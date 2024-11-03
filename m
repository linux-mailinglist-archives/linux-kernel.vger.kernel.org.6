Return-Path: <linux-kernel+bounces-393746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E4F9BA4A6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2311F21B6C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8E617A92F;
	Sun,  3 Nov 2024 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgpJs8Y3"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35184176AA1
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730621702; cv=none; b=poKyRbxueNEC/z5IndaqUKaeTbDzssMvHzYu7I9PjRL/WPSfAcAw78lgaSFDeeeAptUvfHUsJwsZENDIhQuTGQPPIYHPrkANZHVcAoW/kx1hh4vy9JTyz+Rs//IJhzPySlP+MfCz5z6ngJsf//qSmxzAGN3pj0XyqR/4y0QlYx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730621702; c=relaxed/simple;
	bh=ZUHmg1t1sdjL0rwN8lgvvUeLmAvJpXjUgQkUh98C/dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=as+WEOfKYdXa3Ie6d2H+DwqdlmTScCr88StTPk2EEe8qq+dKovqy7YmaErd+xVQm6XGb8VuWUcmOEbIg3nwZClAjyj/wKvSZ/F6UVMfoss6TuWWTQqZmAazgZUTLpliws9msXBRg8jwUnZXX0P9SzQdfNm/3bOnFBcZgFVLRRmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgpJs8Y3; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso4101920a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730621698; x=1731226498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yutS8FymNTV5ezMq6BbpbrCC9fB498yl7otFEg03rmA=;
        b=VgpJs8Y3jyKQz9oV+Tiv/Vk2Ij6q0593SLDVHNs+mhDpcHCYzSD2wML9rfL7wCYbq9
         aLyyReFRRF9odb9AECu7dbDnnHsuC9R4yTFhsiw06iPPIod3klRc6A1/o4qRkk8uZ2fy
         5KgFdCxxbnnJ7D5cwKQOWUNgyetWtXQmazidd/h6P/2dxNVKQ4s4gBUC0MRDcI1+/lo9
         Cx+lrBTwR3qDcALwwZeJ6pO7/AMb6veRlXsPv08CFYF42TK7xNwFdDd0ystjkv5IxL/A
         2t7Cx2GDaFUMmAO6YbrzGLIOOynO6LhVQwEm/sM8HGcscXGksLYwT/D/vIVF7h4cgb0f
         /sCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730621698; x=1731226498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yutS8FymNTV5ezMq6BbpbrCC9fB498yl7otFEg03rmA=;
        b=P3jdxVuicBkjgj1PoSAG7MhBQXlqv8t2RQ425pfWN/ovTHR0ENyaSh5DycmQ0zAJYN
         mDoHoWJ8fqNM5c0FaVcv9G5FJgrPgwSKrDB5t27kVbSkzDdsTTpxTawbei2Fgufv75dR
         188GEsmBLrvt3Bi7TVvvFVY7Koox10HskKEa6mJ+ZTV8dF2lHIZqVxYXLtTwN2wUjyyt
         BLrHUA2sC6JYAhtltYFqeCmHiaHeO5qqfvJaLwACmXzUShQAE93sMckdTlDJ0Tn9WaxI
         T8+rA8geV8chZbGC5B01Tjk0RH0iX4nHNgbBZASk7nDon1OAWOTCP0we7Inr8I2+RlMb
         8oDA==
X-Forwarded-Encrypted: i=1; AJvYcCWN8PUi2evY5WMVCkchk1jvMKSrI/nDORmcGooAC0ci4TVPrMby0JhegZS28pURyJjfc9c2m0Pom/lttnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsECbzJOjOqkuB72y9Yi93fGn66F9nTKsORwvOD9mKL6H0Wdpq
	H3DvZgcQCmJtWYn3DkY+GH685XPgl2GNiPlyumQU7rNYCzDAeLIF
X-Google-Smtp-Source: AGHT+IGAavjs6n08K+rKhBuGeAYl7JC3gaA1uuJISRnq0n/PI7gHwkPTiaQMeYSgovWc2IOJCUFEQA==
X-Received: by 2002:a05:6402:1eca:b0:5cb:69de:2bca with SMTP id 4fb4d7f45d1cf-5cbbf7295b7mr22286929a12.0.1730621698441;
        Sun, 03 Nov 2024 01:14:58 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac789152sm3097882a12.43.2024.11.03.01.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 01:14:58 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 11/13] staging: rtl8723bs: Remove function pointer hal_xmit
Date: Sun,  3 Nov 2024 09:14:32 +0100
Message-ID: <db4f4a699847209e4a577ebfbea82b87c571e6d1.1730619982.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer hal_xmit and use rtl8723bs_hal_xmit directly to
increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c     | 5 +----
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 1 -
 drivers/staging/rtl8723bs/include/hal_intf.h | 1 -
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index d45dfa8e638e..914d4b24d49d 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -162,10 +162,7 @@ s32	rtw_hal_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmit
 
 s32	rtw_hal_xmit(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {
-	if (padapter->HalFunc.hal_xmit)
-		return padapter->HalFunc.hal_xmit(padapter, pxmitframe);
-
-	return false;
+	return rtl8723bs_hal_xmit(padapter, pxmitframe);
 }
 
 /*
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index ccf1e9727846..563ebf8e7fdb 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1258,7 +1258,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->hal_xmit = &rtl8723bs_hal_xmit;
 	pHalFunc->mgnt_xmit = &rtl8723bs_mgnt_xmit;
 	pHalFunc->hal_xmitframe_enqueue = &rtl8723bs_hal_xmitframe_enqueue;
 }
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index b69d201b6826..dfb973018e4e 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -180,7 +180,6 @@ struct hal_ops {
 	void (*run_thread)(struct adapter *padapter);
 	void (*cancel_thread)(struct adapter *padapter);
 
-	s32	(*hal_xmit)(struct adapter *padapter, struct xmit_frame *pxmitframe);
 	/*
 	 * mgnt_xmit should be implemented to run in interrupt context
 	 */
-- 
2.43.0


