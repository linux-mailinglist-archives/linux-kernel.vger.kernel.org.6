Return-Path: <linux-kernel+bounces-222693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50479105CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBCA1C2127D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ED31AD4B7;
	Thu, 20 Jun 2024 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="B5L9UxOR"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92601AD412;
	Thu, 20 Jun 2024 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889990; cv=none; b=Su7tYSsvGc0FjmZU7faOUbW7QzY1x1LttJ8vSgs89z7xsf08TMLnaeCEfRZGCErdl5VvNfltYQ80TXHKlNyvTLbAJL+f4xNPFgaDi0fp9r9BraMmzDTM2J2FQmI4krIaboDozkxb+kUKFgfBlQ1cftVDj7saiWZw5BJpL/xlfIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889990; c=relaxed/simple;
	bh=RvP66MGZQKO50spCBDsPb9yVYBK+JXQ7W1AFlr+gI/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GVJ0fubL/0uhXk6jStSMS9qXwgyhW40fi9RC8iZNnDsU/BNEhtY+y70xjEObzFg13l6b0sj7SxcEXJpvcxos36sp9U7ZODVvelKPAgSrscZV3S7bgEBFsAvzWiXLnXwu1VmAeLXJWkT8bxNrMZXyCsgRZYbzHDQ6fHKKRCr5y7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=B5L9UxOR; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 042249C3240;
	Thu, 20 Jun 2024 09:26:28 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id iMhGuKzcpnbW; Thu, 20 Jun 2024 09:26:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 10B2E9C57BB;
	Thu, 20 Jun 2024 09:26:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 10B2E9C57BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1718889987; bh=ao0WzsH9C9Fs3h30ZfBXgXnzt2j72vf6eP80hXlg++o=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=B5L9UxORS1oQU7YxuD78I9ddj3NppF6gbtdxlkF69ABYmslCDJUkO6QPb5kzuF/an
	 wjBp/YaDJHaEOyrdG8dj146t/dhA6IrbSyu69Y880FcT1o59LGp7YHVSMXSpCS+g7Z
	 r9Q6fFWzxM6hNo10PdgPIW4vfq3hOhbNzZ72e9Za5RDFwm3ZzYKFUimq2/ryAxup6H
	 DVc1NI9ipllgfWtKDdyyIce+pFSoBmc63pTOpvDuhnAeQQOK8GY96Sm7TI7r2qcYnL
	 I24CNqChjRb7G+idfO5tWmNuIp+GK6/LhHeFje6dFMg4XfsqhSufD6A5o8mrRZtL8j
	 Wts0ToO6nq5kw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 5L5N86gzCHlc; Thu, 20 Jun 2024 09:26:26 -0400 (EDT)
Received: from gerard.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 34E9A9C5625;
	Thu, 20 Jun 2024 09:26:24 -0400 (EDT)
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
Subject: [PATCHv5 2/9] ASoC: fsl-asoc-card: add support for dai links with multiple codecs
Date: Thu, 20 Jun 2024 15:25:04 +0200
Message-Id: <20240620132511.4291-3-elinor.montmasson@savoirfairelinux.com>
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

Add support for dai links using multiple codecs for multi-codec
use cases.

Co-developed-by: Philip-Dylan Gleonec <philip-dylan.gleonec@savoirfairelinu=
x.com>
Signed-off-by: Philip-Dylan Gleonec <philip-dylan.gleonec@savoirfairelinux.=
com>
Signed-off-by: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index eb67689dcd6e..e8003fbc8092 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -542,6 +542,7 @@ static int fsl_asoc_card_late_probe(struct snd_soc_card=
 *card)
 static int fsl_asoc_card_probe(struct platform_device *pdev)
 {
 	struct device_node *cpu_np, *codec_np, *asrc_np;
+	struct snd_soc_dai_link_component *codec_comp;
 	struct device_node *np =3D pdev->dev.of_node;
 	struct platform_device *asrc_pdev =3D NULL;
 	struct device_node *bitclkprovider =3D NULL;
@@ -552,6 +553,7 @@ static int fsl_asoc_card_probe(struct platform_device *=
pdev)
 	const char *codec_dai_name;
 	const char *codec_dev_name;
 	u32 asrc_fmt =3D 0;
+	int codec_idx;
 	u32 width;
 	int ret;
=20
@@ -816,10 +818,10 @@ static int fsl_asoc_card_probe(struct platform_device=
 *pdev)
=20
 	/* Normal DAI Link */
 	priv->dai_link[0].cpus->of_node =3D cpu_np;
-	priv->dai_link[0].codecs->dai_name =3D codec_dai_name;
+	priv->dai_link[0].codecs[0].dai_name =3D codec_dai_name;
=20
 	if (!fsl_asoc_card_is_ac97(priv))
-		priv->dai_link[0].codecs->of_node =3D codec_np;
+		priv->dai_link[0].codecs[0].of_node =3D codec_np;
 	else {
 		u32 idx;
=20
@@ -830,11 +832,11 @@ static int fsl_asoc_card_probe(struct platform_device=
 *pdev)
 			goto asrc_fail;
 		}
=20
-		priv->dai_link[0].codecs->name =3D
+		priv->dai_link[0].codecs[0].name =3D
 				devm_kasprintf(&pdev->dev, GFP_KERNEL,
 					       "ac97-codec.%u",
 					       (unsigned int)idx);
-		if (!priv->dai_link[0].codecs->name) {
+		if (!priv->dai_link[0].codecs[0].name) {
 			ret =3D -ENOMEM;
 			goto asrc_fail;
 		}
@@ -848,10 +850,11 @@ static int fsl_asoc_card_probe(struct platform_device=
 *pdev)
 		/* DPCM DAI Links only if ASRC exists */
 		priv->dai_link[1].cpus->of_node =3D asrc_np;
 		priv->dai_link[1].platforms->of_node =3D asrc_np;
-		priv->dai_link[2].codecs->dai_name =3D codec_dai_name;
-		priv->dai_link[2].codecs->of_node =3D codec_np;
-		priv->dai_link[2].codecs->name =3D
-				priv->dai_link[0].codecs->name;
+		for_each_link_codecs((&(priv->dai_link[2])), codec_idx, codec_comp) {
+			codec_comp->dai_name =3D priv->dai_link[0].codecs[codec_idx].dai_name;
+			codec_comp->of_node =3D priv->dai_link[0].codecs[codec_idx].of_node;
+			codec_comp->name =3D priv->dai_link[0].codecs[codec_idx].name;
+		}
 		priv->dai_link[2].cpus->of_node =3D cpu_np;
 		priv->dai_link[2].dai_fmt =3D priv->dai_fmt;
 		priv->card.num_links =3D 3;
--=20
2.34.1


