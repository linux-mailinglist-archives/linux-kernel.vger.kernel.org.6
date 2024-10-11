Return-Path: <linux-kernel+bounces-361167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7721999A486
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11358B23576
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2D62185AB;
	Fri, 11 Oct 2024 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xh+xKkhe"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EC521949B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652179; cv=none; b=lBjUy1MGy8+Z1mJsBTtcV3ADzLOGZy39GqYsCvjT2U6Ogc6vZCeAjOtqfALyd0jAjoeqtWGIOUEL1f7yR+kNTYLH1K9jCbnjnKqgVXs1XRqCjY7LnY0aYQwBFlNUYyMmSn9/cMl8f6m1T6gehaKxm6WoE+Mf+c9ilW23e9zcZpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652179; c=relaxed/simple;
	bh=LOjFy6nhC3aizwmwdmZxS8fZ5JcV0IBn7h8Abb/dF2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQD/uEqB9vsshnlSDttU1WcGgY6WCTaX6a8TEvZtyDdFpTkuw/iXq880MnILXpKJFNBJrlPNfzRBhybQ0ej+N2lC3bxOJb5EPtsJkTXuy6WmniimgL8Cr0JST270lob6/sU8WccKfnARyyAYldVugcJtwHkBVRRtbbHqTy0mHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xh+xKkhe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431198c63cfso2087845e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728652175; x=1729256975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4tqipEDcglLmH5x1uziIV6m/c0LA+zbIAt3VXf+24i8=;
        b=xh+xKkhexw9rX/x9T2adXgB8hLZ350/W+/elHVF2FQDF1B6sXvkbEnZS5t0vLHI8AU
         5lfYd8aFJY7RQuu6+pHv037uLYbqShingfDs++R73E6z3zceCyZAPtDXGic18ufG/vA5
         1WoPmkUvLaoMSpyTwtHUoP2M89nwrFNFqJlIDlcI8uWizBLXKA/IDNs6vdlNRPkQyjHT
         uoUL3V9en7RxPiar9YbTyPbrOdfIqXKoIT+mCowxkwPGGkYyLgh+V7akft7Z4kiPqRW/
         ymb3DLiJIZOuuYW6ZLo2t9ctX/A5zIjgAGdKaOWlO8ZZewr3lDIyXlvhDjTlULbsFwKQ
         j0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652175; x=1729256975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tqipEDcglLmH5x1uziIV6m/c0LA+zbIAt3VXf+24i8=;
        b=kozfqj74jBKtpU7gLHkM5sIlhckXKm1u+nlXL7VjScbZZbdHceMM8YHO+J5jjZhjsT
         9bT8jMzsNXKyFMMKopXDOAzb3BAfk/dHF8/b4cSv0Ee6cjcONbA0PglcCm83HfPgMUNC
         nAYkTd9NtR3DwWbSFr+ibiSA9E9lO3NMZBxdD7uDUDHM1ohtkg/kW/FIUc9I1wjGWrDX
         kC+i56NgxJ3nz+kXutC1GvV3xy4mMO9UUSqKUA0oaU6xYbfpbrn04G0xSJfl22gVT8b/
         oUCZ8bRfeh47nbAvYhlteybVqSRHHfHrjY7MB5dgUdLGYbQUgz7w04/jyQ2dywYJLRn7
         umgw==
X-Forwarded-Encrypted: i=1; AJvYcCVK2fvG7wvJSyACeTYBZF8JGI03/W2ACOCSw38rHBsMfgDBpBQgBC1k6qPqGbfPtzd6lu1cSJ/uPyopI9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx26dOz1t0l7pfGnu84u7lRF9ZRKsgZtEOTXA4Vc82bDKqszQzn
	YrmvyI86uiFdukIWLglL5r8bl6JKJ3VSVTmEsTxE3XySM4cnfBsykFSfPnli8+qE1wLvEhQeXjB
	6
X-Google-Smtp-Source: AGHT+IFKtxHJuxqrekyPdhVBMnAlWiWOkLEWdXtd2C/g5nqBPrGrF0mq3N0p82Jf8eiRmrLVWZMY0g==
X-Received: by 2002:a05:600c:4e8e:b0:42c:b172:8c53 with SMTP id 5b1f17b1804b1-4311df39dbemr10197155e9.5.1728652175321;
        Fri, 11 Oct 2024 06:09:35 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ff6d3sm41621835e9.12.2024.10.11.06.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:09:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 11 Oct 2024 15:09:12 +0200
Subject: [PATCH 04/10] remoteproc: ti_k3_r5: Simplify with scoped for each
 OF child loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-remote-proc-dev-err-probe-v1-4-5abb4fc61eca@linaro.org>
References: <20241011-remote-proc-dev-err-probe-v1-0-5abb4fc61eca@linaro.org>
In-Reply-To: <20241011-remote-proc-dev-err-probe-v1-0-5abb4fc61eca@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1414;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=LOjFy6nhC3aizwmwdmZxS8fZ5JcV0IBn7h8Abb/dF2Y=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnCSOB0CGEefde0iTMWB7udlQSwZInx30X4Kvb1
 xaci8OKPlOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZwkjgQAKCRDBN2bmhouD
 14QfD/96TWKrcYSPmRKB4BTPF1jzofGRKzn6PAWJ2hGNnp6Yz5u1wCttzo2HZ12TATG4ftPErMV
 iKjQJ0aMt6Mn0TgPQziNxsgA1r01+69huM34pYvZe9jY5ceYXDDujOCHA5o/DQQdplSP6tdVmSP
 YmIsVwjEyw7mtp3A60wd1+0nqejGGvZafrhTblMa9I8KpJh17WegAe0VQoZnMY5Q2SrOeX2rrfa
 6BqhFws9hH59dYdY4COjIMMAaEKJ41wGj+MEfPAKdSdJxbedBHd336X26BY3RG6S2gSCB4GmdQm
 fT9uQVcn1QV7iqsAlZSYAECU87baYp5fhdsNX9EBxCVa2I8K+60u9YHYG7MbfxvZzLpACYe0SI4
 1EO2O12cZIoezt0X0GDusygBetTWmoJwHZWX/UseUzBeBYC8PmfOBeax+fu6duvgiqYx3pvOVj2
 Ow9tQgFulPnb7mKpYHJK9TsBCy9P6Rx3sbfysAOP6uBQ4W17OyBITcyCOmkYVA5Q7EPgtU+cFQ0
 oZNZPTvmFK5tbCEsoExuIjIjZDsyGQ4vaZwBnAY7UfymJZcc1y0ZKJj5E/YVbHKlcVEt1MYlRSS
 fJwgqFenhw5qe/zLo78bv8rI3epakm3/Aice2YPdffHpbZ/3ejVZ7nFdrX4a74G6cVrlSADi5MP
 +45R/x9dXwBY+Lw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/remoteproc/ti_k3_r5_remoteproc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 5a2e0464e1b81e3d4571a466643f08a53ebefc0d..2f996a962f55755347e599551f8b7785b986d0dd 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -1650,16 +1650,14 @@ static int k3_r5_cluster_of_init(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev_of_node(dev);
 	struct platform_device *cpdev;
-	struct device_node *child;
 	struct k3_r5_core *core;
 	int ret;
 
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		cpdev = of_find_device_by_node(child);
 		if (!cpdev) {
 			ret = -ENODEV;
 			dev_err(dev, "could not get R5 core platform device\n");
-			of_node_put(child);
 			goto fail;
 		}
 
@@ -1668,7 +1666,6 @@ static int k3_r5_cluster_of_init(struct platform_device *pdev)
 			dev_err(dev, "k3_r5_core_of_init failed, ret = %d\n",
 				ret);
 			put_device(&cpdev->dev);
-			of_node_put(child);
 			goto fail;
 		}
 

-- 
2.43.0


