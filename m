Return-Path: <linux-kernel+bounces-393737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517089BA49D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8386C1C20C8E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AD01632C6;
	Sun,  3 Nov 2024 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdvTciC7"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B75913AD1C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730621696; cv=none; b=YJDpQiEafCW6ei810wQWbumU2xfxz2B64bE6wB4hXGFDEmk/9Vu6777UYK7xCZtKtEKdH+n3I9QldpLwKSeFDsxWD0MbS5+29KsrG7HiywzaITNCeqVg8RHJ8zlCHcpSHLDVgu3eV9m++DGKtSGokW9nKhuaf1dh1oyYb20w+ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730621696; c=relaxed/simple;
	bh=qv7bUIiaq2d6hSz6mAsLCXekBE2vtahVMxlhVFAYAWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQg9aE3pIbH6AFw7FSJZ8IvMJ3oSlESe5CejoGLUqMbzAaa6zqoF/o/6fPWoSgkfMSQyhSzViGaqTjoXDXRAF14ur5JvBrE/f2uqeIe59+q6wTZLPgFL/2WJHkF//pSMBUMU4ao9naPkGURP1+yZyeO4j0yP59jOt66f8R05soI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdvTciC7; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so4719063a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 01:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730621693; x=1731226493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxXy904MrrPlMw4v+3cBS52GXFzaVx4wVG0zuSO1/wM=;
        b=IdvTciC77S4kB8rfi0QrD/24q/Vv5n4s6Qu/ifsLQXHM/XBu7pNCaMTL4gRMm0XJRL
         yEuQFSp3EKzUYI23drRbyd/1mJDV5ora/xSxLjy6f6T8LEEAl1vW7lfROmYgwy+vjTwT
         awZNjLZ00qoLfehWmeQ+DVpInG4kK9rl3azGkfxiPVZYI4EAUN+P14lae0SWd5UjsOkw
         NjcnpfQbqW2meUinhlRjBehKLXoyIPApSCt3x9S5Ghw7WpMTKhzFi4mkFAGLChR+FX9z
         HE3X5Qu8donNE6K09nucufAygBbrr5zHRq5aVK0tS8m36QsviLyEKxJoad43LwLqtvvq
         7T2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730621693; x=1731226493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxXy904MrrPlMw4v+3cBS52GXFzaVx4wVG0zuSO1/wM=;
        b=orvtPsTnv9KYWWbX1502+MWqpBWbUX58RHOvFRhctxyg3TR9h6+hUjKuCoxbJpGjdE
         SOfzXh90HzTNFhEJq74N4KeTo8jf6Z/PpQhERvjyhDVCOQTyx6RQcuFpsUVBQFEXvTty
         LcBu15Dm2sF795hHzOpv7yhqC864rtZa6NEFcO5k2fIByravCAPtDLnEWMyohdMtIQsA
         VpdenveigOCIzcgKrxHiJZA3ut6u1KNoEBqzriNqj+qO39DTfw8wBscJlvFb8mC65NA6
         mJh9o/71JC0zgXUy/WpdH2d103a8xn+4JsHpxt6bReOE4GKw1PKN+9zIfBwFlZN5TCDL
         H8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIawTOyw+sTQcOitVM4HFGAuLLqvDDXcq0JG9HE+X2UC+4z5TjH3YIakCmSm/VLAJtt+oWWcwJbzAQfbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsgZTsRWsnlmeA+dqvyh0qlDH2/ldRPtDYjeriDc+onAYqBunn
	XEUqcoFJDozqvf4/jrDZ1Bydr3UWXXitcsKXNyEvBcQYVkqrkfcn
X-Google-Smtp-Source: AGHT+IF4nZRc+yG/Id2cJXxcIpm90HTJ+ULR7N6gzEr5j8Dy5NfJSFtPsiTljl4GcW76fwZlRV2gCg==
X-Received: by 2002:a17:907:7e8c:b0:a9a:29a9:70bb with SMTP id a640c23a62f3a-a9e3a59d563mr1707138366b.14.1730621692286;
        Sun, 03 Nov 2024 01:14:52 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac789152sm3097882a12.43.2024.11.03.01.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 01:14:51 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 01/13] staging: rtl8723bs: Replace function thread_enter
Date: Sun,  3 Nov 2024 09:14:22 +0100
Message-ID: <6946fae41575fffff1d4718cb3a96cd53f655416.1730619982.git.philipp.g.hortmann@gmail.com>
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

Replace function thread_enter with its only called function allow_signal
to increase readability. Remove resulting unused local variable
thread_name as well.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c          | 2 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c         | 2 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c    | 4 +---
 drivers/staging/rtl8723bs/include/osdep_service.h | 5 -----
 4 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 68b5d8ca900f..64ce33c6fba1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -382,7 +382,7 @@ int rtw_cmd_thread(void *context)
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 	struct drvextra_cmd_parm *extra_parm = NULL;
 
-	thread_enter("RTW_CMD_THREAD");
+	allow_signal(SIGTERM);
 
 	pcmdbuf = pcmdpriv->cmd_buf;
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 3e88f14e3bf7..699cff7b0ac9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -2489,7 +2489,7 @@ int rtw_xmit_thread(void *context)
 	err = _SUCCESS;
 	padapter = context;
 
-	thread_enter("RTW_XMIT_THREAD");
+	allow_signal(SIGTERM);
 
 	do {
 		err = rtw_hal_xmit_thread_handler(padapter);
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index 78298e63edce..5dc1c12fe03e 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -411,14 +411,12 @@ int rtl8723bs_xmit_thread(void *context)
 	s32 ret;
 	struct adapter *padapter;
 	struct xmit_priv *pxmitpriv;
-	u8 thread_name[20];
 
 	ret = _SUCCESS;
 	padapter = context;
 	pxmitpriv = &padapter->xmitpriv;
 
-	rtw_sprintf(thread_name, 20, "RTWHALXT-%s", ADPT_ARG(padapter));
-	thread_enter(thread_name);
+	allow_signal(SIGTERM);
 
 	do {
 		ret = rtl8723bs_xmit_handler(padapter);
diff --git a/drivers/staging/rtl8723bs/include/osdep_service.h b/drivers/staging/rtl8723bs/include/osdep_service.h
index b21267d7ef72..8b1634f4091e 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service.h
@@ -73,11 +73,6 @@ int _rtw_netif_rx(struct net_device *ndev, struct sk_buff *skb);
 
 extern void _rtw_init_queue(struct __queue	*pqueue);
 
-static inline void thread_enter(char *name)
-{
-	allow_signal(SIGTERM);
-}
-
 static inline void flush_signals_thread(void)
 {
 	if (signal_pending(current))
-- 
2.43.0


