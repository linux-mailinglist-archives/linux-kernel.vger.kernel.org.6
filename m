Return-Path: <linux-kernel+bounces-387718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7139B5539
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8608EB21AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD8A209693;
	Tue, 29 Oct 2024 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="Kcp94Qz6"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0541422AB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730238190; cv=none; b=Uyy4c/9Zu+XwndvIACBAqgGrboAeOYzDnMr7QQnSL54dTf13JU/IkjD2S21sG8gBH06MZNcpSXR2YclkMxymFve8u3gz2ZWvXDsWr4tUM62p8TThSqXh9LyI4QHQ5jdR0OuDphKpY9IPqgQxCiOMAm/S+Z4ksab7+8LPSBVs72k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730238190; c=relaxed/simple;
	bh=w5jKC7IyDXKFeyn7ERMAdvanHn38cQ9zy1K2YLWaVOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k04B9DR43hsfJJwSwENtd5YyWoRvo5MgjyNEcmWqM2FXqsh6DRmzqpZ7l3xptc6hUaoLM6kDRBFdkJHd+DPaJr0rcTYz/l+S1OTE74YqaFkqE35NysQfUIPnSDMaRQ/Wq98t6emdeI7G6sp4aRv+lrL/9enpvsemNHoMMV2gDqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=Kcp94Qz6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so3771762f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1730238186; x=1730842986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hcs5fqb96ycIMcokdiYuAt/6DUNMqB+pMWzri0juKvI=;
        b=Kcp94Qz631V77icHgx0Z6P0dF8HUCFBUs9eKWUXeUg9+bGuSz3J1CvWt3hC4wFO4Zh
         3FRHBz6y98kcbkYEDpBalGq2jrWNe3Vmn6EyY1yo5/GpYgJyp+ha22dnFuY8jTxwkHg8
         nmxLPBcraZbcU+9bz71rDfIJGukmSn+DoNl4QXWweAtMpgH1kvuNcrWKI5VR5hfB9TjC
         oZ8W3FoL8xixB8mZrfS3NaaQuF0yjxAfiWBben5xEveOb2vcnCWkSdtYdN9R1ujyBSlR
         m0eu8EioSi+j8AJhHx+nUQ+gfgHs5i6dKeeWpH0emY1xt4CdK85cvWASmqp9DM2Jcq61
         Az/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730238186; x=1730842986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hcs5fqb96ycIMcokdiYuAt/6DUNMqB+pMWzri0juKvI=;
        b=g3yegxjGCTUDPMhZ1Zbb5GdD+561xSUh0Dj4w3pNq8mHvCxbLbSUWYfOa6AnYWMmYf
         auIIt5bnGox1Vto9xNkYtdfSPfCCiefRPwbGHX3hVWfl+BgOqSE3812kHOUhBmlamBU7
         iEccJ0gQ+HUJmzHe8k/wzVlMa83y6jks43dobOvEBi0dY1jZaEWgfa11GSwQ/GMvxfy6
         RuYN+JU0emxazw4SJrqYVd0fcmzets+ogQjgbPtzz2pxOsbBkWsH6LgtWZkWZP6/YNW7
         ZT6nOI91tAFcGSmbVJUpoR6658lNW7aySmJVuBIrtWz6A4CmJ5G7D/uWKCTy7sTLjwXV
         KRcw==
X-Forwarded-Encrypted: i=1; AJvYcCXKuEHLKV4ajhQT+y0FeyeV+41Xiky9vPkbmuJvO4sKGgGwv7y93DpbLt0NyUrzFFZBu+Wg2BjsDyUVLxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLH6nyOTKLKXUB6rH9KwFu3zMK2S1gWPpqad9RpuTffxGXljUW
	gDWMwHhdyoRneXxm17WHPLfJwvt0gfHaEtXBBnz96npuqMrrfLx/h18ZTuMc8MIBKtO1UNxR6kP
	Q
X-Google-Smtp-Source: AGHT+IE1+r+8wMyu6u1Pr3137wczmAuiaUVuSzCdfqbU6L+re41EZx4bAjP2dkFAXalc12q9O3LJvw==
X-Received: by 2002:a05:6000:1f06:b0:37d:481e:8e29 with SMTP id ffacd0b85a97d-38061159039mr8658048f8f.25.1730238185766;
        Tue, 29 Oct 2024 14:43:05 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c559:9886:6c0b:569f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1333bsm13565532f8f.14.2024.10.29.14.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 14:43:05 -0700 (PDT)
From: Antonio Quartulli <antonio@mandelbit.com>
To: gerg@linux-m68k.org
Cc: geert@linux-m68k.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: [PATCH] m68k: coldfire/device.c: only build FEC when HW macros are defined
Date: Tue, 29 Oct 2024 22:43:15 +0100
Message-ID: <20241029214315.26710-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_FEC is set (due to COMPILE_TEST) along with
CONFIG_M54xx, coldfire/device.c has compile errors due to
missing MCFEC_* and MCF_IRQ_FEC_* symbols.

Make the whole FEC blocks dependent on having the HW macros
defined, rather than on CONFIG_FEC itself.

This fix is very similar to commit e6e1e7b19fa1 ("m68k: coldfire/device.c: only build for MCF_EDMA when h/w macros are defined")

Fixes: b7ce7f0d0efc ("m68knommu: merge common ColdFire FEC platform setup code")
To: Greg Ungerer <gerg@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 arch/m68k/coldfire/device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/device.c
index 7dab46728aed..b6958ec2a220 100644
--- a/arch/m68k/coldfire/device.c
+++ b/arch/m68k/coldfire/device.c
@@ -93,7 +93,7 @@ static struct platform_device mcf_uart = {
 	.dev.platform_data	= mcf_uart_platform_data,
 };
 
-#if IS_ENABLED(CONFIG_FEC)
+#ifdef MCFFEC_BASE0
 
 #ifdef CONFIG_M5441x
 #define FEC_NAME	"enet-fec"
@@ -145,6 +145,7 @@ static struct platform_device mcf_fec0 = {
 		.platform_data		= FEC_PDATA,
 	}
 };
+#endif /* MCFFEC_BASE0 */
 
 #ifdef MCFFEC_BASE1
 static struct resource mcf_fec1_resources[] = {
@@ -182,7 +183,6 @@ static struct platform_device mcf_fec1 = {
 	}
 };
 #endif /* MCFFEC_BASE1 */
-#endif /* CONFIG_FEC */
 
 #if IS_ENABLED(CONFIG_SPI_COLDFIRE_QSPI)
 /*
@@ -624,12 +624,12 @@ static struct platform_device mcf_flexcan0 = {
 
 static struct platform_device *mcf_devices[] __initdata = {
 	&mcf_uart,
-#if IS_ENABLED(CONFIG_FEC)
+#ifdef MCFFEC_BASE0
 	&mcf_fec0,
+#endif
 #ifdef MCFFEC_BASE1
 	&mcf_fec1,
 #endif
-#endif
 #if IS_ENABLED(CONFIG_SPI_COLDFIRE_QSPI)
 	&mcf_qspi,
 #endif
-- 
2.45.2


