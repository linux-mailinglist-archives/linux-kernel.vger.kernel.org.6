Return-Path: <linux-kernel+bounces-221237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D2390F0B8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69ACA2820CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A2215253D;
	Wed, 19 Jun 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMFTBPV1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA9844384
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807535; cv=none; b=QxeizmXWNZF8EvsLN44ib54JrDxtsmJ80GgZt9BBzF3GZVPLLzcGwjCcXNk/8om1Un5NnldqTgCBWm4f8Wlmducmf4+O9IG9bZ3lPsVLa8PMDqemI5zbbOePsaFh2l6jggzSXu6gr7pZk3B2JOAv/wv5xvZGaZdj9xj0js+weC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807535; c=relaxed/simple;
	bh=bC3Si/6VjKUhWZGnhO1+v4RCNXyIdUIMDytgGFUCEeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sjzRY5Sesg2Dv3DYMljWnYOQsKEDxD2EvKbFJugiFa+SPcOqrIg7Z40s6agJTRlsTuQ7QqUukPvZzjOBGsBRP8cBt8jSGQv2weN+fVK5Vraqt3l3oV0rESxEFf8yBYcPjgLCGz6tpeDnwWDoTTt1iVgCrhnXvOxpXq0bgq69Gwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMFTBPV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2512C4AF17;
	Wed, 19 Jun 2024 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718807535;
	bh=bC3Si/6VjKUhWZGnhO1+v4RCNXyIdUIMDytgGFUCEeI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LMFTBPV1mkQReAs2Y7JRnpH+i1/6Jdh4qXzFjvnNoLxBLzzoJDrmaIySOFimXunCi
	 GQ6MoJP9iZ0Zbuz+ivx5uSIaARq4UCCJCnn44l05w4haQS08HAp7mrPaEjzZIDQGZ4
	 3RaGMWZLYMSiI2p1/HirRaZKPeTVHjPI/23sBd6ZLi+hslUXlcGKlsiZCv+bAO4G8+
	 vuvX8ma7WYi3ZC8rozqz7/EhIOOwgQOIvDkv38Se6muViVg+mHW5W7n56+8OZGGV8b
	 aqjT1cIJJwXpVHqId+iXTnBnZ5ZqeLeTprkOmhS3WKRebkXlRckTCzpXS9EmuZKyI3
	 j45otqXdmSbkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B57C27C79;
	Wed, 19 Jun 2024 14:32:14 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Wed, 19 Jun 2024 22:30:52 +0800
Subject: [PATCH v2 11/14] drm/mediatek: Support RGBA8888 and RGBX8888 in
 OVL on MT8195
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-mediatek-drm-next-v2-11-abf68f46f8d2@mediatek.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718807531; l=841;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=UFfbnC0Pk+UyDIilXA9CBuArzD2VEBaxjen+ZQRfSQA=;
 b=PSTLyTlCrPco9xY23+obmFFokEvg7Hv7ZDW/+98AnpFtFaL1N2wbvIJpIUrm41sonE2UBa7Wp
 39Ay5MhUleDCvuEHdepP3AugZ4dlViRy1hq7lnDwbtUfaLoZ1Qc+EsM
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Support RGBA8888 and RGBX8888 formats in OVL on MT8195.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 671b1258d9c8..33b58da15ba4 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -117,6 +117,8 @@ static const u32 mt8195_formats[] = {
 	DRM_FORMAT_XBGR8888,
 	DRM_FORMAT_XBGR2101010,
 	DRM_FORMAT_ABGR2101010,
+	DRM_FORMAT_RGBX8888,
+	DRM_FORMAT_RGBA8888,
 	DRM_FORMAT_RGBX1010102,
 	DRM_FORMAT_RGBA1010102,
 	DRM_FORMAT_RGB888,

-- 
Git-146)



