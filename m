Return-Path: <linux-kernel+bounces-388846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6799B6528
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A878BB21A82
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38201EBA08;
	Wed, 30 Oct 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXtzpITX"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9298D1F12FD
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297028; cv=none; b=c+XruWYA4jMwkFnf6S/DZnr6AFLXw5gJmdQbzibhxNEL/6G9LaRmAeB6V+niYMpLn5LbAAPP8mUVQi81zHBkL6wCw5xCW0uginQrpBlFaj2LjddOMYrRcV20zId+cGMVpTv7FZ1UcgwDOFCkE3e6oRmLce3WQ0rqc6kYfqMRAgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297028; c=relaxed/simple;
	bh=mGb4txoYNAVTq3anfEUNTwnBrJqhJeocwzZo3lYhi6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uyNk7HWem4NtT0Kt8MH/IIuWK7EidwmxBygpx3DJb81lloOodGQImDoBBh2s1PYvOe8uaNdHXcB7B6BlHI4B9058XnUzarurCDqjFYAmOLBKB8WLd0LoGcprhtINrriIuD8ctWC1pzcZSNw6ReLOyD/eR4HVoGQAwXnLOxnR6So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WXtzpITX; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43161c0068bso61712205e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730297024; x=1730901824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCo3/H2quhkzzLeJ4h4H59C55POvIjPaxrq0l4ufUw4=;
        b=WXtzpITXXK72r/3mCBzaHZomY613NwHTboe2b7plnX946Jr0bFhAa1DA4cSZ9MSyj1
         Dz5vLypJcLDzxBCrqkyD8Q6NKigY3lRy8M/DdTxAEtluO1btLll9hPAFgghTkDgdJ8Q0
         dH5xrtACi84RTdg6Vzn6V8HdgD7KPCOWwhnkaewsqNLBP+KzQ5qtGYpi1N/S7CuFf5gH
         RbPSHJubQE94T16Z8+bGu64mc1bgTh+dw+qYfzAnE4ijg4KxtGeVrT5E8EhOAI/zXsjp
         7BYaq9lJsPqkplo5vTaGr42pp8rjED1+FW2br9BJlBl7U2EnY0aVLaKpTmDZ8onm+RYc
         6jFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730297024; x=1730901824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCo3/H2quhkzzLeJ4h4H59C55POvIjPaxrq0l4ufUw4=;
        b=GW44LwW2D3M01Q3c0IU6rmucyNNvd7QxTKbdPT1sSDlAd52KH91+f9bppu5imtDva7
         8n2+H/GKU3NZZj8abgh/aPiq3pCCo0cWJJzgv5vPL16hPq8c8zfh58lmUXlkGM+9hpXz
         zHzKPbC4trSFq2LSywSAvIh2CudlU+rQMo8NN+WViyXJPV+YY6DvrlcexnxtmzQ8DTMr
         nOLqo/vFrAzYFn9nbEHkNnN8hTBJmVt7tsXptkU0z8gsiJOY4A21Iy0qxDhziXC0jDEB
         n3bkeSTiYKLL1zqFDUoI2c4JlFQ5nXGzbIuapyAUwbqbQEF/KfUfOZ13Su/SKzZ7fB6r
         XVGA==
X-Gm-Message-State: AOJu0YxDi8424z1d6jklMRUv+QqhkSv9RYQoyjfk+RzI12qBr1FR0K86
	J79JFjqctXNlyoVjll4XpF9pxk1qR1vTn2k28uDYd3bbueo0hrOgGkNoIhUjweqfdzW7kffMpTT
	EJ/TgIA==
X-Google-Smtp-Source: AGHT+IE1Q7y9d1nQvwUd6O0N0qI4Z8R1fDbggTbFXMZG0uswurIPUSMZVdBjrsnS+k2UNh7y6Kp+/Q==
X-Received: by 2002:a05:600c:1c12:b0:431:5533:8f0b with SMTP id 5b1f17b1804b1-4319ad3643fmr138225705e9.32.1730297022756;
        Wed, 30 Oct 2024 07:03:42 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd97d84bsm22498405e9.30.2024.10.30.07.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:03:42 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Shen Lichuan <shenlichuan@vivo.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/7] nvmem: imx-iim: Convert comma to semicolon
Date: Wed, 30 Oct 2024 14:03:12 +0000
Message-Id: <20241030140315.40562-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030140315.40562-1-srinivas.kandagatla@linaro.org>
References: <20241030140315.40562-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=XDKe4Ev5s5kz6hyZ+86A6i10SRypi2CUITlbr9o3DGE=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnIjyiXYnQvK1UAlNa81v8DG5T04TYbI1Wz8wJT XjI9htqjxCJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZyI8ogAKCRB6of1ZxzRV N24oB/4o40Xoa14jpVRUdOG6rnL5RA/o/zE86Cs7dtg+STYGMef/p3QpAF/qwMTazzvGhfHWvzu Ek7wVm8Jxg5kLKGlgKTfIDgWc9eDHAa69CK9sgcLv5VVc5qfVRYUkizvGPymNmcSM9yphhEyLUc FZh5RfabZ+9d6WFGFm3CJBynBb+S8is+LtZUdQtkbIBvzJcnGGNcT3905hylXdBO1fJqp88gbV7 s9o1BSVxi7LTMndU1ExbFtf8J48g1s6NRMdt9JaXOo2nomCz64B14JzWDYDr3Y55mcxN7eivkTX sx6WC9OPdaLeR84GcFmkj89c8g+eXW639Nse0HeOCMYupH6n
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Shen Lichuan <shenlichuan@vivo.com>

To ensure code clarity and prevent potential errors, it's advisable
to employ the ';' as a statement separator, except when ',' are
intentionally used for specific purposes.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-iim.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/imx-iim.c b/drivers/nvmem/imx-iim.c
index f13bbd164086..8cfbe55a56cb 100644
--- a/drivers/nvmem/imx-iim.c
+++ b/drivers/nvmem/imx-iim.c
@@ -115,11 +115,11 @@ static int imx_iim_probe(struct platform_device *pdev)
 	if (IS_ERR(iim->clk))
 		return PTR_ERR(iim->clk);
 
-	cfg.name = "imx-iim",
-	cfg.read_only = true,
-	cfg.word_size = 1,
-	cfg.stride = 1,
-	cfg.reg_read = imx_iim_read,
+	cfg.name = "imx-iim";
+	cfg.read_only = true;
+	cfg.word_size = 1;
+	cfg.stride = 1;
+	cfg.reg_read = imx_iim_read;
 	cfg.dev = dev;
 	cfg.size = drvdata->nregs;
 	cfg.priv = iim;
-- 
2.25.1


