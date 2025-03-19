Return-Path: <linux-kernel+bounces-568818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7021DA69AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119441691D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CD5216392;
	Wed, 19 Mar 2025 21:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="ij+fpfOr"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3DB20A5DE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419115; cv=none; b=UxDMOBuL7ZsblUHHFAGo2tCcBr3MV13ZCeqAluN4afDiizrOe3VKRbfQq3RFVIEsV6l73kkyckOou76hVtvcee6nNdT7tgqg99MPbHET/iMVNvJ2ZRZDE56ZWH7UUnl/Z1NTnswAEYMHNZlX1ko3HHJisr8o6XTqlOSXnXmy/Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419115; c=relaxed/simple;
	bh=g9VGSXs6FgAQnURtC6/R+xRc2ic1cEW9VSobMLBEqm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uw7kkmmbydJeujd5Xy5JiuBreV3/IwFPucgdJyLdb+K9W69GSFVLv51++QfgZ1Zi+m2HRa+PXY27qXkYLFXEDVt/zzulBK5vcYb38+qewca4QCHuruinY1QruAY5Gk2hI9vZw5VmCNsEuyZ/8nycMmJsSDt/TipA+S/ju12u8ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=ij+fpfOr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2235189adaeso2059675ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742419113; x=1743023913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9hVRSfMV30A1D78z4/Or9aFVqloXuvJpP3+HNYzg+s=;
        b=ij+fpfOreetRuNAlc0sNcMGfRg7x2B3c3QxkHwJKiPqI/cBvOPdEUT+bhOHrATTqfR
         8JpW2+8z+QZy+1kHnKJS53AGYKo7dR4DEXQuOw3a1t44eytga1AheQacuerWdZKD4cDT
         Pq7OkTceKT5AWtd8sUQvLQFV/c55raP4QPlMcPhp2IL6JXnVLVs2YB2eD4QTEkEFAvpW
         +Fcy5x5uofvkJqB+hXBzKSX0goVJr9jXYkkRq7/5PN8tGW4Iq0TMiohAJy/lw0gAQ2nc
         bFZMZWcG4eNvbAjZlJqs07yRHB27nHQRdCdaBGEurzbPv1Nlu4kQSWWdxjo4zwKk89uQ
         0ofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742419113; x=1743023913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9hVRSfMV30A1D78z4/Or9aFVqloXuvJpP3+HNYzg+s=;
        b=ZXa7RxuEFMRWp4e1iF4/6gbps50sVgX3PZMdvodlHAJz6UoOrzATBOCU7r/EpvseRp
         ReQi6mBhRFys5TisT0y2IQaF+ZgxxqS5eB20fTs8IzYJilPV4W7z//mZnlweZ+TzBQjL
         MY/TTJh552SOjwc9lG01sTu7SAVreknqnS7NokO/UK28tG5bKeKFJI5Zvsw4zZLutRHt
         Y9e7+ckTNq//cNeHqzgUhjHTme7UXNi9boEEUgJGyTHNrCQ1wUUjTa5uokEcgZYJi2XN
         M7FcZBXZg4IL+MsMt7yhpEtlEiEXZrO5LKQg1wEFAsp1cfatGymN4igURXDzqhCBHZlE
         FrHg==
X-Forwarded-Encrypted: i=1; AJvYcCXnm47iZLJgdGTtoMgUhvBPGG8Eq301nF+RC5wx08LjeQCj4S+0f/LreaGN7lcnIWYVh6We2o0XLbZKtxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhH3RC15D6WJ165y1bJL4XCqsxTuzZN7YXUNz91ERcAEh+drRh
	7xKyxcQvX2MJjU8PIA5PoGYKmJA6Ig8Lj6QDP2o4munLWxR5iRaLa1cr/KdIsX+7+nAgN6/x18w
	=
X-Gm-Gg: ASbGncvUSaFubQ6hGHC5vo7mgKdU8rVFbkCOh5q50OQf17V3f8vVLRRcqIOR9wTHUOM
	CZWnA4o5k8fv5WMM2jrRE3gihljbCv6Ca2aZMCemsQQOigWebArWSna6MfLiIq+PXFnEqIgB2sr
	mLV/Nz+EY1IbAZ0u5EHRXetiNmcOJwykUGQUcsqKfmdgVbao1UGZUlN0T+n4Aa636LKpvL0sfR5
	tz+1HKG2fwxg9C6y8iXgXuHAiqMYVbgKcp4cXlFdUT0VBaCUZrIpfknag978jn1gJCNMAUT5i/5
	GQllkUMc4U4vQAnXZAjrW9SdHbZRwNDSOqpcVWuH3Qn0t/bzQSPrCCoxHA5KmHA9G4gYMtgHTDB
	sTMrdYbRKkIIkYo8XH2v9
X-Google-Smtp-Source: AGHT+IFWHpXSfD4PIjfgx+fhtfYq3mUXPvFlXT63ZdS9mHNoB2TreiRKiJNru08Ka9FgkWuD7TM5lg==
X-Received: by 2002:a17:902:c952:b0:223:4d5e:76a6 with SMTP id d9443c01a7336-2265e690ee3mr13326215ad.1.1742419112698;
        Wed, 19 Mar 2025 14:18:32 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6d0asm120051115ad.130.2025.03.19.14.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:18:32 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 2/2] staging: gpib: Correct CamelCase for VALID enums
Date: Wed, 19 Mar 2025 21:18:27 +0000
Message-ID: <20250319211827.9854-3-matchstick@neverthere.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319211827.9854-1-matchstick@neverthere.org>
References: <20250319211827.9854-1-matchstick@neverthere.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style.

Reported by checkpatch

CHECK: Avoid CamelCase

Signed-off-by: Michael Rubin <matchstick@neverthere.org>
---
 .../gpib/agilent_82357a/agilent_82357a.c       |  2 +-
 drivers/staging/gpib/cb7210/cb7210.c           |  2 +-
 drivers/staging/gpib/common/iblib.c            |  4 ++--
 drivers/staging/gpib/eastwood/fluke_gpib.c     |  2 +-
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c       |  2 +-
 drivers/staging/gpib/gpio/gpib_bitbang.c       |  2 +-
 drivers/staging/gpib/ines/ines_gpib.c          |  2 +-
 .../staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c |  2 +-
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c      |  2 +-
 drivers/staging/gpib/tms9914/tms9914.c         |  2 +-
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c    |  2 +-
 drivers/staging/gpib/uapi/gpib_user.h          | 18 +++++++++---------
 12 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
index 7d660e558fbe..5b5b55e90435 100644
--- a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
+++ b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
@@ -978,7 +978,7 @@ static int agilent_82357a_line_status(const gpib_board_t *board)
 	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	struct agilent_82357a_register_pairlet bus_status;
 	int retval;
-	int status = ValidALL;
+	int status = VALID_ALL;
 
 	bus_status.address = BSR;
 	retval = agilent_82357a_read_registers(a_priv, &bus_status, 1, 0);
diff --git a/drivers/staging/gpib/cb7210/cb7210.c b/drivers/staging/gpib/cb7210/cb7210.c
index ba02dce62dd9..808e0a71dfd6 100644
--- a/drivers/staging/gpib/cb7210/cb7210.c
+++ b/drivers/staging/gpib/cb7210/cb7210.c
@@ -379,7 +379,7 @@ static int cb7210_accel_write(gpib_board_t *board, uint8_t *buffer, size_t lengt
 
 static int cb7210_line_status(const gpib_board_t *board)
 {
-	int status = ValidALL;
+	int status = VALID_ALL;
 	int bsr_bits;
 	struct cb7210_priv *cb_priv;
 
diff --git a/drivers/staging/gpib/common/iblib.c b/drivers/staging/gpib/common/iblib.c
index 1caa57b41596..92e792e12301 100644
--- a/drivers/staging/gpib/common/iblib.c
+++ b/drivers/staging/gpib/common/iblib.c
@@ -76,7 +76,7 @@ static int check_for_command_acceptors(gpib_board_t *board)
 	if (lines < 0)
 		return lines;
 
-	if ((lines & ValidNRFD) && (lines & ValidNDAC))	{
+	if ((lines & VALID_NRFD) && (lines & VALID_NDAC))	{
 		if ((lines & BUS_NRFD) == 0 && (lines & BUS_NDAC) == 0)
 			return -ENOTCONN;
 	}
@@ -520,7 +520,7 @@ int general_ibstatus(gpib_board_t *board, const gpib_status_queue_t *device,
 		status &= ~TIMO;
 		/* get real SRQI status if we can */
 		if (iblines(board, &line_status) == 0) {
-			if ((line_status & ValidSRQ)) {
+			if ((line_status & VALID_SRQ)) {
 				if ((line_status & BUS_SRQ))
 					status |= SRQI;
 				else
diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
index 4e04acfdb48d..bcddf3125b8c 100644
--- a/drivers/staging/gpib/eastwood/fluke_gpib.c
+++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
@@ -195,7 +195,7 @@ static void fluke_return_to_local(gpib_board_t *board)
 
 static int fluke_line_status(const gpib_board_t *board)
 {
-	int status = ValidALL;
+	int status = VALID_ALL;
 	int bsr_bits;
 	struct fluke_priv *e_priv;
 
diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
index 8fbfa7e285af..3e8ad8aa332f 100644
--- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
@@ -229,7 +229,7 @@ static void fmh_gpib_return_to_local(gpib_board_t *board)
 
 static int fmh_gpib_line_status(const gpib_board_t *board)
 {
-	int status = ValidALL;
+	int status = VALID_ALL;
 	int bsr_bits;
 	struct fmh_priv *e_priv;
 	struct nec7210_priv *nec_priv;
diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 004bf0e9bc88..28c5fa9b81ab 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -1031,7 +1031,7 @@ static void bb_return_to_local(gpib_board_t *board)
 
 static int bb_line_status(const gpib_board_t *board)
 {
-	int line_status = ValidALL;
+	int line_status = VALID_ALL;
 
 	if (gpiod_get_value(REN) == 0)
 		line_status |= BUS_REN;
diff --git a/drivers/staging/gpib/ines/ines_gpib.c b/drivers/staging/gpib/ines/ines_gpib.c
index c5c34845fc38..d31eab1a05e4 100644
--- a/drivers/staging/gpib/ines/ines_gpib.c
+++ b/drivers/staging/gpib/ines/ines_gpib.c
@@ -27,7 +27,7 @@ MODULE_DESCRIPTION("GPIB driver for Ines iGPIB 72010");
 
 int ines_line_status(const gpib_board_t *board)
 {
-	int status = ValidALL;
+	int status = VALID_ALL;
 	int bcm_bits;
 	struct ines_priv *ines_priv;
 
diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 2775dc83305e..011096ece7d6 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -658,7 +658,7 @@ static void usb_gpib_interface_clear(gpib_board_t *board, int assert)
 static int usb_gpib_line_status(const gpib_board_t *board)
 {
 	int buffer;
-	int line_status = ValidALL;   /* all lines will be read */
+	int line_status = VALID_ALL;   /* all lines will be read */
 	struct list_head *p, *q;
 	WQT *item;
 	unsigned long flags;
diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 7243d361f173..1f72abe9f2e4 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -1461,7 +1461,7 @@ static int ni_usb_line_status(const gpib_board_t *board)
 	int bytes_written = 0, bytes_read = 0;
 	int i = 0;
 	unsigned int bsr_bits;
-	int line_status = ValidALL;
+	int line_status = VALID_ALL;
 	// NI windows driver reads 0xd(HSSEL), 0xc (ARD0), 0x1f (BSR)
 
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
diff --git a/drivers/staging/gpib/tms9914/tms9914.c b/drivers/staging/gpib/tms9914/tms9914.c
index 17adeccf448b..c563fcab44fc 100644
--- a/drivers/staging/gpib/tms9914/tms9914.c
+++ b/drivers/staging/gpib/tms9914/tms9914.c
@@ -391,7 +391,7 @@ static unsigned int update_status_nolock(gpib_board_t *board, struct tms9914_pri
 int tms9914_line_status(const gpib_board_t *board, struct tms9914_priv *priv)
 {
 	int bsr_bits;
-	int status = ValidALL;
+	int status = VALID_ALL;
 
 	bsr_bits = read_byte(priv, BSR);
 
diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
index 76fd9422809c..e62f3424ca20 100644
--- a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
+++ b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
@@ -150,7 +150,7 @@ MODULE_DESCRIPTION("GPIB driver for National Instruments boards using tnt4882 or
 
 static int tnt4882_line_status(const gpib_board_t *board)
 {
-	int status = ValidALL;
+	int status = VALID_ALL;
 	int bcsr_bits;
 	struct tnt4882_priv *tnt_priv;
 
diff --git a/drivers/staging/gpib/uapi/gpib_user.h b/drivers/staging/gpib/uapi/gpib_user.h
index 2d742540630a..5ff4588686fd 100644
--- a/drivers/staging/gpib/uapi/gpib_user.h
+++ b/drivers/staging/gpib/uapi/gpib_user.h
@@ -106,15 +106,15 @@ enum eos_flags {
 
 /* GPIB Bus Control Lines bit vector */
 enum bus_control_line {
-	ValidDAV = 0x01,
-	ValidNDAC = 0x02,
-	ValidNRFD = 0x04,
-	ValidIFC = 0x08,
-	ValidREN = 0x10,
-	ValidSRQ = 0x20,
-	ValidATN = 0x40,
-	ValidEOI = 0x80,
-	ValidALL = 0xff,
+	VALID_DAV = 0x01,
+	VALID_NDAC = 0x02,
+	VALID_NRFD = 0x04,
+	VALID_IFC = 0x08,
+	VALID_REN = 0x10,
+	VALID_SRQ = 0x20,
+	VALID_ATN = 0x40,
+	VALID_EOI = 0x80,
+	VALID_ALL = 0xff,
 	BUS_DAV = 0x0100,		/* DAV	line status bit */
 	BUS_NDAC = 0x0200,		/* NDAC line status bit */
 	BUS_NRFD = 0x0400,		/* NRFD line status bit */
-- 
2.43.0


