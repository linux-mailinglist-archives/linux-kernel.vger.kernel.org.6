Return-Path: <linux-kernel+bounces-393992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3203E9BA851
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 22:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC462819FC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 21:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EE9198A3F;
	Sun,  3 Nov 2024 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoHKvCxX"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7B18E356
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730669203; cv=none; b=rHXWLTYTTGe4nS8wDIca0jMpNE1lh5pWShs6cio/KSsLOubLFtRPatIpmwiTL+AsT2u5MAs1+CTuMYN6g9SVmfb0z+Tl6L8ZN1WMe6ifbbAu3cpMLEoo+X5Pmk7bKF/3AdreExzVHyalPAF5fch15V4LQZJsXASzj67xD/VOdvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730669203; c=relaxed/simple;
	bh=pLnkhpeYKMc1lxFV3xV4m3dNh7n0yiuHjAX660xk0n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuXxcJ82a/l+slBkcqgAxUmBM/XTT903GNUuA4Kcx1KedmtEthdAFXGxUyYeFNzJTth5B5sSjkJQYfRtK1JSZqRD3qnoc6M8zcPHctAU41kFgo5iZdf/QBGulBm3bZ+Mtp8sriIKxJHRdPdD3IjLeNxClTMvmWVuqnTKrwnEooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoHKvCxX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314c452180so26962435e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 13:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730669200; x=1731274000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4LeEghsieJmKHP01xof54mT4MI7YKin+O0LeMS7tsE=;
        b=JoHKvCxXoUZz8306YO0008iwlwVt5dXWOZi8fge9uXHhrW7ZpqDL6IbhatzrUhS1XG
         v3MJMNgLV4OA6D8J0aRIak81etLVB3SdfxJxd5z9xFCNMxPR9avLRPfr5IuGzu/fFN+9
         nt8HHrxcx3GmqQZWaapU3FOUxiIZGzRv7zmxO4pDMrP3oFLw1vLAYHfOdYyZHkX4yee/
         kM2qta+FRCosEXVLT0Qjug2FCfegp4NlpnqKM/TICFiOedN+u4DanWd5s6tbUqdmrij4
         PEydd2ehHv8xdnuHdQ9lH6cklk2P6yDwmoD+n9vvgqClEOlFolIwV6gDUkiizRpCPq5T
         uTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730669200; x=1731274000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4LeEghsieJmKHP01xof54mT4MI7YKin+O0LeMS7tsE=;
        b=rOXvAFxUX5CA9H/rtmKnITuKFRBUe1S620uzks9lNWn88TH07/E3ugZAzkj9nWN/bI
         eLK/Ihpa/7lUo0M4Tgsdk0w2CvOXJ8+QmLZcTJRLq6OYIuVcej6QTsOt2nlbMHcAc7/J
         EeYmBt8kl5ukaWo0t8Av/GMUCHLIM4OHb/Yd72Sd//NYiospHHKhkLK7SQcZYpG/8hM/
         UpYIs/qobfstBQuQiUpATyyDt35A5V+s00wV1qeQHPQ42iZO1rmRdpIX9eNJj6wMX6Mn
         1J8qQTTyLVKRhxo/MJzTq8ft9FsO6C0A1dd58miR5ujvfs510ye40B+vKlIVI0w51Pi2
         Cr2g==
X-Forwarded-Encrypted: i=1; AJvYcCX7xb8AyLI5ICVCIxDrFNyp8TgspqZR/a6VnNhx/9HtVkMEIWvuP3aPJKdA0sh67mpS2p8NOXHtMGWLPYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrDBwRdVXHN+KRzZH/rGSQvwDPLv2KpdOqYTbR2MtzkIXBx3Ma
	dYaOQAj6uKLfnDiI8ennRJBk/unpGOZoJEVRPGbFBHcKklB4hnYP
X-Google-Smtp-Source: AGHT+IGCfoYcl/WTaMgKFNtbr1A1yYIsaop2G+srrkYcg7Rm1TPsNrDpmn2KsdRG4SdPzS+P/PuuhQ==
X-Received: by 2002:a05:600c:3549:b0:431:416e:2603 with SMTP id 5b1f17b1804b1-43282fe1df2mr79967675e9.3.1730669199664;
        Sun, 03 Nov 2024 13:26:39 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd910718sm166150385e9.12.2024.11.03.13.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 13:26:38 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 08/11] staging: gpib: Remove unneeded lookup table
Date: Sun,  3 Nov 2024 22:26:14 +0100
Message-ID: <20241103212617.13076-9-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241103212617.13076-1-dpenkler@gmail.com>
References: <20241103212617.13076-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove bcm2837 table as the only difference is GPIO14 and GPIO15
which are not used with the current pin maps.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/gpio/gpib_bitbang.c | 33 ------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 8c03e91c01dc..fc8502379c28 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -234,38 +234,6 @@ static struct gpiod_lookup_table gpib_gpio_table_0 = {
 	},
 };
 
-static struct gpiod_lookup_table gpib_gpio_table_1 = {
-	.dev_id = "",	 // device id of board device
-	.table = {
-		// for bcm2837 based pis (3a+ 3b 3b+ )
-		GPIO_LOOKUP_IDX("GPIO_GCLK",  U16_MAX, NULL,  4, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO5",	  U16_MAX, NULL,  5, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO6",	  U16_MAX, NULL,  6, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("SPI_CE1_N",  U16_MAX, NULL,  7, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("SPI_CE0_N",  U16_MAX, NULL,  8, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("SPI_MISO",	  U16_MAX, NULL,  9, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("SPI_MOSI",	  U16_MAX, NULL, 10, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("SPI_SCLK",	  U16_MAX, NULL, 11, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO12",	  U16_MAX, NULL, 12, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO13",	  U16_MAX, NULL, 13, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("TXD1",	  U16_MAX, NULL, 14, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("RXD1",	  U16_MAX, NULL, 15, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO16",	  U16_MAX, NULL, 16, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO17",	  U16_MAX, NULL, 17, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO18",	  U16_MAX, NULL, 18, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO19",	  U16_MAX, NULL, 19, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO20",	  U16_MAX, NULL, 20, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO21",	  U16_MAX, NULL, 21, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO22",	  U16_MAX, NULL, 22, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO23",	  U16_MAX, NULL, 23, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO24",	  U16_MAX, NULL, 24, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO25",	  U16_MAX, NULL, 25, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO26",	  U16_MAX, NULL, 26, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO27",	  U16_MAX, NULL, 27, GPIO_ACTIVE_HIGH),
-		{ }
-	},
-};
-
 static struct gpiod_lookup_table gpib_gpio_table_2 = {
 	.dev_id = "",	 // device id of board device
 	.table = {
@@ -300,7 +268,6 @@ static struct gpiod_lookup_table gpib_gpio_table_2 = {
 
 static struct gpiod_lookup_table *lookup_tables[] = {
 	&gpib_gpio_table_0,
-	&gpib_gpio_table_1,
 	&gpib_gpio_table_2,
 	0
 };
-- 
2.46.2


