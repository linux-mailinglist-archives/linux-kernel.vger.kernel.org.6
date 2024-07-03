Return-Path: <linux-kernel+bounces-239491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17E39260DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E34F286B5B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CAE178384;
	Wed,  3 Jul 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="uh4RLSLM"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325DC1E4A9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720011011; cv=none; b=YAoRmsweoj51+TmBXFf2htegifU6daPAXfp9sMqHv+El+GBtxhk5BDt+3lRNX1FknbNIz/honOvxIqaQkJ5go9Fb43zhzoq8T2XzdxKuXrVes73oCxijMOCcEgPCHGG8oo4cEVLcu83T2mm+PP+BVYQNA6BSL0MYYbf07CQxplo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720011011; c=relaxed/simple;
	bh=TndIeG9G6FrdR/rn55DgwdEEotMupyiOMfJyv1C7ABM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=re4OaQ0fVqc66KkWogXKRlWu6KWdpdquR6sEwoatwph1pkapeQnLggjwK7R83rn3pgxYotw1YeGljMalLJDXRwv88RBCnTmCX6sD66rMyqBSqfpA72m24/d+Zm8ewmn0A0gMNnBBs53mXu35Aw7l2+Eofn+CwuTl5zaHvCfmtIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=uh4RLSLM; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52e99060b0dso579386e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1720011007; x=1720615807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RmBlGZ7JugDA6yCRv+tI74EPUOAWuL4mr31Z/ZqddMo=;
        b=uh4RLSLMkLUZb38cEz7FXZZYBgPP2DP2hWpMstl9PZ6xMO9AtOo4cADN1DRVbS1rAh
         apR68pR9MUV6c+jci7iSyHGpYUYarSBoGF8vOTh0EOZe6UhAtzU+u2gG9x/Dr02u4wH/
         VFw//liUiuckO9NEXwereCQUQnWUbm3z0chV6hs4QBiLiMkGdlMeTAC1bfmGoJCseEUA
         S5badRyA99f35rLbFJYWQpBo/oT3HRfIgnA46gAQmZwQWjU8iis0LNn5ZMSvo23cLMUe
         VS2Q4yeZEsvw7nH3wAkKYRi+PIdvhVLktdgmikhfqIV80SFjzPJClbmXu6lq97pb2YVA
         Q0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720011007; x=1720615807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmBlGZ7JugDA6yCRv+tI74EPUOAWuL4mr31Z/ZqddMo=;
        b=BpNuwvk8pasS/BKFbkRKKfbfen0VZDF34VWVC2SmtOqZar1KAIMP+9rTlab10vl1cn
         cpVQ7LGhYFLhIX2EqBz6yAvQ9m5jOf9Wdgoxm5DDusSY8XV+GMSTk+jKdda50fqzeo6f
         uv/p8t7NZ1asL15TtcYEWSY6KbkkpqRutiiwive0SjEJ0PYWBMgJX3BLiuRUcoZRguGD
         ueRIUkig3D/sZvN5r7FAmFPSu5fey7Z1BP9Rf6L7cPoLBUdaljjTmlStaK5d60O7Y3eo
         u+d0+3G5aK2+ejd5jVH+yMewxdsdpdBn+TsK1+2egn9NfJ+2gJs/0dTuJTDzNYLImcBF
         KsEA==
X-Forwarded-Encrypted: i=1; AJvYcCVVICoH00WRFTUswY3HqDmSqtYcqm5MZwSY7IrCPFoNFKFzHK8V9Dq6uUlIf7eXx/rlhq5lptzMcDw3T2xeqHtbj1OKrOAi/iBGJ/YF
X-Gm-Message-State: AOJu0YwwDkk4PIp2z0WPvZFBowP2DkgnoY1fWNoJ1tEpxy0zpPT1iLBG
	LfDyjRf8wSqeQK8lfC4sAHpI4gJHAGJ58AmcYqVI6ofFYFcDN/UIen50uXE3s5w=
X-Google-Smtp-Source: AGHT+IHlez9j3K0WoeC3XHS+M7qci4/FmMVRo4FxFL3Nd1FA6LeH36IAKdcQ67uBJOsYRMIHSlMkyw==
X-Received: by 2002:a05:6512:b11:b0:52c:7f12:61d1 with SMTP id 2adb3069b0e04-52e82643bdemr8858443e87.1.1720011006993;
        Wed, 03 Jul 2024 05:50:06 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4256b0971d2sm236399635e9.31.2024.07.03.05.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 05:50:06 -0700 (PDT)
From: David Gstir <david@sigma-star.at>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
	Richard Weinberger <richard@nod.at>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-crypto@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	David Gstir <david@sigma-star.at>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] crypto: mxs-dcp: Ensure payload is zero when using key slot
Date: Wed,  3 Jul 2024 14:49:58 +0200
Message-ID: <20240703124958.45898-1-david@sigma-star.at>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We could leak stack memory through the payload field when running
AES with a key from one of the hardware's key slots. Fix this by
ensuring the payload field is set to 0 in such cases.

This does not affect the common use case when the key is supplied
from main memory via the descriptor payload.

Signed-off-by: David Gstir <david@sigma-star.at>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202405270146.Y9tPoil8-lkp@intel.com/
Fixes: 3d16af0b4cfa ("crypto: mxs-dcp: Add support for hardware-bound keys")
---
 drivers/crypto/mxs-dcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index 057d73c370b7..c82775dbb557 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -225,7 +225,8 @@ static int mxs_dcp_start_dma(struct dcp_async_ctx *actx)
 static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
 			   struct skcipher_request *req, int init)
 {
-	dma_addr_t key_phys, src_phys, dst_phys;
+	dma_addr_t key_phys = 0;
+	dma_addr_t src_phys, dst_phys;
 	struct dcp *sdcp = global_sdcp;
 	struct dcp_dma_desc *desc = &sdcp->coh->desc[actx->chan];
 	struct dcp_aes_req_ctx *rctx = skcipher_request_ctx(req);
-- 
2.35.3


