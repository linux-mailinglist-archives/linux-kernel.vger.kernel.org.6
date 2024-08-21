Return-Path: <linux-kernel+bounces-294831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0095395932F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B326D284A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F457161306;
	Wed, 21 Aug 2024 03:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="PsXBqacK"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349CF1547C2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724209745; cv=none; b=Da0B3eyI9TDZqMlHvy9l6tWgdonnx9yaBMGx0fyV7TXbIDmZqGOfbxLvVEfP08E2/UYcSACqCfd6QK4kJlxuuZrjskmIe90TpkNA0wTn4lmSYKESsV9WqhVC51+Hy/vtYKzargdcP1mAteCEb70Mj64pvpvssOw6Dm/UL667Ss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724209745; c=relaxed/simple;
	bh=Y1Isi5tZMdBTmr44yIuWdZLDGGs1zRS8Rk3k3dRwLN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u99ZFcuRrLjFHcv1iUZPxQ3HmRlEyU0RkKVwG7dqodQ4n5+mX4OrNULXEcMBLH+D15oLyOyMZ9dfqpsSMsdTq5cZkzr99WKucztuOhnC+Rsmf8M2LOT2WPxV/tFWsGpMU3h0435+yzFtOgTdSINtCRK779wnUlg3z8+FFB6Bq3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=PsXBqacK; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5daa4f8f1c4so2810915eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 20:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1724209742; x=1724814542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUBD+hB9uTLEnGM3jp7igQB/VUtJFKRV9rFHokEeKCQ=;
        b=PsXBqacK18owneg7cP6F1c1+8Rews5bUJJcJqZbQAAfPuNCpattQgruKmK+6W3Hbod
         Ob5Q68TEceTcC1oNpnzxiNGr5/VEA+IUNVICOklJUOmsROfoomvWI74G8jcsNnqAWcM9
         nCGhbmHgDtaJnDDML6ijAXd7xQkBCI2PlDj4HVLPG7spkc9oaJRzfk22lmNyIYxAUNqD
         tEuid9n4x1SDOB82sFh/gdrH3zE90auFI45kw8lhtubFkjFkp5CjXPdN75kbd2lIH763
         R/bmEhhFzeDzZKUdM1wsvjRmweTGcbRO6y5PmHbTnilxf6yyy34P1gdTPIS40LhVnXW/
         wMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724209742; x=1724814542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUBD+hB9uTLEnGM3jp7igQB/VUtJFKRV9rFHokEeKCQ=;
        b=Aeapwj9PPXyvnhm3WQuXXRBR2sSnD38qYxG7ncuBlzXCsaQKBenFjrDKxIH26MpiNI
         UyK/vGmnToP0ghZ0lxzjVspz7Mk4FFD5gyvul49WqGIYTPEGIVsZ88g9wdsd7xW85Sae
         dlJP+EycqG+vYX6DeZeV0MY6K1MJgViOe9he1GRSpHDIvTuHro9DeyVhMIiXA9XYUBdL
         BASDCWNNBGYnWrwobbjaBgRxsPnvnmv05poxrZCO3/Ql70dJr3oF4BOBubFu+gZjbmcs
         J5twBoDmRGfAO60QDGh4PIMxX1oDr0csRUfnh3Hn5tLB1bxpPxex3vPLrCZqOCLlcSU7
         BSUw==
X-Forwarded-Encrypted: i=1; AJvYcCWQVsfj42t6cuPdqArGVpWfCBigTkCE9t3z2QkehbOWzj5nxJ8e/h8S9v7aHqZHZ/nKPR1MaQX/9emMxjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY2MzvRvKGkH9tnkoFJyXRwQYExcIVgNdBenzbLtqjhRMJs4t3
	QOgvb8vKyKkTXfzaTIOi88uYRilKhMDRAwZ7zS4+tKtZePPhC6kSz8gfjis/Aks=
X-Google-Smtp-Source: AGHT+IHMiFDWJHrUgwGHz1wp4yDgVI3OB2OBVcxAd3/LLlGuAdbgM3uU80ycc23R0d6mutCZQTfbtw==
X-Received: by 2002:a05:6358:3b96:b0:1b5:a139:a24a with SMTP id e5c5f4694b2df-1b5a139b5e2mr131259555d.18.1724209742132;
        Tue, 20 Aug 2024 20:09:02 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add75dbsm8934404b3a.44.2024.08.20.20.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 20:09:01 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 2/6] Staging: rtl8192e: Rename variable CmdID_SetTxPowerLevel
Date: Tue, 20 Aug 2024 20:08:52 -0700
Message-Id: <20240821030856.57423-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240821030856.57423-1-tdavies@darkphysics.net>
References: <20240821030856.57423-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable CmdID_SetTxPowerLevel to
cmd_id_set_tx_power_level to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index e844f1b4913b..e82e992dd139 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -552,7 +552,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 		_rtl92e_phy_set_sw_chnl_cmd_array(dev, ieee->PreCommonCmd,
 						  PreCommonCmdCnt++,
 						  MAX_PRECMD_CNT,
-						  CmdID_SetTxPowerLevel,
+						  cmd_id_set_tx_power_level,
 						  0, 0, 0);
 		_rtl92e_phy_set_sw_chnl_cmd_array(dev, ieee->PreCommonCmd,
 						  PreCommonCmdCnt++,
@@ -611,7 +611,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 			if (!CurrentCmd)
 				continue;
 			switch (CurrentCmd->CmdID) {
-			case CmdID_SetTxPowerLevel:
+			case cmd_id_set_tx_power_level:
 				if (priv->ic_cut > VERSION_8190_BD)
 					_rtl92e_set_tx_power_level(dev,
 								   channel);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 11408fadd1e7..19afb056520e 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -154,7 +154,7 @@ struct cb_desc {
 
 enum sw_chnl_cmd_id {
 	cmd_id_end,
-	CmdID_SetTxPowerLevel,
+	cmd_id_set_tx_power_level,
 	CmdID_BBRegWrite10,
 	CmdID_WritePortUlong,
 	CmdID_WritePortUshort,
-- 
2.30.2


