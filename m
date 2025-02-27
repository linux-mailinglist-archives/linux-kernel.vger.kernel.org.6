Return-Path: <linux-kernel+bounces-536375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB8A47EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8881892F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B9F22FE05;
	Thu, 27 Feb 2025 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUzIF0sw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE322F3A3;
	Thu, 27 Feb 2025 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662386; cv=none; b=ijWnc7Vg3HVHi5mJ+c5NRsJk+XCb69WMqh5iJ+d8kjpQzeJv0rxuN6pQQlF0RSm4eGCrgLqXb+3kwyFT0sYkb9dGgdgGiZtkWLe0fOWNRL4rEcVzttAjR5hMq7O7lDC4iaMQxRjgLv36Rq7Xe8SJp1FpenBlGuaRlhDopPthL/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662386; c=relaxed/simple;
	bh=nW5BiIn0YY0mTP99cWvGx5b/yVrftP8IeddADOYqBGs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gNT0int2029bDD3b14NsodtprIV40QV+0OAcz12pE3bvkIHVdohM4Cg1RoohcH+dX0KnBRH6/LslTL8pnVYuA8VDM24o6BJH4Ni2BsGIKNcR9miT0hWL5iS2KbKLb1qSuqnHgTI2tPB738b2sHdh1lRoYAlBjDf03T3PyRCNqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUzIF0sw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C302C4CEE7;
	Thu, 27 Feb 2025 13:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740662386;
	bh=nW5BiIn0YY0mTP99cWvGx5b/yVrftP8IeddADOYqBGs=;
	h=From:To:Cc:Subject:Date:From;
	b=YUzIF0swFxoup6z6QOJJrcJn1JjDsL6QInSriI61Pf/0VegFMk6tDcJT1zJEJkTFo
	 ed+CujGahHYepR+8jK4o/1IVlTdEpgpbAlhQRFfixz0Hr4zLaWVBQre3YrbPqO85Aj
	 HS9TjEuWpdL8aKMDXb5kdlTGtxqdVUMRFTFr2a2frvxby8vNaDhkgzDVHFeM7YGiUg
	 F4hlXpVB2bS/GOhqUPYp5iRjDqzaoYPwfx97C9GyFYYxoNRtSoGag4QxCvHsmVnAm4
	 CAX20iulNsI/YyQ1JgXYr7OBm8eNDQjuhs5VIufCY8tx9buHuA2jvZz+Baxfd4EY4G
	 /KXk10eol7QCw==
From: Arnd Bergmann <arnd@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	parkeryang <Parker.Yang@mediatek.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: mediatek: mt8188: avoid uninitialized variable use
Date: Thu, 27 Feb 2025 14:19:01 +0100
Message-Id: <20250227131939.1040168-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The 'msk' variable has no initialization:

sound/soc/mediatek/mt8188/mt8188-dai-dmic.c:311:4: error: variable 'msk' is uninitialized when used here [-Werror,-Wuninitialized]
  311 |                         msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(i);
      |                         ^~~

Set it to zero before the loop.

Fixes: c1e42ec04197 ("ASoC: mediatek: mt8188: Add support for DMIC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/mediatek/mt8188/mt8188-dai-dmic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/mt8188/mt8188-dai-dmic.c b/sound/soc/mediatek/mt8188/mt8188-dai-dmic.c
index 4cfbcb71d2d9..adcea7818be2 100644
--- a/sound/soc/mediatek/mt8188/mt8188-dai-dmic.c
+++ b/sound/soc/mediatek/mt8188/mt8188-dai-dmic.c
@@ -307,6 +307,7 @@ static int mtk_dmic_event(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		/* request fifo soft rst */
+		msk = 0;
 		for (i = dmic_num; i >= DMIC0; i--)
 			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(i);
 
-- 
2.39.5


