Return-Path: <linux-kernel+bounces-374979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AD39A72BB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953B41F226F0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12D41FBCAB;
	Mon, 21 Oct 2024 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IVyWo0Ud"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAF81FB3E7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537045; cv=none; b=VYeYpk8oNTwe0FWCzgAGPePj3z27vksqkKRbHoLBOfyvdhZ1WzPsNtRToQgeCJvRRhDavkOdHOVim3qtsD2OALTdtt+CeTkLg5gM5IKnIgiIFdCw3JkxNIe7qjKN+iCktYb1qimpNXMmk1VyUFhItOO/3FA5ChG1zlHSiHzwcCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537045; c=relaxed/simple;
	bh=TxxzcHfeKLyU3QcpuXY3KcGqjJ+YUrGmR6mLM7IqNDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u5sLuJnnktK0XXD04D47UVAgy/Sx+uYjYynRHVUoZiUDST+dV8NZ6P3b6FAQAgg5fPYI++Ii6OLY8lrobK27/G3jSGy8bYUCaDN9bkpbZyQdAPsmM/S78ziMzt4OC9xqxZ6W/9Ul0EiulDRYxUd1gowYSTyI4TUZxnr9T7zd6qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IVyWo0Ud; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso3330431f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729537040; x=1730141840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zc3aJSlNwgLYQEkWHVoE01BInGeXq8mApkPce6TIXVQ=;
        b=IVyWo0UdlzVypra9dBEUbtvhIbWQCGTlnDjQRfgHespWRj8zUM2sdMyUaGeXu8l0ek
         7rUW9jxzKPgcsrXuhPV4nkYjNTS15giPoFC7GsTG8l9nls0hpv3QAVgqjqFyKS0IVOLC
         pwzIN0JZ/ptQyo5S0lWtPhJaWBshVhGrqeTQD2DvOJpYPWBxlLz2WRWh8eYUZiqKQs9B
         qtTJapuIyOWzl/NllzaBFOe2oSNPL5OvTJ5SZRAKvbH7wfNQSd1gIyyf3Cf1yLnZUjjY
         ihO+6NujKSwnYNvymFLRZ5Ep9pn+kcI3uCdEn2rac+mNIukpiC/3I6yJADPrcAcNy4/p
         0oLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729537040; x=1730141840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zc3aJSlNwgLYQEkWHVoE01BInGeXq8mApkPce6TIXVQ=;
        b=n6+ZOWHxZTmZ+qiMeByur72SMBnGJ6KKs8VObeSLqpo9kK/uzPyKEyyPzsqgQUq2Th
         u+hoUeRKIHBGosFUbSFe3m9tt6j6lyy4stjBAfdId5Xy7GXJWU9sDFPLngWcLQcX5lY9
         jnt5OMkKD3+ER0QB2bfvjGmaWTP9R4au8efYwomdfdegTjRLjzMIONf7GHgbiKmT2Oyx
         vVzNfDJ7z7kFjtHWV1f3HJzDm2GvgVwzcmiXE1qyPP3vqt0kMEwNmU2hQp9+2XUu/VNH
         nYOZS16JjJg3XE7NdjosBDarbiticeUIWVk99FwDzRO+VtkOfXYJvN65r7wrqI8mZFdy
         xYqg==
X-Forwarded-Encrypted: i=1; AJvYcCUuHp3INjnZG4+qB8oPJES0nRfMwJ/oetBy0IfY15q3fkfN1CP159OPIhl3eBML39yvQ1P8ZIFo45cRkmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCQOdbKlm0w/qforjdEuxVVZTpuch++OQ4HlwLjeCN+njWgPWt
	5TBu9/AkwfspOsSPZp0Yl9s53nCocFxi6gmES4IpCa/HmAInZVcPXJStmgKW2JwxaXH1mSpssrG
	a
X-Google-Smtp-Source: AGHT+IHe/+/xVRAydjufypdlwdZKA9GsBvRARbH2mlwwo2P9kIO/bFlSmnAGVRMo1gib+ySAkeHhvg==
X-Received: by 2002:a5d:46cf:0:b0:37d:45ab:4241 with SMTP id ffacd0b85a97d-37ea21ddfe0mr8816730f8f.12.1729537039865;
        Mon, 21 Oct 2024 11:57:19 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b40b:61e8:fa25:f97b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bcc8sm4919411f8f.107.2024.10.21.11.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 11:57:19 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: sysfs: demote warning messages on invalid user input to debug
Date: Mon, 21 Oct 2024 20:57:17 +0200
Message-ID: <20241021185717.96449-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We should not emit a non-ratelimited warning everytime a user passes an
invalid value to /sys/class/gpio/export as it's an easy way to spam the
kernel log. Change the relevant messages to pr_debug_ratelimited().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 0c713baa7784..203fc3394afe 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -463,7 +463,7 @@ static ssize_t export_store(const struct class *class,
 	desc = gpio_to_desc(gpio);
 	/* reject invalid GPIOs */
 	if (!desc) {
-		pr_warn("%s: invalid GPIO %ld\n", __func__, gpio);
+		pr_debug_ratelimited("%s: invalid GPIO %ld\n", __func__, gpio);
 		return -EINVAL;
 	}
 
@@ -473,7 +473,7 @@ static ssize_t export_store(const struct class *class,
 
 	offset = gpio_chip_hwgpio(desc);
 	if (!gpiochip_line_is_valid(guard.gc, offset)) {
-		pr_warn("%s: GPIO %ld masked\n", __func__, gpio);
+		pr_debug_ratelimited("%s: GPIO %ld masked\n", __func__, gpio);
 		return -EINVAL;
 	}
 
@@ -520,7 +520,7 @@ static ssize_t unexport_store(const struct class *class,
 	desc = gpio_to_desc(gpio);
 	/* reject bogus commands (gpiod_unexport() ignores them) */
 	if (!desc) {
-		pr_warn("%s: invalid GPIO %ld\n", __func__, gpio);
+		pr_debug_ratelimited("%s: invalid GPIO %ld\n", __func__, gpio);
 		return -EINVAL;
 	}
 
-- 
2.43.0


