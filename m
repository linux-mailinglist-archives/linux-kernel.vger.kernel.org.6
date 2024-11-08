Return-Path: <linux-kernel+bounces-402388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43589C26FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9CD1F230CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBC21E0489;
	Fri,  8 Nov 2024 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFwPB+qS"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288A233D80;
	Fri,  8 Nov 2024 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731100927; cv=none; b=PYlIScuJ1uEo4qqe543uExDTSJ1uqd+OwGIg3SCPOEx+q1E/yH7wWpts38HjUVsiH04GO1As+idi1bLkBWU1EGsf+gaRIFKae6RxTTT1aN+GDJl4Ra9/wWfeUpJWEa/lIse3Bpb3zNdG9sExe3JpvWxtR1ZpzZ4cKRNR0M5lkL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731100927; c=relaxed/simple;
	bh=tgXJh3XRRK9yCYpYIy2cKjBM6UWh1IfIQ7+irJcbel0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JHclGNhQvyEeeFwqE0mQOPwbaYZGmdRQM9GBWFQgzx4m4JgC/m5YUgtA167dU7aORD/jsyS0/DZ3Y9qmd21tTnt9I9GALvAtuWCeUdfFvDv0cCR2pmFBT57WoHhTryxfoVTfGovOgyjihmNJFMmq/x/xAJtMXQJXmy5ynaIw0K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFwPB+qS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-720d5ada03cso2650116b3a.1;
        Fri, 08 Nov 2024 13:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731100925; x=1731705725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aIJNpgzllF0luBBdwCdbbhKpUYPl641j+I8yTy1pQhg=;
        b=hFwPB+qSMfnNVv8FbmARxGjnf361UjpD58T/JN+DLA0ccGcGYhkzXeM+mRkZMp5qa5
         hj58CjpG7p0cAPsGZY+77zASxmt1vspaDO5FJn+9kSs8dwV17pMQd3eH7kHdN6yOnFNg
         3mWl1R0rV/R1UodOFP+bL3WOerGze0FKraRxgHUCttsz8ivFW4Ro615Qbb+nAr5OY46G
         paDywD6nW5PUtpDpGQZbb33U/NvdGJ6JfD1+vFRDuarXJHLPpb1Q/uC3nUjk4ViD12JR
         RXfK95L206K3tf5DNJ6mN9/4qUTpBFOQjjZXU9+/sQ1sUDh141QpGrcAxqzvMJXBEqZf
         Kzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731100925; x=1731705725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIJNpgzllF0luBBdwCdbbhKpUYPl641j+I8yTy1pQhg=;
        b=FqcoN3FdFj9GxOcF13k0x0HSH9iJW7FgYJupIHxmDldCLLkbG5knXUNQaAxuo0xeHr
         wh8ZWxq+ZrRAvxwbhsdSsmg4qz9bew9uCgr9kND3hLpAESLFcwLMaAOTdqTbIZFG0Q7i
         CvXadooCBFBBhSc+/9BUCbHTJQ4ho/AWdYsVzRbIB+vadjfTcQ9qX6RxtlJkUjQTyH3h
         3u6F5uY1XputSn91BlS/gEwTviPyng5X7NsDxbtqHExJ+CPfKPuTehQQQS7FXR6qD0yn
         92HW1s+F33KWBiEhp2cKTmh8lyHue9bapI56Dg2tklWrnUienYdsdzKZx9XYSJMFiC7m
         VVcA==
X-Forwarded-Encrypted: i=1; AJvYcCUoVhgxBjdLbQ0UQ8khTNML2fAx4pE7ZFRG8ZGoGVM0vi0C0Gn5fMI2YWyMAystDGmROihEzx66jgLzRJo=@vger.kernel.org, AJvYcCUoXYKAaqknhJ/mmCsrW9OWVrjULdWO4kVm4Md5k7Q9Wi/kJ7IMbiow92kLZ/v3YT/rB5D0HDU2CYe96t6p@vger.kernel.org, AJvYcCV39tBfcTNS3UYSZgTq5NH2aBYkEvxtSTiKaCRzpB6PkgBgxznyVoxiu0E1c3vVyMH9QFwOmGC/QhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4qKgjIoAB7CYnG3fkrkyD4BCXnhEBEJZggVtkrHbbttPouiT+
	7V+lR9buzi/XhXe5ZA4ZtYOHoYYUAVHaqb4RUZo/dw+HFZC7rA+B8o8Hdw0J
X-Google-Smtp-Source: AGHT+IEJSOSqCoEiLbDmGxkTwgRA85tStmV6AjEYt3tk0HUllCvqvyC0E6GvttSnoac0a8U2/G/PkQ==
X-Received: by 2002:a05:6a20:244c:b0:1dc:2a02:913b with SMTP id adf61e73a8af0-1dc2a02928fmr3185727637.15.1731100925000;
        Fri, 08 Nov 2024 13:22:05 -0800 (PST)
Received: from 1337.tail8aa098.ts.net (ms-studentunix-nat0.cs.ucalgary.ca. [136.159.16.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f643a60sm3972595a12.56.2024.11.08.13.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 13:22:04 -0800 (PST)
From: Abhinav Saxena <xandfury@gmail.com>
To: linux-kernel-mentees@lists.linuxfoundation.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Abhinav Saxena <xandfury@gmail.com>
Subject: [PATCH] docs: hwmon: Fix typos in sch5627 and max31827
Date: Fri,  8 Nov 2024 14:22:01 -0700
Message-Id: <20241108212201.144482-1-xandfury@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some typos in hwmon/sch5627 and hwmon/max31827 reported by
checkpatch.pl. These changes are purely documentation cleanup with no
functional modifications.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 Documentation/hwmon/max31827.rst | 2 +-
 Documentation/hwmon/sch5627.rst  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
index 9c11a9518c67..6cc5088b26b7 100644
--- a/Documentation/hwmon/max31827.rst
+++ b/Documentation/hwmon/max31827.rst
@@ -136,7 +136,7 @@ PEC Support
 
 When reading a register value, the PEC byte is computed and sent by the chip.
 
-PEC on word data transaction respresents a signifcant increase in bandwitdh
+PEC on word data transaction represents a significant increase in bandwidth
 usage (+33% for both write and reads) in normal conditions.
 
 Since this operation implies there will be an extra delay to each
diff --git a/Documentation/hwmon/sch5627.rst b/Documentation/hwmon/sch5627.rst
index 8639dff234fc..5f521c6e90ab 100644
--- a/Documentation/hwmon/sch5627.rst
+++ b/Documentation/hwmon/sch5627.rst
@@ -39,7 +39,7 @@ Controlling fan speed
 ---------------------
 
 The SCH5627 allows for partially controlling the fan speed. If a temperature
-channel excedes tempX_max, all fans are forced to maximum speed. The same is not
+channel exceeds tempX_max, all fans are forced to maximum speed. The same is not
 true for tempX_crit, presumably some other measures to cool down the system are
 take in this case.
 In which way the value of fanX_min affects the fan speed is currently unknown.
-- 
2.34.1


