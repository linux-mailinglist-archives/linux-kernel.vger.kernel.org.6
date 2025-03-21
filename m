Return-Path: <linux-kernel+bounces-571550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A6EA6BEAA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8657189DDF4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D453722B8CF;
	Fri, 21 Mar 2025 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pwYLRAeg"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A4C2236E8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572194; cv=none; b=WIHj4cm3BK9yBafywjmwIqQfMBhpVPZlIBlZE2oNtXX5w5DWDZBCUaabNzmNmQyrGBAMNM7Yvsv2WcjLkiLfkc2R35glL3+j7RkL4rEKRinuTaEn3TeTyML3WV3csy/jffK3fdod+OjGQojErzu0HNlt4Fc7rfgpaYBXX7oH9Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572194; c=relaxed/simple;
	bh=j6e4SEwIZ+0Md5Fe8PtFTn88silsiDaN7LTWkXTiTjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XEVstZDSlDGKldUnVKN63OmbCRnJVkahTFN0/cnhzcB5jF5tSNuyBqlK5oY6nsSlCBireoAyWPAfVk6yD0HFu1A3WTkKQrh25yeqF0XC+tX/RHBcmxxUrDhHoAmx+U2e5vszG1wU/bNUCAHHVviVvhYdeVDPg8zUsapxI4L7y04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pwYLRAeg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so19951005e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1742572190; x=1743176990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzRDcuEPJWoPKjTTkYbk5jU8Jp68q9zHaGnFx5E4fU8=;
        b=pwYLRAegRPHUjaBQSxdbjpz1q2CeUux5umdHAPqDq896GgQJ3BSvwIqVLmU4EDZlbV
         2KZkLImiDcM/fdGSt+MKYcmqHx8oAFAHZfdJp+lDaiRdb+e9TJR8jDXxb0x9MVymS4Za
         5jFY0wUyLndebc5dh1ghtxYZlM4nE3RM5uB19WdeOrul2qET4CfRSgqCncNpUpdB2ueE
         HrraS2nlHlrEla9VCgGy0oVem1sBDguFN1QTTcDQ9h5iGVXmS1cbn5y0NzrwZYOtHvxq
         3YMiPuI7UzwX4nCrfu8Ux7YmGXru67iuonGJrgPlTNBokz3AkcEiF72hK28iWlIp3YvU
         d3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742572190; x=1743176990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzRDcuEPJWoPKjTTkYbk5jU8Jp68q9zHaGnFx5E4fU8=;
        b=Qu6Eritzo05ZqU/9Id2txxkbmZza0drY7PaWmmKuKFVSihFQYEly1L2pw5mV2RfENe
         cIV6Cs18w4JFwOy685xuLkxv8ushf15suw+7uBGyNLAhzfbKXaIQJ1u+mT6A1o6KD8wR
         yzvRL6WPGg+9GA8DSxlHefB9qjG6uJLZZmcRTj+rZ0/mFjA35ggQyBZhFRHGwGm68KVJ
         mv1l7PbT/oqRw960VId8bOsi8hBeSe5qqdML2QrFxudT/mgd55zrtcpNqkbHrAnlW6wF
         T3OENTILg8rmJSD86PMFDSE1YVpPeZeZUWkGKp/+C09hmRUXPigi8IHpNFtXY5253+DA
         FLXg==
X-Forwarded-Encrypted: i=1; AJvYcCX9R/NaWxB9FRaezXYhnW/dyzgm0l3xhXovP7CeU5+ENaWSnlgdnhBYIg6OIsD2eyzYZOp1j3VHZ7ohjMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFtSzy5QgVnvPaLJNKPjdg3Y5XazmmOku3TreEUsd6p2dpM65
	5eQpsJoxzc93SVdqShPb8nDk4uzUnYO4hCT6ZN+o0vKfh295Pqf029+DGoenjOMESVOovn6s5MB
	R
X-Gm-Gg: ASbGncvk+TOiUiME13cOGX9kcAC/bMAcG7hUi7wXcuf7wV3862jezWeVUBk3bjEw8WA
	9Y3Ih/TcdcwuvbJrdaiAyD/uqkCd3xfw9w3bbOQfeOTfoLBoRMauCgT9e8K1/G07Gj6IFvAqbuA
	yR6TkeDdnGRJcaGups5YroGftoxulFKGezXCmOpoFU2CglzkgOal8c+Bd+Qh3i0fbPOfoIH7Bev
	+d43lcFgpAzf0vvqdWrnOTdGUBB8VtgVgpeiypSPgL4ctAGY9HD2wVhXxcjeTWvlL6QoIydh87A
	5ljqrbh7elADbJyMfmax0vvpIl+e0vZkIVp0wg==
X-Google-Smtp-Source: AGHT+IHufKKfpol8lF3yKuxhjsoA02sZx0nbH61YORZlmp5UAGPiafO/EeH1mAihXmDmEh8zT0H0XA==
X-Received: by 2002:a05:600c:5115:b0:43c:efed:732d with SMTP id 5b1f17b1804b1-43d50a12d4fmr28242165e9.16.1742572189896;
        Fri, 21 Mar 2025 08:49:49 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:1aa4:f3ec:847a:32d1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3b4bsm2664406f8f.25.2025.03.21.08.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:49:49 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 21 Mar 2025 16:49:36 +0100
Subject: [PATCH 4/6] gpio: TODO: add delimiters between tasks for better
 readability
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-gpio-todo-updates-v1-4-7b38f07110ee@linaro.org>
References: <20250321-gpio-todo-updates-v1-0-7b38f07110ee@linaro.org>
In-Reply-To: <20250321-gpio-todo-updates-v1-0-7b38f07110ee@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2727;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=xL7u15VgKexCbLGGE9qnvgFvVbrc/q68QcGZle4FQiw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn3YqZZkqcpnCqZSVD+flHoJHpbMvoatYQDV2Z8
 KsOIwQjBzCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ92KmQAKCRARpy6gFHHX
 cuUNEADRTKiFPfDBvClSA+IXwxrQMIft8+zvTOzvBHaereUwuiB9BoEauMGvgJywIpK6x/OoUsz
 61kYTeuF7IKw8qNU8MWFCDRUoUbXEKhw9ijRypQ56PQ5MqmOIp67diqpj+tCve2/8aJ1j1LUsOd
 Q9BxETJ0rhWw0lbefyJEYynkH9n0wQHUUhTMDP9N703Ic/F4929r4Z/o2uwvzkuMjLrcNfCgpVn
 TMy4KTS9rZIlgZ7+Nq5ci8cu5Dt6DNt3ql0Ehu3j8pNpV7qhifiAaFlJ7Oq0bCwyJTBrJAsDkEl
 RVzJE60gUv9drTMvrVuc4cU2MYO4UxPcLb2FCC+W14S3UtL67fX98If2fHYKbtkOuJIKrjMSiOS
 Luwvy9X1DEbf9D69DcWraRvSPnm3v4m/tf9zievVvx+PwzvTObP8DOTAmQ9zPyPN260L4mYmgD0
 daQd3Cj6PNWsP1CtqZLgVjMnnkqy6PGHBgQ2Ymz6z377xL5OsWAbXKhvfBwtw6gdLoTKraOnvjM
 kVLtNEyJ35hVf+hEBda+lIshUqFCMS5rw2muynyiV7CUWedVIfWGJFWA53BKuWLbCabmYZtlCOm
 alOEfhv5S3wy0gzdAE7OIig+8tiIpE7m6tNDxEhqKPSxXK4AbpKani0vrAQme/BTpAOOfEVIhtw
 pMt7YIc1WLIhYXw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For better readability of the TODO, let's add some graphical delimiters
between tasks.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/TODO | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
index 08ff60c65abbb..052ba70070033 100644
--- a/drivers/gpio/TODO
+++ b/drivers/gpio/TODO
@@ -1,6 +1,7 @@
 This is a place for planning the ongoing long-term work in the GPIO
 subsystem.
 
+===============================================================================
 
 GPIO descriptors
 
@@ -48,6 +49,7 @@ Work items:
   numberspace accessors from <linux/gpio.h> and eventually delete
   <linux/gpio.h> altogether.
 
+-------------------------------------------------------------------------------
 
 Get rid of <linux/of_gpio.h>
 
@@ -75,6 +77,7 @@ Work items:
 - Delete <linux/of_gpio.h> when all the above is complete and everything
   uses <linux/gpio/consumer.h> or <linux/gpio/driver.h> instead.
 
+-------------------------------------------------------------------------------
 
 Get rid of <linux/gpio/legacy-of-mm-gpiochip.h>
 
@@ -85,6 +88,7 @@ Work items:
   to_of_mm_gpio_chip(), of_mm_gpiochip_add_data(), of_mm_gpiochip_remove(),
   CONFIG_OF_GPIO_MM_GPIOCHIP from the kernel.
 
+-------------------------------------------------------------------------------
 
 Collect drivers
 
@@ -99,6 +103,7 @@ At the same time it makes sense to get rid of code duplication in existing or
 new coming drivers. For example, gpio-ml-ioh should be incorporated into
 gpio-pch.
 
+-------------------------------------------------------------------------------
 
 Generic MMIO GPIO
 
@@ -119,6 +124,7 @@ Work items:
   helpers (x86 inb()/outb()) and convert port-mapped I/O drivers to use
   this with dry-coding and sending to maintainers to test
 
+-------------------------------------------------------------------------------
 
 Generic regmap GPIO
 
@@ -126,6 +132,7 @@ In the very similar way to Generic MMIO GPIO convert the users which can
 take advantage of using regmap over direct IO accessors. Note, even in
 MMIO case the regmap MMIO with gpio-regmap.c is preferable over gpio-mmio.c.
 
+-------------------------------------------------------------------------------
 
 GPIOLIB irqchip
 
@@ -135,6 +142,7 @@ try to cover any generic kind of irqchip cascaded from a GPIO.
 - Look over and identify any remaining easily converted drivers and
   dry-code conversions to gpiolib irqchip for maintainers to test
 
+-------------------------------------------------------------------------------
 
 Moving over to immutable irq_chip structures
 

-- 
2.45.2


