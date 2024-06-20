Return-Path: <linux-kernel+bounces-222695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C699105D6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FAD1282D19
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786111AE091;
	Thu, 20 Jun 2024 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="HsgPvPPT"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2A01AD4BE;
	Thu, 20 Jun 2024 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889992; cv=none; b=IQNC1Y4RgtpMUCWcPkDL/Jti185Mk8y5K62qg4G+AcnYMRBU5/HFm80o9x5oD0P6FkFL3IphoWIRwLsJToYxtz2CWnaq8SI43r03uJsL+MzWedsvgJv6MhzQ7m98eGRuXcCBzVAFn9oJL9HCaGKPzyI3N0OAvlsS6sNhNH/oF6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889992; c=relaxed/simple;
	bh=3ubglKc/KOQfIaZlNmwQ0fJ7AXhD9dtSkMjUYfLv3QM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QcFNfFxsVlFHDMwGcHGsBP9+ekeTq3t44z89HURkXr7TNR39QWH8+MF8g9X0RrKY2Id/ZPH9G/KP0SHbz8xHfKlF1InAZm/BT5rJSwQbZrdcsEAO9v+IfgS8gVgG7jii8t5/CKF1NKrHNFiFSCfqzFJP1kNDbFJTWf2HpupqqtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=HsgPvPPT; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C17259C5B16;
	Thu, 20 Jun 2024 09:26:30 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id fl0eZEgRxpZp; Thu, 20 Jun 2024 09:26:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 02A289C54A9;
	Thu, 20 Jun 2024 09:26:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 02A289C54A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1718889990; bh=QtA/pIJ8bF/vOwhsCRzTiYA82D2ZNAC429FN7VFxLnA=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=HsgPvPPTwoDHCG+RqNaaAdISoR3KxyHv0RlIXdjQtLwF4UX9EpmKxHFIxmkXt0laX
	 jSqcjZVnw+b5DoQepHdGe38tkkUkiAqkp6KK2FsF4FsHFbdTg/ab8sUeTwZYI5dALC
	 ffiigX34O60QNabSPcsrS2UZgUNOqZ1aqHMCjpwqVLjJ7BvF1F3AgItiT3Qf5lyK/M
	 mzbApItI6inGQzwQ33wAZc6y+ZVGejrBHeYyzZxoynIYNFE6MzT9HP6mn0v9AV0eyR
	 fw1HlujxwHJqU1B+vZXOur5cvVP4mFDhGhQgjbymZNwLGvL3RGtAXUTgqeB7gMMGBs
	 FqYBLbsvJHMeA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id UvN-nFUPYSQE; Thu, 20 Jun 2024 09:26:29 -0400 (EDT)
Received: from gerard.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 22B9B9C5B16;
	Thu, 20 Jun 2024 09:26:27 -0400 (EDT)
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
Subject: [PATCHv5 3/9] ASoC: fsl-asoc-card: add second dai link component for codecs
Date: Thu, 20 Jun 2024 15:25:05 +0200
Message-Id: <20240620132511.4291-4-elinor.montmasson@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620132511.4291-1-elinor.montmasson@savoirfairelinux.com>
References: <20240620132511.4291-1-elinor.montmasson@savoirfairelinux.com>
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


