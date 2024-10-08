Return-Path: <linux-kernel+bounces-354907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51B699445F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFBC1F235BD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55D7191F91;
	Tue,  8 Oct 2024 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eaInGarh"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E508E18C90A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379950; cv=none; b=PX3OXLz9UYxA1BVqn+9AbiYNFkHkmq3tU1RnW0aTLczGBg8CYZ6gY3BHsGukhRRgzyHj0dfrN2QZzOvnZCFizJW3ja3HuZJAcTw6OcJC0FGe2nG0hHyfnFYVqJnoH9e3nKuhN4uD9lyx+lP7/TYFN8jDCRwbCeAvnX95TOLohGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379950; c=relaxed/simple;
	bh=yOyGLWSlpz4zNv4SNgy61maEijgqORM9CW6RDCDBj8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgnzSBd0Cb8qKbDA8yakV62VicExm3MyD1IIOjPZ7pThEwr8Mc2Q2stA6obbv45ZPf5/z/6LCNKADNBEGBvTcBrEgwOS0pDlWV2VO/MhhtmH8lGUntgsW8h6Ocyfdz0J21/x0ShXOms//u5xKDEQk0Y/66lKSCs/Yxuf4A3rzK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eaInGarh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728379946;
	bh=yOyGLWSlpz4zNv4SNgy61maEijgqORM9CW6RDCDBj8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eaInGarhrOvxQIy8SWNPu5AKBQyWA8achoK3ObnALrgYM4bVkdYT5a7bX2M2NRFZj
	 yJW0u4/BMkxVYeWYq1y7i1mLK/CB51r/7rNUQhtJvv0/dRtMzxVBhp3lHzDmiB2T79
	 PQLkftO4UA2Zn0I/5i5ZyG49pEfH5oq5FWBeE/VSQY0Rj2nLMFqM3QCml0R3Xc08gO
	 E8xsJkczdi8Rbpr+yeQj4NdWYC49G8ux1t2kPiTPtdoiPq527OYRPJSRCfRm6KV0ch
	 gvh98k/OAQFYr1MRlze6wXsaKvCs9dbAsCTPsPpwWgvOmQ6YTD/pB6x/sB2VWzYlA2
	 B/WtRVzwYU2aA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C6C5717E1201;
	Tue,  8 Oct 2024 11:32:25 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 2/2] soc: mediatek: mtk-cmdq: Move cmdq_instruction init to declaration
Date: Tue,  8 Oct 2024 11:32:20 +0200
Message-ID: <20241008093220.39734-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241008093220.39734-1-angelogioacchino.delregno@collabora.com>
References: <20241008093220.39734-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move, where possible, the initialization of struct cmdq_instruction
variables to their declaration to compress the code.

While at it, also change an instance of open-coded mask to use the
GENMASK() macro instead, and instances of `ret = func(); return ret;`
to the equivalent (but shorter) `return func()`.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 199 ++++++++++++-------------
 1 file changed, 92 insertions(+), 107 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 620c371fd1fc..0a05ee87a0fc 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -191,13 +191,12 @@ static int cmdq_pkt_mask(struct cmdq_pkt *pkt, u32 mask)
 
 int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value)
 {
-	struct cmdq_instruction inst;
-
-	inst.op = CMDQ_CODE_WRITE;
-	inst.value = value;
-	inst.offset = offset;
-	inst.subsys = subsys;
-
+	struct cmdq_instruction inst = {
+		.op = CMDQ_CODE_WRITE,
+		.value = value,
+		.offset = offset,
+		.subsys = subsys
+	};
 	return cmdq_pkt_append_command(pkt, inst);
 }
 EXPORT_SYMBOL(cmdq_pkt_write);
@@ -208,30 +207,27 @@ int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys,
 	u16 offset_mask = offset;
 	int err;
 
-	if (mask != 0xffffffff) {
+	if (mask != GENMASK(31, 0)) {
 		err = cmdq_pkt_mask(pkt, mask);
 		if (err < 0)
 			return err;
 
 		offset_mask |= CMDQ_WRITE_ENABLE_MASK;
 	}
-	err = cmdq_pkt_write(pkt, subsys, offset_mask, value);
-
-	return err;
+	return cmdq_pkt_write(pkt, subsys, offset_mask, value);
 }
 EXPORT_SYMBOL(cmdq_pkt_write_mask);
 
 int cmdq_pkt_read_s(struct cmdq_pkt *pkt, u16 high_addr_reg_idx, u16 addr_low,
 		    u16 reg_idx)
 {
-	struct cmdq_instruction inst = {};
-
-	inst.op = CMDQ_CODE_READ_S;
-	inst.dst_t = CMDQ_REG_TYPE;
-	inst.sop = high_addr_reg_idx;
-	inst.reg_dst = reg_idx;
-	inst.src_reg = addr_low;
-
+	struct cmdq_instruction inst = {
+		.op = CMDQ_CODE_READ_S,
+		.dst_t = CMDQ_REG_TYPE,
+		.sop = high_addr_reg_idx,
+		.reg_dst = reg_idx,
+		.src_reg = addr_low
+	};
 	return cmdq_pkt_append_command(pkt, inst);
 }
 EXPORT_SYMBOL(cmdq_pkt_read_s);
@@ -239,14 +235,13 @@ EXPORT_SYMBOL(cmdq_pkt_read_s);
 int cmdq_pkt_write_s(struct cmdq_pkt *pkt, u16 high_addr_reg_idx,
 		     u16 addr_low, u16 src_reg_idx)
 {
-	struct cmdq_instruction inst = {};
-
-	inst.op = CMDQ_CODE_WRITE_S;
-	inst.src_t = CMDQ_REG_TYPE;
-	inst.sop = high_addr_reg_idx;
-	inst.offset = addr_low;
-	inst.src_reg = src_reg_idx;
-
+	struct cmdq_instruction inst = {
+		.op = CMDQ_CODE_WRITE_S,
+		.src_t = CMDQ_REG_TYPE,
+		.sop = high_addr_reg_idx,
+		.offset = addr_low,
+		.src_reg = src_reg_idx
+	};
 	return cmdq_pkt_append_command(pkt, inst);
 }
 EXPORT_SYMBOL(cmdq_pkt_write_s);
@@ -254,20 +249,19 @@ EXPORT_SYMBOL(cmdq_pkt_write_s);
 int cmdq_pkt_write_s_mask(struct cmdq_pkt *pkt, u16 high_addr_reg_idx,
 			  u16 addr_low, u16 src_reg_idx, u32 mask)
 {
-	struct cmdq_instruction inst = {};
+	struct cmdq_instruction inst = {
+		.op = CMDQ_CODE_WRITE_S_MASK,
+		.src_t = CMDQ_REG_TYPE,
+		.sop = high_addr_reg_idx,
+		.offset = addr_low,
+		.src_reg = src_reg_idx,
+	};
 	int err;
 
 	err = cmdq_pkt_mask(pkt, mask);
 	if (err < 0)
 		return err;
 
-	inst.mask = 0;
-	inst.op = CMDQ_CODE_WRITE_S_MASK;
-	inst.src_t = CMDQ_REG_TYPE;
-	inst.sop = high_addr_reg_idx;
-	inst.offset = addr_low;
-	inst.src_reg = src_reg_idx;
-
 	return cmdq_pkt_append_command(pkt, inst);
 }
 EXPORT_SYMBOL(cmdq_pkt_write_s_mask);
@@ -275,13 +269,12 @@ EXPORT_SYMBOL(cmdq_pkt_write_s_mask);
 int cmdq_pkt_write_s_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
 			   u16 addr_low, u32 value)
 {
-	struct cmdq_instruction inst = {};
-
-	inst.op = CMDQ_CODE_WRITE_S;
-	inst.sop = high_addr_reg_idx;
-	inst.offset = addr_low;
-	inst.value = value;
-
+	struct cmdq_instruction inst = {
+		.op = CMDQ_CODE_WRITE_S,
+		.sop = high_addr_reg_idx,
+		.offset = addr_low,
+		.value = value
+	};
 	return cmdq_pkt_append_command(pkt, inst);
 }
 EXPORT_SYMBOL(cmdq_pkt_write_s_value);
@@ -289,18 +282,18 @@ EXPORT_SYMBOL(cmdq_pkt_write_s_value);
 int cmdq_pkt_write_s_mask_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
 				u16 addr_low, u32 value, u32 mask)
 {
-	struct cmdq_instruction inst = {};
+	struct cmdq_instruction inst = {
+		.op = CMDQ_CODE_WRITE_S_MASK,
+		.sop = high_addr_reg_idx,
+		.offset = addr_low,
+		.value = value
+	};
 	int err;
 
 	err = cmdq_pkt_mask(pkt, mask);
 	if (err < 0)
 		return err;
 
-	inst.op = CMDQ_CODE_WRITE_S_MASK;
-	inst.sop = high_addr_reg_idx;
-	inst.offset = addr_low;
-	inst.value = value;
-
 	return cmdq_pkt_append_command(pkt, inst);
 }
 EXPORT_SYMBOL(cmdq_pkt_write_s_mask_value);
@@ -333,61 +326,61 @@ EXPORT_SYMBOL(cmdq_pkt_mem_move);
 
 int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event, bool clear)
 {
-	struct cmdq_instruction inst = { {0} };
 	u32 clear_option = clear ? CMDQ_WFE_UPDATE : 0;
+	struct cmdq_instruction inst = {
+		.op = CMDQ_CODE_WFE,
+		.value = CMDQ_WFE_OPTION | clear_option,
+		.event = event
+	};
 
 	if (event >= CMDQ_MAX_EVENT)
 		return -EINVAL;
 
-	inst.op = CMDQ_CODE_WFE;
-	inst.value = CMDQ_WFE_OPTION | clear_option;
-	inst.event = event;
-
 	return cmdq_pkt_append_command(pkt, inst);
 }
 EXPORT_SYMBOL(cmdq_pkt_wfe);
 
 int cmdq_pkt_acquire_event(struct cmdq_pkt *pkt, u16 event)
 {
-	struct cmdq_instruction inst = {};
+	struct cmdq_instruction inst = {
+		.op = CMDQ_CODE_WFE,
+		.value = CMDQ_WFE_UPDATE | CMDQ_WFE_UPDATE_VALUE | CMDQ_WFE_WAIT,
+		.event = event
+	};
 
 	if (event >= CMDQ_MAX_EVENT)
 		return -EINVAL;
 
-	inst.op = CMDQ_CODE_WFE;
-	inst.value = CMDQ_WFE_UPDATE | CMDQ_WFE_UPDATE_VALUE | CMDQ_WFE_WAIT;
-	inst.event = event;
-
 	return cmdq_pkt_append_command(pkt, inst);
 }
 EXPORT_SYMBOL(cmdq_pkt_acquire_event);
 
 int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
 {
-	struct cmdq_instruction inst = { {0} };
+	struct cmdq_instruction inst = {
+		.op = CMDQ_CODE_WFE,
+		.value = CMDQ_WFE_UPDATE,
+		.event = event
+	};
 
 	if (event >= CMDQ_MAX_EVENT)
 		return -EINVAL;
 
-	inst.op = CMDQ_CODE_WFE;
-	inst.value = CMDQ_WFE_UPDATE;
-	inst.event = event;
-
 	return cmdq_pkt_append_command(pkt, inst);
 }
 EXPORT_SYMBOL(cmdq_pkt_clear_event);
 
 int cmdq_pkt_set_event(struct cmdq_pkt *pkt, u16 event)
 {
-	struct cmdq_instruction inst = {};
+	struct cmdq_instruction inst = {
+		.op = CMDQ_CODE_WFE,
+		.value = CMDQ_WFE_UPDATE | CMDQ_WFE_UPDATE_VALUE,
+		.event = event
+	};
 
 	if (event >= CMDQ_MAX_EVENT)
 		return -EINVAL;
 
-	inst.op = CMDQ_CODE_WFE;
-	inst.value = CMDQ_WFE_UPDATE | CMDQ_WFE_UPDATE_VALUE;
-	inst.event = event;
-
 	return cmdq_pkt_append_command(pkt, inst);
 }
 EXPORT_SYMBOL(cmdq_pkt_set_event);
@@ -395,16 +388,13 @@ EXPORT_SYMBOL(cmdq_pkt_set_event);
 int cmdq_pkt_poll(struct cmdq_pkt *pkt, u8 subsys,
 		  u16 offset, u32 value)
 {
-	struct cmdq_instruction inst = { {0} };
-	int err;
-
-	inst.op = CMDQ_CODE_POLL;
-	inst.value = value;
-	inst.offset = offset;
-	inst.subsys = subsys;
-	err = cmdq_pkt_append_command(pkt, inst);
-
-	return err;
+	struct cmdq_instruction inst = {
+		.op = CMDQ_CODE_POLL,
+		.value = value,
+		.offset = offset,
+		.subsys = subsys
+	};
+	return cmdq_pkt_append_command(pkt, inst);
 }
 EXPORT_SYMBOL(cmdq_pkt_poll);
 
@@ -418,9 +408,7 @@ int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
 		return err;
 
 	offset = offset | CMDQ_POLL_ENABLE_MASK;
-	err = cmdq_pkt_poll(pkt, subsys, offset, value);
-
-	return err;
+	return cmdq_pkt_poll(pkt, subsys, offset, value);
 }
 EXPORT_SYMBOL(cmdq_pkt_poll_mask);
 
@@ -474,11 +462,12 @@ int cmdq_pkt_logic_command(struct cmdq_pkt *pkt, u16 result_reg_idx,
 			   enum cmdq_logic_op s_op,
 			   struct cmdq_operand *right_operand)
 {
-	struct cmdq_instruction inst = { {0} };
+	struct cmdq_instruction inst;
 
 	if (!left_operand || !right_operand || s_op >= CMDQ_LOGIC_MAX)
 		return -EINVAL;
 
+	inst.value = 0;
 	inst.op = CMDQ_CODE_LOGIC;
 	inst.dst_t = CMDQ_REG_TYPE;
 	inst.src_t = cmdq_operand_get_type(left_operand);
@@ -494,43 +483,43 @@ EXPORT_SYMBOL(cmdq_pkt_logic_command);
 
 int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value)
 {
-	struct cmdq_instruction inst = {};
-
-	inst.op = CMDQ_CODE_LOGIC;
-	inst.dst_t = CMDQ_REG_TYPE;
-	inst.reg_dst = reg_idx;
-	inst.value = value;
+	struct cmdq_instruction inst = {
+		.op = CMDQ_CODE_LOGIC,
+		.dst_t = CMDQ_REG_TYPE,
+		.reg_dst = reg_idx,
+		.value = value
+	};
 	return cmdq_pkt_append_command(pkt, inst);
 }
 EXPORT_SYMBOL(cmdq_pkt_assign);
 
 int cmdq_pkt_jump_abs(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa)
 {
-	struct cmdq_instruction inst = {};
-
-	inst.op = CMDQ_CODE_JUMP;
-	inst.offset = CMDQ_JUMP_ABSOLUTE;
-	inst.value = addr >> shift_pa;
+	struct cmdq_instruction inst = {
+		.op = CMDQ_CODE_JUMP,
+		.offset = CMDQ_JUMP_ABSOLUTE,
+		.value = addr >> shift_pa
+	};
 	return cmdq_pkt_append_command(pkt, inst);
 }
 EXPORT_SYMBOL(cmdq_pkt_jump_abs);
 
 int cmdq_pkt_jump_rel(struct cmdq_pkt *pkt, s32 offset, u8 shift_pa)
 {
-	struct cmdq_instruction inst = { {0} };
-
-	inst.op = CMDQ_CODE_JUMP;
-	inst.value = (u32)offset >> shift_pa;
+	struct cmdq_instruction inst = {
+		.op = CMDQ_CODE_JUMP,
+		.value = (u32)offset >> shift_pa
+	};
 	return cmdq_pkt_append_command(pkt, inst);
 }
 EXPORT_SYMBOL(cmdq_pkt_jump_rel);
 
 int cmdq_pkt_eoc(struct cmdq_pkt *pkt)
 {
-	struct cmdq_instruction inst = { {0} };
-
-	inst.op = CMDQ_CODE_EOC;
-	inst.value = CMDQ_EOC_IRQ_EN;
+	struct cmdq_instruction inst = {
+		.op = CMDQ_CODE_EOC,
+		.value = CMDQ_EOC_IRQ_EN
+	};
 	return cmdq_pkt_append_command(pkt, inst);
 }
 EXPORT_SYMBOL(cmdq_pkt_eoc);
@@ -541,9 +530,7 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 	int err;
 
 	/* insert EOC and generate IRQ for each command iteration */
-	inst.op = CMDQ_CODE_EOC;
-	inst.value = CMDQ_EOC_IRQ_EN;
-	err = cmdq_pkt_append_command(pkt, inst);
+	err = cmdq_pkt_eoc(pkt);
 	if (err < 0)
 		return err;
 
@@ -551,9 +538,7 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 	inst.op = CMDQ_CODE_JUMP;
 	inst.value = CMDQ_JUMP_PASS >>
 		cmdq_get_shift_pa(((struct cmdq_client *)pkt->cl)->chan);
-	err = cmdq_pkt_append_command(pkt, inst);
-
-	return err;
+	return cmdq_pkt_append_command(pkt, inst);
 }
 EXPORT_SYMBOL(cmdq_pkt_finalize);
 
-- 
2.46.1


