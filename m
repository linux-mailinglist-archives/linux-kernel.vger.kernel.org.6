Return-Path: <linux-kernel+bounces-510814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B7BA32266
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396CE188ABAF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC2320897D;
	Wed, 12 Feb 2025 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R1e0waUI"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AED1206F19;
	Wed, 12 Feb 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352987; cv=none; b=LcYe4U0S43zMeLBbyqrDFg4gpwINUQwOsdrHyeej5/uqvZo80rP83MKxdGLtKBNIO8aOySOfsDQiJ1QxmgZa5oatmRYYER2+G4FL3qNSSGNiZo8OBqlNP+AvvEGTwrny4UvhryEkmD+uXtuvOkxIBOL8wIY55fWAdLbh0jntiaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352987; c=relaxed/simple;
	bh=tib8//zuKJKEhJG3kxu0c5Y3VhlvqZlKQq1YajL1fnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNLnu0ujtEdQKL49fP+tSJ/bqRhaatbpCmnZVUxBk7cbTIfACsukcoDHk69Ywbdc1FthrQzOuutv1jF3TQWtdpwRKFzARfEFBOkjvizCRce9sL91jvAtN0gj/2dGZ7jw34gYWUPslC7Z9gZFpoYg4vTc7CvvFswiIc8MJ6tLx4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R1e0waUI; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=l6drU
	h2vkH8RFHOt/j1F+EFHKFzeB3WYinyBTPKLRVM=; b=R1e0waUINkeu1t+TME29x
	E7wim2L2w4DbmO5N68XLALovPgsE0pJGrzV/vqNvFRaTclSTulCOsg0tBZIklQtc
	QdqHg7rUNULf8eq5NsDR1uIaAYPr8jP4Fdc5Q72l0yO6b0mHpC3aC0JZ0plG7+3m
	lMNpfRbTitAkTPJRROolO0=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBnG9Fja6xn14FuLQ--.33700S3;
	Wed, 12 Feb 2025 17:35:36 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	detlev.casanova@collabora.com,
	daniel@fooishbar.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v14 01/13] drm/rockchip: vop2: use devm_regmap_field_alloc for cluster-regs
Date: Wed, 12 Feb 2025 17:34:56 +0800
Message-ID: <20250212093530.52961-2-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212093530.52961-1-andyshrk@163.com>
References: <20250212093530.52961-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnG9Fja6xn14FuLQ--.33700S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFW7GFWUWrykJr4fGF17Wrg_yoWrZr4xpF
	4rCwnxuF45Grn29rWkArn8AF1Fk39rta1rCFn7uwnI9r1qgr97C3Wqk3Wjyrs0kryv9FZr
	tFs8t3y3ua4Ygr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uu6wtUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQjxXmesZ5VJpgABsZ

From: Heiko Stuebner <heiko@sntech.de>

Right now vop2_cluster_init() copies the base vop2_cluster_regs
and adapts the reg value with the current window's offset before
adding the fields to the regmap.

This conflicts with the notion of reg_fields being const, see
https://lore.kernel.org/all/20240706-regmap-const-structs-v1-1-d08c776da787@weissschuh.net/
for reference, which now causes checkpatch to actually warn about that.

So instead of creating one big copy and changing it afterwards,
add the reg_fields individually using devm_regmap_field_alloc().

Functional it is the same, just that the reg_field we're handling
can stay const.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 66 +++++++++-----------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index afc946ead870..ebc9cb93073c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -3400,7 +3400,7 @@ static int vop2_find_rgb_encoder(struct vop2 *vop2)
 	return -ENOENT;
 }
 
-static struct reg_field vop2_cluster_regs[VOP2_WIN_MAX_REG] = {
+static const struct reg_field vop2_cluster_regs[VOP2_WIN_MAX_REG] = {
 	[VOP2_WIN_ENABLE] = REG_FIELD(RK3568_CLUSTER_WIN_CTRL0, 0, 0),
 	[VOP2_WIN_FORMAT] = REG_FIELD(RK3568_CLUSTER_WIN_CTRL0, 1, 5),
 	[VOP2_WIN_RB_SWAP] = REG_FIELD(RK3568_CLUSTER_WIN_CTRL0, 14, 14),
@@ -3471,28 +3471,26 @@ static struct reg_field vop2_cluster_regs[VOP2_WIN_MAX_REG] = {
 static int vop2_cluster_init(struct vop2_win *win)
 {
 	struct vop2 *vop2 = win->vop2;
-	struct reg_field *cluster_regs;
-	int ret, i;
-
-	cluster_regs = kmemdup(vop2_cluster_regs, sizeof(vop2_cluster_regs),
-			       GFP_KERNEL);
-	if (!cluster_regs)
-		return -ENOMEM;
-
-	for (i = 0; i < ARRAY_SIZE(vop2_cluster_regs); i++)
-		if (cluster_regs[i].reg != 0xffffffff)
-			cluster_regs[i].reg += win->offset;
+	int i;
 
-	ret = devm_regmap_field_bulk_alloc(vop2->dev, vop2->map, win->reg,
-					   cluster_regs,
-					   ARRAY_SIZE(vop2_cluster_regs));
+	for (i = 0; i < ARRAY_SIZE(vop2_cluster_regs); i++) {
+		const struct reg_field field = {
+			.reg = (vop2_cluster_regs[i].reg != 0xffffffff) ?
+					vop2_cluster_regs[i].reg + win->offset :
+					vop2_cluster_regs[i].reg,
+			.lsb = vop2_cluster_regs[i].lsb,
+			.msb = vop2_cluster_regs[i].msb
+		};
 
-	kfree(cluster_regs);
+		win->reg[i] = devm_regmap_field_alloc(vop2->dev, vop2->map, field);
+		if (IS_ERR(win->reg[i]))
+			return PTR_ERR(win->reg[i]);
+	}
 
-	return ret;
+	return 0;
 };
 
-static struct reg_field vop2_esmart_regs[VOP2_WIN_MAX_REG] = {
+static const struct reg_field vop2_esmart_regs[VOP2_WIN_MAX_REG] = {
 	[VOP2_WIN_ENABLE] = REG_FIELD(RK3568_SMART_REGION0_CTRL, 0, 0),
 	[VOP2_WIN_FORMAT] = REG_FIELD(RK3568_SMART_REGION0_CTRL, 1, 5),
 	[VOP2_WIN_DITHER_UP] = REG_FIELD(RK3568_SMART_REGION0_CTRL, 12, 12),
@@ -3559,26 +3557,24 @@ static struct reg_field vop2_esmart_regs[VOP2_WIN_MAX_REG] = {
 static int vop2_esmart_init(struct vop2_win *win)
 {
 	struct vop2 *vop2 = win->vop2;
-	struct reg_field *esmart_regs;
-	int ret, i;
-
-	esmart_regs = kmemdup(vop2_esmart_regs, sizeof(vop2_esmart_regs),
-			      GFP_KERNEL);
-	if (!esmart_regs)
-		return -ENOMEM;
-
-	for (i = 0; i < ARRAY_SIZE(vop2_esmart_regs); i++)
-		if (esmart_regs[i].reg != 0xffffffff)
-			esmart_regs[i].reg += win->offset;
+	int i;
 
-	ret = devm_regmap_field_bulk_alloc(vop2->dev, vop2->map, win->reg,
-					   esmart_regs,
-					   ARRAY_SIZE(vop2_esmart_regs));
+	for (i = 0; i < ARRAY_SIZE(vop2_esmart_regs); i++) {
+		const struct reg_field field = {
+			.reg = (vop2_esmart_regs[i].reg != 0xffffffff) ?
+				vop2_esmart_regs[i].reg + win->offset :
+				vop2_esmart_regs[i].reg,
+			.lsb = vop2_esmart_regs[i].lsb,
+			.msb = vop2_esmart_regs[i].msb
+		};
 
-	kfree(esmart_regs);
+		win->reg[i] = devm_regmap_field_alloc(vop2->dev, vop2->map, field);
+		if (IS_ERR(win->reg[i]))
+			return PTR_ERR(win->reg[i]);
+	}
 
-	return ret;
-};
+	return 0;
+}
 
 static int vop2_win_init(struct vop2 *vop2)
 {
-- 
2.34.1


