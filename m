Return-Path: <linux-kernel+bounces-408304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3523F9C7D31
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 710CDB2704B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B352076B3;
	Wed, 13 Nov 2024 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fTXpgNMg"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A726A205ABD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531189; cv=none; b=NfNOARYg8wu2qjtLXIUhOE4u0znqFRO8u0jJgR3I+suyj9LEC24byAzCdRQqYM3N6Hlcoi1nFp97m77ErKrDyWQLdD+D2t4cemNY+h+vRF6gdNbKT8ZlKn3zV21qoQXy+s+oFpOm8YHEO3aT3bgezVLsEzyXkvFz0K2dRuAqomQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531189; c=relaxed/simple;
	bh=usxnLSOifC75UUbscRAQm9vBt1XSyQeNy/RrQ8fENrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cEc6Gh6JGcfIwC9b3yXd+GSIRuIxiqh1KFIfeeA75oPsEqKyrmU9Bypg+r9frgx6M0MibdAiEHaIPtzqJgg3D4PVmi6awJmxjwxnFEfOQM1laP6ghZPw7vtmO6Uu3xiQcGZX2flefTiHATcOQuhG3K0f6vQohrFCDfSKINf86e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fTXpgNMg; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbcd49b833so48169576d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731531186; x=1732135986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITogGBSwNSbrmJAZixpXgO1FJBpp7STOlbU6R2lyybE=;
        b=fTXpgNMgiVAthfGxCj7joIwTxK9auxbn9ZbaU2qXjnRJeuaxY79PSIIffCCdfJQ/t0
         nyH4tccmAUpGhkQhxe7RxhVBDT1jaSHRvHwW1nfPCsLAoMN4HkZLbmooIClCAaJHryd1
         3lVn3VBXgsFe9UsmrE4g5lRKJdLeIWOH3a49nYZ740nQJHgaKFi+ykdI+EvmMpPqRsfD
         ADtMmMqShxSPnd0scGqzeH//BfV001mFQEUiA9VyzRWPEfEYzx2F1PK9lbq4C/HYzVGw
         qp+BX00jHr4JXlewPaArbp5TYSLTJ5KuKIalHfMH2O808/pMxlX9Oc8VcNfQ+6CARzPV
         vMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731531186; x=1732135986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITogGBSwNSbrmJAZixpXgO1FJBpp7STOlbU6R2lyybE=;
        b=IxCsERxhcdes73CneAOfIZ7I/utUf70U4uFp1cYVk3kupgvD3UyZ/lDuuIgq+vajpm
         7d3fcBO0ILxiIH5vcYaWz7ZGGcoAjjtUnCzbgyaacqTGIM7mAdES6Gu9biLyrkVl9Xa8
         XaJXJp6y9MALoyKJKb8AY3Z4g9snuSaJooTiMpEPjSnPb7knNZnoxM8B4fVJF3zvwDDx
         c3HNm+pQnnKRZBqWV1DHJyyMB73YcjKXnIApHtjAHnPNEAc14+PldjNMMlgkzp/fMz5a
         Byblxom9n3pmDqMgp6uNt0HiwDA1/5SHLdegc/agVvENThR0Gt0sWRFkKV41N6U93l2x
         ddBA==
X-Forwarded-Encrypted: i=1; AJvYcCWRo7PrXZFPvRkqTrY7YlObuu4uPDd36vsOaaDfEb4od4gXd3ytXzNpu88bdKhJd+IDZvwFs8D/tv2cKTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBlAFBWKUGIp5//yoDkJtY+mAIKpZUAiYIoSODWMj7aCTBY6LY
	9U1Y5ImFOEnPSYPGO+1fORnXdnhlaRo/hKNZPYW4dM3Sd2Kx2WnuMNsGevv/vtg=
X-Google-Smtp-Source: AGHT+IFDgRdfRwbHfCGhimMOMUXkC66ocOQWIyw72aM4GlMmOQLibfUV596pHenrKWvqiaZX5Xuoyg==
X-Received: by 2002:a05:6214:3290:b0:6cb:f87f:f073 with SMTP id 6a1803df08f44-6d39e1078dbmr293135896d6.6.1731531186505;
        Wed, 13 Nov 2024 12:53:06 -0800 (PST)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961df2f5sm88829336d6.2.2024.11.13.12.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 12:53:06 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Wed, 13 Nov 2024 15:52:59 -0500
Subject: [PATCH v2 2/3] iio: adc: ad4695: make
 ad4695_exit_conversion_mode() more robust
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-tgamblin-ad4695_improvements-v2-2-b6bb7c758fc4@baylibre.com>
References: <20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com>
In-Reply-To: <20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

Ensure that conversion mode is successfully exited when the command is
issued by adding an extra transfer beforehand, matching the minimum CNV
high and low times from the AD4695 datasheet. The AD4695 has a quirk
where the exit command only works during a conversion, so guarantee this
happens by triggering a conversion in ad4695_exit_conversion_mode().
Then make this even more robust by ensuring that the exit command is run
at AD4695_REG_ACCESS_SCLK_HZ rather than the bus maximum.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 0146aed9069f..4bc800293e60 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -92,6 +92,8 @@
 #define AD4695_T_REFBUF_MS		100
 #define AD4695_T_REGCONFIG_NS		20
 #define AD4695_T_SCK_CNV_DELAY_NS	80
+#define AD4695_T_CNVL_NS		80
+#define AD4695_T_CNVH_NS		10
 #define AD4695_REG_ACCESS_SCLK_HZ	(10 * MEGA)
 
 /* Max number of voltage input channels. */
@@ -364,11 +366,31 @@ static int ad4695_enter_advanced_sequencer_mode(struct ad4695_state *st, u32 n)
  */
 static int ad4695_exit_conversion_mode(struct ad4695_state *st)
 {
-	struct spi_transfer xfer = {
-		.tx_buf = &st->cnv_cmd2,
-		.len = 1,
-		.delay.value = AD4695_T_REGCONFIG_NS,
-		.delay.unit = SPI_DELAY_UNIT_NSECS,
+	/*
+	 * An extra transfer is needed to trigger a conversion here so
+	 * that we can be 100% sure the command will be processed by the
+	 * ADC, rather than relying on it to be in the correct state
+	 * when this function is called (this chip has a quirk where the
+	 * command only works when reading a conversion, and if the
+	 * previous conversion was already read then it won't work). The
+	 * actual conversion command is then run at the slower
+	 * AD4695_REG_ACCESS_SCLK_HZ speed to guarantee this works.
+	 */
+	struct spi_transfer xfers[] = {
+		{
+			.delay.value = AD4695_T_CNVL_NS,
+			.delay.unit = SPI_DELAY_UNIT_NSECS,
+			.cs_change = 1,
+			.cs_change_delay.value = AD4695_T_CNVH_NS,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_NSECS,
+		},
+		{
+			.speed_hz = AD4695_REG_ACCESS_SCLK_HZ,
+			.tx_buf = &st->cnv_cmd2,
+			.len = 1,
+			.delay.value = AD4695_T_REGCONFIG_NS,
+			.delay.unit = SPI_DELAY_UNIT_NSECS,
+		},
 	};
 
 	/*
@@ -377,7 +399,7 @@ static int ad4695_exit_conversion_mode(struct ad4695_state *st)
 	 */
 	st->cnv_cmd2 = AD4695_CMD_EXIT_CNV_MODE << 3;
 
-	return spi_sync_transfer(st->spi, &xfer, 1);
+	return spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 }
 
 static int ad4695_set_ref_voltage(struct ad4695_state *st, int vref_mv)

-- 
2.39.5


