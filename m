Return-Path: <linux-kernel+bounces-406261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D374F9C5CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183E7284213
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D74D20C004;
	Tue, 12 Nov 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q86UTpPb"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16650204923;
	Tue, 12 Nov 2024 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427127; cv=none; b=WDSy/JVBge12Wfs61fjXcyyUdKd4Q03crnYV9xzynT5Vw55KOTbgljuHw9iEaV0X9oNp0WY2xZMhPGLIRosuz8M4pyiVeOluKO6M9+YzTMCSFAXBCfb1xyYXsEJoJMjjGhOJuPfQ/GLDr8Ma74WYr9wBLgjW5v8TvWmsewq52UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427127; c=relaxed/simple;
	bh=C0mc3QtPKj7pyUeJbmesl6Jpo/WFOyAGxSSnADDScRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D2h+rvPFG0ZQ5s+FH39GoPhJFC8xWazsi+hwX15KQszBr90ln+jk6Ay43MTJgi03+tVVOXrICmWudbkd4jWsjaZMEUowgDonsaGdorghTmMWYeUpwfXiNa05g1RZURkAvvE1fQWzTmFb+X0nGqn8kVEOcF/2m1LY4VXH3aqM3FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q86UTpPb; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-381ee2e10dfso3420553f8f.0;
        Tue, 12 Nov 2024 07:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731427124; x=1732031924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL4i3B/UuK7CLhkZCi41Y+0eVdaffsWKjLCivALdDZE=;
        b=Q86UTpPbknkYM+yeEpJpH2CSiFEf0KWPQoj58QtILQR0b7sLp7Vs0z66OS5fbmKN6G
         II8Z8l+QYu9y742PpphRQQhrlOPivuWOmI5hMiKpfx2oew0Ndgx4JuB5rRw5lmoIIv9y
         xTYWlGH6I/fSHLk/BXbIASXK2ZUkSjXZ7o83CIN2IZBYc6Bct1hN1eb8jc0ElL3MKIvi
         ZBLPEGM0SUhoAN2z0BmaZe7wsGcriVvoUmrDr+x00Xdc4QqxzfperHPlR7OXgqtwZ9Qh
         HX2/hS1zL434S/ZXmWtonIAcY2riXLlKm8HolXIQmfz7RC86HjjHB29clXtUiWO6xqWS
         Moog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427124; x=1732031924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hL4i3B/UuK7CLhkZCi41Y+0eVdaffsWKjLCivALdDZE=;
        b=EWBcm+pYiainhRa+8+yHd67MUK12+begjkTsHOlV+NxFSvb8oZ4k12sEG+7cxgszlI
         dYA3QX3CTyYz/J9XgEHYeiO/NClUOJz0F4xiS6RHDZoF32cjPL2Ul+LQgd6C0gwBQWll
         Vf9HyOB04sRpbuRcULMFHwLQo082qhRW9rF5Cuce15dPEr59BsnhI6bpRic3lNFnexRF
         pJGqyQQ/qZmPMPhWhunUGdscUlTxOxWSKfQnbXIPKx6PCnxzq1TTKCtERjNSezYZtiAL
         5XFYftp2lgDc2co669Ph8GuaU8gyhCzV1KM8R0P73XkimVvSAg70UbDof2cAHZ0+Xrq8
         06kw==
X-Forwarded-Encrypted: i=1; AJvYcCWqV+sGKpsvW8xn7jU9OptCzupntmIAtjICiVSHE5EG3/Z9PmfVF4QqB0AEVU8pxJurT635GKiy/SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI0DMnnRspAc1scZ58QgmJmLkaS7fx3vuu75MaigyDt899d+mb
	k43UOOEuOUvFhYRNOKNav+SmS60+iB/5iwSiaXUacI8AC0A9258G
X-Google-Smtp-Source: AGHT+IHTWrYa9MUCV9W4cVrxu0hAjA7rgOc+21HiHjz0mEh1o4esTS1xlbC5/MSRQ1zQr7aypigC3g==
X-Received: by 2002:a05:6000:1f87:b0:37c:d20d:447c with SMTP id ffacd0b85a97d-381f186cbc9mr14886375f8f.29.1731427124479;
        Tue, 12 Nov 2024 07:58:44 -0800 (PST)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381edc1104asm15991136f8f.88.2024.11.12.07.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 07:58:44 -0800 (PST)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: gregkh@linuxfoundation.org,
	andreyknvl@gmail.com,
	b-liu@ti.com,
	johan@kernel.org,
	oneukum@suse.com,
	stern@rowland.harvard.edu
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	snovitoll@gmail.com,
	usb-storage@lists.one-eyed-alien.net
Subject: [PATCH v2 7/8] drivers/usb/serial: refactor min with min_t
Date: Tue, 12 Nov 2024 20:58:16 +0500
Message-Id: <20241112155817.3512577-8-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112155817.3512577-1-snovitoll@gmail.com>
References: <2024111251-spill-hatchback-72da@gregkh>
 <20241112155817.3512577-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure type safety by using min_t() instead of casted min().

Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 drivers/usb/serial/io_edgeport.c | 2 +-
 drivers/usb/serial/sierra.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index 28c71d99e857..1fffda7647f9 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -1129,7 +1129,7 @@ static int edge_write(struct tty_struct *tty, struct usb_serial_port *port,
 	spin_lock_irqsave(&edge_port->ep_lock, flags);
 
 	/* calculate number of bytes to put in fifo */
-	copySize = min((unsigned int)count,
+	copySize = min_t(unsigned int, count,
 				(edge_port->txCredits - fifo->count));
 
 	dev_dbg(&port->dev, "%s of %d byte(s) Fifo room  %d -- will copy %d bytes\n",
diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 64a2e0bb5723..741e68e46139 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -421,7 +421,7 @@ static int sierra_write(struct tty_struct *tty, struct usb_serial_port *port,
 	unsigned long flags;
 	unsigned char *buffer;
 	struct urb *urb;
-	size_t writesize = min((size_t)count, (size_t)MAX_TRANSFER);
+	size_t writesize = min_t(size_t, count, MAX_TRANSFER);
 	int retval = 0;
 
 	/* verify that we actually have some data to write */
-- 
2.34.1


