Return-Path: <linux-kernel+bounces-210868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2581C90498B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C024B1C209AE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D1C4F8A0;
	Wed, 12 Jun 2024 03:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="OTkLChne"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B4A3F8ED
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162562; cv=none; b=pH2Oz/JcBj2NhA4TIEIv2ZR56SP1Shh+Oud75k9DWHHwuMKJDL+9iCar4jixa3BwFxmZ5wpx6XH4a7cWlLrpiL1/rZj810HBg0MIYfbPIFc+iaeQ17bspybMDWbctkjeev2OIIYjqzkzRNpfQsnHqY7fU3Q0hT4BSs2iu/30tss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162562; c=relaxed/simple;
	bh=g04zKuym8MOAIEks5WqlwbJO0ymKVXZ1rE4I4gyez2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NykiCtEfa5FIeJW3hPEZ1pMjhYEVCyghDqkfXixyTumnAG+xiIMsd6nowEYmpVzmxuV3AJF2S56E8wEgrMBeMz4Q724y28yCb1tZm9w6rj2HDOxk4m/Ch7DRUgiS4eyg7TuGheJOO8Tdtnqe6K6SM9K2ceAVeLbHdt8lQREpbPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=OTkLChne; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7042882e741so3105896b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162560; x=1718767360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WkFr6xEvivvd+B09wKWKgC46Hg539bA2/mgjCH1xUA=;
        b=OTkLChneav9SNPisdjyfgE/D4j2S7Z4aaymyNH3FC+OyCX5mlIUXZWoMKzEqAPW/Aq
         Ir6ZhPtXtMi/Nl7FpdCcO86n/X/zS8C+AQimn4ooTfsXBjdcgethC/GKCtTQlKCfwUmE
         2HZI+M9hurHfRaYPrbii1NTIbMEmL/6Zw3ifCNny42cfi1pGNoPa7Dlvu72L77ze5hZD
         sUGySBcjTAban8I6azvcI+9AtQghNpirg/typzlXWh2wLmOMLSkde/yNN03DDfJWPncH
         zr1/7n3+xLg/LSbd9y0b9CJyGLxBi2p1RDerXj3rinbSwHDraU/KRKUFXb2mO2NzJupG
         Q31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162560; x=1718767360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WkFr6xEvivvd+B09wKWKgC46Hg539bA2/mgjCH1xUA=;
        b=KTpo7KhXwYTZDmbeiHkrm1AQ5dL3L/O+iGY2xOE8WMb8U0Lm0niD2Rpb2c7JxbdcAL
         nSWj0rm1Om2SQb2txdaKlWYNGD+MjkpBaUGyzTinZUCFQCbNEHv4smlfBFzDnBLg4lLg
         jSFoC9vIhwWgEjk08g7Pkoj1PYk8A2q0Gr9V37BcU/Zv3mvJ4NsO22R7t0dgW9bvdWV5
         OL2bl6cZefecKEq6cBQKapHe5qjICI7dB8CEiIKXXgsNzNOHtsMs2lIc/y5f/cEFFlpu
         e2yd/Bp/+zX9s3BobOXh2J2Y5iYoJsd5XO0Q/PYJikrdEGeTDWTrSljI8SrVqTfzSrsT
         VD7g==
X-Forwarded-Encrypted: i=1; AJvYcCXeBqCpyllWYAh/vZ9fjPAR9a4gdVN6/pgLE2mKfxZ77aRzTBoAvpoD0wTlw1A2jL3T5GqsRvos43Mn4UEI1tpDqEilT3/WRijBDnIT
X-Gm-Message-State: AOJu0YywEK+VOunF29AC3/TAtWEq2/AUlNmNxSt4gqm8pN8DLH24ngqe
	VOHjnMJJBaxF0ozVLK33egR4Ax4G0xsIX3gmzzXOqbQErvmRzj1BZram/MNQDoM=
X-Google-Smtp-Source: AGHT+IGolqUbZjcHpSurAz5mByQrnFKrL1mfB+aDiqNFOrZ9uOqP7glwG77mTIjrxe0GUiqlkn1weg==
X-Received: by 2002:a05:6a20:a11b:b0:1af:cc75:3f79 with SMTP id adf61e73a8af0-1b8ab6ab340mr823758637.55.1718162560248;
        Tue, 11 Jun 2024 20:22:40 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:39 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 09/24] Staging: rtl8192e: Rename variable bforced_tx20Mhz
Date: Tue, 11 Jun 2024 20:22:15 -0700
Message-Id: <20240612032230.9738-10-tdavies@darkphysics.net>
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

Rename variable bforced_tx20Mhz to forced_tx_20MHz
to remove hungarian notation and make it snake_case.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Change bforced_tx20Mhz to forced_tx_20MHz, and update commit message
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 8 ++++----
 drivers/staging/rtl8192e/rtllib.h          | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 5392d2daf870..f546e6d368b4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -377,7 +377,7 @@ static void _rtl92e_dm_init_bandwidth_autoswitch(struct net_device *dev)
 
 	priv->rtllib->bandwidth_auto_switch.threshold_20Mhzto40Mhz = BW_AUTO_SWITCH_LOW_HIGH;
 	priv->rtllib->bandwidth_auto_switch.threshold_40Mhzto20Mhz = BW_AUTO_SWITCH_HIGH_LOW;
-	priv->rtllib->bandwidth_auto_switch.bforced_tx20Mhz = false;
+	priv->rtllib->bandwidth_auto_switch.forced_tx_20MHz = false;
 	priv->rtllib->bandwidth_auto_switch.bautoswitch_enable = false;
 }
 
@@ -388,14 +388,14 @@ static void _rtl92e_dm_bandwidth_autoswitch(struct net_device *dev)
 	if (priv->current_chnl_bw == HT_CHANNEL_WIDTH_20 ||
 	    !priv->rtllib->bandwidth_auto_switch.bautoswitch_enable)
 		return;
-	if (!priv->rtllib->bandwidth_auto_switch.bforced_tx20Mhz) {
+	if (!priv->rtllib->bandwidth_auto_switch.forced_tx_20MHz) {
 		if (priv->undecorated_smoothed_pwdb <=
 		    priv->rtllib->bandwidth_auto_switch.threshold_40Mhzto20Mhz)
-			priv->rtllib->bandwidth_auto_switch.bforced_tx20Mhz = true;
+			priv->rtllib->bandwidth_auto_switch.forced_tx_20MHz = true;
 	} else {
 		if (priv->undecorated_smoothed_pwdb >=
 		    priv->rtllib->bandwidth_auto_switch.threshold_20Mhzto40Mhz)
-			priv->rtllib->bandwidth_auto_switch.bforced_tx20Mhz = false;
+			priv->rtllib->bandwidth_auto_switch.forced_tx_20MHz = false;
 	}
 }
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index bd18d866ce22..ab52fd66c705 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1018,7 +1018,7 @@ struct tx_pending {
 struct bandwidth_autoswitch {
 	long threshold_20Mhzto40Mhz;
 	long	threshold_40Mhzto20Mhz;
-	bool bforced_tx20Mhz;
+	bool forced_tx_20MHz;
 	bool bautoswitch_enable;
 };
 
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index d376c35a5ad7..ba76d2fcc750 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -362,7 +362,7 @@ static void rtllib_query_BandwidthMode(struct rtllib_device *ieee,
 	if ((tcb_desc->data_rate & 0x80) == 0)
 		return;
 	if (ht_info->cur_bw_40mhz && ht_info->cur_tx_bw40mhz &&
-	    !ieee->bandwidth_auto_switch.bforced_tx20Mhz)
+	    !ieee->bandwidth_auto_switch.forced_tx_20MHz)
 		tcb_desc->bPacketBW = true;
 }
 
-- 
2.30.2


