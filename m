Return-Path: <linux-kernel+bounces-429786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FAC9E244B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E2628798B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4CC1F76AF;
	Tue,  3 Dec 2024 15:46:49 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323A181ADA;
	Tue,  3 Dec 2024 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240809; cv=none; b=b4CLHu2hisc9xIbE3c/dp4vxTTuVZMTVlBF4frXmWIpa03c+hoO1ulLADDQP1z3x3wZy1vGvJw7+TsOKq+Fu9OZ5/Sg3isieoCg9TQCNumcNqBj2DGHCClnj6ckZiIlbBdJuGbZeIUObQKD8q7Dq6m+2sqIoBmq8MuO+UMKQYHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240809; c=relaxed/simple;
	bh=fNJQGCTKbol4fTSpgRRQmJ/M2VyJW5hTHZ3s71zsNy4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fy0f+N0dSIzof6VH9nCbA+YKqSkIMfpI2o/0TdDlAuHTPB0eS6ayxRSBHqsg/L1OoNjvu7e1+29W1O6z5WvITvIdlUr3OroFYtxT85U4fFA+j/dIcIwWl0aVMGGzzglc0SDEjzm2kpKj5EYa7G4OVWWgTzJrTUKBMrbqzIs4t6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7674f27dc2ff-c431e;
	Tue, 03 Dec 2024 23:46:37 +0800 (CST)
X-RM-TRANSID:2ee7674f27dc2ff-c431e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from 192.168.28.197 (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8674f27dc84b-351fb;
	Tue, 03 Dec 2024 23:46:36 +0800 (CST)
X-RM-TRANSID:2ee8674f27dc84b-351fb
From: liujing <liujing@cmss.chinamobile.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] ALSA: asihpi: Delete redundant judgments
Date: Tue,  3 Dec 2024 23:46:35 +0800
Message-Id: <20241203154635.2512-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since HPI6205_TIMEOUT is a constant, time_out is always true,
so unneeded judgments are removed.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
index c7d7eff86727..391cce428a11 100644
--- a/sound/pci/asihpi/hpi6205.c
+++ b/sound/pci/asihpi/hpi6205.c
@@ -2127,22 +2127,20 @@ static u16 message_response_sequence(struct hpi_adapter_obj *pao,
 	time_out = HPI6205_TIMEOUT;
 
 	/* read the result */
-	if (time_out) {
-		if (interface->u.response_buffer.response.size <= phr->size)
-			memcpy(phr, &interface->u.response_buffer,
-				interface->u.response_buffer.response.size);
-		else {
-			HPI_DEBUG_LOG(ERROR,
+	if (interface->u.response_buffer.response.size <= phr->size)
+		memcpy(phr, &interface->u.response_buffer,
+			interface->u.response_buffer.response.size);
+	else {
+		HPI_DEBUG_LOG(ERROR,
 				"response len %d too big for buffer %d\n",
 				interface->u.response_buffer.response.size,
 				phr->size);
-			memcpy(phr, &interface->u.response_buffer,
+		memcpy(phr, &interface->u.response_buffer,
 				sizeof(struct hpi_response_header));
-			phr->error = HPI_ERROR_RESPONSE_BUFFER_TOO_SMALL;
-			phr->specific_error =
-				interface->u.response_buffer.response.size;
-			phr->size = sizeof(struct hpi_response_header);
-		}
+		phr->error = HPI_ERROR_RESPONSE_BUFFER_TOO_SMALL;
+		phr->specific_error =
+			interface->u.response_buffer.response.size;
+		phr->size = sizeof(struct hpi_response_header);
 	}
 	/* set interface back to idle */
 	send_dsp_command(phw, H620_HIF_IDLE);
diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index 7ceaf6a7a77e..cac5fcaef08b 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -1320,12 +1320,12 @@ static int snd_mixart_probe(struct pci_dev *pci,
 			idx = index[dev];
 		else
 			idx = index[dev] + i;
-		snprintf(tmpid, sizeof(tmpid), "%s-%d", id[dev] ? id[dev] : "MIXART", i);
+		snprintf(tmpid, sizeof(tmpid), "%s-%u", id[dev] ? id[dev] : "MIXART", i);
 		err = snd_card_new(&pci->dev, idx, tmpid, THIS_MODULE,
 				   0, &card);
 
 		if (err < 0) {
-			dev_err(&pci->dev, "cannot allocate the card %d\n", i);
+			dev_err(&pci->dev, "cannot allocate the card %u\n", i);
 			snd_mixart_free(mgr);
 			return err;
 		}
@@ -1334,7 +1334,7 @@ static int snd_mixart_probe(struct pci_dev *pci,
 		snprintf(card->shortname, sizeof(card->shortname),
 			 "Digigram miXart [PCM #%d]", i);
 		snprintf(card->longname, sizeof(card->longname),
-			"Digigram miXart at 0x%lx & 0x%lx, irq %i [PCM #%d]",
+			"Digigram miXart at 0x%lx & 0x%lx, irq %i [PCM #%u]",
 			mgr->mem[0].phys, mgr->mem[1].phys, mgr->irq, i);
 
 		err = snd_mixart_create(mgr, card, i);
-- 
2.27.0




