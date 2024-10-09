Return-Path: <linux-kernel+bounces-356376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE43F99602A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F6828132F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69148176AB7;
	Wed,  9 Oct 2024 06:53:56 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9317540849;
	Wed,  9 Oct 2024 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728456836; cv=none; b=oHdCctBQM0ZBdws9B5z70D8YPWHPPAAPQrDrkFDZGKMbrNSmnChQjgdYL7Vx90f1ttMiN9+j9jni2TKXibzC/a0MHTtSvoxeH6BzJmJE/Jz7fGd4a18S0nDLCnhqyP6PpNPbGc6SHPnnEvM11Dz0KyrObSRqABq4kAEHR9cBNBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728456836; c=relaxed/simple;
	bh=IT8NH6qiLYaCsEw9v6HG5yzz/UFovYSGHbPxiFZ8rbU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OFvbA2hxY6NaTLYb0YBOwRMpV+gwbNRcZ5OrlqYp7Btxa/CW/fC/OeLyAmeS3x0dE0LOEkFKCV4dyunN6bHYy/1ozBxzXi24EGItsruXAOnPosbPCqoKnnyt2TU4CKKnLme6G2lBuaRUuhBGjC58VD5/FLA8N0HE4+raUOqclt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86706287db20-25b5d;
	Wed, 09 Oct 2024 14:53:50 +0800 (CST)
X-RM-TRANSID:2ee86706287db20-25b5d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96706287d515-dbf5e;
	Wed, 09 Oct 2024 14:53:50 +0800 (CST)
X-RM-TRANSID:2ee96706287d515-dbf5e
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	zhujun2@cmss.chinamobile.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: ice1712: Remove redundant code in stac9460_dac_vol_put
Date: Tue,  8 Oct 2024 23:53:45 -0700
Message-Id: <20241009065345.6669-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The variable 'ovol' is never referenced in the code, just remove it.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 sound/pci/ice1712/prodigy192.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/pci/ice1712/prodigy192.c b/sound/pci/ice1712/prodigy192.c
index 096ec76f5304..a12dafbf53ab 100644
--- a/sound/pci/ice1712/prodigy192.c
+++ b/sound/pci/ice1712/prodigy192.c
@@ -170,14 +170,9 @@ static int stac9460_dac_vol_put(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 	tmp = stac9460_get(ice, idx);
 	ovol = 0x7f - (tmp & 0x7f);
 	change = (ovol != nvol);
-	if (change) {
-		ovol =  (0x7f - nvol) | (tmp & 0x80);
-		/*
-		dev_dbg(ice->card->dev, "DAC Volume: reg 0x%02x: 0x%02x\n",
-		       idx, ovol);
-		*/
+	if (change)
 		stac9460_put(ice, idx, (0x7f - nvol) | (tmp & 0x80));
-	}
+
 	return change;
 }
 
-- 
2.17.1




