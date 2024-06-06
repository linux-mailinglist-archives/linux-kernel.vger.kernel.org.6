Return-Path: <linux-kernel+bounces-204462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2F08FEF78
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E758B2AA92
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CF81AB510;
	Thu,  6 Jun 2024 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Inxqd0l6"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167519A2A8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684022; cv=none; b=LfKOgU0WVls4EOR90NP5JJea0FdGsyjaN/JXq0rbz+vcNHY/oXtMEJ/XZWb6TjJD74sNYyu9dlOfgtd4EaHq50M9bNv7P2RcpjOb0BVRk2p9QzHnYh2ziBkgARTAFMF3r+TYmnpXqYBAt+kBu0TrVHlqbomHNjkzEhU+QYSIscA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684022; c=relaxed/simple;
	bh=qnEQE+znEpMqv24asVKMZ/KkN6DF56o8w2SHpVB+m4s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qnhMlLQTFvkUQGv1jtuoYrYmCcriUVQklNA8AMWIhwLM7969lNl0c1fAPFsMvA7QVrYmw7nG8N1qAIqyi2Ho825jbAWYDZE50QHqrLk7XRHTF/0LAIorM8dtiD3LjkmYOMAxP1rzrbGkPsVPSu5jqtdkbocEGA/5Cq32Z2oLLiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Inxqd0l6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42121d27861so11342945e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684017; x=1718288817; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tp5PTKFwAXtvx/todRiJJ+CxbMs0fyy3pTRLGPdv8KU=;
        b=Inxqd0l6h3oWeZA9w/N/3F1i27PdNAPDsWTmwSZkBDz0rYbSKgQK/XIj2uMGesrHAa
         aYLFfL4qczO7/h83mv21R1H5E461baimbA/bA9hsRzDdWBWTjwsOPGnZiG8n89SemyqM
         fz46EUnb8LO6UGoxCMyXPECx3L13gEB6KJTqNUaFXecpEbUyXNDW2zYOy/sLtdJMsAm/
         +XX4yfCAzzu/Fr32c9Tp2IgT1kV8Ykxp0LFgoptGI1ZqU7NLxCVZPKOpvXkRkAmKhSSf
         pBK7DQvoRGNWahC+XjjH1znGl6DCDbxfAGZtcw6GP/cyyxFuhlGCxrkvh79K+KAk5ZI7
         gnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684017; x=1718288817;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tp5PTKFwAXtvx/todRiJJ+CxbMs0fyy3pTRLGPdv8KU=;
        b=KlAnREPgyxYpsaprus1YTM3GQ7OCL5TZ2TrNJFz7ke4rANgIiNPTRCm93GUlFO0fuy
         e9CEVRCk/t7bC9NMPsAwOdmq/d/oLMLKXsfSJ4BFoRc0F6HIEdKEdi2DtaL2YB8vvX5R
         3rYp612cD56TbA5Y8/XXBthaFH3EbJbpo3XGG3lsKDcPc3BTIl2b1PcKdKrJaLc8GYx1
         1QsX7yLJP0zYlzQvA+wM7ITwrBHHzgJlAoSc6q1EsTI3Yh2CHT1gwmaVurB0KfDuKxkp
         ZA7Lx9OokFO3fhHcCaJMYmjbyQ0waVEvERY00tq5pmaPbbnPYS2pZw8z7O1vkvDMcdzZ
         ryAw==
X-Forwarded-Encrypted: i=1; AJvYcCXo8JU9T0MvPV2oZ4grnXk0Mv4CSDaJlg8oHRT55s5rj6GkSVtGeBQBJxbWifh68oCRv6NERlDKzrPzuMnH+73EhANnBP6vT3zlRuFR
X-Gm-Message-State: AOJu0Yx3x+hE41F12RgOSxAvzUSTqLcpahuwVTJ6oGiPb3Y10tfHA6ye
	hy2bLXFeE3XYPSsc5AVkWrrI2dYPN4/54ATOZzHtCeImaYVitcYe9dBE/nWFwww=
X-Google-Smtp-Source: AGHT+IGaefabovxjkFtufxVtFDm1B6vY1P2ri+bP2YQyW2x/2qrrizvHNiOvAhP1IobXECg24+SwlA==
X-Received: by 2002:a05:600c:4ed2:b0:421:565b:e71c with SMTP id 5b1f17b1804b1-421565be9ecmr44309055e9.14.1717684017343;
        Thu, 06 Jun 2024 07:26:57 -0700 (PDT)
Received: from [127.0.1.1] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158110dfesm59158615e9.19.2024.06.06.07.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:26:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/8] iio: simplify with spi_get_device_match_data()
Date: Thu, 06 Jun 2024 16:26:42 +0200
Message-Id: <20240606-spi-match-data-v1-0-320b291ee1fe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACPHYWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwMz3eKCTN3cxJLkDN2UxJJEXbOkNPNkU8OkREtDYyWgpoKi1LTMCrC
 B0bG1tQBguYVwYAAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=qnEQE+znEpMqv24asVKMZ/KkN6DF56o8w2SHpVB+m4s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmYcclT7nf/6eJDtZqVXtzfOUHDIm1XQyhfBahv
 l7bw+69kuiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmHHJQAKCRDBN2bmhouD
 197aD/4hvZcXGISsqLzeIOqoPqzSqryKxhgdsh99qHrCeplMjhAyRFoMJ2L8zkYFn8ijWdTibyz
 17gXHmoBIOWxKXBrRNNp4DZ07Bn1dFS9lK79Hoc3BJnIQn4Ft35fabXIqknHltg/I47WA7NPGKB
 deyzkunspi3Z0Q3NLBRQXxAw685+iwf9LE0EdmgfoiHYntL/M9EPGGsdkev4JMdw4LIR8vwD7dR
 7pL0FrQpfg9RbcJBd00Bzit0eouLlJ56B0TC1HK+TTPQ7LjDkwGpzopwlzZOQ7SHWgJA1Y2vuB+
 mEwECGu52J1AIqElfCTQh1ZszRbcZDNKpHDOk9PrYmeqbm8o4o6iz25iHa9zV2DDgeAQzYara+V
 if3xAdgSQixsUGwXAwkoGGk18GEXKDQVXA2IBnvJ/r/kKzPXDC7r//nEeLRBsQE9apOH9pYirmL
 VRv6eQT2Dzci5G6zAsBWcEsc5ZGuZ+ArsMRqBQRuTTlE6K3skRZqKCkCm5Ag+8qUwSS5caR04Nm
 DdB7oio3557Ns+J0zgLAI1c22G5TrfD7HK2W2RSoS5+sie3rrC/aMlJZFRSBbrAlJELO0yEcav1
 wbWGF5iBmiu648mcnYSrVUk8i1XHuPeKbi3KoY4ULghSi+v5FXmEgB/8/8MU8X7MreP1YsM23+x
 BByBYtPlbmU5r/w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Not tested on hardware, but code looks equivalent and should not have
functional effect.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (8):
      iio: accel: adxl313: simplify with spi_get_device_match_data()
      iio: accel: adxl355: simplify with spi_get_device_match_data()
      iio: adc: max11205: simplify with spi_get_device_match_data()
      iio: adc: ti-ads131e08: simplify with spi_get_device_match_data()
      iio: adc: ti-tsc2046: simplify with spi_get_device_match_data()
      iio: addac: ad74413r: simplify with spi_get_device_match_data()
      iio: dac: max5522: simplify with spi_get_device_match_data()
      iio: adc: mcp3564: drop redundant open-coded spi_get_device_match_data()

 drivers/iio/accel/adxl313_spi.c |  8 +-------
 drivers/iio/accel/adxl355_spi.c | 10 +++-------
 drivers/iio/adc/max11205.c      |  5 +----
 drivers/iio/adc/mcp3564.c       |  6 ------
 drivers/iio/adc/ti-ads131e08.c  |  4 +---
 drivers/iio/adc/ti-tsc2046.c    |  7 +------
 drivers/iio/addac/ad74413r.c    | 13 +++----------
 drivers/iio/dac/max5522.c       | 11 +++--------
 8 files changed, 13 insertions(+), 51 deletions(-)
---
base-commit: ed3dab9323648a17a85908c574787be12d4cc871
change-id: 20240606-spi-match-data-6bf7c51ba913

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


