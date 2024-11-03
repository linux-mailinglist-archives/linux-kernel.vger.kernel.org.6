Return-Path: <linux-kernel+bounces-393748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E9F9BA4A9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76DAF1C213D5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9951D189F5A;
	Sun,  3 Nov 2024 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORSnN5RP"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC122183CBE
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730621702; cv=none; b=KMivMjRrwuZ/miZW5Eex+nFQ3e5nt01kaYQWlStjIxtasVKzwXiN9/vM32PefWPiP+WaqJBTOuQr5AZW2NGkEgTw8FHF4LgkLEEyXZWJICe6n1NCAgGSTeM3OdMdTVRLG/mGMJVkYXTTCqYdxDJRVijXHimUJEhoA2wuToWupWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730621702; c=relaxed/simple;
	bh=u3S584myOAyZhc+GjEJWB++ki18Rk5KFE7Km+HtHP5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEeNC+tA6CUkMpF9U9mKbuMbaaNhFpso++XZZnfbRmi7GQStqDiiIzVCAoVLeMCybB2oPD37ZtUEpe0t+AqQp47ioMQ2zTJ261Sf8ZTlLNDCeFxtYNUPC6Wczvlm0gHSnTxkEKwH6/qZ/ID20+gWftCyy2yCuYSHjNh2fWsPqCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORSnN5RP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cec8c4e2f6so1339546a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730621699; x=1731226499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PO6/NrbVeY70kEhJHr00qbdaCGFc5cjzkA6rnNaB7TI=;
        b=ORSnN5RPa+VBkMdEs4oSRD/oTd/MAEoFoit3oZYPU/JlGMEXPg2JptHkm4/AfsV1zZ
         tgKoTh59Ep2aDvIWuKn6T7bSyKzuL1+6/8lZIFfu16zlSu72kbBNXCcjLkpN+7jRd2wx
         mrlf8drFJAeFit4/ka7VS2UagGKOhadbvGXiowsJE0L1YEISdkN7M5ukmPI1ZBU7A3Be
         dlq8wxjA23cacCRfGEpqBj3FSD+ylJSdfn5ETkag8JbPcBgpN0br+k3sYUfIn66zvnM/
         SL+InvjuJrY6mqf3YixzMVEh8/a8A8wV6YM5Wg6Yqmd7us5gXf4Rle+wx2VrMpWLRww/
         S2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730621699; x=1731226499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PO6/NrbVeY70kEhJHr00qbdaCGFc5cjzkA6rnNaB7TI=;
        b=at6ldvEs6uc07QzZQzrpVTKRGmvt635o/fCy6f8Sbwa1ckY4Zpxkqpa9/3sfhvKxkY
         f05QPMpjnQLlTORt4fq2C+UazCyIb83QjMCTt70AVfvwAFDjGEsd5l5WpHM2t0kT0UAA
         MjdIHyaQDIdteuXbfCg1I2dJ7ZT7B9jWjAyosUnaSHsqjANuDOfYxAvDybKCPm/M2aa1
         mW/a82ZCnfbpnJlsk8e4hAxYzwhqFrxoZ8EdfPNCze5FzoT7WF+LSM/k52WeeoSZIl5r
         WgLxpSSgYTiTfDJoDhKK9csZcJ15qoihmtd/ZXkAu3qr+LXfJbQ4ECfy6bK0bAe4Yv25
         nnFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq3+1nw45KS03bR9ILkiHXnsaj/f2CNEpATs7wkCZ4gWRpJCvDy3OEN3LlgKIOUFee8d+g+WEY1x/21Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxO3e7lWyYTJ0nqo12cNXmocMDFFPmqFT1Jg7nNuq7Ke4ApSYd
	A5btTlv59ItUKO797P+0mhVmpUfpFSc1SGRjN2j6lQ2TCgOVHNDo
X-Google-Smtp-Source: AGHT+IHQKaD9j1aO4FHVRnQgsf6wIR7yxAUzxJrwvhoJYvojcAlIiW546/x5OofagafKml4hlZyUkQ==
X-Received: by 2002:a05:6402:1e92:b0:5ce:d03f:68ad with SMTP id 4fb4d7f45d1cf-5ced03f6926mr1520321a12.9.1730621699020;
        Sun, 03 Nov 2024 01:14:59 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac789152sm3097882a12.43.2024.11.03.01.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 01:14:58 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 12/13] staging: rtl8723bs: Remove function pointer mgnt_xmit
Date: Sun,  3 Nov 2024 09:14:33 +0100
Message-ID: <59988d60701a6f83a6a83b6c813e58c4484c7d3e.1730619982.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730619982.git.philipp.g.hortmann@gmail.com>
References: <cover.1730619982.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove function pointer mgnt_xmit and use rtl8723bs_mgnt_xmit directly to
increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c     | 6 +-----
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 1 -
 drivers/staging/rtl8723bs/include/hal_intf.h | 4 ----
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 914d4b24d49d..7462b10fdc94 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -170,8 +170,6 @@ s32	rtw_hal_xmit(struct adapter *padapter, struct xmit_frame *pxmitframe)
  */
 s32	rtw_hal_mgnt_xmit(struct adapter *padapter, struct xmit_frame *pmgntframe)
 {
-	s32 ret = _FAIL;
-
 	update_mgntframe_attrib_addr(padapter, pmgntframe);
 	/* pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET; */
 	/* pwlanhdr = (struct rtw_ieee80211_hdr *)pframe; */
@@ -188,9 +186,7 @@ s32	rtw_hal_mgnt_xmit(struct adapter *padapter, struct xmit_frame *pmgntframe)
 		rtw_mgmt_xmitframe_coalesce(padapter, pmgntframe->pkt, pmgntframe);
 	}
 
-	if (padapter->HalFunc.mgnt_xmit)
-		ret = padapter->HalFunc.mgnt_xmit(padapter, pmgntframe);
-	return ret;
+	return rtl8723bs_mgnt_xmit(padapter, pmgntframe);
 }
 
 s32	rtw_hal_init_xmit_priv(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 563ebf8e7fdb..20dbaa995498 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1258,6 +1258,5 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->mgnt_xmit = &rtl8723bs_mgnt_xmit;
 	pHalFunc->hal_xmitframe_enqueue = &rtl8723bs_hal_xmitframe_enqueue;
 }
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index dfb973018e4e..697e22d1e535 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -180,10 +180,6 @@ struct hal_ops {
 	void (*run_thread)(struct adapter *padapter);
 	void (*cancel_thread)(struct adapter *padapter);
 
-	/*
-	 * mgnt_xmit should be implemented to run in interrupt context
-	 */
-	s32 (*mgnt_xmit)(struct adapter *padapter, struct xmit_frame *pmgntframe);
 	s32	(*hal_xmitframe_enqueue)(struct adapter *padapter, struct xmit_frame *pxmitframe);
 
 	u32 (*read_bbreg)(struct adapter *padapter, u32 RegAddr, u32 BitMask);
-- 
2.43.0


