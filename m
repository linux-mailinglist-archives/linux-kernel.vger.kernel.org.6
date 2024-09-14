Return-Path: <linux-kernel+bounces-329241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F40978F0C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 10:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E8F8B27966
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B243913D51B;
	Sat, 14 Sep 2024 08:16:31 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248AA749A;
	Sat, 14 Sep 2024 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726301791; cv=none; b=BFXQwBD/Gk/UXaN33SwinQVlKj70WAg9UcGDYkSjsQiKbtEhLd7WN8zQeCejt4sx0vohX5VB5eAcqM+QiMqh8wJlsoTTe1fV3PRXRKf6onUpaKV2DXM+4z1n4p8F1HaHuGUeNkG9bHQKP+2K77tj+P0c+Pby+dfq6PYs6jhUfRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726301791; c=relaxed/simple;
	bh=Xm70qA5TINNqEgWIYiIK01VDtk+x++S0wteTAF4+bps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iWi8SLmpOjo9GETzu5BUPN7MOjdxg/pyVUK/jvT6ziNBuVmwHZfWe69FNBro1KkPobme6GnChr758ATQJe1H+cku8UNPwahWyoxjuLvAEhs6cnesD+lRe7y/cpxL+I2PHut3g8eX6xPulcoXrkZlw0ttlPM4TDtwdJmQa1xLJsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee666e546550f4-089b7;
	Sat, 14 Sep 2024 16:16:23 +0800 (CST)
X-RM-TRANSID:2ee666e546550f4-089b7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from leadsec.example.com.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee466e54653e1e-99ba7;
	Sat, 14 Sep 2024 16:16:23 +0800 (CST)
X-RM-TRANSID:2ee466e54653e1e-99ba7
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: topology: Fix incorrect addressing assignments
Date: Sat, 14 Sep 2024 16:16:08 +0800
Message-Id: <20240914081608.3514-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable 'kc' is handled in the function
soc_tplg_control_dbytes_create(), and 'kc->private_value'
is assigned to 'sbe', so In the function soc_tplg_dbytes_create(),
the right 'sbe' should be 'kc.private_value', the same logical error
in the function soc_tplg_dmixer_create(), thus fix them.

Fixes: 0867278200f7 ("ASoC: topology: Unify code for creating standalone and widget bytes control")
Fixes: 4654ca7cc8d6 ("ASoC: topology: Unify code for creating standalone and widget mixer control")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/soc-topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index af3158cdc..97517423d 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -889,7 +889,7 @@ static int soc_tplg_dbytes_create(struct soc_tplg *tplg, size_t size)
 		return ret;
 
 	/* register dynamic object */
-	sbe = (struct soc_bytes_ext *)&kc.private_value;
+	sbe = (struct soc_bytes_ext *)kc.private_value;
 
 	INIT_LIST_HEAD(&sbe->dobj.list);
 	sbe->dobj.type = SND_SOC_DOBJ_BYTES;
@@ -923,7 +923,7 @@ static int soc_tplg_dmixer_create(struct soc_tplg *tplg, size_t size)
 		return ret;
 
 	/* register dynamic object */
-	sm = (struct soc_mixer_control *)&kc.private_value;
+	sm = (struct soc_mixer_control *)kc.private_value;
 
 	INIT_LIST_HEAD(&sm->dobj.list);
 	sm->dobj.type = SND_SOC_DOBJ_MIXER;
-- 
2.33.0




