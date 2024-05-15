Return-Path: <linux-kernel+bounces-179946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 182788C67D8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497781C21C48
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 13:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A486F13FD87;
	Wed, 15 May 2024 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="baJF1SR7"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3F213EFEC;
	Wed, 15 May 2024 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715781276; cv=none; b=EeCOFWxB2Btk8y/KG3Tgx3L8SjXtA7cw44TYuwso2+RiGNzpKOpGbxM7ZmEyHzXO4VXlBHzozcDPf1ABLlQ5u1406b7GSgYsQz8cgNX23XUY26myAGprqy72XAq1vbSTZIWFrlrx3zmSiNaieENjGfYh1HTrOupJtBmaVH+DPXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715781276; c=relaxed/simple;
	bh=CvwLp7rRgODumkCVPlKyo9UnPRGVu+hOstA18eL9OIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jWsiq3h+3dZK6mdnhICtXKOTmRB6aSRanZ3Lyj9rGLesvkN4Efro5BkmhXxWXfUGrT+ZiAtRbCHc0lGPgiKDjm3PUQwv88GT5J3MXBXCg923IyRXC0RlkKB/Kc1FpEVnrBHf7KySMGyFzkH9PV0DCbVx+rmbVERBHp4LMhX1v+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=baJF1SR7; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D606F9C5907;
	Wed, 15 May 2024 09:54:30 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id hFB7ldS9sGge; Wed, 15 May 2024 09:54:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 482349C58FB;
	Wed, 15 May 2024 09:54:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 482349C58FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1715781270; bh=S3WJQMbggwuOXUtStHzsdr+LdyckdrxsaoJfGQHraCs=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=baJF1SR7U91qNsNFtSZRL3ETC9P1i6jDW+CqNzbZjFfgfxMqUn6AR/13ayi4KOBbB
	 1NUM4lVN6crPEQuLEk7/Tj68UUiAnsJSsWg/Lk3snSBqAIe/lHgih0IJ8kqRqKk6Lk
	 lC7rC9bq5YDfGiP/qCqxyv6yDnE0OBh0coTIF2Im6cas4TymiPwNqterQNcLr1FXJ/
	 e+t0GbhNfsHc7py91ZtjpWPFJtwn5wBpDsiEWgnab3zG9dsjqxt7KILWSbkzTirE6c
	 q6PxoZzrOH/azAKmQPU0680pMosgZfsRKs1lTaCRCFmttzLRrwGLVlpTEhNMFyJLNv
	 sjHpqPz4DYlgQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id CDS4YqcRc2gE; Wed, 15 May 2024 09:54:30 -0400 (EDT)
Received: from gerard.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 4DB699C58F8;
	Wed, 15 May 2024 09:54:28 -0400 (EDT)
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
Subject: [PATCHv4 5/9] ASoC: fsl-asoc-card: set generic codec as clock provider
Date: Wed, 15 May 2024 15:54:07 +0200
Message-Id: <20240515135411.343333-6-elinor.montmasson@savoirfairelinux.com>
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

The default dai format defined by DAI_FMT_BASE doesn't set if the codec
is consumer or provider of the bit and frame clocks.

S/PDIF DIR usually converts audio signal to an asynchronous I2S/PCM
stream, and doesn't consume a bit or frame clock.

As S/PDIF DIR and DIT are used as codecs for the generic use case,
set codecs as provider of both bit and frame clocks by default.

Signed-off-by: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Co-authored-by: Philip-Dylan Gleonec <philip-dylan.gleonec@savoirfairelinux=
com>
---
 sound/soc/fsl/fsl-asoc-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index a4ecc9093558..82ed7f4e81a1 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -750,6 +750,7 @@ static int fsl_asoc_card_probe(struct platform_device *=
pdev)
 		generic_codec_dai_names[1] =3D "dir-hifi";
 		priv->dai_link[0].num_codecs =3D 2;
 		priv->dai_link[2].num_codecs =3D 2;
+		priv->dai_fmt |=3D SND_SOC_DAIFMT_CBP_CFP;
 	} else {
 		dev_err(&pdev->dev, "unknown Device Tree compatible\n");
 		ret =3D -EINVAL;
--=20
2.34.1


