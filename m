Return-Path: <linux-kernel+bounces-332502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A54697BA89
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15903B299F2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A74717C9FA;
	Wed, 18 Sep 2024 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cy8YUnLg"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC4FF9E4
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653996; cv=none; b=bq8l99RBrI79SOoAXJ/rsnPTfNveGvqXCZSKHVeqdk/2yhuKXHW04ft2hfzMagld0ljyg/ktf0wqjYoKyqirF56mTyP1Ui68gLPZNzlHPI6ZzdK9oBRnL+kfBBz3UmsC2LeWvtLD5dhW3lxZWBbCOdOoh+rAlUAxD7S7AbT56BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653996; c=relaxed/simple;
	bh=0RM0X8+Uj/yAzEVGnz19COcilxf0hCC5AuSLiaf0NTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5u3W2YBhONZ3xBMTOn82VOG4WSfV7OintJEW/5cyne5BoSZR0bWXMYlMDVDN3DjGutqln7+osG+61iEa4BumpXHwlacPHEfBaluu9xpyUandEZSg85RvPr4v0cz1HlDwV+Rp+HWAmJhGN7FD9zq3CLInUW5rGuAR6lK9kKxinE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cy8YUnLg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726653993;
	bh=0RM0X8+Uj/yAzEVGnz19COcilxf0hCC5AuSLiaf0NTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cy8YUnLgjynfq2iwDDexAgxK1h+DtpsNktVHZ8fjZ52MtX7gaQfXTaLBCKfzTds3x
	 eKJU7jcCvvGdJEcdHDgAjvUb2Qy1aePq3OFaZ6e9qdIw8sgKJcLIV8pmSysDXvOFZf
	 qy9uEcFwt3padA3a9+303USK5Sl6K2zPoXh8nydGNFmbfdbAYyhWguJxB7CShuPpba
	 yuybq5hKc8uwEjpLpJ1wZww8nHfdXtPCUMuQ1dlfqUWQ5dDKnnom3y6uGRdgq8XASO
	 QH1cD9QGYDFmXtb+4hSao1zozNrEc6iTGNTfkPa3tcSSI5RRK1kyQkqbam5PsrvSlW
	 0yECGqZF2JvHg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BF25B17E10AE;
	Wed, 18 Sep 2024 12:06:32 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 1/3] soc: mediatek: mtk-cmdq: Move mask build and append to function
Date: Wed, 18 Sep 2024 12:06:18 +0200
Message-ID: <20240918100620.103536-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918100620.103536-1-angelogioacchino.delregno@collabora.com>
References: <20240918100620.103536-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the CMDQ_CODE_MASK packet build and append logic to a new
cmdq_pkt_mask() function; this reduces code duplication by 4x.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 31 ++++++++++++--------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index a8fccedba83f..620c371fd1fc 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -180,6 +180,15 @@ static int cmdq_pkt_append_command(struct cmdq_pkt *pkt,
 	return 0;
 }
 
+static int cmdq_pkt_mask(struct cmdq_pkt *pkt, u32 mask)
+{
+	struct cmdq_instruction inst = {
+		.op = CMDQ_CODE_MASK,
+		.mask = ~mask
+	};
+	return cmdq_pkt_append_command(pkt, inst);
+}
+
 int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value)
 {
 	struct cmdq_instruction inst;
@@ -196,14 +205,11 @@ EXPORT_SYMBOL(cmdq_pkt_write);
 int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys,
 			u16 offset, u32 value, u32 mask)
 {
-	struct cmdq_instruction inst = { {0} };
 	u16 offset_mask = offset;
 	int err;
 
 	if (mask != 0xffffffff) {
-		inst.op = CMDQ_CODE_MASK;
-		inst.mask = ~mask;
-		err = cmdq_pkt_append_command(pkt, inst);
+		err = cmdq_pkt_mask(pkt, mask);
 		if (err < 0)
 			return err;
 
@@ -251,9 +257,7 @@ int cmdq_pkt_write_s_mask(struct cmdq_pkt *pkt, u16 high_addr_reg_idx,
 	struct cmdq_instruction inst = {};
 	int err;
 
-	inst.op = CMDQ_CODE_MASK;
-	inst.mask = ~mask;
-	err = cmdq_pkt_append_command(pkt, inst);
+	err = cmdq_pkt_mask(pkt, mask);
 	if (err < 0)
 		return err;
 
@@ -288,9 +292,7 @@ int cmdq_pkt_write_s_mask_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
 	struct cmdq_instruction inst = {};
 	int err;
 
-	inst.op = CMDQ_CODE_MASK;
-	inst.mask = ~mask;
-	err = cmdq_pkt_append_command(pkt, inst);
+	err = cmdq_pkt_mask(pkt, mask);
 	if (err < 0)
 		return err;
 
@@ -409,12 +411,9 @@ EXPORT_SYMBOL(cmdq_pkt_poll);
 int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
 		       u16 offset, u32 value, u32 mask)
 {
-	struct cmdq_instruction inst = { {0} };
 	int err;
 
-	inst.op = CMDQ_CODE_MASK;
-	inst.mask = ~mask;
-	err = cmdq_pkt_append_command(pkt, inst);
+	err = cmdq_pkt_mask(pkt, mask);
 	if (err < 0)
 		return err;
 
@@ -436,9 +435,7 @@ int cmdq_pkt_poll_addr(struct cmdq_pkt *pkt, dma_addr_t addr, u32 value, u32 mas
 	 * which enables use_mask bit.
 	 */
 	if (mask != GENMASK(31, 0)) {
-		inst.op = CMDQ_CODE_MASK;
-		inst.mask = ~mask;
-		ret = cmdq_pkt_append_command(pkt, inst);
+		ret = cmdq_pkt_mask(pkt, mask);
 		if (ret < 0)
 			return ret;
 		use_mask = CMDQ_POLL_ENABLE_MASK;
-- 
2.46.0


