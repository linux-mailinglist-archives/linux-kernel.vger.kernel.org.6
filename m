Return-Path: <linux-kernel+bounces-170426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF53F8BD6AC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC49B213B2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0559115CD40;
	Mon,  6 May 2024 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ACUBShd9"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23EA15CD53
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715029834; cv=none; b=hVO2eygembsPxzu+IDY5aqD0UegKq1NFKv5StVIfg6twsC7/eFEG0B5Sn9wESg2x47lz7/hnHXqOecPQ43+XSkZf5mUPjpuz5eJhDufifdCjAa4TOyw+SdIXnfaMZFrzE6Msq8n+3UmFyy9WD1mqWN/kod20Rs0TD9Ktj0Av1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715029834; c=relaxed/simple;
	bh=7MOAwd4bBULwL5xOTaUt6yrPZS3n8PS3P9PINQKXayg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OkTpoa7WoE+/ambP2jOdx0Z3JfKc0y3i66cqU2t8QH8wyEcX/hK7TSMZzAzmiqhcul/HhaU7IHALRuPZhx8n7lOUcXcsbpXhTgA5MEaMicfgKFBkGTmEfEG2ZBBcN8+80P9uQ6VyAvn8Zosfskx3PFDByZ2w8LAbtkGKzJOFNwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ACUBShd9; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-23eff8c9a1dso1396794fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715029832; x=1715634632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sqvg3kz5s9OxeYpuWk0/MXqOrMxTZPD2syeSEOk+5RQ=;
        b=ACUBShd9mbIa0Ya5TH/mHs1ksWYaiB+sy6sebrjYnuUTAxOXIP5UU0viwRGzD9rkeB
         ByMgehQ2J/uHpvrIdr6VaXgOVLli5o+Sd0yVXVdSxLW4Rt60MWemqk10rloGE0BJaT2F
         8JPJwXszS85PTNOT5oIQj7C8JSNgwteMjAxzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715029832; x=1715634632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sqvg3kz5s9OxeYpuWk0/MXqOrMxTZPD2syeSEOk+5RQ=;
        b=VWGP1XH/Ow9lPiOZQa1ivENiPLeSBzhrWy/BZGwcTOe1l2rQSVomo+x1UH+9I0LI/x
         /C158NxWI+y99XSm4z5DCs/O/zSyzSdsy73uC+WWEES7F7a6x54UFEatvXhxvyDfLm9F
         fJ9wDESlPADBff3j8KKxUsdN/cZD47aFPQtz02amRRE7xqNx4HuvCuloZXEnr+ODjROR
         eRbCYT2ehXTaIHledaVVHjC3+neuu18iGjeYBI84vUbqwSRu8LcMJoBJvy9sqwP/bCNi
         KnIsFVSP1UmqBkokSAQ8P/N/JssQSZjwkgQimSKXW4ohjHFR957t8GdT84t3D0DPvOYO
         k0PA==
X-Forwarded-Encrypted: i=1; AJvYcCXRvaVPRRdac7lHz2pwSKq16y3F2ANSzbWy5wmZwc18Z17EBhGEblH3oiquYjmghPxiaoE9s0DBX8KlTq5N6xSx4JmRR1JYvBW6ZeNF
X-Gm-Message-State: AOJu0YxP5BoMaoXUWdRttdqw/BbJLx9yLOZsvq7QqB5ZqjI/hgRIfXMO
	kndNKNcMKTUOpS0pynJJ4Tz2x9mPgQGeLdplsOsFSPRDgiVK3+6ueRlGyJgCxoxd9k2zQEte9bk
	=
X-Google-Smtp-Source: AGHT+IEAFuuBQrD8KQbGry8SYQjhcxEUI+G4myA4NMTrdT2JnKJdlengkUCK51yDD5mFW/bTmbxyNQ==
X-Received: by 2002:a05:6871:341b:b0:22e:bcfd:debc with SMTP id nh27-20020a056871341b00b0022ebcfddebcmr16281376oac.13.1715029831841;
        Mon, 06 May 2024 14:10:31 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id pa20-20020a05620a831400b0078f13e59dc9sm4224921qkn.102.2024.05.06.14.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:10:31 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 06 May 2024 21:10:29 +0000
Subject: [PATCH 4/5] media: go7007: Refactor Adlink PCI-MPG24 i2c mutex
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-cocci-locks-v1-4-a67952fe5d19@chromium.org>
References: <20240506-cocci-locks-v1-0-a67952fe5d19@chromium.org>
In-Reply-To: <20240506-cocci-locks-v1-0-a67952fe5d19@chromium.org>
To: Andy Walls <awalls@md.metrocast.net>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Sean Young <sean@mess.org>, 
 Jarod Wilson <jarod@redhat.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Move the lock/unlock to its own function. It makes the code cleaner and
cocci happier.

Fix the following cocci warning:
drivers/media/usb/go7007/go7007-i2c.c:125:1-7: preceding lock on line 61

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/go7007/go7007-i2c.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/media/usb/go7007/go7007-i2c.c b/drivers/media/usb/go7007/go7007-i2c.c
index 2880370e45c8..f6ce28a4a768 100644
--- a/drivers/media/usb/go7007/go7007-i2c.c
+++ b/drivers/media/usb/go7007/go7007-i2c.c
@@ -33,7 +33,21 @@
 
 /* There is only one I2C port on the TW2804 that feeds all four GO7007 VIPs
  * on the Adlink PCI-MPG24, so access is shared between all of them. */
-static DEFINE_MUTEX(adlink_mpg24_i2c_lock);
+static DEFINE_MUTEX(adlink_mpg24_i2c_mutex);
+
+static inline void adlink_mpg24_i2c_lock(struct go7007 *go)
+{
+	/* Bridge the I2C port on this GO7007 to the shared bus */
+	mutex_lock(&adlink_mpg24_i2c_mutex);
+	go7007_write_addr(go, 0x3c82, 0x0020);
+}
+
+static inline void adlink_mpg24_i2c_unlock(struct go7007 *go)
+{
+	/* Isolate the I2C port on this GO7007 from the shared bus */
+	go7007_write_addr(go, 0x3c82, 0x0000);
+	mutex_unlock(&adlink_mpg24_i2c_mutex);
+}
 
 static int go7007_i2c_xfer(struct go7007 *go, u16 addr, int read,
 		u16 command, int flags, u8 *data)
@@ -56,11 +70,8 @@ static int go7007_i2c_xfer(struct go7007 *go, u16 addr, int read,
 
 	mutex_lock(&go->hw_lock);
 
-	if (go->board_id == GO7007_BOARDID_ADLINK_MPG24) {
-		/* Bridge the I2C port on this GO7007 to the shared bus */
-		mutex_lock(&adlink_mpg24_i2c_lock);
-		go7007_write_addr(go, 0x3c82, 0x0020);
-	}
+	if (go->board_id == GO7007_BOARDID_ADLINK_MPG24)
+		adlink_mpg24_i2c_lock(go);
 
 	/* Wait for I2C adapter to be ready */
 	for (i = 0; i < 10; ++i) {
@@ -116,11 +127,8 @@ static int go7007_i2c_xfer(struct go7007 *go, u16 addr, int read,
 	ret = 0;
 
 i2c_done:
-	if (go->board_id == GO7007_BOARDID_ADLINK_MPG24) {
-		/* Isolate the I2C port on this GO7007 from the shared bus */
-		go7007_write_addr(go, 0x3c82, 0x0000);
-		mutex_unlock(&adlink_mpg24_i2c_lock);
-	}
+	if (go->board_id == GO7007_BOARDID_ADLINK_MPG24)
+		adlink_mpg24_i2c_unlock(go);
 	mutex_unlock(&go->hw_lock);
 	return ret;
 }

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


