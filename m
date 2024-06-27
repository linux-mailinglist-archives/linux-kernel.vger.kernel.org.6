Return-Path: <linux-kernel+bounces-232009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EA291A17E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF402830E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13012137905;
	Thu, 27 Jun 2024 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="Zlu0YZSv"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99182130E4A;
	Thu, 27 Jun 2024 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477111; cv=none; b=U7UhaEq7eq/+w0p9ZwLDjbgToXA/TuUFh7TnL5A0mXKinLsBin2uRcun7LiRVzQJ880aXMGctUYT4qJbtLLij40p5PJBKoFjK3hOgIuKZVdXFp5V85H2a/lJ1JCjb5lfeQs5PtsdpGwLKruMNUWPJX7e48+DBqr/916lElOeFmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477111; c=relaxed/simple;
	bh=RvP66MGZQKO50spCBDsPb9yVYBK+JXQ7W1AFlr+gI/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K121wmBCLnSp3FtKjuUqywxx8mSdwSmrez4zDTB3joENeE5xefhqVGDdmiY7VhnRN6aaXl2SyYnlG01LazfisgEzNYq1DTOfcfAJG8NrLWpl1riAhcbG+Y8mjcMTfUcpj5SF0U4iwi3t+yPVtk0oamUpuzEfhjmrU/816t6JENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=Zlu0YZSv; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E88009C57C2;
	Thu, 27 Jun 2024 04:31:48 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id T-PxCYCpYPeZ; Thu, 27 Jun 2024 04:31:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0132B9C57D2;
	Thu, 27 Jun 2024 04:31:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 0132B9C57D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1719477108; bh=ao0WzsH9C9Fs3h30ZfBXgXnzt2j72vf6eP80hXlg++o=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Zlu0YZSv9PDLV1axQaTg8gA/5TGd0K8hM0XmkG1B7o0OoiwzX/uLjOhrujySA5LTa
	 BwYECccm3oeXM7xdCxdebpk+hT2SQx3Rp4RVHOb7rfOk1syGdSuFnbqVwPIspcc/cv
	 6D6eunvVatP1mcUFR8JIMnNjGTaON9Rz4lEdwJk2Dg5jU+PzcYEIUoHqn6uRVVKj1p
	 6z4eeQOqKLrK/0scf1hq/ed6oKseWMS0DBkJDvSG5jhE1Re08HPbaDajveLNiX5SuG
	 On1BAi7RnpaLP85eZ7mi+1bD03VWT1hw3t2ja7Q0oKax9mGSnwYXZ7ZuyuvYM+tz9A
	 dQRcmfk+KCjbg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id IWSWz7FZ0s_e; Thu, 27 Jun 2024 04:31:47 -0400 (EDT)
Received: from gerard.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 28F239C57C2;
	Thu, 27 Jun 2024 04:31:45 -0400 (EDT)
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
Subject: [PATCH v6 1/7] ASoC: fsl-asoc-card: add support for dai links with multiple codecs
Date: Thu, 27 Jun 2024 10:30:58 +0200
Message-Id: <20240627083104.123357-2-elinor.montmasson@savoirfairelinux.com>
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


