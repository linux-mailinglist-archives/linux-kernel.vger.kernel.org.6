Return-Path: <linux-kernel+bounces-395931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D68B9BC519
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CBF281661
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB2F20012E;
	Tue,  5 Nov 2024 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDUfXjGq"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182681FE103
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786135; cv=none; b=L/Ro9n67DuS6ZkXkjX5oNM0umnaSVKVjFoVSMvSG8OY0AyNo9xCW3ml+GePxTGO3EAjtI8kFCFoDr1YbQC3Gcdrg3/47m+whXyK5oVOoxJHqHhyyVCnv3CY+gTOE6jegL9yYxLWgd64mTOxfxGdx4DHhlxEYOVjlpnpqM2KIm1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786135; c=relaxed/simple;
	bh=6XQX9Sx9O8QzEK8Jv5n+XhTDT5cZkdFl3LWcOJ7R3do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYjoU6mQjD3dALtWBQ0xC/oGk27VxkKeybuSygjem7hhAfEZUWi3YyDgMGqIgHzl0yD9JimCp705ao0MCXB5haU1Fag1jye+/XAsYi4U7wIRE22+J4LdpmH6HVGFtK4GebOANzoRY6RBrjU8MBGlcOk1mESqzCKuhvyUikn8CC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDUfXjGq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso812488266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786130; x=1731390930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0RiCycJ8lXHIHnZIr/OA9nJnBnXFkGlTbDFIlYLTM8=;
        b=WDUfXjGqFJDWGE6iB5JyGAqN/gafQAeHfo7qJDTQKijH0ja75GM5ny249uzryIe/7p
         fVXZSpE/n/yV64ygY5nvPFv/1kdd8W+OveotrYFZ8fxzl4yTJqdruXdGoLlYygxpJPlu
         nqGANT5vBXfIwCYIsIvFASGYjQ3CYsj7s/97V83HVdpQrc2FtcR0R3FdescDNkkfKl1Q
         P0vSfbGbMilujV6vIXGoQm2WnhOEDCtDaaML8yLDx8yIYZ5qeNveqZDgWrhkrH2kBhgi
         3173A4x0l9s2ycO0Tfx0it4ikp8LaZtZjXYceZSALrfyxz+NocPhUSOfq2rhrCMd8Qdz
         NgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786130; x=1731390930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0RiCycJ8lXHIHnZIr/OA9nJnBnXFkGlTbDFIlYLTM8=;
        b=iFCabHH/kyq20c6PRlypUG6WEOfa1BxVXHmmFFtrv3rU8QL0QX1AnjAylxemWHj5VE
         HCbxVGSqhqx6K05rgkNqO4Ms3WtYtyyhy1U3l9GFbGpWfNuCLgIiNw+7DGxw6InBgY2Y
         YVUEtisFTqZ/FrpDg2eI+nlEUYAFNHQKR3uWNOH6MjOhKgV9rr6WLU7UZhvY5CXVbIib
         itZPfJoo5Eyt/nZk1HHgunzoxm5eHRMclvsosPmKYUjlXktWP0ZHtR92QTeqvsk9IOYb
         22a3anjTt0mugyAEQIMmr0YZqti9bzodDd3IIaf7hDFPeKqjRp3bxGZjO5iZ3CATiLDM
         of9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoBUCmXFT9sb8EWctfCNHx8MOoK4/nbWcn5mCBvNdNuVE6fQt+6QywYCFNvbXtgK/Aqc7royFxpOZwn6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq1qmmERvTDehjNxPbqtMAmeRd/hVCfo84zaMieH9TmoNUi7Cc
	WGIHC7Cd4/VBixK0pHrBQsuQPkZXGOGKrUWVeHqBL1HY1Timxl88+ZGEJA==
X-Google-Smtp-Source: AGHT+IF+WdaU4acMcLDkkvrn0a+HllwkOyKrrBr64zT41an7zVt18JWmHU3XpQmoxtYI6RY6OSzjOA==
X-Received: by 2002:a17:907:7da3:b0:a8d:6648:813f with SMTP id a640c23a62f3a-a9de5d6ed87mr3251989966b.3.1730786128533;
        Mon, 04 Nov 2024 21:55:28 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb181451bsm78775466b.201.2024.11.04.21.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:55:28 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 02/16] staging: rtl8723bs: Remove function pointer set_channel_handler
Date: Tue,  5 Nov 2024 06:54:49 +0100
Message-ID: <dbaabf4706ab222b5e43d37b405e9d374ed5f49a.1730749680.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer set_channel_handler and use PHY_SwChnl8723B
directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 3 +--
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 1 -
 drivers/staging/rtl8723bs/include/hal_intf.h      | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 397fd8fb3cb0..aaadd56b7d8a 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -274,8 +274,7 @@ void rtw_hal_write_rfreg(struct adapter *padapter, u32 eRFPath, u32 RegAddr, u32
 
 void rtw_hal_set_chan(struct adapter *padapter, u8 channel)
 {
-	if (padapter->HalFunc.set_channel_handler)
-		padapter->HalFunc.set_channel_handler(padapter, channel);
+	PHY_SwChnl8723B(padapter, channel);
 }
 
 void rtw_hal_set_chnl_bw(struct adapter *padapter, u8 channel,
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 20c8459cd6d2..615a33cad84a 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1744,7 +1744,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->set_channel_handler = &PHY_SwChnl8723B;
 	pHalFunc->set_chnl_bw_handler = &PHY_SetSwChnlBWMode8723B;
 
 	pHalFunc->set_tx_power_level_handler = &PHY_SetTxPowerLevel8723B;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index e882877436c4..9e6414319608 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,7 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	void (*set_channel_handler)(struct adapter *padapter, u8 channel);
 	void (*set_chnl_bw_handler)(struct adapter *padapter, u8 channel, enum channel_width Bandwidth, u8 Offset40, u8 Offset80);
 
 	void (*set_tx_power_level_handler)(struct adapter *padapter, u8 channel);
-- 
2.43.0


