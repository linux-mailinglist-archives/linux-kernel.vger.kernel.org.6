Return-Path: <linux-kernel+bounces-395936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B43179BC51E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BF5282556
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C428200B9A;
	Tue,  5 Nov 2024 05:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8RurbdV"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1764C1FF7C9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786137; cv=none; b=JZxMRy9DnSAtblxzCXxCXyneG7uyiLM1/unVtqscgT4D+2UnCjwI1mPWSNTj3JHA0gfjJbjpPLXQuvYKzx1mmbCMxFKT/X7rAcnSrHYU/GmG8Q0hfSyH77kEwX36zOcK9+wPn89qtoII3khKQsOsmTTzouYPwGJ+65LHgSmeAlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786137; c=relaxed/simple;
	bh=HglkhNzncWm++cDmzY1QBdFTq/C3UWh00tiePddknxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDHY87kGzg7OzY6y3rhZhZgWwWnPIMJGwokNPlz5gnf73ztWfN4DTBJEhUqgZWl+sMWlkiyucHugzokA4hRxdb6zlaBvFBEiEWHeSEYOKT3dAOvnCxEY4i82u+7Ja5NPMnm0bdC4/5xMQ/jyQV4z+EZaOQazC2WNIBzSfacTIes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8RurbdV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so5331395a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786133; x=1731390933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c9Awi4gQwnX479vvOPVy/wJUH9Kd2C6R7oi7odwG+U=;
        b=a8RurbdVY6CeQoVNHS7ZDYYy6oK1CY5Ozt/Sr1CDQJqqSQqSQ0qStf0fbW0c6fvfa5
         FkKYZ1n4K5fKgNMqLjLM0rNmMfHbSS/Nj1Xno3c5FfCTZwkzEU7lzg9yFsBBURkZou87
         ey79ehYWKhdASFUTFSl7lVKgCBrU+aTf9mT3YiHjC4D3+zufkszwW5Ak4y68PG+UzhhI
         9A807a62v1Erg6djfSGiOJSwZwK/WRIrxYXVw1kObi/+xHD3b61yq19HLH8mbn4ok+Wd
         joNu61G8edijmHC1gXFMcMKtFGfXTYXQMuzY+tocYnr2ifcHdA0BLUPWI/0p/WioTx3K
         HI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786133; x=1731390933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5c9Awi4gQwnX479vvOPVy/wJUH9Kd2C6R7oi7odwG+U=;
        b=H+7wT6QSMWPyldC/F7MhTkcQOElhvj1iwchzOumgK+6rqmhzYBfHgluRxvurW5b9TC
         C4DzITRrZwQyLEQyVyYE83/0lFD42i+8mGRPMPolfe6WEAU9AHphPA8pbuivt836JcHI
         Av2mep595RJGvkWv6qfdGn5qPST4vc0QT81yI3UYOUYL0BimpxUUL115ZW7vR4F4xmPx
         Eo0bfEsPOlb1NHuJCy68o7moFH+P51q/ocsUNvys6QcZFFZrIUpErTzO1IO3uc1zRQ9n
         yAUMrA3C7E9VdTmDJsXdal3PHIXld4Gw7ddgjzpMR9H/Mv2xLX1An1DHcUJUUaauZwVC
         JBEA==
X-Forwarded-Encrypted: i=1; AJvYcCVO8WIjtLgXXiNMeSmSxwj1a0kWa/a8uO8Md+HMZf0RSG5uEqmwzxqLA0eu/q7LWgpVPZSJtA6K7r/j9mE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7MsP4omIJ3aFs18s9qhqDG/QQesAWtTUf4OYVtrqffJlpiqDI
	sNMZebyje2LI4RYFcnAbC0yXqrR6MBjfmZc7OGriSBStlg7rsm3O
X-Google-Smtp-Source: AGHT+IHutIpV9r6Mt+L/j/kjgTDJPTDItX13wBgylN1fVRc0YUZpR3UiBzS/+X6QOnu5NIfPd9P13g==
X-Received: by 2002:a17:906:561a:b0:a9e:8522:ba01 with SMTP id a640c23a62f3a-a9e8522ba90mr777118966b.39.1730786133173;
        Mon, 04 Nov 2024 21:55:33 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb181451bsm78775466b.201.2024.11.04.21.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:55:32 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 10/16] staging: rtl8723bs: Remove function pointer cancel_thread
Date: Tue,  5 Nov 2024 06:54:57 +0100
Message-ID: <e4fdff174a8ddc6cd62232e0aac8e23f4f34b1b9.1730749680.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer cancel_thread and use rtl8723b_stop_thread
directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 3 +--
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 2 --
 drivers/staging/rtl8723bs/include/hal_intf.h      | 2 --
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 28d15536abbb..22c41e4deae4 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -238,8 +238,7 @@ void rtw_hal_start_thread(struct adapter *padapter)
 /*Start specifical interface thread		*/
 void rtw_hal_stop_thread(struct adapter *padapter)
 {
-	if (padapter->HalFunc.cancel_thread)
-		padapter->HalFunc.cancel_thread(padapter);
+	rtl8723b_stop_thread(padapter);
 }
 
 u32 rtw_hal_read_bbreg(struct adapter *padapter, u32 RegAddr, u32 BitMask)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 8d8270d85f96..d23e4b1c36b6 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1744,8 +1744,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->cancel_thread = &rtl8723b_stop_thread;
-
 	pHalFunc->read_bbreg = &PHY_QueryBBReg_8723B;
 	pHalFunc->write_bbreg = &PHY_SetBBReg_8723B;
 	pHalFunc->read_rfreg = &PHY_QueryRFReg_8723B;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 3306c26ed2a4..02b31c142b9a 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -164,8 +164,6 @@ typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 struct hal_ops {
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 
-	void (*cancel_thread)(struct adapter *padapter);
-
 	u32 (*read_bbreg)(struct adapter *padapter, u32 RegAddr, u32 BitMask);
 	void (*write_bbreg)(struct adapter *padapter, u32 RegAddr, u32 BitMask, u32 Data);
 	u32 (*read_rfreg)(struct adapter *padapter, u8 eRFPath, u32 RegAddr, u32 BitMask);
-- 
2.43.0


