Return-Path: <linux-kernel+bounces-395937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE529BC51F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0EB1C21614
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B30200C9B;
	Tue,  5 Nov 2024 05:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+6U2vSv"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F1D1FEFD5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786138; cv=none; b=cYMpP7YSI+ITEjw+k6abSWvy8b3wGH6NfhgBtA2HTH8iTdue3Qr5b6qGUE4FhBGb1xanJTGnb/R05i80d83QRYPWkeCWHU9gDWyyDVO9aXXQigcgK6FSPYJxuQzGrbtSPSBpWhd4h2m/lwr9OVzx3GalRD7EgzkEzfVT1KMzppw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786138; c=relaxed/simple;
	bh=svDsaygyFTZe/9Fa4yspOWzEFRzq2T3AsVoPXnJ61Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxddhn2YRWh4Q+D3K4KkqpONHGT94HY+1dpLafbF24Zo6GNDDDb1+CKj0yk3Rvc3IntKHMEfipzCEs8QEMi4p7lWo7VBxBkfmZlnwFVIV3OCObZGZzPC1LSwmrxN3gCLCr8q6Sk57H2gpLxfaITW1pqQbT2y5QJHduj1QP9izGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+6U2vSv; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f2b95775so5664628e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786134; x=1731390934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/p8mfQcwgmWTaow4D7FS5k0WwDF702iUg3tHZvn7wE=;
        b=B+6U2vSv0BX6LOhZP8vOQnr+9dR2s1sWNLBcyBLZPoWilZ1TRdXJP5G5Z/U+bfBFXE
         kGiApe/xgflldju23SSN5y0WqLvrtsfjZzbE0LEJl8GL1gEzoB2OIo56dCPL+T5J5oBn
         neqlkvpK9GWLoMzKjm2mXUriHBX4A0Ry2GLDXXmrGH0ithwQKLCG9WwFFpuo3juNBM0a
         G6eyE+/8PFnIfI3rpSg67tm7OONtY/Na/YDCmne4UVEsuriLjsqAkwieT1hTagIxNa5N
         vt3eFIZ5zFFClIYF7QikRF5Ral6uTYUYZkY2qYh2S6Ez6rITco9Vm2KmpxUXxJU0EaTt
         pSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786134; x=1731390934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/p8mfQcwgmWTaow4D7FS5k0WwDF702iUg3tHZvn7wE=;
        b=a0SuJTbAf6uj2cNUDU4Qn/aK69pKw6mDmmxMA+1ToDYdGvTJ28yvL9yj8CDUVgpdBD
         zc+88BdlGvsjPhs8I3mNwTCxdGZ5DSm4wCbhEOmfLhVvt7IrCUoI98ZyvHlSZSk+mIYZ
         vCVes81ULfqBapDmy3yfOypPbN6kjZdcaDFVNov2wP665/2unD8ZHViyiosmcbvjRhe3
         Hog2/nkh4SwsqISvRxsfEq3PkbG3CYwsNZYiNfmyvkTQy15saIJ0Zj0H9Iu/agJfSVUF
         JN/ejKwz5GFJzR0Z/Jv9OyskdO+eAoN4IpcGM0i0BYhe8iJjA3kxFvAktUjZqdd3iZH2
         TPFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzy0Z46922DT+RGHE8brOrXGMMZWksyo8EUGf6A3FoDaLiqldJmusNPhmcpPoxb2ejHcWL1PsAABouRP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1clQNCth3bfwAAvjpyRUcWd+GNAdUawXnkPJ232UrcnK/0X+2
	UpCRqrnaza8fpqhiHw+aABx1Yvn9dxIgGku0/SFW+tmMiZMQnT8p
X-Google-Smtp-Source: AGHT+IEeLXt78rYimjyRK8fTPdhONbLzK8bL2pl3MQuLGhvZK712Ig08iwAvKqiv3AYYM1OS1IfkEA==
X-Received: by 2002:a05:6512:2384:b0:539:8a50:6ee8 with SMTP id 2adb3069b0e04-53d65e168c8mr10761917e87.57.1730786133749;
        Mon, 04 Nov 2024 21:55:33 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb181451bsm78775466b.201.2024.11.04.21.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:55:33 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 11/16] staging: rtl8723bs: Remove function pointer read_bbreg
Date: Tue,  5 Nov 2024 06:54:58 +0100
Message-ID: <c80ba5221c2b4be85e65246b30cafc111235cf3f.1730749680.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer read_bbreg and use PHY_QueryBBReg_8723B directly
to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 6 +-----
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 1 -
 drivers/staging/rtl8723bs/include/hal_intf.h      | 1 -
 drivers/staging/rtl8723bs/include/rtw_mp.h        | 1 -
 4 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 22c41e4deae4..5e53d6a56b44 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -243,11 +243,7 @@ void rtw_hal_stop_thread(struct adapter *padapter)
 
 u32 rtw_hal_read_bbreg(struct adapter *padapter, u32 RegAddr, u32 BitMask)
 {
-	u32 data = 0;
-
-	if (padapter->HalFunc.read_bbreg)
-		 data = padapter->HalFunc.read_bbreg(padapter, RegAddr, BitMask);
-	return data;
+	return PHY_QueryBBReg_8723B(padapter, RegAddr, BitMask);
 }
 void rtw_hal_write_bbreg(struct adapter *padapter, u32 RegAddr, u32 BitMask, u32 Data)
 {
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index d23e4b1c36b6..9d1b47f4c828 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1744,7 +1744,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->read_bbreg = &PHY_QueryBBReg_8723B;
 	pHalFunc->write_bbreg = &PHY_SetBBReg_8723B;
 	pHalFunc->read_rfreg = &PHY_QueryRFReg_8723B;
 	pHalFunc->write_rfreg = &PHY_SetRFReg_8723B;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 02b31c142b9a..f95bd07a5d31 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -164,7 +164,6 @@ typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 struct hal_ops {
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 
-	u32 (*read_bbreg)(struct adapter *padapter, u32 RegAddr, u32 BitMask);
 	void (*write_bbreg)(struct adapter *padapter, u32 RegAddr, u32 BitMask, u32 Data);
 	u32 (*read_rfreg)(struct adapter *padapter, u8 eRFPath, u32 RegAddr, u32 BitMask);
 	void (*write_rfreg)(struct adapter *padapter, u8 eRFPath, u32 RegAddr, u32 BitMask, u32 Data);
diff --git a/drivers/staging/rtl8723bs/include/rtw_mp.h b/drivers/staging/rtl8723bs/include/rtw_mp.h
index f94bb18479da..63b2ee7e824f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mp.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mp.h
@@ -276,7 +276,6 @@ void _write_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask, u3
 
 u32 read_macreg(struct adapter *padapter, u32 addr, u32 sz);
 void write_macreg(struct adapter *padapter, u32 addr, u32 val, u32 sz);
-u32 read_bbreg(struct adapter *padapter, u32 addr, u32 bitmask);
 void write_bbreg(struct adapter *padapter, u32 addr, u32 bitmask, u32 val);
 u32 read_rfreg(struct adapter *padapter, u8 rfpath, u32 addr);
 void write_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 val);
-- 
2.43.0


