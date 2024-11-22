Return-Path: <linux-kernel+bounces-417819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AD59D596B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF26B212BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 06:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6621632DC;
	Fri, 22 Nov 2024 06:33:06 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A8E230999;
	Fri, 22 Nov 2024 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732257186; cv=none; b=pkhMvKQrlzwGJv2Nunqyo25w3zvaU7QY1rXBPEo3Bit0EEG4NumSG/4BbSsZrlosWuJbmNKkDEUcj4GtV2DmT3sofrjiin4FbJ7BPKu4fskLjI2ZFhonN0+Vo3o2TmX5F6w/PkBqPxXkVGqRq4MvFz6JNiJMipPeA+yBnc+9kFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732257186; c=relaxed/simple;
	bh=x9sJ6Zy7CIz3xBtjnogNNjy+1a9J/7TjsTTMQ/ALwDE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZSJWM/Wk1ml5paFEvOfUZGhYsldfLZIM11Rm8HwcBZwt/PICNF4bVIHkjA9NpPD6ZZM1zlF8nst6QKswfwR4BO+vHpU8Za/Au+2iKFrX+feYa6lkNbJvBmip5Zrav98DrJ7diJ2f8rj4KgrG8eiTzhCxO1ZssepDIPeRb0vG1M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16740259b45c-35d73;
	Fri, 22 Nov 2024 14:32:59 +0800 (CST)
X-RM-TRANSID:2ee16740259b45c-35d73
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26740259a242-2a36e;
	Fri, 22 Nov 2024 14:32:59 +0800 (CST)
X-RM-TRANSID:2ee26740259a242-2a36e
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	zhujun2@cmss.chinamobile.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: avs: Add error handling in avs_tplg_parse_initial_configs
Date: Thu, 21 Nov 2024 22:32:57 -0800
Message-Id: <20241122063257.4419-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Introduce error handling in avs_tplg_parse_initial_configs to ensure that
the function returns immediately if parse_dictionary_entries fails.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 sound/soc/intel/avs/topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/topology.c b/sound/soc/intel/avs/topology.c
index 5cda52702..3f76581af 100644
--- a/sound/soc/intel/avs/topology.c
+++ b/sound/soc/intel/avs/topology.c
@@ -1500,7 +1500,6 @@ static int avs_tplg_parse_initial_configs(struct snd_soc_component *comp,
 				      AVS_TKN_MANIFEST_NUM_INIT_CONFIGS_U32);
 	if (ret)
 		return ret;
-
 	block_size -= le32_to_cpu(tuples->size);
 	/* With header parsed, move on to parsing entries. */
 	tuples = avs_tplg_vendor_array_next(tuples);
@@ -1522,6 +1521,8 @@ static int avs_tplg_parse_initial_configs(struct snd_soc_component *comp,
 					       AVS_TKN_MOD_INIT_CONFIG_ID_U32,
 					       mod_init_config_parsers,
 					       ARRAY_SIZE(mod_init_config_parsers));
+		if (ret)
+			return ret;
 
 		block_size -= esize;
 
-- 
2.17.1




