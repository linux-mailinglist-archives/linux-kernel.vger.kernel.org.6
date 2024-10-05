Return-Path: <linux-kernel+bounces-352145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303A1991AAF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E611F21BC9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05DE17C9FB;
	Sat,  5 Oct 2024 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKRL5o2W"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0DD176FA5
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728160498; cv=none; b=I+3JqnJm7cZQuV5mbW1SgHj6/Nie4KEiBiLsmU/ghmgEFIXr+THMhWutuJwPZYpUWH9Key5LC6b0PB98lHJQcY/nqyDrWxOsNKJnXgseI4W8+glm0btVelsqyYquXyYdEWvtJ6TESsVbfTtQamGrqZaSqfKCZbR82tc8eUCkiIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728160498; c=relaxed/simple;
	bh=krpq0fGgzMVWgb9E7YyRR3doZAOwCWPNy5qDRMYUCGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXHyUOqpeqGXzXeIECfuFbCvSyGPGv6QfahN6+U0ipQLPz8S0lXupNDyeH8TNovor4VNE3wcN3XjY4larN/gr+QuSdqAIeZ1J1qe3l5fNFGwI2sQdWT//NSKyyCaq5dCTNtOoy1XMveXRYctY+BlrueUv7p5qWMu9fFYVc/q9vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKRL5o2W; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so41378995e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728160495; x=1728765295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7spXH37LdfeWovbaJGZA+/T7zLQ1/vnpaj40rcnBLOA=;
        b=TKRL5o2W8ah3xznY6aEuG/YeCfoM+gshngXCufhAhQGIhAGcDdXvHtvWNEeoIeuWVG
         RDR5ZmpcgLMXE2XQlUZyPqIAJfO5pBXrTMKkyidDYaNNOKuZriaLto7+csPH6kqSf7Ui
         XpBN4J3Qa3ZUUyAc19gsxtJIyn7QfI9d3UpnSL36AXofsCH4WLus2hPOE4qXNInJ/yC7
         wp1yjoGlzV9vKPl7CIckGBTs7bJFMCb9+Tm6jBn6A9ClHILLegIL9pcWVZ4Pa8B27K3H
         dXMZ33Eu4YaAKb99gDyKY9P/EyCrZ4Mw6WgDUcQJay2VWKahav153OIAW8+ALkf7D2DW
         KS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728160495; x=1728765295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7spXH37LdfeWovbaJGZA+/T7zLQ1/vnpaj40rcnBLOA=;
        b=e9C2jhNtLM8o4R6fdC4buMuWAa1PkVW+Jm0BGxa0JzxwhI8pt/PgyExadVz2Tj4IPK
         MuBCoKesmEzRL+90RX/yUBjN3ZmdHEvVa752/4z4yYZSCAQ59knBQeemgV4GDLMP2taO
         gdLGOU71wSAIT8tnkqmAmDfU76pkdibjEcBEo7hS4n89BWJMczdLxYj/739K80+dULC7
         mMECjIVGseTPNQeG0wUETXfzGWFBW8L8SKw7i7/YyTov1s20cjYWMywORrkg0mk33aQE
         QdghB6Z3duxSfNCNEuGbUFsWTNIaT8spU/hSi/wLt2zk9O0FiG6AXingwGxlpeRgRf23
         9g4w==
X-Forwarded-Encrypted: i=1; AJvYcCUfdUfj9GHOQdPOZYvIdUuP8FPxlFdklRD7OgbiTCCaCXpnkzGGR1ciJKpP5kal5HmHnWn4WoNwWrcIaN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXIS3rLLB9ntBhM93evT8GokFyNpJPcHoOB0SSpsaE5IpBASXx
	rC43p6atepLRlXDNb7YHGyE0OAc8NG/UWYK3tSR0xtN50tzFL5xh
X-Google-Smtp-Source: AGHT+IFj9oct3wT0jweApImNO0BKJKKyji166TK/fx62TwVKc6IIDyUeFVLl0R7cRhYgl52V07tcYQ==
X-Received: by 2002:a05:600c:3b84:b0:42c:b8c9:16b6 with SMTP id 5b1f17b1804b1-42f85a6e0cdmr69418835e9.2.1728160494628;
        Sat, 05 Oct 2024 13:34:54 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f85995932sm41824805e9.0.2024.10.05.13.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 13:34:54 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 12/15] staging: rtl8723bs: Remove function pointer intf_chip_configure
Date: Sat,  5 Oct 2024 22:33:55 +0200
Message-ID: <d542f172438c333c015b87376a20645eeeae1b99.1727966761.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer intf_chip_configure and use
rtl8723bs_interface_configure directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 3 +--
 drivers/staging/rtl8723bs/hal/sdio_halinit.c      | 3 +--
 drivers/staging/rtl8723bs/include/hal_intf.h      | 2 --
 drivers/staging/rtl8723bs/include/rtl8723b_recv.h | 1 +
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index bcbc9ea78951..ec95d3ec3170 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -9,8 +9,7 @@
 
 void rtw_hal_chip_configure(struct adapter *padapter)
 {
-	if (padapter->HalFunc.intf_chip_configure)
-		padapter->HalFunc.intf_chip_configure(padapter);
+	rtl8723bs_interface_configure(padapter);
 }
 
 void rtw_hal_read_chip_info(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 236effa5c96e..6a56a5db5a5f 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -950,7 +950,7 @@ void rtl8723bs_init_default_value(struct adapter *padapter)
 	pHalData->SdioRxFIFOCnt = 0;
 }
 
-static void rtl8723bs_interface_configure(struct adapter *padapter)
+void rtl8723bs_interface_configure(struct adapter *padapter)
 {
 	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
 	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(padapter);
@@ -1259,7 +1259,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->intf_chip_configure = &rtl8723bs_interface_configure;
 	pHalFunc->read_adapter_info = &ReadAdapterInfo8723BS;
 
 	pHalFunc->enable_interrupt = &EnableInterrupt8723BSdio;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 357b41894cf1..1932f93d89c7 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,8 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	void (*intf_chip_configure)(struct adapter *padapter);
-
 	void (*read_adapter_info)(struct adapter *padapter);
 
 	void (*enable_interrupt)(struct adapter *padapter);
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_recv.h b/drivers/staging/rtl8723bs/include/rtl8723b_recv.h
index 69b5a7df32ad..dbd051a34d90 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_recv.h
@@ -89,5 +89,6 @@ void rtl8723b_process_phy_info(struct adapter *padapter, void *prframe);
 
 void rtl8723b_read_chip_version(struct adapter *padapter);
 void rtl8723bs_init_default_value(struct adapter *padapter);
+void rtl8723bs_interface_configure(struct adapter *padapter);
 
 #endif
-- 
2.43.0


