Return-Path: <linux-kernel+bounces-558674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86243A5E94E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB2F189D390
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6509B158D8B;
	Thu, 13 Mar 2025 01:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NUnd6KRE"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5FD142E83
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828582; cv=none; b=nDOoKnH8jmpHth0eWawpdrxaMjaCWTMuStPp4GmO2cA7G9ErUG5ZyxBUJjIQlPfQzqAitQMoZuaTzyU2sLJR9fTUpC0G233DNH1erzUTAJgGu2Gw1x8gheS+seyU1kvEYzLx+mCT9C98p6iVKfthHjOVdVWkBBAn7wuFPqRSSkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828582; c=relaxed/simple;
	bh=qKZSuCxtl9tcxt4Po5/CTXwnjx7p7qGopCKUQxtAESY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kmnWQK5urvry7WEHO6cd6rnF22A/hlnAKe3sSEtxqOBk6fWHC1diO1WJgrzm07m9/7y6EkzlREHfeHe2T20HA6RjWmGuxwWV4kCK+YF8Mlg65p43NDylW1UZGkGBc9haGpZqC96biIu1lcQkvwOxN263xUO5SRrBPMZmGIsBC8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NUnd6KRE; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5fcd686fe0fso205237eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741828580; x=1742433380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ub2dM3/RGcj9mA3V9E27MSFaOISaFpTMgcXwRQUXdos=;
        b=NUnd6KRE+9LTLjD8SBWE88QRucwaR91oclHuPilTjDeAPebOQ+LuhzWbemq7yc5DB3
         qWOHai8Hpg7fXzShlozL8ddW9F+f+Btn98yT4pBPu0MfForXqaeP9wzGeVRB4RuMopIN
         DeESgcwTBEX46EEH0fJkLAvZ65qYytExLTzQ+YLDPlc8ffs/RpTFHQJ0NH2+i6VKA47P
         7xQ4aNzwhJPtGRmFQ6OwXVuY7xrGzFVTOjaQRk0e5GYurUpfbo+f+U7sBCpSz+DWr27U
         R3mqro0cN3wELT7dRTqBxxwon7ogg5MsJfJoEuv/2JrD/+UXu9xy7A6YwP2p84TdZEMn
         0bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741828580; x=1742433380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ub2dM3/RGcj9mA3V9E27MSFaOISaFpTMgcXwRQUXdos=;
        b=J1aKXxzoe4kB/u7U7lp+VeNF9xM5maxFwOqQ9F6u7pfHrfDg6mesFZO5BSsvlFAiQM
         j4epAE7onxjqDc1F0Iyx4ExWNXUCQZurR3gYFaaRTQ52VoLFyt94mBraBagRGLUbCsVr
         KzD/o0Ja3PtMkjZLi0DgzGcCv2ULp/qSJOjuuCH4XhOyGnrL0WvKAIYXJnHckvQ9+1z5
         5iGsxEqQElRA0zWfc/5yxkkL8QCjAxMOsarUEZ97ew0WHiQ0DYhgwMeS74sVI0mWV61z
         h/WcaATTi7pML74glT8sua2ORbFwAevxBSZ+mnIwkx3hsby/5NzbRVasu2b/GmfVAjGb
         wUNA==
X-Forwarded-Encrypted: i=1; AJvYcCU+xnXr9q0KyZbxvSQp0WcC4f84iJRaQe8aZa/KpbgbbBouwV6MCiKLlIJEPVpdo3FRD2u3/+T8WNV1/Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaq2EEwHZulhLtdnNrFcMOf/WWTsnClA26ALkutuHE1M0LsGUh
	/HKHbu3Zrm9Y3dM7vD72GdoYKvMYcCDnMKfWm6YnF2iredMtpGqj8+qd0c/ZJi0=
X-Gm-Gg: ASbGncsyzJvVD1On6zEKJpUTHyzkU26Tbi+pfuIFC8Q13LKQsv2fpe9xUpEy5phqT9Y
	fZk3X+oCi8nfpSRBP00t5OHiMVgMet0f4NwTZK+pyRYPVQb7hSDD2Wo7IGPut4j+ERnYTVpHSp5
	vaEUz7NaKGVcS2BBTK1h5RBy+BBxxMp+aZsPF7hB3MkUeCiPSD0yQZ3YqpUM6JTlDURWEYIAC8o
	bTMLk3pCRMI/eKRCl4cZzpMQkmgCNBI+YWodZ+ZK4Z0iO5fImH3WSkjue2MH4Ld0U/VPAwZDiSN
	HPkg4WqrVcTwKfugFDDJ/T8SNZjuSbi28PZh61HsUtsM6TaU2NE1+0tbN2H9ONYZtJC0cGaX7Oa
	t
X-Google-Smtp-Source: AGHT+IHDd7tqJOjGEcZgrq1YXhswYd1QsJBlWzqCWhPa2Kg7pTKfG0tSIHEabd4fj4R6v/meEWMubA==
X-Received: by 2002:a05:6820:8c6:b0:5fc:b7f4:c013 with SMTP id 006d021491bc7-6004ab16543mr9939642eaf.5.1741828580173;
        Wed, 12 Mar 2025 18:16:20 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db659ad8sm39865eaf.8.2025.03.12.18.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 18:16:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 12 Mar 2025 20:15:42 -0500
Subject: [PATCH 04/11] iio: adc: ad7606: add missing max sample rates
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-iio-adc-ad7606-improvements-v1-4-d1ec04847aea@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3398; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=qKZSuCxtl9tcxt4Po5/CTXwnjx7p7qGopCKUQxtAESY=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn0jHazYHJnK5YXUo98qA+IVLMwIcGE6xWiHGYY
 VJHFvQv3eOJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9Ix2hUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAMMIQ/+NuXu3Jy7/vklUjpso0z/7/z9RaSOHwBnj/hBkhZ
 qP/3dO/VUEguGsxUYlQIG+8b0ojamy1+NdXN42XrV8tKrPln3LfduqUKxPCo1yCb/JgGtI/vWhf
 S/KQFAQ4fNf9dy1s9CIU9i734cl9DvKItDbLeK+PtX7uWnGL0lqOtLbGTbZ66vGVVmb9jFZnzcK
 aYpuJCCvn8LB+FqORXaradJwPltRzdaHTN4PzVeUC+qOO5e1KC3EsOCxaHls23oX29gvQE33L2M
 9KjDYlmZXN2CtBcPkYxvP1Lnd42l7gTtCRZavVqB22wL/bmpE51VrEZ1xZNys1Ucdo5Mao+fb1G
 WGHnLMzFVJp7Iq8VwiFxEOw1DdV7XUfXYEDeRQHLex7QvB85KkBHX8NOy+A9ouUJ7dmjoAxcYGC
 ndV8os3vh9hCfBAq4iNrl4DcIDQqXbIciIxcrem2Bgvq8Pc4gjNqAALgjWCGFmxduKe6jO2kY+8
 0V6yeqb57gqsXL5AQZC0+qKjH0XdXZe5hBLD2xnlSxRhtRF2cTaUVetKtRBPeMz6REzTN26sR+4
 32i3FhNVY+N04fX00q2F0Du7c4998fhZYhhtgGp1j36Oc3OaWK/waEPEh57LBB7lUR+DzbCleMB
 r7S1UJb6ixLR4t4vYY3tfSs0ERg+KnqWQXjzerpMBJ8I=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add max sample rates for all of the chips. Previously, only one chip had
this field populated.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 79929bd24fa40bccfcdd88673107da4bf56e032b..440e1e5a9b18570dc6441bff91afbc51d20cbc47 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -196,6 +196,7 @@ static int ad7616_sw_mode_setup(struct iio_dev *indio_dev);
 static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev);
 
 const struct ad7606_chip_info ad7605_4_info = {
+	.max_samplerate = 300 * KILO,
 	.channels = ad7605_channels,
 	.name = "ad7605-4",
 	.num_adc_channels = 4,
@@ -205,6 +206,7 @@ const struct ad7606_chip_info ad7605_4_info = {
 EXPORT_SYMBOL_NS_GPL(ad7605_4_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606_8_info = {
+	.max_samplerate = 200 * KILO,
 	.channels = ad7606_channels_16bit,
 	.name = "ad7606-8",
 	.num_adc_channels = 8,
@@ -216,6 +218,7 @@ const struct ad7606_chip_info ad7606_8_info = {
 EXPORT_SYMBOL_NS_GPL(ad7606_8_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606_6_info = {
+	.max_samplerate = 200 * KILO,
 	.channels = ad7606_channels_16bit,
 	.name = "ad7606-6",
 	.num_adc_channels = 6,
@@ -227,6 +230,7 @@ const struct ad7606_chip_info ad7606_6_info = {
 EXPORT_SYMBOL_NS_GPL(ad7606_6_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606_4_info = {
+	.max_samplerate = 200 * KILO,
 	.channels = ad7606_channels_16bit,
 	.name = "ad7606-4",
 	.num_adc_channels = 4,
@@ -251,6 +255,7 @@ const struct ad7606_chip_info ad7606b_info = {
 EXPORT_SYMBOL_NS_GPL(ad7606b_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606c_16_info = {
+	.max_samplerate = 1 * MEGA,
 	.channels = ad7606_channels_16bit,
 	.name = "ad7606c16",
 	.num_adc_channels = 8,
@@ -263,6 +268,7 @@ const struct ad7606_chip_info ad7606c_16_info = {
 EXPORT_SYMBOL_NS_GPL(ad7606c_16_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7607_info = {
+	.max_samplerate = 200 * KILO,
 	.channels = ad7607_channels,
 	.name = "ad7607",
 	.num_adc_channels = 8,
@@ -274,6 +280,7 @@ const struct ad7606_chip_info ad7607_info = {
 EXPORT_SYMBOL_NS_GPL(ad7607_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7608_info = {
+	.max_samplerate = 200 * KILO,
 	.channels = ad7608_channels,
 	.name = "ad7608",
 	.num_adc_channels = 8,
@@ -285,6 +292,7 @@ const struct ad7606_chip_info ad7608_info = {
 EXPORT_SYMBOL_NS_GPL(ad7608_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7609_info = {
+	.max_samplerate = 200 * KILO,
 	.channels = ad7608_channels,
 	.name = "ad7609",
 	.num_adc_channels = 8,
@@ -296,6 +304,7 @@ const struct ad7606_chip_info ad7609_info = {
 EXPORT_SYMBOL_NS_GPL(ad7609_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7606c_18_info = {
+	.max_samplerate = 1 * MEGA,
 	.channels = ad7606_channels_18bit,
 	.name = "ad7606c18",
 	.num_adc_channels = 8,
@@ -308,6 +317,7 @@ const struct ad7606_chip_info ad7606c_18_info = {
 EXPORT_SYMBOL_NS_GPL(ad7606c_18_info, "IIO_AD7606");
 
 const struct ad7606_chip_info ad7616_info = {
+	.max_samplerate = 1 * MEGA,
 	.channels = ad7616_channels,
 	.init_delay_ms = 15,
 	.name = "ad7616",

-- 
2.43.0


