Return-Path: <linux-kernel+bounces-222692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF3E9105CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4426328262D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2201ACE94;
	Thu, 20 Jun 2024 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="ObaoDSIl"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3841AD3F6;
	Thu, 20 Jun 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889988; cv=none; b=W+sPlq6hXLO/U7vwwFt0PE/01S53L8lrzBAq/4inT9ZGelkvZwXp7VhEZUHhD8ZeNai/FQHYNBpWfGlnExkrbuXE2Jjhb3eMe7KqdANbb3feDUJtrIJ9bP6exDKi0/8CzRat0Yd09WmloxOGksgbX1PHS/SXju3HOHjRogQxOyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889988; c=relaxed/simple;
	bh=v2AmP712irz/a2zwTe5iFg/xqPO9PSrxI/jgGwEXG4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KEsNQhVxhDC2DVKeLIuzt6KjsC21IykvfwfiRmBwLSODzfSkrE0it4WQg3TTrvtWdw/xZxfzBpGazQe3aXiakJREO99hleJJwoG5QSmbhUb7KeXRz4jQUdwQ6A7MmkHz0WPmjlHQIlFG3KhjNhkTsrBa8Jp93UhZhPNuW2Hz5uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=ObaoDSIl; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2AE389C54A9;
	Thu, 20 Jun 2024 09:26:25 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id KPreHJiDSlnz; Thu, 20 Jun 2024 09:26:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 217F29C57BB;
	Thu, 20 Jun 2024 09:26:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 217F29C57BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1718889984; bh=rnaRa3s5akRHLJlulKRjZ+W7/rijbiGvPNafUncEGkI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=ObaoDSIlT0epq0B4NcO9hgilLQSuTnhJt7X/kuXqXLlI62XcsJzkA1W88qkayLCG9
	 PSMx+vBuBScrqNPekRIXYfzLOEF+SVjseO8LbKpoV0Y9fT/+J6wpmUU/aOCtT0kVL1
	 F7W1VhrjSRWaBJ8IjGwk7CgBrgbGKZvJOavU3fJu4n8OC0X4DD4Y2V/8nnUMTsKx49
	 Qb0/WuawuBiTQCZT7ClSS7J57StL0mkesUtdZMtlwF//KG2ZCeaDk4G8reEpDU6wft
	 FiChKIt+GA3rbr62gLbbZg5GNtvEmVnoEuF+imGGtcbxkOAQSG47jeB+0iahcELlvV
	 UuVGPMokdF7TQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id u3XePFP8GpAB; Thu, 20 Jun 2024 09:26:24 -0400 (EDT)
Received: from gerard.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 3EBA99C54A8;
	Thu, 20 Jun 2024 09:26:21 -0400 (EDT)
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
Subject: [PATCHv5 1/9] ASoC: fsl-asoc-card: set priv->pdev before using it
Date: Thu, 20 Jun 2024 15:25:03 +0200
Message-Id: <20240620132511.4291-2-elinor.montmasson@savoirfairelinux.com>
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

priv->pdev pointer was set after being used in
fsl_asoc_card_audmux_init().
Move this assignment at the start of the probe function, so
sub-functions can correctly use pdev through priv.

fsl_asoc_card_audmux_init() dereferences priv->pdev to get access to the
dev struct, used with dev_err macros.
As priv is zero-initialised, there would be a NULL pointer dereference.
Note that if priv->dev is dereferenced before assignment but never used,
for example if there is no error to be printed, the driver won't crash
probably due to compiler optimisations.

Fixes: 708b4351f08c ("ASoC: fsl: Add Freescale Generic ASoC Sound Card with=
 ASRC support")
Signed-off-by: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 5ddc0c2fe53f..eb67689dcd6e 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -559,6 +559,8 @@ static int fsl_asoc_card_probe(struct platform_device *=
pdev)
 	if (!priv)
 		return -ENOMEM;
=20
+	priv->pdev =3D pdev;
+
 	cpu_np =3D of_parse_phandle(np, "audio-cpu", 0);
 	/* Give a chance to old DT binding */
 	if (!cpu_np)
@@ -787,7 +789,6 @@ static int fsl_asoc_card_probe(struct platform_device *=
pdev)
 	}
=20
 	/* Initialize sound card */
-	priv->pdev =3D pdev;
 	priv->card.dev =3D &pdev->dev;
 	priv->card.owner =3D THIS_MODULE;
 	ret =3D snd_soc_of_parse_card_name(&priv->card, "model");
--=20
2.34.1


