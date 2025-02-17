Return-Path: <linux-kernel+bounces-517413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC141A38066
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BA41886C78
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3522217707;
	Mon, 17 Feb 2025 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Pj9sCmvr"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B08523CE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788769; cv=none; b=HdhzHThi83x+dZeTpnOmS24pfKebf2REX8FeqcRFve87r8PYEaE8JGrh0yJCsD0/aaIhYsY9/GbgSFmtGkAwBh7yN3FIRIIxsrt4JBAWhwepJ6BSqEPdzNnpMW1SUsUSHGZkZEXYLLX+InQUhIvQ7gaGgChnRVJdy0ylm0A0r/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788769; c=relaxed/simple;
	bh=xr3bci71BPUXSkfBFENqd5IrCtweRTea5NGCRVUdUgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gV54LwZMciKBhT5EvxY0QXI59W3m8+mwCiHH0T8CL1jLV6YCNa2fDjTZFiJi4hizNbGohgOFHQT0HFVrcTaLAYFSacf7gjuYL6J6n/xkBnYPQiVZLEvX+SsBE7DrO5KY+2W/krMRoSpRxdUX3otTyEFH6e2TaKnOstaVJOidMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Pj9sCmvr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43967004304so18684085e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739788764; x=1740393564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1HYro2OVhQtcA+5FjQleajegsLd+JYaJCTYUd5fxBcM=;
        b=Pj9sCmvrPhdPaGmkXVRy6OS8PLNdjYgi2kGcjo0PHdQQ8OQkOjJdGDJaq/+QR6uq7Z
         TY5bPY6DBi01qFf29W2l7eYl7utn2QrokZDS/5rq7qglrHBhVICffyvpL3rCyQNXKsok
         ZlpDDEtH+3NJaArgeFGNflQKTzCc+brDLvzZ4ir1TAdAPgDt4ed2Pu9CnJW3LCkeFfe3
         xbx3OE//eks0m9/u4oGvoOBdg4ksYpvzI0ZNn0LeeN6+dj2He5Jj+3sG7SGAbpb2QCO7
         qG+iNwO2oo1hWw+QnYInbgkhVZxQd9+WjIROF96FWqBjn2KiHTzlIszhqtujxBPmMhYp
         NWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739788764; x=1740393564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1HYro2OVhQtcA+5FjQleajegsLd+JYaJCTYUd5fxBcM=;
        b=kFvNcZ86cgv8g1s5gBBzII0jvn4q1Px1LGL4ZtMGnFqSKbp38kMLkL5EhvUxMIcG4Y
         OMBASAZZLQJB+wcH4W3ebzVgCGQq8buaBrdwPH50e1mClAH66GWyRf+LNEXOhles9qLr
         pWAnGWDIThJc0T1QKFeBZJVVIbW39klbMm1ulj4QKL7WGB4lXmCNkzIDJL/6rt3oi3Be
         6qAP4vm5KLdI5oynhLYA8B89sHdE7ibMJ12OhZxhFrEAv8nisPjn5BdJVY2eigqrTsys
         vdtEOyt9xd010TdwkaPYXjuw5uDNyKUfn2rQmuLYY44SPTGJIEU+t6Dp6vopTcmf0eDZ
         Ytpg==
X-Forwarded-Encrypted: i=1; AJvYcCUFTyfW9Ynbwy7Q/0jnXdZpPk3VOQdQ6UvNjIhQlbvAnH0rUGZlvKW1CaEtyp6DyvLEzs9tnZksHKsh3xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAa5SH8sKtJDgggcGV+tURql4151rwMXBPw6WfNWsjpvKQbaQn
	3fF5ni3owFKl7N7IrGzt4MF/fywQ/ICBzn9IE2y5Ql6LOrFqIpyXD4Mcv68Mgv0=
X-Gm-Gg: ASbGnctohIIzmauC+VNkvwUTuY19OmI4RdKTuaUHgSxjhxtUbbS+2E0/deT322s/wAs
	FsCvG4v77qNFcN7wTSD6VgOWKZqLFeMRxhQMe+X5YEzEBzThdjFxRgtF+MHA3rxQpy8EJcC2Q/a
	QRCMHYlHymrzl0znkgGIwYo2LJ0EpW/O3mK5wY6D0W9JE+UfU1pN2YwRpFebeM17W3GeNKzlCDa
	WqbX9ejJoGtGTXRlS0PFFxXECLOJbXFyrBmA6Bmreb1xyJTkkua7BCDxbtARu0+DOF8rH/bSoaa
	urg9q4ZY+g8L
X-Google-Smtp-Source: AGHT+IFhBaP2rw+cChlFIU4ELkEL9E5omA2StR9DW0zO8+P0LiXu1aUpYNygZP6CdmyuOYdfeg6S7g==
X-Received: by 2002:a05:600c:3b05:b0:436:1be4:c9b4 with SMTP id 5b1f17b1804b1-4396e750814mr73869305e9.27.1739788764342;
        Mon, 17 Feb 2025 02:39:24 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8707:ccd:3679:187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06d1f2sm147990095e9.18.2025.02.17.02.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:39:24 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dipen Patel <dipenp@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	timestamp@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 1/2] gpiolib: move all includes to the top of gpio/consumer.h
Date: Mon, 17 Feb 2025 11:39:21 +0100
Message-ID: <20250217103922.151047-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We have several conditional includes depending on !CONFIG_GPIOLIB. This
is supposed to reduce compilation time with CONFIG_GPIOLIB=y but in
practice there's no difference on modern machines. It makes adding new
stubs that depend on more than just GPIOLIB harder so move them all to
the top, unduplicate them and replace asm/ with preferred linux/
alternatives.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v4:
- rebased after fixing conflicts

 include/linux/gpio/consumer.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 5cbd4afd7862..0dc49b5fca5c 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -3,7 +3,10 @@
 #define __LINUX_GPIO_CONSUMER_H
 
 #include <linux/bits.h>
+#include <linux/bug.h>
 #include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
 #include <linux/types.h>
 
 struct acpi_device;
@@ -184,11 +187,6 @@ struct gpio_desc *devm_fwnode_gpiod_get_index(struct device *dev,
 
 #else /* CONFIG_GPIOLIB */
 
-#include <linux/err.h>
-#include <linux/kernel.h>
-
-#include <asm/bug.h>
-
 static inline int gpiod_count(struct device *dev, const char *con_id)
 {
 	return 0;
@@ -609,8 +607,6 @@ int devm_acpi_dev_add_driver_gpios(struct device *dev,
 
 #else  /* CONFIG_GPIOLIB && CONFIG_ACPI */
 
-#include <linux/err.h>
-
 static inline int acpi_dev_add_driver_gpios(struct acpi_device *adev,
 			      const struct acpi_gpio_mapping *gpios)
 {
@@ -636,8 +632,6 @@ void gpiod_unexport(struct gpio_desc *desc);
 
 #else  /* CONFIG_GPIOLIB && CONFIG_GPIO_SYSFS */
 
-#include <asm/errno.h>
-
 static inline int gpiod_export(struct gpio_desc *desc,
 			       bool direction_may_change)
 {
-- 
2.45.2


