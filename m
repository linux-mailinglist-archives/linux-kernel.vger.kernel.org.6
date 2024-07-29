Return-Path: <linux-kernel+bounces-266525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BCB940126
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E532830A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA4018EFDF;
	Mon, 29 Jul 2024 22:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jf9AJLCk"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8628916F278;
	Mon, 29 Jul 2024 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292618; cv=none; b=mnnDZJUXsY4+BqCc6oVejT9zA5SdJ/wBo2ty0dTwC7z7VmUzcbcCS0iNficSSvh9CorrNVwlsc9wKv5tb7dwg8fcOIz+h34/B74dG4cimThEywUD9281rLec6Cut785hcA4fUWh6/OsADkHmXwgKay4ZYzIvhFhOAssw9fLRpZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292618; c=relaxed/simple;
	bh=SrQ+kHpUP2ACt9WyyeUgaX7R+oZ0qjLs87U991V0AQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TW7zAo8I7L7Kuz0uRrU4SEEla289Lw3tQA5LXhn53ioDFNYlibt7uFWRh3PJ6PhZ9Wuxws3LIzCJZJ+6/xGXx39C6uS2OZCTV5QAgExnWlinqhW4zpU3u6GKnKC18iLlxfcJgJYERr1tCqr8/wnwXp3r3XvLehlISreWF223e3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jf9AJLCk; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-66ca5e8cc51so28503807b3.1;
        Mon, 29 Jul 2024 15:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722292615; x=1722897415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qykVGFoGPcAnIbrizUh5M0ZKMFEc/YBfKf7lW7RpEhI=;
        b=Jf9AJLCkj6EFDlBaVK8b0Ju2sSY4S/HE6gUdcM8SQ0Ik6b+/2hxMrNIQ4UftkVxRHS
         vJa9Ngpur8WE+k7Z8QNT8SuaoeWZ813DP7rWqwQUEJvEm3BGq7F2SvzrD/CrtOTEz+E/
         6Do5OF/9b2ZdnZZLnHgPLMCM24Uy9mBsHgQejXzuFr+uCrT0cqlhe9I5OGQhSI1PCV6H
         oPaqnfScMtHv/L/XlcMkj6e/hXx+ltk8N69SSYsfhwsW0LEZYGQPQnKd5Wfi30kFP208
         6c5QM5AmzLF4lHXX5l/yXK/I7JlFQ9GmRNQhW+1ElGTy/sbRVmlmgYmFOZ1AYNnxdZav
         dn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722292615; x=1722897415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qykVGFoGPcAnIbrizUh5M0ZKMFEc/YBfKf7lW7RpEhI=;
        b=K1kW2Ri2dh7kOurmla7mqlU4Bmk5sSyv/EMKAtIYL/OuQW0ZXqvn4DtKza4I6dH2cG
         136X26yhCiH8ikPL8fIk34K4O2+p9Ojohv7XPvUE+6EHzOfXWgNNj8ZTbCyvpkeCWptD
         oiuWYpHdw6oU7W46sq8+bhkDaGHRfY2OSPbpPDMQ59mjeYIFGOoUVeW6fr3SSTvdLd/8
         Pq0Rs5Q947KUYDy3RatE5demIxz8wASxrHYw/ldK84QuHkrTC9VOggJ9SHm4+Ot9Of5X
         h9EaEdp8Zt/JSmm/FFNStWzP3ZmpNhzX8OPToNngLE+ufw9cqqvjcQQRWdE5dI8KhE2I
         F1rg==
X-Forwarded-Encrypted: i=1; AJvYcCX1DkXosr1wuU+gOQnKve/T1QdodFiWYXT1YmJ4kxVEnYfEd4ciciriw6v3G0gjcPhV5HpGXQpnRm3ezY6RoV+tKqGKJSF9qfgPjG/S1p1H5Kdp4xtNxTWWfHAKqHDwHMHKYMTn2W+8UCwv9kjbapplBW9w/bfARF3kXHcVhB4Y0glFWEoVXDTdh0j8Ig==
X-Gm-Message-State: AOJu0YyGnmfYLpFtjMUZ4HqeQMdPeu7YFCLte4oDfzjpi0xxpzQG3GJr
	azAerUVLgQ6c2ovHtY9lE7SetN0pO6yfo6OFghtBEDljaH0ERZno
X-Google-Smtp-Source: AGHT+IGt92RufeRBsEBYPFgHHPuL4Davoxqe1ZhzlrAzS/6JFKrpECT14BVY2VmjwmydjD+68IzJkw==
X-Received: by 2002:a81:9485:0:b0:65f:8e2f:f7a6 with SMTP id 00721157ae682-67a072ba561mr110499807b3.24.1722292615485;
        Mon, 29 Jul 2024 15:36:55 -0700 (PDT)
Received: from x13.. (syn-035-145-047-162.res.spectrum.com. [35.145.47.162])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b024ab1sm22882937b3.91.2024.07.29.15.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 15:36:55 -0700 (PDT)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: W_Armin@gmx.de,
	corbet@lwn.net
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] [PATCH v2] wmi: Fix spelling mistakes
Date: Mon, 29 Jul 2024 18:36:44 -0400
Message-ID: <20240729223649.135639-1-luis.hernandez093@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There were a few instances of typos that could lead to confusion
when reading. The following words have been corrected:
Binay -> Binary
singe -> single
chaged -> changed

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
---
 Documentation/wmi/devices/msi-wmi-platform.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/wmi/devices/msi-wmi-platform.rst b/Documentation/wmi/devices/msi-wmi-platform.rst
index 29b1b2e6d42c..31a136942892 100644
--- a/Documentation/wmi/devices/msi-wmi-platform.rst
+++ b/Documentation/wmi/devices/msi-wmi-platform.rst
@@ -130,12 +130,12 @@ data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
 
 Due to a peculiarity in how Windows handles the ``CreateByteField()`` ACPI operator (errors only
 happen when a invalid byte field is ultimately accessed), all methods require a 32 byte input
-buffer, even if the Binay MOF says otherwise.
+buffer, even if the Binary MOF says otherwise.
 
 The input buffer contains a single byte to select the subfeature to be accessed and 31 bytes of
 input data, the meaning of which depends on the subfeature being accessed.
 
-The output buffer contains a singe byte which signals success or failure (``0x00`` on failure)
+The output buffer contains a single byte which signals success or failure (``0x00`` on failure)
 and 31 bytes of output data, the meaning if which depends on the subfeature being accessed.
 
 WMI method Get_EC()
@@ -147,7 +147,7 @@ data contains a flag byte and a 28 byte controller firmware version string.
 The first 4 bits of the flag byte contain the minor version of the embedded controller interface,
 with the next 2 bits containing the major version of the embedded controller interface.
 
-The 7th bit signals if the embedded controller page chaged (exact meaning is unknown), and the
+The 7th bit signals if the embedded controller page changed (exact meaning is unknown), and the
 last bit signals if the platform is a Tigerlake platform.
 
 The MSI software seems to only use this interface when the last bit is set.
-- 
2.45.2


