Return-Path: <linux-kernel+bounces-356233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4268995E51
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 05:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B80283CEE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAAC156F3C;
	Wed,  9 Oct 2024 03:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XSvHia//"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66DF150997
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 03:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728445618; cv=none; b=Av2m8vTeWsdZU1j9JSYLrNYsyZMDtLBUoa7R4VuWVNdD3tB8x/hwTtcyILb4jWdBQJecGbU2Gn59y1+XNWgJkRtF1srGlj74HQA50ORLWo4mTGbhP0DrXcbJ6c9WqqE5TJyTCpHoUxC/Zj7Dc+Jr4PBqkriFPaZITcFKDMB1Kh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728445618; c=relaxed/simple;
	bh=3w2tvschrTijM5svhf76ExJt8xal5C0gJlHw2hDd0I8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTPjU3yEu3KSYFA/1AfRIqIpPa1N7PYOMeVMRLvYtPXZ+DM04/NItBL4ld8hoW6+GfLyXXrXURel4F8w/auW66hjzb08GNpv2OrdE3Cn9NxJZtBXuewoHw71bCf0QMLh/fwqp0SYk0dozTQSa13EE2veqP3IN5SQc145NI2t2oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XSvHia//; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1c96522485f111ef8b96093e013ec31c-20241009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jNf8esuPFXdj1SzZwNlUle77CExMPeToTH21H8ouLYo=;
	b=XSvHia//1WANEiQuyBmFckMe4xBMCnx2qNINMgJwFf4yueMyc2dH2QtLeeqaYXhJbNBn/l7y2hIQyDHd+/BJFxZaXKzPUXRrIn3DLctMv6umpIbvRRQeqPKe8lvx041dtYhK1ansTbGABxzRq0fvnsYjNatfPAmWffA9Yf+KmXQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:08fe941d-fd72-4112-b98b-19824cfab9cb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:31c38226-5902-4533-af4f-d0904aa89b3c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 1c96522485f111ef8b96093e013ec31c-20241009
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 316013556; Wed, 09 Oct 2024 11:46:48 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 9 Oct 2024 11:46:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 9 Oct 2024 11:46:46 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Adam Thiede <me@adamthiede.com>, Yassine Oudjana
	<yassine.oudjana@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Shawn Sung <shawn.sung@mediatek.com>, Alper Nebi Yasak
	<alpernebiyasak@gmail.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, "Nancy
 Lin" <nancy.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v11 1/5] drm/mediatek: ovl: Fix XRGB format breakage for blend_modes unsupported SoCs
Date: Wed, 9 Oct 2024 11:46:42 +0800
Message-ID: <20241009034646.13143-2-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241009034646.13143-1-jason-jh.lin@mediatek.com>
References: <20241009034646.13143-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.798000-8.000000
X-TMASE-MatchedRID: X679DjmVMOn2fv0LTPfvM4dlc1JaOB1TUAjrAJWsTe/KP6Yywb5aNnv7
	Io91rBfwD2EF2wJcjhdx0DfvHApiHUIjaJSsaV6qY1bQMCMvmn6eEP0DdJrullxTR00Ss4P62ft
	v/5jXki/ZoTly3PGW4GlSWihAdtZ+j2hRzH1UwuAURSScn+QSXt0H8LFZNFG7CKFCmhdu5cUi5y
	5vykNUv9NYWU6hQo6nyU+stpPw3NyDgLduq9LPWKW+UzY9s8NAqCsLjdN80t/JgECrPZSGt/5fz
	FTJ/+DJcVSyL/LZfpwXRoPmWO3jekxwdkPqCq7vDEyN+J8hd+jCS9WgDXVPCp6oP1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.798000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	8EF844DF62ED7CF5483EBEC09019DF7B7F35AF7A6138F71D1EFF490F66F76CD22000:8
X-MTK: N

OVL_CON_AEN is for alpha blending enable.
For the SoC that is supported the blend_modes, OVL_CON_AEN will always
enabled to use constant alpha and then use the ignore_pixel_alpha bit
to do the alpha blending for XRGB8888 format.
Note that ignore pixel alpha bit is not supported if the SoC is not
supported the blend_modes.
So it will break the original setting of XRGB8888 format for the
blend_modes unsupported SoCs, such as MT8173.

To fix the downgrade issue, enable alpha blending only when a valid
blend_mode or has_alpha is set.

Fixes: bc46eb5d5d77 ("drm/mediatek: Support DRM plane alpha in OVL")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 89b439dcf3a6..047cd1796a51 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -473,8 +473,14 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 
 	con = ovl_fmt_convert(ovl, fmt, blend_mode);
 	if (state->base.fb) {
-		con |= OVL_CON_AEN;
 		con |= state->base.alpha & OVL_CON_ALPHA;
+
+		/*
+		 * For blend_modes supported SoCs, always enable alpha blending.
+		 * For blend_modes unsupported SoCs, enable alpha blending when has_alpha is set.
+		 */
+		if (blend_mode || state->base.fb->format->has_alpha)
+			con |= OVL_CON_AEN;
 	}
 
 	/* CONST_BLD must be enabled for XRGB formats although the alpha channel
-- 
2.43.0


