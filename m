Return-Path: <linux-kernel+bounces-188304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514518CE04F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 06:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E556A1F213F1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B1C381D1;
	Fri, 24 May 2024 04:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enL2Vu30"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C1117C7C
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 04:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716523986; cv=none; b=NXp4oQs/cd4QvAyxpbJoa2xqdvWtHSmt3hcDfTXnjKsibnf2ScQi15wpr1mnzVwOERg759PmpisRS7nOqXuA1AX66SAYm5lKYZbqYEb5jB6jFyKvf/GedsM8gCWTw83x+4h363F2cZHCYhGp59EY5rz/F5+m7orc4Jn1rVnt+zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716523986; c=relaxed/simple;
	bh=53mu7GskWyswzq0Kb3LOlSpj/CqOCHQ55Wc/IXh0bBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kL+8tEwnPqr1S783X3IGe0+vDP90s3GPa5K+N8C9ZRl5UqrzV1wW20+yMzcOsBMpqEHx0E/7lxbCWRMHK56Axh9dkae8Nuly851O2sbt6hiFaOlIeAUaj57caQCFKdT/YFMraNEeO42wTnx9L6EIMg8T4vRQtfwv7rblQpSn5Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enL2Vu30; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f69422c090so3632136b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716523984; x=1717128784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0R2/6bH5nk9ey66bu5PVH9neSHOwxY1qpJG51e+k3+g=;
        b=enL2Vu302mTseomGiLagLfS1OIhl2sCT6fRVM9HHUCoGp2NZaCyZKaQqjnx3AxPSPu
         eNcpIS36LGHQPwMTeFFcLDVQnk5PCGR8BLeiRgOX0HnxGozJZ5lCzYr8eH3XQLZsmeHN
         ufYS8ePa84/Gklc63YjPhe/5ks7yGVYiJRAIsVRLP8Gx80wBKjUalY4Sp72U0SX99JD3
         k6Uu1pIksNlcwbAHjP3TElOMYGM/mlNr2oN3wyZ3XghjcC/i80z6z8WGTEH0z5PtiB44
         +qkanVcTIOy+Kpl7laZSNsvSlZelbkrszaOO5SW3yE0uNG11o1gaoEa1LOzAqzBplA0s
         O6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716523984; x=1717128784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0R2/6bH5nk9ey66bu5PVH9neSHOwxY1qpJG51e+k3+g=;
        b=TaIyk239i/wTiE9bwNyQ3rdnekRNN8Aj10/ao+9Dy9wDide7jNp0BC++3g+APo5OnL
         v4/2LuCOH94JBCYc31oCOiiALxOyXqdTYWLDwdWFgoVmdZpt3ZFVtcLOj2XdhQcHaT+w
         FeaeRt3ckBqpHy2HzofQFP6sKqzBRhuFQFAAXcxPaj5KY0Aye5QDJtiAJmcR0iuBBzNi
         8dkflIbcwpUm1ueaZkNsONKBzQNg4tRXnaii1MRgSyJ6sDbJ7qzXsX4PCfeEWEKxl4A4
         Tj9PZUIwAT0Qs9lHz7qSimRCAgJ1L1bpMhs4ZsoR7rO0/KylxbfbQwXMBZOVoJag29Y7
         igHw==
X-Forwarded-Encrypted: i=1; AJvYcCUMuW3SN4HMZ7Rm2Owkut+1VHpBV5nw3qMOLq7+OyR5k9vPjtOItHvXwW0Qk4XqR+hbuxTBBvstG/W+r7IzUM6aaQcNq8U1Ct3msZQg
X-Gm-Message-State: AOJu0YyjYlhlq/QxlTKpFl7vji+TTi7ArbzwQ5Ur3sWwrOMpKlxi0NWk
	vtissNMBvhdzwd0SJ4f5COM/7bF9e1FwQUpaLmjwYOAFiKXmoQKt
X-Google-Smtp-Source: AGHT+IEJqkWJXe3XaeNyx5KpqAXQnWNZWzL4yOtZJduvM9zfdNfyWSrNd46LXkj6ZdsUXSWSec2bzw==
X-Received: by 2002:a05:6a20:c706:b0:1af:f640:13fd with SMTP id adf61e73a8af0-1b212e73158mr1431489637.62.1716523984205;
        Thu, 23 May 2024 21:13:04 -0700 (PDT)
Received: from ubuntukernelserver.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbe3487asm353555b3a.40.2024.05.23.21.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 21:13:03 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	tdavies@darkphysics.net,
	philipp.g.hortmann@gmail.com,
	garyrookard@fastmail.org
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: rtl8192e: Fix spelling mistakes in rtllib_softmac.c
Date: Fri, 24 May 2024 09:57:35 +0545
Message-Id: <20240524041235.61184-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch corrects some misspellings to increase code readability and
searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
v3: 
 - Added the missing patch history on v2 patch
v2:
 - Updated the patch description as suggested by Phillips
 - https://lore.kernel.org/all/1aefa708-b1fe-4246-bb67-36f25919c766@gmail.com/
v1: https://lore.kernel.org/all/20240523035952.59724-1-topofeverest8848@gmail.com/

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


