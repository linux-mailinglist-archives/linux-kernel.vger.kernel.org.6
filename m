Return-Path: <linux-kernel+bounces-432881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE9D9E5176
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE4F1881C71
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1851D516A;
	Thu,  5 Dec 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDO2Dq1o"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AAA1CF7A1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391291; cv=none; b=a4FFOyAp1Hu55hZjWSweYYwJqjKvtMK2QZLM6A+bIuxcg9kGRgpR6E56x1BSu8Fkd1fJIKF1R8tViEfw3SzKbu+Sk3/R3s7t4/BJaSv+1WQx476LwawCzRSIQ4nyg6leb+iPtTYftaIm496lGjRwnorSMOqBDwifB+4B3x3OL7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391291; c=relaxed/simple;
	bh=rltCx31fQpuLz7eccLuZZQoglSA0TqpZcDzEc45bE4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uHZ3tNPG8cW0J6yE0GRl1xE5m8u6+kmdxcclzlGY7pk5GsmRmC5USztyCj82RN77HH5GfjAB3LZHwUsZIPHmPT1kdt03gj7ttExmN2dd/Qcy87zW54fK092MwW/52B8Ev+aB3n6i5JNFSc5ofNNZLSWLOnfVWbasmIKpUjoRbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDO2Dq1o; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385e0e224cbso332874f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733391288; x=1733996088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+97jMlCI1D0FZdR3+nbrjK/zuRlNUinJNWb46g4mfk=;
        b=EDO2Dq1ouJJAqyMllrDhcVhSOCiNuVAFSkBOFnUyuECTKblIfvhU71L8l51ORH1dUz
         DEMoXfzxJNfCeqEXGCsXs9Faok7gSkOkGZ6ZGs8hffemLcBA5GpxqAdvSF2Ntxy8DiwV
         segF43gtETmQKT31Rz6rLcqSALLWxfz5P1WZYouLxkQ5wg+7p50HXkrzyG6pxd7clkEP
         2HEhIMTkt6jTX59uTtcMxgoyLbeJxhHg519d2J+6AX0JYcYiZJNkv3t+P7ju6vorORH3
         WmC0iEQjW9VmNuaME7Ho3SLkqdx6xV3PkFgAypSw9xJ55WaBEAhVtrF4c1BzQVnkgTrI
         yiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733391288; x=1733996088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+97jMlCI1D0FZdR3+nbrjK/zuRlNUinJNWb46g4mfk=;
        b=oE8JkXITijE05Ke8r461LyxCeUk1ShEfXkaCm69R7tlMT0vzFpSdVD/8OJ9CsMDJCb
         TLRBIV4UZFW76bAtxuxZpyZhpC4WNC1R6JQSPqKQOfJ80E8qs3NAF4iSBSRGM7/uhWnW
         r1WBj9Jh60dX4oY8BotGx82enWVHil7aqX4AyfCcDT/PnKJAt3AOSxfrhh6WHI/0VFDB
         lRFrAzoKk4O3VVGkK+4FqlKxy5dcxjsKeP4aWI7IVAi456Ii6fd8Xe3Wbd7vBkk3hvzo
         6O43BO3qDARU0+fjL24JSbj38KQdWfEGFCtszVARiFyHFa8wfRIrgP6TyKnLgxE2NF9t
         YJDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvef3qtj6HsizR8CmgEqKZdXWVcWQrdwbmINN3pZ5SwXwDaTrTPbEGYXzbaOMkfYjXOF5COORDIkSn/xU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj2RvXw6ON3nLzxuqwwZ+0x+2z8swHgciUSFKkjSCceK+W08bG
	Xunr495gNZLQjFLtVz7IANkmNHjK96OJIVWAWmPMMlGT9WP4apOc
X-Gm-Gg: ASbGncsQkLu+kJi0oYM8yHArXEdAWmrmfTwI3tp1ExTbZWaolL2TaeY5wql92Neq4CD
	kEDsAQ0/Kj/kHFbeh70+YzjOp8PBq0koyu1zxWHQUg3VmMk0QUENjpzyA2bpXxTsM8RxfcCwYyV
	54+wIKPrhQ8XrdWSlEdbXPjwmNiRrz7ISHg2L6CInWZz4OdB1MSWa49Yodoxi6TcjY0EtvGNk2G
	TeACy4/wvzeq2KadX1SBfe6w35FKJ9OutrY7bhT+EY3YUuTAQYAyZ4hlk+M/uYZNHtZ8ZI89xfK
	Z0o4jl6CVw==
X-Google-Smtp-Source: AGHT+IGUbXbtXietuD43WTiX3xy6XxjT74K3zkI7eAyzgT8YxfTeQEjW0q/cIz9TwN/uMg9xMlFz7g==
X-Received: by 2002:a5d:6d89:0:b0:385:e429:e59a with SMTP id ffacd0b85a97d-385fd3f2febmr7339380f8f.25.1733391286595;
        Thu, 05 Dec 2024 01:34:46 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f4a8758sm1428180f8f.27.2024.12.05.01.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 01:34:45 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>,
	Marcello Carla' <marcello.carla@gmx.com>
Subject: [PATCH 3/4 v3] staging: gpib: Fix erroneous removal of blank before newline
Date: Thu,  5 Dec 2024 10:34:42 +0100
Message-ID: <20241205093442.5796-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The USB_GPIB_SET_LINES command string used to be: "\nIBDC \n" but when
we were merging this code into the upstream kernel we deleted the space
character before the newline to make checkpatch happy.  That turned
out to be a mistake.

The "\nIBDC" part of the string is a command that we pass to the
firmware and the next character is a variable u8 value.
It gets set in set_control_line().

 msg[leng - 2] = value ? (retval & ~line) : retval | line;

where leng is the length of the command string.

Imagine the parameter was supposed to be "8".
With the pre-merge code the command string would be "\nIBDC8\n"
With the post-merge code the command string became "\nIBD8\n"

The firmware doesn't recognize "IBD8" as a valid command and rejects it.

Putting a "." where the parameter is supposed to go fixes the driver
and makes checkpatch happy.  Same thing with the other define and
the in-line assignment.

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
v2 -> v3
Adopt and adapt the more explanatory commit message kindly
provided by Dan Carpenter

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


