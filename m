Return-Path: <linux-kernel+bounces-198425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7C48D780E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C5B8B24255
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 20:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C1779B7E;
	Sun,  2 Jun 2024 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="KLoThVaU"
Received: from mail-108-mta161.mxroute.com (mail-108-mta161.mxroute.com [136.175.108.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B8886250
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717359661; cv=none; b=nY/Iqgco0l9M1TAHVni5flITqmGNJDnXF5N8KfhCQH/bwP+rQx+Ctns9jNGzY+KcVWkVmUUJlkEwi9zAOtKsFFIWFOAVZEaNt/OXy2P+pcJ/uDn5xu62cS4SKGS2i8cvx/i/zWGyQs+XQxSaDWLX5SsK8ugwiGLxHrrSOVCiuF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717359661; c=relaxed/simple;
	bh=JYMoAdAi23Rqjp24EgQA29VoTvbC/LV/zcwHywbUEuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUbDeBCzdYcy2b2g5dZEdsb6b07Kj0EFZGVYb6/lBnho8eQwO7ILFyQxKiz7RN0sYZQvZf11tIw1vrFXVJEMTaatYQkEDl0iFjoejMxcqAT+mpM8nj/3UWASucYz5kougz4OoK6Fh9CW5AUFV0dhc4UU20It84d040IIkWGV/64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=KLoThVaU; arc=none smtp.client-ip=136.175.108.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta161.mxroute.com (ZoneMTA) with ESMTPSA id 18fda970331000e2b6.011
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 02 Jun 2024 20:14:40 +0000
X-Zone-Loop: b1d007cc0c9b689e49ea4edc444d878d3298f0f84f11
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7NXcrc70rKMeNobbsr89/2dWktagLdq0/zNwjdJVzYE=; b=KLoThVaUbxr6nNb4nYxZrXrGIN
	QFiuDvHA3jeHhzLf3YUxW24U3fuaXHIyeHWYp+PduEMjWs13tn1R6fS/kaNfxTDYrIuZTP6YCWWRE
	M2mdOLiins20TuRdipId6Bmx7TvDecW/dXLOYN3m5Y1Jjhxe2OhrNOdhAbkI+DG75At03a1Q+4IcH
	IRX/IHNAxBV3a6k17ptKaC57V2F4o0BPecPQRPZICdjPZj5BKrnHQ4OSXQ7QX1ZwKfvo5SiN68yv6
	KTngAakph8sy/B/2OY4kmlqn10jNz3gcNAeZK9lIBVKbDeIFeqpXQDKZzeYk9hlw/foVOr4U13CHY
	3e+KGmJg==;
From: git@luigi311.com
To: linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pavel@ucw.cz,
	phone-devel@vger.kernel.org,
	Luis Garcia <git@luigi311.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>
Subject: [PATCH v6 22/23] media: i2c: imx258: Use v4l2_link_freq_to_bitmap helper
Date: Sun,  2 Jun 2024 14:13:44 -0600
Message-ID: <20240602201345.328737-23-git@luigi311.com>
In-Reply-To: <20240602201345.328737-1-git@luigi311.com>
References: <20240602201345.328737-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Luis Garcia <git@luigi311.com>

Use the v4l2_link_freq_to_bitmap() helper to figure out which
driver-supported link freq can be used on a given system.

Signed-off-by: Luis Garcia <git@luigi311.com>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/media/i2c/imx258.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index 671fe176c64c..e9abf6b96aec 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -693,6 +693,7 @@ struct imx258 {
 	/* Current mode */
 	const struct imx258_mode *cur_mode;
 
+	unsigned long link_freq_bitmap;
 	const struct imx258_link_freq_config *link_freq_configs;
 	const s64 *link_freq_menu_items;
 	unsigned int lane_mode_idx;
@@ -1546,6 +1547,17 @@ static int imx258_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	ret = v4l2_link_freq_to_bitmap(&client->dev,
+				       ep.link_frequencies,
+				       ep.nr_of_link_frequencies,
+				       imx258->link_freq_menu_items,
+				       ARRAY_SIZE(link_freq_menu_items_19_2),
+				       &imx258->link_freq_bitmap);
+	if (ret) {
+		dev_err(&client->dev, "Link frequency not supported\n");
+		goto error_endpoint_free;
+	}
+
 	/* Get number of data lanes */
 	switch (ep.bus.mipi_csi2.num_data_lanes) {
 	case 2:
-- 
2.44.0


