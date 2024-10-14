Return-Path: <linux-kernel+bounces-363908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E4199C851
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A0B1C22500
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7E919D093;
	Mon, 14 Oct 2024 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zCCgVU+8"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F451A3AB7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904035; cv=none; b=CAfxTqAOh32WQpFmoZw0YZajvHKGbkvfAp+/O4yH1s+8YGk7iL4dOLJbEa87sEBJ62fPmYw/kwSsDx7e/m3M+BwbuQSSXZM8kOMlCpl6l8S9Eq0764epJsZUrPCU3NkhLm8xGWwSH3anGNE6AVAqsTR8IFvzG+vrKMOnIZZvUPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904035; c=relaxed/simple;
	bh=FRJNE39drmMWbs0IJEPZYyCVdjsc/3sZuKjUOjlKPOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQB9iJEqqU3rIIKc0SyoVGcuo0W38vmXcfJWwTpZn1sE9MPqy2kzrOj1wbwa2lqgRhJT8zCbeAWwyZeH9hK05y25+A4rc3yJPim5FjvZ/UbtvKb5/m0N9Kq+rcgHUe/fZXFEmkH1vyKBMovUUi/lmYywKtfjRUSdH7wDJyMC9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zCCgVU+8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4311bb9d4beso26041675e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728904030; x=1729508830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N3zfwAAeS6R6LpKSeC3ngQNB0NDIv/4Dub3HhJxrUX0=;
        b=zCCgVU+8QWH41mwEq6qG3lCik91oljrrQUADtlrJ3xb9LdeJqrQGtjwdrjliPBJzmU
         PcpOmA4zLcCMRhdnOSGojZQSJxNxcBHQEEwVyMmE1Pmg1wFCJk63rmSF+xqaGoxwMzm+
         DmVyELjX2XsGTNnR7/Qn9M6o4HUrIJAGyyen4zEjwH7hk8HQb0Qwc6XS2m62eBopz59j
         pNmJhkvGbuBLp8ecWeiW0Gnp0I982Cc4NCAyWavjJrTHUuA7lnghue7n9riczUqSkHWq
         uLnU8Rs9i5xo58KSC3MC1dG/pb9bCMRtX5V439vBou36cZ3e0FK3tRams8DvJ5KIZBpJ
         apyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728904030; x=1729508830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3zfwAAeS6R6LpKSeC3ngQNB0NDIv/4Dub3HhJxrUX0=;
        b=mJm/NMJ3fNDH4KTCi4zPPoh506FwZIGd2wLucsnJa8Zgq73ijQEh4mI0k3GxfZ/SEo
         1TtQfXJiG0InFHYHdnQ9d3OwPJDthbD0hMEa7uXXoll2qysO9Yb3HRrTI2WAE8OVqDq5
         6H97P8z1d2toUDaTXjzRmdRj++Wit1qbOeJA/4WvQXko/Ejf66m9ZkwYAVfuNgPvoDQF
         rEFoSOmIYXKNyNsmrSc3rl/v6A3+n/mN0lMpqXiU3TRvVrJdfr+jpHFLsldPQddqURkY
         bqFsC3nYlqHaxtKinxRJWVW3VrF/5iJkcb1xKUT290wtn/ObWWCd7xfW02ALN2j8gMyq
         NLbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKeIyAmvyG+p78YbnoY5QCiaLqE1QleLqqTgLEFsij2/HGntCWTa6huylN7yQ6yf1mxmsHks392gu1pe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH+F50jndqu/CdzEWBRE+wTMO/seAwieeMKqB2ErElKU9WelwF
	0axw6A+aVGFPdg3yyds7fwFrJY1yrnFatFrmyzJxqieQSv8tT7L+CvSPdjqZKvY=
X-Google-Smtp-Source: AGHT+IGNQzlFW+q7xQekPJFZISxrag4rk9tqYYjwVe92HkdmyDpQU2dlzSlkQT28wJJta12ueGo+TQ==
X-Received: by 2002:a05:600c:354e:b0:42f:8267:69e6 with SMTP id 5b1f17b1804b1-431255d4afcmr71161315e9.3.1728904030336;
        Mon, 14 Oct 2024 04:07:10 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:de54:ebb2:31be:53a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf1f696sm149957735e9.5.2024.10.14.04.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:07:10 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: fold the Kconfig prompt into the option type for GPIO CDEV
Date: Mon, 14 Oct 2024 13:07:07 +0200
Message-ID: <20241014110707.101320-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The 'if !EXPERT' bit will work fine if it follows the 'bool "foobar"'
declaration. No need to have separate entries for it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index bfa6b5a2c537..7f59e861de5b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -70,8 +70,7 @@ config GPIO_SYSFS
 	  ioctl() operations instead.
 
 config GPIO_CDEV
-	bool
-	prompt "Character device (/dev/gpiochipN) support" if EXPERT
+	bool "Character device (/dev/gpiochipN) support" if EXPERT
 	default y
 	help
 	  Say Y here to add the character device /dev/gpiochipN interface
-- 
2.43.0


