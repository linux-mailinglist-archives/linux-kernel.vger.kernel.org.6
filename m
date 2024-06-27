Return-Path: <linux-kernel+bounces-232010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7925D91A181
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33487281C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8B313A272;
	Thu, 27 Jun 2024 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="iYoFHi7c"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86C61386A7;
	Thu, 27 Jun 2024 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477114; cv=none; b=WUUJauUwipzsG2Bv0Ua9uoG3H3LHrDA48YiQjtkUugnlwIiUq6UFVcW9HSeZ7tqk+SPECNKxD0HmFGBvsIrZ3nxPrHpCdvPtX12teJXWrtJxWowj0F0HXo9YDr13uLNQGz8Rj67bmI/2aTTBmzQiwz/m2+lDr/VoaYbe1UFuOEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477114; c=relaxed/simple;
	bh=3ubglKc/KOQfIaZlNmwQ0fJ7AXhD9dtSkMjUYfLv3QM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T4U+jR4rh4vH7n+DMTgfG/2msH+NkYMg+AkQkQbXo6dk13ACpiwvLFis0pFuMrUp97Px+dJDNedxBHOdeICFyZGUzbjcABDKatzXjaZUvPc/1jr3StzBuEE3WNKbq9OAm2rE049rkYeFV0ikfKwt5IiO8eVH/beQmh6Ax40aJ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=iYoFHi7c; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E55BC9C595F;
	Thu, 27 Jun 2024 04:31:51 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id d8tKaNxiVuZo; Thu, 27 Jun 2024 04:31:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EA0DF9C4232;
	Thu, 27 Jun 2024 04:31:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com EA0DF9C4232
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1719477110; bh=QtA/pIJ8bF/vOwhsCRzTiYA82D2ZNAC429FN7VFxLnA=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=iYoFHi7c2ldTqYeXoZ5zXCmflmPxBsilcj7xlUoFiX9PX+0E37x9nD/INbT15hgQu
	 tgzkyMNY4wyW4IW1efK0xelwD8O/25DTmSiBZEPxrxkH8TzPZDjugSVcWz5Nh0QntQ
	 jSG62IO07yIMvYOrWef56vRDkX3I3GilcLtDXLNUxgOZ1AxOqK7bi3TP2M8EdGQEcK
	 x4jWhXznqPBhVa/bifbMr7NQIAJauaq2ChoePjiUxMh7ddRbnwsn1RpjQwRzTvOnch
	 lIgb+NadoSk5MjSrkW+KGrsOr+7ml4ni95ixwP0t5mISjLkWjc2Q2cjjz3qW4O/HZa
	 Y0UMtmfTgMdGA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 9MbFl3u25aSd; Thu, 27 Jun 2024 04:31:50 -0400 (EDT)
Received: from gerard.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 1526C9C595F;
	Thu, 27 Jun 2024 04:31:47 -0400 (EDT)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>,
	Philip-Dylan <philip-dylan.gleonec@savoirfairelinux.com>
Subject: [PATCH v6 2/7] ASoC: fsl-asoc-card: add second dai link component for codecs
Date: Thu, 27 Jun 2024 10:30:59 +0200
Message-Id: <20240627083104.123357-3-elinor.montmasson@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627083104.123357-1-elinor.montmasson@savoirfairelinux.com>
References: <20240627083104.123357-1-elinor.montmasson@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a second dai link component for codecs that will be used for use
cases with 2 codecs.
It is needed for future integration of the SPDIF support, which will
use spdif_receiver and spdif_transmitter drivers.

To prevent deferring in use cases using only one codec, also set
by default the number of codecs to 1 for the relevant dai links.

Co-developed-by: Philip-Dylan Gleonec <philip-dylan.gleonec@savoirfairelinu=
x.com>
Signed-off-by: Philip-Dylan Gleonec <philip-dylan.gleonec@savoirfairelinux.=
com>
Signed-off-by: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index e8003fbc8092..805e2030bde4 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -296,7 +296,7 @@ static int be_hw_params_fixup(struct snd_soc_pcm_runtim=
e *rtd,
=20
 SND_SOC_DAILINK_DEFS(hifi,
 	DAILINK_COMP_ARRAY(COMP_EMPTY()),
-	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY(), COMP_EMPTY()),
 	DAILINK_COMP_ARRAY(COMP_EMPTY()));
=20
 SND_SOC_DAILINK_DEFS(hifi_fe,
@@ -306,7 +306,7 @@ SND_SOC_DAILINK_DEFS(hifi_fe,
=20
 SND_SOC_DAILINK_DEFS(hifi_be,
 	DAILINK_COMP_ARRAY(COMP_EMPTY()),
-	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+	DAILINK_COMP_ARRAY(COMP_EMPTY(), COMP_EMPTY()));
=20
 static const struct snd_soc_dai_link fsl_asoc_card_dai[] =3D {
 	/* Default ASoC DAI Link*/
@@ -622,6 +622,8 @@ static int fsl_asoc_card_probe(struct platform_device *=
pdev)
=20
 	memcpy(priv->dai_link, fsl_asoc_card_dai,
 	       sizeof(struct snd_soc_dai_link) * ARRAY_SIZE(priv->dai_link));
+	priv->dai_link[0].num_codecs =3D 1;
+	priv->dai_link[2].num_codecs =3D 1;
=20
 	priv->card.dapm_routes =3D audio_map;
 	priv->card.num_dapm_routes =3D ARRAY_SIZE(audio_map);
--=20
2.34.1


