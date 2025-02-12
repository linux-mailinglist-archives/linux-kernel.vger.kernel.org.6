Return-Path: <linux-kernel+bounces-510398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2672A31C33
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7500C166153
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14A31D6DDD;
	Wed, 12 Feb 2025 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+XFsYT/"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E5A1D54E2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328186; cv=none; b=mkiUnpgmhfU1pJKCzdvOHx9Ee5LBnwm13DRJr6gJ9vE5RcQlNB4lW7GSJ8aAvMx6Q/dlQoTrMd2NwAqScDfnQWXXREDmOLnCFaTHQgL/PuPjw34+GFuw6DIfYl2dsKYitqqJua8gR4zKNgYKwr7HumyUy/m8VfVgqhTsW95SLsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328186; c=relaxed/simple;
	bh=TYe5hzR1twggHIuKNLBq5BSdZdoAfkP0W7GtGKvuD+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZvLav6fN4NW8ERt6zt5UGD8ad/XV8oFHCy9NpDMd3WuC9h0v0cAxywWYteQDKAuynMpNtuezs+GKrPLhOeQyxCDzCYCOEuxPQ6IDQ4HCRHcOaYv2vlCv9EJjl6lPatiMh8tUVMfZN221GaRWujp/BA2XFHjlaDaIDfzo2pzLTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+XFsYT/; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-726e56adc00so1116039a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 18:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739328184; x=1739932984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8O3tO5rM/sacpg6xfViguUae5/GtGoWDwnWiYIXc/7E=;
        b=m+XFsYT/4uHxBPv7Dmf2WFlDzrjFwbXxyrEJ4MdrV1jyGQGknn3bEgSROdHzWoDH2R
         55cwh0CxHofjzVbEUywJu1VJz8MvXiB4JRdu3n0+K37Z2Y1SzhSMkmRGVymlZBZIJYEh
         FIYqBADH5CdtC1MaqzIHTw9Eyz3A6ei5BX5GF7BHms6Qe2/70voozAxJwZI8IWT1Okpq
         HcxWYKNWEMmHc+iCO4ORFw5FNBB9qWPBGZwFuDhZ294r0iVen24vt8tJwsStPGB3Fziy
         5Y3hczqNtZUpXC0sHmNRvxifnqBNMNpaFD7Amtrnc/MJuXP7rUUpQ053i5SZgyiNtkMg
         ej5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739328184; x=1739932984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8O3tO5rM/sacpg6xfViguUae5/GtGoWDwnWiYIXc/7E=;
        b=rA7uqhLZ/dUcvoT7DVXs4Sv5aOhM9MIy6bg6ycs40crxrO9VoE1x0UEcXEsoSoIWRo
         xOGys1WDhVLx+nedMtgxWJ6vxioJxBgWItJJRd0sPJyQU2CAJR7slwI4ZAuDOWYmJBaT
         v9PPlEN24FExm+o/djlaqaHSGz0lpoCVEcUz/bz8WE3N+J072AF3q1cvJBxhJagPymPI
         5x4t6qFhtMCSUYZxUfhWMbI31VHn0p8gFhsCVZySKNKOR2t/bNOhQPjBl4eBLVB9b/aM
         71e5g3YMeLSbWvGg7n9SZwxv9PauG2hcJJCm14/DUhSRMbGFgg4bN0I0/vamdvxV8o8A
         q3RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCF63oOI5VhSu3yv2fLkynIkbxNWtmdoKh9ReLtMXD4Lpfemxh0TBBJ2cbHVHBc96TtwH6YVaBd0I9UTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcCcy+pIDug0Ltq3q44DQsGjHXa9q+mU8jOSVrJsFw/bP6qTw6
	OnkKdstUM3IIm0f82DGuU7lVwMDIrmdurI+0YzwqlG2/TiwVwE5T
X-Gm-Gg: ASbGnctDveDg0nBY7GsVbYoPpoPhACQxV6bxUVtWmHNsDVok9NwG1G1jtqr+C0Qxzi1
	Rz6iHHl7BDDpanxKpDcdhnaUeNFDOKSS6AJKrUaLGKM6aEOX5/DIriNcxuHLBtz2VYMjblta1pQ
	qlCZe3XzAP6rixK9ISzva6lQA2TUeCdOc7FW9HyLT/9VL3PDOzgVuclhW5x7xdilST0ZTwRjgjA
	er2r2DJ8CccSyowaSoFFC8ToMVeE9KxFImLvA3zzJ7/izYpvj/imXsJwAYvmwMhqBKBjOMNENR0
	PJ8Yex4Rbg57/+uPHPh3KFJYQJiOcuGSG8gdgPc=
X-Google-Smtp-Source: AGHT+IH3UF1z+rZO2ADw5iql0azrJhITlhMG9VT70q+bfryTBuPnc1FT2rV0EX+2X9AUG56QHpZpBQ==
X-Received: by 2002:a05:6808:80c8:b0:3f3:cbe4:9a86 with SMTP id 5614622812f47-3f3cd9227fbmr1394025b6e.18.1739328182832;
        Tue, 11 Feb 2025 18:43:02 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726afa4efb8sm4059667a34.66.2025.02.11.18.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 18:43:02 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	dan.carpenter@linaro.org,
	dpenkler@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: gpib: change return type of t1_delay function to report errors
Date: Tue, 11 Feb 2025 23:35:36 -0300
Message-ID: <20250212024247.176572-2-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250212024247.176572-1-rodrigo.gobbi.7@gmail.com>
References: <20250212024247.176572-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Propagate t1 delay configuration error to userspace

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 2 +-
 drivers/staging/gpib/agilent_82357a/agilent_82357a.c | 2 +-
 drivers/staging/gpib/cb7210/cb7210.c                 | 2 +-
 drivers/staging/gpib/cec/cec_gpib.c                  | 2 +-
 drivers/staging/gpib/common/gpib_os.c                | 5 ++++-
 drivers/staging/gpib/eastwood/fluke_gpib.c           | 2 +-
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c             | 2 +-
 drivers/staging/gpib/gpio/gpib_bitbang.c             | 2 +-
 drivers/staging/gpib/hp_82335/hp82335.c              | 2 +-
 drivers/staging/gpib/hp_82341/hp_82341.c             | 2 +-
 drivers/staging/gpib/include/gpib_types.h            | 2 +-
 drivers/staging/gpib/include/nec7210.h               | 2 +-
 drivers/staging/gpib/ines/ines.h                     | 2 +-
 drivers/staging/gpib/ines/ines_gpib.c                | 2 +-
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c   | 3 +--
 drivers/staging/gpib/nec7210/nec7210.c               | 2 +-
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c            | 4 ++--
 drivers/staging/gpib/pc2/pc2_gpib.c                  | 2 +-
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c          | 2 +-
 19 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index 5c62ec24fced..d3635d283234 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -475,7 +475,7 @@ static int agilent_82350b_line_status(const gpib_board_t *board)
 	return tms9914_line_status(board, &priv->tms9914_priv);
 }
 
-static unsigned int agilent_82350b_t1_delay(gpib_board_t *board, unsigned int nanosec)
+static int agilent_82350b_t1_delay(gpib_board_t *board, unsigned int nanosec)
 {
 	struct agilent_82350b_priv *a_priv = board->private_data;
 	static const int nanosec_per_clock = 30;
diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
index 69f0e490d401..f081bbbda54c 100644
--- a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
+++ b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
@@ -1044,7 +1044,7 @@ static unsigned short nanosec_to_fast_talker_bits(unsigned int *nanosec)
 	return bits;
 }
 
-static unsigned int agilent_82357a_t1_delay(gpib_board_t *board, unsigned int nanosec)
+static int agilent_82357a_t1_delay(gpib_board_t *board, unsigned int nanosec)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
diff --git a/drivers/staging/gpib/cb7210/cb7210.c b/drivers/staging/gpib/cb7210/cb7210.c
index 381c508f62eb..e2e90dd11f0b 100644
--- a/drivers/staging/gpib/cb7210/cb7210.c
+++ b/drivers/staging/gpib/cb7210/cb7210.c
@@ -410,7 +410,7 @@ static int cb7210_line_status(const gpib_board_t *board)
 	return status;
 }
 
-static unsigned int cb7210_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int cb7210_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	struct cb7210_priv *cb_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &cb_priv->nec7210_priv;
diff --git a/drivers/staging/gpib/cec/cec_gpib.c b/drivers/staging/gpib/cec/cec_gpib.c
index 18933223711e..801f041def99 100644
--- a/drivers/staging/gpib/cec/cec_gpib.c
+++ b/drivers/staging/gpib/cec/cec_gpib.c
@@ -169,7 +169,7 @@ static uint8_t cec_serial_poll_status(gpib_board_t *board)
 	return nec7210_serial_poll_status(board, &priv->nec7210_priv);
 }
 
-static unsigned int cec_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int cec_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	struct cec_priv *priv = board->private_data;
 
diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
index 4901e660242e..321f93d926b6 100644
--- a/drivers/staging/gpib/common/gpib_os.c
+++ b/drivers/staging/gpib/common/gpib_os.c
@@ -2018,8 +2018,11 @@ static int t1_delay_ioctl(gpib_board_t *board, unsigned long arg)
 
 	delay = cmd;
 
-	board->t1_nano_sec = board->interface->t1_delay(board, delay);
+	retval = board->interface->t1_delay(board, delay);
+	if (retval < 0)
+		return retval;
 
+	board->t1_nano_sec = retval;
 	return 0;
 }
 
diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
index d5b1a03abf11..77b912326018 100644
--- a/drivers/staging/gpib/eastwood/fluke_gpib.c
+++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
@@ -221,7 +221,7 @@ static int fluke_line_status(const gpib_board_t *board)
 	return status;
 }
 
-static unsigned int fluke_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int fluke_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	struct fluke_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
index f950e7cdd8f8..211807c25a6b 100644
--- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
@@ -255,7 +255,7 @@ static int fmh_gpib_line_status(const gpib_board_t *board)
 	return status;
 }
 
-static unsigned int fmh_gpib_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int fmh_gpib_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	struct fmh_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 828c99ea613f..23af35b96354 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -1012,7 +1012,7 @@ static uint8_t bb_serial_poll_status(gpib_board_t *board)
 	return 0; // -ENOSYS;
 }
 
-static unsigned int bb_t1_delay(gpib_board_t *board,  unsigned int nano_sec)
+static int bb_t1_delay(gpib_board_t *board,  unsigned int nano_sec)
 {
 	struct bb_priv *priv = board->private_data;
 
diff --git a/drivers/staging/gpib/hp_82335/hp82335.c b/drivers/staging/gpib/hp_82335/hp82335.c
index 451d5dc6d340..a1151ee8f373 100644
--- a/drivers/staging/gpib/hp_82335/hp82335.c
+++ b/drivers/staging/gpib/hp_82335/hp82335.c
@@ -161,7 +161,7 @@ static int hp82335_line_status(const gpib_board_t *board)
 	return tms9914_line_status(board, &priv->tms9914_priv);
 }
 
-static unsigned int hp82335_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int hp82335_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	struct hp82335_priv *priv = board->private_data;
 
diff --git a/drivers/staging/gpib/hp_82341/hp_82341.c b/drivers/staging/gpib/hp_82341/hp_82341.c
index 800f99c05566..aeca0013328f 100644
--- a/drivers/staging/gpib/hp_82341/hp_82341.c
+++ b/drivers/staging/gpib/hp_82341/hp_82341.c
@@ -397,7 +397,7 @@ static int hp_82341_line_status(const gpib_board_t *board)
 	return tms9914_line_status(board, &priv->tms9914_priv);
 }
 
-static unsigned int hp_82341_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int hp_82341_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
diff --git a/drivers/staging/gpib/include/gpib_types.h b/drivers/staging/gpib/include/gpib_types.h
index b41781a55a60..5ee72683b2e0 100644
--- a/drivers/staging/gpib/include/gpib_types.h
+++ b/drivers/staging/gpib/include/gpib_types.h
@@ -170,7 +170,7 @@ struct gpib_interface_struct {
 	 */
 	uint8_t (*serial_poll_status)(gpib_board_t *board);
 	/* adjust T1 delay */
-	unsigned int (*t1_delay)(gpib_board_t *board, unsigned int nano_sec);
+	int (*t1_delay)(gpib_board_t *board, unsigned int nano_sec);
 	/* go to local mode */
 	void (*return_to_local)(gpib_board_t *board);
 	/* board does not support 7 bit eos comparisons */
diff --git a/drivers/staging/gpib/include/nec7210.h b/drivers/staging/gpib/include/nec7210.h
index ca998c4a84bf..aa03c234aa60 100644
--- a/drivers/staging/gpib/include/nec7210.h
+++ b/drivers/staging/gpib/include/nec7210.h
@@ -108,7 +108,7 @@ void nec7210_parallel_poll_response(gpib_board_t *board,
 				    struct nec7210_priv *priv, int ist);
 uint8_t nec7210_serial_poll_status(gpib_board_t *board,
 				   struct nec7210_priv *priv);
-unsigned int nec7210_t1_delay(gpib_board_t *board,
+int nec7210_t1_delay(gpib_board_t *board,
 			      struct nec7210_priv *priv, unsigned int nano_sec);
 void nec7210_return_to_local(const gpib_board_t *board, struct nec7210_priv *priv);
 
diff --git a/drivers/staging/gpib/ines/ines.h b/drivers/staging/gpib/ines/ines.h
index 3918737fa21a..57c3a4f8a546 100644
--- a/drivers/staging/gpib/ines/ines.h
+++ b/drivers/staging/gpib/ines/ines.h
@@ -60,7 +60,7 @@ void ines_parallel_poll_response(gpib_board_t *board, int ist);
 void ines_serial_poll_response(gpib_board_t *board, uint8_t status);
 uint8_t ines_serial_poll_status(gpib_board_t *board);
 int ines_line_status(const gpib_board_t *board);
-unsigned int ines_t1_delay(gpib_board_t *board, unsigned int nano_sec);
+int ines_t1_delay(gpib_board_t *board, unsigned int nano_sec);
 void ines_return_to_local(gpib_board_t *board);
 
 // interrupt service routines
diff --git a/drivers/staging/gpib/ines/ines_gpib.c b/drivers/staging/gpib/ines/ines_gpib.c
index 22a05a287bce..2aac58ca7ed4 100644
--- a/drivers/staging/gpib/ines/ines_gpib.c
+++ b/drivers/staging/gpib/ines/ines_gpib.c
@@ -63,7 +63,7 @@ void ines_set_xfer_counter(struct ines_priv *priv, unsigned int count)
 	ines_outb(priv, count & 0xff, XFER_COUNT_LOWER);
 }
 
-unsigned int ines_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+int ines_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	struct ines_priv *ines_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &ines_priv->nec7210_priv;
diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 85322af62c23..84f9bde6f8d1 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -1120,8 +1120,7 @@ static uint8_t usb_gpib_serial_poll_status(gpib_board_t *board)
 }
 
 /* t1_delay */
-
-static unsigned int usb_gpib_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int usb_gpib_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	dev_alert(board->gpib_dev, "%s:%s - currently a NOP\n", NAME, __func__);
 	return 0;
diff --git a/drivers/staging/gpib/nec7210/nec7210.c b/drivers/staging/gpib/nec7210/nec7210.c
index c9a837fad96e..34ef2b1ff6e1 100644
--- a/drivers/staging/gpib/nec7210/nec7210.c
+++ b/drivers/staging/gpib/nec7210/nec7210.c
@@ -373,7 +373,7 @@ void nec7210_release_rfd_holdoff(gpib_board_t *board, struct nec7210_priv *priv)
 }
 EXPORT_SYMBOL(nec7210_release_rfd_holdoff);
 
-unsigned int nec7210_t1_delay(gpib_board_t *board, struct nec7210_priv *priv,
+int nec7210_t1_delay(gpib_board_t *board, struct nec7210_priv *priv,
 			      unsigned int nano_sec)
 {
 	unsigned int retval;
diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index d0656dc520f5..cb8840f2a461 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -1591,7 +1591,7 @@ static int ni_usb_setup_t1_delay(struct ni_usb_register *reg, unsigned int nano_
 	return i;
 }
 
-static unsigned int ni_usb_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int ni_usb_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1605,7 +1605,7 @@ static unsigned int ni_usb_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
 		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
-		return -1;	//FIXME should change return type to int for error reporting
+		return -EIO;
 	}
 	board->t1_nano_sec = actual_ns;
 	ni_usb_soft_update_status(board, ibsta, 0);
diff --git a/drivers/staging/gpib/pc2/pc2_gpib.c b/drivers/staging/gpib/pc2/pc2_gpib.c
index 3eccd4c54afa..863217aea818 100644
--- a/drivers/staging/gpib/pc2/pc2_gpib.c
+++ b/drivers/staging/gpib/pc2/pc2_gpib.c
@@ -215,7 +215,7 @@ static uint8_t pc2_serial_poll_status(gpib_board_t *board)
 	return nec7210_serial_poll_status(board, &priv->nec7210_priv);
 }
 
-static unsigned int pc2_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int pc2_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	struct pc2_priv *priv = board->private_data;
 
diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
index 2e1c3cbebaca..924af43025ed 100644
--- a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
+++ b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
@@ -176,7 +176,7 @@ static int tnt4882_line_status(const gpib_board_t *board)
 	return status;
 }
 
-static unsigned int tnt4882_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int tnt4882_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	struct tnt4882_priv *tnt_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &tnt_priv->nec7210_priv;
-- 
2.47.0


