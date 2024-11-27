Return-Path: <linux-kernel+bounces-423919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4409DAE46
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E79928281F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E7F152160;
	Wed, 27 Nov 2024 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JGtuk5d4"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1903202F9E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732737773; cv=none; b=HtbJ+YgBLt7PJ+hicAMX79kKDsR8hJXLk39T++Pt9Egke+yXhxJczyGNMuWKrNc0OY/sIFq8Rzt7oRmQ7/72S8Uy6WKcEuWDipHAgAoMFUGcRLx0wggUofzK68zDf3nQukECtPc+xWPRLo5ovbmtHvPVkif1pPftRPUr+30g9fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732737773; c=relaxed/simple;
	bh=5TCYTJvP2WZJgf7/Y+kXbTufENMjzuYAF//0sF6enLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BVd6V3RXj5OoMuCzuH/i6o/nUgjcl27orPyiRCEBHL6BbBnPHAXKVjOPh/UirmMk4YDYk1Nw+dYTrthFXTH4h9W+1cb4wKQozcV4n2ZiApsJKsx4GlQr4FRt8n6YDBbZi86kbwjkr2mfFCI22DR+cxJsEXeWdE7XWVbpbFjYo/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JGtuk5d4; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29680f21217so129020fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732737771; x=1733342571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JX1ZaR7yBz56VsJHDUjy+OWYMwBynImasSkSTHjxkM=;
        b=JGtuk5d4iFK+Sozz7rCH96Np0VrQIQJmcLviLpR2InbX/NsbKK6N+ZG08+8p9zSHoC
         iJm7z3CY+fE1XRcVkIKvNBEdtjXsNdyXAhZA5pBk7Gm00uRlAxSBlFG/gTsZ/4bZ5euU
         T+TfUVrAmqsQ9Wf2Tw15E+/WUl9/nn5R62GNA1jbJt2AeWR43Frc7UBoeqh5EAieYjLf
         LGh2tdxkLsGVhvRof84VRoLV9Kq9PGirkdfjAn+Le4hC+dpI2fCLQ6Z1vMHl1rR9Z1/G
         LF5pfIci0HYM6KFe8kJbfdcaBlrGPjI7HNa6U8IaxVidRujrUah0R2KYVBF2w9cY4qnD
         k4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732737771; x=1733342571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JX1ZaR7yBz56VsJHDUjy+OWYMwBynImasSkSTHjxkM=;
        b=eRAfJIFM9lylj3bjgCZ2uAFDmRDPvJ9F3SGAJ+ogtEajrjF/5b4X4ZxdgYrAjjzeEF
         xcHwPqSgRrQ/Zky/uq3jYbesnK9Ju2HHfo0/ZlcJkEgjpprDe82MsCWIcArTwBIIR6QP
         rm7K/mfJEeE7jpbrLWHj7AohvzAx+4Q6vjtmjk6b7kxzRVPAcb00VQVJoSPdfpWD9s75
         0ZLdWaLC49Ny3/XEhrKFUu9Lpn2tGk7daMQ+O8cBK7jZice+E/tALz10Gr7h1mesFYVF
         zahOTt/4d/iDHi5iyK/D7X5WyYaKdHsGfHH7cKGtbWT3+MR7dwdHuab6UVV1A5xK/Wdc
         DfUA==
X-Forwarded-Encrypted: i=1; AJvYcCUDfVstqOLrrpnDLK4N7T7x8XhvWcfSn9RMDPh09C4iF8hemNcmOQZKGk3VM9zrUofNfsCtBhpzUhxaqPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKlSF2LE2XRov8hoy/kDOTNlM/Se7oLoCAiU8htOn9e7vXyo75
	iVAK9DfGj+41/L93jVCsft7tqiKagYIb+nIRbyz5vWCD8Yz41+YrBwtmzPffUQSpSJHwiKhuhS8
	f
X-Gm-Gg: ASbGncv4XJrIVny1GlJ0EH0lGGoJ8w+aPG5lz8aKsySNwcIqZogpvWmvWlXybrFjYVc
	gFUkA+9rYDYMSOpddrdxA6zdHagz0JoIEqrPbSY3uS9cQ+x0rtQ7TXRJpIax2DGmqbvC5lHGr9y
	AcOhem7LlHywXegsqvoiz/0xUOgS07UNQ1w5J+AQwYaxqB3cBGwnZKaOnvpQ8Sq5V+de6TAxvW5
	MOoW1RKyoooISF9CFNcyi8L/ECA18KeWYQ6PZ8tGfV52sui+FKfWxp35zIREXwjdFHR27C/+Fye
	WSjdKw==
X-Google-Smtp-Source: AGHT+IH3/JMmldWEvDZI/7pQLqFpG5vO7av4PDKLlt8J4dtgADQfNKl2QcIkx/c7rjBem5arpbItkg==
X-Received: by 2002:a05:6870:819b:b0:270:205a:4070 with SMTP id 586e51a60fabf-29dc400846dmr4279733fac.14.1732737770743;
        Wed, 27 Nov 2024 12:02:50 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d6654e9sm5069542fac.24.2024.11.27.12.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 12:02:49 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 27 Nov 2024 14:01:54 -0600
Subject: [PATCH v2 2/3] iio: adc: ad7173: remove special handling for irq
 number
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-2-b6d7022b7466@baylibre.com>
References: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com>
In-Reply-To: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Michael Walle <michael@walle.cc>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Guillaume Ranquet <granquet@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Remove the int irq_line field in struct ad_sigma_delta_info and all code
that referenced it.

This struct is intended to be used as static const data. Currently, the
only user that doesn't uses the static const struct directly, namely the
ad7173 driver is making a copy of this struct to be able to modify the
irq_line field. However, this field is written and never used due to the
fact that ad_sd_init() which reads the field is called before
ad7173_fw_parse_device_config() which writes it.

The runtime behavior does not change since ad_sd_init() was already
(unintentionally) being called with irq_line = 0.  But, even though
this could be considered a bug, the behavior was still correct. The SPI
subsystem always uses the first interrupt in the interrupts array from
the devicetree and the devicetree bindings for this family of chips
specify that the RDY interrupt is always the first interrupt. Therefore,
we don't actually need the special call to fwnode_irq_get_byname(), so
it is removed in this patch instead of moving it to the correct place.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* Fixed chip name is subject line
* Uwe's comment made me realize that the special case was actually never
being used because of the ordering bug and could safely be removed
rather than trying to preserve it.
---
 drivers/iio/adc/ad7173.c               | 8 +-------
 drivers/iio/adc/ad_sigma_delta.c       | 5 +----
 include/linux/iio/adc/ad_sigma_delta.h | 2 --
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index c83c4c90b090..52fce43e4ce1 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -199,7 +199,7 @@ struct ad7173_channel {
 
 struct ad7173_state {
 	struct ad_sigma_delta sd;
-	struct ad_sigma_delta_info sigma_delta_info;
+	struct ad_sigma_delta_chip_info sigma_delta_info;
 	const struct ad7173_device_info *info;
 	struct ad7173_channel *channels;
 	struct regulator_bulk_data regulators[3];
@@ -1398,12 +1398,6 @@ static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
 			return ret;
 	}
 
-	ret = fwnode_irq_get_byname(dev_fwnode(dev), "rdy");
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Interrupt 'rdy' is required\n");
-
-	st->sigma_delta_info.irq_line = ret;
-
 	return ad7173_fw_parse_channel_config(indio_dev);
 }
 
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 2f3b61765055..38c48743712e 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -674,10 +674,7 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 		}
 	}
 
-	if (info->irq_line)
-		sigma_delta->irq_line = info->irq_line;
-	else
-		sigma_delta->irq_line = spi->irq;
+	sigma_delta->irq_line = spi->irq;
 
 	iio_device_set_drvdata(indio_dev, sigma_delta);
 
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index f8c1d2505940..44f487323a43 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -52,7 +52,6 @@ struct iio_dev;
  *   be used.
  * @irq_flags: flags for the interrupt used by the triggered buffer
  * @num_slots: Number of sequencer slots
- * @irq_line: IRQ for reading conversions. If 0, spi->irq will be used
  */
 struct ad_sigma_delta_info {
 	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
@@ -68,7 +67,6 @@ struct ad_sigma_delta_info {
 	unsigned int data_reg;
 	unsigned long irq_flags;
 	unsigned int num_slots;
-	int irq_line;
 };
 
 /**

-- 
2.43.0


