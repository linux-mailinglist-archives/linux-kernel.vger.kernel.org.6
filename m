Return-Path: <linux-kernel+bounces-332504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7581697BA8E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D751C220C2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E09183CDB;
	Wed, 18 Sep 2024 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Pyw1njRU"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F3617B425
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653997; cv=none; b=fFBZ17P86bKqS1VYZDmbrgpZYgYIFlAaM7ijxEKB20nV8Ps1UzR55D9NLFT911C8Bog3DOoEI/xsjcxY4ULITAbS3qva/dQaw4c+smz4gynJLFsOZm84h6mMU6yeZXZP6u2S3artd34svXwNq2QoiD79YtY6y3/Q7VdPpQIRs2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653997; c=relaxed/simple;
	bh=t5UwOBnTnD4LxneriXQ1Hkl0RZpJr4Pl9fU7M3V5eV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNFJM26sanoC6GaV51YSJXZquHKGG2Mz0aLSRx8Nc4rRVnPGzl4pk3G8Da6/9w68RXT9VNAFstwd+ZiDT0nVihut6yHE9SK09Rsfc0uLXbDPM4IxP9RvF/J8IpFlJQxi7uVP80EgpHC4TBZ+bOC3aOpy/7sj7I5JrDkAvyWG028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Pyw1njRU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726653993;
	bh=t5UwOBnTnD4LxneriXQ1Hkl0RZpJr4Pl9fU7M3V5eV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pyw1njRU3yIxpRTA0+Jfu1O7bNPLtAZUkMkoCQBEl4Yxk4dCLdBqcpd8UuKIadVMZ
	 OcDYO+tWL4TYx3sbF7e8lHFngrQeyOeOo8/JpOW02/a/x0AtKhS1rS/TeR7JhK+VsF
	 x2JB+VGc6FZHbi4Ca/FshfWLvaLU79RglUk79eIvwUb9DCgxz3HaOh/twydbky2dtm
	 GiRrqSM2CCgArwAEQgGzSjmzrlEUzqvysyid1AfK7BYl25cdqmDQXTKmPdeWn84ZOw
	 B9ng63M2osERNK+xF7J+crsglWhl9VeNMdDl/ICfJXEY/uOVZKPpu+dtda8lv924Jw
	 75ECfkYYy+lxQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 324A517E10B5;
	Wed, 18 Sep 2024 12:06:33 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 2/3] soc: mediatek: mtk-cmdq: Mark very unlikely branches as such
Date: Wed, 18 Sep 2024 12:06:19 +0200
Message-ID: <20240918100620.103536-3-angelogioacchino.delregno@collabora.com>
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

Calling cmdq packet builders with an unsupported event number,
or without left/right operands (in the case of logic commands)
means that the caller (another driver) wants to perform an
unsupported operation, so this means that the caller must be
fixed instead.

Anyway, such checks are here for safety and, unless any driver
bug or any kind of misconfiguration is present, will always be
false so add a very unlikely hint for those.

Knowing that CPUs' branch predictors (and compilers, anyway) are
indeed smart about these cases, this is done mainly for human
readability purposes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 620c371fd1fc..4ffd1a35df87 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -336,7 +336,7 @@ int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event, bool clear)
 	struct cmdq_instruction inst = { {0} };
 	u32 clear_option = clear ? CMDQ_WFE_UPDATE : 0;
 
-	if (event >= CMDQ_MAX_EVENT)
+	if (unlikely(event >= CMDQ_MAX_EVENT))
 		return -EINVAL;
 
 	inst.op = CMDQ_CODE_WFE;
@@ -351,7 +351,7 @@ int cmdq_pkt_acquire_event(struct cmdq_pkt *pkt, u16 event)
 {
 	struct cmdq_instruction inst = {};
 
-	if (event >= CMDQ_MAX_EVENT)
+	if (unlikely(event >= CMDQ_MAX_EVENT))
 		return -EINVAL;
 
 	inst.op = CMDQ_CODE_WFE;
@@ -366,7 +366,7 @@ int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
 {
 	struct cmdq_instruction inst = { {0} };
 
-	if (event >= CMDQ_MAX_EVENT)
+	if (unlikely(event >= CMDQ_MAX_EVENT))
 		return -EINVAL;
 
 	inst.op = CMDQ_CODE_WFE;
@@ -381,7 +381,7 @@ int cmdq_pkt_set_event(struct cmdq_pkt *pkt, u16 event)
 {
 	struct cmdq_instruction inst = {};
 
-	if (event >= CMDQ_MAX_EVENT)
+	if (unlikely(event >= CMDQ_MAX_EVENT))
 		return -EINVAL;
 
 	inst.op = CMDQ_CODE_WFE;
@@ -476,7 +476,7 @@ int cmdq_pkt_logic_command(struct cmdq_pkt *pkt, u16 result_reg_idx,
 {
 	struct cmdq_instruction inst = { {0} };
 
-	if (!left_operand || !right_operand || s_op >= CMDQ_LOGIC_MAX)
+	if (unlikely(!left_operand || !right_operand || s_op >= CMDQ_LOGIC_MAX))
 		return -EINVAL;
 
 	inst.op = CMDQ_CODE_LOGIC;
-- 
2.46.0


