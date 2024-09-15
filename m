Return-Path: <linux-kernel+bounces-329700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0479794CB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95470B21CC8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704A9823DF;
	Sun, 15 Sep 2024 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo4uQ729"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21BA45005
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382466; cv=none; b=b+fdpWRsPWUiMI6g/+2u23CB3fnmGi5BDhx7TktLbkUdSaYT5aMpOFjNDXr74+8WQ5HDTOxR+YvBh/ASQRRAUHpMjYQLf505wr971JY7442mbCP5fQqXQL4dh9PG0B5FhvJSkrtL9bbWLqXwwtUk84AervotcTpP27Sy1XitV6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382466; c=relaxed/simple;
	bh=Wg1QbwaWxoT7iSLjFPwAnB3DqOtoJi6uYhFbQKguFpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inv15xqpRDIHZ0UV43shEYNDd7HP57fL5MSd171lFr/SVapmY+tQ+Ge6btiN8Je4SrP/EXdazVySLe8pmN2/1dIPH6ByyRV5YInRAfUHVEnF8lSBGVlSVo6of2h501aNFVaWbFGbf0CQVHEle52s9K7SCsl1LGt3EolR0qszQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bo4uQ729; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c2561e8041so2332756a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382463; x=1726987263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PG4mVKpcaOCxtSJWDIjqvWmYtFbVY/4wBG00JhaxlE=;
        b=Bo4uQ729c2sUS8Au20RwEt5HBSWNepmpeqa1f55w+FzhVGFHZv3ZK8FSTakyrEZQxy
         NhWtN8zNdhGxaCyKHvRmwvsph0vfsdudjojZ/a0A9T470IiwsBGh2rZr8qYSZP5Yy20z
         6oMpI2sPMMnSTEjEG33ui7wKndDjjDhbesROBmWaXRs5U6PTURQ7F76HKwUkJ0S9JbLn
         1Fr+jeHlH4GjuLLLLuDIh55zdu1/fBppLkCEM2v3rlZP/5WjnvSeAeIaME3Gi/JQIGww
         aH7VjOHn+vKVzRlULIc6Dmpdd9fFqo1VJd/SMHlEz6FDgY3CoguFrYfIPu3oRe25dOUm
         mtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382463; x=1726987263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PG4mVKpcaOCxtSJWDIjqvWmYtFbVY/4wBG00JhaxlE=;
        b=sAvv3RSYLN6yCwR3isJf1DFF8MgEKFcfTGKbXW0x1ORml+wTk3M78heET42TAxjkXQ
         T0cQWES0wrzu/5rqOipt6aHAgX6fQfrE885buHPRODPcq6pIAVKAragqgiHScBRAmGd/
         uKQtt1lAqNIKHPbSrvBMpkfxHYWOFu7ql3LWXgK7654+1Xs5f+5xnYmX5H/dZJpDJLyM
         E6cyUwkWr8zvH8+IbW95gfqaK800nW7Vk3sAO8BLO6rfX0K2ZR8lMXVweftTKlPzwvdx
         +Kk2EA/i4VlEls0bxjWmWyVy+4mQ5xJcYpetBNjZKkHJRLaUs8r1Ajz5ULI3xUqCLgva
         CAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk21doTUvOOWZqYnyXTVXZZWGyKK8ckN6wPPqH9Er9BOURg2AEKYYVy4cvHvUBxaArwL5zVbtMFuw2pGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBYnsExmf3yBVhIYc3PPZvmTaR04wBqTEj4fgNWpIZEQvvyboH
	eJhhP9LGBbBAtJipgFWiEwsr3nl8OUIqHHQpxR78i5MySTg8VMOR
X-Google-Smtp-Source: AGHT+IGzBDXgOeExOn/piQRC2BfIC/0QtfeBYVFqOREzn5ljU+1aF5j5jmwtqFwUmhj56kxpqGwknA==
X-Received: by 2002:a17:907:608d:b0:a86:79a2:ab15 with SMTP id a640c23a62f3a-a9048102110mr738327966b.40.1726382462682;
        Sat, 14 Sep 2024 23:41:02 -0700 (PDT)
Received: from kernel-710.speedport.ip (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm160201066b.8.2024.09.14.23.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:41:02 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 09/17] staging: rtl8723bs: Remove unused function PHY_GetTxPowerLevel8723B
Date: Sun, 15 Sep 2024 08:38:23 +0200
Message-ID: <65e86a58b513c580325fe93cc47a114f51437eea.1726339782.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
References: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused function PHY_GetTxPowerLevel8723B and belonging unused
function pointer in struct hal_ops get_tx_power_level_handler.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 1 -
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 4 ----
 drivers/staging/rtl8723bs/include/hal_intf.h      | 1 -
 drivers/staging/rtl8723bs/include/hal_phy_cfg.h   | 2 --
 4 files changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index a44c1dd0f691..ea0a9849d28b 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1888,7 +1888,6 @@ void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->set_chnl_bw_handler = &PHY_SetSwChnlBWMode8723B;
 
 	pHalFunc->set_tx_power_level_handler = &PHY_SetTxPowerLevel8723B;
-	pHalFunc->get_tx_power_level_handler = &PHY_GetTxPowerLevel8723B;
 
 	pHalFunc->hal_dm_watchdog = &rtl8723b_HalDmWatchDog;
 	pHalFunc->hal_dm_watchdog_in_lps = &rtl8723b_HalDmWatchDog_in_LPS;
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index a4ea124eb9ad..d8709d40cb33 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -575,10 +575,6 @@ void PHY_SetTxPowerLevel8723B(struct adapter *Adapter, u8 Channel)
 	PHY_SetTxPowerLevelByPath(Adapter, Channel, RFPath);
 }
 
-void PHY_GetTxPowerLevel8723B(struct adapter *Adapter, s32 *powerlevel)
-{
-}
-
 static void phy_SetRegBW_8723B(
 	struct adapter *Adapter, enum channel_width CurrentBW
 )
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 84da38c55d7e..be52288a2f1a 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -193,7 +193,6 @@ struct hal_ops {
 	void (*set_chnl_bw_handler)(struct adapter *padapter, u8 channel, enum channel_width Bandwidth, u8 Offset40, u8 Offset80);
 
 	void (*set_tx_power_level_handler)(struct adapter *padapter, u8 channel);
-	void (*get_tx_power_level_handler)(struct adapter *padapter, s32 *powerlevel);
 
 	void (*hal_dm_watchdog)(struct adapter *padapter);
 	void (*hal_dm_watchdog_in_lps)(struct adapter *padapter);
diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
index acf714946365..07bf0a8d019a 100644
--- a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
+++ b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
@@ -49,8 +49,6 @@ void PHY_SetTxPowerIndex(struct adapter *Adapter, u32 PowerIndex,
 u8 PHY_GetTxPowerIndex(struct adapter *padapter, u8 RFPath, u8 Rate,
 			enum channel_width BandWidth, u8 Channel);
 
-void PHY_GetTxPowerLevel8723B(struct adapter *Adapter, s32 *powerlevel);
-
 void PHY_SetTxPowerLevel8723B(struct adapter *Adapter, u8 channel);
 
 /*  Call after initialization */
-- 
2.43.0


