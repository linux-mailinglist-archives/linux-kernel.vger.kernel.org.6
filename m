Return-Path: <linux-kernel+bounces-352147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2932991AB1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BC3283524
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED7617BEB2;
	Sat,  5 Oct 2024 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYvmig8J"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBB417B4FA
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728160499; cv=none; b=sXaR+rHsdx4GFbosOZSGYhtWWQBSGYuihvNxb7OsS7npSBrGsw/VqnzgcnxGdVLTfEoargVQ8j49UOut9M6SRaCKz/HfQmeX5iefBM4JEeKjeLraJq5vnDS7NQsu40H9sROE3lyMV+pD3dmvJhBll+i+EFaEoYKyuj6C7tqIdr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728160499; c=relaxed/simple;
	bh=EVBlHAuvsFXpnXq2JN7skn/v/lX4N53cicZaL5So/jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pduGZIe9RLD7l8nBxRw8TrBe9fWUOf9ZREYBTeD3g3qXUNgSLkcSlcOzOnUO+W3Bbf0yQVsnnWLzR1Mb/Dd/wc2frtkVT9fGfrVfwFHWMM1CiGkrb8LMSfEkt+u/5cLegs8AupAEicfnyAH+eBKQXig7DtnKgysUcqSBINURyqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYvmig8J; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cafda818aso31614935e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 13:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728160496; x=1728765296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSBQvkenhZ5S0EKj6cByYIpak2n0/Sv0jB8kQTzhNJ0=;
        b=bYvmig8J7f0vfLTS+46hP6noPed3BJDuk1eTwv752hNPzlOBhySWczSKkSC4wJAYkz
         r8V68+4eOEdruTaf9B5UgHr2+JkEX5Dr27hFJboLUClvtYgaPT1skyiVatOsNNrvp7Yo
         jvEganUs/HvmMk1xrZedXC3aguq9dycJ67KP2rL1p1eOYGPLscKI0A4VuQY9a27fW/5w
         LvkAyaPdAn17Yssx5wMKoW1UR1E7PeK/lj0kcTJ1M41d0y23yM1TXLU+BdTeL8LkWAdi
         BQJD8EkrrTtI5P9U/ZbCoDuOIPLJQeZlnTPQoqqP/+aJKbm3oCeZRHkYIW3m6rWC4BbI
         aTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728160496; x=1728765296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSBQvkenhZ5S0EKj6cByYIpak2n0/Sv0jB8kQTzhNJ0=;
        b=QdZaC2NchuQ2+1mWjk6Y32W56hlcCUE9JBeba4DNiDc8Oa8zgqL6dcevl7OmhQ0obG
         4nlho4hci/gR48zs1On1atUeF5/LtrG/KEaFWGdTCOi2gOUZkgwE5OkhMQ8HnwyKE9pt
         BWAvm0D0FcxvhBJNa/nAxO7AytyKMu/hxO2QjLVuEEAtUf6wZYrA7HDQSqwb7dRYfNrO
         gkDIxl2/PpNvCCgq77CIKuqs/3D7/pANDfVyRxNCkO8Avu1ptK/Zs/dsZlM6lYwY32RW
         Tlwj8AzPwAQLEgqVgdp787pkOUcysqHv3iyg6pEYsAXqPKQcJ5VGk4HNSSUtCnnYvGb5
         z3Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUdNbho8C4DlIMYii5dPQ6niWnWJ9A9kGpqrD2cmaVaz6jcu4+W/8jjZYP25NR0q0+alC2phdkbHfS8r7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrmlGCbevyWCmsMTrkpDiUGw/0shHA0XK1FR9C25ttLaH4hbrf
	JmZtwu6Q/DqBTRD0e+svG/2V8c+ewvuewR6MZxaLnDVGwu8L2hd2
X-Google-Smtp-Source: AGHT+IEPBX3otu02ikRIi1nWMy7nnlbW+ERjlGid6n1rVzN0v3C9gvy4mHIxK8EbqxHKBA98IDhdaw==
X-Received: by 2002:a05:600c:3150:b0:42f:75cd:2566 with SMTP id 5b1f17b1804b1-42f85a6d72fmr50211435e9.2.1728160495774;
        Sat, 05 Oct 2024 13:34:55 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f85995932sm41824805e9.0.2024.10.05.13.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 13:34:55 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 14/15] staging: rtl8723bs: Remove function pointer enable_interrupt
Date: Sat,  5 Oct 2024 22:33:57 +0200
Message-ID: <728827e155bdcd9951683e485d789d60bc203815.1727966761.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer enable_interrupt and use
EnableInterrupt8723BSdio directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c     | 3 +--
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 1 -
 drivers/staging/rtl8723bs/include/hal_intf.h | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index efc4b44caad3..716eefdf8ce2 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -146,8 +146,7 @@ void rtw_hal_set_odm_var(struct adapter *padapter, enum hal_odm_variable eVariab
 
 void rtw_hal_enable_interrupt(struct adapter *padapter)
 {
-	if (padapter->HalFunc.enable_interrupt)
-		padapter->HalFunc.enable_interrupt(padapter);
+	EnableInterrupt8723BSdio(padapter);
 }
 
 void rtw_hal_disable_interrupt(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index a6766a98042c..91aac5d1c23e 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1259,7 +1259,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->enable_interrupt = &EnableInterrupt8723BSdio;
 	pHalFunc->disable_interrupt = &DisableInterrupt8723BSdio;
 	pHalFunc->check_ips_status = &CheckIPSStatus;
 	pHalFunc->SetHwRegHandler = &SetHwReg8723BS;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index ed303a623e1b..3b35bc30ae37 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,7 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	void (*enable_interrupt)(struct adapter *padapter);
 	void (*disable_interrupt)(struct adapter *padapter);
 	u8 (*check_ips_status)(struct adapter *padapter);
 	void (*set_channel_handler)(struct adapter *padapter, u8 channel);
-- 
2.43.0


