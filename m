Return-Path: <linux-kernel+bounces-395938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F39BC520
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079BC1F22C7A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3431FEFC2;
	Tue,  5 Nov 2024 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ka932y9T"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE0A200117
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786139; cv=none; b=ILUaUwPt21ducHZ+IP6jSQkDS1xyy6fzTrf7oniXhYt8Qv+ukrDzYRr9KdnGGnKvfGeYMvazBQSQAiOeQ9AXUe/PxqT0F7u0yR5rQC1ZJPZe2axvO6TkZXYHiRpfdBHnD53+zNJ+aWnyeRmUnQphHwNzSSYMq+2pSQpeINn/Ck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786139; c=relaxed/simple;
	bh=28Bkc5YGsObVRPzBc7wWi9s9JfvFJnwV1Px34/m+LMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qm6KYeJ83OaM3xjHITr4bx/T1GorBmVjIXVgb0NDgFT7jpaFp9x/RfG8mHK3nFC3FlJq94Mzp0WJTYYJRi2OWTVUNoA8M8QHfEcRJ2vWH1IMBQ6KfMnTtefL65L+tTMyZaB1BvdUNXnvSbP81oMp0IhoTCdjuCVcbTd8DZ0Ev7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ka932y9T; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a998a5ca499so662774766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786134; x=1731390934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ0gej5hu5i4ouNXd0ApdepNnr3n035slJGM94RcvIk=;
        b=Ka932y9TRmD88WELgaP4FvGn3IxuM1zRsve4tfgAz93sFjUlEE7he9ickUg/RTbZqF
         MxuZhxBVGwNZU4OGH0OcZsOcfcmTyJ/S8DgRx0+M0K1ug0Z2fdsQioZWYm33PsWo6CPz
         V1RqNhPPS5zMk4XmuHwK1RGSoOLcAsXxykroLak8KoIxFT1OEKTxaa6bz/Kz2mhgR74Q
         22gullz6cW4vlDvr1KKw6k7WVp3bQEPujmdmj3gXFN1V+5Pk+e4ChGOXscigwFgjGJLS
         1DksZByvXw7Gm5jjctS/Lbd4rPy2rKy+5e+7Ub0FxWJxW3UoxmlBF3GN/cVKnKHmLkUr
         gwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786134; x=1731390934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJ0gej5hu5i4ouNXd0ApdepNnr3n035slJGM94RcvIk=;
        b=iZDm3UKz1ystRhw/qk7PDQWMqlRta/UnDY/6uy2CP3eIaKZs9QIULBI5BIevna1JDx
         EJVCEZC8BqqK1c00YZWukL7U4+NXSNs2jHsz66DTZyzOXS2JAgwDCVcdHK4VbX/bzUuo
         4VzPI+TnSHPn56+EdKnqRpJxMA/qUdkgdgjLQail6Kqbxvbc2OdBMtgRd5eNC8NQ7+eu
         sq0nFV3u/pxsC+GuXL2ecG04sSYPFkShYkpUb41zzVr3nBa50bJDryagzj8fNdzhfkWq
         +k0n8qEnJaayaEsrBefNKQr5OQV2jEkSLZAN3Uvzv7Z72w8GvQZ6Vuv62YHaH2tICc1I
         9/0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxHWJMCgfjKlNBxZju00v5n+9xML2xKNRYY0TjuVbEfQJvbieYfMOVgDsLAAttk0uyOfpLF/8ZgQU1gdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyMQXL2kZw9mlufKMrVnwvDmscizM8RPIcZfDHcenTGyDAi6Jz
	rzOyCSfmq77s9FdS+78qDt5eCy6ENlrhS7EIZPjrzN/+uegi4//DjjZPWw==
X-Google-Smtp-Source: AGHT+IFebDS3Zdq8uE5ocERonEnyJ7aAzrtfqYEtNnSmFUVZd3nDg0JDXj06JbVLHlSRZz2ILbv2mg==
X-Received: by 2002:a17:907:97c6:b0:a99:2ab0:d973 with SMTP id a640c23a62f3a-a9e657fd76dmr1370951066b.55.1730786134330;
        Mon, 04 Nov 2024 21:55:34 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb181451bsm78775466b.201.2024.11.04.21.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:55:34 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 12/16] staging: rtl8723bs: Remove function pointer write_bbreg
Date: Tue,  5 Nov 2024 06:54:59 +0100
Message-ID: <0405fe50c32cfafc95ccf9ceabaa05e14ce653be.1730749680.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730749680.git.philipp.g.hortmann@gmail.com>
References: <cover.1730749680.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove function pointer write_bbreg and use PHY_SetBBReg_8723B directly
to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 3 +--
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 1 -
 drivers/staging/rtl8723bs/include/hal_intf.h      | 1 -
 drivers/staging/rtl8723bs/include/rtw_mp.h        | 1 -
 4 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 5e53d6a56b44..4faa64b1c476 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -247,8 +247,7 @@ u32 rtw_hal_read_bbreg(struct adapter *padapter, u32 RegAddr, u32 BitMask)
 }
 void rtw_hal_write_bbreg(struct adapter *padapter, u32 RegAddr, u32 BitMask, u32 Data)
 {
-	if (padapter->HalFunc.write_bbreg)
-		padapter->HalFunc.write_bbreg(padapter, RegAddr, BitMask, Data);
+	PHY_SetBBReg_8723B(padapter, RegAddr, BitMask, Data);
 }
 
 u32 rtw_hal_read_rfreg(struct adapter *padapter, u32 eRFPath, u32 RegAddr, u32 BitMask)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 9d1b47f4c828..a8191b84eb81 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1744,7 +1744,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->write_bbreg = &PHY_SetBBReg_8723B;
 	pHalFunc->read_rfreg = &PHY_QueryRFReg_8723B;
 	pHalFunc->write_rfreg = &PHY_SetRFReg_8723B;
 
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index f95bd07a5d31..02c18dbc04b1 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -164,7 +164,6 @@ typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 struct hal_ops {
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 
-	void (*write_bbreg)(struct adapter *padapter, u32 RegAddr, u32 BitMask, u32 Data);
 	u32 (*read_rfreg)(struct adapter *padapter, u8 eRFPath, u32 RegAddr, u32 BitMask);
 	void (*write_rfreg)(struct adapter *padapter, u8 eRFPath, u32 RegAddr, u32 BitMask, u32 Data);
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_mp.h b/drivers/staging/rtl8723bs/include/rtw_mp.h
index 63b2ee7e824f..30badc3f8d45 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mp.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mp.h
@@ -276,7 +276,6 @@ void _write_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask, u3
 
 u32 read_macreg(struct adapter *padapter, u32 addr, u32 sz);
 void write_macreg(struct adapter *padapter, u32 addr, u32 val, u32 sz);
-void write_bbreg(struct adapter *padapter, u32 addr, u32 bitmask, u32 val);
 u32 read_rfreg(struct adapter *padapter, u8 rfpath, u32 addr);
 void write_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 val);
 
-- 
2.43.0


