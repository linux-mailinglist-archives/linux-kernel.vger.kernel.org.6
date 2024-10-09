Return-Path: <linux-kernel+bounces-356726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 022AF9965BE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C8B283945
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D5318BBB9;
	Wed,  9 Oct 2024 09:43:23 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A07189528;
	Wed,  9 Oct 2024 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467003; cv=none; b=FR4phiP+VTBXrkY410SDg+sGx+yGPgydQ/jv7I6a2fYS/jc7HvGPGboREcC6Zv9kYEGAJ4Ley+/RKpL1s+CI3m24rEVDVylI+aG5F32Dd/3f0HQ34vww+7Qn+SPhE0ijSW8Rd/WNdhlfY6dgyWBS8sg0zYcpoAf7Wlhrd5gyqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467003; c=relaxed/simple;
	bh=ZMe3jcm3jxvbtWEEvZCYgXS99N2gCSiit+fHXIdZ4KM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=leV63Grd60Rfe2i25WL1CFfj2iuVbpe8hVotJE1bSK6DTvJg8bAYDj8UtZtQGBMVcQHRbsSsc1W/Qxc56gfaIrMWq3msyAPqVwy0wZhE6dryCiuX/zHOPc1Pj13ThHloRHAI554Gmz+h3vRvwubPOJ6wWbaY7Z0qDLDBSwJi89g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4670650334aa-bdda8;
	Wed, 09 Oct 2024 17:43:18 +0800 (CST)
X-RM-TRANSID:2ee4670650334aa-bdda8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26706503301f-ef255;
	Wed, 09 Oct 2024 17:43:18 +0800 (CST)
X-RM-TRANSID:2ee26706503301f-ef255
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: tiwai@suse.com
Cc: wangweidong.a@awinic.com,
	perex@perex.cz,
	andriy.shevchenko@linux.intel.com,
	heiko@sntech.de,
	nathan@kernel.org,
	u.kleine-koenig@baylibre.com,
	zhujun2@cmss.chinamobile.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: codecs: Fix error handling in aw_dev_get_dsp_status()
Date: Wed,  9 Oct 2024 02:43:13 -0700
Message-Id: <20241009094313.8820-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Changed the error handling in aw_dev_get_dsp_status to return -EPERM directly
instead of setting it to a variable.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
V1 -> V2:
- add a dot after the commit
- modify commit info

 sound/soc/codecs/aw88399.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/aw88399.c b/sound/soc/codecs/aw88399.c
index 8dc2b8aa6832..bba59885242d 100644
--- a/sound/soc/codecs/aw88399.c
+++ b/sound/soc/codecs/aw88399.c
@@ -656,7 +656,7 @@ static int aw_dev_get_dsp_status(struct aw_device *aw_dev)
 	if (ret)
 		return ret;
 	if (!(reg_val & (~AW88399_WDT_CNT_MASK)))
-		ret = -EPERM;
+		return -EPERM;
 
 	return 0;
 }
-- 
2.17.1




