Return-Path: <linux-kernel+bounces-301244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0499C95EE27
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45238B23082
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C441474B2;
	Mon, 26 Aug 2024 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x2ewway8"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A915574D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666872; cv=none; b=CBZNDHCQiKApHhCdY4X0vy6BNsiZqP+gKv2ydXnYRQhQCo4ui+oI00S0RqFiYx6qMZOJoTZSbYuP3GlcMX9PDnir7S//XQIpA4GjaKz4tli8M4A244EEuGzoNlRo62tlGudJJTU+bfSuws30X3av4GuK3/o2LHslcKQ0vGInq5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666872; c=relaxed/simple;
	bh=w0e0ayjuNxyXuvAWm5UI9oSMx8HCNPzhkU4MAGzlhMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PkkHF9H+oDyG+YOQOQjBIefmD5EeH3NG5L5pwP/ggbLWeitsgyTOfJlNQPhtbrqhpw3uu6YRfkDynDjkCD+buTQ0MnBsDFvXtjB/QoODTumhwIH7H9z4JP+TbSLDfqTS/Ji0KoV4CSaflFyPvmGoREYcA2csZ/WuKx3QY1hxqKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x2ewway8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4280772333eso6336135e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724666869; x=1725271669; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKZlzL2NZbeJxSHQJB09JnhRjfM+R/bIijlH4cu5cME=;
        b=x2ewway8vYHUVVz8gYaksnyGnLgGFMWUNVApnTxIWB+lMr0tiFQUejkGDHF3MT/Gom
         Tj4AF9ix5Gu/evwlbsr5JpY5BZKSYsJKOHxqYsQou33g8DC7ev+UTCwfeHK1txI7ctXi
         tGCR/Qi2U9aEeooYP9bqkBX0tMUGObLSzlNLalZQKVien+Jp9iCDBtNTMHKufVEbv9U9
         FygF/4SzDTMJEVg0orIpFXzxgVoUyj1xqbuLXg5Ck1cGVJMD3Kvb97qx6seeKpmt/H00
         XraKS3ERjDmYo4iJEg960yulR9nvpMGaQg5GoH6mMvGpg0QUeoqRxc3gXtTr6GfNn80Z
         kSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724666869; x=1725271669;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKZlzL2NZbeJxSHQJB09JnhRjfM+R/bIijlH4cu5cME=;
        b=TJvgGa9KfZ/2nFDy9DgfLizvYk3Wr2B+2uVPsiQMeoAIJqRS5Tq/NFGZHVY77VMqLo
         oip2JkbfUvW6zVWH4IcU8arASUif/IMlKbon+9KaaCd/kRXxWKi+tgKr3zD+/zoCUUSI
         zbGe28xonMuOBdGj4aIqphvkQSCt8rHgUZFLjbG0LZ59tTgcaGHUcQydyg8Qbdtnqd19
         +RdhqBVffaaF/s8yx4MIpCcvwh6KRGpkBBTzwDeiEJWhPf1doiszWQoTpcud6vdUGJJZ
         h052lwC5hP27s2bJfI6qjnDrHGqQf2n/r4gc+T95CzNz4ie1CxTvakcNNmfdKRHQrFup
         sZFA==
X-Forwarded-Encrypted: i=1; AJvYcCX8T9QRCNbfZuc4giA6veeT4FCVMRKGzrZh+IhPXNCRjEX5mBVejW45JHT/Kr99OGLi0QqRJtDcgyUyV5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlLlLbEY1Y6N8rEx/2okIl50UGuJmRaZafbBlL9b3M05bB3r3r
	c0nPpWQP1Jv7FdEDlmh9kV1hU5Tp3to/H3z/datFSoA3IiJ+BHbgaPIUsOpeRBU=
X-Google-Smtp-Source: AGHT+IHpsbxr2jatXOo5ggzUHc4AhIIKQUY/zOn1ZCBV5PQBOfgESp9ARtTvX8s+q9//U0p353spAQ==
X-Received: by 2002:a5d:6481:0:b0:360:872b:7e03 with SMTP id ffacd0b85a97d-373117ba829mr3896712f8f.0.1724666868800;
        Mon, 26 Aug 2024 03:07:48 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308110009sm10324821f8f.18.2024.08.26.03.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 03:07:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 26 Aug 2024 12:07:27 +0200
Subject: [PATCH 11/11] phy: ti: j721e-wiz: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-phy-of-node-scope-v1-11-5b4d82582644@linaro.org>
References: <20240826-phy-of-node-scope-v1-0-5b4d82582644@linaro.org>
In-Reply-To: <20240826-phy-of-node-scope-v1-0-5b4d82582644@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=w0e0ayjuNxyXuvAWm5UI9oSMx8HCNPzhkU4MAGzlhMQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmzFPiG/KFFJ/l+/AwfobhDy9BkMVA4hidPlmBJ
 BxVdEXyoG+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZsxT4gAKCRDBN2bmhouD
 14gOD/4gnPbwGuH5BNBzq+9rK8+/r4dwG7A1IcyXYdYsWfau5R0tw2zv23PLPhzCYNA50n6txqT
 C4oU6FGzQV4QlgWI1kYnfzSqQc7rg4Nbfz7nqCcF3C/fDdThpmB+v3jVhkB1y9gGVsyYA0zOBYt
 iVU9WqZPPrtIfMWHBnMxl0/Sh26CUVyzVG5ZPow20y9RExDuAPrlJvqePRWEBPx+vPRvAccLzHB
 BeEfmlJPUx/fowwJgvDdGBVWbEUexJJ7JqOr2GM870FVsgCuH4/gkQrmcL5XT5FvZt+i8/yDGVn
 P3MN2mJLs7+gzgLsOGkre8R6zBEO5q95XUix1+S2pQyAp9oDk618h2nK06X87jmXPfm0c8Wsg4Y
 iRQ9GqsZh45L3QI4hsGT2nIlOYshaS1/9UQ3n2dnRVUaLgV5PG1IzZA2itCWcC+HFgvqaqIrYBI
 rlAS4yWLacWX1JmJ7AKfX4zwwkeZDvspdoqTZ5NS7anNEMA9TSw5PHj0iNvRr/ardFTQx/kt9Rt
 Uy1Yfn/QQWQCIZWYwWVopcjVmB01bpBhRV9iVoBnAWXao7pnQa4SmaZeNNupsIO/Z1wFPV7Bqjb
 PqeKkzw1ByOii2k+UDDiHn+jkwVSkOC/G+itzuyQ/ojBpWAgMS7kpNDOS/AeogFPFk9jrG9p/CG
 8Y6+jVZpDl7Mm8w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/phy/ti/phy-j721e-wiz.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index d0f3ead3fc80..a6c0c5607ffd 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -1404,7 +1404,7 @@ MODULE_DEVICE_TABLE(of, wiz_id_table);
 
 static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
 {
-	struct device_node *serdes, *subnode;
+	struct device_node *serdes;
 
 	serdes = of_get_child_by_name(dev->of_node, "serdes");
 	if (!serdes) {
@@ -1412,7 +1412,7 @@ static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
 		return -EINVAL;
 	}
 
-	for_each_child_of_node(serdes, subnode) {
+	for_each_child_of_node_scoped(serdes, subnode) {
 		u32 reg, num_lanes = 1, phy_type = PHY_NONE;
 		int ret, i;
 
@@ -1422,7 +1422,6 @@ static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
 
 		ret = of_property_read_u32(subnode, "reg", &reg);
 		if (ret) {
-			of_node_put(subnode);
 			dev_err(dev,
 				"%s: Reading \"reg\" from \"%s\" failed: %d\n",
 				__func__, subnode->name, ret);

-- 
2.43.0


