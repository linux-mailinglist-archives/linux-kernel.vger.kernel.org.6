Return-Path: <linux-kernel+bounces-244679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F19D992A7C5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC27281282
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6725148308;
	Mon,  8 Jul 2024 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tjQRua5M"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BB3142642
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458280; cv=none; b=pHTUsV1V0DoDo6Po2MaVZlBl4IcYjyIOJKr7Ne2uc0Ezm3DGYlB30lPkHiWli/rz4GMYpxv2JZ+UVJKHHyW3DWO6FkDeqmXeO9GcwXrN8luw5uv+bpf/8cZRNcx0nrQn96UF4zG3H9csmmywynT86EsCsv8g0fjSA8ywRXlUrek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458280; c=relaxed/simple;
	bh=/gmKHTdKlikA3tWSdvm57nrzkaxKksXD8hG0imHI3po=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ircjQyU4Do2tMjtgq/vlEFF0pOE55CLtlvhzlbB9gdPmUyrObuJsaRSAOaSQpV+OZK7GQXx64R6wEtT4EeuOuww+fHHlsZyv5gzwpbXkGqspAMhdWp6JWmQYD4EklNAdAD9jW4FajbWI9LEATtdpqklAF/nJ/HYgJFFfwg1Nygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tjQRua5M; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5c661df5db4so1445612eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720458277; x=1721063077; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvpNrB9c9Hl46wWiT75cgTZb/z1ngLdiVtG52BbExk8=;
        b=tjQRua5MzuEADRG2sorpjqbfwf32Jr5whuCq9gD/AOjw4v8Ev4WYuHvsjld7B1j0fE
         X7jojRJ5hEscYzLYLX+I4Tqcd68a0VF6TV623P5WU08btK+3Ft/faTqcJkrvXxXzl2iG
         3/X1xiMdbZ9m0nk9CMywU0MQkzbJ0deH5Xf/4i2EQES/aCXJOpY2yWIv5TLTDBoqOfOE
         s2wbUN88oNMFM2kIyUTA83CHMofo0tiNtRqkIRUmUNvtPDVmEpWdnMiO94t0MrzyhB72
         1APXl26xrpCIuQbtegcOFjrHlOZLsjKEfR+pK7Zpm97CLM4dCBnXy60foSMwt4bdpQ5S
         +zVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720458277; x=1721063077;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvpNrB9c9Hl46wWiT75cgTZb/z1ngLdiVtG52BbExk8=;
        b=GUChrOhXgE8ZzmdhSmcPEuy16qYNF96fpe+uqR97Hp4ZSVd+2jUwPunePVqxoT7Lis
         O8OIUhca2zv3PPRkgpcUVMgOFXw2AavZcZNbPXHnSpLrxSFtJgPaBhOxI9rqt9UKAVv8
         /3uMkeiaYo3R+Hyf/SQr00lVqFHGjbqo7a2dhcGtb93h5bvbXR458u3y1FAFKekrkPbY
         4eumwKmPLNLiT+7+fhNmVlnhmCMWSylhA8nmJggg24UQp1XhcmLwvtTBK93XXpxWghkz
         BnHPTd/jhEKsPHiRDkY0RasfU5jxtOplXMw8RIkarAUESwNyyfPdOqVv2404orYPMEdD
         abfg==
X-Forwarded-Encrypted: i=1; AJvYcCVzI+FsePcswHfINsVpCnG5YSiyAp41gz26a+ZcRaye1u2xlxCfflX3fxK1adrTtK/XLxs+jqFCfIqxQ73tMR2GqmbYB+QStRRqvENp
X-Gm-Message-State: AOJu0YwI5ARhY5Chl252yJQ1ZYNK2b/Mgmu3K/WdhtKaumC6RKFoIAS8
	Sjz7C1iOT3nBtxST3k8qDXV4OBZsLzZzNtrr+JToxSZZfR9ZmiPSGxoOlTC9Y50=
X-Google-Smtp-Source: AGHT+IHBVVH6omPzyI4LtKLmO7vYBh9XFRpTa35ZGKUdJwwwS7iIEWOMqHJsi48/VsYlkMNnwlk8qg==
X-Received: by 2002:a05:6871:299:b0:25e:170b:4470 with SMTP id 586e51a60fabf-25e2bf1e4ebmr12424412fac.50.1720458276907;
        Mon, 08 Jul 2024 10:04:36 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:cdd0:d497:b7b2:fe])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25ea9f8fce4sm79026fac.8.2024.07.08.10.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 10:04:36 -0700 (PDT)
Date: Mon, 8 Jul 2024 12:04:33 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Rob Herring <robh@kernel.org>, linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] phy: exynos5-usbdrd: fix error code in probe()
Message-ID: <a956a3e2-c6ce-4f07-ad80-ec8a96e00d16@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return negative -ENOMEM instead of positive ENOMEM.

Fixes: 497ddafe915e ("phy: exynos5-usbdrd: convert Vbus supplies to regulator_bulk")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index df52b78a120b..9cbf90142950 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -1745,7 +1745,7 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
 					   sizeof(*phy_drd->regulators),
 					   GFP_KERNEL);
 	if (!phy_drd->regulators)
-		return ENOMEM;
+		return -ENOMEM;
 	regulator_bulk_set_supply_names(phy_drd->regulators,
 					drv_data->regulator_names,
 					drv_data->n_regulators);
-- 
2.43.0


