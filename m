Return-Path: <linux-kernel+bounces-511636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 727EAA32D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD343A85C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AB825C6FD;
	Wed, 12 Feb 2025 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DOG40+jF"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038F425A631
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381599; cv=none; b=VJYJfmD8eYxcZ84guYSSKDAfx4atqNLBz58cw0mYvIptyJvEG9oKV6aHR1bO3Sa56E+ys/QCRpj+IFDVzKK69eD0ftVJP6EBaMPQ/BAZBkwg5dukeGIj3h1xmupm74pWuHcvtw+pO3BGXyLJC/TJ7sdFt8ET4U+jBuxnzroiX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381599; c=relaxed/simple;
	bh=n22EqJ2nQnrLzFIJLAStjl6g6PS2JMh1kLsvrOG24uY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aLF5PZqnKgdRTc15F2TyipoXYZhkjgvjL8Nxc3+1facMSwv8becm389LT5vPejF7d9pMoJ3JNNWsfmm6i9lC5aHYCQXuGtzvXG9cq8L+OgyPLNk4IqkwGANPGUfWEe4blGCnb4W+rOpVB8kdiUQIZMYmM/MB41kxQGBrnpEHWmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DOG40+jF; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71e1158fe3eso4089374a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739381597; x=1739986397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVzkZvmnvhzApmruysTSX1Nt4iOOeCqfMujbI7HV23Y=;
        b=DOG40+jFqD/arkQURdtJBx7UMw/kZVIGJnC3w1jQkRx8j6firSH20Fe+Se54tOOLeB
         5ILUz094fAJ4kOjlCcKvlPJxMNFxjZBEpgmlZ2+H2FYQb743IvPEHomKE/JcLsiJXJsA
         W8BhWO4jt12ZCDwsZBZag77UswUrurIcc7/vu8hnBWrhh2x84GqIkg293nE8qZ/DvofO
         G7aP3Xh/QZO3Qt6ohXAeZmqg12c6sQrdalNXRhNPjiqDRlizl4KXMYCZDBCjGAhxKk5j
         OabMj2sH8IZq04hXFfCq9SKIg/ubBRm/bfA2OboPC97Bd91C1TyX0k05+liKvfKWgVTz
         AiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739381597; x=1739986397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVzkZvmnvhzApmruysTSX1Nt4iOOeCqfMujbI7HV23Y=;
        b=uAj7RPU72+laNHqgCvsf35slvUjNJH3eXTWTxdxQnxzD6sHGVvuzf4Zf2r++80Jc7R
         NHdZ37Bo7UTeSwBZIwEkbtti5fwrc9wZwEl724Eg5o7+bY83iiXG0HZT2ZKDQii8xGMP
         HRTGgzEmy/rPQIYuEe+KtvIIatkGtm4LoNbT8NJY+P848e5wmBrV+LSB+Cvjc5B65a6d
         gvYNQRJY7S8rR4bClgcq/x1vlJhB9ESl80n/4Wo4n/e+B46/1tkVlrkGeF0Y1p1vk7uT
         qsrA8r9o/EAWp8VMOohVM3OwB8yjsWE3/g3nFL1z8jKfTP4J9rIOFw5x6cm+3MXFrUU+
         bULg==
X-Forwarded-Encrypted: i=1; AJvYcCVUx9vnw3xN2qafN08XHuIuuUnP3A0o+boLlGdbmfXX1R6NzHh5kutey0jKJJdCF9WPNQCiEz4KKGyctmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1loc5Rxu0kBULmkc2olwCmGpRO2jyaF/CSMrgnjrovjvidtyx
	JqrrgjIIdHYW8GsXU3rVwBBDIAJo7hYEkr1lAc1H0ySTKQwBCbgcPhCI4rYuWVo=
X-Gm-Gg: ASbGnctanPg0N/BtDFX+S2yE6vBDlkcz8jHElPkPJKxyNIAZ6yO7pwVHzNnj0vj4G4f
	Xv/EL+mbSIuhPD40xmhCi3ayCxW3o/NzqcLwb6buHDgROtxRR/NduINW2GOJLCIY5Gn0qe3dit9
	Nk8mkNe5ngTlJTMNL1A+mESCfqi9CQjzx3M/fFBlEuO/AQIkSBnTZE1JedHkJAoeRhFmoJQYr73
	sUzlOlKns3W5utWS3jnZAi/Vbc0lGD6bwGln/mPOypztzsigi3xvuX8Kp4fxOkcr6US2577Wcb1
	9XS3wc5ueexn9F+CgFCaxG+diYBOi5UmGof5UfRyeZia1nE=
X-Google-Smtp-Source: AGHT+IHANhVLAmBTAt1jn+3ZLEIQuul0W8yVFirn7Itv71qH29IIUy5H6bUe1yqlQ+ekk1urTD5BJg==
X-Received: by 2002:a05:6830:6e08:b0:726:f139:42b2 with SMTP id 46e09a7af769-726f1ceeb21mr2931274a34.17.1739381596961;
        Wed, 12 Feb 2025 09:33:16 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af9343c2sm4720190a34.20.2025.02.12.09.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:33:16 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 12 Feb 2025 11:33:13 -0600
Subject: [PATCH 2/2] spi: offload: fix use after free
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-spi-offload-fixes-v1-2-e192c69e3bb3@baylibre.com>
References: <20250212-spi-offload-fixes-v1-0-e192c69e3bb3@baylibre.com>
In-Reply-To: <20250212-spi-offload-fixes-v1-0-e192c69e3bb3@baylibre.com>
To: Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Nuno Sa <nuno.sa@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, kernel test robot <lkp@intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.2

Fix a use after free bug in devm_spi_offload_get() where a pointer
was dereferenced after being freed. Instead, add a new local variable
to avoid needing to use the resource pointer to access the offload
pointer.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202502112344.7ggtFzyn-lkp@intel.com/
Fixes: 5a19e1985d01 ("spi: axi-spi-engine: implement offload support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-offload.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
index df5e963d5ee29d37833559595536a460c530bc81..6bad042fe4373e8b91dae3154ef5e22744a4acd0 100644
--- a/drivers/spi/spi-offload.c
+++ b/drivers/spi/spi-offload.c
@@ -108,6 +108,7 @@ struct spi_offload *devm_spi_offload_get(struct device *dev,
 					 const struct spi_offload_config *config)
 {
 	struct spi_controller_and_offload *resource;
+	struct spi_offload *offload;
 	int ret;
 
 	if (!spi || !config)
@@ -120,18 +121,20 @@ struct spi_offload *devm_spi_offload_get(struct device *dev,
 	if (!resource)
 		return ERR_PTR(-ENOMEM);
 
-	resource->controller = spi->controller;
-	resource->offload = spi->controller->get_offload(spi, config);
-	if (IS_ERR(resource->offload)) {
+	offload = spi->controller->get_offload(spi, config);
+	if (IS_ERR(offload)) {
 		kfree(resource);
-		return resource->offload;
+		return offload;
 	}
 
+	resource->controller = spi->controller;
+	resource->offload = offload;
+
 	ret = devm_add_action_or_reset(dev, spi_offload_put, resource);
 	if (ret)
 		return ERR_PTR(ret);
 
-	return resource->offload;
+	return offload;
 }
 EXPORT_SYMBOL_GPL(devm_spi_offload_get);
 

-- 
2.43.0


