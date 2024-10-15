Return-Path: <linux-kernel+bounces-365295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454CD99E01B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0383B281B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80ED1C75F9;
	Tue, 15 Oct 2024 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Y3+1v94v"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657261B4F02
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979241; cv=none; b=VBb/70ZMqHkQqbBFTrNhl0qKVBx0aRy6JWOA4W74JkUZY/lqPJWDyaLn0HI8nCrb9Q3WRF79yyQNjMN9SJ064hUuG9exipvW5MSfaitWdc4w8zb4wW+w2jtKRczRba+THJeH5MskW3HAa5No2e+mZSrKRAR+/Orfn35A9LgIuVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979241; c=relaxed/simple;
	bh=snrtP37fMOoZbMd/JPvlEsG9kH/finrRhUiyXYrY5SY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KUlqkg2qTSUkBZ0q6VwVvfoNrZ8ishbUzAveV8egPh9xeFQBjAztN+yCUHKU08jb3CTAozwRHKc29m0pL9xh2Me4iFm2hHcKp6/5D4GXYEuTU+gEUHZnsOXjVe7GSR8M6r/w5qtnOUHjISOWkRjBlZjR0Tm3J38lg09zQQR9mrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Y3+1v94v; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d41894a32so3371561f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728979238; x=1729584038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AVg3FIgTibrviHcCt5EkxLbtg53d4/ePooJwP0U7JQ=;
        b=Y3+1v94vJKHmKI6bvSnr+4VZ2bgwMRRkIj0BYlnbGuz/hg9S//e9u3aPXZinDTCl0T
         PUBBHo5x3QpvechuxluJlzK9QTeABbPIcbjLAxfZSq+yQ4d7rgAHSnkhKUEAkqNdKKI/
         +F0t4yn29RdE90N9IJVwmmh5x1Ap9wyHTkCwptcw5DBHO1ac+DpEWKiQnyI3o7AErqpu
         95G/PMOPlfzRdl1njMnYO/Hwkv0V22N95lfjs3+bBDfqrVaSMR7rWoA+E8ThmBcHCsko
         dS//rBe4r2GECkHgm6Vijq8q1nRO4sUQ2wNkIvERsfKa4Lwj4WvcddCNqp0zGyfWHsO9
         jCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979238; x=1729584038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AVg3FIgTibrviHcCt5EkxLbtg53d4/ePooJwP0U7JQ=;
        b=Scx3WpEXOskoEi0yDzDZ07g6kPHpfzXSv8CBJBxPfMXSA9rdlTgInHjGvbbDir0EBG
         fq0FfqgqdAo8BOCx+KIxL2iR9RgdZx7ZJ+Rjwk927E8XxHCC4k6x9DTmprn7WB3bXyy3
         5b5NneX7L78OP5jiJQGzo4RoL4yyNWuxqHrJ7lctPXpXfSVa4gSXW+l4uu+Mt0csT0vy
         n9i+OFoF+HfS2zHSI6Y0zdDfpSOl/8W7JOyRkMd+fOme3swDptc9yjAHe3i2VVeo4ObY
         tSG32jIEPuxqdPWL9hz9066/0cFTyqQRxueDNAMIS9xvhwZDQKRdU5rH5slFt+gFWanJ
         CDzQ==
X-Gm-Message-State: AOJu0YzjgXvBX98sfwmtCykQLh4f2ZABifxWoh8UXd0Zrt/z4DJQlvtP
	kDy9AkC2tJMSnom12GL0tW9E5888KpR+/WedrjL4WPA5qY6hQCCC0usnxmfaag4=
X-Google-Smtp-Source: AGHT+IGjVLkeDRfvNzDE113Q4ocR4NAUhan6qrz9rfRH9QgrdDElPxUKPO7rtbJa0cv3lltzcQZ4KA==
X-Received: by 2002:adf:f00b:0:b0:374:c692:42e2 with SMTP id ffacd0b85a97d-37d4816552fmr15637511f8f.9.1728979237592;
        Tue, 15 Oct 2024 01:00:37 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d382:b11b:c441:d747])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6c5531sm9962385e9.46.2024.10.15.01.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 01:00:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 15 Oct 2024 10:00:24 +0200
Subject: [PATCH v2 2/2] gpio: create the /sys/class/gpio mount point with
 GPIO_SYSFS disabled
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-gpio-class-mountpoint-v2-2-7709301876ef@linaro.org>
References: <20241015-gpio-class-mountpoint-v2-0-7709301876ef@linaro.org>
In-Reply-To: <20241015-gpio-class-mountpoint-v2-0-7709301876ef@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2478;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=IXI8fc+BDTt6dXc2mOvzUU5JFVJWsj1fSNvXX0TFXLM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnDiEh5aNPWbyBm1yyVv5fwe+71Vy7kKpSsdVtR
 gVh96Hn7ISJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZw4hIQAKCRARpy6gFHHX
 cpCtD/4oUNtfzUWGhirGZ4x++US0pfxpEH5QMOPfP0IxjxVRDIuZg68Es3A9Tk9/ZIdWpJbXX0z
 zcqpXca1REK0CHdUqzBJ2NKLJOiuAijNLdutzgU8VOXjuP+sYjuj1C/Gnuu3Ib2TDqzuWCEcyZ/
 uJN9iPVhPovAoPG2+UQh+RlUhkCrJFdWg68L3IVIS9XPoy2JzGx8iTt75iXNZ9ZjKy+Rna/xMa6
 3tU1Y4R/TkRNleiYrTjAYCb12AzJHO2zttfW2TvT4WIWhtMmXXSXJ9zot1Xy4i1jy3wqS4XzrrQ
 /uptNGwcKC2TQkOP64UuvVhnbKz8HZ70Pmf2hEmYuE4i0JOe1lu5N9CnlRQyBvNyGZLmYRf04kU
 HwcnHgucRg5A+h718QrPRQHpsGoHwnawi4/zoHrmuBMOdjxmYp74OIs34jeSJuXozkbhy+fq2Am
 q7g1SIrSB1ShuRfO6vzYu30sQBFpwzgn3WHT9IXzKTni8w1KUywjjuIvqq6skY6TyC/aIfqBgm+
 NV7ybIAcTCAxaAumuIdztwVKnuBdSHJt2Z1j6kgoc9/6fy9Youp9OIyGEVA2T5HycAj524kvh1K
 7JJOK8k6/1zW44PX8t9hTjscmYxX9OsPB23PIDe2KsIELOeriX35+JydtV//1a/q7b7aZDIw4/R
 +j0ST1Cv3QHC9bw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

User-space may want to use some kind of a compatibility layer for the
deprecated GPIO sysfs ABI. This would typically involve mounting
a fuse-based filesystem using the GPIO character device to emulate the
sysfs behavior and layout.

With GPIO_SYSFS disabled, the /sys/class/gpio directory doesn't exist
and user-space cannot create it. In order to facilitate moving away from
the sysfs, add a new Kconfig option that indicates to GPIOLIB that is
should create an always-empty directory where the GPIO class interface
would exist and enable this option by default if GPIO_SYSFS is not
selected.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/Kconfig   | 18 ++++++++++++++++++
 drivers/gpio/gpiolib.c |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index efddc6455315..1a3535bda779 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -69,6 +69,24 @@ config GPIO_SYSFS
 	  use the character device /dev/gpiochipN with the appropriate
 	  ioctl() operations instead.
 
+config GPIO_SYSFS_CLASS_MOUNT_POINT
+	bool "Create empty /sys/class/gpio directory" if EXPERT
+	depends on !GPIO_SYSFS
+	default y
+	help
+	  Say Y here to create an empty /sys/class/gpio directory.
+
+	  User-space may want to use some kind of a compatibility layer for the
+	  deprecated GPIO sysfs ABI. This would typically involve mounting
+	  a fuse-based filesystem using the GPIO character device to emulate
+	  the sysfs behavior and layout.
+
+	  This option makes GPIOLIB create an empty directory at /sys/class/gpio
+	  where user-space can mount the sysfs replacement and avoid having to
+	  change existing programs to adjust to different filesystem paths.
+
+	  If unsure, say Y.
+
 config GPIO_CDEV
 	bool
 	prompt "Character device (/dev/gpiochipN) support" if EXPERT
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 97346b746ef5..1c8bd765d8e1 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4899,6 +4899,12 @@ static int __init gpiolib_dev_init(void)
 		return ret;
 	}
 
+#if IS_ENABLED(CONFIG_GPIO_SYSFS_CLASS_MOUNT_POINT)
+	ret = sysfs_create_mount_point(class_kobj, "gpio");
+	if (ret)
+		pr_err("gpiolib: failed to create the GPIO class mountpoint\n");
+#endif /* CONFIG_GPIO_SYSFS_CLASS_MOUNT_POINT */
+
 	gpiolib_initialized = true;
 	gpiochip_setup_devs();
 

-- 
2.43.0


