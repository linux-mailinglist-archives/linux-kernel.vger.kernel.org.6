Return-Path: <linux-kernel+bounces-221532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A086290F50B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65161C228B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6572A156C6C;
	Wed, 19 Jun 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LL/fLTO2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E8155C94
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818032; cv=none; b=r6wfdYpYWdSQzC59t1mnZbiUPa2XVoPAxNwzPTAKjopXc9n4bYN9+gOV9JTlsSRXcOJvKwt2rj4JoJr3kQwIQxomfdAXVYARfuDbFwMljs/BORgIWOuEmcbm2GIoBbN6Ie26KEudISHoLDt5XcelA95XcaRREhrVP84Y17HBmCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818032; c=relaxed/simple;
	bh=Nao5IZ6gS4htHNI4Bs9XEbYk4qFYkFkjgxxw6oHgg5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bwBqITaUzAXuWNgM5YXP0I+OX6PJ7km0Nk/Qc9rmMdRDJd/ILFjoMYQaci2lQbhf7ZdLLg6kER9WjjZHYuY4+3ibHtYaMSMX9VKTvEuiOefdJcH36VxNpxCRcJm53A0za7RFKfGX+2IdbXQ6JYE6lUjwpjg84eNvpckPaRLeFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LL/fLTO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6281EC4AF0B;
	Wed, 19 Jun 2024 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818032;
	bh=Nao5IZ6gS4htHNI4Bs9XEbYk4qFYkFkjgxxw6oHgg5g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LL/fLTO29QX2UaABYk2m4jwVlQpE+Z2f7JkQUuxFbIwkjHAYmrqg3xpJ8y1RfPSk9
	 OqRw209EfLXmF31R67OKclMXtzlg2tPyEj5DsjcTBCKzC30lgjm9oMCfiQSW6YtX0H
	 q7zwfpenEx5FknB6phOrM0DSyLLMg1o6OCL+SSSRSAY98xcMb9Cx89E3IVhWzTOjqv
	 Gk7GOkP+RcMknB7TDFcJD/KhJPQZEQH1j0vBT7WTaPF0isgJM11RFASC9eT9P3aueG
	 zprewtlOc6fKGK9WLy6HFMcya8z77ypCfAgq6G+lmUgzo7O2DiA/26cR7+WnjDAW/l
	 raBOBxSXKg3Hg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55424C27C53;
	Wed, 19 Jun 2024 17:27:12 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Thu, 20 Jun 2024 01:27:09 +0800
Subject: [PATCH 4/5] drm/mediatek: Support "Pre-multiplied" blending in
 Mixer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-blend-v1-4-72670072ca20@mediatek.com>
References: <20240620-blend-v1-0-72670072ca20@mediatek.com>
In-Reply-To: <20240620-blend-v1-0-72670072ca20@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718818030; l=936;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=3bQjcoj+V0e9su0dM39EChvPukc7zStbrzEBWWh/Frw=;
 b=tmGg6oENStsgX78tH+bSHouFVDAfE2H7VBaEIK/gPa76rctdyJWSPy0rnc5TkdUO5Jnni8zSK
 fbpepZ4ykebB0sXZivN86VVGHO6snBnajwCVvviUw2iYjuEzcz//B+b
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Support "Pre-multiplied" alpha blending mode in Mixer.
Before this patch, only the coverage mode is supported.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_ethdr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
index 48b714994492..bc43d0d760c1 100644
--- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
+++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
@@ -177,7 +177,8 @@ void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
 		alpha_con |= state->base.alpha & MIXER_ALPHA;
 	}
 
-	if (state->base.pixel_blend_mode == DRM_MODE_BLEND_PIXEL_NONE)
+	if (state->base.pixel_blend_mode == DRM_MODE_BLEND_PIXEL_NONE ||
+	    state->base.pixel_blend_mode == DRM_MODE_BLEND_PREMULTI)
 		alpha_con |= PREMULTI_SOURCE;
 	else
 		alpha_con |= NON_PREMULTI_SOURCE;

-- 
Git-146)



