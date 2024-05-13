Return-Path: <linux-kernel+bounces-177921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 601AC8C463F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C7D1F24C12
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F6E2942F;
	Mon, 13 May 2024 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="W1sQ4L4K"
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718DF2C1A0;
	Mon, 13 May 2024 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621872; cv=none; b=S6N90BkYAG23yY+KI5lQyjP/lJzXc43dFe1uKhj0mef7axoDecNH//G9NIq8OOU0qItYfRXnR8vnpFPUdYBMoYz6wEA4D1rWVSCVJjJAQEnbM32T76hEL2bSLralmFb36kSrfpf7d+jQRCTb4b/U99hUehES5RQ0dd7lL2rmW5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621872; c=relaxed/simple;
	bh=mmp/3E5t0JWgl4/OYoYB0/Z3Zg7EBCcBulwzfpIlR2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElQzqRw7btoLi+SnmGpQB3mnisaDzAtjFXyixbe0QlNUcuHWavL/2D/eM3rigul1d1fGlckWoA2CDB25O8cBYmYJqTX6cjQIzOytsdBYyUK6rjyMSZkEV3DoZi9BN+qMG7ZBYd8rwv5flq+alIZsUrsbm4XMbidrpBNOoJLtyzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=W1sQ4L4K; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 6ZcDs0lh7ME2z6ZcMsL81f; Mon, 13 May 2024 19:37:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715621863;
	bh=A26Rl7MtM3B51oWgHFeoUVOcPLJ5BY3Z+dYCWIU7CTA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=W1sQ4L4KZKDLj0JG8sMTDYYCXP31N2hT7k41A6sBY2Z8c0LmZkf9HmTV/yO2SncVE
	 fgorRdt1du9JSEGgtxOsjW91X/7ATkARIMK+pmfb4WbV5x5hzRPtusgNdtVHouDF3L
	 OqZrK0UvU6SQ01Fi6g0FG6FOTaZCiJYN0Gf9HnzRQi9gSWxCC0eUxSXeKuAXU4mWy6
	 4YJe+ZsrlXunh3/sPF2VAAlGiwUES0zAWQEt38sO9Ba/mnlhnzUWeKbsfmSIp373kF
	 bygSM8HADDUbJfdv1hbyvQ+HVlzyFBhQ6LoWuQd0F44GMSmFGRJHgiwtSqXZQVu79B
	 mp4n6S/LpS+PA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 13 May 2024 19:37:43 +0200
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
Subject: [PATCH 4/6] ASoC: Intel: Skylake: Constify struct snd_soc_tplg_ops
Date: Mon, 13 May 2024 19:37:23 +0200
Message-ID: <48f096b6dc617ecf3ca53211c2a696a4df33b21a.1715526069.git.christophe.jaillet@wanadoo.fr>
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
  58844	   5282	     56	  64182	   fab6	sound/soc/intel/skylake/skl-topology.o

After:
   text	   data	    bss	    dec	    hex	filename
  59004	   5122	     56	  64182	   fab6	sound/soc/intel/skylake/skl-topology.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index e27f0fc3d897..602ef4321122 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3470,7 +3470,7 @@ static int skl_tplg_complete(struct snd_soc_component *component)
 	return 0;
 }
 
-static struct snd_soc_tplg_ops skl_tplg_ops  = {
+static const struct snd_soc_tplg_ops skl_tplg_ops = {
 	.widget_load = skl_tplg_widget_load,
 	.control_load = skl_tplg_control_load,
 	.bytes_ext_ops = skl_tlv_ops,
-- 
2.45.0


