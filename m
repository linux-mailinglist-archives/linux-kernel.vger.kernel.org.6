Return-Path: <linux-kernel+bounces-352139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2621B991AA8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3E4281E16
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F873176252;
	Sat,  5 Oct 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5zMzXz7"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4CC16F908
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728160495; cv=none; b=kAjTmR0mHoEobyL22IVlBAduq4XKJOx8w8SQF2EmUyrEhSllD1Sd7StJaDAjQMdpk8uOfNsAeEv6Aak3IeZkffHPMmVZiu8EgmRTs6wySPbHDFMlFkA9SrB6mTdJE6wJwIxcXyzyu3p8+Th2uNg3yAIS9WYcdxfAuYPeT6S2lYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728160495; c=relaxed/simple;
	bh=Jm1rGgJTi+mCasyO4bMyXN8oeJxCKBSRh5MsXJXwyNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bny0spBPXHDmIbLMFo6Abz3gII9rbzdJn9pLdBRL0KPxNU1A5ZczM/OAlgqfhva8gpd23EuQF56NFyta8PrBBXf/7g68S6sO6kkts802eswOaWMnpS4raZ96kmCFyNv+za2qogoo6cHCWnHBYhwq5Qx2ymXiqzx/xvJPEgYCxCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5zMzXz7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so26667975e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728160492; x=1728765292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Wi+hIllgebzi4E1LyxylRUbiLWFw6eryMs3u2YRRFU=;
        b=j5zMzXz7CwwGDL/i0NtdotTsb8o0DowNqeA2XmB8N0i1gvBFPX5JeAEO6kbIfEtWax
         MUdPI0gR3EcEF9SuODkrTWrT46vlV3CUj4k3bYQL3LYuOcBB13mKgYbh7m7IrPJDqr0d
         4VjMIjOYPaVuLhaDthQ8Lao/IpwCXlgoCgjuwOQJlUtClpNklV+pQknGwBd4vtJx1Cbj
         5HFKjXUwPFY8SJre+5Cu/WPbdt4JVpLVsGkkY4RF8lmgfz6sF79GjrqvKWbJT54BQPZz
         pOs6Z8YyuKHANKPPEJL9quLKyDE4FETppVhhTkq9nHBh220Gev2VQx1glqSdSXbfdjuJ
         axuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728160492; x=1728765292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Wi+hIllgebzi4E1LyxylRUbiLWFw6eryMs3u2YRRFU=;
        b=uBQbie9EQXUJltww6oHweRkFQZWsx+CiunDqJIBkcsinTfYT6KLF+Derq53IbjUFBv
         sZw8YSZNATTDvbM0c7bn3L7xdkDGljD+aQr7ZRJXYUjlfBZKH1ObL7zJsNNIiwDSdrZt
         1iidUAMAE06j6dJbDRngdRs9H2oxwFwivB1EpJGPVZMZDuo1jb/fMoIU9d/+qAeHnKur
         83LjUAU+LNsrPb6iwrz0d9YU9A3amQ+OuBT0Tbn2mZPrbRng6+qdbwcP6APjPxwTmePf
         bFg52Z3YLYrYjYuJoOo9RWxtYWU8DT+sllcFB+RwGb7ymnaOAGo8Qw8R1iepZ+Kr2Atk
         +/eA==
X-Forwarded-Encrypted: i=1; AJvYcCX11/MguqT0nnxA0MKi50HVaVtaz6vxL7LDuqXQ4v4tm4dtTOpoRKgM/3KhCfymvMsCahbo/k9CR26NMSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCIRMrLVSlYGilyqRLatdmzjdB2VMbq67xtlMgq4bxVYq2aj1D
	Nzs1HuSQCmmBnZyT25WVhKV9EtkbI2LsbEQzSMPG7sPpjmMUZXEL
X-Google-Smtp-Source: AGHT+IGk4Rda6bc641qDF72QqSR+3nlF1zPT8cTBSwlrSfc96+yP7+osH55oyi+/xpfK8NlP7gh9iA==
X-Received: by 2002:adf:a198:0:b0:37c:d20d:447c with SMTP id ffacd0b85a97d-37d0e779f64mr4039355f8f.29.1728160491566;
        Sat, 05 Oct 2024 13:34:51 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f85995932sm41824805e9.0.2024.10.05.13.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 13:34:51 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 07/15] staging: rtl8723bs: Remove function pointer free_recv_priv
Date: Sat,  5 Oct 2024 22:33:50 +0200
Message-ID: <17f06e3495abea1f6ad2a2f8d4f4ff1f23bef654.1727966761.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer free_recv_priv and use rtl8723bs_free_recv_priv
directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c     | 3 +--
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 2 --
 drivers/staging/rtl8723bs/include/hal_intf.h | 2 --
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index d571bf81ab2b..de7dfaa69c66 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -235,8 +235,7 @@ s32	rtw_hal_init_recv_priv(struct adapter *padapter)
 
 void rtw_hal_free_recv_priv(struct adapter *padapter)
 {
-	if (padapter->HalFunc.free_recv_priv)
-		padapter->HalFunc.free_recv_priv(padapter);
+	rtl8723bs_free_recv_priv(padapter);
 }
 
 void rtw_hal_update_ra_mask(struct sta_info *psta, u8 rssi_level)
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 8d2a44726fc7..52cd980c2003 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1259,8 +1259,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->free_recv_priv = &rtl8723bs_free_recv_priv;
-
 	pHalFunc->init_default_value = &rtl8723bs_init_default_value;
 	pHalFunc->intf_chip_configure = &rtl8723bs_interface_configure;
 	pHalFunc->read_adapter_info = &ReadAdapterInfo8723BS;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index cc01b8d56498..ced414f2368e 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,8 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	void (*free_recv_priv)(struct adapter *padapter);
-
 	void (*dm_init)(struct adapter *padapter);
 	void (*dm_deinit)(struct adapter *padapter);
 	void (*read_chip_version)(struct adapter *padapter);
-- 
2.43.0


