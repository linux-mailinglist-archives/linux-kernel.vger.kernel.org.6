Return-Path: <linux-kernel+bounces-348754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A587698EB76
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BFA11F21579
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5574A126BE1;
	Thu,  3 Oct 2024 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="no0dPUdq"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14390145A1C
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943623; cv=none; b=c/DTbSoNQ3IERbn1El7UHrPGd7xm6OA0GxCEhJFfIR/yOag3CH3sL3P5rxD4/SjCAED8t4AbHpNUmp5g0FBEZWxrT4A5EwF5+Qp1sHpF+79x2maeiJauBtJ4gaw6jyxn5eujyUHDM9sn6Boje33ELaH+rx9WbEu4TETD4LCajs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943623; c=relaxed/simple;
	bh=sxyZYTd0fVH8Bz2Z150K40EjOVFNrgi/e8yOxKsM44g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KuaKCU6yDf0cO4i43/Q+XsbynObkfck7IMAeJdwgv69qdMH8jF4ULcSXFVMLW/kwSLN4cq+m3T8UPDn3tTEG0ApLp+p4BtNaUW312OAQ6oG0/YuYubM1g/d+PirZrsJx5QoeZjKZCyrJBNCHTgHW/I/nt/F1FlBeWkEh9UJqCbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=no0dPUdq; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1727943616; x=1730535616;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sxyZYTd0fVH8Bz2Z150K40EjOVFNrgi/e8yOxKsM44g=;
	b=no0dPUdqGTceOIJbgnF/CYO8zvYgGGfFrJDh8FdV4ugW7sqoJ7U+eaM2xksCtTo8
	Hf1f/P5fnqrwH+pdRkwr7SJWcivbzjstr6aGKvVE4s3yY7DUYYvsrnFCs4ka55cU
	aIB07C+faZw/uApTYjI7eV6asd5IvvV141E0ztXJj9s=;
X-AuditID: ac14000a-4577e70000004e2a-9e-66fe53c0951f
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id FE.F4.20010.0C35EF66; Thu,  3 Oct 2024 10:20:16 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 3 Oct 2024
 10:20:15 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>
CC: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<bbrezillon@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
	<robh@kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH 1/2] drm/bridge: sii902x: Provide data-lines property to input endpoint
Date: Thu, 3 Oct 2024 10:20:05 +0200
Message-ID: <20241003082006.2728617-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWyRpKBR/dA8L80gx8XmC1OXF/EZHF/8WcW
	i9Ut0xkt1uw9x2Qx/8g5VosrX9+zWTyfv47R4uSbqywWL2fdY7PonLiE3eLyrjlsFgs/bmWx
	aOtcxmrxfuctRotJ826yWvzfs4PdYva7/ewWW95MZLXofqfuIOyx99sCFo+ds+6ye8zumMnq
	sXjPSyaPTas62TxOTLjE5HHn2h42j3knAz3udx9n8ujvbmH12Hy62uPzJrkAnigum5TUnMyy
	1CJ9uwSujMcts9gKGoUqrjd8YGlgvMXXxcjJISFgIrFg/jKWLkYuDiGBJUwS3x7NgHIeMUos
	nH2eHaSKTUBd4s6Gb6wgtoiAn8StL/vYQYqYBTYxS3x+vRssISwQLrH2ZycTiM0ioCKxqusb
	mM0rYClxb+IfVoh18hIzL31nh4gLSpyc+YQFxGYGijdvnc0MYUtIHHzxAswWAoq/uLScBaZ3
	2rnXzBB2qMTWL9uZJjAKzEIyahaSUbOQjFrAyLyKUSg3Mzk7tSgzW68go7IkNVkvJXUTIyg2
	RRi4djD2zfE4xMjEwXiIUYKDWUmEd972v2lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVd3BKcK
	CaQnlqRmp6YWpBbBZJk4OKUaGDXWb/28XbjNYO7Z6ktfX9oYPk0LFFBcfelw2JcrZwWWLz99
	5/eOY28muDs+1jXNXHhwqvIiT7av4Z0sx14osHEv/uXf9nHWN67tX+8sUePbaCvE7m73QvWm
	nPxEPhY10/5zV5YLHQlbUaCU/HrzL42zDzsMfaSzpsiev3LD7/VEnSzXeld/mxolluKMREMt
	5qLiRABN4QS9uwIAAA==

Introduce a data-lines property to define the number of parallel RGB
input pins connected to the transmitter. The input bus formats are updated
accordingly. If the property is not specified, default to 24 data lines.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 drivers/gpu/drm/bridge/sii902x.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 7f91b0db161e..3565c3533597 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -180,6 +180,8 @@ struct sii902x {
 	struct gpio_desc *reset_gpio;
 	struct i2c_mux_core *i2cmux;
 	bool sink_is_hdmi;
+	u32 pd_lines; /* number of Parallel Port Input Data Lines */
+
 	/*
 	 * Mutex protects audio and video functions from interfering
 	 * each other, by keeping their i2c command sequences atomic.
@@ -477,6 +479,8 @@ static u32 *sii902x_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 						     u32 output_fmt,
 						     unsigned int *num_input_fmts)
 {
+
+	struct sii902x *sii902x = bridge_to_sii902x(bridge);
 	u32 *input_fmts;
 
 	*num_input_fmts = 0;
@@ -485,7 +489,19 @@ static u32 *sii902x_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	if (!input_fmts)
 		return NULL;
 
-	input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
+	switch (sii902x->pd_lines) {
+	case 16:
+		input_fmts[0] = MEDIA_BUS_FMT_RGB565_1X16;
+		break;
+	case 18:
+		input_fmts[0] = MEDIA_BUS_FMT_RGB666_1X18;
+		break;
+	default:
+	case 24:
+		input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
+		break;
+	}
+
 	*num_input_fmts = 1;
 
 	return input_fmts;
@@ -1167,6 +1183,15 @@ static int sii902x_probe(struct i2c_client *client)
 		return PTR_ERR(sii902x->reset_gpio);
 	}
 
+	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 0, -1);
+	if (endpoint) {
+		ret = of_property_read_u32(endpoint, "data-lines", &sii902x->pd_lines);
+		if (ret) {
+			dev_dbg(dev, "Could not get data-lines, fallback to 24 data-lines\n");
+			sii902x->pd_lines = 24;
+		}
+	}
+
 	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 1, -1);
 	if (endpoint) {
 		struct device_node *remote = of_graph_get_remote_port_parent(endpoint);
-- 
2.34.1


