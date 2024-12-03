Return-Path: <linux-kernel+bounces-428784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 874BE9E1367
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D6C161647
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D1B187325;
	Tue,  3 Dec 2024 06:36:05 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA81E178383;
	Tue,  3 Dec 2024 06:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733207764; cv=none; b=RP5V4gviUhKLr4G6QeQAHhFaP4HWuzZW5x361gKJVC5RHfOEexEUMexbZOENig+2/8oIvaR9cWVELoWG5Q2iMrR2mr45eO80rWEREeBBrkLX3VGnAn/HhqdYTXNMLBuiBpkC/LJNcbarGQamuMqjnMS57RryKixsN37DLyol0GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733207764; c=relaxed/simple;
	bh=B1UTk9/BytEAmv+lKwWMk2gv8t9dUj3Ot6I1jPWed3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ssl6CYosE9mBxDGmkHYa35/K0LBc7zg/KvRIA9w6M/qSMDDHdDbMGC7Ii3bg9DdhrChVMpp+KZyhsTBK1sq2OxK1+oxqNleBd3zlYsyXEg9v5HZoI5ZvhsbxNxMKbTFvztjWGgJrSAp3+s1Hr3P5rPpEgoBD9YQlktvmxVJgdA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee6674ea6cacbe-8e58f;
	Tue, 03 Dec 2024 14:35:55 +0800 (CST)
X-RM-TRANSID:2ee6674ea6cacbe-8e58f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee3674ea6ca7bb-1d643;
	Tue, 03 Dec 2024 14:35:55 +0800 (CST)
X-RM-TRANSID:2ee3674ea6ca7bb-1d643
From: liujing <liujing@cmss.chinamobile.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] ALSA: ac97: Modify the incorrect format specifier
Date: Tue,  3 Dec 2024 14:35:53 +0800
Message-Id: <20241203063553.2825-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace %d with %u in snprintf() because it is "unsigned int".

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 25f93e56cfc7..6e710dce5c60 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -1864,7 +1864,7 @@ void snd_ac97_get_name(struct snd_ac97 *ac97, unsigned int id, char *name, int m
 		strcat(name, " ");
 		strcat(name, pid->name);
 		if (pid->mask != 0xffffffff)
-			sprintf(name + strlen(name), " rev %d", id & ~pid->mask);
+			sprintf(name + strlen(name), " rev %u", id & ~pid->mask);
 		if (ac97 && pid->patch) {
 			if ((modem && (pid->flags & AC97_MODEM_PATCH)) ||
 			    (! modem && ! (pid->flags & AC97_MODEM_PATCH)))
-- 
2.27.0




