Return-Path: <linux-kernel+bounces-334985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5594397DF63
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 00:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872171C20B65
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F78216DEBD;
	Sat, 21 Sep 2024 22:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="sX6GAVKn"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7505C1547C6
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 22:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.76.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726957272; cv=none; b=UWIuk2RRuLfgCOoBMdPIneCTIYF2kcSIoEHGaHL5Y3qLE2EvkJIS6YS3oajjUo6dezgx+CTBUGrwf+ZFyRenXmCnecPyob1+eA8W/jz9TToBDOs8aHUP4QVN/yBzZDcZRfQchoZIm6P6eW8U+xqXboMGFtQZZNHvbS4n4slFxJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726957272; c=relaxed/simple;
	bh=ji7KsBSQlNR/X346xRrdEqiQPAQT+NlXZdQr0aXDGVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcavc1afK7YVSGXA4y2Wq5YwrcKR6CEbBz6NXwzfQNM9YznKZTBe0xyjbKGg/cCYt0KUMVpW9a90Z/n0EsWWDKwuGIBIcO6lJXw37NgSWjJS9WBoK/H8oOlerz4lqCjxRxHAdT8ATRUxfYpkOwol5B4p082g8wvfwIypWJlmdd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=sX6GAVKn; arc=none smtp.client-ip=207.246.76.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1726957252; bh=8XVidTJxe1Ijnds0MNBHEWFnH2eEKvVTfDWt1cqAA5Q=;
 b=sX6GAVKnIhbByF5a0w2D3pfJpJS0QMar9ShPqOlepKOoNlTSd9B5t71Is4cLwO49fVp3g9xRl
 8GGOgyCEb+Zmbf5OqPBb3l+YdRH5TufOXIIzuVIV78bdoXSyAHd9e0nKXxMOlxGT6iTE/dwif+w
 yj8eUjOqQlIcO5z1AFytaEQXcSwlakSOSJApJKVv56Y6flGZKZ+jit4hDcNTw+Puc6ihCyh2998
 1BbWEpuS/r0qUrbixizgO3tNR7hyELhUPT6hG5HrCuY62nbiphNTLvKQ8lHkHVxYK1TPIhaBEfT
 Q/4S6d3v+ngk6USufMkTjOdqImE71Efsb9WnTkfgwFOQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/3] drm/rockchip: vop: Split rk3288-vop into big and lit
Date: Sat, 21 Sep 2024 22:20:03 +0000
Message-ID: <20240921222007.2301868-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240921222007.2301868-1-jonas@kwiboo.se>
References: <20240921222007.2301868-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 66ef46c318c10b4d4a165d2b

The Rockchip RK3288 SoC contain two different Visual Output Processor
(VOP) blocks, VOP_BIG and VOP_LIT. The VOP blocks support different max
output resolution, 3840x2160 and 2560x1600.

Add support for the compatible used to differentiate between VOP_BIG and
VOP_LIT, support for the old compatible is kept for compatibility with
older device tree.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 27 +++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index e2c6ba26f437..978db93cda33 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -762,7 +762,7 @@ static const struct vop_intr rk3288_vop_intr = {
 	.clear = VOP_REG(RK3288_INTR_CTRL0, 0xf, 8),
 };
 
-static const struct vop_data rk3288_vop = {
+static const struct vop_data rk3288_vop_big = {
 	.version = VOP_VERSION(3, 1),
 	.feature = VOP_FEATURE_OUTPUT_RGB10,
 	.intr = &rk3288_vop_intr,
@@ -772,14 +772,22 @@ static const struct vop_data rk3288_vop = {
 	.win = rk3288_vop_win_data,
 	.win_size = ARRAY_SIZE(rk3288_vop_win_data),
 	.lut_size = 1024,
-	/*
-	 * This is the maximum resolution for the VOPB, the VOPL can only do
-	 * 2560x1600, but we can't distinguish them as they have the same
-	 * compatible.
-	 */
 	.max_output = { 3840, 2160 },
 };
 
+static const struct vop_data rk3288_vop_lit = {
+	.version = VOP_VERSION(3, 1),
+	.feature = VOP_FEATURE_OUTPUT_RGB10,
+	.intr = &rk3288_vop_intr,
+	.common = &rk3288_common,
+	.modeset = &rk3288_modeset,
+	.output = &rk3288_output,
+	.win = rk3288_vop_win_data,
+	.win_size = ARRAY_SIZE(rk3288_vop_win_data),
+	.lut_size = 1024,
+	.max_output = { 2560, 1600 },
+};
+
 static const int rk3368_vop_intrs[] = {
 	FS_INTR,
 	0, 0,
@@ -1245,8 +1253,13 @@ static const struct of_device_id vop_driver_dt_match[] = {
 	  .data = &rk3066_vop },
 	{ .compatible = "rockchip,rk3188-vop",
 	  .data = &rk3188_vop },
+	{ .compatible = "rockchip,rk3288-vop-big",
+	  .data = &rk3288_vop_big },
+	{ .compatible = "rockchip,rk3288-vop-lit",
+	  .data = &rk3288_vop_lit },
+	/* rockchip,rk3288-vop kept for backward compatibility */
 	{ .compatible = "rockchip,rk3288-vop",
-	  .data = &rk3288_vop },
+	  .data = &rk3288_vop_big },
 	{ .compatible = "rockchip,rk3368-vop",
 	  .data = &rk3368_vop },
 	{ .compatible = "rockchip,rk3366-vop",
-- 
2.46.1


