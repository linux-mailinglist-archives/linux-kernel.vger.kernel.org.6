Return-Path: <linux-kernel+bounces-434245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6919E63DD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8894F18849F2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B76614A635;
	Fri,  6 Dec 2024 02:09:06 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102F013BAC6;
	Fri,  6 Dec 2024 02:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450945; cv=none; b=Qj9hdnOz9h7LYYoIi3d32I78N0qGnrCOvTrggg4ysMYrFowhfSaSEUFvzePWLtndCRtudf/Z3K2z6aoXMiL3OLF7BHg/mRRIZ5wlJukJLE5fIPh0ECE/L3AYb0F5mNm6DFO8A4Ri6OAMRBo/uSGgYlz3yc6PJfAPpkRbZLCVXVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450945; c=relaxed/simple;
	bh=T9bvb8qLNK/C2a8Bs4tsTcdJbzec+FlhKYgOmzv8k04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gA5UenDIJ9F5x6+22mKG06RFjKqH0qBqt7CLP5u+LueczVIpKx7M57I+IuRR5gwkTgO1CaP/aEssGbvvStLy+jIQVFKVa2htDRc6rISgp5czmRwLp83bY4zf8e990+72LBXVAcQuex+JkIQc/egKODeQKJFEN1uzxViIethaDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee367525bfc80a-a9034;
	Fri, 06 Dec 2024 10:05:50 +0800 (CST)
X-RM-TRANSID:2ee367525bfc80a-a9034
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee367525bfdb1c-cd085;
	Fri, 06 Dec 2024 10:05:50 +0800 (CST)
X-RM-TRANSID:2ee367525bfdb1c-cd085
From: liujing <liujing@cmss.chinamobile.com>
To: perex@perex.cz,
	tiwai@suse.com,
	ghanshyam1898@gmail.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] ALSA: au88x0: Modify the incorrect format specifier
Date: Fri,  6 Dec 2024 10:05:43 +0800
Message-Id: <20241206020543.2153-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make a minor change to eliminate a static checker warning. The type
of chip->irq is unsigned int, so the correct format specifier should be
%u instead of %i.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
index 62b10b0e07b1..e3b1d7116110 100644
--- a/sound/pci/au88x0/au88x0.c
+++ b/sound/pci/au88x0/au88x0.c
@@ -223,7 +223,7 @@ __snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 	// Card details needed in snd_vortex_midi
 	strcpy(card->driver, CARD_NAME_SHORT);
 	sprintf(card->shortname, "Aureal Vortex %s", CARD_NAME_SHORT);
-	sprintf(card->longname, "%s at 0x%lx irq %i",
+	sprintf(card->longname, "%s at 0x%lx irq %u",
 		card->shortname, chip->io, chip->irq);
 
 	// (4) Alloc components.
-- 
2.27.0




