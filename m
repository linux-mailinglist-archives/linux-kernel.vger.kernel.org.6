Return-Path: <linux-kernel+bounces-177922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7BA8C4642
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB94A1F20EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37BA39FEC;
	Mon, 13 May 2024 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XWQayaUl"
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80305339A1;
	Mon, 13 May 2024 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621873; cv=none; b=vA1nW6LYEPTK5nmDKHHwu7jAsO+p+lo57Bj/dPegaYOYU2S3N7Mw93sgimB/wNt0f5UtxrONdCqf+PfV5Pms+tearZlMpTenH9+twMsOyKCRhIBLdbZJeUDRYcE1j2vq4d8AgKgdLAJw586lwM9byVhb/yRwuXti7KUQvNg8/bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621873; c=relaxed/simple;
	bh=5NI70CwdCr6ds3UXpAse5bSY/w2S2qX7EJ/03/SHaBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjRdjKEGl0Yn7G1XSpPD45ac9hcn6GL2i9cqwZsWkiPm6MQMSb5JmnfuBxNl6Nb4GpOXYA5cy6BO59fo4bThQILth/bFZwUq4VpHg8XTjOrTKPumAaLaxK1VnQXQm6HS35+tZPXtWsdu2EgviNS/hHTd5StZrcpiaUZY0aWQ3MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XWQayaUl; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 6ZcDs0lh7ME2z6ZcNsL821; Mon, 13 May 2024 19:37:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715621864;
	bh=tArMz3CXGARffdI7GxCeEXs4RlHzAXyCNuBRtNfPV0w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XWQayaUl7WTsSQ5YM4kr8gQgm3qMIo2et81SM55AGN8EHTknUjJSUpj7xQgEorIfj
	 DZZKp+bwgM9AZ1sZbI6vdNeIVUpfeq1TdYFqCuAWrzGTfnHxSIndH6ykKyqmx49ZQv
	 jRWlYChvnRad263+ngdk3IM+02SqNMmSmYz3vyvVxVuCrDCQpDf9O3vLAk/xsZHCBE
	 RbH2p5/tC5iwGfuJTqWO7WMCcAHiX6jS4LxkAiu6mEWGSJJa2G9U/td4xAI46ONVCA
	 UrqCRtoobwviGkpEGdSt3fdbiEQjYrRa/2NJOCX/8pR6OioW5xKWtQTRE8S1h0ngfF
	 0PWWuO4oLY+KQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 13 May 2024 19:37:44 +0200
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
Subject: [PATCH 5/6] ASoC: SOF: topology: Constify struct snd_soc_tplg_ops
Date: Mon, 13 May 2024 19:37:24 +0200
Message-ID: <2d9f5b75e979eb38b6f3baf85dfa1f0fdb3447ef.1715526069.git.christophe.jaillet@wanadoo.fr>
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
  44519	   2888	     48	  47455	   b95f	sound/soc/sof/topology.o

After:
   text	   data	    bss	    dec	    hex	filename
  44839	   2552	     48	  47439	   b94f	sound/soc/sof/topology.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 sound/soc/sof/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index da182314aa87..b54382131991 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -2278,7 +2278,7 @@ static const struct snd_soc_tplg_bytes_ext_ops sof_bytes_ext_ops[] = {
 	{SOF_TPLG_KCTL_BYTES_VOLATILE_RO, snd_sof_bytes_ext_volatile_get},
 };
 
-static struct snd_soc_tplg_ops sof_tplg_ops = {
+static const struct snd_soc_tplg_ops sof_tplg_ops = {
 	/* external kcontrol init - used for any driver specific init */
 	.control_load	= sof_control_load,
 	.control_unload	= sof_control_unload,
@@ -2433,7 +2433,7 @@ static int sof_dspless_link_load(struct snd_soc_component *scomp, int index,
 	return 0;
 }
 
-static struct snd_soc_tplg_ops sof_dspless_tplg_ops = {
+static const struct snd_soc_tplg_ops sof_dspless_tplg_ops = {
 	/* external widget init - used for any driver specific init */
 	.widget_ready	= sof_dspless_widget_ready,
 	.widget_unload	= sof_dspless_widget_unload,
-- 
2.45.0


