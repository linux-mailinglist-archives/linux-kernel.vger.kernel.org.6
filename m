Return-Path: <linux-kernel+bounces-440062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717239EB82E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674EC282F56
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870FB23ED57;
	Tue, 10 Dec 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CnkOwIZ0"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388BD23ED4B;
	Tue, 10 Dec 2024 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851499; cv=none; b=DhtDP2By+56Ig1TSuCUr8ansY4khCeksiQtAUvzmq6wD3sE4udTp58MthWuCMC1imEy2fFpV6hMyfWCbC94wP6aJyDF9fpOiiRpVgMOWy1bfciYCQTQs5x50AfT2B8nvvtSeOBPN3oNl0AIGlaZy/FhWQm4hsE76P0/MHF5PzDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851499; c=relaxed/simple;
	bh=n0Z7l1Jd4l0M1C2cLK2HeH8LXbnGjaIWPiewPs5BCHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YlL7mb4z3HpCr0D6BnDqlY7dxDXrIdfS8RdebAi/hLds+KkXFwY+O73Zh0eHy6zrIoAh73R3vutb3oXEphTDFA4i8ZCr7mRaTS/m0F2jMaqgxxwqSdf+AJegLuVXslZPvMHtNG6aOSvef5s6Nju8SqGf3ttFGGvwVMht/a9VC6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CnkOwIZ0; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733851493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2v0vkAYCBTmjMlAsGd8RWJgd2gkd+NjGVC+nKnAfYsQ=;
	b=CnkOwIZ0WSeO1sVaVUfcGCmQjtUIBO4uCIuPkGmTriPtV3zJmoEpBKd10qPfnd1/a5R+wh
	4QuLmMzxYWPgKwoVrB4UzIIO0XRJ193EAZIs+D9PiGNAQKxd5u+Rtqv1InxDwnuS61CvTC
	SJ384I/9RNI5UFN1JBizoTnqeAt8+D0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: sonicvibes: Use str_on_off() helper in snd_sonicvibes_proc_read()
Date: Tue, 10 Dec 2024 18:24:26 +0100
Message-ID: <20241210172428.139643-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_on_off() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/pci/sonicvibes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index f91cbf6eeca0..e510715a6c95 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -1135,9 +1135,9 @@ static void snd_sonicvibes_proc_read(struct snd_info_entry *entry,
 		    tmp == 0x00 ? "on-board ROM" :
 		    tmp == 0x01 ? "PCI bus" : "on-board ROM + PCI bus");
 	tmp = sonic->mpu_switch;
-	snd_iprintf(buffer, "Onboard synth    : %s\n", tmp & 0x01 ? "on" : "off");
-	snd_iprintf(buffer, "Ext. Rx to synth : %s\n", tmp & 0x02 ? "on" : "off");
-	snd_iprintf(buffer, "MIDI to ext. Tx  : %s\n", tmp & 0x04 ? "on" : "off");
+	snd_iprintf(buffer, "Onboard synth    : %s\n", str_on_off(tmp & 0x01));
+	snd_iprintf(buffer, "Ext. Rx to synth : %s\n", str_on_off(tmp & 0x02));
+	snd_iprintf(buffer, "MIDI to ext. Tx  : %s\n", str_on_off(tmp & 0x04));
 }
 
 static void snd_sonicvibes_proc_init(struct sonicvibes *sonic)
-- 
2.47.1


