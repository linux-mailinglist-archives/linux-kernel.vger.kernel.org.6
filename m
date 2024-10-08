Return-Path: <linux-kernel+bounces-354415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC846993D35
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EFE284D0B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37A029CFB;
	Tue,  8 Oct 2024 03:02:42 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919E23FC7;
	Tue,  8 Oct 2024 03:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728356562; cv=none; b=Gy8DsSq49UXwPBBVnWU3u+gvpRDxgn+KIgoLEhao7anJq+/jj1Taw4ngpAktPcH0lqvCrcmwg3U2mk5ujzCr/3hAkKDpmLTmsmt4jsD3JqsQBufARjHkDtB1phpN3p033W7Uh4ygLxuDQSfhhNboQFW13CzBfV7HrrmyRy3bXt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728356562; c=relaxed/simple;
	bh=EIblVUPShlUFmQ/WUe97ldk8Qs/Ts9lujgAx4hFJObo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ra3iVMo2BNV3fVllC2XlAZdi4GkjZxW55B19FBbU8qScIihRKdF8rK9XcaC9mynoveRyS679VhDGfGs3xxb+XmZwzAoHlCCM7gEBt+aob6y2yltURwCupt+1KYCt/8BIdyrjFSWaFUUSjykMS5jtQ6l2qUnnSStWdtrxhwSVG68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76704a00e407-df40f;
	Tue, 08 Oct 2024 10:59:27 +0800 (CST)
X-RM-TRANSID:2ee76704a00e407-df40f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66704a00dda2-8b9c4;
	Tue, 08 Oct 2024 10:59:27 +0800 (CST)
X-RM-TRANSID:2ee66704a00dda2-8b9c4
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	wangweidong.a@awinic.com,
	andriy.shevchenko@linux.intel.com,
	heiko@sntech.de,
	kuninori.morimoto.gx@renesas.com,
	nathan@kernel.org,
	u.kleine-koenig@baylibre.com,
	zhujun2@cmss.chinamobile.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	broonie@kernel.org,
	lgirdwood@gmail.com
Subject: [PATCH] sound:aw88399:Correct error handling in aw_dev_get_dsp_status function
Date: Mon,  7 Oct 2024 19:59:23 -0700
Message-Id: <20241008025923.10606-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Added proper error handling for register value check that
return -EPERM when register value does not meet expected condition

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
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




