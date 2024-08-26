Return-Path: <linux-kernel+bounces-300613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D045B95E604
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 02:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3E91F21270
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3CA2F50;
	Mon, 26 Aug 2024 00:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="LR5TN0Ki"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7D4944E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 00:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724631455; cv=none; b=UI2bJmAlPevXCVtz/+ut7eu9DSg5e3OGwVR9f4804RPjnwtXr91eBExIXDut/zLOFISGxvRMriz9jrreIAuXkDXfInEAwCUV+iZRSS23pLMbrGygvhwPUjZBc8rPpm9szYO2pDTIc9dIvkiLOJXUyCifUGr+F18gm2Thzhf5d4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724631455; c=relaxed/simple;
	bh=FZq3TlinAw0NAQgAOiZ6+WmbqrxTTJjlM77u29/HlLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u3gUrI5rfZEP9ioNjO4jWJun/w5CsQ7s4xeixpw6eKEK6xAgEGwQOvt1A+mEhFsidwK3rAKWgIKGZlOOM+WHD33j5Or3ciYwCHLO1q0BcFO0+72DvCAn2AGmLRe0Kn66s7JU8wClO1VC8xx4iDZ2ck2olJTPWv1jUlykcyhO8kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=LR5TN0Ki; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-202146e9538so32351715ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 17:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1724631453; x=1725236253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fp3ZaYZ2bdEs+KuBwodCSVcCtgG051WR1MOG9KDjm3w=;
        b=LR5TN0KinSbnfDet0P2QRx3qIl3N8zEWXEiHt9gjrzjvySX6Xqgz0Q1TWofRbHh0as
         bsfkGB8PTuWHY1TzBpBjdB/s83S5C8y2nsd6hiI5cELKnzRfZgA2fhVonwzFj66puYhE
         PMsBw6uE5+2qtYVx9AyFN/LL9YjcloNI/C7toCEkCeaCXkBLnqmAW2aCqC536Srh9B4v
         Gbm/peTvYKeOsymptOruPGtpx8dvxNW/EDRw70CWUh/Hi+hebK7q01dRThLIEFMARIxt
         gYRZR5Bq31bn71xGHsylxh8Ax64SEUZpA4Va99gudQAIqA6DB7OKLp4E4Tu8/o/1D3X7
         olzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724631453; x=1725236253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fp3ZaYZ2bdEs+KuBwodCSVcCtgG051WR1MOG9KDjm3w=;
        b=TDs3o42PnBB01WJP/8TdY3EU+a7aJeB07BW2MnUob2N9QBTuCN8aDg6IoGgLmk5qzN
         Mj/D+dqMrNE93X5oh+zH8KakgdmbbXsM4qwg0kvw0fRpR+j9BaH/VXIajG9rweapjfsY
         eQ5kaRH0jl+B2mYCcROkcV5jiXd+5Syh4SenRNrzJQWiAlhObzh7WPZK6aCV3B4vB+0w
         j7scU6UpKHXAhMZ8yw9D8iJSR/yFU4Dqqf4//FDznPz4a0HsC+hjwH/fGuFNjqw5xeva
         WDZCyYqTrEOIVYjj27ghkRSeuAfFWEC+4ma3Osn5rYwrBXLdNuXFoX694r/wtvPsSTqn
         vtmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdsaRhwNONUjMXnUycg+vBagYSLxLPUpD+9qPLZPTXxSmCAwEJulZm+DxOjHJSz8h8SdEP9EghTg2nrLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgPi5NqjcM6mf1FE4Go1Nowe8uUnfvYEbvymZI5/ysf1AvjytS
	Zb47rupkpPmthJcHfV0gbUcLE1C5sHlnEWk1f6JAKSQIJSMLD+2vaO1WMz6uBos=
X-Google-Smtp-Source: AGHT+IFbmTr6SypIn0YhfS/UcntvRY9CSCf8ragk4gVQnPyD5GXw5Yv2YoJooKkgjGFI8jBEIxosPA==
X-Received: by 2002:a17:902:e850:b0:1fb:6663:b648 with SMTP id d9443c01a7336-2039e46ce19mr113805605ad.21.1724631452822;
        Sun, 25 Aug 2024 17:17:32 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203857051b9sm58695955ad.234.2024.08.25.17.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 17:17:32 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 4/6] Staging: rtl8192e: Rename variable CmdID
Date: Sun, 25 Aug 2024 17:17:22 -0700
Message-Id: <20240826001724.274811-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240826001724.274811-1-tdavies@darkphysics.net>
References: <20240826001724.274811-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable CmdID to cmd_id
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 8 ++++----
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 1088352a315d..939f0a7c3a90 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -509,7 +509,7 @@ static void _rtl92e_set_tx_power_level(struct net_device *dev, u8 channel)
 static u8 _rtl92e_phy_set_sw_chnl_cmd_array(struct net_device *dev,
 					    struct sw_chnl_cmd *CmdTable,
 					    u32 CmdTableIdx, u32 CmdTableSz,
-					    enum sw_chnl_cmd_id CmdID,
+					    enum sw_chnl_cmd_id cmd_id,
 					    u32 Para1, u32 Para2, u32 msDelay)
 {
 	struct sw_chnl_cmd *pCmd;
@@ -524,7 +524,7 @@ static u8 _rtl92e_phy_set_sw_chnl_cmd_array(struct net_device *dev,
 	}
 
 	pCmd = CmdTable + CmdTableIdx;
-	pCmd->CmdID = CmdID;
+	pCmd->cmd_id = cmd_id;
 	pCmd->Para1 = Para1;
 	pCmd->Para2 = Para2;
 	pCmd->msDelay = msDelay;
@@ -601,7 +601,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 				break;
 			}
 
-			if (CurrentCmd && CurrentCmd->CmdID == cmd_id_end) {
+			if (CurrentCmd && CurrentCmd->cmd_id == cmd_id_end) {
 				if ((*stage) == 2)
 					return true;
 				(*stage)++;
@@ -611,7 +611,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 
 			if (!CurrentCmd)
 				continue;
-			switch (CurrentCmd->CmdID) {
+			switch (CurrentCmd->cmd_id) {
 			case cmd_id_set_tx_power_level:
 				if (priv->ic_cut > VERSION_8190_BD)
 					_rtl92e_set_tx_power_level(dev,
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index f588f01d66fa..41ae98e01a30 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -163,7 +163,7 @@ enum sw_chnl_cmd_id {
 };
 
 struct sw_chnl_cmd {
-	enum sw_chnl_cmd_id CmdID;
+	enum sw_chnl_cmd_id cmd_id;
 	u32			Para1;
 	u32			Para2;
 	u32			msDelay;
-- 
2.30.2


