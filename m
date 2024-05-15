Return-Path: <linux-kernel+bounces-179965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8B08C682C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC2D1C21F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E2113F42D;
	Wed, 15 May 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="fUruR3hW"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F8C13EFEC;
	Wed, 15 May 2024 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715781688; cv=none; b=FzDeeYnhFXwKX/S2BRYxXuBlt86l7As6/LnOgCufDydamhFG83HD8GOoeKEfUvGzK0ZENhyX+mVyD3WbeD+UizcDkoIWSYJv519wTLtzUmWo/X8jf7kLts7UwewtNy5POCWbDWl2NZHxeEiB2s7zZI40NOImf8XRQGxJaFO/O3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715781688; c=relaxed/simple;
	bh=xwRUh0Q2BEauu+Nl2a/vlTqpSIVntSobu/oSaitZYuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fKM5r8bX/cPaojsNUc6yJXyuoVQmYMisOa56NsiFWTpxfxoMgP05z9tD7puIghgJ9HyoKvPtBhy8Bk2pyOYzWfeFHoZ6+KqXmDC5qPnNwRUZ0mIjVF405ehukrBahT7RhItI1dCRr8I4bGmAiI+KrhCTjSNrSVgC+WdVeOFVwL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=fUruR3hW; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CAD0A9C58F5;
	Wed, 15 May 2024 09:54:22 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Vsvw-3Gl_yow; Wed, 15 May 2024 09:54:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F3B129C58F1;
	Wed, 15 May 2024 09:54:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com F3B129C58F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1715781262; bh=/chpUC0ukdj/AkYVw/i/VbX5GAidH0oA2LX3Jzux/F4=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=fUruR3hWfJ3B2AU7MRup/BInecKGrZqxqzu0u7skxC3oxODqJFKJTES78g28qZjrV
	 D3fhVpjgRpmYhPlugcWM3q9hh87WXH+ZH+3AAXMrQzRhadUd3h5vcF1M7ufHaQ9A7A
	 LcbJKTLgT+3OsxoOmOZKdGrwpIdySqlZKjDHhc+wIeYYanPo+BF2mgo9Bn69eUq8CX
	 X1SdSF3ue5LY1y+VktZKEKv4K6uYT304Y/Naxucn4ZWOTiuezh6Ge0AE5y7EPjvJwt
	 zwDQqZzyipiVxncOHQKaOJ82VXt6HLqyE3ZZjl2T2/dbFueh/7+csp9yDn7tX97Yek
	 P+xo17keh9A4g==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id XlufncGnrO2c; Wed, 15 May 2024 09:54:21 -0400 (EDT)
Received: from gerard.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 02C819C58F5;
	Wed, 15 May 2024 09:54:19 -0400 (EDT)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Subject: [PATCHv4 1/9] ASoC: fsl-asoc-card: add support for dai links with multiple codecs
Date: Wed, 15 May 2024 15:54:03 +0200
Message-Id: <20240515135411.343333-2-elinor.montmasson@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add support for dai links using multiple codecs for multi-codec
use cases.

Signed-off-by: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Co-authored-by: Philip-Dylan Gleonec <philip-dylan.gleonec@savoirfairelinux=
com>
---
 sound/soc/fsl/fsl-asoc-card.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 5ddc0c2fe53f..8a2a6e5461dc 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -815,10 +815,10 @@ static int fsl_asoc_card_probe(struct platform_device=
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
@@ -829,11 +829,11 @@ static int fsl_asoc_card_probe(struct platform_device=
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
@@ -844,13 +844,19 @@ static int fsl_asoc_card_probe(struct platform_device=
 *pdev)
 	priv->card.num_links =3D 1;
=20
 	if (asrc_pdev) {
+		int i;
+		struct snd_soc_dai_link_component *codec;
+		struct snd_soc_dai_link *link;
+
 		/* DPCM DAI Links only if ASRC exists */
 		priv->dai_link[1].cpus->of_node =3D asrc_np;
 		priv->dai_link[1].platforms->of_node =3D asrc_np;
-		priv->dai_link[2].codecs->dai_name =3D codec_dai_name;
-		priv->dai_link[2].codecs->of_node =3D codec_np;
-		priv->dai_link[2].codecs->name =3D
-				priv->dai_link[0].codecs->name;
+		link =3D &(priv->dai_link[2]);
+		for_each_link_codecs(link, i, codec) {
+			codec->dai_name =3D priv->dai_link[0].codecs[i].dai_name;
+			codec->of_node =3D priv->dai_link[0].codecs[i].of_node;
+			codec->name =3D priv->dai_link[0].codecs[i].name;
+		}
 		priv->dai_link[2].cpus->of_node =3D cpu_np;
 		priv->dai_link[2].dai_fmt =3D priv->dai_fmt;
 		priv->card.num_links =3D 3;
--=20
2.34.1


