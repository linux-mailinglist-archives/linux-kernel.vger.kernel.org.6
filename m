Return-Path: <linux-kernel+bounces-527470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE36A40B95
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 21:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680EA3BC3B6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94AF201113;
	Sat, 22 Feb 2025 20:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckXn6Ezi"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100701531DB
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740257125; cv=none; b=tSNcCGjAQxczt2wx7nXgekdESDqeB86FSt2nj03lUtGcaGD7sCF7NDWflqOnQy6P1ReFx+6m51sb0km4RPx417pCmsGE50jNKQE/K5HA190pp+bfO+7J+/VmG/Dc0i1crxWdXikkN1DFNt5fd5uy/6xoGeNW9A2dfCDh64JetgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740257125; c=relaxed/simple;
	bh=dGrVVFg7ISr/V8vZz+OTqtD0mPL1jaOQDzL5DVtlWOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=trnAo5AvmrGzqZvmnAgLfVgBxcBH3+Y8BNuf086VCo0IPunz5+hPTsoDtqmOvCx0belozg6MB3td8PSA05Z6Qe1q1NztIXjibDA9vjrOCJT7vOuHKRCcocoRcBnFjLFrimU0SgnENy7uqTJlLPqzjePygC1axS6IG7llrIEfr2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckXn6Ezi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4398ec2abc2so28263095e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 12:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740257121; x=1740861921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TvT7dtWi6+ARu5un8G5FtK9nNIMwdG/GyzImr2AnEkc=;
        b=ckXn6Ezi+DevRE7NHN1pMpUGtYttr++0pKS+AKQBOk1r1elkCnLKdFTGLE42YoBd/b
         NTynXC/cAhh4CC5gX7eqd/3kSOdLVIjI2CzNy+OESTiDAj5S5tsuO5CJ97J8WqrJxTSc
         J/2qeB9Bcr/7myqKteeqZ54zzo8FsDnbpcs2raAVcAbXXmd8Q5z6dN62QHcDnRuFixH2
         XlMqdyJGy3H3GicwHbuBZrpjYw30IvNVl44p0fx9XJRCH1ha6rykdZNRQmvMQkMYTdX7
         iNh768iziBSJ+25t0oqcj/Wbtc/HrG9qfAT6LVPtpczjjF0590b3Z0Kk+djq0oJ+YO+/
         FG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740257121; x=1740861921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TvT7dtWi6+ARu5un8G5FtK9nNIMwdG/GyzImr2AnEkc=;
        b=fe8HXyl7SqjESCQPT4ewlPJhYArxfIDz98M+vKaSlLXetebYW2sfCrM8DO0fp763+R
         f5dY7779Ig2+ZuJCbCRbNxoovjI/SF5FAAc/4fcAbL8MLxS2LZu6zwTDsIAtpOhZXWvL
         pz7wu8JIQbs6Gc87/Ojh+V85vUqatVQtQZSk5oSVMsIgbto8JDDTwvwqQ7bCAZp6OVPs
         ksxUOEElK9F/fDHl/obBYAJ5saoloBrlk9ogEJmsCbh+beU235cfW79yzOWT+4+uUglz
         ENVAnX/d0GFsEdiYJBwJ61hSfT1PgCZ35ktIrHjulK2nZ8iNO+OSNF2LyrCJKFcBhGWq
         RkWg==
X-Forwarded-Encrypted: i=1; AJvYcCX+It5BcnfiCrpGShpTAedQ6ywKF62vv4xNVYwZpch3gZ4DeEDVplR0AJEu7pmcl13Tb8vw/+dyNkfasCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7GPio6qHEuP1iOav6nR58pZJ7pA1lYyMzn+ulC/th71ldR2AT
	QY6QEJUYi0Ofs/IGi3AntTabyLqTPY8rea9Pc0I1N0t5DyG5M9ztdL23w1s1
X-Gm-Gg: ASbGncsLhpzuUEE5SozrCJGnty9GbZtTZjQk+V7vaOQjAX0MfzfqWqfnxDajbh/jqF2
	PFEpCtemloH3NebhnNILY0ESLwuSy2iFdZZU8jVgami3fjPcQCuDnWWAWY6Ei6FRWUB+yYSU1ye
	hsBRac26xN6LBHWd1mRzuxQkQqQS8/JNcNNJa2H/8zOHUeAem/0MJBJ7ztQDoccZUp5fYTcPrME
	OkkVp+mdTTX+fDc5dfkVZ8aKrWv9wLj8nERKCSZGOrOu40+BLI5ODt8cw/CR4ntj237EIbETdeR
	BuRdB5eOIT+zo8tqNYUcJSvt7S0QyODR+lAIThA/4xoC1rWjbrlc1if3LN68HA==
X-Google-Smtp-Source: AGHT+IFg72/wH8hwyMZUIc/PuFZTgmxKlENVWdLU/TRzypJUgaSDKiqcUJeVbRCZRqLcyAMVXFnbJg==
X-Received: by 2002:a05:600c:5101:b0:439:65f0:c9ce with SMTP id 5b1f17b1804b1-439ae220a84mr56715795e9.25.1740257121120;
        Sat, 22 Feb 2025 12:45:21 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b031c5casm56553085e9.39.2025.02.22.12.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 12:45:19 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH] staging: gpib: Fix Oops after disconnect in agilent usb
Date: Sat, 22 Feb 2025 21:45:15 +0100
Message-ID: <20250222204515.5104-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the agilent usb dongle is disconnected subsequent calls to the
driver cause a NULL dereference Oops as the bus_interface
is set to NULL on disconnect.

This problem was introduced by setting usb_dev from the bus_interface
for dev_xxx messages.

Previously bus_interface was checked for NULL only in the functions
directly calling usb_fill_bulk_urb or usb_control_msg.

Check for valid bus_interface on all interface entry points
and return -ENODEV if it is NULL.

Fixes: fbae7090f30c ("staging: gpib: Update messaging and usb_device refs in agilent_usb")

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 .../gpib/agilent_82357a/agilent_82357a.c      | 65 ++++++++++++++++---
 1 file changed, 55 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
index 7ebebe00dc48..e0d36f0dff25 100644
--- a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
+++ b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
@@ -427,7 +427,7 @@ static int agilent_82357a_read(gpib_board_t *board, uint8_t *buffer, size_t leng
 {
 	int retval;
 	struct agilent_82357a_priv *a_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	int out_data_length, in_data_length;
 	int bytes_written, bytes_read;
@@ -438,6 +438,10 @@ static int agilent_82357a_read(gpib_board_t *board, uint8_t *buffer, size_t leng
 
 	*nbytes = 0;
 	*end = 0;
+
+	if (!a_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	out_data_length = 0x9;
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
@@ -534,7 +538,7 @@ static ssize_t agilent_82357a_generic_write(gpib_board_t *board, uint8_t *buffer
 {
 	int retval;
 	struct agilent_82357a_priv *a_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data = NULL;
 	u8 *status_data = NULL;
 	int out_data_length;
@@ -545,6 +549,10 @@ static ssize_t agilent_82357a_generic_write(gpib_board_t *board, uint8_t *buffer
 	struct agilent_82357a_register_pairlet read_reg;
 
 	*bytes_written = 0;
+	if (!a_priv->bus_interface)
+		return -ENODEV;
+
+	usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	out_data_length = length + 0x8;
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
@@ -697,9 +705,13 @@ int agilent_82357a_take_control_internal(gpib_board_t *board, int synchronous)
 
 static int agilent_82357a_take_control(gpib_board_t *board, int synchronous)
 {
+	struct agilent_82357a_priv *a_priv = board->private_data;
 	const int timeout = 10;
 	int i;
 
+	if (!a_priv->bus_interface)
+		return -ENODEV;
+
 /* It looks like the 9914 does not handle tcs properly.
  *  See comment above tms9914_take_control_workaround() in
  *  drivers/gpib/tms9914/tms9914_aux.c
@@ -723,10 +735,14 @@ static int agilent_82357a_take_control(gpib_board_t *board, int synchronous)
 static int agilent_82357a_go_to_standby(gpib_board_t *board)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
+	struct usb_device *usb_dev;
 	struct agilent_82357a_register_pairlet write;
 	int retval;
 
+	if (!a_priv->bus_interface)
+		return -ENODEV;
+
+	usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	write.address = AUXCR;
 	write.value = AUX_GTS;
 	retval = agilent_82357a_write_registers(a_priv, &write, 1);
@@ -739,11 +755,15 @@ static int agilent_82357a_go_to_standby(gpib_board_t *board)
 static void agilent_82357a_request_system_control(gpib_board_t *board, int request_control)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
+	struct usb_device *usb_dev;
 	struct agilent_82357a_register_pairlet writes[2];
 	int retval;
 	int i = 0;
 
+	if (!a_priv->bus_interface)
+		return; // -ENODEV;
+
+	usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	/* 82357B needs bit to be set in 9914 AUXCR register */
 	writes[i].address = AUXCR;
 	if (request_control) {
@@ -767,10 +787,14 @@ static void agilent_82357a_request_system_control(gpib_board_t *board, int reque
 static void agilent_82357a_interface_clear(gpib_board_t *board, int assert)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
+	struct usb_device *usb_dev;
 	struct agilent_82357a_register_pairlet write;
 	int retval;
 
+	if (!a_priv->bus_interface)
+		return; // -ENODEV;
+
+	usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	write.address = AUXCR;
 	write.value = AUX_SIC;
 	if (assert) {
@@ -785,10 +809,14 @@ static void agilent_82357a_interface_clear(gpib_board_t *board, int assert)
 static void agilent_82357a_remote_enable(gpib_board_t *board, int enable)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
+	struct usb_device *usb_dev;
 	struct agilent_82357a_register_pairlet write;
 	int retval;
 
+	if (!a_priv->bus_interface)
+		return; //-ENODEV;
+
+	usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	write.address = AUXCR;
 	write.value = AUX_SRE;
 	if (enable)
@@ -804,6 +832,8 @@ static int agilent_82357a_enable_eos(gpib_board_t *board, uint8_t eos_byte, int
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 
+	if (!a_priv->bus_interface)
+		return -ENODEV;
 	if (compare_8_bits == 0)
 		return -EOPNOTSUPP;
 
@@ -822,10 +852,13 @@ static void agilent_82357a_disable_eos(gpib_board_t *board)
 static unsigned int agilent_82357a_update_status(gpib_board_t *board, unsigned int clear_mask)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
+	struct usb_device *usb_dev;
 	struct agilent_82357a_register_pairlet address_status, bus_status;
 	int retval;
 
+	if (!a_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	board->status &= ~clear_mask;
 	if (a_priv->is_cic)
 		set_bit(CIC_NUM, &board->status);
@@ -885,6 +918,9 @@ static int agilent_82357a_primary_address(gpib_board_t *board, unsigned int addr
 	struct agilent_82357a_register_pairlet write;
 	int retval;
 
+	if (!a_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	// put primary address in address0
 	write.address = ADR;
 	write.value = address & ADDRESS_MASK;
@@ -906,11 +942,14 @@ static int agilent_82357a_secondary_address(gpib_board_t *board, unsigned int ad
 static int agilent_82357a_parallel_poll(gpib_board_t *board, uint8_t *result)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
+	struct usb_device *usb_dev;
 	struct agilent_82357a_register_pairlet writes[2];
 	struct agilent_82357a_register_pairlet read;
 	int retval;
 
+	if (!a_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	// execute parallel poll
 	writes[0].address = AUXCR;
 	writes[0].value = AUX_CS | AUX_RPP;
@@ -975,11 +1014,14 @@ static void agilent_82357a_return_to_local(gpib_board_t *board)
 static int agilent_82357a_line_status(const gpib_board_t *board)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
+	struct usb_device *usb_dev;
 	struct agilent_82357a_register_pairlet bus_status;
 	int retval;
 	int status = ValidALL;
 
+	if (!a_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	bus_status.address = BSR;
 	retval = agilent_82357a_read_registers(a_priv, &bus_status, 1, 0);
 	if (retval) {
@@ -1025,10 +1067,13 @@ static unsigned short nanosec_to_fast_talker_bits(unsigned int *nanosec)
 static unsigned int agilent_82357a_t1_delay(gpib_board_t *board, unsigned int nanosec)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
+	struct usb_device *usb_dev;
 	struct agilent_82357a_register_pairlet write;
 	int retval;
 
+	if (!a_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	write.address = FAST_TALKER_T1;
 	write.value = nanosec_to_fast_talker_bits(&nanosec);
 	retval = agilent_82357a_write_registers(a_priv, &write, 1);
-- 
2.48.1


