Return-Path: <linux-kernel+bounces-179948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE288C67E2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97020282F69
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBCF1411D8;
	Wed, 15 May 2024 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="ljzj71Wp"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21482140388;
	Wed, 15 May 2024 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715781279; cv=none; b=V01kf8jb5HCTzN7zkIpA3XGbJdIZ8Oj4wtYlUi/FTx/Ij072L6hoYPBqLoSLVL/Lbu87y+bLidO+S0gb1Tkrj0CLfWE+ECOfXuN5Y2qjtKfSC4cam4/GutWlXNrcoBtm6ti917+2CRmytpSsC5mWK2GZTBAxHMbI8JMSZEjiXZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715781279; c=relaxed/simple;
	bh=HmsWWVn+apswWOsWnEuqVhg36ana28bxKeAc7zcNNjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=reXK5HLVSJUwO5xkguHcW75wo1WV8z3J692ZsJO2fhwufYQ5a5EtzpqHd2l7y6ZZNd90MmoYR2dkyRPxP90KOC9D2FFzeqfZicHIoXk7OW6UvYeY60gdSYkme2Fu8SVW9Whyy50cbgDPgr3/k1P8HkpUXkmDjMuBCVPP0BtUW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=ljzj71Wp; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 31B0A9C5916;
	Wed, 15 May 2024 09:54:37 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Ltc_Mz9nNuLl; Wed, 15 May 2024 09:54:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 891C49C5910;
	Wed, 15 May 2024 09:54:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 891C49C5910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1715781276; bh=kEAPwirqd+qGDyNkKpHZSAdDGASOPIMCVpuG1z7ksok=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=ljzj71WpQJVCnTp/Nd/xB9vO2PbBLev6GAlZqnK9EYKQnJ1+Y62SyuquGLNeYvjy9
	 5bVXQPnMU/DojTpq60jwSQIEEX9FFhoBST7H13YqZnLFnmIr66U9FKRGTW8SyuK5+g
	 uOip+gf13WOy5G8lA/030WNHlAVfm18u4vPIju7AWDb2ke0K/fRBoU4MuAaIlM5Vby
	 AiUwzIpP+8InnYsBVf9/nN74nNEowV6xjpuQ34l4g04kUgy5vOlkFGk8rasC4ePCN6
	 kW2dDPyDaBRvHGtBY4iI4D5G0xiDRwjdBEVHpdTNfK6CejUcr4lMFZrRzR99SfKXCQ
	 1WzgVpggDyRuQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Mw-6FlqT01jj; Wed, 15 May 2024 09:54:36 -0400 (EDT)
Received: from gerard.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 8DAF09C5911;
	Wed, 15 May 2024 09:54:34 -0400 (EDT)
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
Subject: [PATCHv4 8/9] ASoC: fsl-asoc-card: add DT property "cpu-system-clock-direction-out"
Date: Wed, 15 May 2024 15:54:10 +0200
Message-Id: <20240515135411.343333-9-elinor.montmasson@savoirfairelinux.com>
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

Add new optional DT property "cpu-system-clock-direction-out" to set
sysclk direction as "out" for the CPU DAI when using the generic codec.
It is set for both Tx and Rx.
If not set, the direction is "in".
The way the direction value is used is up to the CPU DAI driver
implementation.

Signed-off-by: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index c7fc9c16f761..f3fc2b29c92f 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -760,6 +760,10 @@ static int fsl_asoc_card_probe(struct platform_device =
*pdev)
 			priv->cpu_priv.sysclk_freq[RX] =3D priv->cpu_priv.sysclk_freq[TX];
 			clk_put(cpu_sysclk);
 		}
+		priv->cpu_priv.sysclk_dir[TX] =3D
+			of_property_read_bool(np, "cpu-system-clock-direction-out") ?
+			SND_SOC_CLOCK_OUT : SND_SOC_CLOCK_IN;
+		priv->cpu_priv.sysclk_dir[RX] =3D priv->cpu_priv.sysclk_dir[TX];
 	} else {
 		dev_err(&pdev->dev, "unknown Device Tree compatible\n");
 		ret =3D -EINVAL;
--=20
2.34.1


