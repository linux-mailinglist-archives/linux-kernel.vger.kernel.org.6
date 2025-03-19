Return-Path: <linux-kernel+bounces-568889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3739FA69BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE1219C46FD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D32222B7;
	Wed, 19 Mar 2025 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="ZPADH/pw"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB6C221572
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421597; cv=none; b=cXg42at2toPfQaazSGtuzIoHyvXBrJcUeVIKd8O/xRLsddQB8SwQUNczOt4VID0e0AN2y7dY7KVDzasah/oDWwP8eqcE+ArSrn6BRRWReyctT/i9WIgA6B2rj4DhPY/GxNnKmu3KWuu3QmvCD9a6ft4++LSzsUyKuOga/TQhMx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421597; c=relaxed/simple;
	bh=PXFbG5O/nfvHW1QzJUbSW3+qHxjDhuJAY/1zhSCjGiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4p8vVv+IE/W3HqzXTp2PzljdoblW8G2t+X3PJPagPTQrWltwlmEN3Na3ytO+W90c5yT413OdkIj1oZ0R0n6OVLYSF89V6ZWf7JNc0wGium/w8LZIWmfpG9m2yxdfGr3BjCAX0nxshn2gAdF/bC/qXNaTgXm6uACoBr6btniXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=ZPADH/pw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2241053582dso1176265ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421594; x=1743026394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oa+0Pt1V4+SqMSbsbweCkzQQ9zLDOIiBj8exlzrjjFY=;
        b=ZPADH/pw9/qAIujrm3Mdth1RmEZB49JBywQ2560I1yXkzCe/x9Bu6TUjswZ+sUNCQr
         +pK2KclSBA4Hz5dp3g9BTbcaRhhZ2bU4LtkqZBj43lGXnh1ScGCOIsqsxCwKvn9WwB1q
         EhN8n0SDSqTgw5t9+n0PfnUUjwqiGGPheHhsAIe4qigkJzEkvauyqwBh3qChCnAi2FsQ
         exX7WO5GeTqWr8wfJIx5gZvmMKUEzkzrFf3gluQaBXP3J4cmAOtFZDBnAqzAZ23p66c+
         dobKAQCGhzDyomYRKFKpF1vI+QIQ4PRhs6gBoT17g+SqetdWP27cqMwgeI6j1rPltjoJ
         4czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421594; x=1743026394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oa+0Pt1V4+SqMSbsbweCkzQQ9zLDOIiBj8exlzrjjFY=;
        b=cuGZT1SWVNd0MhPLAlwN6w+Vb/BqMnJEGdzyoLRKQnj9j5gsym8D1MjdnXyA+zgfZd
         AKl2xkKwEs+bz3jEsnYIuzQt1XOOMgYCKu1GnWMU3XEHaO3oTtNBRY9CvOTcPqZr359b
         i0+oGvDImZgwxfY4EhevQnUpHl29erkZCSZor1+pvQUydlE0VEVQtQ5MCXSitD6+xj0a
         W61nCUIEfqbIyAZeoXRIxJI7pseW88EJsAgw9ATf5gvvYtkvpOt+zE+dHsEwN9cQ0Zo/
         NiMV9JFGe2LvGF0eYBLCZ4D+53pya2ujDRRkK5TQdWREr49jBZ4RxLpae4yDxLL57lzA
         nlug==
X-Forwarded-Encrypted: i=1; AJvYcCVAysK8aGp142UtCOvAklljElzti45Coz/KPNyLzT5vTJzSfkPbgnOdjYq6gwAhKRJJpq6Q2QqfJDUYPxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNRQV7BtwDGhoP+JDLwR/i8nyPaf8bIPyAr9VDrXk4ZB2Mrk9l
	6WPCgtHKW+ZwMEz1XaOb3hlXWKonXDAoWRbKrjPyxheeuJl4aZm++kJbVo1pDQ==
X-Gm-Gg: ASbGncv4uQc1IK23lE6UdfcfdeegP5UVqPa6DH0HxIAm/xk7o9l4WpWVuO2/8aj7yGH
	UMPO6hmgAthwCSGxj/gan1getscMDBf+1zyeCsrR0+Pbg5eRSrx+org7pQuEVxm7pYCQf76JeWb
	WNI57w2XcBHZcXZ2y0ciUYo++1WN5NMSpaeqBKPG39AjgUFpC6K5XrQ88LwesY4s2RtyjhT1dgD
	pT10dXscACu0azfFPBUp0k4Al5oYndHLcWrjMDjwYleL8JkfscSd9s1lY4QrCWbrLcd7K9LCDPd
	brDF02vBPzCcvXS0+GP9gXL5iVXPMeuHisfSE8TJGRq/YxEJ3VIsl7l8fFyVonb8i8jzVjLreqh
	6aqnlkqiM+w==
X-Google-Smtp-Source: AGHT+IFr4kp9t3TFnrrNqlwiKDZtLS8gq+a1DwiAWOWfX/zxf6y66YjdjOLGxC55fcS/6b0iLtY1Uw==
X-Received: by 2002:a17:903:228f:b0:216:3c36:69a7 with SMTP id d9443c01a7336-22649a803bcmr54470095ad.45.1742421594533;
        Wed, 19 Mar 2025 14:59:54 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5488sm120624775ad.245.2025.03.19.14.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:59:54 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 14/20] staging: gpib: nec7210 struct gpib_board
Date: Wed, 19 Mar 2025 21:59:18 +0000
Message-ID: <20250319215924.19387-15-matchstick@neverthere.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319215924.19387-1-matchstick@neverthere.org>
References: <20250319215924.19387-1-matchstick@neverthere.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using Linux code style for struct gpib_board.

Adhering to Linux code style.

In general, a pointer, or a struct that has elements that can reasonably be
directly accessed should never be a typedef.

Signed-off-by: Michael Rubin <matchstick@neverthere.org>
---
 drivers/staging/gpib/include/nec7210.h | 58 ++++++++++----------
 drivers/staging/gpib/nec7210/nec7210.c | 76 +++++++++++++-------------
 2 files changed, 68 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/gpib/include/nec7210.h b/drivers/staging/gpib/include/nec7210.h
index ca998c4a84bf..6c49283bd139 100644
--- a/drivers/staging/gpib/include/nec7210.h
+++ b/drivers/staging/gpib/include/nec7210.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+//* SPDX-License-Identifier: GPL-2.0 */
 
 /***************************************************************************
  *    copyright            : (C) 2002 by Frank Mori Hess
@@ -78,48 +78,48 @@ enum {
 };
 
 // interface functions
-int nec7210_read(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *buffer,
+int nec7210_read(struct gpib_board *board, struct nec7210_priv *priv, uint8_t *buffer,
 		 size_t length, int *end, size_t *bytes_read);
-int nec7210_write(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *buffer,
+int nec7210_write(struct gpib_board *board, struct nec7210_priv *priv, uint8_t *buffer,
 		  size_t length, int send_eoi, size_t *bytes_written);
-int nec7210_command(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *buffer,
+int nec7210_command(struct gpib_board *board, struct nec7210_priv *priv, uint8_t *buffer,
 		    size_t length, size_t *bytes_written);
-int nec7210_take_control(gpib_board_t *board, struct nec7210_priv *priv, int syncronous);
-int nec7210_go_to_standby(gpib_board_t *board, struct nec7210_priv *priv);
-void nec7210_request_system_control(gpib_board_t *board,
+int nec7210_take_control(struct gpib_board *board, struct nec7210_priv *priv, int syncronous);
+int nec7210_go_to_standby(struct gpib_board *board, struct nec7210_priv *priv);
+void nec7210_request_system_control(struct gpib_board *board,
 				    struct nec7210_priv *priv, int request_control);
-void nec7210_interface_clear(gpib_board_t *board, struct nec7210_priv *priv, int assert);
-void nec7210_remote_enable(gpib_board_t *board, struct nec7210_priv *priv, int enable);
-int nec7210_enable_eos(gpib_board_t *board, struct nec7210_priv *priv, uint8_t eos_bytes,
+void nec7210_interface_clear(struct gpib_board *board, struct nec7210_priv *priv, int assert);
+void nec7210_remote_enable(struct gpib_board *board, struct nec7210_priv *priv, int enable);
+int nec7210_enable_eos(struct gpib_board *board, struct nec7210_priv *priv, uint8_t eos_bytes,
 		       int compare_8_bits);
-void nec7210_disable_eos(gpib_board_t *board, struct nec7210_priv *priv);
-unsigned int nec7210_update_status(gpib_board_t *board, struct nec7210_priv *priv,
+void nec7210_disable_eos(struct gpib_board *board, struct nec7210_priv *priv);
+unsigned int nec7210_update_status(struct gpib_board *board, struct nec7210_priv *priv,
 				   unsigned int clear_mask);
-unsigned int nec7210_update_status_nolock(gpib_board_t *board, struct nec7210_priv *priv);
-int nec7210_primary_address(const gpib_board_t *board,
+unsigned int nec7210_update_status_nolock(struct gpib_board *board, struct nec7210_priv *priv);
+int nec7210_primary_address(const struct gpib_board *board,
 			    struct nec7210_priv *priv, unsigned int address);
-int nec7210_secondary_address(const gpib_board_t *board, struct nec7210_priv *priv,
+int nec7210_secondary_address(const struct gpib_board *board, struct nec7210_priv *priv,
 			      unsigned int address, int enable);
-int nec7210_parallel_poll(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *result);
-void nec7210_serial_poll_response(gpib_board_t *board, struct nec7210_priv *priv, uint8_t status);
-void nec7210_parallel_poll_configure(gpib_board_t *board,
+int nec7210_parallel_poll(struct gpib_board *board, struct nec7210_priv *priv, uint8_t *result);
+void nec7210_serial_poll_response(struct gpib_board *board, struct nec7210_priv *priv, uint8_t status);
+void nec7210_parallel_poll_configure(struct gpib_board *board,
 				     struct nec7210_priv *priv, unsigned int configuration);
-void nec7210_parallel_poll_response(gpib_board_t *board,
+void nec7210_parallel_poll_response(struct gpib_board *board,
 				    struct nec7210_priv *priv, int ist);
-uint8_t nec7210_serial_poll_status(gpib_board_t *board,
+uint8_t nec7210_serial_poll_status(struct gpib_board *board,
 				   struct nec7210_priv *priv);
-unsigned int nec7210_t1_delay(gpib_board_t *board,
+unsigned int nec7210_t1_delay(struct gpib_board *board,
 			      struct nec7210_priv *priv, unsigned int nano_sec);
-void nec7210_return_to_local(const gpib_board_t *board, struct nec7210_priv *priv);
+void nec7210_return_to_local(const struct gpib_board *board, struct nec7210_priv *priv);
 
 // utility functions
-void nec7210_board_reset(struct nec7210_priv *priv, const gpib_board_t *board);
-void nec7210_board_online(struct nec7210_priv *priv, const gpib_board_t *board);
+void nec7210_board_reset(struct nec7210_priv *priv, const struct gpib_board *board);
+void nec7210_board_online(struct nec7210_priv *priv, const struct gpib_board *board);
 unsigned int nec7210_set_reg_bits(struct nec7210_priv *priv, unsigned int reg,
 				  unsigned int mask, unsigned int bits);
-void nec7210_set_handshake_mode(gpib_board_t *board, struct nec7210_priv *priv, int mode);
-void nec7210_release_rfd_holdoff(gpib_board_t *board, struct nec7210_priv *priv);
-uint8_t nec7210_read_data_in(gpib_board_t *board, struct nec7210_priv *priv, int *end);
+void nec7210_set_handshake_mode(struct gpib_board *board, struct nec7210_priv *priv, int mode);
+void nec7210_release_rfd_holdoff(struct gpib_board *board, struct nec7210_priv *priv);
+uint8_t nec7210_read_data_in(struct gpib_board *board, struct nec7210_priv *priv, int *end);
 
 // wrappers for io functions
 uint8_t nec7210_ioport_read_byte(struct nec7210_priv *priv, unsigned int register_num);
@@ -134,8 +134,8 @@ void nec7210_locking_iomem_write_byte(struct nec7210_priv *priv, uint8_t data,
 				      unsigned int register_num);
 
 // interrupt service routine
-irqreturn_t nec7210_interrupt(gpib_board_t *board, struct nec7210_priv *priv);
-irqreturn_t nec7210_interrupt_have_status(gpib_board_t *board,
+irqreturn_t nec7210_interrupt(struct gpib_board *board, struct nec7210_priv *priv);
+irqreturn_t nec7210_interrupt_have_status(struct gpib_board *board,
 					  struct nec7210_priv *priv, int status1, int status2);
 
 #endif	//_NEC7210_H
diff --git a/drivers/staging/gpib/nec7210/nec7210.c b/drivers/staging/gpib/nec7210/nec7210.c
index 85f1e79d658a..773495cde9d8 100644
--- a/drivers/staging/gpib/nec7210/nec7210.c
+++ b/drivers/staging/gpib/nec7210/nec7210.c
@@ -23,7 +23,7 @@
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("GPIB library code for NEC uPD7210");
 
-int nec7210_enable_eos(gpib_board_t *board, struct nec7210_priv *priv, uint8_t eos_byte,
+int nec7210_enable_eos(struct gpib_board *board, struct nec7210_priv *priv, uint8_t eos_byte,
 		       int compare_8_bits)
 {
 	write_byte(priv, eos_byte, EOSR);
@@ -37,14 +37,14 @@ int nec7210_enable_eos(gpib_board_t *board, struct nec7210_priv *priv, uint8_t e
 }
 EXPORT_SYMBOL(nec7210_enable_eos);
 
-void nec7210_disable_eos(gpib_board_t *board, struct nec7210_priv *priv)
+void nec7210_disable_eos(struct gpib_board *board, struct nec7210_priv *priv)
 {
 	priv->auxa_bits &= ~HR_REOS;
 	write_byte(priv, priv->auxa_bits, AUXMR);
 }
 EXPORT_SYMBOL(nec7210_disable_eos);
 
-int nec7210_parallel_poll(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *result)
+int nec7210_parallel_poll(struct gpib_board *board, struct nec7210_priv *priv, uint8_t *result)
 {
 	int ret;
 
@@ -64,14 +64,14 @@ int nec7210_parallel_poll(gpib_board_t *board, struct nec7210_priv *priv, uint8_
 }
 EXPORT_SYMBOL(nec7210_parallel_poll);
 
-void nec7210_parallel_poll_configure(gpib_board_t *board,
+void nec7210_parallel_poll_configure(struct gpib_board *board,
 				     struct nec7210_priv *priv, unsigned int configuration)
 {
 	write_byte(priv, PPR | configuration, AUXMR);
 }
 EXPORT_SYMBOL(nec7210_parallel_poll_configure);
 
-void nec7210_parallel_poll_response(gpib_board_t *board, struct nec7210_priv *priv, int ist)
+void nec7210_parallel_poll_response(struct gpib_board *board, struct nec7210_priv *priv, int ist)
 {
 	if (ist)
 		write_byte(priv, AUX_SPPF, AUXMR);
@@ -85,7 +85,8 @@ EXPORT_SYMBOL(nec7210_parallel_poll_response);
  * the 488.2 capability (for example with NI chips), or we need to implement the
  * 488.2 set srv state machine in the driver (if that is even viable).
  */
-void nec7210_serial_poll_response(gpib_board_t *board, struct nec7210_priv *priv, uint8_t status)
+void nec7210_serial_poll_response(struct gpib_board *board,
+				  struct nec7210_priv *priv, uint8_t status)
 {
 	unsigned long flags;
 
@@ -102,13 +103,13 @@ void nec7210_serial_poll_response(gpib_board_t *board, struct nec7210_priv *priv
 }
 EXPORT_SYMBOL(nec7210_serial_poll_response);
 
-uint8_t nec7210_serial_poll_status(gpib_board_t *board, struct nec7210_priv *priv)
+uint8_t nec7210_serial_poll_status(struct gpib_board *board, struct nec7210_priv *priv)
 {
 	return read_byte(priv, SPSR);
 }
 EXPORT_SYMBOL(nec7210_serial_poll_status);
 
-int nec7210_primary_address(const gpib_board_t *board, struct nec7210_priv *priv,
+int nec7210_primary_address(const struct gpib_board *board, struct nec7210_priv *priv,
 			    unsigned int address)
 {
 	// put primary address in address0
@@ -117,7 +118,7 @@ int nec7210_primary_address(const gpib_board_t *board, struct nec7210_priv *priv
 }
 EXPORT_SYMBOL(nec7210_primary_address);
 
-int nec7210_secondary_address(const gpib_board_t *board, struct nec7210_priv *priv,
+int nec7210_secondary_address(const struct gpib_board *board, struct nec7210_priv *priv,
 			      unsigned int address, int enable)
 {
 	if (enable) {
@@ -166,7 +167,7 @@ static void update_listener_state(struct nec7210_priv *priv, unsigned int addres
 	}
 }
 
-unsigned int nec7210_update_status_nolock(gpib_board_t *board, struct nec7210_priv *priv)
+unsigned int nec7210_update_status_nolock(struct gpib_board *board, struct nec7210_priv *priv)
 {
 	int address_status_bits;
 	u8 spoll_status;
@@ -209,7 +210,7 @@ unsigned int nec7210_update_status_nolock(gpib_board_t *board, struct nec7210_pr
 }
 EXPORT_SYMBOL(nec7210_update_status_nolock);
 
-unsigned int nec7210_update_status(gpib_board_t *board, struct nec7210_priv *priv,
+unsigned int nec7210_update_status(struct gpib_board *board, struct nec7210_priv *priv,
 				   unsigned int clear_mask)
 {
 	unsigned long flags;
@@ -234,7 +235,7 @@ unsigned int nec7210_set_reg_bits(struct nec7210_priv *priv, unsigned int reg,
 }
 EXPORT_SYMBOL(nec7210_set_reg_bits);
 
-void nec7210_set_handshake_mode(gpib_board_t *board, struct nec7210_priv *priv, int mode)
+void nec7210_set_handshake_mode(struct gpib_board *board, struct nec7210_priv *priv, int mode)
 {
 	unsigned long flags;
 
@@ -250,7 +251,7 @@ void nec7210_set_handshake_mode(gpib_board_t *board, struct nec7210_priv *priv,
 }
 EXPORT_SYMBOL(nec7210_set_handshake_mode);
 
-uint8_t nec7210_read_data_in(gpib_board_t *board, struct nec7210_priv *priv, int *end)
+uint8_t nec7210_read_data_in(struct gpib_board *board, struct nec7210_priv *priv, int *end)
 {
 	unsigned long flags;
 	u8 data;
@@ -268,7 +269,7 @@ uint8_t nec7210_read_data_in(gpib_board_t *board, struct nec7210_priv *priv, int
 }
 EXPORT_SYMBOL(nec7210_read_data_in);
 
-int nec7210_take_control(gpib_board_t *board, struct nec7210_priv *priv, int syncronous)
+int nec7210_take_control(struct gpib_board *board, struct nec7210_priv *priv, int syncronous)
 {
 	int i;
 	const int timeout = 100;
@@ -295,7 +296,7 @@ int nec7210_take_control(gpib_board_t *board, struct nec7210_priv *priv, int syn
 }
 EXPORT_SYMBOL(nec7210_take_control);
 
-int nec7210_go_to_standby(gpib_board_t *board, struct nec7210_priv *priv)
+int nec7210_go_to_standby(struct gpib_board *board, struct nec7210_priv *priv)
 {
 	int i;
 	const int timeout = 1000;
@@ -329,7 +330,7 @@ int nec7210_go_to_standby(gpib_board_t *board, struct nec7210_priv *priv)
 }
 EXPORT_SYMBOL(nec7210_go_to_standby);
 
-void nec7210_request_system_control(gpib_board_t *board, struct nec7210_priv *priv,
+void nec7210_request_system_control(struct gpib_board *board, struct nec7210_priv *priv,
 				    int request_control)
 {
 	if (request_control == 0) {
@@ -340,7 +341,7 @@ void nec7210_request_system_control(gpib_board_t *board, struct nec7210_priv *pr
 }
 EXPORT_SYMBOL(nec7210_request_system_control);
 
-void nec7210_interface_clear(gpib_board_t *board, struct nec7210_priv *priv, int assert)
+void nec7210_interface_clear(struct gpib_board *board, struct nec7210_priv *priv, int assert)
 {
 	if (assert)
 		write_byte(priv, AUX_SIFC, AUXMR);
@@ -349,7 +350,7 @@ void nec7210_interface_clear(gpib_board_t *board, struct nec7210_priv *priv, int
 }
 EXPORT_SYMBOL(nec7210_interface_clear);
 
-void nec7210_remote_enable(gpib_board_t *board, struct nec7210_priv *priv, int enable)
+void nec7210_remote_enable(struct gpib_board *board, struct nec7210_priv *priv, int enable)
 {
 	if (enable)
 		write_byte(priv, AUX_SREN, AUXMR);
@@ -358,7 +359,7 @@ void nec7210_remote_enable(gpib_board_t *board, struct nec7210_priv *priv, int e
 }
 EXPORT_SYMBOL(nec7210_remote_enable);
 
-void nec7210_release_rfd_holdoff(gpib_board_t *board, struct nec7210_priv *priv)
+void nec7210_release_rfd_holdoff(struct gpib_board *board, struct nec7210_priv *priv)
 {
 	unsigned long flags;
 
@@ -372,7 +373,7 @@ void nec7210_release_rfd_holdoff(gpib_board_t *board, struct nec7210_priv *priv)
 }
 EXPORT_SYMBOL(nec7210_release_rfd_holdoff);
 
-unsigned int nec7210_t1_delay(gpib_board_t *board, struct nec7210_priv *priv,
+unsigned int nec7210_t1_delay(struct gpib_board *board, struct nec7210_priv *priv,
 			      unsigned int nano_sec)
 {
 	unsigned int retval;
@@ -390,13 +391,13 @@ unsigned int nec7210_t1_delay(gpib_board_t *board, struct nec7210_priv *priv,
 }
 EXPORT_SYMBOL(nec7210_t1_delay);
 
-void nec7210_return_to_local(const gpib_board_t *board, struct nec7210_priv *priv)
+void nec7210_return_to_local(const struct gpib_board *board, struct nec7210_priv *priv)
 {
 	write_byte(priv, AUX_RTL, AUXMR);
 }
 EXPORT_SYMBOL(nec7210_return_to_local);
 
-static inline short nec7210_atn_has_changed(gpib_board_t *board, struct nec7210_priv *priv)
+static inline short nec7210_atn_has_changed(struct gpib_board *board, struct nec7210_priv *priv)
 {
 	short address_status_bits = read_byte(priv, ADSR);
 
@@ -414,7 +415,7 @@ static inline short nec7210_atn_has_changed(gpib_board_t *board, struct nec7210_
 	return -1;
 }
 
-int nec7210_command(gpib_board_t *board, struct nec7210_priv *priv, uint8_t
+int nec7210_command(struct gpib_board *board, struct nec7210_priv *priv, uint8_t
 		    *buffer, size_t length, size_t *bytes_written)
 {
 	int retval = 0;
@@ -463,7 +464,7 @@ int nec7210_command(gpib_board_t *board, struct nec7210_priv *priv, uint8_t
 }
 EXPORT_SYMBOL(nec7210_command);
 
-static int pio_read(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *buffer,
+static int pio_read(struct gpib_board *board, struct nec7210_priv *priv, uint8_t *buffer,
 		    size_t length, int *end, size_t *bytes_read)
 {
 	ssize_t retval = 0;
@@ -512,7 +513,7 @@ static int pio_read(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *buf
 }
 
 #ifdef NEC_DMA
-static ssize_t __dma_read(gpib_board_t *board, struct nec7210_priv *priv, size_t length)
+static ssize_t __dma_read(struct gpib_board *board, struct nec7210_priv *priv, size_t length)
 {
 	ssize_t retval = 0;
 	size_t count = 0;
@@ -567,7 +568,7 @@ static ssize_t __dma_read(gpib_board_t *board, struct nec7210_priv *priv, size_t
 	return retval ? retval : count;
 }
 
-static ssize_t dma_read(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *buffer,
+static ssize_t dma_read(struct gpib_board *board, struct nec7210_priv *priv, uint8_t *buffer,
 			size_t length)
 {
 	size_t remain = length;
@@ -594,7 +595,7 @@ static ssize_t dma_read(gpib_board_t *board, struct nec7210_priv *priv, uint8_t
 }
 #endif
 
-int nec7210_read(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *buffer,
+int nec7210_read(struct gpib_board *board, struct nec7210_priv *priv, uint8_t *buffer,
 		 size_t length, int *end, size_t *bytes_read)
 {
 	ssize_t retval = 0;
@@ -615,7 +616,7 @@ int nec7210_read(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *buffer
 }
 EXPORT_SYMBOL(nec7210_read);
 
-static int pio_write_wait(gpib_board_t *board, struct nec7210_priv *priv,
+static int pio_write_wait(struct gpib_board *board, struct nec7210_priv *priv,
 			  short wake_on_lacs, short wake_on_atn, short wake_on_bus_error)
 {
 	// wait until byte is ready to be sent
@@ -641,7 +642,7 @@ static int pio_write_wait(gpib_board_t *board, struct nec7210_priv *priv,
 	return 0;
 }
 
-static int pio_write(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *buffer,
+static int pio_write(struct gpib_board *board, struct nec7210_priv *priv, uint8_t *buffer,
 		     size_t length, size_t *bytes_written)
 {
 	size_t last_count = 0;
@@ -684,7 +685,7 @@ static int pio_write(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *bu
 }
 
 #ifdef NEC_DMA
-static ssize_t __dma_write(gpib_board_t *board, struct nec7210_priv *priv, dma_addr_t address,
+static ssize_t __dma_write(struct gpib_board *board, struct nec7210_priv *priv, dma_addr_t address,
 			   size_t length)
 {
 	unsigned long flags, dma_irq_flags;
@@ -741,7 +742,7 @@ static ssize_t __dma_write(gpib_board_t *board, struct nec7210_priv *priv, dma_a
 	return retval ? retval : length;
 }
 
-static ssize_t dma_write(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *buffer,
+static ssize_t dma_write(struct gpib_board *board, struct nec7210_priv *priv, uint8_t *buffer,
 			 size_t length)
 {
 	size_t remain = length;
@@ -765,8 +766,9 @@ static ssize_t dma_write(gpib_board_t *board, struct nec7210_priv *priv, uint8_t
 	return length - remain;
 }
 #endif
-int nec7210_write(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *buffer, size_t length,
-		  int send_eoi, size_t *bytes_written)
+int nec7210_write(struct gpib_board *board, struct nec7210_priv *priv,
+		  uint8_t *buffer, size_t length, int send_eoi,
+		  size_t *bytes_written)
 {
 	int retval = 0;
 
@@ -827,7 +829,7 @@ EXPORT_SYMBOL(nec7210_write);
 /*
  *  interrupt service routine
  */
-irqreturn_t nec7210_interrupt(gpib_board_t *board, struct nec7210_priv *priv)
+irqreturn_t nec7210_interrupt(struct gpib_board *board, struct nec7210_priv *priv)
 {
 	int status1, status2;
 
@@ -839,7 +841,7 @@ irqreturn_t nec7210_interrupt(gpib_board_t *board, struct nec7210_priv *priv)
 }
 EXPORT_SYMBOL(nec7210_interrupt);
 
-irqreturn_t nec7210_interrupt_have_status(gpib_board_t *board,
+irqreturn_t nec7210_interrupt_have_status(struct gpib_board *board,
 					  struct nec7210_priv *priv, int status1, int status2)
 {
 #ifdef NEC_DMA
@@ -957,7 +959,7 @@ irqreturn_t nec7210_interrupt_have_status(gpib_board_t *board,
 }
 EXPORT_SYMBOL(nec7210_interrupt_have_status);
 
-void nec7210_board_reset(struct nec7210_priv *priv, const gpib_board_t *board)
+void nec7210_board_reset(struct nec7210_priv *priv, const struct gpib_board *board)
 {
 	/* 7210 chip reset */
 	write_byte(priv, AUX_CR, AUXMR);
@@ -991,7 +993,7 @@ void nec7210_board_reset(struct nec7210_priv *priv, const gpib_board_t *board)
 }
 EXPORT_SYMBOL(nec7210_board_reset);
 
-void nec7210_board_online(struct nec7210_priv *priv, const gpib_board_t *board)
+void nec7210_board_online(struct nec7210_priv *priv, const struct gpib_board *board)
 {
 	/* set GPIB address */
 	nec7210_primary_address(board, priv, board->pad);
-- 
2.43.0


