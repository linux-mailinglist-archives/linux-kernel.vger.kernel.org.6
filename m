Return-Path: <linux-kernel+bounces-294828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A18E95932B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BDB1F23F47
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B513157A61;
	Wed, 21 Aug 2024 03:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="YH1pD20E"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D414D2A4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724209743; cv=none; b=jEiqpRX9wMzUlgkR8XnlRCDvxsVRjaBupbkCUFfqx78JIPght4Qg7dvuhOD+BIRaWqHXNJCINzpBOpvOBjKkF1f4qtzGgtLggk+cieho7P1gAHlD+y/YjRq7IYY7qsxAdyDiH3/UHmxGD5FYFr8vb6JkRAFrSHhWATROPKGcURw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724209743; c=relaxed/simple;
	bh=MSSrYs+Ev3I5I+MKzaEegdg+eZUUUuBSp+4MOEQm+7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DesdQQVT9VAZliigs7U5OWGxy+lcncSf4mWZdIt7BBcVEXjj/oiXDF/YV6cqaBGhge4DgaI/g0gL+LwHeY36DRgbtCAUpxO6m5oOl9M9Pri1Q+n4oXQorzwfRn7+xXY2L82Tp7ffe8plkz1cjY/ewn0xB5SntlFEUkDIsAMq9s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=YH1pD20E; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-714261089c1so93035b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 20:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1724209741; x=1724814541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyVBtoPNvS38G5BU2iCTo12jZw/thaVDEc7UQjxqHpE=;
        b=YH1pD20EZsOTyQMaAw+BAq7khylu848yQ96TxatrrXMfbPxE9zCGUslZWdUO99Fkev
         D8+dTU53dPbxfAtZZPuy1kiBUj7JLceKyTj7x3sC2Yu0QsoGAg5GBMlA1eLO88QYE+q4
         y5o6oShiG0sRlA0ToY78zLwQuI+J7v5mFs5UI2KUABYKEF5QBl1KGB9G3Xu3JUHbbTXD
         1h4kpBriIvqEH81bQx7BqoRrXYzRL8fENUsAeD6VsCoaRdq2a6+rRkYWgPvxZekX8HRx
         KG9tdriMMPcGUJPwMlHwfEQF0PI1iJCtT6TBmiHBsFeOoDtHYFGR4+4vxZlBadAU4ucB
         nv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724209741; x=1724814541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyVBtoPNvS38G5BU2iCTo12jZw/thaVDEc7UQjxqHpE=;
        b=KCdrLCTdpiaC6N6v9yH8tdK+4zl35lCAltSVclALF1loz52Cw8K6rNlgVhOBUCsLWg
         JhzWpX8Basgs9u42gCcpMCQJWoPtdyFeWe/oPkw3A42+e4p7yCz2K1YIF3aJMWUAF1qY
         1gy5KgEYKxQ8Tqzz1q00wFXUqhAy1UkL5MN5lGo8tKHW6U0BzAfzdgGB5HwgKPoMY/DI
         nk9AQJQQGwo2DXK0/o0z2WvR+JCP8ESzGNHwg1dCyFsTVymDHkSv4n5ipIMNKIItvJ/n
         TfjtKX5pLE2A5Bg1wjt/XX429r5gejRE8cUwGXbusnQkw+UcNXFQD1n/JxgGcWm+MHB6
         kFOA==
X-Forwarded-Encrypted: i=1; AJvYcCVXdx7KZEx+LvRTZHq3a13cB42vKGupv4vdHR2Yo0c8OSzQR71Q0Kaeh/7MKdpbdnxfdb4mbct/gW34tfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7qefoxAHynQBcwdD8KWwt+iVS7REmaaTDcjD6mPQjGHYbczHC
	qUuWuWdnJcKKKcgtxegje6BNrK6S514TixBmUzefNGHhxfj9fjeVJdHb64cvcS0=
X-Google-Smtp-Source: AGHT+IFXo6FslBQ2+uvZNqOcRyAaIm9YgVPXCABNnsQ0OPz6uv9XsD/eDGnKAf7ddbq/A+ggvYHmsw==
X-Received: by 2002:a05:6a00:2ea8:b0:70e:aa7f:2cb3 with SMTP id d2e1a72fcca58-71423e6822dmr2273465b3a.2.1724209741272;
        Tue, 20 Aug 2024 20:09:01 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add75dbsm8934404b3a.44.2024.08.20.20.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 20:09:00 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 1/6] Staging: rtl8192e: Rename variable CmdID_End
Date: Tue, 20 Aug 2024 20:08:51 -0700
Message-Id: <20240821030856.57423-2-tdavies@darkphysics.net>
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

Rename variable CmdID_End to cmd_id_end
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 8 ++++----
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 18b948d4d86d..e844f1b4913b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -556,14 +556,14 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 						  0, 0, 0);
 		_rtl92e_phy_set_sw_chnl_cmd_array(dev, ieee->PreCommonCmd,
 						  PreCommonCmdCnt++,
-						  MAX_PRECMD_CNT, CmdID_End,
+						  MAX_PRECMD_CNT, cmd_id_end,
 						  0, 0, 0);
 
 		PostCommonCmdCnt = 0;
 
 		_rtl92e_phy_set_sw_chnl_cmd_array(dev, ieee->PostCommonCmd,
 						  PostCommonCmdCnt++,
-						  MAX_POSTCMD_CNT, CmdID_End,
+						  MAX_POSTCMD_CNT, cmd_id_end,
 						  0, 0, 0);
 
 		RfDependCmdCnt = 0;
@@ -585,7 +585,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 						  ieee->RfDependCmd,
 						  RfDependCmdCnt++,
 						  MAX_RFDEPENDCMD_CNT,
-						  CmdID_End, 0, 0, 0);
+						  cmd_id_end, 0, 0, 0);
 
 		do {
 			switch (*stage) {
@@ -600,7 +600,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 				break;
 			}
 
-			if (CurrentCmd && CurrentCmd->CmdID == CmdID_End) {
+			if (CurrentCmd && CurrentCmd->CmdID == cmd_id_end) {
 				if ((*stage) == 2)
 					return true;
 				(*stage)++;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index cf4d48c4d4ed..11408fadd1e7 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -153,7 +153,7 @@ struct cb_desc {
 };
 
 enum sw_chnl_cmd_id {
-	CmdID_End,
+	cmd_id_end,
 	CmdID_SetTxPowerLevel,
 	CmdID_BBRegWrite10,
 	CmdID_WritePortUlong,
-- 
2.30.2


