Return-Path: <linux-kernel+bounces-331292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2728097AB06
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1341F288E2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1596614AD0E;
	Tue, 17 Sep 2024 05:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="BURRh0Ik"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C5576036
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551121; cv=none; b=VFPYMp+7ebmEMubkHjQWEyOh3zKipd9rOMoC2uxFJjFw5n1DXut+DIvk9cXf29fwBCsmF4Up0gdwgPgMokVNBWzpK1PwftkOBxWR831EYpdb1QgA5RMG98+cseVe52Caf7IuO8IOMLTUuux+OqXbTVRMZzNN+NqxVa3fjbF6Bc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551121; c=relaxed/simple;
	bh=/aRwPhx68qTL0lKrU3BPit/lV8pb86BsZrdljM1kho8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VPZj6AJfDlED8fVZ+MaBWwhnhCNAd+ZXaIBb7aLFgc1Vqg5wFzVL2dPI0lIeiRQ9fukkRv84QhfAfYj6JAF5wSyYprw8zfWrwOGFD82U2TX6OR8z7rCqdl5kyNu5WyLxToQBhb8czUG32TNiN0EdJ4TmFPz1Up0itUwe70tC5bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=BURRh0Ik; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7d666fb3fb9so2565921a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551119; x=1727155919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O63mVFRoUMn0Irdln2CPxuHNEZxiLeaDCDgudz+MiBA=;
        b=BURRh0IkhGTNCSuEA2ushjZ6t/hqp26exH1Y/wesnygxUoH5N2brKIzllbEF+VWhaS
         Yob4g52KTlimMQXLTRaYygwXQSS5CazzJ28bTrqKsYTP/X6+WMEWIX75DUc+rjdNmiXV
         ChrZrK8d+BFw6QwU9BYhUaIuhb+etfwY2jXmyZXETeHNqwb/aF3tkAnl2t0aetRD56FA
         C3cio10phEGcpafK1Jyqpr8HMfkqZ/d59rApK9oLXDu5UacDdC/HDQON14lBOdkzzA9o
         jEOHoHSb3z3OYYfE/7bb5YiLsKwdwvlGhptchRxRVJJCvY8LlCsRq2nzfKIlxIn0pab5
         ecyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551119; x=1727155919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O63mVFRoUMn0Irdln2CPxuHNEZxiLeaDCDgudz+MiBA=;
        b=o72QwTFnN6FEIKTkGmCcbWbMWl+L4RHk+hJOexvg7iRmT22xrWdBMXkqr4aKVRl8Ns
         uxLnqkhHkV73Vb4jp4NcMmkDF7cYdQ0Otp0MWsK3y5uiZ6TM23RgG77SMVfRKd/29a5x
         iIACRKH/aoX7THAg7Th/Y56KwV8+O/5GWDN5umDMvkd5H2Sqjcbx7GwzBRUb9v7pJSVM
         Z7tjWqImhXxvbjTp2ONunrbWGtCWidALpRhc4W7H7CuCn9igp1itFTwBuLgL5sPqaend
         lngTZ4c/yhGyibdk4oPnqn4NYwp/UedESQpzNIMpjCAfDI30jkusaWysSPzBWxA1hqP3
         65Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXp+kJK5W5NvRmNDcuh0F6K6TdVoKULtsavJAaXPuXsFD6BZqrPawEPjewQumznNJvWRvPAbJ7v+ZkW2FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkvoIZsGKd7b3kxXQslxqRIUF9ZBt3Zzon6QX8fype5VSyHKFT
	eWub6nbjU2gtSZAfDGFkOLbXNZt/vinecMX++FKbXiYHTUl45qBJo+3L66369lI=
X-Google-Smtp-Source: AGHT+IGrAEsEAnjGA+zMNlmnFwBOh6t2QXxQQIZ0eykys0/fb6bX/LEkDWQMrANrnLrZtghqtVh/nw==
X-Received: by 2002:a05:6a21:8901:b0:1cf:46e1:5b7c with SMTP id adf61e73a8af0-1cf5e05cad6mr35860187637.3.1726551119208;
        Mon, 16 Sep 2024 22:31:59 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:31:58 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 05/18] Staging: rtl8192e: Rename variable PreCommonCmd
Date: Mon, 16 Sep 2024 22:31:39 -0700
Message-Id: <20240917053152.575553-6-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240917053152.575553-1-tdavies@darkphysics.net>
References: <20240917053152.575553-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable PreCommonCmd to precommon_cmd
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 6 +++---
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index fbe624e235df..ac9aea228276 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -550,12 +550,12 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 
 	{
 		PreCommonCmdCnt = 0;
-		_rtl92e_phy_set_sw_chnl_cmd_array(dev, ieee->PreCommonCmd,
+		_rtl92e_phy_set_sw_chnl_cmd_array(dev, ieee->precommon_cmd,
 						  PreCommonCmdCnt++,
 						  MAX_PRECMD_CNT,
 						  cmd_id_set_tx_power_level,
 						  0, 0, 0);
-		_rtl92e_phy_set_sw_chnl_cmd_array(dev, ieee->PreCommonCmd,
+		_rtl92e_phy_set_sw_chnl_cmd_array(dev, ieee->precommon_cmd,
 						  PreCommonCmdCnt++,
 						  MAX_PRECMD_CNT, cmd_id_end,
 						  0, 0, 0);
@@ -591,7 +591,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 		do {
 			switch (*stage) {
 			case 0:
-				CurrentCmd = &ieee->PreCommonCmd[*step];
+				CurrentCmd = &ieee->precommon_cmd[*step];
 				break;
 			case 1:
 				CurrentCmd = &ieee->RfDependCmd[*step];
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 7c575535d074..ce36f0979294 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1400,7 +1400,7 @@ struct rtllib_device {
 		struct rtllib_rxb *stats_IndicateArray[REORDER_WIN_SIZE];
 		struct rtllib_rxb *prxb_indicate_array[REORDER_WIN_SIZE];
 		struct {
-			struct sw_chnl_cmd PreCommonCmd[MAX_PRECMD_CNT];
+			struct sw_chnl_cmd precommon_cmd[MAX_PRECMD_CNT];
 			struct sw_chnl_cmd PostCommonCmd[MAX_POSTCMD_CNT];
 			struct sw_chnl_cmd RfDependCmd[MAX_RFDEPENDCMD_CNT];
 		};
-- 
2.30.2


