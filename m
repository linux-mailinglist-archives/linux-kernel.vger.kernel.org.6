Return-Path: <linux-kernel+bounces-221497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5369590F477
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06AD1282E43
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868B815530B;
	Wed, 19 Jun 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvRnMDtM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE261848
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815829; cv=none; b=D+nQK9OY5Qqiz+3yeotLAqluzpc6b2GmkgR9wzG3JqKxgRWZVIBMPI4fqjtcNgFhz/wCBVuKEgrv/NNFz/j3e3Z/mFXG0ttj1eXNxMzV4AYePaP95F2HR0fKhfcGhqqm9eKOIjsdwegH91/hCi25dmT+54ZApsyeWIoQ8HQS/zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815829; c=relaxed/simple;
	bh=EfufO2Llk9pumk0C7f8PNAltKODZ1xHc7rjQM9qwOCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pc+VUtH+gL8lB1mR020HJ61hlPNe8iW9AE8bZumyLG/alqn7XXNe+PSPtSivmTRAF0FT3PUaiu7MpxulSFbL4/Plb6i4gXeelU6fOszc3r/o0FyII36JgCgX/QSUFtJpI+XuBILrfFUQO+uZCYJxQ/SqbjY4UBN2IfNTdXfAfOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvRnMDtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BD11C2BBFC;
	Wed, 19 Jun 2024 16:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718815829;
	bh=EfufO2Llk9pumk0C7f8PNAltKODZ1xHc7rjQM9qwOCE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZvRnMDtM5Po3u3vmvlhVVCBMXI01AdLFQWgapf97FHWRFLfs+578RSoV/nOdJTPtj
	 5mnoGCZLc5l9PeMtUrC5gwb402zLklh04AvlRs36EKxIAwEmglXdRb84+Sb0/TwvSK
	 cxeAxBoxdzDVTdLZ/a9cxhV4Qy5bIs91IUe+LhN0sV/wI9sUdcI1lSbhGH2/wOUP5d
	 0r95HFKjqdFKqSK/QScwRk8KhdcS/JsJTq6rcAZGqh3giIYlB5D9fEbZnov+ybwujv
	 4a6/2WLpTZLU8PqJG5tua+ACgkKEGDDnuSIvg0JPfxrQLRB/v4DV1Rq4TCHDhYUXmH
	 FB60EBNc8XwIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5376FC27C53;
	Wed, 19 Jun 2024 16:50:29 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Thu, 20 Jun 2024 00:50:24 +0800
Subject: [PATCH] soc: mediatek: Disable 9-bit alpha in ETHDR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-9bit_alpha-v1-1-13c69daaf29f@mediatek.com>
X-B4-Tracking: v=1; b=H4sIAFAMc2YC/0XM7QrCIBiG4VMZ/k7QuZnuVGKEr742qX3kbAzGz
 j1rQT/vB55rIzPGgDNpio1EXMIcxiEHPxXEdma4IQ0uNylZWTHJNdUQ0tU8ps5QoT2A1sZaASQ
 fpog+rF/s0h4d8fnKZjrGP9kUP7CmPbpgEt6piz0dcE3UOMk4iEr7UjSL+NBgZqR27PuQmkKWH
 itg8lwr7irFUEnBNRes9pwpQPAeLENN2n1/AwQtdJzhAAAA
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718815828; l=2248;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=iFWhQ/l8OT7lINIvtBNo7lMXyTigd+l7pk0Z9HnOTR8=;
 b=5fOrKi33gu2tz5LCPRmVxBETuDsDJ7q3F5v5c8dLfS73sIguoLBp6/9YqHdMFi6FzFcejXbCC
 py8wLZrEWqyAHrhF/yJ5vjYhCP+35tbSnq4QcNMXtfbjYJPMCVir82X
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

When 9-bit alpha is enabled, its value will be converted from 0-255 to
0-256 (255 = not defined). This is designed for special HDR related
calculation, which should be disabled by default, otherwise, alpha
blending will not work correctly.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/soc/mediatek/mtk-mmsys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index f370f4ec4b88..938240714e54 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -236,6 +236,7 @@ void mtk_mmsys_mixer_in_config(struct device *dev, int idx, bool alpha_sel, u16
 
 	mtk_mmsys_update_bits(mmsys, MT8195_VDO1_MIXER_IN1_ALPHA + (idx - 1) * 4, ~0,
 			      alpha << 16 | alpha, cmdq_pkt);
+	mtk_mmsys_update_bits(mmsys, MT8195_VDO1_HDR_TOP_CFG, BIT(15 + idx), 0, cmdq_pkt);
 	mtk_mmsys_update_bits(mmsys, MT8195_VDO1_HDR_TOP_CFG, BIT(19 + idx),
 			      alpha_sel << (19 + idx), cmdq_pkt);
 	mtk_mmsys_update_bits(mmsys, MT8195_VDO1_MIXER_IN1_PAD + (idx - 1) * 4,

---
base-commit: 62fe4b067581d480e863191305f108bebffbc0e9
change-id: 20240619-9bit_alpha-39fbb99acc3b
prerequisite-change-id: 20240615-mediatek-drm-next-ad601b349f23:v3
prerequisite-patch-id: fdd0efbeca41c69c6fa93a5e49a2f16b3d2e8ef7
prerequisite-patch-id: 24bfda7b207bf9698ab88c7233d9168187aa54bb
prerequisite-patch-id: f2ab4804bbe54091a89b310c2ecd4b65fe031137
prerequisite-patch-id: 26bfe746bda376c070c23c72fcc25949e396d952
prerequisite-patch-id: b0b1589f88a9067b93a1e439e1db9abbde96e9e8
prerequisite-patch-id: 14603755fd2d5b6f0ef8a7843e118d0e8d27f57d
prerequisite-patch-id: 86f89ad0a06705cd2ad2867e9409da5610c9d228
prerequisite-patch-id: bd0b091709980bc6e993055d78573f3979139662
prerequisite-patch-id: 2f4da7b628f9d1f03e045b4c8f04b53eeb133a03
prerequisite-patch-id: 9ee1d1b3c69dc6ca828c21fae9180d2e9b5cd4d5
prerequisite-patch-id: 5c1f57bc1bd2d56061c2b927c9efbc9dad36ab68
prerequisite-patch-id: 05443d9f227599f0784da4006c4c983513654087
prerequisite-patch-id: 694abac72844a2b9753453aa514f9485a47a8f32
prerequisite-patch-id: 99f314c9dc697cb78c57d1311dfe055204b9e7b8

Best regards,
-- 
Hsiao Chien Sung <shawn.sung@mediatek.com>



