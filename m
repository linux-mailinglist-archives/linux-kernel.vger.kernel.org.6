Return-Path: <linux-kernel+bounces-189865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 769F38CF5F5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 22:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371601F21209
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 20:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF001139D07;
	Sun, 26 May 2024 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RswYs/pC"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA89139D00
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716754939; cv=none; b=HROtabNArmn2oI/hILU3RwyKb5GdXSY3u3KAU1uBbzOxSSSnDC3c8srivRxEuakc82Sh02u1bKeTqjgk+N6wGqQTGoeK+s4wdmepR1kZ0ZsILH1p9DMjc3J4pyWdePy2T6DJ7gHMeXSz+Afc6m6EUfgkEFNP68M1dEYkAWadcXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716754939; c=relaxed/simple;
	bh=yjXrCCEzHaobC15HySaJokFi2Tyu6bbB2BhMaQiRkYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EsMRSFN8de+ne2bJGsfG/O1/5yvIYiZy20XYjKLWHJtW59PVzZvDA5aLBcHV2sWILbm8Upste7Z8jRK0S/9r8BrBRODWlxoZxUmohaFL1SGvoDBfJwTNhNmu8QER3cArFnDmLC4QRKYSRQJa/zkw967WZ8GPv649o6Nc0a04WL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RswYs/pC; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: rfoss@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716754936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHEGEyR5HKYcrfD9JBIV0ziW1Rx1W7V/ic0nMRKrGeo=;
	b=RswYs/pCIv6lZwAAqKNacSfmf+2Q8+53Xm8HjQQyAgDzWNkXljRxyLKTiti8KPHXvk/06H
	GMWBhTIghuoScRfT7eBtzJKFsl7wWFWHDyvCrlKIzF31M6rtWRFo78I4JHixpOasmTqgF8
	TmZmtGzjItU+Eu169oGIzVKSaiwaJA4=
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: sui.jingfeng@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v6 10/10] drm/bridge: ch7033: Switch to use fwnode based APIs
Date: Mon, 27 May 2024 04:21:15 +0800
Message-Id: <20240526202115.129049-11-sui.jingfeng@linux.dev>
In-Reply-To: <20240526202115.129049-1-sui.jingfeng@linux.dev>
References: <20240526202115.129049-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use the freshly created helper to replace the use of DT-dependent APIs,
also print error log if the fwnode graph is not complete which is benefit
to debug.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/chrontel-ch7033.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/chrontel-ch7033.c b/drivers/gpu/drm/bridge/chrontel-ch7033.c
index c6374440af7f..35dd2e6ba6c0 100644
--- a/drivers/gpu/drm/bridge/chrontel-ch7033.c
+++ b/drivers/gpu/drm/bridge/chrontel-ch7033.c
@@ -531,6 +531,7 @@ static const struct regmap_config ch7033_regmap_config = {
 static int ch7033_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct ch7033_priv *priv;
 	unsigned int val;
 	int ret;
@@ -541,10 +542,15 @@ static int ch7033_probe(struct i2c_client *client)
 
 	dev_set_drvdata(dev, priv);
 
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, -1, NULL,
-					  &priv->next_bridge);
-	if (ret)
+	priv->next_bridge = drm_bridge_find_next_bridge_by_fwnode(fwnode, 1);
+	if (IS_ERR(priv->next_bridge)) {
+		ret = PTR_ERR(priv->next_bridge);
+		dev_err(dev, "Error in founding the next bridge: %d\n", ret);
 		return ret;
+	} else if (!priv->next_bridge) {
+		dev_dbg(dev, "Next bridge not found, deferring probe\n");
+		return -EPROBE_DEFER;
+	}
 
 	priv->regmap = devm_regmap_init_i2c(client, &ch7033_regmap_config);
 	if (IS_ERR(priv->regmap)) {
-- 
2.34.1


