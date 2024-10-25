Return-Path: <linux-kernel+bounces-381063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 579779AF9C9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D31F283A93
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B591AB6D4;
	Fri, 25 Oct 2024 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFpLhgAS"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D18419AA5D;
	Fri, 25 Oct 2024 06:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729837114; cv=none; b=sJxtqN1bSWKzpW1e+6CDoLdgjgeiPE592hm5W5vRPI+B4WzOnbGNjVb1ah1an7q8CwVMTJIxUDrGkNV2Br4a5lv763Ky4BfnJJe2qHEBlJOsJwQBWpPvf7afooh1g8le4FiLK5vHPfn265ElTOaLZoa3d3po1rJyzM0ru5O9pqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729837114; c=relaxed/simple;
	bh=08PefwZ7yukQx2quUWfezNFTWKGA+BeBpjoWvJ9Bl2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=adJAXx4C4Jenz5HMMmmYFdNtvo5+EqxHG8Jw/7vyqpQmay8/Fs7g8KFjbKPTzj+vOIXMaLVkF6X1GurbV8Kw4Ya6yX8LuS/OVgg57Nlv1+XDGAqLtRJi1v0SVX7Z2UvdUWLACbnRc0v3QdFbNONa2Kks02deuk3pGhTLNrn+LL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFpLhgAS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e30db524c2so1283890a91.1;
        Thu, 24 Oct 2024 23:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729837111; x=1730441911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cg7YRCcamsG4YB2cjdHfXR1yc10Bn8cddsigznXlYw=;
        b=ZFpLhgASAmVWG9U5OCZmvy03WUVbR1kR4P48Cw688xVLYvB2+Rbt6Bzz8xrczRT6yo
         7qBmheORZhFym4h91iUlJTmwhJiXqyqw/fulQBDGQrfynmpAV4Xg85uovu2hyBZcfjSi
         iRS27bYH53ZWrUjFnVbxSTVFf95wB+bRUvLnZ5DvH4P82qJWi21f6R8L78IOY+gABaka
         lMhuPWKlGoIxj3NqCty9Yc/lb0su8ABt4dyABvCKzQE5Ani7Fkd4cnUnfjiFiY4LCVi5
         H8jqqjltMYx7pJ6plcA1bk6UZ3fpNTnfLklmDpsZ4rpDuIFEMMvJsqSU1RM02w762WFS
         s9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729837111; x=1730441911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cg7YRCcamsG4YB2cjdHfXR1yc10Bn8cddsigznXlYw=;
        b=LkNZD0/OYEceIibnzL/4b+5kpPRcFNpGueAxHei09mlyX1X4ZHiPfMWqYWEuIBhI6I
         nhL5x/8buqs3jPijd8aAi39ypU40HYxejg05Y8TJzgERP5c91pGfBRnUnKpCYYgzTjIY
         GnqH61txqx2G9wr/2BrxnDkh7w+ShW7nUE5Q3kP5jbD8EA1iMXknv/2MO9sKldCwr9Fo
         6jEmU3wW+H1xSt4KdhD91ven2h7DkIHDuj26xP9A4Q98T6Jj0NN0+MqFVW22qYQP/ZSe
         7wZCl9ta1qNDif0ugBTOLuTGwa3FfpZEGdmry8/F3K5EMx1208shzJFDYiC02muf9IMh
         Nm4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUP2QdqIK8emWfugMoJwh+lS5NjHiEsd+ZzrF7kaAsau2Q6XefCWuoaFh5Sv7yisx9oIhrp+mebsaQo7Lo=@vger.kernel.org, AJvYcCVURdSYuJFqOqYqspp6m3r1yVmxyOwj0rBBzzqgxxM5V9jFJ5P6Q2n0V0g8GevpRs4OSKJMxp4OscC5@vger.kernel.org
X-Gm-Message-State: AOJu0YyDUVO8BEOgJAKn2NtcZxdRtjrSW+TFMh9yeeaD5TAOcQKORHV3
	P9EkG0YYNP5a+gZ1WnxP1fC5lbsulaQj/HiiFP/xfYcMaTsVkZNGaOfFT31qjMk=
X-Google-Smtp-Source: AGHT+IHnjdrSh+QvgmsqPZTVerXIvOJJSg515vWKJcvfH5MpzIjcOADOg9c4OtNjEoevrTqdVxOYRg==
X-Received: by 2002:a17:90a:9305:b0:2e2:e769:dffe with SMTP id 98e67ed59e1d1-2e76b6e15f3mr9388930a91.30.1729837111626;
        Thu, 24 Oct 2024 23:18:31 -0700 (PDT)
Received: from asix-MS-7816.. ([2403:c300:550b:d387:a102:1511:5e8b:8a24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e578001sm2566697a91.43.2024.10.24.23.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:18:31 -0700 (PDT)
From: Tony Chung <tony467913@gmail.com>
To: johan@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Tony Chung <tony467913@gmail.com>
Subject: [PATCH v2 1/6] driver: usb: serial: mos7840: fix style warnings
Date: Fri, 25 Oct 2024 14:17:08 +0800
Message-Id: <20241025061711.198933-2-tony467913@gmail.com>
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

fix "no space before tabs" coding style warnings.

Signed-off-by: Tony Chung <tony467913@gmail.com>
---
 drivers/usb/serial/mos7840.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index ca3da79af..dcaed0f26 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -220,7 +220,7 @@ struct moschip_port {
 
 /*
  * mos7840_set_reg_sync
- * 	To set the Control register by calling usb_fill_control_urb function
+ *	To set the Control register by calling usb_fill_control_urb function
  *	by passing usb_sndctrlpipe function as parameter.
  */
 
@@ -238,7 +238,7 @@ static int mos7840_set_reg_sync(struct usb_serial_port *port, __u16 reg,
 
 /*
  * mos7840_get_reg_sync
- * 	To set the Uart register by calling usb_fill_control_urb function by
+ *	To set the Uart register by calling usb_fill_control_urb function by
  *	passing usb_rcvctrlpipe function as parameter.
  */
 
@@ -1356,11 +1356,11 @@ static void mos7840_set_termios(struct tty_struct *tty,
  * mos7840_get_lsr_info - get line status register info
  *
  * Purpose: Let user call ioctl() to get info when the UART physically
- * 	    is emptied.  On bus types like RS485, the transmitter must
- * 	    release the bus after transmitting. This must be done when
- * 	    the transmit shift register is empty, not be done when the
- * 	    transmit holding register is empty.  This functionality
- * 	    allows an RS485 driver to be written in user space.
+ *	is emptied.  On bus types like RS485, the transmitter must
+ *	release the bus after transmitting. This must be done when
+ *	the transmit shift register is empty, not be done when the
+ *	transmit holding register is empty.  This functionality
+ *	allows an RS485 driver to be written in user space.
  *****************************************************************************/
 
 static int mos7840_get_lsr_info(struct tty_struct *tty,
-- 
2.34.1


