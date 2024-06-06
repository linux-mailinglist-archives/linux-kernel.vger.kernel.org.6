Return-Path: <linux-kernel+bounces-204469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E974C8FEF82
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E171C20E20
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E95C1CC6F8;
	Thu,  6 Jun 2024 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVYzO7F1"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56651AB8FB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684032; cv=none; b=IuH0IHvs91haWm2K7NGVDuG2jQKTeVLXjky8jhp5WDKxHo+lWzTKgaHYPMzNuzh1F4PDbTLqVxWUm4X39M2y2FI+EGYld27EopcN4MaVBO9ole5xBwZUINKT1rRZ1hCfRGnqaQ8JGCu7U4z88DwXBIdNnRHbCYMoc0Nyk8RF9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684032; c=relaxed/simple;
	bh=/Drt9DvPT3iPacr8BHFd0FnwQyhtB9dBAHbphjiKxpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bNRClPZ44R4NRBG2Nmvpolpg5lx5tv0W5iZinOse6hK7qUZCWn3z9lJPr0xD9bIixdyr5AWnzkLWIYSqAmJl/txFKQz2w8CWvGjjTLlHVavuL8vWNo0XddzKOcFYOfPJQRP9FLJYZxVgiJlzgJ3PKMFqsNC9cbLbT2HOpJAaRS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bVYzO7F1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421208c97a2so10450585e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684028; x=1718288828; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+ON/wkAKBmuxABFUuc+U89h1GiBlQq9gib75ECTHco=;
        b=bVYzO7F1Du7O1daD7RRXQ3THaYiLXy8YZEXQFEwJKBXJvG0A07An0FeUlIbBE0UVVX
         PBJh8V8DF/yf9Jw9a9avTbyfJ2sodRNj0cwZXK5oIEGq0Xtom1T9mCEpGCbnBRTM3IF5
         SLLU4fJuHDGMddR5wTUvwp5XTxn0s1q4XDmbp837ok9kqkNCdhqQLUyqNebzzVZZQLWW
         xn4Tve2QojzRMxCc4hLP1cao7U153Nu+JWyoMAARlglfPfhMftQdVQ64JZyvN4h9TCxz
         2ZdFDK1ASZEsJiPxB6D5XpGb6IA1FOc+9x96eMRhrbtL2sfa+kJIHxZz+sIaeyh2vVZM
         kF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684028; x=1718288828;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+ON/wkAKBmuxABFUuc+U89h1GiBlQq9gib75ECTHco=;
        b=AuwgfzL+eC4gFBtT9XJsmyLVqQbUfQT5uR1Rw4ld9wkXXwFb0C068tspOEf8fN9fED
         MXC+ZFcDNANci87+HDHKqLvtd1to3p/cIDhr1ibZn6VoSXT2vNfxP+YCdTxPROwxJLAJ
         YK5sjMZmgFqJ1Bz6YwelPYuLuc2h5AdclEbTf3OTGcCKlvrgZBJG6QmLYzNld28xwEkm
         YT8uOeRk1po0jqBicOpkYM57cXAyHcgp84BFij6BdtKo9M01MWTqvuc6lIruytzc/K4V
         e5zTikrRPJo6N3EOUuRBIa8Kwl4hIiRsKljl6cyJDWlQe6/A5r7L8G0yV9MH6GTv35Ge
         W24A==
X-Forwarded-Encrypted: i=1; AJvYcCUGnJsRIUNwP5Girqsv3DBBHw8PyzmONzkfILxUoiIXsxn9OjFGr1Wktj6+bV+UA8WKCoQ+0vxzxklRAwWzJ/Us7lYiBGgFwQtw6XGE
X-Gm-Message-State: AOJu0YwvblKQU8BiDZV4zO7vBUTPvUUpwT0gJ6BOsr6YT2OjWz8HICv4
	TEZORNj14+qwHFMG1//8Hm5a52CQNQh3Ws+3gkvv52vaH/iJQUNOHIgcJqNLmy8=
X-Google-Smtp-Source: AGHT+IHyBXsfWnnY+dpEOaBk06feEQHV0wQw4MfxmfB1QhpJtZsLeUZjAg5UoLph3AgS1uzeBqFuPA==
X-Received: by 2002:a05:600c:3550:b0:421:5288:63df with SMTP id 5b1f17b1804b1-421562cf734mr52054265e9.11.1717684028385;
        Thu, 06 Jun 2024 07:27:08 -0700 (PDT)
Received: from [127.0.1.1] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158110dfesm59158615e9.19.2024.06.06.07.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:27:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Jun 2024 16:26:50 +0200
Subject: [PATCH 8/8] iio: adc: mcp3564: drop redundant open-coded
 spi_get_device_match_data()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-spi-match-data-v1-8-320b291ee1fe@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=/Drt9DvPT3iPacr8BHFd0FnwQyhtB9dBAHbphjiKxpg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmYccvHAlB7a2d3uml14VcNQVQcno4MG62juiap
 AWDoGyQoZKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmHHLwAKCRDBN2bmhouD
 18N/D/4zmNIBRCfaS+X2Tbqwv0wbam22Rj0rrVINzmy+8LpDrghxyf08QLn/Y9TNBPqrBewXpZA
 3b8NtJWnJT+9LWPcIijpn/z57vsqvUfsLOKG70OEjRPf2TUZoluuZCDmG8QYOJYoOe4TiknvtDi
 lpLbQBfz8g+wdBF8n0G5tVzpeJBA6ceAfVFjsDGCmfDDBP2otzWGeuaQJhz02T6UmRJC/6T3zzr
 suZiC1Qs/IwbkYq41nYtGwpuQQizBzphqP1iArF6Nj33n8uwFAdaSQCPc+y4y8H8DEj27KUu2gA
 r8MFvX2xp3lRAJQCG9P3hBPPA96q0I6MLH3SthtYQZdv05LiiS8dNQqPmHm3iZk342VbzgeaImC
 fhLryLpkM1zinqavJZK/A5P8xqD/0knwtT5G0jWxOUT+CTvNc/GwZlQtujMsR7CZm06IIt/MOx2
 aga7/XXj0w6bJpejyytriRYraKR8qApQZR2SrS50n1DgAa/Pbzp5DShbAZnvTQd4c4407gNLJhW
 3BfUjs+6vjqq95rT+fooFe/y/3nWnYrOevIfnLKVm1sjhTTEFDoRTLUow1splnX+QjcTfOCRKdJ
 ExdKlOLy6yNsQ6063IN+yWp/3mgv24eFF+xXmVqRpQfDhtDz3ajSw6OhRWYoCS0omqA3FG+3xOc
 1z6rbxXttNnF6iw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The driver calls spi_get_device_match_data() and on its failure calls
again parts of it: spi_get_device_id() and getting driver data.  This is
entirely redundant, because it is part of spi_get_device_match_data().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/adc/mcp3564.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index e2ae13f1e842..d83bed0e63d2 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -1114,7 +1114,6 @@ static int mcp3564_config(struct iio_dev *indio_dev)
 {
 	struct mcp3564_state *adc = iio_priv(indio_dev);
 	struct device *dev = &adc->spi->dev;
-	const struct spi_device_id *dev_id;
 	u8 tmp_reg;
 	u16 tmp_u16;
 	enum mcp3564_ids ids;
@@ -1212,11 +1211,6 @@ static int mcp3564_config(struct iio_dev *indio_dev)
 		 * try using fallback compatible in device tree to deal with some newer part number.
 		 */
 		adc->chip_info = spi_get_device_match_data(adc->spi);
-		if (!adc->chip_info) {
-			dev_id = spi_get_device_id(adc->spi);
-			adc->chip_info = (const struct mcp3564_chip_info *)dev_id->driver_data;
-		}
-
 		adc->have_vref = adc->chip_info->have_vref;
 	} else {
 		adc->chip_info = &mcp3564_chip_infos_tbl[ids];

-- 
2.43.0


