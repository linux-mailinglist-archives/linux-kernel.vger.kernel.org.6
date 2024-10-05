Return-Path: <linux-kernel+bounces-352141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C5A991AAA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F7A1F22F21
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9D2178397;
	Sat,  5 Oct 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKf59Pl7"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF216C6B7
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728160495; cv=none; b=edUVU+FRajHDkJzsoNINI/+wIvOgMi82torRt/I85g26fanhiliYA7+VNhIyGLgG1xjMNwbwf6mc/pKo/7dGjXKrtpGXqgFIfLaDMgEylXdMrGtrh9GJGQv2Tfx0OLGyaFgkB1GItkZSNR7YfzisnkggnfpMvwetGbVdkNC7KZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728160495; c=relaxed/simple;
	bh=gLrtsrqCpd7Z8WUHzQfpHBMi9NhWsyCtmyG6Pga2PJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvRCwq4IEwN9IghjXWEaiJj3e/0t9kOCR5s1WPFTwJdLNYGF5wIo8QeQyihaD+q3Z3bO9ZuWjEbA0z2X/+PZs0s0lSHxUm0q7JsNtJrpBZJnCfMlJCbdyU2ZP/ptnA4eQToDbSY0VB9olD/kV1lnokArH+QyfNJdLz0mEqY2YZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKf59Pl7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so26667935e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 13:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728160491; x=1728765291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRjXbGvt01b/G8SRxpi+wLxDhteB86SUXqAlnJOcBUM=;
        b=aKf59Pl7utMopO0yZYZKxOzPABFSAkRP4nmaRRiVYtlEiestaMYTSMD0HrOxcru4We
         BqtwQ0AX5PaTLQ8GT7GL+Xj9v6dNpfrpwlFHrzj1H0rfj2JWSuHBRoZJv1llGcelMl/j
         MeKOl8IzuI0gIMtJ/mYXt8qOc9SWGogqHC9stRfrmoPshZjuIQmtMkoAS4vKJ+afRUvt
         izfQvLalskQRUUiTZo5Q2YATIagG69TUfdwnTxl66lUdN/y06UapUGhz4TyIrVGpnTSS
         p+MnNy+Zs/SKKZCacd9l+6VKYYGKOQkn0ARTLrl6QXCqzuhzHlm+MYUfnbY8lvQSjcXq
         WVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728160491; x=1728765291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRjXbGvt01b/G8SRxpi+wLxDhteB86SUXqAlnJOcBUM=;
        b=HiMossXEiOI5ey5YulAccV1m9/m965VzwyFGRCSbtDLf01YksGRMb5EexdYF+SVG8r
         IY+3cokfPjrp3mPgy/2g+4PefZ8opnfl9RhdpriiZDQqPvDB9kUPT8kktH1IyWEhxzm1
         hAPtnLyGFUIKtfXGB2DnohD/1lZX9EJhf1hR99FZc0566DXX4y8u/aTO5LLGMhckeT8m
         /wqFg74SNX0PJ4kj4BkSWoUSwSRnUdjaoSRnj30jJqBNNRmJmbqMyjWX6smnfieqBH6S
         dFnQ+YvBcCKjYqSUnBiieb7G/GEj4Jo+a7jKB3hZKMigNXETesEPHXSi0mt5W0JxJm+O
         TROQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQH73sLWWnL9TFiAly8pKgnFB5HY7pgYuCugIGU6ULCdB7WNwVzeBv4CJ0cTJeyw1vX8lYgfJlsIZWI8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpjgcNIhiKl0ORFuulvGyzy+kOFlnmPCO1EWAF9bQX2QW1nh7m
	U9OLNFNFpxGBNqg5b8UbxtmcHiC3vlbFf7O9+SRrd/tyyB3C4N6V
X-Google-Smtp-Source: AGHT+IF0GyjFxjdin35AL8y+oEfcO9zmoloAem5RPoQ0Rp8dpbaN/OjTJGjHYf+nj+00PjYscEaD1A==
X-Received: by 2002:a05:600c:3b2a:b0:42f:8267:69e6 with SMTP id 5b1f17b1804b1-42f85aa3344mr46591255e9.3.1728160490942;
        Sat, 05 Oct 2024 13:34:50 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f85995932sm41824805e9.0.2024.10.05.13.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 13:34:50 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 06/15] staging: rtl8723bs: Remove function pointer init_recv_priv
Date: Sat,  5 Oct 2024 22:33:49 +0200
Message-ID: <d9576e47920b045d702069fd3167e38d889412e7.1727966761.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer init_recv_priv and use rtl8723bs_init_recv_priv
directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c     | 5 +----
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 1 -
 drivers/staging/rtl8723bs/include/hal_intf.h | 1 -
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index bbead941289d..d571bf81ab2b 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -230,10 +230,7 @@ void rtw_hal_free_xmit_priv(struct adapter *padapter)
 
 s32	rtw_hal_init_recv_priv(struct adapter *padapter)
 {
-	if (padapter->HalFunc.init_recv_priv)
-		return padapter->HalFunc.init_recv_priv(padapter);
-
-	return _FAIL;
+	return rtl8723bs_init_recv_priv(padapter);
 }
 
 void rtw_hal_free_recv_priv(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index ef70ada68f2c..8d2a44726fc7 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1259,7 +1259,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->init_recv_priv = &rtl8723bs_init_recv_priv;
 	pHalFunc->free_recv_priv = &rtl8723bs_free_recv_priv;
 
 	pHalFunc->init_default_value = &rtl8723bs_init_default_value;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 0782a13074d7..cc01b8d56498 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,7 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	s32	(*init_recv_priv)(struct adapter *padapter);
 	void (*free_recv_priv)(struct adapter *padapter);
 
 	void (*dm_init)(struct adapter *padapter);
-- 
2.43.0


