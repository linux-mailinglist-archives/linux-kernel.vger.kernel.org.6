Return-Path: <linux-kernel+bounces-558670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A167A5E941
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235CA189C1C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5E6179BD;
	Thu, 13 Mar 2025 01:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qB99r5xO"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D801C683
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828578; cv=none; b=kZ7sLkg88gTNl9PJXWwdfrQe1THqTNTF1TbVaY758jc7hJAKDrPkKXOh0+I6jJP5vx+b5XFw78dns0itL9q4xyyCAu89YKvKMOedvg2jHsnHu/1OBxVA3jTcxcj1woHhLin8yHG/EpzhGdWZUAzdhkcRZiv+QHDJnurrB7/hxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828578; c=relaxed/simple;
	bh=xZHcGGygz8rLb2jKnacJRSX2NoW/pbcS9hwvQWXE9dI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EP4UeCVpD2rjostAHvawyjGQ/GRpcmh55noGiQNjOzJlNXXRWFOMmBEGS1xA8ENSq+NoC0uoQeiJozEEHEQF3rebgTlmrmZx+7yCOjAia6OC+OAcSUs6LxHCT1ymRnj2IQNm9Y6uEndu/68I0dROyt5Djz5ziV0pY8+aJ91kdHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qB99r5xO; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7271239d89fso130233a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741828576; x=1742433376; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bn6syc6wh8t9UYBPXOdzHhnfpFN2bWgwC2EMK9hX77c=;
        b=qB99r5xOzcOAYUWu46n7Ox0hAC6ROLLSW+NXSF5tQOxfG+/5JfhJP3WrQEuvn/LX7Q
         Jm/CpFsezQYeiPf2/bU+MFS9c+eVn4eZpkGvrrWrgG2hVJ8Kjvx5SQEONjvup2MseHA6
         EztbpC1yukmvfC+RArhhkS52Su2/MlE8AHT3cV2OhoK6AUgyDj9ueuu5M4eIR+2urYRL
         kzqbQERYUL6IhXGuVQEBubj4YfW3wHdQ69Xk+MQ6j6faSzY7rqK0380mZOk6hzs7jMRT
         Kv/s9i+/vsDYHgmyY8LZR/AmqLxqYRO8yrenYW4xKkfiIT4McGYF0hVn6CpoUcU5H6Ng
         rMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741828576; x=1742433376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bn6syc6wh8t9UYBPXOdzHhnfpFN2bWgwC2EMK9hX77c=;
        b=LGwa221lK1XPX8UG0QEbx2AQlrkMKz0zSvD6kqtmmkAi5nAfJvFFadIWaoU1459TwP
         qwLKXUpIyytvqVcmsV8eMFmG3lx2TYEn/HoIFbToHjIdGL9HdA5Yun/ssZC/Y3DBWwbZ
         +Nzqog0N45CEkFCCI/OtvWwnWCbI+II9p8s+PwNEfFAQdpumo5+t81BJf7893V/3z1zo
         UJDKuwsbl1+fZm77kGalwqXt3jEzOzHJfE+1Iu+bbOBvAQDCE8DR7z2f8bxVN3P/Eu6+
         KjuF4zXZvIpWO03WqryuGYnmp5Sdjh78EPB/PvRhCCgQVvgqbi8HixNEZ0OUbOdGTE4m
         31Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXaYpkYXn+owbEC6mFVK6ifcCTJZ51chktBueGatxQq56Ae+EZL/bqyES9t89J2HTPccquUto2M5adeRN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB1dCdZfILs1N4Jxx3TKpiTQm/geikTWBBaqslRA/iK2m2wiex
	2zo2jL0FQyKK2gXAZ9CBVmMNW6bo7YouvlwP+Cbm4382RjntYPXNob+p6KHGg1Q=
X-Gm-Gg: ASbGncsLkrZ1UT5XAAmr9i3SELuZzw0wP+RbU6LNjQp6rNWRGx0uu6VYNIiO49bW0K7
	SjtVEni95SyBXJPngOGxB3/NA93eXFFfxg49cluxycoxOlz4TTwU/u3mBsEAAlT4wFYgueTu22/
	WTJkhV0oVer2ZHWR8lHoC1eymIbxj7jIPWZSXM4CkRl7sQGwdZcE9vRxoHF4fPzlbbGh0Q3n67R
	fmx456PJ94X2P0B55u/2svVrSerBHxs2gPoRRWRPmWDkr+S+Y5t9fzjJwozlm4UabFfePzSGjbh
	Kkm3UDtzlZFEH4PBhGIdLT+D6+0GZfcRvOdEgSsrdh/ccLBOmQMVOfqjNcfKOlGIfpSoED2RJVy
	8cUchDsBkTZ4=
X-Google-Smtp-Source: AGHT+IFqI99xnlFy4vifJ2ohpC02lCYpxCA0dEsc1Wso3XCVcaj9+mlk9yGOjVOWn1sqikxx0nYmpQ==
X-Received: by 2002:a05:6830:6201:b0:727:4356:9f07 with SMTP id 46e09a7af769-72a37ba072amr12944875a34.14.1741828575757;
        Wed, 12 Mar 2025 18:16:15 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db659ad8sm39865eaf.8.2025.03.12.18.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 18:16:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 12 Mar 2025 20:15:40 -0500
Subject: [PATCH 02/11] iio: adc: ad7606: check for NULL before calling
 sw_mode_config()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-iio-adc-ad7606-improvements-v1-2-d1ec04847aea@baylibre.com>
References: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
In-Reply-To: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=xZHcGGygz8rLb2jKnacJRSX2NoW/pbcS9hwvQWXE9dI=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn0jHa3XB7NLH6KlhxCimyly37UP6OgW+jgn4ji
 O1EenmhXI2JAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9Ix2hUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAMCcQ/7BfJcfeY3IbXeqBUQzMYAqUbr5OxwuJ6SRo4Y7Ky
 +n152MA7Xi1730p+i94R8ssYBgq0ZG3ukWTbMiU9EGmaRILr4Ou8fm1tsq1CxGE2OJGYJM27r62
 VPHpBhc6BTwNbEbn3SSnLuFUEwDNd/COcz9byTJ8kw1EnmktcM/VsynUnL4Yfpv42qtnF9sJkQo
 x9U1dVTYPWpKqfK1m+ER27D06DNtaz36G0rP9S73i2NE9zJKqoDbO73teee/mohAQa7MOE/jswv
 GqEkpgHnFUvtOXvcAchjdN/lIztILIKao7QH4NI9Mfzkyh9gnEaj9k5fv0k8tWrYDx56VS7UZ8Y
 O6YWni56Bus4UVJXm9pTRoUC+6zfie0rjinrukkganorAu11xVt9zYYyt5G0T01A3ULhypT67Bu
 CvTlkTh+/E4nKQv7pz5wqea+At+SfESe9MoMc7MC9jyMXT552hi/uINWmCWnRMLue7rXEbnouj3
 kMOpKfymNovEAcaDo9rjfNIU5lvpTEBesf//+ZDwLo5m01By/YsCmal2XtYeVn0TQNvmhBVPwVo
 aY9QVcpRpMw2DlylcAY+QbGHV/obMrSmEMZYQ8JPScnkpk0aqhuoH0C7+6KtKLPVpcSgIljfeL0
 VaGfi8BuoRO0gPJr+pitKe/A7x1DrHd7BspgJjMhRDh0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Check that the sw_mode_config function pointer is not NULL before
calling it. Not all buses define this callback, which resulted in a NULL
pointer dereference.

Fixes: e571c1902116 ("iio: adc: ad7606: move scale_setup as function pointer on chip-info")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 631e837171679ad95e71cef2ce6c55c2c756881a..ec444aba25e89ced7b84b723aded3c9dbf2c738b 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -1236,9 +1236,11 @@ static int ad7616_sw_mode_setup(struct iio_dev *indio_dev)
 	st->write_scale = ad7616_write_scale_sw;
 	st->write_os = &ad7616_write_os_sw;
 
-	ret = st->bops->sw_mode_config(indio_dev);
-	if (ret)
-		return ret;
+	if (st->bops->sw_mode_config) {
+		ret = st->bops->sw_mode_config(indio_dev);
+		if (ret)
+			return ret;
+	}
 
 	/* Activate Burst mode and SEQEN MODE */
 	return ad7606_write_mask(st, AD7616_CONFIGURATION_REGISTER,
@@ -1268,6 +1270,9 @@ static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev)
 	st->write_scale = ad7606_write_scale_sw;
 	st->write_os = &ad7606_write_os_sw;
 
+	if (!st->bops->sw_mode_config)
+		return 0;
+
 	return st->bops->sw_mode_config(indio_dev);
 }
 

-- 
2.43.0


