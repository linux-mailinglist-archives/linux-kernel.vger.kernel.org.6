Return-Path: <linux-kernel+bounces-381068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEA99AF9D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E4A1F25696
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B9F1B0F24;
	Fri, 25 Oct 2024 06:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8JMT8tI"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7C19AA5D;
	Fri, 25 Oct 2024 06:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729837157; cv=none; b=apRWaJTol1c8pOdfc4X0IiucWXyWVW5JvSN4ckTIOfHkLwTetUgeYhOUmOxp8dBfPQTsAQn56SzXDYbhbZrStKrc/C5TWtMALACHh5vG/d0fr78s7D1f4O+vzI8OoqRh7ltil1cvuSyxTL5qMy/2a3wWVsvyQjRho6+tvJkEnZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729837157; c=relaxed/simple;
	bh=SzoQ6pWwLA9emlyeEe1vi4JhbqCCw9VXx0XHEWULUxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJNoYIuUe9Y7uf7DbPDPEzAHxjNElD3or5ffFi/c55zsVY9rJpwmCRMqxHlMssht17rZ0UWgXjz9nHUKJLrJwPcPN73y8J1o/LwaCHrYFeuuvsIrQS8u5d8NwEbBUN/aTEykKXU4/2RXwCwMfw6GI8bdrwVNymVGMRggxINqoBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8JMT8tI; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so1204327a91.3;
        Thu, 24 Oct 2024 23:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729837155; x=1730441955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+/0SPQ8r7PbmavPDJd/94TVVDD0dd4aFDXw+3ZovcY=;
        b=W8JMT8tI+HDAiv5KuQ9vnj+/SeDa64MXSIYD9Cy32LRSFppzZdWCHFsPRywMDE4G01
         thShM5rBNWovcPOkPJ36sKmAHJbYvPC+R1QmUqnRgw/3EMY5wCdo04CMaJFaK06fF45r
         RS4DHrU7I3ZQRlwCN+EmmdzEHFpLYvh5GmsU8em3nHYnbfFXmdObVFKjBpJQczh0yDOr
         ZbxCd2feASnyHzGkmfvNfospWSkK9X1NGybS1x8s5oIg829Ty4q34k7TzwY8NA5ECvyO
         fh2/e/9JuFHc5OlSrR5WDQdUoI6YqybG45pG+b8Iinf1eIHCG4jf5SPYRz/xazM3g7QM
         OYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729837155; x=1730441955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+/0SPQ8r7PbmavPDJd/94TVVDD0dd4aFDXw+3ZovcY=;
        b=Ds2wdjtxwuxFz/Pk0ujddnh1PGH6SxnMwvj7xLiM5RROyAH/48BOsDwZMAFAhBJPg/
         Kdz7BGyCH6Z9jIQIUZ/B7U1xTAkydY2w3kyO4ycMbXlYiQTkqgcKLpRBp7ntpiA79d/m
         zryCwmrmJ6awIIjjJXSB+ArjsO8nHmkyDoMtcnepoRdkARX7GoXUeoII2uxvwAEJO5qY
         oE0asNE+m98QWooQpeATzUAePTbqfJsdK4zZT16AIba/L9q6mR8wRUdV8mcr+x8ZchP7
         5kLRG4C2Oo0DcbmVRzqJ/RPaqh2MqQnpLBFSfuukEGqUamFx2CIWTGRmZSHnAbSRusg+
         hdMg==
X-Forwarded-Encrypted: i=1; AJvYcCUYr1PKODi/r3/TvoxOJplQTJCDBJxnpBJSxYs9fhBnZJZzh8OOS4XABSduyBevoybgCzlrMq84/yiI@vger.kernel.org, AJvYcCWQleqmgla0NKrDooyuJOOHTXKixRQYP37U8IppoaCHN4oNP2kt46k9jjiMhAZyO1zl5jr8SMPZEtKErJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwVjPKfYhUviS7gK1R3xA6sHD1yoYgpby7qN+uisxM3WXySGge
	HwfyalQNGhmu4PmRevqEOaVU/i4L7EmDVnjRVCTtBss0up4fXh18bxRUYEsRMKw=
X-Google-Smtp-Source: AGHT+IGqxrEDW548GMoVXgdOh4pMugbaH1za8fjfzXQcvUGvosng9VHQOqVJzBf+zB/gtGI//J4I/w==
X-Received: by 2002:a17:90a:db86:b0:2e1:ce7b:6069 with SMTP id 98e67ed59e1d1-2e76b70c2a0mr9094050a91.33.1729837154622;
        Thu, 24 Oct 2024 23:19:14 -0700 (PDT)
Received: from asix-MS-7816.. ([2403:c300:550b:d387:a102:1511:5e8b:8a24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e578001sm2566697a91.43.2024.10.24.23.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:19:14 -0700 (PDT)
From: Tony Chung <tony467913@gmail.com>
To: johan@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Tony Chung <tony467913@gmail.com>
Subject: [PATCH v2 3/6] drivers: usb: serial: mos7840: fix coding style warnings
Date: Fri, 25 Oct 2024 14:17:12 +0800
Message-Id: <20241025061711.198933-4-tony467913@gmail.com>
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

fix coding style warning of
"Missing a blank line after declarations"

Signed-off-by: Tony Chung <tony467913@gmail.com>
---
 drivers/usb/serial/mos7840.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index b1a794f99..b48a26468 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -228,6 +228,7 @@ static int mos7840_set_reg_sync(struct usb_serial_port *port, __u16 reg,
 				__u16 val)
 {
 	struct usb_device *dev = port->serial->dev;
+
 	val = val & 0x00ff;
 	dev_dbg(&port->dev, "mos7840_set_reg_sync offset is %x, value %x\n", reg, val);
 
@@ -280,6 +281,7 @@ static int mos7840_set_uart_reg(struct usb_serial_port *port, __u16 reg,
 {
 
 	struct usb_device *dev = port->serial->dev;
+
 	val = val & 0x00ff;
 	/* For the UART control registers, the application number need
 	 * to be Or'ed
@@ -449,6 +451,7 @@ static void mos7840_bulk_in_callback(struct urb *urb)
 
 	if (urb->actual_length) {
 		struct tty_port *tport = &mos7840_port->port->port;
+
 		tty_insert_flip_string(tport, data, urb->actual_length);
 		tty_flip_buffer_push(tport);
 		port->icount.rx += urb->actual_length;
@@ -743,6 +746,7 @@ static unsigned int mos7840_chars_in_buffer(struct tty_struct *tty)
 	for (i = 0; i < NUM_URBS; ++i) {
 		if (mos7840_port->busy[i]) {
 			struct urb *urb = mos7840_port->write_urb_pool[i];
+
 			chars += urb->transfer_buffer_length;
 		}
 	}
@@ -944,6 +948,7 @@ static void mos7840_throttle(struct tty_struct *tty)
 	/* if we are implementing XON/XOFF, send the stop character */
 	if (I_IXOFF(tty)) {
 		unsigned char stop_char = STOP_CHAR(tty);
+
 		status = mos7840_write(tty, port, &stop_char, 1);
 		if (status <= 0)
 			return;
@@ -973,6 +978,7 @@ static void mos7840_unthrottle(struct tty_struct *tty)
 	/* if we are implementing XON/XOFF, send the start character */
 	if (I_IXOFF(tty)) {
 		unsigned char start_char = START_CHAR(tty);
+
 		status = mos7840_write(tty, port, &start_char, 1);
 		if (status <= 0)
 			return;
-- 
2.34.1


