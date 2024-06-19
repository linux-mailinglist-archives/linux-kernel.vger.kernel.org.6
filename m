Return-Path: <linux-kernel+bounces-221238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE6F90F0B9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A0E281E31
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED7D15253F;
	Wed, 19 Jun 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EegmEYte"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F68A446B4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807535; cv=none; b=OWScMAetXb1TOKuW1O/OGfeE/mC6H7Qu/NKM2p8QPhmkCSho3xdz5yWbxqdw8bl+Sd25HylbKEC26YraMCdEPxO1DZAIGR0cweYxGFECtSqq8Wy65sfE93nYF1c8RWUm5aZr6KgwlhuB3BmAix8NNwfvdJEPiKOTzwKWd5xAESQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807535; c=relaxed/simple;
	bh=H/xL/aaPV6K8CRmLwrIEXZNxCXF2qf6RiWqeP4TRBnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OTR3JBDnXzEH52B0THtPOAy99vX+NsestvKb54eQMrA4EXA+P0PtIMVL8n+/KMi/ZlRswxeoHhaXVWazcqxBaos32qjNVI3P35hCE4tXi2w7Gr1dBKG2HK3S77nvPGGr2MxXjx6nIkZfesrNmXscWcZxHsvxabbt5J8odoWH8MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EegmEYte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F808C4AF4D;
	Wed, 19 Jun 2024 14:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718807535;
	bh=H/xL/aaPV6K8CRmLwrIEXZNxCXF2qf6RiWqeP4TRBnQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EegmEYteY1gHWVTtILoHw2PhGPJPHuKz4aAZQgy2nze85EQ9az7z1XZM+LypdeUrv
	 BvWWORmmE96Kv9ZYuzRqcfVkng/0rMiwDoCo76ERlFzMYC3dnDqh9kIh0qUp4+ojxh
	 D96IKmuj8eO0oGw/X+/MuUGc0TPApNCksgCWxFKIJTn5nmNRSoy0hnF2ahK7gw2H9C
	 elYmMishTalT4VP09fjVplHVkI+1liiMJK/AyZXj2/iJqqiRSvgchYbI6+RIQcOqEC
	 VnlqNKemyO+ZRppHQEJSV32WPIdC7JN4QmNG4//FU8IQEW66q/roi1mtDn8xmJaDdH
	 fADzNVB7IeG0g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DC8C27C53;
	Wed, 19 Jun 2024 14:32:15 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Wed, 19 Jun 2024 22:30:53 +0800
Subject: [PATCH v2 12/14] drm/mediatek: Support DRM plane alpha in OVL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-mediatek-drm-next-v2-12-abf68f46f8d2@mediatek.com>
References: <20240619-mediatek-drm-next-v2-0-abf68f46f8d2@mediatek.com>
In-Reply-To: <20240619-mediatek-drm-next-v2-0-abf68f46f8d2@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>, 
 Daniel Kurtz <djkurtz@chromium.org>, YT Shen <yt.shen@mediatek.com>, 
 Mao Huang <littlecvr@chromium.org>, "Nancy.Lin" <nancy.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718807531; l=1074;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=A1tCyNili9ONVchgKYjd+o0ng6Y8jo6rrmL1JAOqRUE=;
 b=rnRBBesRm9lrD0ENLA6aPqPsEUWcRgvzTppHIxL520esIcoOx43LOqcoP3OpMUIS4DG1zkvNQ
 oG/KM2onM+1AeTIJYBt2+umWJhT9AypTPKce2GGgN/shhjiC+8ZdNyA
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Set the plane alpha according to DRM plane property.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 33b58da15ba4..f358dbfed5e3 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -450,8 +450,10 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 	}
 
 	con = ovl_fmt_convert(ovl, fmt);
-	if (state->base.fb && state->base.fb->format->has_alpha)
-		con |= OVL_CON_AEN | OVL_CON_ALPHA;
+	if (state->base.fb) {
+		con |= OVL_CON_AEN;
+		con |= state->base.alpha & OVL_CON_ALPHA;
+	}
 
 	/* CONST_BLD must be enabled for XRGB formats although the alpha channel
 	 * can be ignored, or OVL will still read the value from memory.

-- 
Git-146)



