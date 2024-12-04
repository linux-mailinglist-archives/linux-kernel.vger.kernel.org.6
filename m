Return-Path: <linux-kernel+bounces-431448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 274F99E3D74
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C39280C4F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FDD20B1F5;
	Wed,  4 Dec 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9CgI6eg"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6579020B1EC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324271; cv=none; b=Uhy1QCIB0gxZTnI2e09Nh7aEuuW6KUoR5dCn7qjatbTSdv/1F8ni6Cq9d9hZ2FcfcMDYZjlPuPWp0rfu/O/3E1wWYCrzy4Vtxs5jyMETdm/bCn4QWF89dqioCyJP0VZFPifJOb+QUwynpoGpMf6G7qrSbwA7VHA2PvdzRsFWQ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324271; c=relaxed/simple;
	bh=IQZ0iUbCC9xvjEAxIXAcFLwsoJQ/RJQF6AQ/NOmcWQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuoN7Q2bmSw84IJ1mwTCMhpeWIMzL2CeICO3+IGxcYnRR2vSE4ncVxhR7Bl0SIdyvuU//psoMzRGQWZtcKXc2y23KrRgnA/wtUXsF/ecOn7ySvclm+0tFXQtvMF08Y0U6KXe5LhVQmbv9JiJ6xYk89tqSG+OR9Jq9DMfKAKFgY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9CgI6eg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a736518eso84337785e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733324268; x=1733929068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmrmSp1fKYnprWCdDM12P2PuB9fwFiU34+5ag9mQwmA=;
        b=I9CgI6egG0G2mjTvsxBAdtD7VVQi2pUWKy11VOJzpLWaBTM/FSkf3obDkupQyhVRLb
         MIiO2S4fIwSB5S7jEPzp71pLXfjs1o/9TLgQswNyhGcGen2leNqUEuyAXDfCi6tCzhMk
         MF2OksMqXK8lcCVGeF1HU/ykkIYem/gbFwCLeSs1ENyFr0gJucrNnWDl56sEzaiG2T54
         LTFnrB4/502eiTFqDm0oXHUvYRukHynXHUm28G34jdIAVqFQDQhdwUqP3djmS/VO37ny
         BigST9dYPLPaVd9ZkvF79THEVWmhB5jQPtQvS9QBm8ryBFQ9ea6W9fWPCic+vz24VbOP
         Jztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733324268; x=1733929068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmrmSp1fKYnprWCdDM12P2PuB9fwFiU34+5ag9mQwmA=;
        b=hr+o/+/SO08uE6EHW85vD26bwy52V1RiuJ7yPaDdy/kkqkBVawXI1id7+SCE740+t6
         myvlONCvcbYcwhaT37nned7bKrxXeqTwBgejkLx07ZIkn412do8okUb2vEV2ntac9b3q
         I1sfXUAAoV3BRP+3xyvFfOnNNgntC4yOq//NVT3hUAaxntb+EiG7GIxhlqjANVspqP2s
         PKOnzipNOpH0C7n78L1dnXaLqSIctwkSRQJlAOog2szevCe6bil6xZh8ynxoSCbOD0VM
         U6N+lpVdm56F2SGkdKSfYoThW/2v2VRS15GMUg+rkRCtAEIrcz8dhnRnNUlkB1WABhEx
         NXEw==
X-Forwarded-Encrypted: i=1; AJvYcCW5Zs/SeFK60DW2mdu5TveiSBSOntceNcwiIuIMa+XRw8Z4/VBATOOOgVdag9cFwuhTn6RpUvQA8+k9lqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhhNL1sIA27IixLVvTSZEqOJNHZbhLS1ghc0UrE/YEOrrl4IL9
	qNaLV5uVLJKL5IzDFHHDjwcW3DVu6pC24QIQW7YzSPEUwbe6Q2phg6QdzHMl
X-Gm-Gg: ASbGncvkl5/jC7Tt70Dh5I9hiQpiLIMo7wFuzrTgiLJ/exeI5QY3Sl+EzoV4RrThZjQ
	8kN3Qon12/JO46TAHEzNQq4/4LyzpBUo9ooa34EQB305PqFNSmRzeLEZ3ySlBILP1VdG4aNWRa5
	tIUJP8dFVU0aGGHdrz5ghTB16qX8q6MKv5xtF88LHu1UpPR8CFvbFMRavM1cZuU0Sedxo48/3G6
	FLPpzURRErbgvH9TqDA64hxB3wOr6mPVhBl5X0dOKA1ZKVvh0gu7NGJ66jMvtZYlFjwCX1ysvRn
	sUuHvjPQ1Q==
X-Google-Smtp-Source: AGHT+IEb3yNqEWKu0U6iHfrsW75PsjsstsCnZ+2ZD9CQrrrFiOglaJeYkLYoz+JGopPvWBlMP/JW0w==
X-Received: by 2002:a05:600c:1989:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-434d09b2a75mr65718905e9.6.1733324267469;
        Wed, 04 Dec 2024 06:57:47 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527e8besm26678955e9.13.2024.12.04.06.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:57:46 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>,
	Marcello Carla' <marcello.carla@gmx.com>
Subject: [PATCH 3/4] staging: gpib: Fix erroneous removal of blank before newline
Date: Wed,  4 Dec 2024 15:57:12 +0100
Message-ID: <20241204145713.11889-4-dpenkler@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204145713.11889-1-dpenkler@gmail.com>
References: <20241204145713.11889-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace original blanks with "."

Reported-by: Marcello Carla' <marcello.carla@gmx.com>
Co-developed-by: Marcello Carla' <marcello.carla@gmx.com>
Fixes: fce79512a96a ("staging: gpib: Add LPVO DIY USB GPIB driver")
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 47db17418a74..c30db3615f49 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -97,8 +97,8 @@ module_param(debug, int, 0644);
 #define USB_GPIB_DEBUG_ON    "\nIBDE\xAA\n"
 #define USB_GPIB_SET_LISTEN  "\nIBDT0\n"
 #define USB_GPIB_SET_TALK    "\nIBDT1\n"
-#define USB_GPIB_SET_LINES   "\nIBDC\n"
-#define USB_GPIB_SET_DATA    "\nIBDM\n"
+#define USB_GPIB_SET_LINES   "\nIBDC.\n"
+#define USB_GPIB_SET_DATA    "\nIBDM.\n"
 #define USB_GPIB_READ_LINES  "\nIBD?C\n"
 #define USB_GPIB_READ_DATA   "\nIBD?M\n"
 #define USB_GPIB_READ_BUS    "\nIBD??\n"
@@ -587,7 +587,7 @@ static int usb_gpib_command(gpib_board_t *board,
 			    size_t *bytes_written)
 {
 	int i, retval;
-	char command[6] = "IBc\n";
+        char command[6]="IBc.\n";
 
 	DIA_LOG(1, "enter %p\n", board);
 
-- 
2.47.1


