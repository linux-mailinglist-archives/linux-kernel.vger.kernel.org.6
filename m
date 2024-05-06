Return-Path: <linux-kernel+bounces-169901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162D08BCF28
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D011C23BDF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C1E81722;
	Mon,  6 May 2024 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhS1pLRn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2104B811FE
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002533; cv=none; b=rYJiPjCyFUZVA/kw5KI3TGUkr0Hn6k4gydeQv/uDLM4vC/EJ6C94poA69sdID3PxnTmrvD0907/HbzAblXVdQG4GuHeQvcF7FtoihuzAr6TX8VTGyLIUrsDufTf4o/lZK0T+qRJ0cGdv/2JIWhd/Mrd3pc1FqDJkCs355yWB+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002533; c=relaxed/simple;
	bh=46hAq1PCM2INpFGrPzb+MElX1JVQQ10d/aQq2p0zy48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L9Wwro/mFSmpqZrhA3/D70EBf8zOYSzV1sA7nY50H+m4I0SSZ+6oygjOpD0wR+HhFaYFmOWkTMQi0PXkELM01cPh5vTRmWRzlXvyYNVIWVY4mSpbKKe1wXgXiD36DM1OuM/t9hETUA/lX4X9xK0rf00BnwbNosao193i4oygNbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhS1pLRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38788C116B1;
	Mon,  6 May 2024 13:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002532;
	bh=46hAq1PCM2INpFGrPzb+MElX1JVQQ10d/aQq2p0zy48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HhS1pLRn3qUNaKrsNVT+K3AvOvWmUzJ0dJTt14Q3gc7LX6ZSjiLZhmPzq9sacIq5P
	 /RuAtzhq0ZYAnOqzx2hTZ/yk+AZsaWrRdnFmw2WsVQRNx3FfrS5mSPRv6rk9XxiZrf
	 a9GXaqorKyymQxJ6ML4AW9XWEWW3GSYFu6mVTkvH806yeep8NpVXVyJWtQFuWUdo3f
	 97KnrhIsWEpmtjcirMjoc1QspIcLEK6NcDmc9JJjfEpY+FH591lsfQeFzko/lZq4az
	 Jy+6R4jHiSUjuLmQyzHEG+b3lO/XOTDNpdwIHugcjbOIDpggKMW20VEnEYzgY4gvb1
	 4hlAD6+2n6Yqw==
From: Michael Walle <mwalle@kernel.org>
Date: Mon, 06 May 2024 15:34:35 +0200
Subject: [PATCH 06/20] drm/bridge: tc358775: redefine LV_MX()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-tc358775-fix-powerup-v1-6-545dcf00b8dd@kernel.org>
References: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
In-Reply-To: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sam Ravnborg <sam@ravnborg.org>, Vinay Simha BN <simhavcs@gmail.com>, 
 Tony Lindgren <tony@atomide.com>
Cc: Daniel Semkowicz <dse@thaumatec.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.4

Drop the FLD_VAL macro, just use bit shifts. This is a preparation patch
to switch to regmap and to remove the FLD_VAL().

While at it, reformat the LV_x enum.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/bridge/tc358775.c | 36 ++++++------------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 720c0d63fd6a..7ae86e8d4c72 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -124,39 +124,15 @@
 #define LV_MX1619        0x0490  /* Bit 16 to 19 */
 #define LV_MX2023        0x0494  /* Bit 20 to 23 */
 #define LV_MX2427        0x0498  /* Bit 24 to 27 */
-#define LV_MX(b0, b1, b2, b3)	(FLD_VAL(b0, 4, 0) | FLD_VAL(b1, 12, 8) | \
-				FLD_VAL(b2, 20, 16) | FLD_VAL(b3, 28, 24))
+#define LV_MX(b0, b1, b2, b3) \
+	(((b3) << 24) | ((b2) << 16) | ((b1) << 8) | (b0))
 
 /* Input bit numbers used in mux registers */
 enum {
-	LVI_R0,
-	LVI_R1,
-	LVI_R2,
-	LVI_R3,
-	LVI_R4,
-	LVI_R5,
-	LVI_R6,
-	LVI_R7,
-	LVI_G0,
-	LVI_G1,
-	LVI_G2,
-	LVI_G3,
-	LVI_G4,
-	LVI_G5,
-	LVI_G6,
-	LVI_G7,
-	LVI_B0,
-	LVI_B1,
-	LVI_B2,
-	LVI_B3,
-	LVI_B4,
-	LVI_B5,
-	LVI_B6,
-	LVI_B7,
-	LVI_HS,
-	LVI_VS,
-	LVI_DE,
-	LVI_L0
+	LVI_R0, LVI_R1, LVI_R2, LVI_R3, LVI_R4, LVI_R5, LVI_R6, LVI_R7,
+	LVI_G0, LVI_G1, LVI_G2, LVI_G3, LVI_G4, LVI_G5, LVI_G6, LVI_G7,
+	LVI_B0, LVI_B1, LVI_B2, LVI_B3, LVI_B4, LVI_B5, LVI_B6, LVI_B7,
+	LVI_HS, LVI_VS, LVI_DE, LVI_L0
 };
 
 #define LVCFG           0x049C  /* LVDS Configuration  */

-- 
2.39.2


