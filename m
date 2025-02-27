Return-Path: <linux-kernel+bounces-535841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9C6A477FA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F7F166471
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9584F13A3F2;
	Thu, 27 Feb 2025 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="r0t3kuyf"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516B8227594
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645475; cv=none; b=KkZe2AfuAMPhdK0GaN4/4OOle4ACJuRxSyIDtP3cK1RGFdvY+rINiq0ATupEqdLoGw154Jadj5xCNM/8bDwmfyf++1P0McdkIuunXtOJlq8q1lQ8LJebycG3vPaVRgHjh7Yx9q48P9cwKDF9HqKc2Se+cBJnL36rlWpwRkKsWhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645475; c=relaxed/simple;
	bh=VyvanoG9EB6jT8WPXjcXUuXsCY4dBM2vUzt/++4vy58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WL/JVQE1rTpK3Qd34x5FwnwhPbW+Uv2AIDE62mY0J7NHw914ZkICKJn+8UVcckmfxzxaSyKOTX7DNytuLLMKECK3jARZoEcpK9pndcs3lIjhLreNdzPlUGlcoZ9mPq+7IOLwjygnNiF7AGjbF03Tl2+2UvhkwsEsomUdd+rqYJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=r0t3kuyf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f325dd9e6so318162f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740645471; x=1741250271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iyFKRvTgmesITJ9EZpOfiEseCx+CHEh97TxyzvI4DpQ=;
        b=r0t3kuyfm2LiPNxSrD1NT5unnSvCnwVVy9Iu1B08+67SYYS0p8apCXtxkckylvEaqG
         KeG8vtdSsd5gnUdp6b8xQ8jn2hRiYwqtumT7Xoa6ic4jB+BrdX+xU+GUOoBCxjPpyn/y
         WqwLQcjjqoQTxV7xqCiqv7IW3ycDbJ6uTLgbYIGhEsywBe5BG35bNFAlr17MtKmoEAGT
         cudsqQpPhT9Dnkk58A8FTPWtWCpePxl9I/EpUF8W3yMsWQoZ8JBJmfG0z/JcA7yiW0pZ
         BIdtdTUoS/fJwPiP7rDCpD7sOJ/0JsNY5JfUyHpl0oxiflnggybYpNWTOqHCChwrtoZl
         NleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740645471; x=1741250271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyFKRvTgmesITJ9EZpOfiEseCx+CHEh97TxyzvI4DpQ=;
        b=ge5xjFAN6BbH1hml/uhYS4Yd7IcMRxxYXuFybdjlE2hxt5ztsMNK+o4WYomO8yJVXI
         GODd/SmwGkcv8swe4CRDljFA1FRXsPlR8hY6Xa6RWjomPem5tlw16B9z+peYTcKPvcM8
         XQ8zxQHyHx7TBf6JA3gIXktRtSpQiWk8zFX3KI7mBeckv+Ol51XIuv9QIS/ArTcRSdyr
         X1v9CPHw7YWli3Kuf6T2JXqJUZmQYkpfeYTBNC3W8yqru77B7aTu7f35vIOgfOQYicyY
         HeRGCIhdAKehnVGmakY3VpXMC1zYvS4ZSLoQhicIuCv1bjY5E4A65cP4SbtxhAZyt01O
         ztlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUdIivGrnTaEI6RESNNb/V+srrNdhCFWxvtoBIrUs9PGABg3BuQZG4pjj59UgUSJXeiYK9t3InRQKjSUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw643zJS0SYCDNt9/3U0ME0j7IspMhw5pCQiS4HCMXCUZtCpku
	UCh27ihEsmDrWaUcjapXbbEqjgY4oobln3Qv7/tYed7pjuX/B9tWfBo5SEDW0uU=
X-Gm-Gg: ASbGnct5JoX6bEaWD+jlinjXPVq3zgzYhdaiWw7ZQe6bb+pqnO9K7p1WDbXlC1Q7WZX
	Jiz3dV0zJjGPvMh/eww/H8Q/C9z3dBURLPs3lKd3BtiO0mUFlen0XOq/cmy8h+k+MQw4QIUM3Xg
	EuEkIfD16CsJkOsJpdzHntEUpIm0Nnfz9EX9qcfzXFFsVfpYQSdMiaa4o2Nr4LU+38xWYESl28f
	mhVeAn4fWJf+ucLdUamTBFm7Kol0pPupwgL6vGV8ZMkqXSQnm9h5W9RzZ8j2rn597B85/fyeseW
	r8jG8EedT8t6K5kdi+hQGD6fHw==
X-Google-Smtp-Source: AGHT+IH2y5MhuV2XTnmtF9QJ4iKL3ex+HsM2rIi/yCxQS4yEoFBd/mjJsgO3qkVz5sd09XoviJATuw==
X-Received: by 2002:a05:6000:1a85:b0:38f:2403:8e98 with SMTP id ffacd0b85a97d-390d4f3c49cmr5302171f8f.20.1740645471647;
        Thu, 27 Feb 2025 00:37:51 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b50f:c403:bf52:2dbb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e479608fsm1313765f8f.14.2025.02.27.00.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:37:51 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] gpiolib: deprecate gpio_chip::set and gpio_chip::set_multiple
Date: Thu, 27 Feb 2025 09:37:47 +0100
Message-ID: <20250227083748.22400-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We now have setter callbacks that allow us to indicate success or
failure using the integer return value. Deprecate the older callbacks so
that no new code is tempted to use them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/driver.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index a2a1b6434321..783897d94be8 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -346,8 +346,8 @@ struct gpio_irq_chip {
  * @get: returns value for signal "offset", 0=low, 1=high, or negative error
  * @get_multiple: reads values for multiple signals defined by "mask" and
  *	stores them in "bits", returns 0 on success or negative error
- * @set: assigns output value for signal "offset"
- * @set_multiple: assigns output values for multiple signals defined by "mask"
+ * @set: **DEPRECATED** - please use set_rv() instead
+ * @set_multiple: **DEPRECATED** - please use set_multiple_rv() instead
  * @set_rv: assigns output value for signal "offset", returns 0 on success or
  *          negative error value
  * @set_multiple_rv: assigns output values for multiple signals defined by
-- 
2.45.2


