Return-Path: <linux-kernel+bounces-329707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE4E9794D2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4A41C21423
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CE214265F;
	Sun, 15 Sep 2024 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWDc2r/W"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2598A13A89B
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382471; cv=none; b=bRGSJpAgukx9ENGRy5U5NTcrYFmGSpH9owRwNRd0ffA7keOjPP7K1JmVWNfuVucaLBYyDwbRVao3NOo6w2szHbFVLhPie47i+CYVy7coOBZfxF7liNcYcleQiwD2Ke6W5jEWzMAMR8+stRf5X4FTcAYYnQPMzPSNAF5nTFeU0qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382471; c=relaxed/simple;
	bh=QpT6Z8LG2nnF3VrkVUtoHOFioALPi1x81TYXKQYmhc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AogheXJqnCXyPDrCBh2pPVJ92YxT9z/4F1tlGoTfjyGFXiNGfCwDM8ETgBG3f63ZCmdO5ZTtiDGoyZo1jyg1L8at+Jfea8RrgNkoD73ktzsDNy1k1vz/yRQ0MCZrLdUc8dDTo0b8B0VwLppUsRXr9zYNds8MSJ9thkDTaZE3d+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWDc2r/W; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c25554ec1eso4249321a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382467; x=1726987267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/90mJY5TiZ73bUY9rQirJjWNfRoCE6FwinjarxUBu4Q=;
        b=gWDc2r/WO64PsmOTTJDXNqDNJ5nUUJ7K4w0ovQrsWpwGTU7KswVqCI3wHcG1xksiGC
         FRu/jwfQzcubVhqLRbFX9pPmvGWjg2e1Ht2QiYy4x80f1UpJWIsvY6tQsSH1LiXj3vhP
         7v7OdoNBJxkKrF1J7q7h5VXO9jkau63qoo6dJvG9mUt9qvdRTcT3oT1om+kegvs5Z8B5
         t8zXOkTdiQaROLqXJnG++WBqUEyCykPm5yJ+dY/gr8Np+Cq5X8FDrfJjGlMQvSNRX2hB
         FzPTdT5hxcWcb6fCWNNB9xjmVLDb6TeizgEDSU+WJl777LA/0QmqTb2i/N2lbsJFWf7M
         PnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382467; x=1726987267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/90mJY5TiZ73bUY9rQirJjWNfRoCE6FwinjarxUBu4Q=;
        b=eq7i1OFLVwsZL/39/ZVvr6I3fIwMfryuCA80KqyT+k2y+6uzFCF1ZnGtvf75gSA+zV
         SGGZvMrrDmq1X90LX37KxzOaYmgRXV8tTrREAwvC3Mu1i/5oKW2/UJk7gUrLwK4jY4eK
         LDUiDYeixS99LtVknqMGwJArkVDgMTHrwCjaeDM/NVorVVtlVHOeIlwjapqvHoYMRnCD
         /Bt22XGxz0FE9qbftSv6HgVPqCK8wdJ/t6DdeU5SnebLmzeE3Kodo+PankeOK3EedV63
         8p2Va/WKN+v32BrQAqdes0oLB7pgLY33CpVBnoSm94VLIPNhBlHdUTrQx1NCEfoJpErK
         oe4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDCRsSQ8boOMUBpiaHD5QpQzwQ+mbhkzQHUIzz3hYGr1iGLBMPfI+OZnvfPmlnDgcwU+E52UA8oSaW9uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YweOmaQa4SFbKuXLc1cBnhpEJYfI+SUGfRU4os+NMjCnnzmdbFy
	+9q0vzoGPdfitCrARQ7O7r/XJK5IkYMUrgjkyoyoAkJnMsZ8HsQl
X-Google-Smtp-Source: AGHT+IE7qy7IyLD8O8OlyKzAvBJ0r/MYWALYgMTCMFrbVAK7sVLqv7zVLKEWVr8PbnKrt1d2U/lWaQ==
X-Received: by 2002:a17:907:e2db:b0:a90:13b6:3ece with SMTP id a640c23a62f3a-a90294337cdmr1196603366b.15.1726382467335;
        Sat, 14 Sep 2024 23:41:07 -0700 (PDT)
Received: from kernel-710.speedport.ip (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm160201066b.8.2024.09.14.23.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:41:07 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 16/17] staging: rtl8723bs: Remove constant result macro get_iface_type
Date: Sun, 15 Sep 2024 08:38:30 +0200
Message-ID: <d382321bdd67fdce0ec2357920f67b5dd81ef426.1726339782.git.philipp.g.hortmann@gmail.com>
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

Remove macro get_iface_type that returns always false to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 3 +--
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  | 4 ----
 drivers/staging/rtl8723bs/include/drv_types.h | 1 -
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index bbdd5fce28a1..a6383f615686 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -4872,8 +4872,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 		/* set_link_timer(pmlmeext, DISCONNECT_TO); */
 	}
 
-	if (get_iface_type(padapter) == IFACE_PORT0)
-		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_CONNECT, 0);
+	rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_CONNECT, 0);
 }
 
 /* currently only adhoc mode will go here */
diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 6ddd73b9cb29..c60e179bb2e1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -452,10 +452,6 @@ void LPS_Enter(struct adapter *padapter, const char *msg)
 	if (n_assoc_iface != 1)
 		return;
 
-	/* Skip lps enter request for adapter not port0 */
-	if (get_iface_type(padapter) != IFACE_PORT0)
-		return;
-
 	if (!PS_RDY_CHECK(dvobj->padapters))
 		return;
 
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 2b12a2313707..57cbe2876838 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -182,7 +182,6 @@ struct registry_priv {
 
 #include <drv_types_sdio.h>
 
-#define get_iface_type(adapter) (IFACE_PORT0)
 #define GET_PRIMARY_ADAPTER(padapter) (((struct adapter *)padapter)->dvobj->if1)
 #define GET_IFACE_NUMS(padapter) (((struct adapter *)padapter)->dvobj->iface_nums)
 #define GET_ADAPTER(padapter, iface_id) (((struct adapter *)padapter)->dvobj->padapters[iface_id])
-- 
2.43.0


