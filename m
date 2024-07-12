Return-Path: <linux-kernel+bounces-250882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A4692FE1B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230451C21639
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106AE17557B;
	Fri, 12 Jul 2024 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XADlh/Ml"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A817622F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800249; cv=none; b=h246FTkydE3u8XOY19q/su3xskm7a7RMzh0V7Km3RxkqRNgCQQ+2XXmRrb+wvEVYN/N0Js9CpDQ7a5ukOScMYYChS1zW6wjR4yaYXoxeFydVdgTL7DphcXuhaw1/+c0uhWfdnvuDKQTSdOXrIq4a0q79ILQ8+NstPCBagwX7frE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800249; c=relaxed/simple;
	bh=jcbI0ILmzg2rz8ajY9fDpFx5bxGc9dBImltD76qGtXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I506oqGvfnF2AReoVklFUegUgvUgSANul3viLLcJL23cGb8R8KPz7L+Zy0jxCEQxl7HdqXJCf69AMTczQOFxDOczyKM5t5AS0xFnu/Or4s9Ap+Hn4i+2USehxAAmWTtLVddS6+JN5d0rLsuYhzZoSjP56M4Sp+iiWGb46t3SX6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XADlh/Ml; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-703ba2477bdso1037463a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720800247; x=1721405047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60eUVwKVeZ7BrLO6pxv9nbYIZ9oGCgCB8H4hO/TeI/g=;
        b=XADlh/MlstSnuIy9Po0NBK6gB/5MwLA2JBwujo5/dxAw6HK0PCWcxbpCuQbYr9lAi5
         0H33dyyCBQ2Sh4TlCY5zASlVDiQSwtO0/Z63h5e0evVqQMXRuk0voySi52RFC6M/fjv4
         Yl+tMyWXs36VMO3BlJRCfGiyIcbVRC99BQieuhqLE49y7jzQ20VtPMVN9cUigcnV9/6F
         2mgqm9Mz7ZY3BtRzObZa2u+5Sjj47f/PzIk2vz4CQ9TLsJvJRoB9LiPgYGNCcKbd8s3U
         iuS9s/N/hZtvLJVMexCHFs2cSu48EcWtl3u6ximw+xehO740PWhBn6RK5lnhZ8FoOwLe
         iufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720800247; x=1721405047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60eUVwKVeZ7BrLO6pxv9nbYIZ9oGCgCB8H4hO/TeI/g=;
        b=GO9sby822n3/WYkZtaleN6nwW0froQN96sDJVhOxutnwNdxrTLXuj1ir3qsRc+fbmy
         LhiApPEy/Xqs6TtYUMhHCxg0TZIExtfo6UkA5J0ooFBfkHkHMT2ICPT/0MzFUFQIWLyQ
         He5fFUSQc2b1LQBkOpOsnlCUqXMLmhC/pmKKm8Rb9IO/Hxc6k8w7HG4gYHvuIHt27f1j
         kuseuZCsERsu12xoHZE2SznHg37a+wvMQrd+GgaHgkcYSTgoU06pv0aBg4Ob7p8N82oT
         viCPfIBYbClMG3IiEZRjzCVOl77BvckyKvgQWLjxEcIcTj94JYg3chsqs+yaZDHIAG16
         CcIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlahOXhBMoxYpYPNZdoxcgA2b4tTpr8sJTQMU9OoYUOFEP7IwfDktvTHREm6s2mb7b+50AjupQqieqa8Y+/NVNnObhoyZYIkmF5ynJ
X-Gm-Message-State: AOJu0YxdRo/G9Q9TuJF9licF1Pv4xXxF90Od320FEs+gnleaI6JqH1JD
	0CvEGblEelPMdN6P06pEHq2iR9PHDgkwrLRs4uQTT+3bfpGt7hlAbNmCbOAqTPzrrqkQKSpRX8X
	A
X-Google-Smtp-Source: AGHT+IEuQNhkpjMbmrtQ5ogRBVhUZBpJ4I4zgpDiKAPbDUpxqOcQNOVerUGUqq5HZO5btAfIiNVRjw==
X-Received: by 2002:a9d:6a56:0:b0:704:45bb:267f with SMTP id 46e09a7af769-70445bb3223mr13140566a34.5.1720800246613;
        Fri, 12 Jul 2024 09:04:06 -0700 (PDT)
Received: from localhost.localdomain (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f78d35sm1615131a34.23.2024.07.12.09.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:04:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>
Cc: David Lechner <dlechner@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] iio: dac: mcp4922: drop remove() callback
Date: Fri, 12 Jul 2024 11:03:55 -0500
Message-ID: <20240712-iio-regulator-refactor-round-3-v1-4-835017bae43d@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
References: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

By using devm_iio_device_register(), we can drop the remove() callback
in the mcp4922 driver. We can also remove spi_set_drvdata() since there
are no more callers of spi_get_drvdata(). Also use dev_err_probe()
while we are at it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/mcp4922.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
index f89af70fa5af..26aa99059813 100644
--- a/drivers/iio/dac/mcp4922.c
+++ b/drivers/iio/dac/mcp4922.c
@@ -138,7 +138,6 @@ static int mcp4922_probe(struct spi_device *spi)
 
 	state->vref_mv = ret / 1000;
 
-	spi_set_drvdata(spi, indio_dev);
 	id = spi_get_device_id(spi);
 	indio_dev->info = &mcp4922_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -149,22 +148,13 @@ static int mcp4922_probe(struct spi_device *spi)
 		indio_dev->num_channels = MCP4922_NUM_CHANNELS;
 	indio_dev->name = id->name;
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to register iio device: %d\n",
-				ret);
-		return ret;
-	}
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "Failed to register iio device\n");
 
 	return 0;
 }
 
-static void mcp4922_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
-}
 
 static const struct spi_device_id mcp4922_id[] = {
 	{"mcp4902", ID_MCP4902},
@@ -180,7 +170,6 @@ static struct spi_driver mcp4922_driver = {
 		   .name = "mcp4922",
 		   },
 	.probe = mcp4922_probe,
-	.remove = mcp4922_remove,
 	.id_table = mcp4922_id,
 };
 module_spi_driver(mcp4922_driver);

-- 
2.43.0


