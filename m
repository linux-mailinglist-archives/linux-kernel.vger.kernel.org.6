Return-Path: <linux-kernel+bounces-354905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1107299445E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79F21F226BD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F5B18DF8D;
	Tue,  8 Oct 2024 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jE8yfCzH"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9FB18C900
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379949; cv=none; b=XBkOQO/xIoZFNJ3kbfr2Hpodwc9+FQw/bLaBhe0WhaxjYxWS8vGaBUlB0firIa44ZD/38Ge7K1A7+Ex0unPQriC1MVaO2ZV7uCoDn0clEQax2PWuRCutyu9uPa8ID6u++20JVKhOCH7e2BTBhIjcidly5N37AX0MLAYtCuhA2HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379949; c=relaxed/simple;
	bh=RNy7f4IYf2GR8GpS+QPyUGvYiK6+9T8IXGPtykB2b6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7wqbiIe2zdBFvOGwW2L0Xougqd3FC61161agKFfF+TSzZR7iaLWo5QUfqfpsdYhLf4kie6TuYDsN4fTd9LpCe+GIPX6zYeIce63dHlkDL+yjHIo4mNND8QfgYxB66bAKc7IfuXpNRZgmOsQLdDQTxSaogtL6mgUJ+TvEkAdbN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jE8yfCzH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728379945;
	bh=RNy7f4IYf2GR8GpS+QPyUGvYiK6+9T8IXGPtykB2b6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jE8yfCzHL8c59S8JT3nca1jEHPbZlsqZrV+MC0GnYY8fyiCfgLHDna5MFhaIr9gSw
	 U+TlUikTsTiRVQD3lmsLEzlX04JYy/AvgLLwqJRRCI3RoTaH5Yep0HO5O09RXDvVhL
	 nLRjsrKtCQbQ3hQAlI0vngo8yAvLEU27csqmP70ZXLzyEvR7wU29cQiqBDY1bOeg5i
	 28e5V2pFxvb4NR/dkKFIeykRZy8Tav4Cs0RdxLW1EeZWFcCVlJsDq7Vmzw5mtttC9v
	 9lzrYfH4aTQVqZ7LFKD0g5uCKfNH6NL2ZLjuGjihfutNcUtd336s6qC7DPoQ5ngVoZ
	 eMVlIIbAIoBag==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5321417E11FA;
	Tue,  8 Oct 2024 11:32:25 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 1/2] soc: mediatek: mtk-cmdq: Move mask build and append to function
Date: Tue,  8 Oct 2024 11:32:19 +0200
Message-ID: <20241008093220.39734-2-angelogioacchino.delregno@collabora.com>
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

Move the CMDQ_CODE_MASK packet build and append logic to a new
cmdq_pkt_mask() function; this reduces code duplication by 4x.

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
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
2.46.1


