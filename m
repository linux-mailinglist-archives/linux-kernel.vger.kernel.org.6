Return-Path: <linux-kernel+bounces-319574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF1D96FECC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 02:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5E9281C71
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ED9134B1;
	Sat,  7 Sep 2024 00:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSxPW2sF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC0125BA;
	Sat,  7 Sep 2024 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725670540; cv=none; b=XDuXvvsgcfmv7gc61sEF6t8zRSFUm09faMKEypVoDM7O4N2ZzUdINTNWn7BNjQeKHpii78R7qxnZiZm8pXMzJDi1H+myd1pZYPaJ/UrHnnvYzCbrm7mFmRDWQzB/OKxlyRt5bvMQPR3VUXsATjkXE0vt1q4Pfq9K/hZFCbiGecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725670540; c=relaxed/simple;
	bh=iSQufWGpx94L8jD/fIu7r3A06l7ki4DXdmHTvAiYL80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RyHLfiq/YD2D0v7uNIO+gDLSsK4Ea1pmvOBagYD/ocRn9zvDbnHMGZnkQthV+l8WF3aIyF2HCprw/z0jcYPL0zPov17y/jyK2WyEZYdrjtYxoVUUoMdPIx+76CZPlcx2QuPQjivIRyAzXpQ+XS3sEObAMWdE4TrlizEXYPWnpBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSxPW2sF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5AAC4CEC4;
	Sat,  7 Sep 2024 00:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725670540;
	bh=iSQufWGpx94L8jD/fIu7r3A06l7ki4DXdmHTvAiYL80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sSxPW2sFMCFSmehq8NSEkbXl3fNtzmSJ9LJxUiy6tk22JT1lWq0k/LNUUiKu/SWGl
	 IX3IqozxmqcyuX0oEOt8pVnSMV+NH+WF9Yb83qz7NnFR0g653PywNMg0CH66N7EoO0
	 fjHh/pOGEPv6TFJnSl9C+I3DDQOf/D7qkxpWgY4Qg+ureyaU2baNYd9YDMUipPzWyq
	 eVgcbLokxA1nBTxvlridk71RPJzLAStxaKyF2tM56XnfdEAmSiOoCvrlLr5QuXltUu
	 3V9/0yIrW4ii28dpVafBdut8suqjYmH323Igr8scJODtq4NWv9kmC90YeQC24oYqvD
	 mW+Om5SotZQ2A==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 07 Sep 2024 01:53:27 +0100
Subject: [PATCH 2/7] ASoC: mt8365: Remove spurious unsigned long casts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240907-asoc-fix-mt8365-build-v1-2-7ad0bac20161@kernel.org>
References: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
In-Reply-To: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Alexandre Mergnat <amergnat@baylibre.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580; i=broonie@kernel.org;
 h=from:subject:message-id; bh=iSQufWGpx94L8jD/fIu7r3A06l7ki4DXdmHTvAiYL80=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm26R+zknCtJq+ENLDqwu1RsLA7s39ffxBc41Hj
 KN25Rko+ZmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZtukfgAKCRAk1otyXVSH
 0IHSB/92x7A9qdeg88jK2oSvesXS/dYxWzhp9sqLKjt2RvrB7oYqO/C2RlYbYaf1todLCgSAQhe
 p+jsJEaaD5U9vMDyp6rd/+2Urx5qJcBVXU/KlVptzaNrytAcyBVqqwMqwFH8S6V3RoisfHV9VTc
 N67ePaaDqers+7fgRq/rkUHfM3UdXOiKm3GkegtrcvrSWHIa7zapJwgTnjinufYnCXrFn3OGpe1
 d7Htr52YKD9WAH2sL6Ro3Rvdggjwi4RvTtc/ncnASTEgLdF3ZYDM+IbWtjP0tL4ZNXbXLQUzMr+
 NMiVrX+ihx36pTcGzqAKpgMZgKJoi1pPPXlL7rcL9jh3bGAt
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The regmap APIs take unsigned ints not unsigned longs so casting their
arguments to unsigned longs is not a good choice, the constants being
cast here are all unsigned ints anyway.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
index 5003fe5e5ccf..6b4d8b7e24ca 100644
--- a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
+++ b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
@@ -385,7 +385,7 @@ static int mt8365_afe_set_2nd_i2s_asrc(struct mtk_base_afe *afe,
 		/* disable IIR coeff SRAM access */
 		regmap_update_bits(afe->regmap, AFE_ASRC_2CH_CON0,
 				   COEFF_SRAM_CTRL,
-				   (unsigned long)~COEFF_SRAM_CTRL);
+				   ~COEFF_SRAM_CTRL);
 		regmap_update_bits(afe->regmap, AFE_ASRC_2CH_CON2,
 				   CLR_IIR_HISTORY | IIR_EN | IIR_STAGE_MASK,
 				   CLR_IIR_HISTORY | IIR_EN |
@@ -393,7 +393,7 @@ static int mt8365_afe_set_2nd_i2s_asrc(struct mtk_base_afe *afe,
 	} else {
 		/* disable IIR */
 		regmap_update_bits(afe->regmap, AFE_ASRC_2CH_CON2,
-				   IIR_EN, (unsigned long)~IIR_EN);
+				   IIR_EN, ~IIR_EN);
 	}
 
 	/* CON3 setting (RX OFS) */
@@ -456,7 +456,7 @@ static int mt8365_afe_set_2nd_i2s_asrc_enable(struct mtk_base_afe *afe,
 				   ASM_ON, ASM_ON);
 	else
 		regmap_update_bits(afe->regmap, AFE_ASRC_2CH_CON0,
-				   ASM_ON, (unsigned long)~ASM_ON);
+				   ASM_ON, ~ASM_ON);
 	return 0;
 }
 

-- 
2.39.2


