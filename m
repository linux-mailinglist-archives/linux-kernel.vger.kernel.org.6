Return-Path: <linux-kernel+bounces-204468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C838FEF80
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED141C210A6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB8C1ABCC2;
	Thu,  6 Jun 2024 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TRI1MRzw"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8801ABCBA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684030; cv=none; b=QrvlGqFU8vk5TSPDjvVLnp23Jhnz6v8mtzZmtTbkSpkq5UV+gkfaiX8l9RRvfCzCCe0nY0MUBOuRP+ZK5Wb80KtyToVv3c7QrwPmYAvLblhtF+h+3mcyuk67jeKiSmEdKz0YAYXDCdQ6rJei9mQ2IVTHvUaPLThb05pKESeMp4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684030; c=relaxed/simple;
	bh=CC5VrVQlrTO5Z/KVeJTa7No+6VHuZqxo+QMeYJcB7JQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Py4n1MtlUaXRvTTi/wwZRPKILVqByf3EXWGd8ip7ybveBJvzIbYfwCZ4QTS9xTE2rZQD99zKcQHy13jMn0+kGlW2r51s5HUM2zzMeJLCPlLhdHxLi0ByIRUsusvrOZ7N7URGOQnWnh9pKr9NVKk53mv6EW7LFtcJHQnZEzrk/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TRI1MRzw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-421555a4454so10706445e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684027; x=1718288827; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4axVnQS/++Nc2i+YUJICxGzNngB4GBatJqXLma6H1do=;
        b=TRI1MRzwuXxen/ja6VVAZyz4GVSGfC+hcdk4D+X2lNz7ZKw/osWR9ofS87awfzDbza
         tSAE73pLNUeTtFN5paPnYGzqw2HYOylRRcmlpH1X7GQO2goVAPoUentBjz479Xm3QqVz
         Q6IcgakLsSIIJPTiPMFeiT/vEfBGN9B8p48Zn6hnjh630OhbVgwrNRU+cdIn/QMS39lj
         dwuV+ShQ+FW9ripKun3ryB7wYqctSMH5rwM3+FGJ7ROGo32BYePjM5Ch5VjI9W9iqFrb
         y5egFn0YcQvjmdEaIXxT6C8UPlFKWRLCNTIZSlVVrtQo4ZbCXyNWHBtnGDPNbGcEmVK8
         PRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684027; x=1718288827;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4axVnQS/++Nc2i+YUJICxGzNngB4GBatJqXLma6H1do=;
        b=AWw4hurR5+YW4D1aEs3Bw2jU3G/TagKy2RatyTAW+Rdq5OPVZ/SnwIjsoYe7c3+mb1
         MsFy2GLfm/IR8DhoBVZC3CyC7fAqegmcHrSeJlNBywDmsU6uwxVRxmpV/n49iLfHj7Jw
         whK8fGTU6ciuvterb5KY7W+ls6vnoZbejt0yT3MiPh2jll1v/FSPKzohS3RajwNQJWHJ
         F1kMO0yHqV8DmhZZzc5kK4Mk3yYrTa1dXWeERRwVDx4ZP1/3Fd/3OOL0zsZGDBrc7tIN
         IMdajcNWIVyK/bHCJIx4G9/ErfqzprKJAy8jhD/057jHBzI7IxQbb03HCtf2C6QYgK6u
         sHmg==
X-Forwarded-Encrypted: i=1; AJvYcCVl+KfKWa0sQeAczGysbRE0I0LH7ZVbgG/AiekUEPSiFtrdfN9i/lpgwI7z5s8tRBSICizWXS2qgIk/1+h43YRIV6Hly+Cdps//V9gm
X-Gm-Message-State: AOJu0YwdrSS2xh/qXvDmjxg5o+fnJxevver9/MBikiOjarhUkI3MFx/B
	+w254Z8pcjdg+E55Bz3T09Kgl4uNRjwlc/fhdSzGfWgBS/c1yGQ9wMGdJaWKL8s=
X-Google-Smtp-Source: AGHT+IEJuwTCqX5RmDMAu5H/s3UUPo/3WRLZMXx7hkYvhTFJQcrS94uqo4MpNpYTZie9aiFibV3T4Q==
X-Received: by 2002:a05:600c:4fc7:b0:416:88f9:f5ea with SMTP id 5b1f17b1804b1-42156f4b8c6mr49523655e9.34.1717684027112;
        Thu, 06 Jun 2024 07:27:07 -0700 (PDT)
Received: from [127.0.1.1] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158110dfesm59158615e9.19.2024.06.06.07.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:27:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Jun 2024 16:26:49 +0200
Subject: [PATCH 7/8] iio: dac: max5522: simplify with
 spi_get_device_match_data()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-spi-match-data-v1-7-320b291ee1fe@linaro.org>
References: <20240606-spi-match-data-v1-0-320b291ee1fe@linaro.org>
In-Reply-To: <20240606-spi-match-data-v1-0-320b291ee1fe@linaro.org>
To: Lucas Stankus <lucas.p.stankus@gmail.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Ramona Bolboaca <ramona.bolboaca@analog.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Marius Cristea <marius.cristea@microchip.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=CC5VrVQlrTO5Z/KVeJTa7No+6VHuZqxo+QMeYJcB7JQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmYccu027SZwoUudm2dp63YPEyNKqqdVmF869JM
 n+uLe24iweJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmHHLgAKCRDBN2bmhouD
 1xObD/9qSysP2WI4q0hMcptlW7EFePOZrF++EfQ+AE/5yTeXHKbTaJkBvj+Kmcl/LLjKk/e1tUL
 g0uQzmz4uJbpSbitTdg41vQjan6IO0pbMG7jgsED2+FawWLIS8Yr9ezPNLhTbC43Pvam0z4FCbd
 Hg5uHWPGIcrCk/fp/a4QqiWZ+2e96Fvx2fiz4effSx/aNSNQIxfFGaafgOmsgulBshuLqLEZHBq
 7WdU7sOqjhoTi1cqE6dMiFvox75AG8LBz61PB59cBaR6DnU10grrcbfkEVrTJB+p6M2qQWt+DTE
 jIvf6IUY5kkJHIky/lDT8XCRBZ+pqBQmAejuWkQUQyoL4npkhgj1BCJRdSFSORevWmd7Hih4Ia5
 VIUF2ItM/bAgWt5vfpnXCyl3JOIysR8GrYK8Hl2FI3vYBy43nie/H4lwg1cK4TU1f9Ixp37/gdI
 UpReTNB9LulcYk/LUZsd/6sLJAhxPROIobDZXaN4zGnb6gNdS2C/4+c6NeP3M3cA3IXHEnIocpl
 DOC3k7CM63Y4Zequy3ms/9kgErj32ffPzfKwKFLGrbsuZYlvB6LtGy+OLBOITSuIB0wwG/bU0J6
 zlCCef81qr9wI7zMcbNpE763rcsrzNHqHcvy+fHshDUafrHMEZZmTCrII3enFNMsIjVV2ZyeuPY
 gf+3ZElYe0SEYTA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use spi_get_device_match_data() helper to simplify a bit the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/dac/max5522.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/max5522.c b/drivers/iio/dac/max5522.c
index 05034a306597..9f72155dcbc7 100644
--- a/drivers/iio/dac/max5522.c
+++ b/drivers/iio/dac/max5522.c
@@ -132,7 +132,6 @@ static const struct regmap_config max5522_regmap_config = {
 
 static int max5522_spi_probe(struct spi_device *spi)
 {
-	const struct spi_device_id *id = spi_get_device_id(spi);
 	struct iio_dev *indio_dev;
 	struct max5522_state *state;
 	int ret;
@@ -144,13 +143,9 @@ static int max5522_spi_probe(struct spi_device *spi)
 	}
 
 	state = iio_priv(indio_dev);
-	state->chip_info = device_get_match_data(&spi->dev);
-	if (!state->chip_info) {
-		state->chip_info =
-			(struct max5522_chip_info *)(id->driver_data);
-		if (!state->chip_info)
-			return -EINVAL;
-	}
+	state->chip_info = spi_get_device_match_data(spi);
+	if (!state->chip_info)
+		return -EINVAL;
 
 	state->vrefin_reg = devm_regulator_get(&spi->dev, "vrefin");
 	if (IS_ERR(state->vrefin_reg))

-- 
2.43.0


