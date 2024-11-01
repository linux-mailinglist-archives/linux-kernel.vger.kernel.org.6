Return-Path: <linux-kernel+bounces-392656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9669B96BE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3009D2832ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270691CEACC;
	Fri,  1 Nov 2024 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhKNcMQq"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A41CEAA2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483272; cv=none; b=t0Lf/n3yjd5qeqfYuFbJomkRiGCAox7JtL6EblISBLa/zeehPVy/my6MmKnREC24htFGTmzyVuuGjPvkeLex7mpRU918TAEDu5+KnavxTNfMmS68TKf869qeMGSHInPtpu13hlxPMFWmu897dhHcKySAl4rR9B1TsATWYQsRouk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483272; c=relaxed/simple;
	bh=Wv8MMXJ+Py8EDogJKlT4hNxcHSRfLmTQK6sZN9sF+mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRvpFrjHRf0/ovvM6714AdukWu7+/wLDIw//K3c2PZuRLwUQllJOpuPOB4jSBID7NHLSdOYTh5Mt77bxAd+hqdtYRXVPOupKzwLjarNUqvqtNVAOXG3ihhndgVw11eC9VLg4bz8GiTTK2dyP/mu7cLs64c4nTxcPaKLrfamIelk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhKNcMQq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4314b316495so19528415e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730483267; x=1731088067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FCsFKtTlniBMf+HskEurqf7ZwS4OL3ptDFkdbvDQH4=;
        b=VhKNcMQqsBBgsCpycmSEYj3hwzQlo6XC7FsdTPa0i6tXA+YEOfclPrB7v1LaOm3HIa
         HLoWdA/FsbjsbCME6RFT8DHYtzyKxby15uRct4sIBw8yt7VMUe15c/gdBbxePpmjql35
         v1C+XULX6KSNOY22oGlf3A3wclWue4GEA9Dofw++YV7LRljOsP3P6nxpDSRVFi7wM7kJ
         uSqK7nmSyfDkMqL5+bZtBRTL4gfnHTUyUE8/ToLlBnYJFyo5hJ9i0z6gKr9h+659Qri7
         YX00eBjUHtSgXIe895chHQJt6hzzUoIWdRCml434e99Sff4ZBo2vI++xpJfqnJWv/iGf
         tPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730483267; x=1731088067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FCsFKtTlniBMf+HskEurqf7ZwS4OL3ptDFkdbvDQH4=;
        b=cw84+cAy42HHRsV4lqoq36DOIrm+G8NQrOFugJXkdsVtT8MlgbT5nqbE1u3ZebzXRf
         zA20bBAlBXhtzH0EWMLpJjjxcDX6aztI02U1tytlqOW6jaxYSBbDv9rdW8h4drIc/Kho
         AxhZuyQVveX9Tjg2MJ4AnBf3NVMSHT5VUb5lVj0aO3Tn2B2QiL1M2Z0j5TL+fl1shOSM
         otCGEosOV/eQXdFkpp3XyXXrQa8NyculL5OZ9iNXSgSyfWUZXcdZ3xS4xOtpS4AzLywl
         gVWilndhmA4D3WInTbp4jDkZeaxNDpiBeEDlb6v6S2zGOigCn8MZg7S15tTeIAtknmZl
         G8RA==
X-Forwarded-Encrypted: i=1; AJvYcCVD1Qk6Br2kv+NsHPMZbGmQaVXlJfrwiGCjGChv4GuKT8u2FRWKk/0HPKpZ1c6NxPWhh4bp/oOIKn0seX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWioMFQ6mVJ8Lz4QyFx2R0ZaJ+gzaGG5Aa+F1XrEJIeS+TvCo1
	EuJidCUxD2SPAs+QBYACCYIz5U5XcFGmHWhuEb5GREAUS0in90Od
X-Google-Smtp-Source: AGHT+IGy0Pe0rjcA3JSYRD6Ge7Fw1LeHQXS2UJTErx1+bcXrKSz+uJrJP0zc8uhS4CtWPqZ87a2XBg==
X-Received: by 2002:a05:600c:524d:b0:431:1d0a:38e2 with SMTP id 5b1f17b1804b1-4327b6fd392mr70795705e9.21.1730483267083;
        Fri, 01 Nov 2024 10:47:47 -0700 (PDT)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1185b4bsm5732933f8f.112.2024.11.01.10.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 10:47:46 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 5/9] Remove GPIB_DEBUG reference and update messaging
Date: Fri,  1 Nov 2024 18:47:01 +0100
Message-ID: <20241101174705.12682-6-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241101174705.12682-1-dpenkler@gmail.com>
References: <20241101174705.12682-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 Change pr_alert to dev_alert

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 .../gpib/lpvo_usb_gpib/lpvo_usb_gpib.c        | 69 +++++++++----------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 4c580137043f..796c3a5be545 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -68,11 +68,8 @@ MODULE_DEVICE_TABLE(usb, skel_table);
  *	      At module loading:  modprobe lpvo_usb_gpib debug={0,1,2}
  *	      On the fly: echo {0,1,2} > /sys/modules/lpvo_usb_gpib/parameters/debug
  */
-#ifdef GPIB_DEBUG
-static int debug = 1;
-#else
+
 static int debug;
-#endif
 module_param(debug, int, 0644);
 
 #define DIA_LOG(level, format, ...)					\
@@ -366,10 +363,10 @@ static int one_char(gpib_board_t *board, struct char_buf *b)
 		DIA_LOG(2, "--> %x\n", b->inbuf[b->last - b->nchar]);
 		return b->inbuf[b->last - b->nchar--];
 	} else if (b->nchar == 0) {
-		pr_alert("%s:%s - read returned EOF\n", NAME, __func__);
+		dev_alert(board->gpib_dev, "%s:%s - read returned EOF\n", NAME, __func__);
 		return -EIO;
 	}
-	pr_alert("%s:%s - read error %d\n", NAME, __func__, b->nchar);
+	dev_alert(board->gpib_dev, "%s:%s - read error %d\n", NAME, __func__, b->nchar);
 	TTY_LOG("\n *** %s *** Read Error - %s\n", NAME,
 		"Reset the adapter with 'gpib_config'\n");
 	return -EIO;
@@ -412,8 +409,8 @@ static void set_timeout(gpib_board_t *board)
 	}
 
 	if (val != ACK) {
-		pr_alert("%s:%s - error in timeout set: <%s>\n",
-			 NAME, __func__, command);
+		dev_alert(board->gpib_dev, "%s:%s - error in timeout set: <%s>\n",
+			  NAME, __func__, command);
 	} else {
 		data->timeout = board->usec_timeout;
 	}
@@ -456,8 +453,8 @@ static int usb_gpib_attach(gpib_board_t *board, const gpib_board_config_t *confi
 
 	if (config->device_path) {
 		/* if config->device_path given, try that first */
-		pr_alert("%s:%s - Looking for device_path: %s\n",
-			 NAME, __func__, config->device_path);
+		dev_alert(board->gpib_dev, "%s:%s - Looking for device_path: %s\n",
+			  NAME, __func__, config->device_path);
 		for (j = 0 ; j < MAX_DEV ; j++) {
 			if ((assigned_usb_minors & 1 << j) == 0)
 				continue;
@@ -492,7 +489,8 @@ static int usb_gpib_attach(gpib_board_t *board, const gpib_board_config_t *confi
 	mutex_unlock(&minors_lock);
 
 	if (j == MAX_DEV) {
-		pr_alert("%s:%s - Requested device is not registered.\n", NAME, __func__);
+		dev_alert(board->gpib_dev, "%s:%s - Requested device is not registered.\n",
+			  NAME, __func__);
 		return -EIO;
 	}
 
@@ -737,7 +735,8 @@ static int usb_gpib_line_status(const gpib_board_t *board)
 	buffer = send_command((gpib_board_t *)board, USB_GPIB_STATUS, 0);
 
 	if (buffer < 0) {
-		pr_alert("%s:%s - line status read failed with %d\n", NAME, __func__, buffer);
+		dev_alert(board->gpib_dev, "%s:%s - line status read failed with %d\n",
+			  NAME, __func__, buffer);
 		return -1;
 	}
 
@@ -777,7 +776,7 @@ static int usb_gpib_parallel_poll(gpib_board_t *board, uint8_t *result)
 
 	retval = set_control_line(board, IB_BUS_EOI, 1);
 	if (retval != ACK) {
-		pr_alert("%s:%s - assert EOI failed\n", NAME, __func__);
+		dev_alert(board->gpib_dev, "%s:%s - assert EOI failed\n", NAME, __func__);
 		return -EIO;
 	}
 
@@ -787,7 +786,7 @@ static int usb_gpib_parallel_poll(gpib_board_t *board, uint8_t *result)
 
 	retval = set_control_line(board, IB_BUS_EOI, 0);
 	if (retval != 0x06) {
-		pr_alert("%s:%s - unassert EOI failed\n", NAME, __func__);
+		dev_alert(board->gpib_dev, "%s:%s - unassert EOI failed\n", NAME, __func__);
 		return -EIO;
 	}
 
@@ -869,8 +868,8 @@ static int usb_gpib_read(gpib_board_t *board,
 		goto read_return;
 
 	if (one_char(board, &b) != DLE || one_char(board, &b) != STX) {
-		pr_alert("%s:%s - wrong <DLE><STX> sequence\n",
-			 NAME, __func__);
+		dev_alert(board->gpib_dev, "%s:%s - wrong <DLE><STX> sequence\n",
+			  NAME, __func__);
 		retval = -EIO;
 		goto read_return;
 	}
@@ -910,15 +909,15 @@ static int usb_gpib_read(gpib_board_t *board,
 					retval = 0;
 					goto read_return;
 				} else {
-					pr_alert("%s:%s - %s %x\n",
-						 NAME, __func__,
-						 "Wrong end of message", c);
+					dev_alert(board->gpib_dev, "%s:%s - %s %x\n",
+						  NAME, __func__,
+						  "Wrong end of message", c);
 					retval = -ETIME;
 					goto read_return;
 				}
 			} else {
-				pr_alert("%s:%s - %s\n", NAME, __func__,
-					 "lone <DLE> in stream");
+				dev_alert(board->gpib_dev, "%s:%s - %s\n", NAME, __func__,
+					  "lone <DLE> in stream");
 				retval = -EIO;
 				goto read_return;
 			}
@@ -937,8 +936,8 @@ static int usb_gpib_read(gpib_board_t *board,
 			c = one_char(board, &b);
 			if (c == ACK) {
 				if (MAX_READ_EXCESS - read_count > 1)
-					pr_alert("%s:%s - %s\n", NAME, __func__,
-						 "small buffer - maybe some data lost");
+					dev_alert(board->gpib_dev, "%s:%s - %s\n", NAME, __func__,
+						  "small buffer - maybe some data lost");
 				retval = 0;
 				goto read_return;
 			}
@@ -946,8 +945,8 @@ static int usb_gpib_read(gpib_board_t *board,
 		}
 	}
 
-	pr_alert("%s:%s - no input end - GPIB board in odd state\n",
-		 NAME, __func__);
+	dev_alert(board->gpib_dev, "%s:%s - no input end - GPIB board in odd state\n",
+		  NAME, __func__);
 	retval = -EIO;
 
 read_return:
@@ -973,8 +972,8 @@ static void usb_gpib_remote_enable(gpib_board_t *board, int enable)
 
 	retval = set_control_line(board, IB_BUS_REN, enable ? 1 : 0);
 	if (retval != ACK)
-		pr_alert("%s:%s - could not set REN line: %x\n",
-			 NAME, __func__, retval);
+		dev_alert(board->gpib_dev, "%s:%s - could not set REN line: %x\n",
+			  NAME, __func__, retval);
 
 	DIA_LOG(1, "done with %x\n", retval);
 }
@@ -1072,21 +1071,21 @@ static int usb_gpib_write(gpib_board_t *board,
 static void usb_gpib_parallel_poll_configure(gpib_board_t *board,
 					     uint8_t configuration)
 {
-	pr_alert("%s:%s - currently a NOP\n", NAME, __func__);
+	dev_alert(board->gpib_dev, "%s:%s - currently a NOP\n", NAME, __func__);
 }
 
 /* parallel_poll_response */
 
 static void usb_gpib_parallel_poll_response(gpib_board_t *board, int ist)
 {
-	pr_alert("%s:%s - currently a NOP\n", NAME, __func__);
+	dev_alert(board->gpib_dev, "%s:%s - currently a NOP\n", NAME, __func__);
 }
 
 /* primary_address */
 
 static int  usb_gpib_primary_address(gpib_board_t *board, unsigned int address)
 {
-	pr_alert("%s:%s - currently a NOP\n", NAME, __func__);
+	dev_alert(board->gpib_dev, "%s:%s - currently a NOP\n", NAME, __func__);
 	return 0;
 }
 
@@ -1094,7 +1093,7 @@ static int  usb_gpib_primary_address(gpib_board_t *board, unsigned int address)
 
 static	void usb_gpib_return_to_local(gpib_board_t *board)
 {
-	pr_alert("%s:%s - currently a NOP\n", NAME, __func__);
+	dev_alert(board->gpib_dev, "%s:%s - currently a NOP\n", NAME, __func__);
 }
 
 /* secondary_address */
@@ -1103,7 +1102,7 @@ static int usb_gpib_secondary_address(gpib_board_t *board,
 				      unsigned int address,
 				      int enable)
 {
-	pr_alert("%s:%s - currently a NOP\n", NAME, __func__);
+	dev_alert(board->gpib_dev, "%s:%s - currently a NOP\n", NAME, __func__);
 	return 0;
 }
 
@@ -1111,14 +1110,14 @@ static int usb_gpib_secondary_address(gpib_board_t *board,
 
 static void usb_gpib_serial_poll_response(gpib_board_t *board, uint8_t status)
 {
-	pr_alert("%s:%s - currently a NOP\n", NAME, __func__);
+	dev_alert(board->gpib_dev, "%s:%s - currently a NOP\n", NAME, __func__);
 }
 
 /* serial_poll_status */
 
 static uint8_t usb_gpib_serial_poll_status(gpib_board_t *board)
 {
-	pr_alert("%s:%s - currently a NOP\n", NAME, __func__);
+	dev_alert(board->gpib_dev, "%s:%s - currently a NOP\n", NAME, __func__);
 	return 0;
 }
 
@@ -1126,7 +1125,7 @@ static uint8_t usb_gpib_serial_poll_status(gpib_board_t *board)
 
 static unsigned int usb_gpib_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
-	pr_alert("%s:%s - currently a NOP\n", NAME, __func__);
+	dev_alert(board->gpib_dev, "%s:%s - currently a NOP\n", NAME, __func__);
 	return 0;
 }
 
-- 
2.46.2


