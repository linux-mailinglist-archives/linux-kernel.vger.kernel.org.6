Return-Path: <linux-kernel+bounces-226294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B250913C90
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45411F21D8E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 15:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4641822E6;
	Sun, 23 Jun 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="QCd1Vmfi"
Received: from out.smtpout.orange.fr (out-11.smtpout.orange.fr [193.252.22.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47BCF9F0;
	Sun, 23 Jun 2024 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719157828; cv=none; b=TKsnAHxYh2nXo+CCbM8Nit9FXGH93Dc1VK1KskfwP2Su8XoQaoOP5JgoKJPFq5hyl+TJy8SxdoVKgvz7BH1zFOdszSJ5/Kay8iVXxxSJjILriVL1cNkraeO5uEO7v9JD7A26K+rfQfNQv1H6Mdfho493reK2G9Z3PcwPJIPfa/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719157828; c=relaxed/simple;
	bh=VTtHoMRrh/CknLnrTiA6cISWe0B7QIazQmbA5Bs4n5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KzHjULzbzwBKM33nQCSa6m/YjLH6F6ptkUj/0r9bVNkQH1Ox4NQ6E6PMSfh/G7GIkJ95+pCBt9Z++8/Al8Tg04494wEE7eSRLXCPwwesFTatecy5jopJYfUhx09BmGWZAPHg6+iViTXNw51EnZgu0EWCDfHSZ3rWnHx6ZhxPpcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=QCd1Vmfi; arc=none smtp.client-ip=193.252.22.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id LOvzs9RlN2GQtLOvzsbDUH; Sun, 23 Jun 2024 17:15:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1719155719;
	bh=6xc2xyXmsrpTItWg6IptTdpN90W19e46SCweNrwd4z4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=QCd1Vmfi7/8s3qsK8bcJq1V3dXy73L7NZiNWiMW2h/YlojSzlRfWprMCDw3ibhUk2
	 W6vX3VEQsVlKfW1edVOsjY6V/EhNgQNszuWZH/BS9yyRwaR5+yQ93jQIHmSm/+j79y
	 YOoAdA2eMSBy5sq7mRbob3AguiMoy95CsrbLvgDwD7u4z4DKAAaxq2diqhomNZoN+H
	 eQ8JcyJ128zs2PY923RLqCPMgGbdeBEKLbcGAyV8G5PIc4fQuPgO7zgICNwhoFv+jv
	 6muz8tudmTkaRTOLabI5bXCM2DXdgFRef7pHsEL4PUEvn7CllwapiA6mL99TA6Z+dZ
	 N798nWjA/7hPw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 23 Jun 2024 17:15:19 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH] ASoC: Intel: sst: Constify struct intel_sst_ops
Date: Sun, 23 Jun 2024 17:15:11 +0200
Message-ID: <098acdf266b2f4a922d6a624e9032ec24a09093c.1719155688.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct intel_sst_ops' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  12250	   1000	    112	  13362	   3432	sound/soc/intel/atom/sst/sst.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  12378	    888	    112	  13378	   3442	sound/soc/intel/atom/sst/sst.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only
---
 sound/soc/intel/atom/sst/sst.c | 2 +-
 sound/soc/intel/atom/sst/sst.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index e0357d257c6c..ff03fde12151 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -158,7 +158,7 @@ static int sst_save_dsp_context_v2(struct intel_sst_drv *sst)
 }
 
 
-static struct intel_sst_ops mrfld_ops = {
+static const struct intel_sst_ops mrfld_ops = {
 	.interrupt = intel_sst_interrupt_mrfld,
 	.irq_thread = intel_sst_irq_thread_mrfld,
 	.clear_interrupt = intel_sst_clear_intr_mrfld,
diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index 126903e126e4..e0db7434543c 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -391,7 +391,7 @@ struct intel_sst_drv {
 	unsigned int		csr_value;
 	void			*fw_in_mem;
 	struct sst_sg_list	fw_sg_list, library_list;
-	struct intel_sst_ops	*ops;
+	const struct intel_sst_ops	*ops;
 	struct sst_info		info;
 	struct pm_qos_request	*qos;
 	unsigned int		use_dma;
-- 
2.45.2


