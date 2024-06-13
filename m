Return-Path: <linux-kernel+bounces-214430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A3A90844C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99BD284FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C29F148FE5;
	Fri, 14 Jun 2024 07:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="g/xzsFh2"
Received: from msa.smtpout.orange.fr (out-66.smtpout.orange.fr [193.252.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED97914884C;
	Fri, 14 Jun 2024 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718349530; cv=none; b=DnH96pCmAYAxHxzhyQArK41VrywZrGHP+BazGpuBD0cpI1VOF+yi9re1gvNrC0zGbtG8jsI3gcz/bYA7oWya4WCXfabPhcz5jXLWfTR6/9+Qedms6wothiDJ+bHkHY//Rt6gFMjQlyPbzORHl7CA4rzQ6m+27ThJYvfaEhA1PZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718349530; c=relaxed/simple;
	bh=6du1KfglJLoWLvTGWtPHrIfbGlhezcXOWIFkFAthN5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6iFw8799MnIu0/8aWqWWlyN38C19wyc8p4AyOfrwlyiQ8IzTk5OyXoB78p3PZ5jGh2/VOZPxEvZfG/d0Je1s9dwpzWofCW9MoHRHqclhdnYdgTlEXS1NUmtYVchY6Y54/6zhPmOqYaUUMSxRyxLRxK6esRKGS2NjbOw7vLqd/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=g/xzsFh2; arc=none smtp.client-ip=193.252.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id HrXUsAUflNbytHrXUsgDhP; Thu, 13 Jun 2024 22:59:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1718312364;
	bh=vkHkCaWtDIfpH8ijSazjk6Jfhs+hqJsnwjns3+SaeCg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=g/xzsFh2MkamRdsQKDv53s+bAw6tPvjMHfmSFNRtrNOApkoOHKjv8Wc8/TdKeyfHC
	 ipqv5H/DVpYWUGNABFHxxry+9ml49vL45+z9DUtryf5awGJe4IKtn91XOCKo/UcemF
	 LWS2tvL39XMnecXlmQK76b+veHt/RUwr0gTF5p+XivJpqZkj0eHJgUnQ/9fSDXHckf
	 uThafhO/uCu9jHd4W8CVwelQm+aXU/6hIARUdCqqg7nfteQd2ljfqKlUEW0D1JELkH
	 X9SbpLIpyg4rCTrU/jJSvugjpRUz1PYc7WmD47W0TZjy0vTSrA+Bk0IZ7D6tVYxwxl
	 kzn6hRUxIzbzg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 13 Jun 2024 22:59:24 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH] ASoC: SOF: mediatek: Constify struct mtk_adsp_ipc_ops
Date: Thu, 13 Jun 2024 22:59:09 +0200
Message-ID: <a45d6b2b5ec040ea0fc78fca662c2dca3f13a49f.1718312321.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct mtk_adsp_ipc_ops' is not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increase overall security.

In order to do it, "struct mtk_adsp_ipc" also needs to be adjusted to this
new const qualifier.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  15533	   2383	      0	  17916	   45fc	sound/soc/sof/mediatek/mt8195/mt8195.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  15557	   2367	      0	  17924	   4604	sound/soc/sof/mediatek/mt8195/mt8195.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/linux/firmware/mediatek/mtk-adsp-ipc.h | 2 +-
 sound/soc/sof/mediatek/mt8186/mt8186.c         | 2 +-
 sound/soc/sof/mediatek/mt8195/mt8195.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/firmware/mediatek/mtk-adsp-ipc.h b/include/linux/firmware/mediatek/mtk-adsp-ipc.h
index 5b1d16fa3f56..6e86799a7dc4 100644
--- a/include/linux/firmware/mediatek/mtk-adsp-ipc.h
+++ b/include/linux/firmware/mediatek/mtk-adsp-ipc.h
@@ -40,7 +40,7 @@ struct mtk_adsp_chan {
 struct mtk_adsp_ipc {
 	struct mtk_adsp_chan chans[MTK_ADSP_MBOX_NUM];
 	struct device *dev;
-	struct mtk_adsp_ipc_ops *ops;
+	const struct mtk_adsp_ipc_ops *ops;
 	void *private_data;
 };
 
diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c b/sound/soc/sof/mediatek/mt8186/mt8186.c
index bea1b9d9ca28..74522400207e 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186.c
+++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
@@ -82,7 +82,7 @@ static void mt8186_dsp_handle_request(struct mtk_adsp_ipc *ipc)
 	}
 }
 
-static struct mtk_adsp_ipc_ops dsp_ops = {
+static const struct mtk_adsp_ipc_ops dsp_ops = {
 	.handle_reply		= mt8186_dsp_handle_reply,
 	.handle_request		= mt8186_dsp_handle_request,
 };
diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 31dc98d1b1d8..24ae1d4959be 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -82,7 +82,7 @@ static void mt8195_dsp_handle_request(struct mtk_adsp_ipc *ipc)
 	}
 }
 
-static struct mtk_adsp_ipc_ops dsp_ops = {
+static const struct mtk_adsp_ipc_ops dsp_ops = {
 	.handle_reply		= mt8195_dsp_handle_reply,
 	.handle_request		= mt8195_dsp_handle_request,
 };
-- 
2.45.2


