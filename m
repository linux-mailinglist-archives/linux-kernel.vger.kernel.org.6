Return-Path: <linux-kernel+bounces-352137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FCE991AA6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89F2281227
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3748170A1C;
	Sat,  5 Oct 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhsNH5Ir"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AAF161901
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728160493; cv=none; b=ib9kbwR1OthPOtYGIm9TpDBnjIk7aBzJYRV280teEE0809JbDzAL+mkDEHji9lf2pMT2zyRtzHHf0CSkSFMdhxOO26CGd+yrrH7UO0xYnaqEr9IUyEnpEjarX6lfvc7ONpdT0i6e+/aeV7NQsVhFgnp+56r8arXSmrgS0HsC+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728160493; c=relaxed/simple;
	bh=6w4gp3GmSJn+oIpsBAPIJ/LWbaB+xt3M0uQbnYqnCog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ritnnEg7IPoAFBwmYPbZRNLWH+fGcOCdwLABTvIFmAfSucKJ3TDPYeF4NBN2DACHnUteD/PAWdFEQm7/WqNx+eas5JZ2myE6xoGQAMU+u3/EVY3Z8E/SnCFy8VNAeHYD0wg/s0stxZ55tVGmfzTECezm8LHFNrmNhRz86Gx6tTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhsNH5Ir; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so31677935e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 13:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728160490; x=1728765290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFpoihA3emnfB9/dxfqMbKVK7yB71LAzW+Wo8COlZSU=;
        b=XhsNH5Ir10+rvBOwHhUpIWtnxdTW69BQgxJ+fYkdTrFCafF6RPrDQoR8aYwI3r/Bz6
         NEq/aXvZW1x/bP++plqtFziY6ZlFtw+3NHR+MaMWdBpYLEFWFxG4UktCBCXgFk39qlXa
         sS/gWruatrwmqKsi4pq229MTJcIcUrAMfw4YVO04mz63Q3QyVRF52w4CpO635IHwka7g
         J6JK1+4m8MFTZXw3l+5S9Yj1S1UoUU1oBFKHtMtIZO+M0Ov8lL22bk5LZY/9ddRCU/zn
         Ta/73tv+sHQhQvveRysRcsigqmkw/VjiVtvSUWExLqStdSWMYWDIXuAllvYu4x6K4XUn
         QVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728160490; x=1728765290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFpoihA3emnfB9/dxfqMbKVK7yB71LAzW+Wo8COlZSU=;
        b=ny2Ysjf4t2W9qFMCH32XggnpVCRZzmWyuy+j84d392o7BGw/mQsVCMpncelvMQ2BPT
         knNjMMrK+5ihiKPXvDSdESQ4FzwLHvO4mSyt1qrToMK0STZ1QkpYsm57+8ukgV9so/Li
         dRFhUDThLTtepL2IAB/R2P2KXh5N27Jy+q9lNXE+f4cp6njsCWnZNnoQhyDmbXqDH1Mr
         Vapjz/baAKzl23oz7t6qEpb/m1U9MshoFuNjC3nFg+EmR+DGGqwW1SaSestmkzFhVaSo
         3w7MmTuVFxGxKO4XqSTWh3HKGtpEtSnL+RjOFMMcqlH+wNWBi2N/+Hi+mMnS/HRN4mW4
         luuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCtmBEwklM/XBi8svBdxyHFpoH40ZwI/AMsnBda8EuZA8HSEtKsuDmGionHIbsB17yVIvgdUfk9DKQrTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyimYSA+bZt1FJ7wdXM/Q9e9EIZKZ+OMUzj2dpusTnyaGCaCObR
	4zCOeglakB/yhAQmfeeoZZ+OHwqaT7sYPQqqOG5LaSVHYMTmZu6D
X-Google-Smtp-Source: AGHT+IG4jMAD2sUZ39zcTYHff6YUDHkQKynv+ec9fDPelc35Tsp+bFM137K1XrbLYH5xU54VPFzvfQ==
X-Received: by 2002:a05:600c:4fcc:b0:42c:ac9f:b528 with SMTP id 5b1f17b1804b1-42f85aefd2cmr42207465e9.35.1728160489622;
        Sat, 05 Oct 2024 13:34:49 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f85995932sm41824805e9.0.2024.10.05.13.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 13:34:49 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 04/15] staging: rtl8723bs: Remove function pointer init_xmit_priv
Date: Sat,  5 Oct 2024 22:33:47 +0200
Message-ID: <322d2412d89ae384365ec1d000bb0fc62128a261.1727966761.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer init_xmit_priv and use rtl8723bs_init_xmit_priv
directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c     | 4 +---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 1 -
 drivers/staging/rtl8723bs/include/hal_intf.h | 1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 983218cdbfec..1d1e4f438e7b 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -220,9 +220,7 @@ s32	rtw_hal_mgnt_xmit(struct adapter *padapter, struct xmit_frame *pmgntframe)
 
 s32	rtw_hal_init_xmit_priv(struct adapter *padapter)
 {
-	if (padapter->HalFunc.init_xmit_priv)
-		return padapter->HalFunc.init_xmit_priv(padapter);
-	return _FAIL;
+	return rtl8723bs_init_xmit_priv(padapter);
 }
 
 void rtw_hal_free_xmit_priv(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index d7941fdf42e1..55cf827fc255 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1259,7 +1259,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->init_xmit_priv = &rtl8723bs_init_xmit_priv;
 	pHalFunc->free_xmit_priv = &rtl8723bs_free_xmit_priv;
 
 	pHalFunc->init_recv_priv = &rtl8723bs_init_recv_priv;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index bc2696f23085..696a71c01bf9 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,7 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	s32	(*init_xmit_priv)(struct adapter *padapter);
 	void (*free_xmit_priv)(struct adapter *padapter);
 
 	s32	(*init_recv_priv)(struct adapter *padapter);
-- 
2.43.0


