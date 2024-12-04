Return-Path: <linux-kernel+bounces-431820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0159A9E4321
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8AFB3A24D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34A921D5AB;
	Wed,  4 Dec 2024 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atQTsiq1"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F22F22D4EA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331936; cv=none; b=h4L7Mucea2vTEFrTUeE2FU7PMj6jD9O8FMaD39E1ohlFjF1yexKLFZ0x8nH8k0hrohA3h0HFO54q+kWbTToFuAtvAZVY2IERNw7f+8IEHmBj4WXDXluLpm0ExBcz3Ysz726aJrcb9TvjjNS3lwN1KaZTRFokFr4k7Ht1L1YBaF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331936; c=relaxed/simple;
	bh=SwdIkwAyBADHolNVHGKonu13CQKyD3zHMnYIOIO5/MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ocq/tEWGNP9lx3FHhg4Sa0N4ufvK4t7QT391QLauWIO+FCONFeSUKm+ooS4txh1qnu2kotMgNFnv0cDeNQz7IvpM0ROi4GoIUg5xo09iRA5epdDNPz+hT+BTF53KT80Z1ZVfEdw0ZaGL57PvU6VQsH7WDe3jDknkA7+2TtZ/4j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atQTsiq1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a9f2da82so109335e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 09:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733331933; x=1733936733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9cuQDS9XjCoh01d12eDFy34pmkiiHwb9j2F8JlmKFAE=;
        b=atQTsiq1HUz3tHI6wteN2wd9nRLOW/J8ZZdT+vau3PpbAZ1833JSv6cQJR3zF7CAqE
         N1RiYJ6/BnwPFybZvA3agY8xP0ys4lx7JHj7YYyRwHOgxGaSaPT1hd0JGLa1MDpJ0GZu
         D7QaRe1CmGzlJCAEz++giCOmECulRJ3I8jo793qV3UiChOHXrlkH+0tMj/c7qQog2fQT
         6x6sAyxNRdBLKKwU1bYjYRpFxBrOUO9BGmIiYsFjIVjCKlJP94oLJMF+0dMgQpkOj39v
         I7O4FnIk+pcmkkA0FLTRZVRqvaWOpqF/tPsxyUx2yc4G8JKmgeCcqbyv0/dxvFkCPe5U
         BlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733331933; x=1733936733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cuQDS9XjCoh01d12eDFy34pmkiiHwb9j2F8JlmKFAE=;
        b=kA+VA0M2z3qLumc7KAVZsAoBSV9TvyeeBtciHXs3kF+QGDZ2TyQuiDuE+Ms/plRebI
         xqDdwb2+joEJPwUEaXU6v4G3BGUsDo9X+/zaQJaBWk21J3Z/Cb3MeMZRibmR/qfRFlyJ
         ul/BmdcCu4D6ZknWIjjP2ghTTesakWfqkiOJgk9y6oPxoHtpQ7n7FftN/3zsCk7cQm4a
         Ou9qYThn77icODsafDEoF1tO0gbXPCZ1vsipwQP34kASDsYBoD7f2QNSCQRMw6vx3wJ4
         Z3qgdDjO8Hg2lt7RBgAaozfXqnQwzPXj4M6oSqF+I+1ATjTHn1/yLQAmqmnqSuLjqycM
         M+2g==
X-Forwarded-Encrypted: i=1; AJvYcCX8k2rLVXvEhaC7664DAjBet038nVGxHVIabnIc8rXH7KwDqllLrCVlbd6e+uD2Cx7KOqKvSxc8uhR/R8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKnx7Gam5Gfau3rnkrSSQVz4lVPJiYa/ji/2G1leapw0SyR9/F
	MwuVm1LJqSG9bJZ79/TtKrOf2awSaSr4kj/Nei4p10+A6abcm+qg
X-Gm-Gg: ASbGnctxp/BhzvoYL/WseTmPjR4y8dmas9Yqpo9JoC8xuKUJyVfYiDiSCSvW6xKiojq
	l+HTJseGZwplX0F1x69+ZLsP5fNaJ7aLdPK6djn+m5pmB5tW3uIm4YJGtVHXcABxDNoLC//Inp3
	0qarMIF/Z6S03SJiZhW6SlZX62+Bl/Oex82289buG4TU59vfBq80rKMdc9hq7ICTGEPM47C/T8v
	war1wegdd+8N5ohWTWTeM99JSGsM+J29S1baPvKMVf3Te3tq6Gri8up01HYb3gHD5Hp+S52fMT5
	gvfbIK/OSQ==
X-Google-Smtp-Source: AGHT+IH6Z+DHxmfTB0THiad8h84UNVfaQ7Wmykz0fyCn8uzv/XiXEMhZdpHTCuKzRh2vvihTlptIgw==
X-Received: by 2002:a05:6000:4025:b0:382:31a2:17fd with SMTP id ffacd0b85a97d-385fd532b93mr6685415f8f.55.1733331932630;
        Wed, 04 Dec 2024 09:05:32 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385d80a77a0sm17025470f8f.58.2024.12.04.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:05:31 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>,
	Marcello Carla' <marcello.carla@gmx.com>
Subject: [PATCH 3/4 v2] staging: gpib: Fix erroneous removal of blank before newline
Date: Wed,  4 Dec 2024 18:04:43 +0100
Message-ID: <20241204170443.28333-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original commit removed the blanks before the newline
in the protocol string constants to satisfy checkpatch.pl
This broke the driver since it relies on the correct length
of the string constants including the blank.
For example the original
  #define USB_GPIB_SET_LINES   "\nIBDC \n"
became
  #define USB_GPIB_SET_LINES   "\nIBDC\n"
which broke the driver.

The solution is to replace original blanks in protocol constants
with "."
e.g.:
  #define USB_GPIB_SET_LINES   "\nIBDC.\n"

Reported-by: Marcello Carla' <marcello.carla@gmx.com>
Fixes: fce79512a96a ("staging: gpib: Add LPVO DIY USB GPIB driver")
Co-developed-by: Marcello Carla' <marcello.carla@gmx.com>
Signed-off-by: Marcello Carla' <marcello.carla@gmx.com>
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
v1 -> v2
  Add more details to the commit message
  Add Signed-off by co developer
  Add spaces around assignment
  Fix tabs
  
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 1a8eb3bfb61c..81c110f29e76 100644
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
+	char command[6] = "IBc.\n";
 
 	DIA_LOG(1, "enter %p\n", board);
 
-- 
2.47.1


