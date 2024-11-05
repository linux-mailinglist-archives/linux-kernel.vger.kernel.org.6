Return-Path: <linux-kernel+bounces-395926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FF69BC512
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9041C21451
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498361FDFBB;
	Tue,  5 Nov 2024 05:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UujOq/lZ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5F11FDFB4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786131; cv=none; b=TVeNDGal0Kg8lmYuwQeq8wz2/VAxIFaqNwqbQydRPteBzicZpuMqgfeUDZ34txwaxAz/oZltCUzlL8jVE5dA3ZJEi559L85O+W8kMQu9cUGFtyrHU0afOrg8VDP/99F5h6FWOX3kU5kOOBWRCYOzScQGgzKMLlWbW9dUceidw6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786131; c=relaxed/simple;
	bh=e0qpNxPiS6knu42pKMhzUMqgsBTZxSaiUf7bg+iHlrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NriEI09vgB4j+NuEmvl94ey7yPsHaylotN1vEwjNx64ZYop9WVGIGZ1Elz0ckC445xKnxB0YkoejP27FnSGHgJgRHwlMCpxAC6zrR0SqhOBUDh4KxdTS4xSqYtIRqOA+rJP92qNkGOF3/y7J8vYQ9Y8S+mtOu4xM9DDYnuW0Nd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UujOq/lZ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99ebb390a5so1088805666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786128; x=1731390928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ySr93uDv1RLoNp9SZC+4GP4tsUzCUfN27zMA1PYid8=;
        b=UujOq/lZ9YBv+tmnJiHTSXnyIq0hkxjGiOfgWkFMGvqBCmnbCpL8hjohGg8D9ujMaH
         TnA+pafAm7UNDkd/M25gKw+JRh1nB3kQvJSyfZ4/dCx99xZhbayY10jvujQP9H6GwdxQ
         5TgTMo6NvtKzg5dTgvt/g/ifCokYkED7+ZXYjUmgUAyKVb5UmITX9kU91LEReJ9Ufb1/
         lkK3o9otBFGGYbc34FZMXYyy7Tu/1VwyCrKMJmpIu215toC1nDewrCIKjjXzvXgb3bQk
         Wj2VE2JxFoxUn/wARLu4Rz1z2OKWhIa+vJCbS8sQAZGZii2IPfHZSP4DCEgdPzoy87eT
         3pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786128; x=1731390928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ySr93uDv1RLoNp9SZC+4GP4tsUzCUfN27zMA1PYid8=;
        b=AKC/08T2rHLglJ6XLZrSIx0JrBN+7pvSF4ASfRqy3YRyh9piVbRDYW/JDfBbqcHACl
         on9xnSzVSPDTRi5LEhQIFf8L8l/ZAM+EO2leFMWW2TmPnf22a4wq4j6WhLqKBO/8sqrs
         5rWGQnsHm1g2APqYYX5FENJ4Uhw/fzUafOM43Z9F9RBg3PmuIidJrEdNk0EMtlxjD4Jo
         hinee1jPfuq+3IJ4STS37CsvqnffKKKG1NYnuUUQxsTUCAAEhNJeuZLL8Dx7VLaZTUCH
         H6PTcDasiVBE7RUYF5G/fBZTYxtsEubmQI8JG5HxQckWvVHFGXqZY9zGL4HaDS7V82nX
         bHOw==
X-Forwarded-Encrypted: i=1; AJvYcCW4+8cJzd/nv3iazj4WQJCDt0GzgSvSzDR7k8Z+94MNyLJfDwX8DuhObrknU5+DXTXpauxEtoERu/pMivU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOlOoI5XTsl0FcDWn1pt65e/m7aN5hz9THJBBZxa5+9uBVD8t7
	1AC/mrcvXO4eNh9K7ZuADW+XlN4GWNm51v/AX7XrpNtIIoDjtqgo8K8G9A==
X-Google-Smtp-Source: AGHT+IHS/vo13xfu+Zu7dmKKO4/v67IudTcp/WEOqVMqzf/cmcc0e7FEoRz2vRabvCkIqUleteR5Pg==
X-Received: by 2002:a17:906:c38d:b0:a9e:82d2:3266 with SMTP id a640c23a62f3a-a9e82d23c2dmr780516966b.4.1730786127936;
        Mon, 04 Nov 2024 21:55:27 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb181451bsm78775466b.201.2024.11.04.21.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:55:27 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 01/16] staging: rtl8723bs: Remove function pointer UpdateRAMaskHandler
Date: Tue,  5 Nov 2024 06:54:48 +0100
Message-ID: <6e11b767faf44c2e95a05f3e1326d9cc382dcebd.1730749680.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer UpdateRAMaskHandler and use UpdateHalRAMask8723B
directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 3 +--
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 4 +---
 drivers/staging/rtl8723bs/include/hal_intf.h      | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 8b924961789e..397fd8fb3cb0 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -221,8 +221,7 @@ void rtw_hal_update_ra_mask(struct sta_info *psta, u8 rssi_level)
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true)
 		add_RATid(padapter, psta, rssi_level);
 	else {
-		if (padapter->HalFunc.UpdateRAMaskHandler)
-			padapter->HalFunc.UpdateRAMaskHandler(padapter, psta->mac_id, rssi_level);
+		UpdateHalRAMask8723B(padapter, psta->mac_id, rssi_level);
 	}
 }
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index c3fcadc634f9..20c8459cd6d2 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1704,7 +1704,7 @@ static void hal_notch_filter_8723b(struct adapter *adapter, bool enable)
 		rtw_write8(adapter, rOFDM0_RxDSP+1, rtw_read8(adapter, rOFDM0_RxDSP+1) & ~BIT1);
 }
 
-static void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
+void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 {
 	u32 mask, rate_bitmap;
 	u8 shortGIrate = false;
@@ -1744,8 +1744,6 @@ static void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_l
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->UpdateRAMaskHandler = &UpdateHalRAMask8723B;
-
 	pHalFunc->set_channel_handler = &PHY_SwChnl8723B;
 	pHalFunc->set_chnl_bw_handler = &PHY_SetSwChnlBWMode8723B;
 
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 7050520224ff..e882877436c4 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -172,7 +172,6 @@ struct hal_ops {
 
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 
-	void (*UpdateRAMaskHandler)(struct adapter *padapter, u32 mac_id, u8 rssi_level);
 	void (*SetBeaconRelatedRegistersHandler)(struct adapter *padapter);
 
 	void (*Add_RateATid)(struct adapter *padapter, u32 bitmap, u8 *arg, u8 rssi_level);
@@ -308,4 +307,5 @@ void GetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val);
 void SetHwRegWithBuf8723B(struct adapter *padapter, u8 variable, u8 *pbuf, int len);
 u8 GetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
 u8 SetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
+void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level);
 #endif /* __HAL_INTF_H__ */
-- 
2.43.0


