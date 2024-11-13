Return-Path: <linux-kernel+bounces-406977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEC89C66FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D5F1F24566
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB027080E;
	Wed, 13 Nov 2024 01:58:06 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB14481C4;
	Wed, 13 Nov 2024 01:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463086; cv=none; b=KrLJHzqi6Z+LZk2xzi538+irhBegP1/LjNxFA/Y6ZHr7nTEuP0oIyCG8Fky16QqoskXXiEVHVH7zGR2SQZW+TYsm9uOiSqF9blkhWLDECdKWBsqrsJAqL0J/LAEx8hcb5tmEpRvxTqYajGv/UY1mPABz66dADfzGNabbf9Ue+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463086; c=relaxed/simple;
	bh=Sb/hii9sYzUkbrxUho4NcJczD6dyngF5OH681nF1keg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Eyv2gl0eoag4RoZ9V9shHAXcvAjqrJWtieVpVdcfXvBIKkihhrn837cvQ8i/0Jdt7FN/u8F5LKg2lb6W038iwtVhKlBJxqPguCcB1g3DfOXCeHjrlnNq8qwYArMQgcRZWoI63+IVBwMzZC+cr2RcMc8XPkdmJ6JTeCgMY9Onivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee1673407a8673-e3f88;
	Wed, 13 Nov 2024 09:58:00 +0800 (CST)
X-RM-TRANSID:2ee1673407a8673-e3f88
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1673407a7260-71818;
	Wed, 13 Nov 2024 09:58:00 +0800 (CST)
X-RM-TRANSID:2ee1673407a7260-71818
From: liujing <liujing@cmss.chinamobile.com>
To: povik+lin@cutebit.org
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	asahi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] ASoC: apple: Fix the wrong format specifier
Date: Wed, 13 Nov 2024 09:57:58 +0800
Message-Id: <20241113015758.5441-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the mca_fe_hw_params(), the variable tdm_slot_width is of
type unsigned int, so the output should be %u

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
index c9e7d40c47cc..b4f4696809dd 100644
--- a/sound/soc/apple/mca.c
+++ b/sound/soc/apple/mca.c
@@ -616,7 +616,7 @@ static int mca_fe_hw_params(struct snd_pcm_substream *substream,
 			tdm_slot_width = 32;
 
 		if (tdm_slot_width < params_width(params)) {
-			dev_err(dev, "TDM slots too narrow (tdm=%d params=%d)\n",
+			dev_err(dev, "TDM slots too narrow (tdm=%u params=%d)\n",
 				tdm_slot_width, params_width(params));
 			return -EINVAL;
 		}
-- 
2.27.0




