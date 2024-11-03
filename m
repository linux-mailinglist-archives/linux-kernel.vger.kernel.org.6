Return-Path: <linux-kernel+bounces-393742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB0B9BA4A2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7380B1F21731
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D133F175D37;
	Sun,  3 Nov 2024 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUMf6SGP"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C91632E0
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730621699; cv=none; b=aOLACnWid/DUKwSLf/NUVv1rwbL8kXqt/C/JO4SsY3Lh1zjsCHVFQ137mbez3do5HpXsVRQNEuWHsO0VeWsCDaB815FTWp1lJ2RhzC0+J5U99CXE3M94stPSwXFYo7kNrtscUz/AywiJs92s70tIQc3J35BiK3ynirpQaedEKLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730621699; c=relaxed/simple;
	bh=/SthlVcCaUJCfyv9+5To30Pjd+tIyLw75lQr01QO6V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0it0xKzGuwdRy20kwrZsDIM/ZKH0cILqxeCNu9+5cgrYHLbupUmIzemu7GFRYnQpHyI6klULxeovxHAuoDTaIoe6Ly5BfOwdmYp940x10NEjYVW9jeD3DJbetGv392A7Q5w9Gcv/acVhXxImu3ozzt5KNf77BIb2wSzK/hGc58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUMf6SGP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so1324070a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 01:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730621695; x=1731226495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdwTYTJsNURbKgGhx9XimSyfQDHw9X3ulBGYRri9afA=;
        b=HUMf6SGPBTpYczMKnVpDfpRNIbTIcf70HtktWs4IBegx+ohonYW7HaS6vvuhh2ANrO
         t4Hrbmobri19hW4hepnCkaRAEpi8kKjDZGaSGLKDXPmW4TlxFqSJbTN6S9SPaj+rMRml
         luh8jDGgWxn790dok2Ar7Mn+ZJRXssoOo3bp/ytfwocsV9RPRNCieOCl0F8bWMY17gT7
         mA36C8Q/FhaeN3jrgg2wETXZIBS4mgQoIA0uFo9n8iYzWZG5U2RDi9d7fY5oPXfoMa5i
         CmVE74lkdDVoM2pg5axElrOecLSHtNCgSrZ8GIvaGflu0APVGT89QZC54+CZY0msL2Q/
         yjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730621695; x=1731226495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdwTYTJsNURbKgGhx9XimSyfQDHw9X3ulBGYRri9afA=;
        b=CkoNEeZNZr6skHQsPHg7ADH7eDrhl9862MqlObobroY4pkKZP3lyd0ULvqPRng5f0S
         9F14C1zS+zHds6u/2LY1T66vyeX/Sq6cKYVzd9uQDT4zigf1yBTly9wi0QQuccKULIBb
         3MtsydO0ENB9XBcN6jap4CJjRaPQIulgbGTF+kuMWQ5YQILCLaMocpI/tZ8HFnUc0/Lg
         b6CWGK2fGL8qB8gQpCuiB6L33vG2DLKeavOAhxfmJSpy8L/jOOP15xUT988jvUnkuzFP
         rZAYnf5jzkvwTpy/Xb0+dK15p6g/TyN4LeUvOh2d9yalhWdXuNYmjYQ8SKS3R04r2gQK
         N0YA==
X-Forwarded-Encrypted: i=1; AJvYcCWUO0LM1v6fH5rXx1uceIgeqdXPW8kBhkSfYm7kZapJol+MIWiTVc4JgFYIoVz4CQOdhcrStY5wqRegKwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNwTBkWf4FbwV1v/ZVkHyMdfuDpXAFdayS/w5KOTdOHJFWuO7p
	oBAaE/fYvDF8sqqtcMLt2sraq3poLr+it1KSPQ7VR0mMWiWUVB1E
X-Google-Smtp-Source: AGHT+IE5MjUKB3SHBPEkKomjFhpIPecx86bNYfO3WeGkQFpShnXPn6Av+fqOT/PVGW9653s09ii90A==
X-Received: by 2002:a05:6402:50d0:b0:5ce:d69f:ca1 with SMTP id 4fb4d7f45d1cf-5ced69f0dcamr219094a12.20.1730621695342;
        Sun, 03 Nov 2024 01:14:55 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac789152sm3097882a12.43.2024.11.03.01.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 01:14:55 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 06/13] staging: rtl8723bs: Remove function pointer SetHwRegHandler
Date: Sun,  3 Nov 2024 09:14:27 +0100
Message-ID: <5682bb8d6951e903d23c98615e2fc6bd463b0ba4.1730619982.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer SetHwRegHandler and use SetHwReg8723BS directly
to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c  | 2 +-
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 4 ++--
 drivers/staging/rtl8723bs/hal/hal_intf.c       | 3 +--
 drivers/staging/rtl8723bs/hal/sdio_halinit.c   | 3 +--
 drivers/staging/rtl8723bs/include/hal_intf.h   | 4 ++--
 5 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index bb639ce49431..317f3db19397 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -5637,7 +5637,7 @@ u8 setkey_hdl(struct adapter *padapter, u8 *pbuf)
 		rtw_hal_set_hwreg(padapter, HW_VAR_SEC_DK_CFG, (u8 *)true);
 
 	/* allow multicast packets to driver */
-	padapter->HalFunc.SetHwRegHandler(padapter, HW_VAR_ON_RCR_AM, null_addr);
+	SetHwReg8723BS(padapter, HW_VAR_ON_RCR_AM, null_addr);
 
 	return H2C_SUCCESS;
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 9bef4b9e2aca..73c70b016f00 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1575,9 +1575,9 @@ void update_wireless_mode(struct adapter *padapter)
 	SIFS_Timer = 0x0a0a0808; /* 0x0808 -> for CCK, 0x0a0a -> for OFDM */
 													/* change this value if having IOT issues. */
 
-	padapter->HalFunc.SetHwRegHandler(padapter, HW_VAR_RESP_SIFS,  (u8 *)&SIFS_Timer);
+	SetHwReg8723BS(padapter, HW_VAR_RESP_SIFS,  (u8 *)&SIFS_Timer);
 
-	padapter->HalFunc.SetHwRegHandler(padapter, HW_VAR_WIRELESS_MODE,  (u8 *)&(pmlmeext->cur_wireless_mode));
+	SetHwReg8723BS(padapter, HW_VAR_WIRELESS_MODE,  (u8 *)&(pmlmeext->cur_wireless_mode));
 
 	if (pmlmeext->cur_wireless_mode & WIRELESS_11B)
 		update_mgnt_tx_rate(padapter, IEEE80211_CCK_RATE_1MB);
diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 44fab4eecb5e..756d6ed9232d 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -108,8 +108,7 @@ uint rtw_hal_deinit(struct adapter *padapter)
 
 void rtw_hal_set_hwreg(struct adapter *padapter, u8 variable, u8 *val)
 {
-	if (padapter->HalFunc.SetHwRegHandler)
-		padapter->HalFunc.SetHwRegHandler(padapter, variable, val);
+	SetHwReg8723BS(padapter, variable, val);
 }
 
 void rtw_hal_get_hwreg(struct adapter *padapter, u8 variable, u8 *val)
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 1211b7b440cf..6333a0d23d43 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1144,7 +1144,7 @@ void ReadAdapterInfo8723BS(struct adapter *padapter)
  * If variable not handled here,
  * some variables will be processed in SetHwReg8723B()
  */
-static void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val)
+void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val)
 {
 	u8 val8;
 
@@ -1259,7 +1259,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->SetHwRegHandler = &SetHwReg8723BS;
 	pHalFunc->GetHwRegHandler = &GetHwReg8723BS;
 	pHalFunc->SetHwRegHandlerWithBuf = &SetHwRegWithBuf8723B;
 	pHalFunc->GetHalDefVarHandler = &GetHalDefVar8723BSDIO;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index e6f4c398f35f..439639f6616c 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -170,8 +170,6 @@ struct hal_ops {
 	void (*hal_dm_watchdog)(struct adapter *padapter);
 	void (*hal_dm_watchdog_in_lps)(struct adapter *padapter);
 
-
-	void (*SetHwRegHandler)(struct adapter *padapter, u8 variable, u8 *val);
 	void (*GetHwRegHandler)(struct adapter *padapter, u8 variable, u8 *val);
 
 	void (*SetHwRegHandlerWithBuf)(struct adapter *padapter, u8 variable, u8 *pbuf, int len);
@@ -319,4 +317,6 @@ s32 rtw_hal_macid_wakeup(struct adapter *padapter, u32 macid);
 
 s32 rtw_hal_fill_h2c_cmd(struct adapter *, u8 ElementID, u32 CmdLen, u8 *pCmdBuffer);
 
+void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val);
+
 #endif /* __HAL_INTF_H__ */
-- 
2.43.0


