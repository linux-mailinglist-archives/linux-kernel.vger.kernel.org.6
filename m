Return-Path: <linux-kernel+bounces-352136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A86991AA5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE24AB217CC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8A716F271;
	Sat,  5 Oct 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeNqFdyc"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B00715B992
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728160492; cv=none; b=od2PCv3990/agNSCuK7ofijGUTnKVIAJXGuAKYAFM8IcT5i7GfQfl5zhk7G20GH/bijumSCqtu+tRBd9i2Qmz3JOtlkbC9Ij0u5etB+emQOLVbVwmXEGIKioawrFYqEB+94arih9sRhAFlOpIVGSllc53JrjDVwIdYJMQFFfPVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728160492; c=relaxed/simple;
	bh=Xlmrw1ICSZSLpyppc3P1wO9DsXKMAXudZrtMHiaVX5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOUoXgSvhXfF7OP4WcOfKGUGxy7OrMcBdmbXGcSZkE7pt5oItxrNbqxuei8/nouEUdIwF8eO4/JtAQcg1iBsmCOLf7VIGimiQRN0AKeIFDNQVeHtj95Hgj6PrRCaFiYTt3bXEBrrLHO+fiBiRRPiNVDT5+AzZSBoP1OlZnfbbQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeNqFdyc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso31943525e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 13:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728160489; x=1728765289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqRwvqn5MMZIilIwb7m5L2Gv05WHBymSS5m9I5855dI=;
        b=GeNqFdycZoot+0OiijC2XWp7Wgf2xlByOeV0wplqFrHvsphieWV3ZEmEijq8+mPXGJ
         W2RpcbrFw8S6JVj93dJzrxkS1KcMeKANE9+eav3FBi6kA7FWb9kjftR/WpZh9kfSAB+6
         FSc0ZsSE1wog73w6flyCqicjgVIZJnr9YfnYZj8t1UEdUdj2UnjeB6+s2/TwX8f02fXR
         h9J3mZHu9oLAYf1ZC98qYEXEQ+Ens3gBmbbX4/MBMnhhnF3bS2cDXkqyWG+MjT4hTqIr
         HyuXINbRsseWPoe11kjBXz0vN0XelqHic/3QX9BRRwSWgnwanKEi7FSxagJoMFVo8DyR
         KMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728160489; x=1728765289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqRwvqn5MMZIilIwb7m5L2Gv05WHBymSS5m9I5855dI=;
        b=MI/yBNsN8pnV6bcGTIQZyeGlduj7605TyOyDogAbfiqQYKjM+a1WgCpeMw6hHSNCYM
         eucGy1C4Xi8Yj/UYjE7tgn6MokVIX7AhL4jSocDlnr48b7XBuORsL9C+Dvs1+fQZCdOC
         Bdv1ixlcco+89c69TiJJm9qYjQ0zh4x441Owvy0WAL38zaWZ6elp4Yf6YY2IPK/Rpvn9
         yuyyrruZAxrMCreldFbp30bCaBLBw2wmF6Pgcrow7+GKWZtQIaDAl63lKVr0OGkHZKvU
         qdZmlTzagzi34AU9GddQJoxiFrfgCkmDUhAUZsOd8kZpOKoQfAK8ZIkAb1VfBIkvNC2R
         A6Qg==
X-Forwarded-Encrypted: i=1; AJvYcCV1SJNJdLryp8jgtkXBx8INOpYbqfrOdwUAYN4sLaxSWHuhdWYt+2wnCwGWyA1gCdlUzicG0b2BCv2IIbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyK+jpC4vxIK4JdMx4P7vQLxCDbAyjLov7Bk/0+KNqyS4wMoYV
	AR9gp6NlKarD6Zqx9p7e8wXFe6QZFVkfCBlVh38iCAjAZx09sk1yQBCRzS0q
X-Google-Smtp-Source: AGHT+IE9xG3NaWlIuTacg005sDJLyBO3bfMPTr7DCrgTYFT5Ui7ARWgCZ3y9M0L7BfUgJEzvAjwmbA==
X-Received: by 2002:a05:600c:5116:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-42f859ac1ccmr58124885e9.0.1728160489047;
        Sat, 05 Oct 2024 13:34:49 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f85995932sm41824805e9.0.2024.10.05.13.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 13:34:48 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 03/15] staging: rtl8723bs: Remove function pointer free_hal_data
Date: Sat,  5 Oct 2024 22:33:46 +0200
Message-ID: <455b7a4645e6652815020635a7b34e56c2b96423.1727966761.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727966761.git.philipp.g.hortmann@gmail.com>
References: <cover.1727966761.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove function pointer free_hal_data and function rtl8723b_free_hal_data
as it is dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 3 ---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 6 ------
 drivers/staging/rtl8723bs/include/hal_intf.h      | 2 --
 3 files changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index d9121e13fe69..983218cdbfec 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -35,9 +35,6 @@ void rtw_hal_free_data(struct adapter *padapter)
 {
 	/* free HAL Data */
 	rtw_hal_data_deinit(padapter);
-
-	if (padapter->HalFunc.free_hal_data)
-		padapter->HalFunc.free_hal_data(padapter);
 }
 
 void rtw_hal_dm_init(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 33ae1ae51a30..867021ed31bf 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -439,10 +439,6 @@ void rtl8723b_InitializeFirmwareVars(struct adapter *padapter)
 /* pHalData->H2CStopInsertQueue = false; */
 }
 
-static void rtl8723b_free_hal_data(struct adapter *padapter)
-{
-}
-
 /*  */
 /* 				Efuse related code */
 /*  */
@@ -1827,8 +1823,6 @@ static void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_l
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->free_hal_data = &rtl8723b_free_hal_data;
-
 	pHalFunc->dm_init = &rtl8723b_init_dm_priv;
 
 	pHalFunc->read_chip_version = &rtl8723b_read_chip_version;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 40383d3cdcef..bc2696f23085 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,8 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	void (*free_hal_data)(struct adapter *padapter);
-
 	s32	(*init_xmit_priv)(struct adapter *padapter);
 	void (*free_xmit_priv)(struct adapter *padapter);
 
-- 
2.43.0


