Return-Path: <linux-kernel+bounces-269793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 188F29436EE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39C61F22248
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2655316C84D;
	Wed, 31 Jul 2024 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdP9yCjo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3E16C6B5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456880; cv=none; b=Kv8CYvi6ftWbu//HcgpcYyTMQ0iN0Jd+hUInLCGGRUMZAJp/wm2a5HlWpu/Z9aCToEG0m8bZkzQUfGUdihBGHEx20HYpOh+W+euTYfGFhW3+Cgtkj9lEh8iu6mlerI5G3kevXFsc4/RnKL892iYbkRSY9nXo2vLCZ2LNArL84c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456880; c=relaxed/simple;
	bh=+JRx7YZVVmat6vfPo2gFiywJDPLdH779FTMjtYnw98k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JHi51gvwJY1McnfkzOBqHRxlFkAvpFkVa9Ps9iyTza/v60ZcyvoRQMkd7OVEvgto1H9KxQITvJI8/fZ45sZM6kH2JqnWxKQaXnJtxPd+qf3IyYALIK3V7dShm8mUuQO+GRDbD4XyKZuoImQiRRbxAxiDR4FgsumgdlYPZnTLccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdP9yCjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8606C116B1;
	Wed, 31 Jul 2024 20:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722456880;
	bh=+JRx7YZVVmat6vfPo2gFiywJDPLdH779FTMjtYnw98k=;
	h=From:To:Cc:Subject:Date:From;
	b=PdP9yCjoLHeWQmDDclv8rVkTxnbNwPeLTuJAoqytzWqQtzob1vH5akCSnbuC5dbmU
	 AjHzucZDOw0LD05kvg8kA3Vq+8RM7z7/lNgi8mP/VS/Vl+kmWjS+94Lt3h2mWEdL8H
	 7P67K+ByRgplB7CQ/dpP/lk+tI+yzack0Eqtf1COWqe6BWlQZa1tkM87Oq1ApK2Z29
	 Gjc+mXeuY99SDeWuGbqYJjcUYRZa+JjUtYhXrAQKbSRgGt8iLjd6QOTN0zInS72CLC
	 ToHLXhotuMYepBiHPpudfVrQgGG8CyWzn0FSFva5RDTBqgd6SA4ZxkkLwvrmjXCPCO
	 fDURP5oCkqVtg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: bridge: anx7625: Use of_property_read_variable_u8_array()
Date: Wed, 31 Jul 2024 14:13:59 -0600
Message-ID: <20240731201407.1838385-4-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need to get the length of an DT array property before
parsing the array. of_property_read_variable_u8_array() takes a minimum
and maximum length and returns the actual length (or error code).

This is part of a larger effort to remove callers of of_get_property()
and similar functions. of_get_property() leaks the DT property data
pointer which is a problem for dynamically allocated nodes which may
be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 88e4aa5830f3..a2e9bb485c36 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1647,25 +1647,15 @@ static int anx7625_get_swing_setting(struct device *dev,
 {
 	int num_regs;
 
-	if (of_get_property(dev->of_node,
-			    "analogix,lane0-swing", &num_regs)) {
-		if (num_regs > DP_TX_SWING_REG_CNT)
-			num_regs = DP_TX_SWING_REG_CNT;
-
+	num_regs = of_property_read_variable_u8_array(dev->of_node, "analogix,lane0-swing",
+						      pdata->lane0_reg_data, 1, DP_TX_SWING_REG_CNT);
+	if (num_regs > 0)
 		pdata->dp_lane0_swing_reg_cnt = num_regs;
-		of_property_read_u8_array(dev->of_node, "analogix,lane0-swing",
-					  pdata->lane0_reg_data, num_regs);
-	}
-
-	if (of_get_property(dev->of_node,
-			    "analogix,lane1-swing", &num_regs)) {
-		if (num_regs > DP_TX_SWING_REG_CNT)
-			num_regs = DP_TX_SWING_REG_CNT;
 
+	num_regs = of_property_read_variable_u8_array(dev->of_node, "analogix,lane1-swing",
+						      pdata->lane1_reg_data, 1, DP_TX_SWING_REG_CNT);
+	if (num_regs > 0)
 		pdata->dp_lane1_swing_reg_cnt = num_regs;
-		of_property_read_u8_array(dev->of_node, "analogix,lane1-swing",
-					  pdata->lane1_reg_data, num_regs);
-	}
 
 	return 0;
 }
-- 
2.43.0


