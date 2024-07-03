Return-Path: <linux-kernel+bounces-239229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B1092582E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7993B1C210C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589B5172BD5;
	Wed,  3 Jul 2024 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vytpm4br"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C64C171085
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001782; cv=none; b=PrXQIhrL2hEXoqFQCsR8V8TbpsLDL3cYW/k/vAv+E//lf4MANcBiEGggEm1Sk28zrRPsZrwHoiItwhXvWw30HZw5Irtmfutu8vZxwnaYxAVyN2qBToLM8x3L7bE4CHE1t1qxkp4z3+tFzJKujHe22Mo3WvAraNIUv4Hjf6wHjKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001782; c=relaxed/simple;
	bh=H6MHDzn4DJjvMx+UU3AarlEqCOFCm2kvbOhK8C4skwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wu/g92bLrHfETM6Fyjh1tfHA2M0SPC5rbskVZkC0aaBvSqfi8oLvFICDSYJo0UL3mwBykI+ZthMJ6kFFZp6K0L9OFreMckPDpuwvqjIgF85BTKWkY5GUxQwdF1B3BD9lJcAxGfJW/vSukuLOA8bv8wMHptQ5lONFhdu2k0Gus28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vytpm4br; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a72af03ebdfso724848966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720001779; x=1720606579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4h10YGfrwPkkGVTEjCw3qirW9g6luYJ5Y1/Sh0BpRyU=;
        b=Vytpm4brkrYBWYak9Id6SDWsnmPTTjbwl1hMEfZ/jieTYb/p1kenN0Rry84/xgPedg
         SitNJMuFwrqrPnfgR11OGuVTzij+EQvA17vjrmWoJCxLWeWkM89EJfkS9RTR8GxAYfdq
         rUbAo5HSZngsrYKdG09tFI8yk7crjxxEFgN82r+x6DMMfrh6o/4NktL1t/UZPbN8cSlR
         vQDVFXcBI5gAmPIybrTXzI8f1dGVs9SFcrDCJVF9TyuBM3UUfP9Z0q4TW+y7j4ohEq3F
         bOzcJQqK/nS4KEflRea+siyt6eAjKpeDSQCFFfOzs9u2hKkwx0eUIdvyZBSgcuQImKGG
         0miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001779; x=1720606579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4h10YGfrwPkkGVTEjCw3qirW9g6luYJ5Y1/Sh0BpRyU=;
        b=KcJZ19R1rpCNcJcWLQykxU4AjA1zlvLfG9QDZTbpzoqqYawZBCqT3Qnm1tcINMZxUZ
         d7DWU195b5kzlw85dAbTMGiCmrtmwdc/G/9eYNMpJVjAQY2nwdagPscIaF2iklKSXTYD
         C+uIHrdOrwfSsTYHtlcNfZVk0+28b60vQc+c1q3e3y1ugq0mqBkfvRt7aij90O6os0mq
         coOOTUQDQCqUHJI/2u9P7/YyijKCEAWMtwBJlBcoBQf7eTW2A9fPvMW3wKb6Am1cKRYF
         BaZ3YH/ZEIKDAVa9yjreVDHqwMiAtuWNeClVS5aQtMeNCf0GKFbnNGPY8Q80/zlUxe4h
         JIVA==
X-Forwarded-Encrypted: i=1; AJvYcCWCzok6VFB/08+4A6HnuMDCyhpOqe2vwGUiyYFMrpdLIFDrGepnfTCSjnQiinEbHrruwFSVkblP5d9IrecsTjO4V2MPS5i1VB4nZO/v
X-Gm-Message-State: AOJu0Yw1JPkkXAgT6q93yFBIrwXSdsBYDVT9NmQHBUpHtLzjIe7fwoLY
	dBc4KDXgMqgMNIVndY5bhPFUYEDFkTfz2d+mG62pQ67aH9hYNzbgK/+9HxD2/dk=
X-Google-Smtp-Source: AGHT+IE2lrUjD2pD2f+fZKLRkMjumm7fxaU+U4uTiEAcTuke1jkfQkdtKdbpoN9AyTeSI5vhJJyf4A==
X-Received: by 2002:a17:907:7e85:b0:a72:9d25:8ad3 with SMTP id a640c23a62f3a-a75142d84cfmr1002976966b.9.1720001779364;
        Wed, 03 Jul 2024 03:16:19 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06565csm494291466b.103.2024.07.03.03.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:16:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Jul 2024 12:15:58 +0200
Subject: [PATCH 6/9] soundwire: intel_ace2x: simplify return path in
 hw_params
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-soundwire-cleanup-h-v1-6-24fa0dbb948f@linaro.org>
References: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
In-Reply-To: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=H6MHDzn4DJjvMx+UU3AarlEqCOFCm2kvbOhK8C4skwc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhSTmLDnJUL3FsGDF5drvgu3fqPTzR9Y/ZiOGC
 mlwnnfvADqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoUk5gAKCRDBN2bmhouD
 16qGD/0RTy0gf025ZbhLA1kN/XXZ3PlVTWyAloNPGC57y/esZhOXT/qt53fssZ7KSpHzpKNERDt
 flw0qiIrQwaGh0tIfMFkQAgPOUX0IK+QcVX5Da4Wu2rHui3mest/vCtHs+v9GuY+ey4bGENm6Up
 wqF/fkwK7tNmYNBrWsNkDdSmpfLak2VaFfRqwcdS4NCcUPbDtPXin5ijO1ezNwPT7oEg6PkVnaW
 f87mCHd0QPF93MOCsUl8U9Df39Wloe9QZ9pn5Qh3a8IxJX9nxxcrP/dnBkXQIpbEnMwOII2doic
 nGobn0vQq2v1+Tte0V5hS7paQolA2IsyHfUwblLJ1yb/tn9rrbCWB9Rq9ImCTx4IKaI9FVqGJ9a
 dAcZaW+8Jd/xeFwQMRsnwVu+PsJPMpjrTC+4vx3/kBvqMK+e6RAK1aY+r0aoYBBUa2Y5MuwgBLa
 RR6JGDAO1eFUay9tABD0VU6VeHb2lT6izYKhi1FZSHW6IRa1W07dDTNQQtQZG2Wws9ATEcvliuP
 X+8G5QzMhXHdSUh6n53+4ZJ7xH7hHjvCv6rwtGcyAzueVoTDbNPk+COndQwODT8MomTTLf8zNva
 hIoHT6MEounK8Z+iGtLxmFv6ed3+RmrX0Ewuwvo315qpZIX2EpIsorjuZBuzuM/nSU8QDc+HsnT
 PWxuBI7PWu2MliA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Remove unused error path (label+goto) to make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/intel_ace2x.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 4f78b7f99e44..f0008ff84ab4 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -325,11 +325,8 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 		dir = SDW_DATA_DIR_TX;
 
 	pdi = sdw_cdns_alloc_pdi(cdns, &cdns->pcm, ch, dir, dai->id);
-
-	if (!pdi) {
-		ret = -EINVAL;
-		goto error;
-	}
+	if (!pdi)
+		return -EINVAL;
 
 	/* use same definitions for alh_id as previous generations */
 	pdi->intel_alh_id = (sdw->instance * 16) + pdi->num + 3;
@@ -350,7 +347,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 				  sdw->instance,
 				  pdi->intel_alh_id);
 	if (ret)
-		goto error;
+		return ret;
 
 	sconfig.direction = dir;
 	sconfig.ch_count = ch;
@@ -361,10 +358,8 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 
 	/* Port configuration */
 	pconfig = kzalloc(sizeof(*pconfig), GFP_KERNEL);
-	if (!pconfig) {
-		ret =  -ENOMEM;
-		goto error;
-	}
+	if (!pconfig)
+		return -ENOMEM;
 
 	pconfig->num = pdi->num;
 	pconfig->ch_mask = (1 << ch) - 1;
@@ -375,7 +370,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 		dev_err(cdns->dev, "add master to stream failed:%d\n", ret);
 
 	kfree(pconfig);
-error:
+
 	return ret;
 }
 

-- 
2.43.0


