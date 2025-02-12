Return-Path: <linux-kernel+bounces-510866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D7AA32300
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88E93A45BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EDE2080D5;
	Wed, 12 Feb 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PN+zMyYh"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB121E47A6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354423; cv=none; b=R4K/me7p6AZ94G+eQzeKJa2T8/jZfavCn06NMO7CltSJmzBeldOOlAWdex+QXOE1lDAtVL9+Jg7dtBsIzK7fPms8zB1ARMwkJiZ4R365Yl286tnxXHEM3PV3TI7DJgc0gY2NtGNpvFizAdlOfZi8zvn3zIaQ7+jveyC1ujPwlEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354423; c=relaxed/simple;
	bh=0F/0qyTpLblJN9bn3oUmfcJlpoiaYpBNrYXmmjYDh2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NdY8gJcxG82Hml/pmkXHp9rOTXSDJuz6xEa0295cNyarjU9hsZPoDE+g3S/DbPG6X3AaYSKjmiTD9Fxp/B+8ptxj2vnXy58EuRv2LchqoqMYL9JPl5kpCHuWtdLDA2qToFzyFI28hu+MV+/Tk2PZXiV9Si55zfbieB1mvxu57aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PN+zMyYh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739354419;
	bh=0F/0qyTpLblJN9bn3oUmfcJlpoiaYpBNrYXmmjYDh2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PN+zMyYhBYF0Rtv/CBkX7kCjGOZ4oMLI4PD5HbgrS+k4+5S/yI3yi3YeNL0omuQN0
	 0CNV7ABcioAGJrefwmykvcVFjSre/+0g7KCGzBIttiM2V5zJ7QY8FwGDRWq+B27bOE
	 q9jTGF07XG1eGO6Btn2+Qv9NNl8DDOwwUTAfPmyZk1gjzfpVfHlC+F2Bq30TIW0FPu
	 iB2sQpyu+tC66TqujIe6Hl759NkGTeWyQUrr7UkCVR7js9XtPDpNVnJEDkvve2NMbp
	 ijuDQQomBqv9hREVOaSu6GYWWIpWtPMrTajfaVTlYqWUvSx/5bCk9e94/e8ge110ls
	 hBLeAggH3LoMw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EF98117E154B;
	Wed, 12 Feb 2025 11:00:18 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: matthias.bgg@gmail.com
Cc: angelogioacchino.delregno@collabora.com,
	shawn.sung@mediatek.com,
	fparent@baylibre.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	pablo.sun@mediatek.com,
	kernel@collabora.com
Subject: [PATCH v1 2/8] soc: mediatek: mtk-mmsys: Fix MT8188 VDO1 DPI1 output selection
Date: Wed, 12 Feb 2025 11:00:06 +0100
Message-ID: <20250212100012.33001-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212100012.33001-1-angelogioacchino.delregno@collabora.com>
References: <20250212100012.33001-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VDO1_MERGE4 hardware (merge5 software component) should be
set to enable output to DPI1_SEL by setting BIT(2) but, despite
the intention being exactly that, this won't work because the
declared register mask is wrong as it is set as GENMASK(1, 0).

Register MERGE4_MOUT_EN in VDO1 has four used bits [3, 0] so
fix the mask to reflect that.
That, in turn, allows the mmsys driver to actually set BIT(2)
in this register, fixing the MERGE4 output to DPI1 selection.

Fixes: c0349314d5a0 ("soc: mediatek: Support MT8188 VDOSYS1 in mtk-mmsys")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mt8188-mmsys.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mt8188-mmsys.h b/drivers/soc/mediatek/mt8188-mmsys.h
index 6bebf1a69fc0..a1d63be0a73d 100644
--- a/drivers/soc/mediatek/mt8188-mmsys.h
+++ b/drivers/soc/mediatek/mt8188-mmsys.h
@@ -343,7 +343,7 @@ static const struct mtk_mmsys_routes mmsys_mt8188_vdo1_routing_table[] = {
 		MT8188_DISP_DPI1_SEL_IN_FROM_VPP_MERGE4_MOUT
 	}, {
 		DDP_COMPONENT_MERGE5, DDP_COMPONENT_DPI1,
-		MT8188_VDO1_MERGE4_SOUT_SEL, GENMASK(1, 0),
+		MT8188_VDO1_MERGE4_SOUT_SEL, GENMASK(3, 0),
 		MT8188_MERGE4_SOUT_TO_DPI1_SEL
 	}, {
 		DDP_COMPONENT_MERGE5, DDP_COMPONENT_DP_INTF1,
-- 
2.48.1


