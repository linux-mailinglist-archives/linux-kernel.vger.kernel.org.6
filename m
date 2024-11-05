Return-Path: <linux-kernel+bounces-395928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7A69BC516
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6CEB1F21BD1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B1D1FEFCD;
	Tue,  5 Nov 2024 05:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmsgVlEo"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920BA1FE0F2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786133; cv=none; b=lkFgXBzp+vH0yxKPVFd4SIB6EYwV5N8qs0viNCtZOyeDKv+UzA70xRddg7zTIAOnW38GX+M6DCeI8NTZKmX5qO8vkckHYjYFu3HqUn6FdmNvfT5gOBm3E4dbXl984XwWWbb1nPKz40bvH7hY/nWfcv2r82UM9rabzd4ZIQPZMgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786133; c=relaxed/simple;
	bh=jrq4/E5NDDOpFNWHL0DN5PzOqvNMgQj/oKYq0prtfR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IV9aphAhnQRdUN36OxWpy3r1sbhU9WYoTeE4aRuCHyRNDvIaWKhvNOn3quQ16+Vmm//6JCDowLzzsugYoCXkHkWMgoUKRucCfmxeq6rIa0eH7H+qA8PTA6irzEFkAJsP+nQqHJVmkp1YhAGlYQpHf5vRr7opnxAovmqv8TWtbEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmsgVlEo; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso74555501fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786129; x=1731390929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPl2wir3DMIoXyEGtK2BWBXAxfA9J6lkO9SyjSLT3tM=;
        b=SmsgVlEoE3yh+upBZ3sTeokLcwS4iJG/m0j+g6DzufSSeNabOw+5fUGFBclnoWmxeU
         h7QGY2lIRGXSj/I/+B0KGxkoh+VaJ9Pw5WLbgP/N0vYzyVq4Ah1OZ0Djwpf0oEfaBcKL
         H2wLBeF76EMPbjkkvaOL61dsgb+ezV2+uhxNWId5M2gFidIeLB8nabYJCwCYx4uK9Wm5
         6QZexCpIsnEdJKnbD1OB5MHvBp/13QmR4lF9+9Rbl//w54gxLcrg6Id2eQKQYlU+Eekq
         Km5SX6D+Mw9jBeoDnckFtkxTyrK6DQKjRFtkxG6zaGyzqn1CFcNP9NEvv/0MVFUGfvWq
         sUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786129; x=1731390929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPl2wir3DMIoXyEGtK2BWBXAxfA9J6lkO9SyjSLT3tM=;
        b=ixam6MzxnLnbRAbpHl3L17kHdL4KNMLHXsGSydXlPEbYFr+qvqKnuTFT+QUzJVfspX
         ++KXWYO3xX9P9jC9fT9hnOT+IhE85zBugA0z1FK9ig6KNJfoATKsHfkjKtjIi8S69DsW
         0atFIgM4YFLCGKiTCL6Kz8xFITdjgRkCuMX+/N6nFHZ0auojmNxzIYmwgWDe4Da8OzAR
         kbyTldbhSXZCLAnOpmQ0D+w7Y2hczw6L53ZinAbh0NgDoleb2aGaYgOTR+xFrAuLbK1/
         kFUfcUPWGHihPpUJGL7jNjyc4oP+VNoahbszVktzGLEpqOSWu5p1une/jF+rkrs+uAFd
         tj7A==
X-Forwarded-Encrypted: i=1; AJvYcCVUzzPFqFd/On0g86QDD8vXWyRBhKOKZqn0ZSVHDP/c15nLDfVxw9ShQz5/R3BhRub9pTOWWfoMkAy6Rpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt7XG+bx3zsT8yv90JwsuWhSCUinsa1rMse5y6s5Q5jm86fFgx
	zKUb9yuTqI6WFw/k2z2gF8Ww4xXZsBs1H4H0uiPVzYIBpYnPb00b
X-Google-Smtp-Source: AGHT+IHM26YoJDPjOfCd9kEU5QTvBz7nznuCJTdiiXg9j76bfiW0cudiQAlZV2koGeLDcxMzKmAHQw==
X-Received: by 2002:a2e:a589:0:b0:2fb:3df8:6a8c with SMTP id 38308e7fff4ca-2fedb7c9c38mr100205051fa.23.1730786129140;
        Mon, 04 Nov 2024 21:55:29 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb181451bsm78775466b.201.2024.11.04.21.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:55:28 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 03/16] staging: rtl8723bs: Remove function pointer set_chnl_bw_handler
Date: Tue,  5 Nov 2024 06:54:50 +0100
Message-ID: <fb4da3a1f3b3076641d7173a6b512abfbf60e7c5.1730749680.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730749680.git.philipp.g.hortmann@gmail.com>
References: <cover.1730749680.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove function pointer set_chnl_bw_handler and use
PHY_SetSwChnlBWMode8723B directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 5 +----
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 2 --
 drivers/staging/rtl8723bs/include/hal_intf.h      | 2 --
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index aaadd56b7d8a..7aa9d84ee574 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -280,10 +280,7 @@ void rtw_hal_set_chan(struct adapter *padapter, u8 channel)
 void rtw_hal_set_chnl_bw(struct adapter *padapter, u8 channel,
 			 enum channel_width Bandwidth, u8 Offset40, u8 Offset80)
 {
-	if (padapter->HalFunc.set_chnl_bw_handler)
-		padapter->HalFunc.set_chnl_bw_handler(padapter, channel,
-						      Bandwidth, Offset40,
-						      Offset80);
+	PHY_SetSwChnlBWMode8723B(padapter, channel, Bandwidth, Offset40, Offset80);
 }
 
 void rtw_hal_dm_watchdog(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 615a33cad84a..283208e1de5d 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1744,8 +1744,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->set_chnl_bw_handler = &PHY_SetSwChnlBWMode8723B;
-
 	pHalFunc->set_tx_power_level_handler = &PHY_SetTxPowerLevel8723B;
 
 	pHalFunc->hal_dm_watchdog = &rtl8723b_HalDmWatchDog;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 9e6414319608..2b3eaabf0774 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,8 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	void (*set_chnl_bw_handler)(struct adapter *padapter, u8 channel, enum channel_width Bandwidth, u8 Offset40, u8 Offset80);
-
 	void (*set_tx_power_level_handler)(struct adapter *padapter, u8 channel);
 
 	void (*hal_dm_watchdog)(struct adapter *padapter);
-- 
2.43.0


