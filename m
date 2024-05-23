Return-Path: <linux-kernel+bounces-186963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F1A8CCB46
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 06:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18461C20E17
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D315579F;
	Thu, 23 May 2024 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTLi7ps6"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0CD282E2
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 04:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716436803; cv=none; b=KX1F9qG4f909Oz154mDYPbtySoXP00w15Yu8LvwgfANS29gHeNmZgzVaeA/CHjIJJpctdyFaEDklork2okt+3hThWAd/EY6LLl4PPJH6s2dlg3+QAUOI1oqTpL/w/nsfMxU7EejJIKdjV+JfuFdMctR3YRhfjL7GGKRjOeifuRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716436803; c=relaxed/simple;
	bh=B2gzviBGjtnYiHgLNjFoKRHvFC2PraWQH9BuIVHuRgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=icsSFneMnHnUD6sSpb4gp9xAAhP8TzUH+7PMl5DlDUJtAPotXiy9Ozz07OYUOohuJKXEMda+xaVC4ZljzEoysnuc9eKQ7qn4EOrMgM1zH8PJhpo3Cw0NvUJI8/MP+VHW4QrwOItAPooxap9tGJWd7cP3xy20XY3ZcTUmdXbidZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTLi7ps6; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-662aeb8d157so1818038a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716436801; x=1717041601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AYayg9Q3I1iT06AmylVzr/L0YJUgQCxPueqQrQfFEGU=;
        b=OTLi7ps6sKll8i193f58TnR8yByynkJS6B/gahpy+dbvs2oX7Zi5W4V9TTl/UHzGLY
         wdXHsFw5y/bge7DsiAWXci453pjjLRRgR3iMAnH26llLG5fW1Q9XCNVTJ1lAIslTlViS
         ps2JTk3HR6zT0dlvgWOkOnKLYOFG6tmKzjRwR1pXzNi2WLamzuQdDQ+6BJ73uBI5HxLh
         6KrOzbvXuVAIKBHsJi9Yzc7xCoGLy2pWnyKBqVIiG+h3MxbzTTQUjXkxpHwgVdadW6Pl
         y8KdQoSFJdevp88BCUdHv8gVYinHUh/r7F536oQREA9DDq/ev/IZDkF91Fel8eJob770
         mowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716436801; x=1717041601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYayg9Q3I1iT06AmylVzr/L0YJUgQCxPueqQrQfFEGU=;
        b=b/qfiRRmqw4S+NmarmqwhN/6MH9D0k6eDk8IL+FMnwOpYZlI+WSjgPJe9bv1I6VkHY
         Inf7CGvLgwI5vZC4Xw+VuLmo8Rf9g8RogD1etQLbmryxPWaf7702PVMPArEVqt6hJV2o
         9jvGOL1xC+/X6IGJzrnqLMf2VjoUQzL1dgQkNtuag8rqOP2AzrtvLB7km6pC7FEiip33
         zXmpQDBj2gAnCbWOl1cAOS/bAa/orZf3UhVYbxrDEdh3tdPKtuuhGZus9p5Pp5kdK3K2
         /KqyNl/0cbSITQR1DL3ezXSw9gx3MIvVk/c3Ga/58mxFunoemZeXRgcEc7H2cL3s/Xfg
         /DFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRBZMlKec+WfQzokuzdhSV9EaIe5FaVTxTPQ3QGITg1MwrgpAEE1ZYSe49LJkWtw3gri6g/DQ48owFmiS1W36bSUA7P1U1uGSrt6I5
X-Gm-Message-State: AOJu0YwfXOb48/MaVdjtCnlYKcIF0aBNk3p2S7W79lXu25DgJp+0cbmi
	FNSC2a/L54oVjULxJFH/Paup8UClOMKnU9VTtby30uHG/4rz2bbUQIo8HrJi
X-Google-Smtp-Source: AGHT+IH6TQ0Tw4CtxyVBxNAKNmaTmFz4jky+RFReIKrb/aCt3QJAjhO29XXhjGVUm4q4gnyIcLAvjw==
X-Received: by 2002:a17:90a:b00a:b0:2bd:83e9:8764 with SMTP id 98e67ed59e1d1-2bd9f455301mr3562356a91.12.1716436801232;
        Wed, 22 May 2024 21:00:01 -0700 (PDT)
Received: from ubuntukernelserver.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9f35303sm573963a91.53.2024.05.22.20.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 21:00:00 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	tdavies@darkphysics.net,
	philipp.g.hortmann@gmail.com,
	garyrookard@fastmail.org
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Fix spelling mistakes in rtllib_softmac.c
Date: Thu, 23 May 2024 09:44:52 +0545
Message-Id: <20240523035952.59724-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codespell reported misspellings of temporarily, possibly, notify and
param on rtllib_softmac.c. This patch fixes the misspellings to increase
code readability and searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 97fdca828da7..0fc97c868f81 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -421,7 +421,7 @@ static void rtllib_softmac_scan_syncro(struct rtllib_device *ieee)
 		 *    So we switch to MAC80211_LINKED_SCANNING to remember
 		 *    that we are still logically linked (not interested in
 		 *    new network events, despite for updating the net list,
-		 *    but we are temporarly 'unlinked' as the driver shall
+		 *    but we are temporarily 'unlinked' as the driver shall
 		 *    not filter RX frames and the channel is changing.
 		 * So the only situation in which are interested is to check
 		 * if the state become LINKED because of the #1 situation
@@ -934,7 +934,7 @@ static void rtllib_associate_abort(struct rtllib_device *ieee)
 
 	ieee->associate_seq++;
 
-	/* don't scan, and avoid to have the RX path possibily
+	/* don't scan, and avoid to have the RX path possibly
 	 * try again to associate. Even do not react to AUTH or
 	 * ASSOC response. Just wait for the retry wq to be scheduled.
 	 * Here we will check if there are good nets to associate
@@ -1359,7 +1359,7 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 		return 0;
 	timeout = ieee->current_network.beacon_interval;
 	ieee->current_network.dtim_data = RTLLIB_DTIM_INVALID;
-	/* there's no need to nofity AP that I find you buffered
+	/* there's no need to notify AP that I find you buffered
 	 * with broadcast packet
 	 */
 	if (dtim & (RTLLIB_DTIM_UCAST & ieee->ps))
@@ -1806,7 +1806,7 @@ void rtllib_softmac_xmit(struct rtllib_txb *txb, struct rtllib_device *ieee)
 
 	spin_lock_irqsave(&ieee->lock, flags);
 
-	/* called with 2nd parm 0, no tx mgmt lock required */
+	/* called with 2nd param 0, no tx mgmt lock required */
 	rtllib_sta_wakeup(ieee, 0);
 
 	/* update the tx status */
-- 
2.34.1


