Return-Path: <linux-kernel+bounces-399283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0284B9BFCFE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41AF9B22037
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41B813AA3F;
	Thu,  7 Nov 2024 03:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MarRR0JJ"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90472E62B;
	Thu,  7 Nov 2024 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730950392; cv=none; b=b94jl9qoEi5tVmcRnyLRzoCc6UHdyiU3ThT3zHONtSqJ5TojHrOQLXp2wiPpFJ4mSBwf+Lh5B//us5Y5pR27UdxCamUJWVnr//jRq/i9KLQydL7Uh58hOHSi8fSpeZOPAg8iMnWfQ8vTP8XeyYD3b5qlN11zmvVGDSD+MwEji1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730950392; c=relaxed/simple;
	bh=L7RQ5p127isxhSgyM1HUfN42OLCegbGS1VLKiJgIbd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WEz3aCYfekSvMddWKFrwiWZndrQxlx4akpQqfr/s6h+ewnNTgcOnLaJW44o/sOusgLrJubzIc9jW3WuWMzRsZ1lW3yrcK3+hdw/gLBGji5va2B0Ztj4HHHnQSlArhokjIV0AKW7A5uZsiW6JMHG6JTTAWuMsMUh4V9PaZOksV7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MarRR0JJ; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7181caa08a3so332874a34.0;
        Wed, 06 Nov 2024 19:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730950389; x=1731555189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7uKB9c4AOgBqlbIFhdwAokG6qi+ibSt5e8VIEMQvkNU=;
        b=MarRR0JJWpfxFfcfOQTfSd73zdj+uf9kJUwFR8xMVVX1EZivrCkFnwnYUAct2ZjNRQ
         MIQ6AcvuPkKtANGYxJiIqG7mrXjjuGxiD6kdwacRLRx8jySCnv2fp/w6cdYiY1ffZt5s
         jZaHIv1S/PUVWKhNQAZx/dZLbpzezUtMKFqzeB/Q+4wmUmTwzaRYo6CbVBp6D+6Qag9V
         0bmPEJaLw0hr8e2+zOFSTgyhaasNmoA1w5PJFrD12KF9XalwNSXUU9MpWxAVp+2rXZSq
         FdgmW4WRitA045mbcwSjmJhp9nDe1ds3Z6WigxIunX0oMjHEYFtMdGZUMKG0eOVqwlPn
         XE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730950389; x=1731555189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uKB9c4AOgBqlbIFhdwAokG6qi+ibSt5e8VIEMQvkNU=;
        b=kIlqcIXWa+RfxEHF9fGuiuXLTYpHzmQso5/vYyQoqRJCHZISSryfQP3kTCjJJk4rIG
         dSmh67sRFJMcipc5XFcFNHA9ewxKJk4X8JewNtNo10zF28SCFz1mkWwjbX956SKxlGSx
         1Pz6waR8ao7WRxeVD7xYjwOk/C8AVP0jUWTW4SmuwmVF7VVJ9Bs7VXuWm2SnHIRAzkmY
         2e3Kj+46A8vQcbLUTfAfi9UiEBmJsJ4jqEERQXObrNq04ochbAxhQgvEAu8L9ioH1+zi
         kH5JEsox6TsM7bPTkX4Z2dZokM7Mo6Fd0wk4i1AiLk9WIJnBRLf80d3ENpzca5wca35P
         PYrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1mKKo+M/JS5aXKlLFjovTsbUErZ6jyvkVCx/WgLJ0+OANGh/NS0VrQuRByiCFo4xd4so9rChzAR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye07tdnOmXxuG8suEACMusofimQ7uKL/bT/nrnlKN9izqhD+Ap
	bd6mnILGSgxJl+Oqgppkclb5PMj1AztsVUD6Gg2e08cufPl5kXu1
X-Google-Smtp-Source: AGHT+IG85Z2kzUWZUsFXuadQW5dXzIQ5keYo/mbSGdhtKjqZGh6buuuds8l1kZrmjy4hhmVgIBzpKw==
X-Received: by 2002:a05:6871:10b:b0:288:865e:1864 with SMTP id 586e51a60fabf-29051745061mr37928524fac.0.1730950389598;
        Wed, 06 Nov 2024 19:33:09 -0800 (PST)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:c934:17a7:b0a5:6e02])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546c8eb0fsm167476fac.14.2024.11.06.19.33.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Nov 2024 19:33:08 -0800 (PST)
From: anish kumar <yesanishhere@gmail.com>
To: corbet@lwn.net,
	broonie@kernel.org,
	dlechner@baylibre.com,
	u.kleine-koenig@pengutronix.de,
	Jonathan.Cameron@huawei.com,
	pstanner@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH] docs: driver-model: generate kernel-doc for driver model using script
Date: Wed,  6 Nov 2024 19:33:03 -0800
Message-Id: <20241107033303.97509-1-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 63dc355 ("remove the driver-model structures from the
documentation"), the kernel-doc text was removed, and users were
instructed to read the documentation directly from the source code.
However, using the kernel-doc script to extract and generate the
documentation is a better approach, as it ensures the documentation
remains in sync with the code. Additionally, it provides users with
a more convenient way to access the documentation without needing to
refer directly to the source code.

This patch adds kernel-doc annotations for the driver model to
facilitate the use of the kernel-doc script.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 Documentation/driver-api/driver-model/bus.rst    | 4 +++-
 Documentation/driver-api/driver-model/device.rst | 4 ++--
 Documentation/driver-api/driver-model/driver.rst | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/driver-model/bus.rst b/Documentation/driver-api/driver-model/bus.rst
index 9709ab62a468..15fb77fc69df 100644
--- a/Documentation/driver-api/driver-model/bus.rst
+++ b/Documentation/driver-api/driver-model/bus.rst
@@ -4,7 +4,9 @@ Bus Types
 
 Definition
 ~~~~~~~~~~
-See the kerneldoc for the struct bus_type.
+
+.. kernel-doc:: include/linux/device/bus.h
+    :identifiers: struct bus_type
 
 int bus_register(struct bus_type * bus);
 
diff --git a/Documentation/driver-api/driver-model/device.rst b/Documentation/driver-api/driver-model/device.rst
index 0833be568b06..14095770e80b 100644
--- a/Documentation/driver-api/driver-model/device.rst
+++ b/Documentation/driver-api/driver-model/device.rst
@@ -2,8 +2,8 @@
 The Basic Device Structure
 ==========================
 
-See the kerneldoc for the struct device.
-
+.. kernel-doc:: include/linux/device/device.h
+    :identifiers: struct device
 
 Programming Interface
 ~~~~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/driver-api/driver-model/driver.rst b/Documentation/driver-api/driver-model/driver.rst
index 06f818b1d622..b5e8b00878ca 100644
--- a/Documentation/driver-api/driver-model/driver.rst
+++ b/Documentation/driver-api/driver-model/driver.rst
@@ -2,7 +2,8 @@
 Device Drivers
 ==============
 
-See the kerneldoc for the struct device_driver.
+.. kernel-doc:: include/linux/device/driver.h
+    :identifiers: struct device_driver
 
 Allocation
 ~~~~~~~~~~
-- 
2.39.3 (Apple Git-146)


