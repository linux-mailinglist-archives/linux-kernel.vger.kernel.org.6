Return-Path: <linux-kernel+bounces-434924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D589E6CEE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26AA188425B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189B01FF5FC;
	Fri,  6 Dec 2024 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="In2/7Xdf"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56527200111
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483646; cv=none; b=ZCA0suRxuuYHQM7VB6g5Nskpj0CpBKqv8dbshTGqKRs+QGnZsXxjive944VwoHr/+7ihkUDSIHiQEAJS5Hb7VS8PkXfSsGhz3GWkjsQyNb1bOi7S6E9UULJUyVHVotwRRtOzLhx/4mqa8dAlslQjt93V+7Xt3wYknq9Eob1rQ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483646; c=relaxed/simple;
	bh=Dwmv4o74khoBQdkptuvQ4q7nGic6CB59TAj8g4R5I2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kuA0Vr/rjxNqZN7x6yVNdALycgBsQYckK31UW0+YqcOSQHAdtOKelBO47A593WqXCRQxU8OZgycvGBWI4JM9qBP7hEPd5SHIFZCJZyAgggrPQQz7OquJU9LtlOtN1DTqCoVLz5YtSPnZHBUtjb1bCgRyN/w120YWp4Tvx7yMiaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=In2/7Xdf; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa543c4db92so385776266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 03:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733483643; x=1734088443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNUU76506eldJbwNztMYjCQxf0w88SMXCYz1DW5xFro=;
        b=In2/7XdfuJQ+VvilHhtkD7O+e9S05Cfhzi+R9SmGf/eoYLhLxcRfqJ9RKkZG8CNXnB
         Jbql9fJNzGnWpQlCbPvbLy/tp3Vvk3L+vUBAqRb036S88aluvlxP3qTYTVTxghQuyziZ
         gHJnbYsb2Mk4II6juQZ+pgwZO2LH70WG5lIwUmoCGOpLo2pSqr4j8zrvpToNRb8E8hC/
         It8F/dCDIP5mqhtkjQoqCGlYb8nY1Sqljddtk/PMwoWnpEdBPO5kKVWCkpVtSZxvhMf0
         FBbJQPanKxlJmrvSKE6knIj3C21w5yH61mz+Ld+YUTUTmGGIztH9Xn8mpjmDccbencqa
         /1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733483643; x=1734088443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNUU76506eldJbwNztMYjCQxf0w88SMXCYz1DW5xFro=;
        b=qEsvgsesNh2oe57jBFj4SNS/YHiGM7aNTRhiEpc/DEzWpolV6IrhYJB9bVqDHKgfGL
         5nwRGG2YZez2ou9gU5waRJ6XC0yhb1x8kUrfTH9J7DONIWpUau7R8WcUQ6Z8j+lgHwhk
         fxn6MNMDJBLhVXxhaPX3sDeokHxdVgVGlQaXopiHv7GuMyf5pdtUPJFdg+ksrVK9IpOj
         2M/4gEj+Po0jOla9R2OCNsxx7zlcrfVFN8zXH2r14lOE6iSwAky/TBfdVTWS66H4szWp
         No2JxD/7zCQKswZ62/I9ID6wrI+qbkM0dXSfVPE4qW4oXRTPzFGPh6qjZxJwFL/gLIhC
         7F8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3jAYbZGogVMRgZ82ABNxVLWJjbdOlfjWB7xuZl6Ryk3aMj8r6uZSliyJuTSi1j1AplZTH7CJXvcAe8xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkAaf3nwYWxecR0dEV7uMBgO135NINAzSbnQa6IUKxpaaKF38B
	5kH4u7Pcmyn5kThCfRXBDjZjfmLMEhPcAjICGIxF2R583VqArx+1TIW2cZa+QRs=
X-Gm-Gg: ASbGncsvO6G4syNTJp934f2VLz+Y8SPt4H7H4TfzhQ+8R5xEnN0PuYnwZQO4exgpD5D
	bPu9tw3tdQeH4fpddhGkuZqdPMb64BCdHJoAD120iVyzvqGemtkdYRp6k+9+TgjG+o73BzA2z01
	7CKszzXGCs8QRxRw+8hadIA31KLWdfa5OU0m7N0zLflIvJIsClUdh14egMSEbLm0iHTJ34SVj1C
	thA5XUoDPW9LbCWBMFieDuJi5bTDKPCDR6qBBKcDXBhGZstvQuXBa3w/yAzQbGPbkpdHkOkPK7/
	F1YH
X-Google-Smtp-Source: AGHT+IH6Yt9ImiRFWWuZjkCgbEGYygXRPHwjAYhKDD1eg/rWy5S/tL1CQg/zDPDowgi1wK/HCr+qTA==
X-Received: by 2002:a17:907:75d8:b0:aa6:2867:4dc5 with SMTP id a640c23a62f3a-aa63a285650mr203661266b.49.1733483642631;
        Fri, 06 Dec 2024 03:14:02 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eee2a6sm226877866b.90.2024.12.06.03.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 03:14:02 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 05/15] iio: adc: rzg2l_adc: Switch to RUNTIME_PM_OPS() and pm_ptr()
Date: Fri,  6 Dec 2024 13:13:27 +0200
Message-Id: <20241206111337.726244-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The use of SET_RUNTIME_PM_OPS() is now deprecated and requires
__maybe_unused annotations to avoid warnings about unused functions.
Switching to RUNTIME_PM_OPS() and pm_ptr() eliminates the need for such
annotations because the compiler can directly reference the runtime PM
functions, thereby suppressing the warnings. As a result, the
__maybe_unused markings can be removed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 drivers/iio/adc/rzg2l_adc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 780cb927eab1..482da6dcf174 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -454,7 +454,7 @@ static const struct of_device_id rzg2l_adc_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rzg2l_adc_match);
 
-static int __maybe_unused rzg2l_adc_pm_runtime_suspend(struct device *dev)
+static int rzg2l_adc_pm_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct rzg2l_adc *adc = iio_priv(indio_dev);
@@ -464,7 +464,7 @@ static int __maybe_unused rzg2l_adc_pm_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
+static int rzg2l_adc_pm_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct rzg2l_adc *adc = iio_priv(indio_dev);
@@ -475,9 +475,7 @@ static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops rzg2l_adc_pm_ops = {
-	SET_RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
-			   rzg2l_adc_pm_runtime_resume,
-			   NULL)
+	RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend, rzg2l_adc_pm_runtime_resume, NULL)
 };
 
 static struct platform_driver rzg2l_adc_driver = {
@@ -485,7 +483,7 @@ static struct platform_driver rzg2l_adc_driver = {
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.of_match_table = rzg2l_adc_match,
-		.pm		= &rzg2l_adc_pm_ops,
+		.pm		= pm_ptr(&rzg2l_adc_pm_ops),
 	},
 };
 
-- 
2.39.2


