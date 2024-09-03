Return-Path: <linux-kernel+bounces-313726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2334896A914
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9AF1F257D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345081D9D9D;
	Tue,  3 Sep 2024 20:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Junl84Vh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A35B189B8E;
	Tue,  3 Sep 2024 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396317; cv=none; b=E1DurX34OnfAllOml/p35kj5U/70NSR/PRVfEG1Rhs5lZCD0RArDk4dGi2K1wft1V740UcG/ty9X0XMm7vefGSPdsYKYgj76hUIeLtHjZm05NMAl46s/bA3/NM2kYCmjA0LmdIER4p9ieADzO3UiGp/ViXlDAFh/JVRDVLNxWYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396317; c=relaxed/simple;
	bh=ZN3aHPQfFSmVtl+HuC3jUfcxPgpdLvgJItoky229XU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PBneVuaLBwmlhjAhbsyDUJpVNYjW22zPrIdEZJlGGEl0Y1zLS+k6icDVIRgCfzsdYwG91wdmrCO/sDiViezbrWa01qNzSLcH8/aj3wDUMKWeCvbIFyClPlDLl3XO0ASmbWpW3rerxw6N5TFKP8Jf+Zk0U7bI/To5um3/SZkix2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Junl84Vh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C4BC4CEC4;
	Tue,  3 Sep 2024 20:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396317;
	bh=ZN3aHPQfFSmVtl+HuC3jUfcxPgpdLvgJItoky229XU0=;
	h=From:To:Cc:Subject:Date:From;
	b=Junl84VhaoF1CmOGzsuGmdkbNHrrjZDdttT9rk99W/PLqoh285hua+AnlY+cYpGwp
	 /1tcVZMhU2YDmVITSpV2lpPeMtBmwjL5Vazl8o9cUHifCbld50/I4RmKFYIOBWWgj8
	 IFiLUHNS7padTNwGwwdazhjbiOEt7pT29HgBq4/4AMOTzqS97o2NpmgTc6DQ3+xNZF
	 7BsyQdPX+1sizQNOLXwd6BgO9IfUmPTmkVTN5sFnNWyVbg/0iLHGDvJm4bjCm0pKji
	 +eelscbudlFwldF2hbudHgUrTxEZileYvjjo2VFwzZ5cf7G1j16HwBwUHAA91/8kvO
	 bfX/mB0vyk1VA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Albert=20Jakie=C5=82a?= <jakiela@google.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pierre-louis.bossart@linux.intel.com,
	lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	kuninori.morimoto.gx@renesas.com,
	trevor.wu@mediatek.com,
	christophe.jaillet@wanadoo.fr,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 01/17] ASoC: SOF: mediatek: Add missing board compatible
Date: Tue,  3 Sep 2024 15:25:15 -0400
Message-ID: <20240903192600.1108046-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.107
Content-Transfer-Encoding: 8bit

From: Albert Jakieła <jakiela@google.com>

[ Upstream commit c0196faaa927321a63e680427e075734ee656e42 ]

Add Google Dojo compatible.

Signed-off-by: Albert Jakieła <jakiela@google.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Link: https://patch.msgid.link/20240809135627.544429-1-jakiela@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/mediatek/mt8195/mt8195.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 53cadbe8a05cc..ac96ea07e591b 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -663,6 +663,9 @@ static struct snd_sof_of_mach sof_mt8195_machs[] = {
 	{
 		.compatible = "google,tomato",
 		.sof_tplg_filename = "sof-mt8195-mt6359-rt1019-rt5682.tplg"
+	}, {
+		.compatible = "google,dojo",
+		.sof_tplg_filename = "sof-mt8195-mt6359-max98390-rt5682.tplg"
 	}, {
 		.compatible = "mediatek,mt8195",
 		.sof_tplg_filename = "sof-mt8195.tplg"
-- 
2.43.0


