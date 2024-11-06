Return-Path: <linux-kernel+bounces-397641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 519F49BDE64
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1615D284EF1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 05:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4391917D7;
	Wed,  6 Nov 2024 05:57:37 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE112C80;
	Wed,  6 Nov 2024 05:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730872657; cv=none; b=B09aZbV3xUqcXfalIwR1XHfBHV6RqJLfdxf0moo7ejBqQ/mL5LvxLyBF1MWOpQn3XscIN0dTgaUT4Iid0ENiPQ2ZEQOLV80Q8MhVF5Ng2fB9PjFfTjiqZ+gXpCHj0LEa+q/OYv8P2w2Xfz1/bL0qaqwYEXDfsBIY9zD1G3jm+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730872657; c=relaxed/simple;
	bh=2AM/jbmldN3Uoh7ZxuT26wR2a9hMQJ37FTIwOeMLbUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D+SX8pg0taggS1MfmGOFHWLWCKRkJts2bopScjElsONzrCM0WlM07qTUjZve3efL1kuBoVhr8S+HziK3/FcHzUC1ZKHuPl4yA5P7NJ6vXUs4WQbiZYl28KapE4OO/4AR0fkV3aY6ZLKxh3D8tZyk2q84A42ONSHW3lDis2sibHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3672b054215b-aa97b;
	Wed, 06 Nov 2024 13:57:22 +0800 (CST)
X-RM-TRANSID:2ee3672b054215b-aa97b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee6672b0541a82-20337;
	Wed, 06 Nov 2024 13:57:22 +0800 (CST)
X-RM-TRANSID:2ee6672b0541a82-20337
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] ASoC: amd: acp: Fix potential null pointer dereference of "adata"
Date: Wed,  6 Nov 2024 13:57:20 +0800
Message-Id: <20241106055720.208057-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The condition `!adata` indicates a possible null pointer dereference
for the "adata" parameter. To address this, the access to "adata"
members has been moved after the null check to ensure safer handling.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 sound/soc/amd/acp/acp-platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index 3a7a467b7..2acb08073 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -137,7 +137,7 @@ EXPORT_SYMBOL_NS_GPL(acp_machine_select, SND_SOC_ACP_COMMON);
 static irqreturn_t i2s_irq_handler(int irq, void *data)
 {
 	struct acp_dev_data *adata = data;
-	struct acp_resource *rsrc = adata->rsrc;
+	struct acp_resource *rsrc;
 	struct acp_stream *stream;
 	u16 i2s_flag = 0;
 	u32 ext_intr_stat, ext_intr_stat1;
@@ -145,6 +145,8 @@ static irqreturn_t i2s_irq_handler(int irq, void *data)
 	if (!adata)
 		return IRQ_NONE;
 
+	rsrc = adata->rsrc;
+
 	if (adata->rsrc->no_of_ctrls == 2)
 		ext_intr_stat1 = readl(ACP_EXTERNAL_INTR_STAT(adata, (rsrc->irqp_used - 1)));
 
-- 
2.27.0




