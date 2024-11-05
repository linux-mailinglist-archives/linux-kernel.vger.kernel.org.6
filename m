Return-Path: <linux-kernel+bounces-395933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7D19BC51B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595CB1C2145A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAD52003AB;
	Tue,  5 Nov 2024 05:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/LyptDr"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832881FE10F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786136; cv=none; b=YJeulqTYDY3VWYul7WR66ZJ+F9+Tntv5Vumf3hwNqL8KkJhqW+Xe/+7dP89bw9uaMwkOLcG20hlkgtVVJBp5DlrOXzTvjd02XZ2AFGeX/F8POuwMLiyEPvKQqHLDT4iL9mEvJ2w1jcz8MdUfqXzhHIG5gJLmwvQ8VebBoa+ig/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786136; c=relaxed/simple;
	bh=dUmRw66INNlKdlmTudq7RiF3F29a8TpZ7rdCqwq7m+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLOvN41EUO7DWqT4IJO8rslw0az8Z4MKmSvB+xk5TFqnVVXLYEycC2CpM9KkfxAojdJxzItWfx+uSRx0aqF4YvQWd9gFbN8p47a6505+RsFEF08jeNVNDAw3Se3fQm+lf7dYsNNb+bJyxtcfx8ohti2+PclmAVmUKWT9UTpee4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/LyptDr; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f58c68c5so9084315e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786130; x=1731390930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATcCt5wGapgsOIibXTkxr5INcEzs+wUBJpSP0wgkVe8=;
        b=C/LyptDr5mVB1OZzLDpd0/T01gMjCXfPqSiI088jpYhAnvg+uPD77OIvUmEEHDWmks
         gac/1rwlyASuweWYDtKKoNObaVBEfVKZLc2NWKsGeKLlPLqcfE9/BHADTqHZ132GbFlX
         dHTlDDjnJEC03/q6AxjCSzjcENRBSlSa4MBJ2h5wLMotYZOblY11d0cr4uGWIxun1SzX
         a40/7XzJF07uzb8tqTFPvSy+p7PH+Rteu5g+wc0mR0QpCXNdBAqCfIjPTWQx9JMC86g7
         uTnbEaYyma91beDsCfBs+OUNkaOnc2H+KH6rnWph+xSbF0J6Scga7YBjqxXqrlHapely
         Da6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786130; x=1731390930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATcCt5wGapgsOIibXTkxr5INcEzs+wUBJpSP0wgkVe8=;
        b=eC07kRY6F+3tq9ztxNb77a7dsc/HEmQQDf11P0ser+dwn3mzixNHQNrq0vZ2kpsd9E
         J9jwiZmHc2v5aMhbbx+B4+OJumuMgoaCYwGHM9zasSGJuz4D/6Ywv4JIEvKPIuuEhTd9
         KOKwkKoLy3OOze69vbNrT1RL2sRwzZEDY4lIgh7EEW92fCCuElTxu3XvRAbujP6avEEm
         8sFN8Qr8A60n6j74msYo6TyXE65C7RzSVEDAAK6yILIqHLuGkzLHHbhqky+TJgyEafCW
         d7KWEBV6jCfENLiJ0jtPX88ZG+FPTWYb7ckE6ob2nVnPDN2yQ7JGyMzg2XvjK261k4wJ
         VfmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU1bH+PRa5aL2P5Drf9ZUKd2O/riB44QjX7bx46O1S5bhM7E6jULtkj6kW3Rrou/f1SwzKxaJnDP6eHPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBxW3pySmFT+Ep29xW460T5GMEpuAtuO0RTA3OYUA1Xmwv33qF
	JIOKlKG0qf1JFDcUKBbUexbqhlqnGQff5KDGjuWdbsN1CZofydT9
X-Google-Smtp-Source: AGHT+IFf7/arJetSzLOR2v1y+NSDgZwOhl+cpQCCz/tzyY+aP5gGIynapqUT0FiOj0c1zKHOFHDl1g==
X-Received: by 2002:a05:6512:b12:b0:52c:e17c:cd7b with SMTP id 2adb3069b0e04-53d65de52aemr11843291e87.22.1730786130334;
        Mon, 04 Nov 2024 21:55:30 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb181451bsm78775466b.201.2024.11.04.21.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:55:30 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 05/16] staging: rtl8723bs: Remove function pointer hal_dm_watchdog
Date: Tue,  5 Nov 2024 06:54:52 +0100
Message-ID: <6e1b09e7d7184285fc747be7d7bd636bd1690d60.1730749680.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer hal_dm_watchdog and use rtl8723b_HalDmWatchDog
directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 3 +--
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 1 -
 drivers/staging/rtl8723bs/include/hal_intf.h      | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 7aa9d84ee574..af72e0fe6fc0 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -285,8 +285,7 @@ void rtw_hal_set_chnl_bw(struct adapter *padapter, u8 channel,
 
 void rtw_hal_dm_watchdog(struct adapter *padapter)
 {
-	if (padapter->HalFunc.hal_dm_watchdog)
-		padapter->HalFunc.hal_dm_watchdog(padapter);
+	rtl8723b_HalDmWatchDog(padapter);
 }
 
 void rtw_hal_dm_watchdog_in_lps(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index f742a82d1e35..ff899a066b33 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1744,7 +1744,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->hal_dm_watchdog = &rtl8723b_HalDmWatchDog;
 	pHalFunc->hal_dm_watchdog_in_lps = &rtl8723b_HalDmWatchDog_in_LPS;
 
 
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index ddc4c41605d2..311a97c31518 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,7 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	void (*hal_dm_watchdog)(struct adapter *padapter);
 	void (*hal_dm_watchdog_in_lps)(struct adapter *padapter);
 
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
-- 
2.43.0


