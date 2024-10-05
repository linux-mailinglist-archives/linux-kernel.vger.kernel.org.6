Return-Path: <linux-kernel+bounces-352143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89050991AAD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3FD1F223D2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04F817BB12;
	Sat,  5 Oct 2024 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqlH8SN5"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542EB16F265
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728160497; cv=none; b=daFvflwL58gsC+Qw6WYLvArGG8JpPFra848sZOBcO3WAi/Ta9tfUiXsBJSs/ArSxcuqB0gC9DwSmbBoA4RUBbd9GAmuHHIriJ0ynLYlGW0cxes7prNRZeCK+46fPwJBlTa5jegnPynLC4SunI8OyweJfXfUd2yiKYw6rhZuxU/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728160497; c=relaxed/simple;
	bh=q1+I+qi7RRRKyj37zYDmCgv6DDuGIALnITv4DV7u5uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCe2BGuz8b4e1ZNZOVwKyoynINLg6YashiQWC/zHMw9nv8tiIqsGRZI0ppmP+S+EB1E6Rf+PWShCwBd+eMn8AJ1a94obMohlfdYjYgddysaxDKTLetk9TYGqgiANndpKJEWxhQwFfTmyLHPdct+pmopueWcNzsGzDEIrZwrnFWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqlH8SN5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso31943965e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728160494; x=1728765294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvdqAIcZmdVsn+BXaPIVAuslbQWY2fWTXE+bajsMN+Y=;
        b=SqlH8SN5Khz6pyBs8hsUZdy2c3PqjaQwvDj/PnnQ4L64KEnkwSj7dsxyEKx90XsGyO
         qlwO2sg1ivn/LNAU+KUUaSs4XTZg45+axdJZcTMmWy9VtFgCZzG/vLbkrNrCDHiwvbIC
         DHD9z87UbIX6+sCx7Yzm42GpFuijQLIN1Cp/2Fv6rQ7NhPL/SjOLdikdbPmIy40hSij6
         3Gybeyk4r3uWRWhIB8YBaLNsD+xyPwViyZs4MqV3zUBWYJwVvDiIo+6/eNatPanM6pWa
         pFnW+yG8Q7q4eY0nbHpXY9pif6cvuisfCZWSHi66jDyv5IJAF++Sv92xrZ7/tQAhCvZJ
         uKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728160494; x=1728765294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvdqAIcZmdVsn+BXaPIVAuslbQWY2fWTXE+bajsMN+Y=;
        b=PX4lXM2hWICG4leFkEIz1VxA53CzN+avnTLUqBxMhN2sdjac6tyOhTcA3NqvcEe659
         o/69iucZU77ZJvIukS26kOq2qoBIG/+bDVQY91zgI88S2yL5qRN5wNz0yyGHfXHVtRQ0
         21dLx2+QQ5tS2vDglM6ltqKB4+z3M2UeWXUcS1SGuSEkN3LHLwYcAtTV9GulZ+ZiJYnz
         elJxMHEqKU97GeSgZotj/mdoZL7L5A2V6ttfRk8M4RX2Imo+S6ZWpUa5RV6d7sVsywVJ
         Nt31OMoSpIllR5qNKOz8g9ul8aUnv+7i6uc5MhtXm8V7ui7bcs00ODeLs88mMjSVVzMw
         +ffg==
X-Forwarded-Encrypted: i=1; AJvYcCXBWa2ZAkerhasT1x69SppDDaJfperLVkjWD3Z8DsNcyDqN2LUskDNi+n6k2qkE7uROEljZ2+3B1Tx0Umg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Uwqi+uZZNWczhuvjyg7Bu0NACJI7tybVr3/i46xvvvODPYfk
	OPoF2poqfnSS4eaJOigay+eoo/RfAGobLG+AagR4aFAgR+RtIr4CC5ZXB8k+
X-Google-Smtp-Source: AGHT+IGd91FqCQuN6SxeWzAMZSzwcbIs+051hxb67ZpDNIiJuwkmWU9pxfg2WqSf2VJjdy7JbiZYDQ==
X-Received: by 2002:a05:600c:3ba1:b0:42c:bc04:58a5 with SMTP id 5b1f17b1804b1-42f85af0e48mr53707005e9.33.1728160493453;
        Sat, 05 Oct 2024 13:34:53 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f85995932sm41824805e9.0.2024.10.05.13.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 13:34:53 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 10/15] staging: rtl8723bs: Remove function pointer read_chip_version
Date: Sat,  5 Oct 2024 22:33:53 +0200
Message-ID: <79b26478a2493a1d7c27f8e88e0bec56a653d082.1727966761.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer read_chip_version and use
rtl8723b_read_chip_version directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 3 +--
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 4 +---
 drivers/staging/rtl8723bs/include/hal_intf.h      | 2 --
 drivers/staging/rtl8723bs/include/rtl8723b_recv.h | 2 ++
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 451f54e5de09..8c80e0735840 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -21,8 +21,7 @@ void rtw_hal_read_chip_info(struct adapter *padapter)
 
 void rtw_hal_read_chip_version(struct adapter *padapter)
 {
-	if (padapter->HalFunc.read_chip_version)
-		padapter->HalFunc.read_chip_version(padapter);
+	rtl8723b_read_chip_version(padapter);
 }
 
 void rtw_hal_def_value_init(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 106f1124964a..578e8ebf07c6 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1610,7 +1610,7 @@ static struct hal_version ReadChipVersion8723B(struct adapter *padapter)
 	return ChipVersion;
 }
 
-static void rtl8723b_read_chip_version(struct adapter *padapter)
+void rtl8723b_read_chip_version(struct adapter *padapter)
 {
 	ReadChipVersion8723B(padapter);
 }
@@ -1823,8 +1823,6 @@ static void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_l
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->read_chip_version = &rtl8723b_read_chip_version;
-
 	pHalFunc->UpdateRAMaskHandler = &UpdateHalRAMask8723B;
 
 	pHalFunc->set_channel_handler = &PHY_SwChnl8723B;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 6d301b44fa23..9b0e9c0bf020 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,8 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	void (*read_chip_version)(struct adapter *padapter);
-
 	void (*init_default_value)(struct adapter *padapter);
 
 	void (*intf_chip_configure)(struct adapter *padapter);
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_recv.h b/drivers/staging/rtl8723bs/include/rtl8723b_recv.h
index a108ce89bce4..040c9af06eee 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_recv.h
@@ -87,4 +87,6 @@ void rtl8723bs_free_recv_priv(struct adapter *padapter);
 void rtl8723b_query_rx_phy_status(union recv_frame *prframe, struct phy_stat *pphy_stat);
 void rtl8723b_process_phy_info(struct adapter *padapter, void *prframe);
 
+void rtl8723b_read_chip_version(struct adapter *padapter);
+
 #endif
-- 
2.43.0


