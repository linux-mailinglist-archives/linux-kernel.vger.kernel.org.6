Return-Path: <linux-kernel+bounces-177933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BF88C4667
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108B31C21EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CE429422;
	Mon, 13 May 2024 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ES/EOgJ9"
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66742224CF;
	Mon, 13 May 2024 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622389; cv=none; b=Rf1CLVqhymYGjqMDKsOqrsJAqETRy8/cuujB0MB4YdX1wd4CTwRZ6Dw5j5616JGTq4PD9SmzobP8FrnkBnRC11JnE9vs/S+GwiZAd/zbS7LA9Ib2UThSzHAIWPCbT+ZCHxCdigInpwDWW+SH981AiNTxuxWEv/8I8Nd3qBk2im8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622389; c=relaxed/simple;
	bh=WdpcdrePfNwFsbix0el9X+8Z4a1fgWVJwTo9rg3XJJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsFpC4MBEEGxFStzkxtu7t9HJHOHZC6glEZcWi7u7SKPU1WF2AcLhZ5rlsnYGaJf5Y3a9B2tG+QmtgPRU6usucs7GwFn8SWzBhoobTtUezOFX3X5n1R9T6gKucM6SKja6rjDNIN0YVZEzoVsNqwIfKt2jxVELZzp9mEGUH9/igY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ES/EOgJ9; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 6ZcDs0lh7ME2z6ZcIsL80i; Mon, 13 May 2024 19:37:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715621859;
	bh=1XoI0qrkb16jr4M55oFmdJGGB7I4eLKt6bnnOAdsEJI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ES/EOgJ9+o9BPNKuuyYur0AGTIYX0XLGxXu2HluR7bjjtu66uy6rWHVo/iKF3pU6y
	 JKm8sxRQdmfgDD+XHlvwH2DntmE4uF+hgUONv6Fm9DVXj+7xJx/fxE9u4xsDv9LPeS
	 v7BsukwIRkRJyPM1aXye/w95YCk+GS974eSBzFDfL7UVUw37BZBFvLusX7U1Ub68j+
	 +rZrfOifHQCi6Z+/ddV6+kmhlsmaBFUJT2FHLjGLBTQASPoijThCxFctm3OcdLxOdU
	 TWuJqJCJTUBqR8qdb00OEtPkmTi+UFBkrCfMVMg4IjWlGu9pa38fiHwTr5d0/OrP4o
	 0UPNRn9pa9/9A==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 13 May 2024 19:37:39 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com,
	pierre-louis.bossart@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	srinivas.kandagatla@linaro.org,
	bgoswami@quicinc.com,
	daniel.baluta@nxp.com
Cc: linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	sound-open-firmware@alsa-project.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/6] ASoC: Intel: avs: Constify struct snd_soc_tplg_ops
Date: Mon, 13 May 2024 19:37:21 +0200
Message-ID: <01de0157088de0475970c79738284d6c86d702fe.1715526069.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <f2f983e791d7f941a95556bb147f426a345d84d4.1715526069.git.christophe.jaillet@wanadoo.fr>
References: <f2f983e791d7f941a95556bb147f426a345d84d4.1715526069.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Constifying "struct snd_soc_tplg_ops" moves some data to a read-only
section, so increase overall security.

On a x86_64, with allmodconfig:
Before:
   text	   data	    bss	    dec	    hex	filename
  28046	    794	      0	  28840	   70a8	sound/soc/intel/avs/topology.o

After:
   text	   data	    bss	    dec	    hex	filename
  28206	    614	      0	  28820	   7094	sound/soc/intel/avs/topology.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 sound/soc/intel/avs/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/topology.c b/sound/soc/intel/avs/topology.c
index 02bae207f6ec..35381a835c93 100644
--- a/sound/soc/intel/avs/topology.c
+++ b/sound/soc/intel/avs/topology.c
@@ -1889,7 +1889,7 @@ avs_control_load(struct snd_soc_component *comp, int index, struct snd_kcontrol_
 	return 0;
 }
 
-static struct snd_soc_tplg_ops avs_tplg_ops = {
+static const struct snd_soc_tplg_ops avs_tplg_ops = {
 	.io_ops			= avs_control_ops,
 	.io_ops_count		= ARRAY_SIZE(avs_control_ops),
 	.control_load		= avs_control_load,
-- 
2.45.0


