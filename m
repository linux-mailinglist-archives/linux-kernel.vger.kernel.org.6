Return-Path: <linux-kernel+bounces-400981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0983B9C149F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CA52875CE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBCB5473E;
	Fri,  8 Nov 2024 03:27:13 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4A34962C;
	Fri,  8 Nov 2024 03:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731036433; cv=none; b=LaP7OUJvGrA95VLJEOF+BMg4gqx4hmAyLQtq9moQcB6iQLel2aNPv6bUj8w1IUX1o/2Ebq5kY3/2IEvzi89mnWIpXdHnnH4EZ4hC00mdC842K/NEUGhaEV3qXDLKaojoUWQT67+Z0RHVM/BN+1bG0OVdrEXYkaoUTnjNXKsi1cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731036433; c=relaxed/simple;
	bh=cDiAD11i49EaVXWiTXFqmb6+pxirgdJOujFJfqczyNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jUPrvObymswOcHcY74/pSDYhooy+ZBl6xoXsafPxPi0CjkyK50SKRuh0d+2+Z66LceZxvgjEpdBK36m9nnvkYsTBWP2HjoT6B++g4VeXsJszG7GPnbQAN+JaS8hVhRct8Rt3mIN8QzzfTW20L5GM9TELXgpiMBFrjqtEygFH5kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee6672d8508358-bcc24;
	Fri, 08 Nov 2024 11:27:05 +0800 (CST)
X-RM-TRANSID:2ee6672d8508358-bcc24
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9672d8507b87-84368;
	Fri, 08 Nov 2024 11:27:04 +0800 (CST)
X-RM-TRANSID:2ee9672d8507b87-84368
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] ALSA: ump: remove unnecessary check on blk
Date: Fri,  8 Nov 2024 11:27:02 +0800
Message-Id: <20241108032702.217168-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The unsigned expression 'blk' will never be negative, so remove the
unnecessary check.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 sound/core/ump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/ump.c b/sound/core/ump.c
index cf22a17e3..af763939e 100644
--- a/sound/core/ump.c
+++ b/sound/core/ump.c
@@ -366,7 +366,7 @@ int snd_ump_block_new(struct snd_ump_endpoint *ump, unsigned int blk,
 {
 	struct snd_ump_block *fb, *p;
 
-	if (blk < 0 || blk >= SNDRV_UMP_MAX_BLOCKS)
+	if (blk >= SNDRV_UMP_MAX_BLOCKS)
 		return -EINVAL;
 
 	if (snd_ump_get_block(ump, blk))
-- 
2.27.0




