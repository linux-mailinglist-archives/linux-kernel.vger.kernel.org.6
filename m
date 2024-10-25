Return-Path: <linux-kernel+bounces-381066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 592559AF9CF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8EA6B226ED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3561B21B0;
	Fri, 25 Oct 2024 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdVL37km"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502281AB6CA;
	Fri, 25 Oct 2024 06:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729837134; cv=none; b=kUldGktGGKLpWnBHxJTJ6TEgSic4YackYNS/ofSb4wPta8eq50vwmQKgQsDGZgE84RGNU0MGur366GFX/NIU7NjJOgyfaurp875hN1QD3DF4VdrA9RRxtPYZY78HMT8rnaoBcWfFe5KB5mDk06xwU/Cj0PqsftD1ki3tRHLRW8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729837134; c=relaxed/simple;
	bh=IpHvJpcDV6FbQ8pIFLhNW3syUX5UaaofDfZ8QrCLZM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pAyUkff3cmczhXXzx7+buziJC+Z1dKwfRM2iGJ3JrHlqW99SvGLKRGeDRixzoMfL53dX+Ffxr4Hl8HZ/Bpxeg+XztD8M9eMTxO7fgRvHjCHqk8NM1lEf6mlP3BSomIZMLzG3Qo7hO46ATx716Uj35Ic9bBeSdUasBjFXPF4jqQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdVL37km; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso1325105a91.3;
        Thu, 24 Oct 2024 23:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729837132; x=1730441932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jUF1HMy1MUgyp6MY9MD+ftrWrZlW/ievmzGAu0QpwQ=;
        b=SdVL37kmoxcF1mLK1/tLLfMtjTQF+4cIk6/DXRd0IJulZqOCOMvIIYLWMkcbmUv1XX
         4H47uzat+8AhrHyxKkgRj5IDOBvlKk/bLZv7AluqLOMnN6BuWoXfC0X41vQsbvMbulF0
         sKhn/tWZ/dhfvtnvfpwww4zLsKJbI4oMFozTKdGOPHG7T+dK5nUjYgchNoys6dZzd4Rh
         W+JB+L+nXh0eE5iBSRHL3FrlF7Cq19HuEZnFvTZZz2BrJPOhsbaWkca1cZdk3HIHn3UZ
         qeyg5G+SKjnStChLTpZs9evaEL5ES1fZsBYwbCvVFCaL9p4xGU0P5cANjXiQ/vt6/ceQ
         ov4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729837132; x=1730441932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jUF1HMy1MUgyp6MY9MD+ftrWrZlW/ievmzGAu0QpwQ=;
        b=cbe55T2RrH1Th/nogocuxyp8N28t2iocPsstLihNlzGI994Qb1/g/dIzmmEbKBlz/M
         T8d0VT4SdCGNsdTNXZlnBrgyxb7JjLHg28x2IKFglk2a9e0TgLplgp5f6D1L0oJEed6Q
         iCI0cA5oXKVxJ2mklzGw8jTy7V+W564QTnlnrMmMetxw4p0xFYEjAJ2E8apjZck66ZRE
         yIkJDtj7SPD3GRHh6r1C7588686LgejCetxO+MrBrRIBejPy2Ps21+NfM61rIleFA5rK
         jErcg2Hxqg6t+GBQ+x2lGCQkpMxdTPFqwZiSlFitR+VgTXHSrDDdN3JiNLPATWt37Jf1
         oXwg==
X-Forwarded-Encrypted: i=1; AJvYcCU2KTZDxv95hLqbdHaglFVcUCo3uyIUFePHKQnaceYGeEmgrRd2NP+bKDyWJAbVBVWCxvq3LuPasAGm@vger.kernel.org, AJvYcCWLx8sbXkhxkx4YmI/hPhmOm2a8wUKgczldshgK/kdmLVCRsWv2htIxUY3eESizBGlCCgUSrXZZzB/Obug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJenB1RKUn6zpSKmopOVVaW4OwsZCPcOZZQry3e1WmkwqJ31I5
	avbLWhllPrlSnOVgcv8eNmQFNS6FmH7bDxeiGEANWVQG6YnT67vDimnUI8Rkbak=
X-Google-Smtp-Source: AGHT+IEqCjfA3azWK3AY5fVSgab7gRKIb6UvRQGdnpcJcEHv+P1hPyE9U0AJEdubVYRoAFc6xa5Vzg==
X-Received: by 2002:a17:90a:e389:b0:2e2:ba35:3573 with SMTP id 98e67ed59e1d1-2e76b60d445mr9282023a91.20.1729837131633;
        Thu, 24 Oct 2024 23:18:51 -0700 (PDT)
Received: from asix-MS-7816.. ([2403:c300:550b:d387:a102:1511:5e8b:8a24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e578001sm2566697a91.43.2024.10.24.23.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:18:51 -0700 (PDT)
From: Tony Chung <tony467913@gmail.com>
To: johan@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Tony Chung <tony467913@gmail.com>
Subject: [PATCH v2 2/6] drivers: usb: serial: mos7840: Fix Block comments coding style warnings
Date: Fri, 25 Oct 2024 14:17:10 +0800
Message-Id: <20241025061711.198933-3-tony467913@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202410250141.AEkzzW60-lkp@intel.com>
References: <202410250141.AEkzzW60-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix block comments coding style warnings.
1. Block comments use * on subsequent lines
2. Block comments use a trailing */ on a separate line

Signed-off-by: Tony Chung <tony467913@gmail.com>
---
 drivers/usb/serial/mos7840.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index dcaed0f26..b1a794f99 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -282,7 +282,8 @@ static int mos7840_set_uart_reg(struct usb_serial_port *port, __u16 reg,
 	struct usb_device *dev = port->serial->dev;
 	val = val & 0x00ff;
 	/* For the UART control registers, the application number need
-	   to be Or'ed */
+	 * to be Or'ed
+	 */
 	if (port->serial->num_ports == 2 && port->port_number != 0)
 		val |= ((__u16)port->port_number + 2) << 8;
 	else
@@ -1539,8 +1540,9 @@ static int mos7840_port_probe(struct usb_serial_port *port)
 	int pnum;
 	__u16 Data;
 
-	/* we set up the pointers to the endpoints in the mos7840_open *
-	 * function, as the structures aren't created yet.             */
+	/* we set up the pointers to the endpoints in the mos7840_open
+	 * function, as the structures aren't created yet.
+	 */
 
 	pnum = port->port_number;
 
@@ -1551,14 +1553,16 @@ static int mos7840_port_probe(struct usb_serial_port *port)
 
 	/* Initialize all port interrupt end point to port 0 int
 	 * endpoint. Our device has only one interrupt end point
-	 * common to all port */
+	 * common to all port
+	 */
 
 	mos7840_port->port = port;
 	spin_lock_init(&mos7840_port->pool_lock);
 
 	/* minor is not initialised until later by
 	 * usb-serial.c:get_free_serial() and cannot therefore be used
-	 * to index device instances */
+	 * to index device instances
+	 */
 	mos7840_port->port_num = pnum + 1;
 	dev_dbg(&port->dev, "port->minor = %d\n", port->minor);
 	dev_dbg(&port->dev, "mos7840_port->port_num = %d\n", mos7840_port->port_num);
@@ -1591,7 +1595,8 @@ static int mos7840_port_probe(struct usb_serial_port *port)
 		dev_dbg(&port->dev, "ControlReg Reading success val is %x, status%d\n", Data, status);
 	Data |= 0x08;	/* setting driver done bit */
 	Data |= 0x04;	/* sp1_bit to have cts change reflect in
-			   modem status reg */
+			 * modem status reg
+			 */
 
 	/* Data |= 0x20; //rx_disable bit */
 	status = mos7840_set_reg_sync(port,
@@ -1603,7 +1608,8 @@ static int mos7840_port_probe(struct usb_serial_port *port)
 		dev_dbg(&port->dev, "ControlReg Writing success(rx_disable) status%d\n", status);
 
 	/* Write default values in DCR (i.e 0x01 in DCR0, 0x05 in DCR2
-	   and 0x24 in DCR3 */
+	 * and 0x24 in DCR3
+	 */
 	Data = 0x01;
 	status = mos7840_set_reg_sync(port,
 			(__u16) (mos7840_port->DcrRegOffset + 0), Data);
-- 
2.34.1


