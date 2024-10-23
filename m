Return-Path: <linux-kernel+bounces-377637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C18599AC1A2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789B91F211FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022C715A849;
	Wed, 23 Oct 2024 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbq2YyCI"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE1158DA3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672239; cv=none; b=FVWd55Sn2PkLQs3GYYEBFPJQ2T9qH1OAyseSAuEaiVgx5cVGO5+H8v8rHCRvxy2jPKWZ5uBR7f2fw01rFLeEaqzrzSDdU828pwvV6uXkXqmVWpbSj8UZnyOC8nnFbFy/mKGm+4MHITtNNK/Uxz3S7NoTmhmc5q9pWg0UHPsuRXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672239; c=relaxed/simple;
	bh=c0Vwk6WOOc2/MYBaUvlMbC6aKVmZwQj130v5adtmU0g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BP6SQP3tkspUXwxX3B/m7PrND4B5VMUTa8oizWprPgJtXm1PKBy007iSEup3QZUP/FFOQst3Tsv5XgK3F3+vsNgdWKbl7uIBxyO7KyE5Bf476a2Naq68DzdQUQXNGehRGKGHQ5L7XOKKxVwbMj8fSDuI6WEXj072eJOtAQmrBzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cbq2YyCI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315baec69eso61354195e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729672235; x=1730277035; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95Cs3StsmPVbQEmy5DYBdaAp5pMh1zUcYS64FB9PkOw=;
        b=cbq2YyCIySlJzXT+WTBnWsfwA91kDCgYKS6s9hXuu71gTnneYBWsSoGDz0jY4v+PFs
         jgXlT8fvYKUuyL1LBm7zyxTNyLfbTtaoqBQO27qmODtJJeJSfPc7BfhwC+AnirwBhEB1
         2/iQ+ogh4Z1J3Ywo0fVTEsxF2WVlwI1C+sppbzmKn/XmPHv/keBDos3IFVtjDg4orDa9
         O9QZcfWsW7Z9TPUzWQ4zMQmw1U8RdSemDZaSfu1xwoZ+Gntl68g+ztsOTayFVRO0qonw
         BhbNSYg1/XJDCUxF9CY0AMSysq33fOE52dQ2EuI9sQ3m5yLBd7fdhxxOtFZixAdDLEnJ
         C/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729672235; x=1730277035;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95Cs3StsmPVbQEmy5DYBdaAp5pMh1zUcYS64FB9PkOw=;
        b=A2FF860xdHYxJVTbjKsfAZpiiMfnWIlkQBtyO3ZUHjYrHJe+b5bRFuxf586qVWyuUI
         u+3YGpTYnTstoQgFIqkO5otlDD/58q1v/QUEg+ZlKAp+CGSbM3VwDePIzELVgrDpR/dJ
         VA6InNcnVeO+iO7IeNjxxcD7VituPHNt941VSh3xCmaFr/cTWWXGia886GxlPuLwPoev
         KgkkWDHc3XG3ak6VYfV3dPDcQH1M3gxBpK+FsLfqABdyyybWD4rwakjp121PfYCyJkZ/
         mZKOOzCgQLfe1y5c8R/5JwNBpELvD254cYowdmI1I9QCozx8rQVndW+z1gSBCI2H+2k2
         mauA==
X-Forwarded-Encrypted: i=1; AJvYcCUikzxvHUDAForeIVAnomz2S0z8iu8+rCQnmzhbSpE3q351VP01iQDK4mgZgNErDcBnLgt0jm4LHK4PjbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMYmV+l/lIPExFqoGWQQu+T7GUysrQRYhoht+bsXa1acmjM18m
	9wXD885nBKZGNa3hMc3v5yrE1SpdEqZjSgoGZ6y44dKLRECoOZX1BA6zmLvZ/eM=
X-Google-Smtp-Source: AGHT+IGb/UB2CSjQVVmaOHKT/K4GreGbDp8bdWYCdX3b6WAbVqGRAZOZ8sPRqWUJoRUK+LtTVQFvnw==
X-Received: by 2002:a05:600c:46d0:b0:431:57e5:b251 with SMTP id 5b1f17b1804b1-4318424ea03mr15362385e9.28.1729672235246;
        Wed, 23 Oct 2024 01:30:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4317d03ea4asm24552605e9.0.2024.10.23.01.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:30:34 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:30:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/sharp-memory: Fix some checks in
 sharp_memory_probe()
Message-ID: <0d307349-c141-49ee-8b34-67caf5f8b638@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_drm_dev_alloc() function returns error pointers, it never
returns NULL.  Change that check to IS_ERR().

The devm_gpiod_get_optional() function returns a mix of error pointers
if there is an error, or NULL if there is no GPIO assigned.  Add a check
for error pointers.

Fixes: b8f9f21716fe ("drm/tiny: Add driver for Sharp Memory LCD")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/tiny/sharp-memory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index 2d2315bd6aef..1bcdd79166a4 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -543,8 +543,8 @@ static int sharp_memory_probe(struct spi_device *spi)
 
 	smd = devm_drm_dev_alloc(dev, &sharp_memory_drm_driver,
 				 struct sharp_memory_device, drm);
-	if (!smd)
-		return -ENOMEM;
+	if (IS_ERR(smd))
+		return PTR_ERR(smd);
 
 	spi_set_drvdata(spi, smd);
 
@@ -555,6 +555,8 @@ static int sharp_memory_probe(struct spi_device *spi)
 		return dev_err_probe(dev, ret, "Failed to initialize drm config\n");
 
 	smd->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(smd->enable_gpio))
+		return PTR_ERR(smd->enable_gpio);
 	if (!smd->enable_gpio)
 		dev_warn(dev, "Enable gpio not defined\n");
 
-- 
2.45.2


