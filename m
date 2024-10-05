Return-Path: <linux-kernel+bounces-352134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55435991AA3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04C51F21FCC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF0B1662F4;
	Sat,  5 Oct 2024 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRlT3cwb"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF4D1581F9
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 20:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728160491; cv=none; b=EAvdRVUxQ23ZgCA+qiGNdfIKmGRwF69gaSQxDmTtXWxfV5d7LCYoVmgr1ddHJY2WZloB+U5DOzhy6i4Frf/7QZAcEM8Q51iUxJx3PqovdOLBO2N5RHWhPzn/k90hAEcK+WsMnaaZW60XiMxU0ShGJfu3Y8f8XaO+qMS4kXqBR0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728160491; c=relaxed/simple;
	bh=X9DHnhb3PcjWFlPozmUkt4LTX03S1xya3WRzJN0hsmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aH9eHr34+96Vxb0JToPzGGyp3qiZgcnAy87kGrmp7K9+/2GYY06gNcw2rku6c1oywRdeIbDGWCFHrAHMyVTkUL39WQfj8sXgnkXZyVpk181zhFswR09phjj9PPoIkEOqnxgI0/+bUK0LzAU2md/zA30he+AOymTyhQdHCrQl01w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRlT3cwb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so41609685e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 13:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728160488; x=1728765288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n45JSFh+Iunnvvyo7iSbLfdkXzJD1ATFvBRpOr0mHbo=;
        b=LRlT3cwbKzxHzZdrSgKBhtw8nZZW+nLMkUNzzwDLQ1SKDGCseltChz85na++vyL+Um
         P3WLnCE0wa1dgNl1OXl40yeQ/QfwcqDma+Uu1S8nCNrmFrR9W+ZMKqWd69qvGPHBB2U7
         Eit2hq0YoOnKiFv+vvsxtVNjvcgJrsvINr8EybWQHtxyHNQqYNPDXFsFKbYZSs+57QK6
         efeu4+Y6KG2n+ezK3mS9+AxszQW8O0npR8UwlIc7xr6C/UqC6+oz5440BM+f+jG3LRr2
         W5gtDfBsiLOg2bFhQ0w/liaUV3Ms9LpwT+78ssL2FI7vHUTY8NghKva3CZPolidoVQbo
         AzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728160488; x=1728765288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n45JSFh+Iunnvvyo7iSbLfdkXzJD1ATFvBRpOr0mHbo=;
        b=oNf+CyhJOSH2mQ4i4sOOPJrt4bXSj5cs5rDBPNyhTGz+Cgvb1aXwDksU/oMffaS1Ql
         ZNQ/MEseejpYFfm2RZ0PulXdoGxg3n4B0T5HDFp1c3qavhg+ndOSpeJEfAPfizwZCWG0
         jaP0t2cKXCOdLmvAPnZ0ek4cRlv5yM8AtKdkLf9dA3mfiYzuZbm9hTqgYZiFsLHNN4nA
         g3aicGzt1/kaCzBX8pV94DKmnqmc/FmQQaPvoqIQEzjBaCXwgP4yKmNweVypFvMTx3Fz
         lnTMixOpQ0gTHpq2etvlvqdLNWLET8mwOTWAE1+rmYy6pVndSG5bmwId81VCQuZlPne8
         4Elg==
X-Forwarded-Encrypted: i=1; AJvYcCXKwOegE5ctTLdK0OEuQu9TkPeBM66vRZgue4Wl43a8mVEIUhotMs7bvtbhqcJm05CKUPjSgRc8qNOrTvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh/7YAlPn0MCLstD/a4jtH1rhhMp39idSfWk9f0mkFBog+ECvM
	Gg0l9dZTl0JWLZaOaVDVgJ52jRdrsdaPz2UuW9vf3QI0bJbW8iviOSKuBelw
X-Google-Smtp-Source: AGHT+IE9+Wiqg7TlFmhDx2CKfX+QkqSK/VLv2J9Yzz7wRUqNgXo9P/u1Q9pxMjZl/rI6GPM7EW7u7A==
X-Received: by 2002:a05:600c:1f96:b0:42c:bbd5:727b with SMTP id 5b1f17b1804b1-42f85ae974emr69950985e9.25.1728160487765;
        Sat, 05 Oct 2024 13:34:47 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f85995932sm41824805e9.0.2024.10.05.13.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 13:34:47 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 01/15] staging: rtl8723bs: Remove function pointer hal_init
Date: Sat,  5 Oct 2024 22:33:44 +0200
Message-ID: <5c838981141aad1275cbcbe862ac7885de9bb8e9.1727966761.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer hal_init and use rtl8723bs_hal_init directly to
increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 2 +-
 drivers/staging/rtl8723bs/hal/sdio_halinit.c      | 3 +--
 drivers/staging/rtl8723bs/include/hal_intf.h      | 1 -
 drivers/staging/rtl8723bs/include/rtl8723b_xmit.h | 1 +
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index d675a5eeaddb..684d31360f4b 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -78,7 +78,7 @@ uint rtw_hal_init(struct adapter *padapter)
 	uint status;
 	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
 
-	status = padapter->HalFunc.hal_init(padapter);
+	status = rtl8723bs_hal_init(padapter);
 
 	if (status == _SUCCESS) {
 		rtw_hal_init_opmode(padapter);
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index c54d6dc1a495..b4819ff2928f 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -583,7 +583,7 @@ static bool HalDetectPwrDownMode(struct adapter *Adapter)
 	return pHalData->pwrdown;
 }	/*  HalDetectPwrDownMode */
 
-static u32 rtl8723bs_hal_init(struct adapter *padapter)
+u32 rtl8723bs_hal_init(struct adapter *padapter)
 {
 	s32 ret;
 	struct hal_com_data *pHalData;
@@ -1259,7 +1259,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->hal_init = &rtl8723bs_hal_init;
 	pHalFunc->hal_deinit = &rtl8723bs_hal_deinit;
 
 	pHalFunc->init_xmit_priv = &rtl8723bs_init_xmit_priv;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index d959be13fcf3..fc3a94e40721 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,7 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	u32 (*hal_init)(struct adapter *padapter);
 	u32 (*hal_deinit)(struct adapter *padapter);
 
 	void (*free_hal_data)(struct adapter *padapter);
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h b/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h
index ad2542d0cabe..5e3483cb22db 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h
@@ -405,6 +405,7 @@ struct txdesc_8723b {
 void rtl8723b_update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem);
 void rtl8723b_fill_fake_txdesc(struct adapter *padapter, u8 *pDesc, u32 BufferLen, u8 IsPsPoll, u8 IsBTQosNull, u8 bDataFrame);
 
+u32 rtl8723bs_hal_init(struct adapter *padapter);
 s32 rtl8723bs_init_xmit_priv(struct adapter *padapter);
 void rtl8723bs_free_xmit_priv(struct adapter *padapter);
 s32 rtl8723bs_hal_xmit(struct adapter *padapter, struct xmit_frame *pxmitframe);
-- 
2.43.0


