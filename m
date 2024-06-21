Return-Path: <linux-kernel+bounces-225399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066B091302A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3747B1C234B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229DA17D88B;
	Fri, 21 Jun 2024 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QIRpXW8x"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B630617CA03
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007930; cv=none; b=uEahABHS35sMzPmd37DxsH1m2RdMrqTsFBOtGZYpLY9XA1s5VQL1RfBGKlK+qKmDaqBCgD7ry4+IkxAbFxJHRXZ9rYNN1D/QgN4fnIhoX9KuxRPcZm/vhVEoL/OEEqdTB6RQhG8HiIE7/iCdrD1aJTHT/UXrPLjd8ZA4qz3tdm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007930; c=relaxed/simple;
	bh=D4fRF5Zhpc9HezkdYsinrECFHeuHQj1dIH5KeSf9cf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuOCM42CPZLbUAIZHJDJKncHyqOoGXmSfawva7n7+kEbBqO/GpDKp+LuoOIaNwDY4QWRYiva5WIPBp6Z1oY1gVP5wC7n5dlfNwvAQgtAjz+lqb6lHpcXzGdypahXVoPrwsgx8Q1qu3CvwUfCDlT/XQh2CRbVn5FIsX03IV20tbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QIRpXW8x; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b9a35a0901so828769eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719007928; x=1719612728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x480k30HvbgguxGycHu5EFcSQYfeSDwQqt26z/bkWhw=;
        b=QIRpXW8xQvgnyRciqGyHHpnJukDcNIrJhYxcy/eNXRvn0gAbvz/dttFM5aY6ipig3l
         7qHvr3/c9CznOX3n2FIjGqgJ7TDWzFaOMXdgFJzy+Ks1sbOy3zMMHNq1jzvo2z/k0hrW
         Szk6ZqgpxC+iWPXJmy6w17KZ9mYArMQJaXWnB/t10X3pVz6lckrBUCzhLuc30wXm3Pre
         gvhMfCSAXRZUO5ZUbjTrW/LPe0b54i7T27DRFAOlemeGI4tU4FMk+A5G6F0NOfl/TkSv
         OaSq9baMfGaFUCKpQFs6uBihRdo/a4Ikl5NIZtZM+bVZMIX2Fry0vqaMJ22ZgZFDNs0u
         3CIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719007928; x=1719612728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x480k30HvbgguxGycHu5EFcSQYfeSDwQqt26z/bkWhw=;
        b=wpkGG9P4DGoQmTn9rKGDBIhBR4RLFjRdRADYZ37mXTNwWfFoavWp4Nz3r89olL3lLJ
         5FTXLukJ1LaXrlkGoMpjkZu4KvCrFLJ+zZJ2Md2hhdZi4pUL76D1j3K8FRE0gEHqCJIp
         jJlHBxkSM1uYKKdDIP/4as8xeuI34aKj9jFdaVzl/Uh8YE8dhXVI0PjW2WdGSkmS5NmO
         gGiCbG52dXCVXQnR4FoDeG9gQJISlh1U3kom5/hnM979hTVqODRiVwhChI/agmsIpVZo
         Az659MPrxKbNOPLLe3Me9BJqvOIMF7z1VXkOpPiXKdonIKcOB2CaO52ue3uz/bWELI67
         0x8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcdvwIA+RvI1un4xQCeTZUZY5HRZKD28YwolVJiHq62Nskf+ywcvDT6pgIZhXXAO2VboJ/RAdacrGgsWQLmfA8PUiNkN1+asllLrAs
X-Gm-Message-State: AOJu0YzGjnMiSt1Cn4UGckWIwrbZP2GrhyIYvmc2XQalQEgEkuLLRANG
	9XA2hrIp9I5C8o04/s0ADQ+QPzoaoVHtc6R/pslY7P+ESPHiiygKWivZhoSfU+g=
X-Google-Smtp-Source: AGHT+IG+VM3BqlCHEFeC4J9E/NMCgNrxfHHKT6M7Y8Cy0YuF/8Q782d8FLdKsjcTjtElrN8SZRNxMQ==
X-Received: by 2002:a4a:3c1e:0:b0:5bd:b100:8ab1 with SMTP id 006d021491bc7-5c1adbeb0e3mr9929583eaf.7.1719007927729;
        Fri, 21 Jun 2024 15:12:07 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d94fb2a4sm329837eaf.10.2024.06.21.15.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:12:07 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] iio: adc: max1363: use devm_regulator_get_enable_read_voltage()
Date: Fri, 21 Jun 2024 17:11:53 -0500
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-6-49e50cd0b99a@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Use devm_regulator_get_enable_read_voltage() to simplify the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/max1363.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 8b5bc96cb9fb..bf4b6dc53fd2 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1561,18 +1561,12 @@ static const struct of_device_id max1363_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, max1363_of_match);
 
-static void max1363_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int max1363_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	int ret;
 	struct max1363_state *st;
 	struct iio_dev *indio_dev;
-	struct regulator *vref;
 
 	indio_dev = devm_iio_device_alloc(&client->dev,
 					  sizeof(struct max1363_state));
@@ -1589,26 +1583,12 @@ static int max1363_probe(struct i2c_client *client)
 	st->chip_info = i2c_get_match_data(client);
 	st->client = client;
 
-	st->vref_uv = st->chip_info->int_vref_mv * 1000;
-	vref = devm_regulator_get_optional(&client->dev, "vref");
-	if (!IS_ERR(vref)) {
-		int vref_uv;
-
-		ret = regulator_enable(vref);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(&client->dev, max1363_reg_disable, vref);
-		if (ret)
-			return ret;
+	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
+		return ret;
 
-		st->vref = vref;
-		vref_uv = regulator_get_voltage(vref);
-		if (vref_uv <= 0)
-			return -EINVAL;
 
-		st->vref_uv = vref_uv;
-	}
+	st->vref_uv = ret == -ENODEV ? st->chip_info->int_vref_mv * 1000 : ret;
 
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		st->send = i2c_master_send;

-- 
2.45.2


