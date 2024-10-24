Return-Path: <linux-kernel+bounces-379550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 001FD9AE04A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F8EB21F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFD81C07ED;
	Thu, 24 Oct 2024 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xbSK1usL"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605361B21A2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761176; cv=none; b=ULGMzS9OcyB6YUYZLO/2B9OrGWPGXwGzC4jmhmMh4Gdsr+0lJ//y+iv7wIBNBuyFQ2Gsw+8IrvqEOsR2a7rUqLNgUT5vwfPQ6oTyvAU3VgOZWNRLVqIqlSdQXeGpH41hFYR29YFSYV9zjh29SsD1TXlkSU2oeenBjgxXd2iLinw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761176; c=relaxed/simple;
	bh=bpTnp9nT2dKpE0zNeVdWpkY1GIIYuomrwdvCKfM8qu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KCF6Gi+zkwFLqWjETupPGzeP00e/uu7bEQzdyfIFpt9gshTafIA9oZY1XSPPYw5iHlaBzy8gIvf1TE63Hd+2Q18jWQbc1qgISUdNPveSFvkF+REOP9cZWOltIgh400hu9cRyyzChEIg8oapCFnUjbTKQ3FqWG3K8xcRYiNX2W4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xbSK1usL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d3ecad390so1278963f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 02:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729761169; x=1730365969; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIQ2MP5pDvvYrbfNGj0xV8zPitW4RS++GGpHycvY1/k=;
        b=xbSK1usLPSE2NfspMlXreJ5SPJ+FaH6inVaIXEHC6keLF5Hns9UwhnvNpQ8eU7vIxC
         FJ1tJyklysU0oyjCwzRlGch0JDYcTA9qvKmipAN9y0UAmHAs1QZRJObwaaKEqGVph5R/
         k7gdNWZjYynJJ/kCRPaarTn1lvQyqMWseOixeNJngGkfGr1wWmc2/S0VNuCDA8Jj/PcE
         p2oUAeoiTKiHDJsirjrhDCC99p/7F+XL73eye0ufHVn2GyZg58ih0Hem08tu0AR4ZBPW
         droFkqDrBogLpqbLsx3DxsAJqi7pN0xJNPNOAG2akF1lvsHrO7KP7vAINruOJMpn68ch
         +3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761169; x=1730365969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIQ2MP5pDvvYrbfNGj0xV8zPitW4RS++GGpHycvY1/k=;
        b=ntWKNT60j6Jpd+/ReYw6jALVW5y3f7WVS+UQHNtu9OAYkjpa5ulmCcRBkrmXmMHRv1
         M+Oz0NXka8uXuN7FFIjOPIFhQgDPzbSC/9HJMhukrKQxToVccJT7Y0QTmQ695tav/Z02
         B8JHJRit0Dgo0YUXTOTZ8QWfno35rDb8JXGTVfayNMh0emGc78PVsPdh8j5f+dtF0cpq
         f6sSxfqV4qwXxHCXppIIt5q/Z1Ok7Edblr5B1XRZKeOXMMPVKt96e73mpc21KIAc+euF
         vUJHbVN2YlogpPkJO4OTgT+xsKzzY1ublc0TSYhgaygAR2DJTDZeZkjSiKVtKzU+YNlh
         ru1A==
X-Forwarded-Encrypted: i=1; AJvYcCX1gKLeLxC5BEoOi2O7S/mhkMS3uVE7JD882yRcoXO/y1GaaqvIbry1nb7YFvnIadtnmPwqNuL2l1xAePY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgE1LsvvEDD7BHWOaZS6Ygga3urhw9oFJdjfWX9Nbd+vaCkCfL
	oQ93PrJTXLQFGqw3ZtSrkFwjT6CNNC9TDq0Rme0fZapkh3v3Tzhw/25nvyGR4Q/MFw4NVvKldii
	zsJEfzQ==
X-Google-Smtp-Source: AGHT+IEntWBLa/5dqURskXL/ARSqsAtqEzMl2o5Iyp6sjz8yTHvxrX3rp+R1PtjRMJFP/N8oYDaypw==
X-Received: by 2002:a05:6000:c8b:b0:37c:c4c0:4545 with SMTP id ffacd0b85a97d-3803abb4947mr832029f8f.10.1729761168701;
        Thu, 24 Oct 2024 02:12:48 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94071sm10843701f8f.89.2024.10.24.02.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:12:48 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 24 Oct 2024 11:11:23 +0200
Subject: [PATCH 1/7] iio: light: bh1745: simplify code in
 write_event_config callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-iio-fix-write-event-config-signature-v1-1-7d29e5a31b00@baylibre.com>
References: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
In-Reply-To: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
To: Mudit Sharma <muditsharma.info@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Anshul Dalal <anshulusr@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Dan Robertson <dan@dlrobertson.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Matteo Martelli <matteomartelli3@gmail.com>, 
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Mariel Tinaco <Mariel.Tinaco@analog.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
 Kevin Tsai <ktsai@capellamicro.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

iio_ev_state_store is actually using kstrtobool to check user
input, then gives the converted boolean value to the write_event_config
callback.

Remove useless code in write_event_config callback.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/light/bh1745.c | 48 +++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
index 2e458e9d5d85308fb6a13d9dbd845fa03b56a40e..fc6bf062d4f510886f909509d8115f0cf892f3c4 100644
--- a/drivers/iio/light/bh1745.c
+++ b/drivers/iio/light/bh1745.c
@@ -643,41 +643,37 @@ static int bh1745_write_event_config(struct iio_dev *indio_dev,
 	struct bh1745_data *data = iio_priv(indio_dev);
 	int value;
 
-	if (state == 0)
+	if (!state)
 		return regmap_clear_bits(data->regmap,
 					 BH1745_INTR, BH1745_INTR_ENABLE);
 
-	if (state == 1) {
-		/* Latch is always enabled when enabling interrupt */
-		value = BH1745_INTR_ENABLE;
+	/* Latch is always enabled when enabling interrupt */
+	value = BH1745_INTR_ENABLE;
 
-		switch (chan->channel2) {
-		case IIO_MOD_LIGHT_RED:
-			return regmap_write(data->regmap, BH1745_INTR,
-					    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
-							       BH1745_INTR_SOURCE_RED));
+	switch (chan->channel2) {
+	case IIO_MOD_LIGHT_RED:
+		return regmap_write(data->regmap, BH1745_INTR,
+				    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
+						       BH1745_INTR_SOURCE_RED));
 
-		case IIO_MOD_LIGHT_GREEN:
-			return regmap_write(data->regmap, BH1745_INTR,
-					    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
-							       BH1745_INTR_SOURCE_GREEN));
+	case IIO_MOD_LIGHT_GREEN:
+		return regmap_write(data->regmap, BH1745_INTR,
+				    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
+						       BH1745_INTR_SOURCE_GREEN));
 
-		case IIO_MOD_LIGHT_BLUE:
-			return regmap_write(data->regmap, BH1745_INTR,
-					    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
-							       BH1745_INTR_SOURCE_BLUE));
+	case IIO_MOD_LIGHT_BLUE:
+		return regmap_write(data->regmap, BH1745_INTR,
+				    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
+						       BH1745_INTR_SOURCE_BLUE));
 
-		case IIO_MOD_LIGHT_CLEAR:
-			return regmap_write(data->regmap, BH1745_INTR,
-					    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
-							       BH1745_INTR_SOURCE_CLEAR));
+	case IIO_MOD_LIGHT_CLEAR:
+		return regmap_write(data->regmap, BH1745_INTR,
+				    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
+						       BH1745_INTR_SOURCE_CLEAR));
 
-		default:
-			return -EINVAL;
-		}
+	default:
+		return -EINVAL;
 	}
-
-	return -EINVAL;
 }
 
 static int bh1745_read_avail(struct iio_dev *indio_dev,

-- 
2.47.0


