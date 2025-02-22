Return-Path: <linux-kernel+bounces-527469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1B3A40B91
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 21:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4BF171E14
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04E5202C25;
	Sat, 22 Feb 2025 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/xiI219"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3C21DC745
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740255791; cv=none; b=iLTiNoOOWATMrUh0DZxeTwC/XbT3xQAREVkbb+1zsF8oTvQA0SmOMuZ6J7aoGY2wEg0xdwzWBJOjLbGpE8nRqaIbqbEmzTwwH8e8B3vAutveAwZMCI1qSeg9RVrkwBJgeqbBUyB6cTqm0xc7BBlB1AQ5FM+3gEjC8ze8nbAKwSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740255791; c=relaxed/simple;
	bh=gafxOQW5yIYXJhfFooWSQQvhM/T1fIqi6swXzPzLJvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oj9CadwaoxvCXu3OlZOU/49K1HFvO37wIqtjoO2xD3Re3M/E8WnTe1gkRuLmvI+dDrbXtxN0H7ParbyjzkBddi4S1Jmx7Jnje/ANlF88MF0s+z29EfPLAm/fJfRUFCN6GFU7iTx3E8WaKqaqOgXewLLpjAkGMVnhURcAiy4Nzz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/xiI219; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f6287649eso2459985f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 12:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740255787; x=1740860587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oC3C84ut5aQIIPfxxTtSUYN3VvZq3CE85sDQXpA3w58=;
        b=i/xiI219R/rWXdRn8ostqzNnrWcUU/up4/7tFWcSeIpAhP0/ax6gaJSc8qFT+2+QVB
         ZGHjR3EOX0ci5WXxG2SzBbfBNn4LnpSDum7+CzSf5VGSoMbKuNbaD0cLHyQAWKHmZ8C+
         Z9cRALa2xOP5OL96v7UG2Q9J1N9a4EwJ+nPcVwY08MrTGU9jRgHs1xorZ671G+qXgM0P
         gKwJ8zSM4UwYAQI2Bd649YteYBB4DoA0kHKHw84PHTvR32SIGiqTf4+qL7IdzL/4ym8T
         AwmE4t3AmM59DYF3ZdN0Wp+NvQHeH3PWbUjPRdgeEMZCDynsXnkmvkgaDBuOemfR6Pdd
         zCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740255787; x=1740860587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oC3C84ut5aQIIPfxxTtSUYN3VvZq3CE85sDQXpA3w58=;
        b=AJvqE9JhpW7weNQQj2uqOlsiTKcfI2sREWIfSFjNT8yhSrkcw8FEHco1LiaK15rQ5l
         Gqml8glVaHjJu33ELa2+dsPT4BkQY4+Qd2vRGf9MyV0pqvmR5PKCcQ66ma37hOGdwbUw
         UGVMDCh/ldr0GrkZBbYjzL+Dbw/lrFZH4j8vNg+lQsgtAKtZI11ej6+alXcrv5FGZ0us
         iamAA6IiuUyt04wIW607PKpvVai3x54OKpMkjNsLGiBYjt0WvX9VZdtjZmDorbn+FiO7
         Wa2qwYE2SfFi+CHfryi86t9C+ywt1mOuV39tCnOlVLEgEE0bCJ+X8AmAWejGQSI/UIsH
         8ycw==
X-Forwarded-Encrypted: i=1; AJvYcCX2v+we8zfyWJqGt0A+miM4JH2hVo2k2EInbh/1rdyN2SlAcB4p8kGboaUIcBLIM8hA7Gs1OEgclXc1ED4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2i9Nhz/hDSEHHmCBpXKPrx4PSKtXisPsSr2dVdxLY6RMA/nX5
	VXT1jrEIvGPUjagIC1Uya64Q5t0yJJTrHQgaWiItrMubKOjcv5or
X-Gm-Gg: ASbGncsGSiLQ9FjtKmAjShPWILCBT/LD7B/AEvyL+4bF6FsL6sk7JsqfnUuqrHfCj4J
	9PotfRlSLjkWzGarY8bzSY0RmUl3Adtiq7RFMs3RRPGKHQoATFFX8cFIadaBQGSVNuuwwHT5nP4
	hd6hjdA856WO7kvwIDdRxlUa2ZJP0DpWGE8+PotQ2Bbwkio+Io8z9ODiHlIH+YbBV0oft4tv6SP
	UX/Fg15x7oxUpXNHULEV8D1BuHrM9jPhys+WqnENRTCsUatirbinx0lKOSY+D/xXe0HAKdZo+Av
	7fqHSEKW8bp1VAeP04r1uV7XsAlfyvEFND7NWj8s88VOSFfjQ+ndzxL72degtw==
X-Google-Smtp-Source: AGHT+IFiHe9wwDEJBI7Ec1GuLxX8jtLwKKELhjaig4To0WEuuoZtm1Wr2BbaWoP8u3klVgvnbSpLiw==
X-Received: by 2002:a05:6000:1faa:b0:38f:20bc:7df0 with SMTP id ffacd0b85a97d-38f707b05d0mr5862892f8f.26.1740255786535;
        Sat, 22 Feb 2025 12:23:06 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccdccsm27115733f8f.24.2025.02.22.12.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 12:23:05 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH] staging: gpib: Add return value to request_control
Date: Sat, 22 Feb 2025 21:23:01 +0100
Message-ID: <20250222202301.3729-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A number of drivers are unable to release control due to
hardware or software limitations. As request_control was defined
as void - no error could be signalled. Some drivers also did
not implement request_control correctly by setting
controller_in_charge instead of system_controller.

This patch changes the prototype of request_control to int
and adds the appropriate checking and returns. In the case
that a board cannot release control EPERM is returned. The
faulty implementations have been corrected.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 .../gpib/agilent_82350b/agilent_82350b.c      |  7 +++--
 .../gpib/agilent_82357a/agilent_82357a.c      | 31 +++++++++----------
 drivers/staging/gpib/cb7210/cb7210.c          |  4 +--
 drivers/staging/gpib/cec/cec_gpib.c           |  4 +--
 drivers/staging/gpib/common/gpib_os.c         |  4 +--
 drivers/staging/gpib/common/iblib.c           | 15 ++++++---
 drivers/staging/gpib/eastwood/fluke_gpib.c    |  4 +--
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c      |  4 +--
 drivers/staging/gpib/gpio/gpib_bitbang.c      | 21 ++++++++-----
 drivers/staging/gpib/hp_82335/hp82335.c       |  4 +--
 drivers/staging/gpib/hp_82341/hp_82341.c      |  4 +--
 drivers/staging/gpib/include/gpib_proto.h     |  2 +-
 drivers/staging/gpib/include/gpib_types.h     |  2 +-
 drivers/staging/gpib/include/nec7210.h        |  4 +--
 drivers/staging/gpib/include/tms9914.h        |  4 +--
 drivers/staging/gpib/ines/ines.h              |  2 +-
 drivers/staging/gpib/ines/ines_gpib.c         |  4 +--
 .../gpib/lpvo_usb_gpib/lpvo_usb_gpib.c        | 14 +++++----
 drivers/staging/gpib/nec7210/nec7210.c        |  5 +--
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c     |  8 ++---
 drivers/staging/gpib/pc2/pc2_gpib.c           |  4 +--
 drivers/staging/gpib/tms9914/tms9914.c        |  6 ++--
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c   |  6 ++--
 23 files changed, 91 insertions(+), 72 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index f83e1f321561..ba75cf6e0de0 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -339,10 +339,11 @@ static int agilent_82350b_go_to_standby(gpib_board_t *board)
 	return tms9914_go_to_standby(board, &priv->tms9914_priv);
 }
 
-static void agilent_82350b_request_system_control(gpib_board_t *board, int request_control)
+static int agilent_82350b_request_system_control(gpib_board_t *board, int request_control)
 
 {
 	struct agilent_82350b_priv *a_priv = board->private_data;
+	int retval;
 
 	if (request_control) {
 		a_priv->card_mode_bits |= CM_SYSTEM_CONTROLLER_BIT;
@@ -354,7 +355,9 @@ static void agilent_82350b_request_system_control(gpib_board_t *board, int reque
 			writeb(0, a_priv->gpib_base + INTERNAL_CONFIG_REG);
 	}
 	writeb(a_priv->card_mode_bits, a_priv->gpib_base + CARD_MODE_REG);
-	tms9914_request_system_control(board, &a_priv->tms9914_priv, request_control);
+	retval = tms9914_request_system_control(board, &a_priv->tms9914_priv, request_control);
+
+	return retval;
 }
 
 static void agilent_82350b_interface_clear(gpib_board_t *board, int assert)
diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
index e0d36f0dff25..76573aee4a4f 100644
--- a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
+++ b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
@@ -751,8 +751,7 @@ static int agilent_82357a_go_to_standby(gpib_board_t *board)
 	return 0;
 }
 
-//FIXME should change prototype to return int
-static void agilent_82357a_request_system_control(gpib_board_t *board, int request_control)
+static int agilent_82357a_request_system_control(gpib_board_t *board, int request_control)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 	struct usb_device *usb_dev;
@@ -761,19 +760,15 @@ static void agilent_82357a_request_system_control(gpib_board_t *board, int reque
 	int i = 0;
 
 	if (!a_priv->bus_interface)
-		return; // -ENODEV;
+		return -ENODEV;
 
+	if (!request_control)
+		return -EPERM; /* can't not be system controller */
 	usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	/* 82357B needs bit to be set in 9914 AUXCR register */
 	writes[i].address = AUXCR;
-	if (request_control) {
-		writes[i].value = AUX_RQC;
-		a_priv->hw_control_bits |= SYSTEM_CONTROLLER;
-	} else {
-		writes[i].value = AUX_RLC;
-		a_priv->is_cic = 0;
-		a_priv->hw_control_bits &= ~SYSTEM_CONTROLLER;
-	}
+	writes[i].value = AUX_RQC;
+	a_priv->hw_control_bits |= SYSTEM_CONTROLLER;
 	++i;
 	writes[i].address = HW_CONTROL;
 	writes[i].value = a_priv->hw_control_bits;
@@ -781,7 +776,7 @@ static void agilent_82357a_request_system_control(gpib_board_t *board, int reque
 	retval = agilent_82357a_write_registers(a_priv, writes, i);
 	if (retval)
 		dev_err(&usb_dev->dev, "write_registers() returned error\n");
-	return;// retval;
+	return retval;
 }
 
 static void agilent_82357a_interface_clear(gpib_board_t *board, int assert)
@@ -1584,7 +1579,7 @@ static int agilent_82357a_driver_resume(struct usb_interface *interface)
 {
 	struct usb_device *usb_dev = interface_to_usbdev(interface);
 	gpib_board_t *board;
-	int i, retval;
+	int i, retval = 0;
 
 	mutex_lock(&agilent_82357a_hotplug_lock);
 
@@ -1595,8 +1590,10 @@ static int agilent_82357a_driver_resume(struct usb_interface *interface)
 				break;
 		}
 	}
-	if (i == MAX_NUM_82357A_INTERFACES)
+	if (i == MAX_NUM_82357A_INTERFACES) {
+		retval = -ENOENT;
 		goto resume_exit;
+	}
 
 	struct agilent_82357a_priv *a_priv = board->private_data;
 
@@ -1619,7 +1616,9 @@ static int agilent_82357a_driver_resume(struct usb_interface *interface)
 			return retval;
 		}
 		// set/unset system controller
-		agilent_82357a_request_system_control(board, board->master);
+		retval = agilent_82357a_request_system_control(board, board->master);
+		if (retval)
+			goto resume_exit;
 		// toggle ifc if master
 		if (board->master) {
 			agilent_82357a_interface_clear(board, 1);
@@ -1637,7 +1636,7 @@ static int agilent_82357a_driver_resume(struct usb_interface *interface)
 resume_exit:
 	mutex_unlock(&agilent_82357a_hotplug_lock);
 
-	return 0;
+	return retval;
 }
 
 static struct usb_driver agilent_82357a_bus_driver = {
diff --git a/drivers/staging/gpib/cb7210/cb7210.c b/drivers/staging/gpib/cb7210/cb7210.c
index 19dfd8b4a8e7..1ad242d0e28e 100644
--- a/drivers/staging/gpib/cb7210/cb7210.c
+++ b/drivers/staging/gpib/cb7210/cb7210.c
@@ -577,7 +577,7 @@ static int cb7210_go_to_standby(gpib_board_t *board)
 	return nec7210_go_to_standby(board, &priv->nec7210_priv);
 }
 
-static void cb7210_request_system_control(gpib_board_t *board, int request_control)
+static int cb7210_request_system_control(gpib_board_t *board, int request_control)
 {
 	struct cb7210_priv *priv = board->private_data;
 	struct nec7210_priv *nec_priv = &priv->nec7210_priv;
@@ -588,7 +588,7 @@ static void cb7210_request_system_control(gpib_board_t *board, int request_contr
 		priv->hs_mode_bits &= ~HS_SYS_CONTROL;
 
 	cb7210_write_byte(priv, priv->hs_mode_bits, HS_MODE);
-	nec7210_request_system_control(board, nec_priv, request_control);
+	return nec7210_request_system_control(board, nec_priv, request_control);
 }
 
 static void cb7210_interface_clear(gpib_board_t *board, int assert)
diff --git a/drivers/staging/gpib/cec/cec_gpib.c b/drivers/staging/gpib/cec/cec_gpib.c
index 8f2b4b46a446..b34deeb68daf 100644
--- a/drivers/staging/gpib/cec/cec_gpib.c
+++ b/drivers/staging/gpib/cec/cec_gpib.c
@@ -82,11 +82,11 @@ static int cec_go_to_standby(gpib_board_t *board)
 	return nec7210_go_to_standby(board, &priv->nec7210_priv);
 }
 
-static void cec_request_system_control(gpib_board_t *board, int request_control)
+static int cec_request_system_control(gpib_board_t *board, int request_control)
 {
 	struct cec_priv *priv = board->private_data;
 
-	nec7210_request_system_control(board, &priv->nec7210_priv, request_control);
+	return nec7210_request_system_control(board, &priv->nec7210_priv, request_control);
 }
 
 static void cec_interface_clear(gpib_board_t *board, int assert)
diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
index 301c8a1a62c2..c9e097dcab37 100644
--- a/drivers/staging/gpib/common/gpib_os.c
+++ b/drivers/staging/gpib/common/gpib_os.c
@@ -1970,9 +1970,7 @@ static int request_system_control_ioctl(gpib_board_t *board, unsigned long arg)
 	if (retval)
 		return -EFAULT;
 
-	ibrsc(board, request_control);
-
-	return 0;
+	return ibrsc(board, request_control);
 }
 
 static int t1_delay_ioctl(gpib_board_t *board, unsigned long arg)
diff --git a/drivers/staging/gpib/common/iblib.c b/drivers/staging/gpib/common/iblib.c
index fd2874c2fff4..3d51a093fc8b 100644
--- a/drivers/staging/gpib/common/iblib.c
+++ b/drivers/staging/gpib/common/iblib.c
@@ -418,12 +418,19 @@ int ibsic(gpib_board_t *board, unsigned int usec_duration)
 	return 0;
 }
 
-	/* FIXME make int */
-void ibrsc(gpib_board_t *board, int request_control)
+int ibrsc(gpib_board_t *board, int request_control)
 {
-	board->master = request_control != 0;
+	int retval;
+
 	if (board->interface->request_system_control)
-		board->interface->request_system_control(board, request_control);
+		retval = board->interface->request_system_control(board, request_control);
+	else
+		retval = -EPERM;
+
+	if (!retval)
+		board->master = request_control != 0;
+
+	return retval;
 }
 
 /*
diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
index 731732bd8301..a6ed93498c38 100644
--- a/drivers/staging/gpib/eastwood/fluke_gpib.c
+++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
@@ -91,12 +91,12 @@ static int fluke_go_to_standby(gpib_board_t *board)
 	return nec7210_go_to_standby(board, &priv->nec7210_priv);
 }
 
-static void fluke_request_system_control(gpib_board_t *board, int request_control)
+static int fluke_request_system_control(gpib_board_t *board, int request_control)
 {
 	struct fluke_priv *priv = board->private_data;
 	struct nec7210_priv *nec_priv = &priv->nec7210_priv;
 
-	nec7210_request_system_control(board, nec_priv, request_control);
+	return nec7210_request_system_control(board, nec_priv, request_control);
 }
 
 static void fluke_interface_clear(gpib_board_t *board, int assert)
diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
index d62c83368518..946c00a5c7a5 100644
--- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
@@ -82,12 +82,12 @@ static int fmh_gpib_go_to_standby(gpib_board_t *board)
 	return nec7210_go_to_standby(board, &priv->nec7210_priv);
 }
 
-static void fmh_gpib_request_system_control(gpib_board_t *board, int request_control)
+static int fmh_gpib_request_system_control(gpib_board_t *board, int request_control)
 {
 	struct fmh_priv *priv = board->private_data;
 	struct nec7210_priv *nec_priv = &priv->nec7210_priv;
 
-	nec7210_request_system_control(board, nec_priv, request_control);
+	return nec7210_request_system_control(board, nec_priv, request_control);
 }
 
 static void fmh_gpib_interface_clear(gpib_board_t *board, int assert)
diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 2012db188f58..30ffa54b8f96 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -855,6 +855,7 @@ static void set_atn(gpib_board_t *board, int atn_asserted)
 			priv->listener_state = listener_addressed;
 		if (priv->talker_state == talker_active)
 			priv->talker_state = talker_addressed;
+		SET_DIR_WRITE(priv);  // need to be able to read bus NRFD/NDAC
 	} else {
 		if (priv->listener_state == listener_addressed) {
 			priv->listener_state = listener_active;
@@ -871,7 +872,6 @@ static int bb_take_control(gpib_board_t *board, int synchronous)
 {
 	dbg_printk(2, "%d\n", synchronous);
 	set_atn(board, 1);
-	set_bit(CIC_NUM, &board->status);
 	return 0;
 }
 
@@ -882,16 +882,22 @@ static int bb_go_to_standby(gpib_board_t *board)
 	return 0;
 }
 
-static void bb_request_system_control(gpib_board_t *board, int request_control)
+static int bb_request_system_control(gpib_board_t *board, int request_control)
 {
+	struct bb_priv *priv = board->private_data;
+
 	dbg_printk(2, "%d\n", request_control);
 	if (request_control) {
-		set_bit(CIC_NUM, &board->status);
-		// drive DAV & EOI false, enable NRFD & NDAC irqs
-		SET_DIR_WRITE(board->private_data);
+		gpiod_direction_output(REN, 1); /* user space must enable REN if needed */
+		gpiod_direction_output(IFC, 1); /* user space must toggle IFC if needed */
+		if (sn7516x)
+			gpiod_direction_output(DC, 0); /* enable ATN as output on SN75161/2 */
+		gpiod_direction_input(SRQ);
+		ENABLE_IRQ(priv->irq_SRQ, IRQ_TYPE_EDGE_FALLING);
 	} else {
-		clear_bit(CIC_NUM, &board->status);
+		return -EPERM;
 	}
+	return 0;
 }
 
 static void bb_interface_clear(gpib_board_t *board, int assert)
@@ -903,6 +909,7 @@ static void bb_interface_clear(gpib_board_t *board, int assert)
 		gpiod_direction_output(IFC, 0);
 		priv->talker_state = talker_idle;
 		priv->listener_state = listener_idle;
+		set_bit(CIC_NUM, &board->status);
 	} else {
 		gpiod_direction_output(IFC, 1);
 	}
@@ -1293,8 +1300,6 @@ static int bb_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		       IRQF_TRIGGER_NONE))
 		goto bb_attach_fail_r;
 
-	ENABLE_IRQ(priv->irq_SRQ, IRQ_TYPE_EDGE_FALLING);
-
 	dbg_printk(0, "attached board %d\n", board->minor);
 	goto bb_attach_out;
 
diff --git a/drivers/staging/gpib/hp_82335/hp82335.c b/drivers/staging/gpib/hp_82335/hp82335.c
index 982544d1b382..6d403a1422d7 100644
--- a/drivers/staging/gpib/hp_82335/hp82335.c
+++ b/drivers/staging/gpib/hp_82335/hp82335.c
@@ -67,11 +67,11 @@ static int hp82335_go_to_standby(gpib_board_t *board)
 	return tms9914_go_to_standby(board, &priv->tms9914_priv);
 }
 
-static void hp82335_request_system_control(gpib_board_t *board, int request_control)
+static int hp82335_request_system_control(gpib_board_t *board, int request_control)
 {
 	struct hp82335_priv *priv = board->private_data;
 
-	tms9914_request_system_control(board, &priv->tms9914_priv, request_control);
+	return tms9914_request_system_control(board, &priv->tms9914_priv, request_control);
 }
 
 static void hp82335_interface_clear(gpib_board_t *board, int assert)
diff --git a/drivers/staging/gpib/hp_82341/hp_82341.c b/drivers/staging/gpib/hp_82341/hp_82341.c
index 91fbaf953bcd..0c03e8fedbb0 100644
--- a/drivers/staging/gpib/hp_82341/hp_82341.c
+++ b/drivers/staging/gpib/hp_82341/hp_82341.c
@@ -293,7 +293,7 @@ static int hp_82341_go_to_standby(gpib_board_t *board)
 	return tms9914_go_to_standby(board, &priv->tms9914_priv);
 }
 
-static void hp_82341_request_system_control(gpib_board_t *board, int request_control)
+static int hp_82341_request_system_control(gpib_board_t *board, int request_control)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
@@ -302,7 +302,7 @@ static void hp_82341_request_system_control(gpib_board_t *board, int request_con
 	else
 		priv->mode_control_bits &= ~SYSTEM_CONTROLLER_BIT;
 	outb(priv->mode_control_bits, priv->iobase[0] + MODE_CONTROL_STATUS_REG);
-	tms9914_request_system_control(board, &priv->tms9914_priv, request_control);
+	return tms9914_request_system_control(board, &priv->tms9914_priv, request_control);
 }
 
 static void hp_82341_interface_clear(gpib_board_t *board, int assert)
diff --git a/drivers/staging/gpib/include/gpib_proto.h b/drivers/staging/gpib/include/gpib_proto.h
index 1499f954210b..6448b5e77a01 100644
--- a/drivers/staging/gpib/include/gpib_proto.h
+++ b/drivers/staging/gpib/include/gpib_proto.h
@@ -38,7 +38,7 @@ int iblines(const gpib_board_t *board, short *lines);
 int ibrd(gpib_board_t *board, uint8_t *buf, size_t length, int *end_flag, size_t *bytes_read);
 int ibrpp(gpib_board_t *board, uint8_t *buf);
 int ibrsv2(gpib_board_t *board, uint8_t status_byte, int new_reason_for_service);
-void ibrsc(gpib_board_t *board, int request_control);
+int ibrsc(gpib_board_t *board, int request_control);
 int ibsic(gpib_board_t *board, unsigned int usec_duration);
 int ibsre(gpib_board_t *board, int enable);
 int ibpad(gpib_board_t *board, unsigned int addr);
diff --git a/drivers/staging/gpib/include/gpib_types.h b/drivers/staging/gpib/include/gpib_types.h
index b41781a55a60..f21942a03930 100644
--- a/drivers/staging/gpib/include/gpib_types.h
+++ b/drivers/staging/gpib/include/gpib_types.h
@@ -93,7 +93,7 @@ struct gpib_interface_struct {
 	 */
 	int (*go_to_standby)(gpib_board_t *board);
 	/* request/release control of the IFC and REN lines (system controller) */
-	void (*request_system_control)(gpib_board_t *board, int request_control);
+	int (*request_system_control)(gpib_board_t *board, int request_control);
 	/* Asserts or de-asserts 'interface clear' (IFC) depending on
 	 * boolean value of 'assert'
 	 */
diff --git a/drivers/staging/gpib/include/nec7210.h b/drivers/staging/gpib/include/nec7210.h
index ca998c4a84bf..05652bfa0bbf 100644
--- a/drivers/staging/gpib/include/nec7210.h
+++ b/drivers/staging/gpib/include/nec7210.h
@@ -86,8 +86,8 @@ int nec7210_command(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *buf
 		    size_t length, size_t *bytes_written);
 int nec7210_take_control(gpib_board_t *board, struct nec7210_priv *priv, int syncronous);
 int nec7210_go_to_standby(gpib_board_t *board, struct nec7210_priv *priv);
-void nec7210_request_system_control(gpib_board_t *board,
-				    struct nec7210_priv *priv, int request_control);
+int nec7210_request_system_control(gpib_board_t *board,
+				   struct nec7210_priv *priv, int request_control);
 void nec7210_interface_clear(gpib_board_t *board, struct nec7210_priv *priv, int assert);
 void nec7210_remote_enable(gpib_board_t *board, struct nec7210_priv *priv, int enable);
 int nec7210_enable_eos(gpib_board_t *board, struct nec7210_priv *priv, uint8_t eos_bytes,
diff --git a/drivers/staging/gpib/include/tms9914.h b/drivers/staging/gpib/include/tms9914.h
index d8c8d1c9b131..6da43f278aed 100644
--- a/drivers/staging/gpib/include/tms9914.h
+++ b/drivers/staging/gpib/include/tms9914.h
@@ -92,8 +92,8 @@ int tms9914_take_control(gpib_board_t *board, struct tms9914_priv *priv, int syn
 int tms9914_take_control_workaround(gpib_board_t *board, struct tms9914_priv *priv,
 				    int syncronous);
 int tms9914_go_to_standby(gpib_board_t *board, struct tms9914_priv *priv);
-void tms9914_request_system_control(gpib_board_t *board, struct tms9914_priv *priv,
-				    int request_control);
+int tms9914_request_system_control(gpib_board_t *board, struct tms9914_priv *priv,
+				   int request_control);
 void tms9914_interface_clear(gpib_board_t *board, struct tms9914_priv *priv, int assert);
 void tms9914_remote_enable(gpib_board_t *board, struct tms9914_priv *priv, int enable);
 int tms9914_enable_eos(gpib_board_t *board, struct tms9914_priv *priv, uint8_t eos_bytes,
diff --git a/drivers/staging/gpib/ines/ines.h b/drivers/staging/gpib/ines/ines.h
index 3918737fa21a..12f4be7f6564 100644
--- a/drivers/staging/gpib/ines/ines.h
+++ b/drivers/staging/gpib/ines/ines.h
@@ -46,7 +46,7 @@ int ines_accel_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 int ines_command(gpib_board_t *board, uint8_t *buffer, size_t length, size_t *bytes_written);
 int ines_take_control(gpib_board_t *board, int synchronous);
 int ines_go_to_standby(gpib_board_t *board);
-void ines_request_system_control(gpib_board_t *board, int request_control);
+int ines_request_system_control(gpib_board_t *board, int request_control);
 void ines_interface_clear(gpib_board_t *board, int assert);
 void ines_remote_enable(gpib_board_t *board, int enable);
 int ines_enable_eos(gpib_board_t *board, uint8_t eos_byte, int compare_8_bits);
diff --git a/drivers/staging/gpib/ines/ines_gpib.c b/drivers/staging/gpib/ines/ines_gpib.c
index 56da6cd91188..24fa7fc64d9d 100644
--- a/drivers/staging/gpib/ines/ines_gpib.c
+++ b/drivers/staging/gpib/ines/ines_gpib.c
@@ -440,11 +440,11 @@ int ines_go_to_standby(gpib_board_t *board)
 	return nec7210_go_to_standby(board, &priv->nec7210_priv);
 }
 
-void ines_request_system_control(gpib_board_t *board, int request_control)
+int ines_request_system_control(gpib_board_t *board, int request_control)
 {
 	struct ines_priv *priv = board->private_data;
 
-	nec7210_request_system_control(board, &priv->nec7210_priv, request_control);
+	return nec7210_request_system_control(board, &priv->nec7210_priv, request_control);
 }
 
 void ines_interface_clear(gpib_board_t *board, int assert)
diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 50faa0c17617..72cf2807b62e 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -921,15 +921,17 @@ static void usb_gpib_remote_enable(gpib_board_t *board, int enable)
 
 /* request_system_control */
 
-static void usb_gpib_request_system_control(gpib_board_t *board,
-					    int request_control)
+static int usb_gpib_request_system_control(gpib_board_t *board, int request_control)
 {
-	if (request_control)
-		set_bit(CIC_NUM, &board->status);
+	int retval;
+
+	if (!request_control)
+		retval = -EPERM;
 	else
-		clear_bit(CIC_NUM, &board->status);
+		retval = 0;
+	DIA_LOG(1, "done with %d -> retval %i\n", request_control, retval);
 
-	DIA_LOG(1, "done with %d -> %lx\n", request_control, board->status);
+	return retval;
 }
 
 /* take_control */
diff --git a/drivers/staging/gpib/nec7210/nec7210.c b/drivers/staging/gpib/nec7210/nec7210.c
index 85f1e79d658a..a14211e54861 100644
--- a/drivers/staging/gpib/nec7210/nec7210.c
+++ b/drivers/staging/gpib/nec7210/nec7210.c
@@ -329,14 +329,15 @@ int nec7210_go_to_standby(gpib_board_t *board, struct nec7210_priv *priv)
 }
 EXPORT_SYMBOL(nec7210_go_to_standby);
 
-void nec7210_request_system_control(gpib_board_t *board, struct nec7210_priv *priv,
-				    int request_control)
+int nec7210_request_system_control(gpib_board_t *board, struct nec7210_priv *priv,
+				   int request_control)
 {
 	if (request_control == 0) {
 		write_byte(priv, AUX_CREN, AUXMR);
 		write_byte(priv, AUX_CIFC, AUXMR);
 		write_byte(priv, AUX_DSC, AUXMR);
 	}
+	return 0;
 }
 EXPORT_SYMBOL(nec7210_request_system_control);
 
diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 62fbc78204ce..969d88525e6e 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -1049,7 +1049,7 @@ static int ni_usb_go_to_standby(gpib_board_t *board)
 	return 0;
 }
 
-static void ni_usb_request_system_control(gpib_board_t *board, int request_control)
+static int ni_usb_request_system_control(gpib_board_t *board, int request_control)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1059,7 +1059,7 @@ static void ni_usb_request_system_control(gpib_board_t *board, int request_contr
 	unsigned int ibsta;
 
 	if (!ni_priv->bus_interface)
-		return; // -ENODEV;
+		return -ENODEV;
 	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	if (request_control) {
 		writes[i].device = NIUSB_SUBDEV_TNT4882;
@@ -1091,12 +1091,12 @@ static void ni_usb_request_system_control(gpib_board_t *board, int request_contr
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
 		dev_err(&usb_dev->dev, "register write failed, retval=%i\n", retval);
-		return; // retval;
+		return retval;
 	}
 	if (!request_control)
 		ni_priv->ren_state = 0;
 	ni_usb_soft_update_status(board, ibsta, 0);
-	return; // 0;
+	return 0;
 }
 
 //FIXME maybe the interface should have a "pulse interface clear" function that can return an error?
diff --git a/drivers/staging/gpib/pc2/pc2_gpib.c b/drivers/staging/gpib/pc2/pc2_gpib.c
index 6711851301ec..f9615b4a5fa2 100644
--- a/drivers/staging/gpib/pc2/pc2_gpib.c
+++ b/drivers/staging/gpib/pc2/pc2_gpib.c
@@ -127,11 +127,11 @@ static int pc2_go_to_standby(gpib_board_t *board)
 	return nec7210_go_to_standby(board, &priv->nec7210_priv);
 }
 
-static void pc2_request_system_control(gpib_board_t *board, int request_control)
+static int pc2_request_system_control(gpib_board_t *board, int request_control)
 {
 	struct pc2_priv *priv = board->private_data;
 
-	nec7210_request_system_control(board, &priv->nec7210_priv, request_control);
+	return nec7210_request_system_control(board, &priv->nec7210_priv, request_control);
 }
 
 static void pc2_interface_clear(gpib_board_t *board, int assert)
diff --git a/drivers/staging/gpib/tms9914/tms9914.c b/drivers/staging/gpib/tms9914/tms9914.c
index 1f2bb163cfb5..ab81020b6ebd 100644
--- a/drivers/staging/gpib/tms9914/tms9914.c
+++ b/drivers/staging/gpib/tms9914/tms9914.c
@@ -116,8 +116,8 @@ void tms9914_remote_enable(gpib_board_t *board, struct tms9914_priv *priv, int e
 }
 EXPORT_SYMBOL_GPL(tms9914_remote_enable);
 
-void tms9914_request_system_control(gpib_board_t *board, struct tms9914_priv *priv,
-				    int request_control)
+int tms9914_request_system_control(gpib_board_t *board, struct tms9914_priv *priv,
+				   int request_control)
 {
 	if (request_control) {
 		write_byte(priv, AUX_RQC, AUXCR);
@@ -125,6 +125,8 @@ void tms9914_request_system_control(gpib_board_t *board, struct tms9914_priv *pr
 		clear_bit(CIC_NUM, &board->status);
 		write_byte(priv, AUX_RLC, AUXCR);
 	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(tms9914_request_system_control);
 
diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
index d32420dee5e5..e43f3d0b1945 100644
--- a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
+++ b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
@@ -642,19 +642,21 @@ static int tnt4882_go_to_standby(gpib_board_t *board)
 	return nec7210_go_to_standby(board, &priv->nec7210_priv);
 }
 
-static void tnt4882_request_system_control(gpib_board_t *board, int request_control)
+static int tnt4882_request_system_control(gpib_board_t *board, int request_control)
 {
 	struct tnt4882_priv *priv = board->private_data;
+	int retval;
 
 	if (request_control) {
 		tnt_writeb(priv, SETSC, CMDR);
 		udelay(1);
 	}
-	nec7210_request_system_control(board, &priv->nec7210_priv, request_control);
+	retval = nec7210_request_system_control(board, &priv->nec7210_priv, request_control);
 	if (!request_control) {
 		tnt_writeb(priv, CLRSC, CMDR);
 		udelay(1);
 	}
+	return retval;
 }
 
 static void tnt4882_interface_clear(gpib_board_t *board, int assert)
-- 
2.48.1


