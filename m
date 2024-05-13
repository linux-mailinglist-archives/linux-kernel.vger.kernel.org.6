Return-Path: <linux-kernel+bounces-177924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902AF8C4647
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15771C232A6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39EE24B2A;
	Mon, 13 May 2024 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="NMO3deRZ"
Received: from msa.smtpout.orange.fr (smtp-77.smtpout.orange.fr [80.12.242.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741632C1A0;
	Mon, 13 May 2024 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621937; cv=none; b=pfJU4+ZsPDnrBFvQSBk3TNJ9K3cBH+/cM1PYrCnE84tlOc55wvQJ/HNWMToqVGkL//wCsDzoM9k44KhkafTgpJ2FkqAeFmHS3uMuuXrb5WPRtx2ZLoWi2W1VQTYCqDG3arWKnS0VbwmZ+Fo/o0l95EziySktYVBxpJgZ7TIBO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621937; c=relaxed/simple;
	bh=Ze4YnXQ9+Ruy/YlREfo5kfMqxowQDPvZTQDp2yrWKWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nDBM45R/YW/Z0bjmndlO+TO3szcvTk6BtCbPcCOSPkcpt1+GyYfbPZbM0URZ7ZCcvIwojO+QldE/buSgIHZMJhgzq0f4ROqDxACDHGXmWNb6xTUA9MbYjyGAySW/iKWb5rs9aQMydUhWbQxEv7sgweaQA23NIG0RZycclcVnxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=NMO3deRZ; arc=none smtp.client-ip=80.12.242.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 6ZcDs0lh7ME2z6ZcDsL7zL; Mon, 13 May 2024 19:37:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715621857;
	bh=mUQBjk+s3SNdJ92QJBlXrlaeh+q14MQJ4sqID/f3sz8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=NMO3deRZtCm5rDDebG9M7A7LwCm4uV4f+sAz704wyybGDhXxX8Or/waFg25iNWZ48
	 KC88iB5AnZCkLGd4/ejfRKI6lDxfivEGiy42vwPOPvgV7EOAtmconRrWNG5abdIKP1
	 NhsMyrL4lniKsWUSNxIvFs44Y9rs/14Zmq6w/TRgJpkkwBsrPrz0ETpc6LzgxDoU4A
	 5s61tRwo132xm/WP5fXuHOWw2iZA5No1lav/OhJBGhdX3V9m9hsTOwdjjLwMw7KTb9
	 a3t18nt/SSvlN5CCYR30dwt96vmTn2rkH/NYZSHs22JRiOBs44XiGLVgNDJTCrF7rQ
	 sttZOFEvI3jxw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 13 May 2024 19:37:37 +0200
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
Subject: [PATCH 1/6] ASoC: topology: Constify an argument of snd_soc_tplg_component_load()
Date: Mon, 13 May 2024 19:37:20 +0200
Message-ID: <f2f983e791d7f941a95556bb147f426a345d84d4.1715526069.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snd_soc_tplg_component_load() does not modify its "*ops" argument. It
only read some values and stores it in "soc_tplg.ops".

This argument and the ops field in "struct soc_tplg" can be made const.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/sound/soc-topology.h | 2 +-
 sound/soc/soc-topology.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index f055c6917f6c..1eedd203ac29 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -178,7 +178,7 @@ static inline const void *snd_soc_tplg_get_data(struct snd_soc_tplg_hdr *hdr)
 
 /* Dynamic Object loading and removal for component drivers */
 int snd_soc_tplg_component_load(struct snd_soc_component *comp,
-	struct snd_soc_tplg_ops *ops, const struct firmware *fw);
+	const struct snd_soc_tplg_ops *ops, const struct firmware *fw);
 int snd_soc_tplg_component_remove(struct snd_soc_component *comp);
 
 /* Binds event handlers to dynamic widgets */
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 90ca37e008b3..b00ec01361c2 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -73,7 +73,7 @@ struct soc_tplg {
 	int bytes_ext_ops_count;
 
 	/* optional fw loading callbacks to component drivers */
-	struct snd_soc_tplg_ops *ops;
+	const struct snd_soc_tplg_ops *ops;
 };
 
 /* check we dont overflow the data for this control chunk */
@@ -2334,7 +2334,7 @@ static int soc_tplg_load(struct soc_tplg *tplg)
 
 /* load audio component topology from "firmware" file */
 int snd_soc_tplg_component_load(struct snd_soc_component *comp,
-	struct snd_soc_tplg_ops *ops, const struct firmware *fw)
+	const struct snd_soc_tplg_ops *ops, const struct firmware *fw)
 {
 	struct soc_tplg tplg;
 	int ret;
-- 
2.45.0


