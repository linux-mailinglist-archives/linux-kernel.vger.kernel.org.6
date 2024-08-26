Return-Path: <linux-kernel+bounces-300612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CFC95E603
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 02:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7CE1F21253
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5075C121;
	Mon, 26 Aug 2024 00:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="P/JbnwHR"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2344C96
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 00:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724631454; cv=none; b=nZ009+79E96iWkF462hBdVVZZ28BqNrXKeR7Hu7SEy6p7zt3YSbLLXBqTLdDNHQzG5yAmz7sppXrfHW+aI0trLjO9c9FvDfhRruA8/PMek3Fhl1BgZIAI9ffBaRZribfr3Rtp6MAM9jB76guaTcSxM9VFjRdO5G8Ps2apo4JWLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724631454; c=relaxed/simple;
	bh=prRiS44P0Iof096cPDWfqkcr1mi//kjz52Me642CfK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y5xwDNIG3x5CASZl3NWniIRt37Fe4QHluGiQthZo+8ulOh4/o3r8Z5ZUvZDs1/d5z8sca4YV/AfCJzLQiXeZnVEgQaRrmFF457kKdqEYzy6UJhMwcO/QSTgf2GcozGHiMpHB/GMxwrjfszz0fMJmE8FYIvNXRNccBYgOpCQbo+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=P/JbnwHR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71423273c62so2628579b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 17:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1724631452; x=1725236252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rqngQI/4sGkKpLaL5rsoSzvVLXDgXzNrKFaFzkUU64=;
        b=P/JbnwHROBtkQOEhMIY1r4xBZZ2R65WpAx6QEDMY0N4hsHTgIt4tgWAIu1SRvnCOID
         oLC9YZiMH19/TyBs2tuyKM23BtPJi20aer3N7JOMf3BP01FtTCLH+KNomnlpWXaGt1mR
         3BEHOm0+GQGXlIiPC7ri12KWvALqEGUuUpbf9K+CBXxHwyDuoctkwKjKSMUe44Mvjak/
         TXWUP8c8aogfKll2MvWTt+xnyz/ntXQXgyj4BeaunVJgnrDeCXsl60IU1v6C61cjOxm9
         ahEnY6hQG/Zpid/guHSlUZvEPouaPiKDUBbUiiC+fYc0Oun1pqPMmQDwS7EGD8C+cau0
         zNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724631452; x=1725236252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rqngQI/4sGkKpLaL5rsoSzvVLXDgXzNrKFaFzkUU64=;
        b=dYAcMmkENvJ9X2CgQxM24cKJQFa06kARoHbYbP4ZQwFL9lGb2mAamCQ10cWM4aMOTF
         XpocvXH+qpmdK5Ya+LEb2MV9dTJlY9IXtWLZ9pTroiEYiwq0WimRpXIBU7TYe+HZRFNn
         HH8iY48mnUBA8C/vZubUOkHQM2NhkqTHIFoCI+k218VzzbdYSAeF5g86GmxzNvEN5ihF
         pFfikJz3pAPCs6lMuEU1PQAZ/rkrdX88jgHlXjZk2xQS6NSnBiDBub/FHRIUQzvwinxA
         uT4eainshm9dAYZtGT+VV/lmYzSjkHDRZFk8GTBorXPZvKMx26kPZPA8sEfA2gvZ4MXl
         JLFg==
X-Forwarded-Encrypted: i=1; AJvYcCUob+vpZWnve/eoAku7vdMHOxe3brhqK8GqiCr5fKFEzFshsUVp7w9S2ngPKcqoNGLkgtJOhR8MSNktZKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy59ilSp9/7LWK/f7GgQQDldesC+5ZidQlcNFPU/NAPVqpiq0cd
	9fmH/MJEe4fTBu3DRdcb8xyjoKnCRUe/X/TkEovWrU5oD+w6uaFKBJYb7HJC2sU=
X-Google-Smtp-Source: AGHT+IHxPd7zjdnIo6iOsBV4KQBEh1xqjCrs5S0hw2TD8B8kin9y+UD+rez4FNo0/O/VybFBs68HFA==
X-Received: by 2002:a05:6a21:6f83:b0:1ca:edfc:8550 with SMTP id adf61e73a8af0-1cc8b59174dmr8524171637.38.1724631451983;
        Sun, 25 Aug 2024 17:17:31 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203857051b9sm58695955ad.234.2024.08.25.17.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 17:17:29 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 3/6] Staging: rtl8192e: Rename variable CmdID_RF_WriteReg
Date: Sun, 25 Aug 2024 17:17:21 -0700
Message-Id: <20240826001724.274811-4-tdavies@darkphysics.net>
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

Rename variable CmdID_RF_WriteReg to cmd_id_rf_write_reg
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 6bed5363ec54..1088352a315d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -579,7 +579,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 						  ieee->RfDependCmd,
 						  RfDependCmdCnt++,
 						  MAX_RFDEPENDCMD_CNT,
-						  CmdID_RF_WriteReg,
+						  cmd_id_rf_write_reg,
 						  rZebra1_Channel,
 						  channel, 10);
 		_rtl92e_phy_set_sw_chnl_cmd_array(dev,
@@ -629,7 +629,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 				rtl92e_writeb(dev, CurrentCmd->Para1,
 					      CurrentCmd->Para2);
 				break;
-			case CmdID_RF_WriteReg:
+			case cmd_id_rf_write_reg:
 				for (eRFPath = 0; eRFPath <
 				     priv->num_total_rf_path; eRFPath++)
 					rtl92e_set_rf_reg(dev,
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 8ca36d1c7fb1..f588f01d66fa 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -159,7 +159,7 @@ enum sw_chnl_cmd_id {
 	cmd_id_write_port_ulong,
 	cmd_id_write_port_ushort,
 	cmd_id_write_port_uchar,
-	CmdID_RF_WriteReg,
+	cmd_id_rf_write_reg,
 };
 
 struct sw_chnl_cmd {
-- 
2.30.2


