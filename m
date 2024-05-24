Return-Path: <linux-kernel+bounces-188280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3C98CDFFD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C4E1C22007
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A2F381B9;
	Fri, 24 May 2024 03:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8k1u+vj"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388362F50A
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716522959; cv=none; b=LF3AVJj3AzTMtvgs7m6yOH08+VuS/N6zBtcefWriDssqZazES5ESUmvkdT6EbXlPAIS45BxCP9FfOmR+voMKf5ypPoGVo+/GxcBcuRgHMo1Rfihk+zhTUodEeurmn4/Yrfl0JxlU7iAmo3JL/wcdD28AWB8ii0hENp0TYVtgB9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716522959; c=relaxed/simple;
	bh=hz6yD3YpRQ+/vmJO/Jc9hA4ctopEf7XFcndZkYLFllw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=auCZYaLmscwXrOk5JvP3GdkwrbgIGaz36RR2qOV8bjGLuLXeKtWku8LJ3y6udm4yrgf+eTPnbnyzZaPLWYmv/mhpYGosVxNiThqEIUQapVIjTjQZnk8ww3+Q7RWwJuuHPDFawBy6otqgthngFLb6NeH45eyxpXlywxDnFxmUyFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8k1u+vj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f332511457so3580705ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716522957; x=1717127757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3x9vVo+8n8DI9HwirLv4lx4BXroqIOS5ZYSTB5Fjk5s=;
        b=c8k1u+vjjo6aB2ZjdldI7U961vypCfzllL0Nn58GCycFBgQFtzyEuxRs8AGfS4wxZ+
         v4uvXLoVHZ04RZ2toAQmKa6xT9PKgL0So8skT/F67W1co0/OL1vQh9ETt3aqtMgDmslV
         pVr/tHGsHNJHa0VHQR7/z0hjlEykOwkfiE2ijZvx7kQLcnSLm+Zf5/icSLKyirSESWnI
         etSz22q3uEzoni/v7EDO13eiQsN2a29/yglPvLaiRecKCjgOkNPQvoT5uf8fJynuGtcn
         Vm8qku7qhbAwbtCBuOH2CApOYqqTiZ/u/nqI0u7BoCWKus87YQ8Ub+1epi6gylSVtpYY
         3ukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716522957; x=1717127757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3x9vVo+8n8DI9HwirLv4lx4BXroqIOS5ZYSTB5Fjk5s=;
        b=w7z6nBgtMWS5notE3BVY61GmMHpAhRuNjprv4Q/3ik6UL9atf0wI4D+LegG2J7CiOR
         lSFmmiIrj0WfvxNokMh+1AwLjivLlpFQUHDrRMVTG4lqtGkrVcPPRSCCeBxzXhqI/pN7
         taBBmKQMWeWTEXYjGjaR2UckVNB0H/69A4H1cj46X9PQDCurdeoTkqyxNO7w69ga7wXv
         +hOklucoftDPEXvkTLpH8wQrrVhozo89zV6OMitocVcXrBBGuJLf9vj2xPR081FjPEVd
         z2F289F7KQcqiJwRMppy1h+1vxpVC+Yz6x2ifEmuYt7TrZwO+9Pf/s+7k1vkmaQz7ulI
         tnlw==
X-Forwarded-Encrypted: i=1; AJvYcCXeYyCSeS7hh/jFfPKXWAn1guUEeDXVWSwYLsm8Jntv2WFFSc7wMWYT9WRutDI+dTxhFHaYRZYyam+vB8JlSetCB7tj0Rqzf2O4RGvu
X-Gm-Message-State: AOJu0Yw/x028zgHbnF1oIB1slcHoFXnY/dPUd9OFkucRdJmwPD2i/UOT
	/ZdcyYOLBb02atkIniUHck3eAc6hMzxnvjHDni75hP8oh9RiTRbw
X-Google-Smtp-Source: AGHT+IGHa4C3FN7n8+eC7KzOZBlPE2yGNCes1Lr9VjmAe4+0SYxnbQiTgj05W5VxdVyMph6XmY9Tqw==
X-Received: by 2002:a17:902:d2c9:b0:1ee:8fb7:dce1 with SMTP id d9443c01a7336-1f44893d42bmr14924295ad.31.1716522957373;
        Thu, 23 May 2024 20:55:57 -0700 (PDT)
Received: from ubuntukernelserver.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c79d046sm3708015ad.72.2024.05.23.20.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 20:55:56 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	tdavies@darkphysics.net,
	philipp.g.hortmann@gmail.com,
	garyrookard@fastmail.org
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8192e: Fix spelling mistakes in rtllib_softmac.c
Date: Fri, 24 May 2024 09:40:24 +0545
Message-Id: <20240524035525.61072-1-topofeverest8848@gmail.com>
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


