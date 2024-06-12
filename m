Return-Path: <linux-kernel+bounces-210866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53202904989
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE91B25159
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1449146436;
	Wed, 12 Jun 2024 03:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="geJXBF2E"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9592F374D3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162561; cv=none; b=dszIya24MhjSjwYw4QheW0oJY1sPtuHb0cUoL7GalFycIEeVRxbEDf/MeUpouuI13RHGn9kVIdWCQBHx+vpKyS4iX/2W8jvg8VJD2j3h6Pnew5cxH7cXFUcMw39IJ4FxKtgZZBQOTkSCy7zewYZgl6Vzqd6UETnzowxJ6S6xQQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162561; c=relaxed/simple;
	bh=GxUQdypfFx8mKG5Keo9Q+CYF+U0ENbg51vKbh73Q4yE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nO/IonAWoh554Q5WzTAgBbqENbeJAnbgi7PYe/umBMoHVXlE4LZrNtFaM1YHk9Ja3/KBoqaYdEVAtp8X59No6mhuLokcbfMYvXXQAHSs+EAME2LaFYWSdPXuFvpmn3LEHGJ9rnLLye9ch6MxmNU/f7nJtou7Kdr8p5b+UWfCg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=geJXBF2E; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7025f4f4572so371525b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162559; x=1718767359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tu1YovfLQEAsBdhGanL9XJ+Gga/xI5TxCjPr1vPzUmU=;
        b=geJXBF2EvhSs1QAkvDyN8YAWHFJm6DfVO+Hrqu6lVNE+3agPo8bamY4+tnXz2LsBsP
         w+7FmjiZrcLBFSeEA2Nrh1E1F83oIpwO2IQn7ho5F+ERhAF1yq0iQX2Vtv2FvkOrW3WD
         KpsSLctq7NCPcrXhkJXnlrS38Oljnn8sl8QCmiSFbCnbon7eiz4cSKqe+OBS41j8Bupv
         Ms+VPU9dKi5P0pLa+VZs7wV3EoAKDduA1u3bzU33hlKjr820w7G6Oz9FRbXuG5pk62Rh
         4cZ2l7VH0y9rgWjOUnjdSOcx2BSgakCopSyJE/8JeYrSt0R/ccVAfJR930A8I6KwLi7w
         sjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162559; x=1718767359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tu1YovfLQEAsBdhGanL9XJ+Gga/xI5TxCjPr1vPzUmU=;
        b=JgLnlRf7grc4Cse6P5rv/EaHfSTnTZ2iPw52kY7Ui9qYMQBi1wsJmHhjcwoI13rSay
         2G0YzHZZA61LecHICS2GiHBmmCKx3CqbGOGEF8GKFBtnpLPHv1qcu3VdpH6pDcUlhUGM
         svPyGIeVcyTLU7SOu7HP4PbRw7gca/17wlZ6xHsc0TpD5JMB5VI2gpPY8VV6dgYA+9fB
         xZRJ7Uza9UeVxslTula0xYPpk9TWjNHDPP9PSWRFEXiTdymWwJqSAc21qWcad5cXf6Tl
         bFWTJfyiZr3Of+GPA/oKuqfT4jhSryMlsJHi+8nZYiwaE1dLplk1ZBMttQvoqrV8kuDx
         obwg==
X-Forwarded-Encrypted: i=1; AJvYcCUOFXrxFp4rWvZJ8+dRegX/r5Ceq+ddadoFBJLkg3luMALoMpxV4Xf6zAOpI+k6yicET+MKx1jAsfB7uRBDRvteWIRSZaQb+NzdYYRk
X-Gm-Message-State: AOJu0Yz9ZWPhuy5oRjpxFv7kCFCyxFTCx9h38EvV60Z2s0g8FGpxN3MW
	mxZ17KKSvUF1bXoz0DAvu8vfValiloPhNCBe/5nVCdh/U1jrU7HXye+sIovQx7E=
X-Google-Smtp-Source: AGHT+IGbK31oLFywfNaLnSP9D1b26MHKW4EJL/Us0ks3qOwNu0Lp2kbhXjyFeoVfuTZbSyY/tnEc4w==
X-Received: by 2002:a05:6a20:96cf:b0:1b5:88f5:5823 with SMTP id adf61e73a8af0-1b86d376213mr5016905637.27.1718162558807;
        Tue, 11 Jun 2024 20:22:38 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:38 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 07/24] Staging: rtl8192e: Rename variable bCTSEnable
Date: Tue, 11 Jun 2024 20:22:13 -0700
Message-Id: <20240612032230.9738-8-tdavies@darkphysics.net>
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

Rename variable bCTSEnable to cts_enable
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No Change
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  2 +-
 drivers/staging/rtl8192e/rtllib.h              |  2 +-
 drivers/staging/rtl8192e/rtllib_tx.c           | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 0263f3d7179c..4117530f19b1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -893,7 +893,7 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 	}
 
 	pTxFwInfo->RtsEnable =	(cb_desc->rts_enable) ? 1 : 0;
-	pTxFwInfo->CtsEnable = (cb_desc->bCTSEnable) ? 1 : 0;
+	pTxFwInfo->CtsEnable = (cb_desc->cts_enable) ? 1 : 0;
 	pTxFwInfo->RtsSTBC = (cb_desc->bRTSSTBC) ? 1 : 0;
 	pTxFwInfo->RtsHT = (cb_desc->rts_rate & 0x80) ? 1 : 0;
 	pTxFwInfo->RtsRate = _rtl92e_rate_mgn_to_hw(cb_desc->rts_rate);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0131765e451e..2282c709654d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -110,7 +110,7 @@ struct cb_desc {
 	u8 nStuckCount;
 
 	/* Tx Firmware Related flags (10-11)*/
-	u8 bCTSEnable:1;
+	u8 cts_enable:1;
 	u8 rts_enable:1;
 	u8 bUseShortGI:1;
 	u8 bUseShortPreamble:1;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 8c9072538688..c0fe00d0df02 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -374,7 +374,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 
 	tcb_desc->bRTSSTBC			= false;
 	tcb_desc->bRTSUseShortGI		= false;
-	tcb_desc->bCTSEnable			= false;
+	tcb_desc->cts_enable			= false;
 	tcb_desc->RTSSC				= 0;
 	tcb_desc->rts_bw			= false;
 
@@ -390,7 +390,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 			tcb_desc->rts_rate = MGN_24M;
 		} else if (ieee->current_network.buseprotection) {
 			tcb_desc->rts_enable = true;
-			tcb_desc->bCTSEnable = true;
+			tcb_desc->cts_enable = true;
 			tcb_desc->rts_rate = MGN_24M;
 		}
 		return;
@@ -400,7 +400,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 
 	while (true) {
 		if (ht_info->iot_action & HT_IOT_ACT_FORCED_CTS2SELF) {
-			tcb_desc->bCTSEnable	= true;
+			tcb_desc->cts_enable	= true;
 			tcb_desc->rts_rate  =	MGN_24M;
 			tcb_desc->rts_enable = true;
 			break;
@@ -412,7 +412,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 		}
 		if (ieee->current_network.buseprotection) {
 			tcb_desc->rts_enable = true;
-			tcb_desc->bCTSEnable = true;
+			tcb_desc->cts_enable = true;
 			tcb_desc->rts_rate = MGN_24M;
 			break;
 		}
@@ -444,7 +444,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 	return;
 NO_PROTECTION:
 	tcb_desc->rts_enable	= false;
-	tcb_desc->bCTSEnable	= false;
+	tcb_desc->cts_enable	= false;
 	tcb_desc->rts_rate	= 0;
 	tcb_desc->RTSSC		= 0;
 	tcb_desc->rts_bw	= false;
-- 
2.30.2


