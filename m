Return-Path: <linux-kernel+bounces-382147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690159B0A10
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CB01C22585
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9591885BB;
	Fri, 25 Oct 2024 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FMhOSvhl"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585521A4D0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729874222; cv=none; b=TrkdYbnYVXfHThQXtq1j4I7/UgaqexgBDe6EJtw2XwFcCljzvYXsLu1JF3SM3YLFIRkwiM6xXUB8Xm8dMORL9wQf+EeX9BFPiENerWyh5qc+JEb4XhcV6w/8PztNHhrPwZB2ndhw4TnBwcLDMkfX0TTidXr0pHH2q1iZ9nejaZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729874222; c=relaxed/simple;
	bh=z8ZYUyX3DegatEokaoi93YFQEe8PkLpJaLNX49odOSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3hloG/208N4To/OxZt7kQ/Y1qaejXaTQGEohU//VNppZmIWrmcQg1ZZ+dJF0dA+s2yy1mPdx6vlX7ZbpE63g0FNbUk8JTf4G63V/yEGBUc0h3uYVtb4HbOsRYjVstxnsJlbxUZc+yhEfbLozldElWCLHAMdOsqRLGZ41em67Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FMhOSvhl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so21471995e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729874214; x=1730479014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7lGkP35cJnTIdnyhY5sfY8yz0v3JRW7Q1yvNGRDERrg=;
        b=FMhOSvhlsLTVhZ/Xst9Vt3tIQ5wAK5a6fJxhe+EIy4Twncc7qW431xKNRbKTwSpOkb
         GrOfdWjWILmcawnAyBbW6i4NPpoXZH7/unkaHox0jT86HrCJWyRw01E+N1yQ99Omi4Q4
         UbspEw+E3AH9WujOBYhFqDZ/84btMlhKURSc96tXO2mSsrXZ0cS9fR4sRgxuw2WZ/bzb
         ibu1okQYdiTmc9xRxFMQZNTOj/gsJZERO9hCofv16isabiCdqNlbg3XUpK74p3ra/9Cm
         AnCSRS4AvlMgK4bwGCtG/tI2FJXB7QzSi+rzDYJX3pXaLp2A73vwfAogUOtBkmtdwME4
         o3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729874214; x=1730479014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lGkP35cJnTIdnyhY5sfY8yz0v3JRW7Q1yvNGRDERrg=;
        b=w1sAoOq0ZoCdGL2/YfOCE61zRSx1XIW1P7MHkPYDVRXtVrVGmZXmM09QLlbiRtGi5V
         1ZcIXfl66GdEaICfVb3PTpjybuhL8aBDTe7kidRzUaxSbilkjPLtsHbKda5GZ3qSBuWz
         BjM9zx2KbxD2h8NF2Dp8bDVjd3pJDXgwH/TkzBYhbSpbQBnrp0GbwZdHZ92VnsFKvzWd
         s/D3FkOb2v+F3KozGSqjmv3Hv0FXt5Yx5BDXwtpNyEkHIRoer+P8ySjqcZWYYJYc7xiI
         edWNQPnj8K2s3A9rZLIvlPcG96anvjdjTNLH0qgQgCAluOr8T7NgBQIhdc4brhDF3/dB
         owJw==
X-Forwarded-Encrypted: i=1; AJvYcCVVW76QatnNEtlqhGFdJBgkiY+FmvBvwKhCOYwNj+p66ZuNwaEQZZYyj/gEUSWKT8apaHjV1pnWbVvhYGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSx4afzSF3naswEUpbXyELlzScoaRSX37aUAtzYfuwL9km1OeC
	s7ECFSjtUCkR3hg0uhIpGMjZoreV8NgKRv7DGh9r3oAZfuNB1ez5lTPOKPj3mBw=
X-Google-Smtp-Source: AGHT+IEVcCSB/+2gFz0T4Is6uvy0Nb64CEXaviScFcm3jz+lgW5p91JQltzJOKFrgHlsa8gdQwDoUQ==
X-Received: by 2002:a05:600c:3550:b0:42c:b16e:7a22 with SMTP id 5b1f17b1804b1-4318413f0ccmr90291625e9.12.1729874213802;
        Fri, 25 Oct 2024 09:36:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a207:5d17:c81:613b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b92963sm1932967f8f.98.2024.10.25.09.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:36:53 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: of: drop dependency on HAS_IOMEM
Date: Fri, 25 Oct 2024 18:36:51 +0200
Message-ID: <20241025163651.54566-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Commit 2527ecc9195e9 ("gpio: Fix OF build problem on UM") added the
dependency on HAS_IOMEM to OF_GPIO to address a build-issue on UML (User
Mode Linux). It's no longer needed as now UM defines stubs for
ioremap() and iounmap() even with !HAS_IOMEM (and its emulation can also
be enabled on UM now). Let's remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e28efd5f9c17..27c18a1f76b8 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -29,7 +29,6 @@ config GPIOLIB_FASTPATH_LIMIT
 config OF_GPIO
 	def_bool y
 	depends on OF
-	depends on HAS_IOMEM
 
 config GPIO_ACPI
 	def_bool y
-- 
2.45.2


