Return-Path: <linux-kernel+bounces-204464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D46E8FEF79
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E95E1C25451
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744801AB8F3;
	Thu,  6 Jun 2024 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wz1GnV2t"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C36B1AB515
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684024; cv=none; b=ZRgfWOGdyEO5pcTmEZDiAtmn3w9tPnUAZSXjo73PhZldxtBypq9E6j3bSevNM28dGdbxeTLXK4Rh3KEwpDbLN2tY6APuM/VoZzwrdd4UlpXiLLEipXJBxhIP35lhBn7W2bQo9QlH3YgcUN1o4keO5qAZaanz30ahOHlDPTqiVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684024; c=relaxed/simple;
	bh=GEQpZ/AnK0wMBcP0xVmMauOZlz+QTE3U8F59z75ODIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F637+mZLOlpRuPkm45fzQmJiLE9WoLyIxoMjNUk7yZQkxaPzX+JDgIhjhZcIvpMHa4vspjLk0SjNTgODGdOjCVXOVA4jdsY6Q/KvdBpFOH0cbd6fFRLFEDxzkcNu4kYTzLcqeLNssr3RtlyABNI2RcCdJA1dmu26XF+2H7X1fJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wz1GnV2t; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-421396e3918so13722795e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684021; x=1718288821; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L85NsvGoDUeQoY3YtE8+i2I/DxvNN1zDXSSC47EQKas=;
        b=Wz1GnV2t6HzlETKByCJK1yXnPY9uYtRIza67KgmSaQdp4fBaeV51kfpX9PxB7xgNjJ
         MTIKDm7hII3+SvfOcslbtvQ8dwLxJYAB2q0Enjn/ilDaBvevszIGUDdmg/MaEcWGHUxT
         CeTBMwxPnw3Gd9IP2+bNQeg0wn22w+9VyYss5VwYva/FcWCMYc65GUPplYFkq3dpAatO
         ujm+N+E+QKly3KN0LJug36/P1QecCp3/742BbxL+gyqQZNp7SvVUjUoL35yL2u2HB7/Q
         5lrE9Sp87trQdJlJxTuNn90aQzbyoCmxvJCO9oOxLlJDEwIzewz4lZ3eYRBT1od9kHoz
         aqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684021; x=1718288821;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L85NsvGoDUeQoY3YtE8+i2I/DxvNN1zDXSSC47EQKas=;
        b=vvirJOmOGy5hOUP4wqSVSR0/RkS1kJI8znculq6LZGxYTJFfvN623/g2mdxZDIrlhp
         lvR4RShTF6tE3uDNj7sb3v0rA7H/QBK3wCYeSVUKZDVDTs4z99JHwXpqiorsjbX2By8K
         iCnRcAbtAPr9AiDfOUCJttwqb3n0INc7AMMcAvMJWD9aEFSApIzY3KnRhR1IzH5CJ3em
         075O4uoKjEsllED40swuT+LQ+sp8Q7/ZDSZ5yaJUHCqPkk5kbUGIjZISvnzaFDEEkTer
         z0V+84yRa57XOPkjnYiTk2rdTToTbCOdkkdGOLdJbY0o190AsNk7sRUjiZys8vDURZsY
         bVNw==
X-Forwarded-Encrypted: i=1; AJvYcCUYlaSl4J+qduktXt062icVfY2NVBsaBNrBXLOZhEKI7CCZn1sskTP06EAPMFWdZ6bXzb4W8fB3n1f9u8y15v1HBk523AG/RWZn3Wk2
X-Gm-Message-State: AOJu0YwmOe9MRgQqeHaypDOGHuR8cPzu1zWSxIBFz9HAQra2D51xRIoJ
	xCUU1FOXwYxnY9Nb7l+RnmOAPwH9gxNaYoh1vcLh/hk3gSPR0UA7RWbrELI2Mog=
X-Google-Smtp-Source: AGHT+IGPHPpNN4o0qC5iIvAMx+8WRy9de4SpebOmvsz5WZTl87vb3I6wRJHkGRyu1jgTlcsISnsnFg==
X-Received: by 2002:a05:600c:4f8e:b0:421:59b0:f364 with SMTP id 5b1f17b1804b1-42159b0f616mr41722905e9.40.1717684021630;
        Thu, 06 Jun 2024 07:27:01 -0700 (PDT)
Received: from [127.0.1.1] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158110dfesm59158615e9.19.2024.06.06.07.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:27:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Jun 2024 16:26:45 +0200
Subject: [PATCH 3/8] iio: adc: max11205: simplify with
 spi_get_device_match_data()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-spi-match-data-v1-3-320b291ee1fe@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=886;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=GEQpZ/AnK0wMBcP0xVmMauOZlz+QTE3U8F59z75ODIs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmYccqs/TdFoQX8Hj7tD+FCm9HPlS2XvTzAWiZq
 DTX2QJspb+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmHHKgAKCRDBN2bmhouD
 1zRbD/9AUW+4LTW3tPTMqOfojfkOFb8pejCotSDMTJFUxA4rjhhVexJHSt/jq+FpPtM7ZJgkK/O
 Q4cwSlOe0xuELztzpNuxrub3iNctxULPh4pJVGvtwh8haeb7PU+1MZXlqOzzUDnrQYVovEM6lJ/
 esCjFMwcVn0943KaXwQ8YSO3DYgiCOOPTdlekz/n34YExOgIO+x8POhaSwbV0Sp/F6manata7as
 QkJmony+BOQkKtZHi14SpQpJcE8+yLsPYgBPKewSJi3zmXOd4SaJ2GMpNkNyAETY7XaeBKMzQZ0
 D4cwv05n91l+s8NhKKT+rxYLYJKXIZwT+LNhbH2DaDwDqDFQu+1Apj2dd3GlocytKAiK7G0e0bd
 4+H4Pe8LJsWLyjNJQz7575z6cdScFvduuhzHIPPvfWBvmEU5Zb9DsJAtD63Y5ToKSk6it9YIAQI
 ZZlk+upT/6fH0VkpEbHDQ7myQQeUW7opuRw2uICCPyB7l8G7uImtbR8uhAi+hpbyV82N8VLxFJV
 +vd7SSLJoMkX7zNxF8GzFSf4sQvWWX4ica4P/rUALWrjYqzxXGNPzzrbnl1+hTMNmnD7srYLV0R
 N2XvRvmHJtM5v3wBievswHHJEWdvB3QzcbNxQicbL896X5FfGGNmKgnglt3rxIISi6RvUROE851
 mH7aNKr5pNd8Hdg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use spi_get_device_match_data() helper to simplify a bit the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/adc/max11205.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/max11205.c b/drivers/iio/adc/max11205.c
index 65fc32971ba5..9d8bc0b154dd 100644
--- a/drivers/iio/adc/max11205.c
+++ b/drivers/iio/adc/max11205.c
@@ -116,10 +116,7 @@ static int max11205_probe(struct spi_device *spi)
 
 	ad_sd_init(&st->sd, indio_dev, spi, &max11205_sigma_delta_info);
 
-	st->chip_info = device_get_match_data(&spi->dev);
-	if (!st->chip_info)
-		st->chip_info =
-			(const struct max11205_chip_info *)spi_get_device_id(spi)->driver_data;
+	st->chip_info = spi_get_device_match_data(spi);
 
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;

-- 
2.43.0


