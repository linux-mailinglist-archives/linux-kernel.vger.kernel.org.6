Return-Path: <linux-kernel+bounces-352144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D387D991AAE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534B31F22182
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D7117C9A0;
	Sat,  5 Oct 2024 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyK/DeO4"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E0C172767
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728160497; cv=none; b=tWPDA8u/BPOmmrkbdrWbLtjRD5xE3a4m8bZfQDeCiN12PJ60qQvV6vPie07JZfCfN5TWfZAgPu9urETBXUTKvtUg5TzLTbhfup81zQtrM02pAM+XKs7A/WOBGqsTJh8Qm/yAnmL/PTNnOQe8Tn7IbfzrLNDJVasGN0OjpU6Iybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728160497; c=relaxed/simple;
	bh=DzFsjrR8uTSsexoZFECYdKO5oEoK7H7WulDYsnWyGUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsKZTek9cJNINFoVmE3RIzYKM9fHFPLH8JSkKubKBhD8qDmcdC+OVUkUJR4FHmVjAS2Dy2+oVn8MtwjPCQhcTFtt/ShJfBc8RAIA+GaDnxavxNtPVJ/d25IzWg6oExE0Gks61tMZPMYKxl/hKrn9pe/bCLzup5aaRaCpM5XcP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyK/DeO4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso19279735e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728160494; x=1728765294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0q9mc5Vxi135rYPqQgMHuHAkwJUcyR7fvEbuN9Uzyy8=;
        b=NyK/DeO4cTPImL7MBCY2ZKcnOdzPT+kcJg6A6/xfOmJ//7GCcBUCAzbkuhZyZXh5fb
         MlBye02rILioD/4eTFDjYpLn5C4XNno03afvp4JGga7W85Ww9Eu7qqqh8ancS1YuzRGU
         Y7Gew5hFbIN3TMz2Hg9cTdCbJm0qk4ZPM/YSPBx0n3PyxN6Q8V3bgG6XnY83e2mIYPQE
         72u38eu7CyO+YQc5uZrXQ/U+ECgThA3ken9GZVi/MczyD4+vPpMTEHGJx1dvzd8LUHrP
         36pbgbd30guZtJKco7FCL0xMjhVO0YaKoMeL28yuq8H5WVckhc/0a1FvGghMS+x0DwYz
         +gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728160494; x=1728765294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0q9mc5Vxi135rYPqQgMHuHAkwJUcyR7fvEbuN9Uzyy8=;
        b=g406x9W52t8qyoCZNLfkwxeWu60JwhMzGc6kraptaB88PYBRl93DrMy3R+4uQSLWqm
         LUc90um+K43rbZeCHCavOOxwDk7S9izrGVfJJlBrenPj1AkhBDSnnXJl7e9kWiZX/52v
         O+UoTVjuvjryOz28teqtTmJrXKcqyi9fyu3Bb7Yf2g+wLetiE9bqi/QzZCKuDZ9XlgZB
         Faohfrt2lC6SFrCLOs36GSIXi2KLtDZBwfwHiqU7dsR11dlDsN6jDJ8KbT2HrL3UHay/
         npbSl1RDUFWN5L4SNm/QfXM5h8dUwlr9m4BCBtuYjyD3QwujfvJx1dVa9qvITHktfhUz
         n0Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXbvzMVV7i3Qmq61n3/+N3iSQoqctHx70keop+FBLpkTwSsg6fRzDzYNRjvuLdTIBq/KJtFPXBQpD2Aa1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyej02+P/cSuOD9jRjkNWBYJyeyOaqpDZgQpSjneY/DeqVsoA5C
	Z1i33eZLu0RS7eb8kLAOvgFHHysvstsr6OQ9NEUXW3a+8lGhvYsbhgBXUBxH
X-Google-Smtp-Source: AGHT+IFb4ZE3CnE17gYQ6TuhVGEqEVW9uNilRK7jmt409cBGqXE8EHg7yYucFhBpiBjNuLlIk9TuDQ==
X-Received: by 2002:a05:600c:1d1c:b0:42c:b697:a62c with SMTP id 5b1f17b1804b1-42f7df1cffbmr71784345e9.5.1728160494059;
        Sat, 05 Oct 2024 13:34:54 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f85995932sm41824805e9.0.2024.10.05.13.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 13:34:53 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 11/15] staging: rtl8723bs: Remove function pointer init_default_value
Date: Sat,  5 Oct 2024 22:33:54 +0200
Message-ID: <d0bb58235d54d1c7e4806c5ea3a50dbf77c293e7.1727966761.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer init_default_value and use
rtl8723bs_init_default_value directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 3 +--
 drivers/staging/rtl8723bs/hal/sdio_halinit.c      | 3 +--
 drivers/staging/rtl8723bs/include/hal_intf.h      | 2 --
 drivers/staging/rtl8723bs/include/rtl8723b_recv.h | 1 +
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 8c80e0735840..bcbc9ea78951 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -26,8 +26,7 @@ void rtw_hal_read_chip_version(struct adapter *padapter)
 
 void rtw_hal_def_value_init(struct adapter *padapter)
 {
-	if (padapter->HalFunc.init_default_value)
-		padapter->HalFunc.init_default_value(padapter);
+	rtl8723bs_init_default_value(padapter);
 }
 
 void rtw_hal_free_data(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 52cd980c2003..236effa5c96e 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -937,7 +937,7 @@ u32 rtl8723bs_hal_deinit(struct adapter *padapter)
 	return _SUCCESS;
 }
 
-static void rtl8723bs_init_default_value(struct adapter *padapter)
+void rtl8723bs_init_default_value(struct adapter *padapter)
 {
 	struct hal_com_data *pHalData;
 
@@ -1259,7 +1259,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->init_default_value = &rtl8723bs_init_default_value;
 	pHalFunc->intf_chip_configure = &rtl8723bs_interface_configure;
 	pHalFunc->read_adapter_info = &ReadAdapterInfo8723BS;
 
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 9b0e9c0bf020..357b41894cf1 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,8 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	void (*init_default_value)(struct adapter *padapter);
-
 	void (*intf_chip_configure)(struct adapter *padapter);
 
 	void (*read_adapter_info)(struct adapter *padapter);
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_recv.h b/drivers/staging/rtl8723bs/include/rtl8723b_recv.h
index 040c9af06eee..69b5a7df32ad 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_recv.h
@@ -88,5 +88,6 @@ void rtl8723b_query_rx_phy_status(union recv_frame *prframe, struct phy_stat *pp
 void rtl8723b_process_phy_info(struct adapter *padapter, void *prframe);
 
 void rtl8723b_read_chip_version(struct adapter *padapter);
+void rtl8723bs_init_default_value(struct adapter *padapter);
 
 #endif
-- 
2.43.0


