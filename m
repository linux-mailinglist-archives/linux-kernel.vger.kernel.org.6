Return-Path: <linux-kernel+bounces-510872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE0BA32308
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F273A03AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B89620A5EE;
	Wed, 12 Feb 2025 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="o7dmrnKZ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DB020967C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354428; cv=none; b=QLAKNY4WZugUURYZEB+uuHIiMb3dyzf5qKsIFjAJKkqsuhUpyIAFzduCKHA5whYLA9ij7C0Y4q6WXXfJB5X+DBM6Zg5ZhG+jvb/SR6bTuA3QgSEl5oRyjH1HKVK116zmMsAGH2rSTiu58ix0zzA+JNqph4dQhqyvkio4PfngoT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354428; c=relaxed/simple;
	bh=qIB7ibz7WHqpA4xUJoQy83qbNuSr/lbngQhBP3iOYO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IU4GfeyXpgvFuBoSqzSNIquaqO+EtuYV6AvzXd0XRw9/IoXNN8fyJTnPMJQvzYoEbFXFUxjQhDfJGa2RVaUtEUeh+5bLQ7UGT0XtbeYd+ZCWK8Wa7IPCnir/lF0tjkzx360CLBTMUs8t/KTQhCeHgjE1Z1cEPkSVcchGjwrYsmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=o7dmrnKZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739354423;
	bh=qIB7ibz7WHqpA4xUJoQy83qbNuSr/lbngQhBP3iOYO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o7dmrnKZfTma6lXtDwkyHbSduLPhytlXF4ztc3SeDcVAKLm5ASzfW5VU5NpReto0f
	 WrYd0lJqTEHkI4uA/Lzhu0NoDz5h2ycSIUSHCxvwJaE7nY/Dj5MIxPS20X/tOgiXnT
	 h3RDheIdIf7z/97NNHxBG9p76tHiRXwpLXTaZDWL8mHEq8qFPiMHzO9N1iPaYYF9Gz
	 q0y8oXeDZHytiVCuxZs7z5FTd8gNxBZWFXdxZDXE7x1GpvKeiJg1m4n5SHnFT5QQQB
	 3I1fZxu7MKIRbRPU6qB2KYVw4LO6cSuOp5c/4OjMSl0tP1IbIPHnlmnWbq1nsM36vY
	 IVGdEwvLJvyfw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2E30617E0F68;
	Wed, 12 Feb 2025 11:00:23 +0100 (CET)
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
Subject: [PATCH v1 8/8] soc: mediatek: mt8188-mmsys: Add support for DSC on VDO0
Date: Wed, 12 Feb 2025 11:00:12 +0100
Message-ID: <20250212100012.33001-9-angelogioacchino.delregno@collabora.com>
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

Add routing paths to support Display Stream Compression on the
VDOSYS0 pipelines ending with DSI or DisplayPort (DP_INTF).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mt8188-mmsys.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soc/mediatek/mt8188-mmsys.h b/drivers/soc/mediatek/mt8188-mmsys.h
index befd293e86c3..99080afead7e 100644
--- a/drivers/soc/mediatek/mt8188-mmsys.h
+++ b/drivers/soc/mediatek/mt8188-mmsys.h
@@ -226,15 +226,24 @@ static const struct mtk_mmsys_routes mmsys_mt8188_routing_table[] = {
 	MMSYS_ROUTE(DSC0, MERGE0,
 		    MT8188_VDO0_VPP_MERGE_SEL, MT8188_SEL_IN_VPP_MERGE_FROM_MASK,
 		    MT8188_SEL_IN_VPP_MERGE_FROM_DSC_WRAP0_OUT),
+	MMSYS_ROUTE(MERGE0, DP_INTF0,
+		    MT8188_VDO0_DP_INTF0_SEL_IN, MT8188_SEL_IN_DP_INTF0_FROM_MASK,
+		    MT8188_SEL_IN_DP_INTF0_FROM_VPP_MERGE),
 	MMSYS_ROUTE(DSC0, DSI0,
 		    MT8188_VDO0_DSI0_SEL_IN, MT8188_SEL_IN_DSI0_FROM_MASK,
 		    MT8188_SEL_IN_DSI0_FROM_DSC_WRAP0_OUT),
 	MMSYS_ROUTE(RDMA0, COLOR0,
 		    MT8188_VDO0_DISP_RDMA_SEL, GENMASK(1, 0),
 		    MT8188_SOUT_DISP_RDMA0_TO_DISP_COLOR0),
+	MMSYS_ROUTE(DITHER0, DSC0,
+		    MT8188_VDO0_DISP_DITHER0_SEL_OUT, MT8188_SOUT_DISP_DITHER0_TO_MASK,
+		    MT8188_SOUT_DISP_DITHER0_TO_DSC_WRAP0_IN),
 	MMSYS_ROUTE(DITHER0, DSI0,
 		    MT8188_VDO0_DISP_DITHER0_SEL_OUT, MT8188_SOUT_DISP_DITHER0_TO_MASK,
 		    MT8188_SOUT_DISP_DITHER0_TO_DSI0),
+	MMSYS_ROUTE(DITHER0, MERGE0,
+		    MT8188_VDO0_DISP_DITHER0_SEL_OUT, MT8188_SOUT_DISP_DITHER0_TO_MASK,
+		    MT8188_SOUT_DISP_DITHER0_TO_VPP_MERGE0),
 	MMSYS_ROUTE(DITHER0, DP_INTF0,
 		    MT8188_VDO0_DISP_DITHER0_SEL_OUT, MT8188_SOUT_DISP_DITHER0_TO_MASK,
 		    MT8188_SOUT_DISP_DITHER0_TO_DP_INTF0),
-- 
2.48.1


