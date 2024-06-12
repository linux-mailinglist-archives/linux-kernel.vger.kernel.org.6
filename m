Return-Path: <linux-kernel+bounces-210864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B35904987
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F331F24601
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E013D0D9;
	Wed, 12 Jun 2024 03:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="URPjdJ8z"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C24282F1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162559; cv=none; b=NFr30vQ2WhAt/CLOPH9yT3vt56B9uT8Li6+coehyow0nbSgjggKz+bfnKGQ6CMP3OW8TD9AhjIn/Zmc3gyVYcU3xH+B6xlIbwNDHr0HA1oltSYESFpUFfrFKYvzTHpGCfJ3uX6Bf/rHZ5969rSZppWHCAsKIBglvvFWED+EETBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162559; c=relaxed/simple;
	bh=54IIdVY7ciiHv8FfEFOv/C1olmIKHuzoK3dEis8XOpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C+PSu6ODb+uqr4HvJi/mAKLnprEnnF3vql4jYwKU7VhzZVxpj+EPe5x9V0fsaeMFTM7OwT0HIEfOzaUAMIgoz4l23QF+dr+0jGvszPUjvzlG3ubHOGII/RNa66RtTj7NE0h9V0jSTxRSOLR/vMQHH7cR+T9i8MfYQn4YuSTrlqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=URPjdJ8z; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d23a0a32afso538335b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162557; x=1718767357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRdNCIuE1fAcIlopHPfrxao68P6nIKXQy67ti/GMEzk=;
        b=URPjdJ8z55rhXqQ4HBYFqNi7FycuPQmaolVCZtbp9o0vNEUsRvO/VRjFSi5i6YAowW
         /CVGR83R66GCzcydTYhyQukYbcgc251A7hG3BiSkDbKSp5cv9pVDXUk3sQ2Mx0cDGM99
         MCLxY3fe6GE+TdzwxkN3sR75MyKurUpOzm+i3bfPtpIsawGUzZ9QPfQUfOeTVUX+M8uH
         2LKU42mf0C6EDQgqGEDJkQnIewp+CJSSp/JQ2aAV65EZgx6ZJoNivsrPekHetoQrH+fE
         85WJ0GtwwMa2yGAmsRwgzEdap/2sCoSumR9/axGJ0wo9JVqi0H1OzgEAmD7iexd6+4Da
         w7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162557; x=1718767357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRdNCIuE1fAcIlopHPfrxao68P6nIKXQy67ti/GMEzk=;
        b=RBH6WiBtl/fxKEMpnt6HYAiaorHECxY6FueIjSNopJV2BZoSrBgaJzlsoDE2cn+6Gp
         gQUj4UzM5VB4juiXnNRXN+w73J2se5F9XELauG4EPz1cQPENGnGwmwHzDWtYAj8msDI+
         RwdWZsYlkM625Syi5Mls0DunuZI8kruiZlsyOAR9T6qBek4qG6bzqxWX+FKWKJMnSUGS
         +sSK/ZhckDM2VihkKDxayq2mShHIFu8f3BQNQFd5wKeqb47ItPcfu8PuvUtE8pfYrImP
         zK6NWuUgzeRQ6Rbh27WcS+0QoxDVCdubbM4qxZTlmNIZwRvQ7HTG1vCo9whQhacocKn3
         cPog==
X-Forwarded-Encrypted: i=1; AJvYcCUZ+4rk9bi7KjTv9JLNntROllt9ydsiH75RzRzB/nR0MDWbFkayHV7IfFGjAuicsYApOkviUeDmrrL7ypY5RmtM758qoYF5cJV5s+58
X-Gm-Message-State: AOJu0YzpV0vHIouOytVMeOT/r13nxOV8Y0Qpj7cXc4oPUwgVqszZRmNV
	I/t5lLeZhT/I0EzNlwcarwzupCDgegc7Le57H3s/9bEeI8QWc2kWmKsSN3thREU=
X-Google-Smtp-Source: AGHT+IEgTVRl9RJkhDsO1gIVutg9vxMpQtIebArdKX/AqnlOo+SeVCMLu/htOQ4dRUClFgXHGNiqHQ==
X-Received: by 2002:a05:6808:1789:b0:3d2:25c6:c521 with SMTP id 5614622812f47-3d23e0ce2c9mr775622b6e.51.1718162557225;
        Tue, 11 Jun 2024 20:22:37 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:36 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 05/24] Staging: rtl8192e: Rename variable bRTSEnable
Date: Tue, 11 Jun 2024 20:22:11 -0700
Message-Id: <20240612032230.9738-6-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240612032230.9738-1-tdavies@darkphysics.net>
References: <20240612032230.9738-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bRTSEnable to rts_enable
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No Change
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  2 +-
 drivers/staging/rtl8192e/rtllib.h              |  2 +-
 drivers/staging/rtl8192e/rtllib_tx.c           | 18 +++++++++---------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 27dfa268cd68..0263f3d7179c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -892,7 +892,7 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 		pTxFwInfo->RxAMD = 0;
 	}
 
-	pTxFwInfo->RtsEnable =	(cb_desc->bRTSEnable) ? 1 : 0;
+	pTxFwInfo->RtsEnable =	(cb_desc->rts_enable) ? 1 : 0;
 	pTxFwInfo->CtsEnable = (cb_desc->bCTSEnable) ? 1 : 0;
 	pTxFwInfo->RtsSTBC = (cb_desc->bRTSSTBC) ? 1 : 0;
 	pTxFwInfo->RtsHT = (cb_desc->rts_rate & 0x80) ? 1 : 0;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 6dc641f78202..a305848dabd5 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -111,7 +111,7 @@ struct cb_desc {
 
 	/* Tx Firmware Related flags (10-11)*/
 	u8 bCTSEnable:1;
-	u8 bRTSEnable:1;
+	u8 rts_enable:1;
 	u8 bUseShortGI:1;
 	u8 bUseShortPreamble:1;
 	u8 tx_enable_fw_calc_dur:1;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 83082a990fbd..be8de6703e5d 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -386,10 +386,10 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 
 	if (ieee->mode < WIRELESS_MODE_N_24G) {
 		if (skb->len > ieee->rts) {
-			tcb_desc->bRTSEnable = true;
+			tcb_desc->rts_enable = true;
 			tcb_desc->rts_rate = MGN_24M;
 		} else if (ieee->current_network.buseprotection) {
-			tcb_desc->bRTSEnable = true;
+			tcb_desc->rts_enable = true;
 			tcb_desc->bCTSEnable = true;
 			tcb_desc->rts_rate = MGN_24M;
 		}
@@ -402,16 +402,16 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 		if (ht_info->iot_action & HT_IOT_ACT_FORCED_CTS2SELF) {
 			tcb_desc->bCTSEnable	= true;
 			tcb_desc->rts_rate  =	MGN_24M;
-			tcb_desc->bRTSEnable = true;
+			tcb_desc->rts_enable = true;
 			break;
 		} else if (ht_info->iot_action & (HT_IOT_ACT_FORCED_RTS |
 			   HT_IOT_ACT_PURE_N_MODE)) {
-			tcb_desc->bRTSEnable = true;
+			tcb_desc->rts_enable = true;
 			tcb_desc->rts_rate  =	MGN_24M;
 			break;
 		}
 		if (ieee->current_network.buseprotection) {
-			tcb_desc->bRTSEnable = true;
+			tcb_desc->rts_enable = true;
 			tcb_desc->bCTSEnable = true;
 			tcb_desc->rts_rate = MGN_24M;
 			break;
@@ -423,18 +423,18 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 						      ht_op_mode == 3)) ||
 			     (!ht_info->cur_bw_40mhz && ht_op_mode == 3)) {
 				tcb_desc->rts_rate = MGN_24M;
-				tcb_desc->bRTSEnable = true;
+				tcb_desc->rts_enable = true;
 				break;
 			}
 		}
 		if (skb->len > ieee->rts) {
 			tcb_desc->rts_rate = MGN_24M;
-			tcb_desc->bRTSEnable = true;
+			tcb_desc->rts_enable = true;
 			break;
 		}
 		if (tcb_desc->ampdu_enable) {
 			tcb_desc->rts_rate = MGN_24M;
-			tcb_desc->bRTSEnable = false;
+			tcb_desc->rts_enable = false;
 			break;
 		}
 		goto NO_PROTECTION;
@@ -443,7 +443,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 		tcb_desc->bUseShortPreamble = true;
 	return;
 NO_PROTECTION:
-	tcb_desc->bRTSEnable	= false;
+	tcb_desc->rts_enable	= false;
 	tcb_desc->bCTSEnable	= false;
 	tcb_desc->rts_rate	= 0;
 	tcb_desc->RTSSC		= 0;
-- 
2.30.2


