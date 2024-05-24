Return-Path: <linux-kernel+bounces-189093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3CF8CEAEC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F35B281BFA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5142D7E574;
	Fri, 24 May 2024 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0vWAcJk+"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6557A74407
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583092; cv=none; b=QrDNf+VoFhnMKqNLf6c9B54pkRLHCkVjPrBIzwXGvnngLN8JugdIagHqFR2cxEsy8w0k54HUXDwwoNMh9QDTQlfWl/60LulKSoHtkZ0VBrRJ61sST3ggFeq5c7ltDO47yK9rpneAGohgJx+7g9lpcRQTJFsdAFv1jyE8R4h9vR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583092; c=relaxed/simple;
	bh=8j8OrljIvFu2Et9RmLk4iAykmVaiaUh+gf8m1koNlGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aHk8kis/IdXste8au/mR7OhcI6/rMPzYOg9nJz9beunxogplsGCvOrIu4h5qttm3lKs3FIekzqwSeIxQDBvv7oOwmAYq8xuLALC6x6bVjdbUypJ//3ALf/DCkBYjJIBgcSjSI97qar4ditZfQOLC0yz4kqDcWnfNcFhZ6E0Q5UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0vWAcJk+; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b970a97e8eso616020eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716583088; x=1717187888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lAb0yvkmRIH2YjR8NuuhLY/irhuLspeCDPAA3a0v6HQ=;
        b=0vWAcJk+F10usFchgUjSpXLV+xvskFn8rkrSKiMLxogM9VO8QeWEgquyyCMnMGgSCX
         IBAe5VowWqBeDyFBqrOlB0tRhfblPiM03bIK5Pi65XRJKzSp7tNtPXY0EXxqoTGoR62a
         x9p3vwe69a7Vg2ii9b6l7YVWLZwxei6UWpaRbsBVUuoQ5t1fZdmN7/BdfFzJZvYX3+1V
         Uow3AzyRGl9dm/pM5TrpAYy42CaByI3asakFgTgPOrK93uMgEcyaCq+meceASolpNqHH
         GiDewN2YpCgtYg07OB1DTZnT9AfbysTgivd56Dh+MKBZ7evUqihWnwQVLvAwKvaXEGmz
         VCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716583088; x=1717187888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAb0yvkmRIH2YjR8NuuhLY/irhuLspeCDPAA3a0v6HQ=;
        b=wCsO1FqZVkiBlRSrVgZQLFboujrfmsUrQLSeiykIsmvjTr8IIjgkRWbS6Bq1V24dZW
         w3zJ2GpbB2p/F5QgGF9AP0qblFH6eNrCYotwukts7Dy4pByyEso4nhmhd76S5Se3ApuQ
         O5NlqY/4pdW0LvyreMcE2OKtnYdVbvdSp+035kbaUFphErm+SdHTVEw3JAHNEg0gY3Y0
         ZAxXLOfipTjCMg2zCQuG6gZbR70Isegx/K1d4DN1MP9H4DE5xfJcGQrq0yPrLSEzpZdE
         nGjlvoMwX+56D2l31DLtOVzwYgnKm0oXq1h5t3k2QF3Dz5POa5X6hJg5epNqWQ24zY23
         aMwA==
X-Forwarded-Encrypted: i=1; AJvYcCU/8FmXAf3CBV0u+N8Hhs7+kG8Tvi8clUc4PZEvwv/6srPGN2EKE/QrC82aPXhh2Cy3j8piLskvSkClhBRdPCDfcCmMyGc6ZZ8923lZ
X-Gm-Message-State: AOJu0Yxy541gZvKrsH4kt1WaAbP5/JGf+1OzkQEL0EFMnwVFvv/wCAwl
	HKlEtjur+guAhLIXyoBoKiNFAl9Gpq1UfjUmFiWJwFCi0fzoUtuUUdIX15yC804=
X-Google-Smtp-Source: AGHT+IFmcO1B730qZOExe18PR3yCsMK8Mp4TMxtezp+Z3SNVkxkF/bovPBgfXhsG6dK5UxW31fHKTg==
X-Received: by 2002:a05:6820:603:b0:5b2:ff69:97c3 with SMTP id 006d021491bc7-5b95fe9c7b9mr4391373eaf.2.1716583088547;
        Fri, 24 May 2024 13:38:08 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b96c462871sm480285eaf.1.2024.05.24.13.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 13:38:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ad7944: remove unused parameter
Date: Fri, 24 May 2024 15:38:04 -0500
Message-ID: <20240524-iio-ad7944-remove-unused-parameter-v1-1-fd824d7122a0@baylibre.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

In the ad7944 driver, the ad7944_convert_and_acquire() had an unused
`chan` parameter. This patch removes the parameter.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7944.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 4602ab5ed2a6..e2cb64cef476 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -259,7 +259,6 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 /**
  * ad7944_convert_and_acquire - Perform a single conversion and acquisition
  * @adc: The ADC device structure
- * @chan: The channel specification
  * Return: 0 on success, a negative error code on failure
  *
  * Perform a conversion and acquisition of a single sample using the
@@ -268,8 +267,7 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
  * Upon successful return adc->sample.raw will contain the conversion result
  * (or adc->chain_mode_buf if the device is using chain mode).
  */
-static int ad7944_convert_and_acquire(struct ad7944_adc *adc,
-				      const struct iio_chan_spec *chan)
+static int ad7944_convert_and_acquire(struct ad7944_adc *adc)
 {
 	int ret;
 
@@ -291,7 +289,7 @@ static int ad7944_single_conversion(struct ad7944_adc *adc,
 {
 	int ret;
 
-	ret = ad7944_convert_and_acquire(adc, chan);
+	ret = ad7944_convert_and_acquire(adc);
 	if (ret)
 		return ret;
 
@@ -361,7 +359,7 @@ static irqreturn_t ad7944_trigger_handler(int irq, void *p)
 	struct ad7944_adc *adc = iio_priv(indio_dev);
 	int ret;
 
-	ret = ad7944_convert_and_acquire(adc, &indio_dev->channels[0]);
+	ret = ad7944_convert_and_acquire(adc);
 	if (ret)
 		goto out;
 

---
base-commit: 6c46802cc0c4ff878f07139f7b7b8774fd43ce3d
change-id: 20240524-iio-ad7944-remove-unused-parameter-d814bb7e1a28

