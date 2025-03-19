Return-Path: <linux-kernel+bounces-568893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1ABA69BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF03482D77
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45763224898;
	Wed, 19 Mar 2025 22:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="nB3hqVUo"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F23F223327
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421604; cv=none; b=Azh/HzPBZ1YQkCKgGiQiJHLbYTKXeGN3Q94ghzZw+/oP1umwXJnwVbnt29jHjLVyPO77zq0CdbrLeLDmEWczYWS5uqQPpLdkg+eaqQgl7v1E2GU/WzU5kHdsq/LxbMyZ/1utmisaY1NMkhy98sxmQwBNix3pR3LwhqtbNiGeY8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421604; c=relaxed/simple;
	bh=PJo7XY5iWYWccY43koXbM0vrT5sgu9no9HG2zsYlarQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjedtHQEWAYKZfT4lvsSkvGO41GA7m9LrFxDfnehF6G++haAIYSDcDYTW3BYllEUdIekjIFfXaFpmQWcivB2EbzSpX0UKCaZw0SX7YnA4C/iNWu+P7S/6b1+lKdoPH1qxHH9aGuZR+Lge0YlAkyvcPmKSWnqRGrqJNP6svhVSoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=nB3hqVUo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2254e0b4b79so1152025ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421601; x=1743026401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0yppVfKOM5irPIoqhzoyPGWYGuyd2GLb5kDS1Y/XIs=;
        b=nB3hqVUoK5Ta4rlozmcV1gE60vLJcLz6+bHHPzOthDEKm2a9hgx2eyF1fwgebz84FZ
         4YZf8SgJN+vXGf3iUXd0Uvp5C/vuTes+YX4wvSzQX0yMO45cwyUmr+oy1txubA+CVZGB
         78NA27W/vv2nHSXomgyCPHjkttwIE5NFGCJANPLW+RPxdEy2CDL7ciPdmKDvkXyayB3S
         TFKCf+YuVifrsrn4jjiMfrgGBOw3rmA4gywpA5DAgNhLPQgcJmqd7eE/ZFZM7gzoO9lN
         BxExGrumpL6g8Yy/QSCfXxPyJzXYrYnOr3fHMCfg9Z8tgoKJX2FZ2gM9QFLrNdjJNSrg
         SDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421601; x=1743026401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0yppVfKOM5irPIoqhzoyPGWYGuyd2GLb5kDS1Y/XIs=;
        b=uVkWRXIGelK4jEMgkl4xBUmd6MsWnG261xmufSnbJlGz7jsYeQAn6DzOkMaWmJPbPD
         Fl50mU0uUL5HLNpbdGpglMZQsW4TPDLaVX5sqlgfqFt/lFJGf9wpSA7QRQ9WyRWwc0pQ
         RAsizqx8SeoaNhK1/Pr2S86+e4HKy2nlthmgXM0RsFCdcurfTghMB1FjZ/XQ1A1UwB7j
         2Cw6fWpQzYRaDjxy1lWVQchWkLIGalbRt7TK3uQtfu2q27E6qEcXWELypufI5tnWnIWQ
         F2CTl4ETK709vivhoGuuuqsZvtHKTDY4fLHbIWyGgcsgTpjBokf8jWZkcRmYyJBrtXwT
         xSdA==
X-Forwarded-Encrypted: i=1; AJvYcCX+N2Q4sG0ApgoXt0xcf8OcM72/ksfzlbnoRcNaGN5vwFazFmBZmBWUcoG7aPNY+sTev9Au01o7rRDAdWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9hhxIlrRj2rM4DJUHbHb45dbp/eUle6iMkEmKsrCfahmaEcd
	Swjmo08QvtSFwMI3xu3BP68FMmrsYyMJ6SAsvsVPPSOUSDNOHnO1ae8xiI+jNw==
X-Gm-Gg: ASbGncv6rKpCI8o0lBaVcINW5NjFiBh92BjRF9HKAWnbhW+WveRyZ4y+tvRrN7G0SZM
	UUr+9HfNvNTzYIHPo2EUbQPuyTj3XLRECC4LfRrZ2PGNNbhMjuw4kyw8hCW0Z0S5s5rcFLrGSqh
	aDrZb1fXjn/gEkVTwHKlBVZccXEcUsw93PhoKe2GwE+GK7AUULSTdxdIY8IlNQ5c7FAtpAs1+wj
	WhtiktTdN/p7mRoZLfsiCi/cSboZK9Lu0ZzyUw0h/sL4T8m/m7/KV77YgLYCfYpuVfrfTtjCX/Z
	1BivWCJjv+ToVt0kP3M1ydTtsatsZeFXoeSHgBE9JGnc8VH+s1tVOL/M+TdBj+OoTM0ddUPmliq
	NgINfP0YEAQ==
X-Google-Smtp-Source: AGHT+IETgC4crhGhY4O0UlC3TJK9wdI3LrJMMAG9f0yUukPhBWl8iL3gcJ4ZMxwxX3tof2UiABtogg==
X-Received: by 2002:a05:6a20:72a3:b0:1f5:6e00:14c9 with SMTP id adf61e73a8af0-1fd11800cb6mr1319219637.15.1742421600650;
        Wed, 19 Mar 2025 15:00:00 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af586a37490sm9642899a12.43.2025.03.19.15.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:00:00 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 19/20] staging: gpib: struct typing for gpib_gboard_t
Date: Wed, 19 Mar 2025 21:59:23 +0000
Message-ID: <20250319215924.19387-20-matchstick@neverthere.org>
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

Using Linux code style for gpib_board struct.

Adhering to Linux code style.

In general, a pointer, or a struct that has elements that can reasonably be
directly accessed should never be a typedef.

Signed-off-by: Michael Rubin <matchstick@neverthere.org>
---
 drivers/staging/gpib/include/gpibP.h      | 10 ++--
 drivers/staging/gpib/include/gpib_proto.h | 58 +++++++++++------------
 drivers/staging/gpib/include/gpib_types.h | 54 ++++++++++-----------
 3 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/staging/gpib/include/gpibP.h b/drivers/staging/gpib/include/gpibP.h
index d35fdd391f7e..0c71a038e444 100644
--- a/drivers/staging/gpib/include/gpibP.h
+++ b/drivers/staging/gpib/include/gpibP.h
@@ -26,13 +26,13 @@ struct pci_dev *gpib_pci_get_subsys(const gpib_board_config_t *config, unsigned
 				    unsigned int device_id, unsigned int ss_vendor,
 				    unsigned int ss_device, struct pci_dev *from);
 unsigned int num_gpib_events(const gpib_event_queue_t *queue);
-int push_gpib_event(gpib_board_t *board, short event_type);
-int pop_gpib_event(gpib_board_t *board, gpib_event_queue_t *queue, short *event_type);
-int gpib_request_pseudo_irq(gpib_board_t *board, irqreturn_t (*handler)(int, void *));
-void gpib_free_pseudo_irq(gpib_board_t *board);
+int push_gpib_event(struct gpib_board *board, short event_type);
+int pop_gpib_event(struct gpib_board *board, gpib_event_queue_t *queue, short *event_type);
+int gpib_request_pseudo_irq(struct gpib_board *board, irqreturn_t (*handler)(int, void *));
+void gpib_free_pseudo_irq(struct gpib_board *board);
 int gpib_match_device_path(struct device *dev, const char *device_path_in);
 
-extern gpib_board_t board_array[GPIB_MAX_NUM_BOARDS];
+extern struct gpib_board board_array[GPIB_MAX_NUM_BOARDS];
 
 extern struct list_head registered_drivers;
 
diff --git a/drivers/staging/gpib/include/gpib_proto.h b/drivers/staging/gpib/include/gpib_proto.h
index 1499f954210b..2c7dfc02f517 100644
--- a/drivers/staging/gpib/include/gpib_proto.h
+++ b/drivers/staging/gpib/include/gpib_proto.h
@@ -10,11 +10,11 @@ int ibclose(struct inode *inode, struct file *file);
 long ibioctl(struct file *filep, unsigned int cmd, unsigned long arg);
 int osInit(void);
 void osReset(void);
-void os_start_timer(gpib_board_t *board, unsigned int usec_timeout);
-void os_remove_timer(gpib_board_t *board);
+void os_start_timer(struct gpib_board *board, unsigned int usec_timeout);
+void os_remove_timer(struct gpib_board *board);
 void osSendEOI(void);
 void osSendEOI(void);
-void init_gpib_board(gpib_board_t *board);
+void init_gpib_board(struct gpib_board *board);
 static inline unsigned long usec_to_jiffies(unsigned int usec)
 {
 	unsigned long usec_per_jiffy = 1000000 / HZ;
@@ -22,35 +22,35 @@ static inline unsigned long usec_to_jiffies(unsigned int usec)
 	return 1 + (usec + usec_per_jiffy - 1) / usec_per_jiffy;
 };
 
-int serial_poll_all(gpib_board_t *board, unsigned int usec_timeout);
+int serial_poll_all(struct gpib_board *board, unsigned int usec_timeout);
 void init_gpib_descriptor(gpib_descriptor_t *desc);
-int dvrsp(gpib_board_t *board, unsigned int pad, int sad,
+int dvrsp(struct gpib_board *board, unsigned int pad, int sad,
 	  unsigned int usec_timeout, uint8_t *result);
-int ibAPWait(gpib_board_t *board, int pad);
-int ibAPrsp(gpib_board_t *board, int padsad, char *spb);
-void ibAPE(gpib_board_t *board, int pad, int v);
-int ibcac(gpib_board_t *board, int sync, int fallback_to_async);
-int ibcmd(gpib_board_t *board, uint8_t *buf, size_t length, size_t *bytes_written);
-int ibgts(gpib_board_t *board);
-int ibonline(gpib_board_t *board);
-int iboffline(gpib_board_t *board);
-int iblines(const gpib_board_t *board, short *lines);
-int ibrd(gpib_board_t *board, uint8_t *buf, size_t length, int *end_flag, size_t *bytes_read);
-int ibrpp(gpib_board_t *board, uint8_t *buf);
-int ibrsv2(gpib_board_t *board, uint8_t status_byte, int new_reason_for_service);
-void ibrsc(gpib_board_t *board, int request_control);
-int ibsic(gpib_board_t *board, unsigned int usec_duration);
-int ibsre(gpib_board_t *board, int enable);
-int ibpad(gpib_board_t *board, unsigned int addr);
-int ibsad(gpib_board_t *board, int addr);
-int ibeos(gpib_board_t *board, int eos, int eosflags);
-int ibwait(gpib_board_t *board, int wait_mask, int clear_mask, int set_mask,
+int ibAPWait(struct gpib_board *board, int pad);
+int ibAPrsp(struct gpib_board *board, int padsad, char *spb);
+void ibAPE(struct gpib_board *board, int pad, int v);
+int ibcac(struct gpib_board *board, int sync, int fallback_to_async);
+int ibcmd(struct gpib_board *board, uint8_t *buf, size_t length, size_t *bytes_written);
+int ibgts(struct gpib_board *board);
+int ibonline(struct gpib_board *board);
+int iboffline(struct gpib_board *board);
+int iblines(const struct gpib_board *board, short *lines);
+int ibrd(struct gpib_board *board, uint8_t *buf, size_t length, int *end_flag, size_t *bytes_read);
+int ibrpp(struct gpib_board *board, uint8_t *buf);
+int ibrsv2(struct gpib_board *board, uint8_t status_byte, int new_reason_for_service);
+void ibrsc(struct gpib_board *board, int request_control);
+int ibsic(struct gpib_board *board, unsigned int usec_duration);
+int ibsre(struct gpib_board *board, int enable);
+int ibpad(struct gpib_board *board, unsigned int addr);
+int ibsad(struct gpib_board *board, int addr);
+int ibeos(struct gpib_board *board, int eos, int eosflags);
+int ibwait(struct gpib_board *board, int wait_mask, int clear_mask, int set_mask,
 	   int *status, unsigned long usec_timeout, gpib_descriptor_t *desc);
-int ibwrt(gpib_board_t *board, uint8_t *buf, size_t cnt, int send_eoi, size_t *bytes_written);
-int ibstatus(gpib_board_t *board);
-int general_ibstatus(gpib_board_t *board, const gpib_status_queue_t *device,
+int ibwrt(struct gpib_board *board, uint8_t *buf, size_t cnt, int send_eoi, size_t *bytes_written);
+int ibstatus(struct gpib_board *board);
+int general_ibstatus(struct gpib_board *board, const gpib_status_queue_t *device,
 		     int clear_mask, int set_mask, gpib_descriptor_t *desc);
-int io_timed_out(gpib_board_t *board);
-int ibppc(gpib_board_t *board, uint8_t configuration);
+int io_timed_out(struct gpib_board *board);
+int ibppc(struct gpib_board *board, uint8_t configuration);
 
 #endif /* GPIB_PROTO_INCLUDED */
diff --git a/drivers/staging/gpib/include/gpib_types.h b/drivers/staging/gpib/include/gpib_types.h
index 7dc5a16e427b..515fdb91d150 100644
--- a/drivers/staging/gpib/include/gpib_types.h
+++ b/drivers/staging/gpib/include/gpib_types.h
@@ -55,9 +55,9 @@ struct gpib_interface_struct {
 	/* name of board */
 	char *name;
 	/* attach() initializes board and allocates resources */
-	int (*attach)(gpib_board_t *board, const gpib_board_config_t *config);
+	int (*attach)(struct gpib_board *board, const gpib_board_config_t *config);
 	/* detach() shuts down board and frees resources */
-	void (*detach)(gpib_board_t *board);
+	void (*detach)(struct gpib_board *board);
 	/* read() should read at most 'length' bytes from the bus into
 	 * 'buffer'.  It should return when it fills the buffer or
 	 * encounters an END (EOI and or EOS if appropriate).  It should set 'end'
@@ -68,19 +68,19 @@ struct gpib_interface_struct {
 	 * return indicates error.
 	 * nbytes returns number of bytes read
 	 */
-	int (*read)(gpib_board_t *board, uint8_t *buffer, size_t length, int *end,
+	int (*read)(struct gpib_board *board, uint8_t *buffer, size_t length, int *end,
 		    size_t *bytes_read);
 	/* write() should write 'length' bytes from buffer to the bus.
 	 * If the boolean value send_eoi is nonzero, then EOI should
 	 * be sent along with the last byte.  Returns number of bytes
 	 * written or negative value on error.
 	 */
-	int (*write)(gpib_board_t *board, uint8_t *buffer, size_t length, int send_eoi,
+	int (*write)(struct gpib_board *board, uint8_t *buffer, size_t length, int send_eoi,
 		     size_t *bytes_written);
 	/* command() writes the command bytes in 'buffer' to the bus
 	 * Returns zero on success or negative value on error.
 	 */
-	int (*command)(gpib_board_t *board, uint8_t *buffer, size_t length,
+	int (*command)(struct gpib_board *board, uint8_t *buffer, size_t length,
 		       size_t *bytes_written);
 	/* Take control (assert ATN).  If 'asyncronous' is nonzero, take
 	 * control asyncronously (assert ATN immediately without waiting
@@ -88,54 +88,54 @@ struct gpib_interface_struct {
 	 * until board becomes controller in charge.  Returns zero no success,
 	 * nonzero on error.
 	 */
-	int (*take_control)(gpib_board_t *board, int asyncronous);
+	int (*take_control)(struct gpib_board *board, int asyncronous);
 	/* De-assert ATN.  Returns zero on success, nonzer on error.
 	 */
-	int (*go_to_standby)(gpib_board_t *board);
+	int (*go_to_standby)(struct gpib_board *board);
 	/* request/release control of the IFC and REN lines (system controller) */
-	void (*request_system_control)(gpib_board_t *board, int request_control);
+	void (*request_system_control)(struct gpib_board *board, int request_control);
 	/* Asserts or de-asserts 'interface clear' (IFC) depending on
 	 * boolean value of 'assert'
 	 */
-	void (*interface_clear)(gpib_board_t *board, int assert);
+	void (*interface_clear)(struct gpib_board *board, int assert);
 	/* Sends remote enable command if 'enable' is nonzero, disables remote mode
 	 * if 'enable' is zero
 	 */
-	void (*remote_enable)(gpib_board_t *board, int enable);
+	void (*remote_enable)(struct gpib_board *board, int enable);
 	/* enable END for reads, when byte 'eos' is received.  If
 	 * 'compare_8_bits' is nonzero, then all 8 bits are compared
 	 * with the eos bytes.	Otherwise only the 7 least significant
 	 * bits are compared.
 	 */
-	int (*enable_eos)(gpib_board_t *board, uint8_t eos, int compare_8_bits);
+	int (*enable_eos)(struct gpib_board *board, uint8_t eos, int compare_8_bits);
 	/* disable END on eos byte (END on EOI only)*/
-	void (*disable_eos)(gpib_board_t *board);
+	void (*disable_eos)(struct gpib_board *board);
 	/* configure parallel poll */
-	void (*parallel_poll_configure)(gpib_board_t *board, uint8_t configuration);
+	void (*parallel_poll_configure)(struct gpib_board *board, uint8_t configuration);
 	/* conduct parallel poll */
-	int (*parallel_poll)(gpib_board_t *board, uint8_t *result);
+	int (*parallel_poll)(struct gpib_board *board, uint8_t *result);
 	/* set/clear ist (individual status bit) */
-	void (*parallel_poll_response)(gpib_board_t *board, int ist);
+	void (*parallel_poll_response)(struct gpib_board *board, int ist);
 	/* select local parallel poll configuration mode PP2 versus remote PP1 */
-	void (*local_parallel_poll_mode)(gpib_board_t *board, int local);
+	void (*local_parallel_poll_mode)(struct gpib_board *board, int local);
 	/* Returns current status of the bus lines.  Should be set to
 	 * NULL if your board does not have the ability to query the
 	 * state of the bus lines.
 	 */
-	int (*line_status)(const gpib_board_t *board);
+	int (*line_status)(const struct gpib_board *board);
 	/* updates and returns the board's current status.
 	 * The meaning of the bits are specified in gpib_user.h
 	 * in the IBSTA section.  The driver does not need to
 	 * worry about setting the CMPL, END, TIMO, or ERR bits.
 	 */
-	unsigned int (*update_status)(gpib_board_t *board, unsigned int clear_mask);
+	unsigned int (*update_status)(struct gpib_board *board, unsigned int clear_mask);
 	/* Sets primary address 0-30 for gpib interface card.
 	 */
-	int (*primary_address)(gpib_board_t *board, unsigned int address);
+	int (*primary_address)(struct gpib_board *board, unsigned int address);
 	/* Sets and enables, or disables secondary address 0-30
 	 * for gpib interface card.
 	 */
-	int (*secondary_address)(gpib_board_t *board, unsigned int address,
+	int (*secondary_address)(struct gpib_board *board, unsigned int address,
 				 int enable);
 	/* Sets the byte the board should send in response to a serial poll.
 	 * This function should also start or stop requests for service via
@@ -149,7 +149,7 @@ struct gpib_interface_struct {
 	 * by IEEE 488.2 section 11.3.3.4.3 "Allowed Coupled Control of
 	 * STB, reqt, and reqf".
 	 */
-	void (*serial_poll_response)(gpib_board_t *board, uint8_t status_byte);
+	void (*serial_poll_response)(struct gpib_board *board, uint8_t status_byte);
 	/* Sets the byte the board should send in response to a serial poll.
 	 * This function should also request service via IEEE 488.2 reqt/reqf
 	 * based on MSS (bit 6 of the status_byte) and new_reason_for_service.
@@ -164,15 +164,15 @@ struct gpib_interface_struct {
 	 * If this method is left NULL by the driver, then the user library
 	 * function ibrsv2 will not work.
 	 */
-	void (*serial_poll_response2)(gpib_board_t *board, uint8_t status_byte,
+	void (*serial_poll_response2)(struct gpib_board *board, uint8_t status_byte,
 				      int new_reason_for_service);
 	/* returns the byte the board will send in response to a serial poll.
 	 */
-	uint8_t (*serial_poll_status)(gpib_board_t *board);
+	uint8_t (*serial_poll_status)(struct gpib_board *board);
 	/* adjust T1 delay */
-	unsigned int (*t1_delay)(gpib_board_t *board, unsigned int nano_sec);
+	unsigned int (*t1_delay)(struct gpib_board *board, unsigned int nano_sec);
 	/* go to local mode */
-	void (*return_to_local)(gpib_board_t *board);
+	void (*return_to_local)(struct gpib_board *board);
 	/* board does not support 7 bit eos comparisons */
 	unsigned no_7_bit_eos : 1;
 	/* skip check for listeners before trying to send command bytes */
@@ -198,7 +198,7 @@ static inline void init_event_queue(gpib_event_queue_t *queue)
 struct gpib_pseudo_irq {
 	struct timer_list timer;
 	irqreturn_t (*handler)(int irq, void *arg);
-	gpib_board_t *board;
+	struct gpib_board *board;
 	atomic_t active;
 };
 
@@ -216,7 +216,7 @@ typedef struct gpib_interface_list_struct {
 	struct module *module;
 } gpib_interface_list_t;
 
-/* One gpib_board_t is allocated for each physical board in the computer.
+/* One struct gpib_board is allocated for each physical board in the computer.
  * It provides storage for variables local to each board, and interface
  * functions for performing operations on the board
  */
-- 
2.43.0


