Return-Path: <linux-kernel+bounces-568880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2770BA69BB2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7EF18895B8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269C221CC5B;
	Wed, 19 Mar 2025 21:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="HU8rLMUe"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4142B21C9EA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421588; cv=none; b=mp/lrXPZB+d4k524V52526wDtaErXTuH35aIIKmqjwW2wFoFMTXyTRqgJ4wQWJEMZcKK9kwL4grqyhaSl2pAro96fsoZNLILHNJpTjZ6r6+0KH0rDqrRClRQJnomkMz3ZG7K94WVx+udAH6o2CiObJaLqNATibZHdgXnErXMMwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421588; c=relaxed/simple;
	bh=HRSOYbPGWoo6z/JmzinxHLZ36CdZ23R6tDdcp+KW+YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLyD7P2VF1P/XS4jzhUou8G4GhJ7nKnixqySPN7larp5SILwGbJTEdJq+BIFQqhjaf8BUiqHaIild/VKDN3wpKiKZCeF8yX12ngsDWiwTQ0R9COexK5dNg7Hkqo40NfoFEA74jP3aTjBAaBO5h3W5ym9BwiE/iR79ahA/QsRNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=HU8rLMUe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224171d6826so1069645ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421584; x=1743026384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbfsr64MCoaFkYQZ9IhCGlHZeUo705MTmbhGCEUuF6o=;
        b=HU8rLMUej8NwO3CC6ZRqiIlt1yUSzEAR2K/5dS0nwwvU626S+LPBupaKlHw62X5aRZ
         P9TZJHNtMUEMNJ8Fr4btfvXx55D8uMvCNeqsYoWgXgiqDhNNmRjr4b6uLa2KrTWk87OF
         SyLppGzxGyfhJnYSR3kJ80KZSMpOel3Y8MwrBztByczHIUcSnhwfyoj9VnOPLBWqII01
         6pwX7jCXkcAABmI3OvfwRYHcdC6U3gWcMqxzO66D4m1EnLCYs5kShLaICTxlrZpniIHY
         ahqvvlAz//VXiGMjObsFoaNFTGagOi1etKIAbM7JTTXyIbNkxZ2ssyDmdTGO5svR19Ia
         u4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421584; x=1743026384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbfsr64MCoaFkYQZ9IhCGlHZeUo705MTmbhGCEUuF6o=;
        b=RugiMi+iPpA8cMQZZLpq4aevlmMNUMB81h6GWdeF7DtNn5p6N5dzIPdoEecok7lU84
         1feanBlQaHVotIgLyPl/rYmfhcPzqu7sCvM2EWpvsZmimYmk9SOZGb0dutT7Wk6m8vXj
         GWNGKmod2I9lAQgSOVHR7BibVeG/Q0lvXbpPApGQ6FSlJEv9Wt7ht3KI1ZyPbpmTSgxR
         136gDdhiDLBYo5h/Im+8UYeLgjvaA6vYqlSRX5lcxir4WasQ2Sc4t0FmxZvZj7MkwxKP
         kazHL5uYyBVbKvux64N/VBDL5JO3Gc9nQGew3ghHt4bGMqEcJlmu1ZPKJGT54u2cv1QZ
         dcbw==
X-Forwarded-Encrypted: i=1; AJvYcCXdSRLPefoMN24Yy4xaerFi7MUzqnQONsjZ/JliUqGfDwLwyeO3cclldAQGWZ0xN6Yz9AfoYaxXxZ+9+7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmSo/nxeuBT2FNSu2OFdSJyyOHfsx4GQcIL15FyRL5XpE6akHr
	Mth0bbrT3N77RmIntaoP1LkxrGb8FaBoiij3iJYLEz+bG0+5ONtVQ8wsQVHIdw==
X-Gm-Gg: ASbGncv3HtEusAfjmo1WlZFFYGJkoYScBGkRQIKHZBOtit9+Q3mbf9n5VJfU6LvJFzk
	Q29yn63e6gH+zHqbvSApOK4tCK2cgoUo/QITEyixcMM0UMGGTF6KOgqAAhEK3K3voxFPpjfQlYM
	BNJcpvXZsHu4y/4lfBevIcvBi5lUgi5Ypt+s1xnBobrvpaBu8voMeeq7q2mk7z1UhWfcxEF9anj
	jhYwCYLMztUU4uaoo8brre+zBhJm38pAOPawsi4T5PJ2/7osfyoEb54mRMYbSszPTnPmy4H7NlE
	LtN7td8cimns9jOapXIa8ua4TBmo/pVXfwwYotSuo1F80nSYe5MVNwWZIDjLsw9QR56jDVbU437
	ju2SIXuIUag==
X-Google-Smtp-Source: AGHT+IFKxR9lbtWsl1kDtTJcwDx+/Q6jcgrrOK3hxMnEwWn9VxhW3pEUlNc88vzgJSkYEPgI2Jkauw==
X-Received: by 2002:a05:6a00:a86:b0:736:5545:5b84 with SMTP id d2e1a72fcca58-7376d5ea4ddmr7417056b3a.3.1742421584345;
        Wed, 19 Mar 2025 14:59:44 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167d88fsm12664806b3a.96.2025.03.19.14.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:59:44 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 06/20] staging: gpib: common: struct gpib_board
Date: Wed, 19 Mar 2025 21:59:10 +0000
Message-ID: <20250319215924.19387-7-matchstick@neverthere.org>
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
---
 drivers/staging/gpib/common/gpib_os.c | 196 +++++++++++++-------------
 drivers/staging/gpib/common/iblib.c   |  50 +++----
 drivers/staging/gpib/common/ibsys.h   |  14 +-
 3 files changed, 130 insertions(+), 130 deletions(-)

diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
index 301c8a1a62c2..9bf2076cbbb3 100644
--- a/drivers/staging/gpib/common/gpib_os.c
+++ b/drivers/staging/gpib/common/gpib_os.c
@@ -26,53 +26,53 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("GPIB base support");
 MODULE_ALIAS_CHARDEV_MAJOR(GPIB_CODE);
 
-static int board_type_ioctl(gpib_file_private_t *file_priv, gpib_board_t *board, unsigned long arg);
-static int read_ioctl(gpib_file_private_t *file_priv, gpib_board_t *board,
+static int board_type_ioctl(gpib_file_private_t *file_priv, struct gpib_board *board, unsigned long arg);
+static int read_ioctl(gpib_file_private_t *file_priv, struct gpib_board *board,
 		      unsigned long arg);
-static int write_ioctl(gpib_file_private_t *file_priv, gpib_board_t *board,
+static int write_ioctl(gpib_file_private_t *file_priv, struct gpib_board *board,
 		       unsigned long arg);
-static int command_ioctl(gpib_file_private_t *file_priv, gpib_board_t *board,
+static int command_ioctl(gpib_file_private_t *file_priv, struct gpib_board *board,
 			 unsigned long arg);
-static int open_dev_ioctl(struct file *filep, gpib_board_t *board, unsigned long arg);
-static int close_dev_ioctl(struct file *filep, gpib_board_t *board, unsigned long arg);
-static int serial_poll_ioctl(gpib_board_t *board, unsigned long arg);
-static int wait_ioctl(gpib_file_private_t *file_priv, gpib_board_t *board, unsigned long arg);
-static int parallel_poll_ioctl(gpib_board_t *board, unsigned long arg);
-static int online_ioctl(gpib_board_t *board, unsigned long arg);
-static int remote_enable_ioctl(gpib_board_t *board, unsigned long arg);
-static int take_control_ioctl(gpib_board_t *board, unsigned long arg);
-static int line_status_ioctl(gpib_board_t *board, unsigned long arg);
-static int pad_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
+static int open_dev_ioctl(struct file *filep, struct gpib_board *board, unsigned long arg);
+static int close_dev_ioctl(struct file *filep, struct gpib_board *board, unsigned long arg);
+static int serial_poll_ioctl(struct gpib_board *board, unsigned long arg);
+static int wait_ioctl(gpib_file_private_t *file_priv, struct gpib_board *board, unsigned long arg);
+static int parallel_poll_ioctl(struct gpib_board *board, unsigned long arg);
+static int online_ioctl(struct gpib_board *board, unsigned long arg);
+static int remote_enable_ioctl(struct gpib_board *board, unsigned long arg);
+static int take_control_ioctl(struct gpib_board *board, unsigned long arg);
+static int line_status_ioctl(struct gpib_board *board, unsigned long arg);
+static int pad_ioctl(struct gpib_board *board, gpib_file_private_t *file_priv,
 		     unsigned long arg);
-static int sad_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
+static int sad_ioctl(struct gpib_board *board, gpib_file_private_t *file_priv,
 		     unsigned long arg);
-static int eos_ioctl(gpib_board_t *board, unsigned long arg);
-static int request_service_ioctl(gpib_board_t *board, unsigned long arg);
-static int request_service2_ioctl(gpib_board_t *board, unsigned long arg);
+static int eos_ioctl(struct gpib_board *board, unsigned long arg);
+static int request_service_ioctl(struct gpib_board *board, unsigned long arg);
+static int request_service2_ioctl(struct gpib_board *board, unsigned long arg);
 static int iobase_ioctl(gpib_board_config_t *config, unsigned long arg);
 static int irq_ioctl(gpib_board_config_t *config, unsigned long arg);
 static int dma_ioctl(gpib_board_config_t *config, unsigned long arg);
-static int autospoll_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
+static int autospoll_ioctl(struct gpib_board *board, gpib_file_private_t *file_priv,
 			   unsigned long arg);
-static int mutex_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
+static int mutex_ioctl(struct gpib_board *board, gpib_file_private_t *file_priv,
 		       unsigned long arg);
-static int timeout_ioctl(gpib_board_t *board, unsigned long arg);
-static int status_bytes_ioctl(gpib_board_t *board, unsigned long arg);
-static int board_info_ioctl(const gpib_board_t *board, unsigned long arg);
-static int ppc_ioctl(gpib_board_t *board, unsigned long arg);
-static int set_local_ppoll_mode_ioctl(gpib_board_t *board, unsigned long arg);
-static int get_local_ppoll_mode_ioctl(gpib_board_t *board, unsigned long arg);
-static int query_board_rsv_ioctl(gpib_board_t *board, unsigned long arg);
-static int interface_clear_ioctl(gpib_board_t *board, unsigned long arg);
+static int timeout_ioctl(struct gpib_board *board, unsigned long arg);
+static int status_bytes_ioctl(struct gpib_board *board, unsigned long arg);
+static int board_info_ioctl(const struct gpib_board *board, unsigned long arg);
+static int ppc_ioctl(struct gpib_board *board, unsigned long arg);
+static int set_local_ppoll_mode_ioctl(struct gpib_board *board, unsigned long arg);
+static int get_local_ppoll_mode_ioctl(struct gpib_board *board, unsigned long arg);
+static int query_board_rsv_ioctl(struct gpib_board *board, unsigned long arg);
+static int interface_clear_ioctl(struct gpib_board *board, unsigned long arg);
 static int select_pci_ioctl(gpib_board_config_t *config, unsigned long arg);
 static int select_device_path_ioctl(gpib_board_config_t *config, unsigned long arg);
-static int event_ioctl(gpib_board_t *board, unsigned long arg);
-static int request_system_control_ioctl(gpib_board_t *board, unsigned long arg);
-static int t1_delay_ioctl(gpib_board_t *board, unsigned long arg);
+static int event_ioctl(struct gpib_board *board, unsigned long arg);
+static int request_system_control_ioctl(struct gpib_board *board, unsigned long arg);
+static int t1_delay_ioctl(struct gpib_board *board, unsigned long arg);
 
-static int cleanup_open_devices(gpib_file_private_t *file_priv, gpib_board_t *board);
+static int cleanup_open_devices(gpib_file_private_t *file_priv, struct gpib_board *board);
 
-static int pop_gpib_event_nolock(gpib_board_t *board, gpib_event_queue_t *queue, short *event_type);
+static int pop_gpib_event_nolock(struct gpib_board *board, gpib_event_queue_t *queue, short *event_type);
 
 /*
  * Timer functions
@@ -82,14 +82,14 @@ static int pop_gpib_event_nolock(gpib_board_t *board, gpib_event_queue_t *queue,
 
 static void watchdog_timeout(struct timer_list *t)
 {
-	gpib_board_t *board = from_timer(board, t, timer);
+	struct gpib_board *board = from_timer(board, t, timer);
 
 	set_bit(TIMO_NUM, &board->status);
 	wake_up_interruptible(&board->wait);
 }
 
 /* install timer interrupt handler */
-void os_start_timer(gpib_board_t *board, unsigned int usec_timeout)
+void os_start_timer(struct gpib_board *board, unsigned int usec_timeout)
 /* Starts the timeout task  */
 {
 	if (timer_pending(&board->timer)) {
@@ -105,14 +105,14 @@ void os_start_timer(gpib_board_t *board, unsigned int usec_timeout)
 	}
 }
 
-void os_remove_timer(gpib_board_t *board)
+void os_remove_timer(struct gpib_board *board)
 /* Removes the timeout task */
 {
 	if (timer_pending(&board->timer))
 		del_timer_sync(&board->timer);
 }
 
-int io_timed_out(gpib_board_t *board)
+int io_timed_out(struct gpib_board *board)
 {
 	if (test_bit(TIMO_NUM, &board->status))
 		return 1;
@@ -140,7 +140,7 @@ static void pseudo_irq_handler(struct timer_list *t)
 		mod_timer(&pseudo_irq->timer, jiffies + pseudo_irq_period());
 }
 
-int gpib_request_pseudo_irq(gpib_board_t *board, irqreturn_t (*handler)(int, void *))
+int gpib_request_pseudo_irq(struct gpib_board *board, irqreturn_t (*handler)(int, void *))
 {
 	if (timer_pending(&board->pseudo_irq.timer) || board->pseudo_irq.handler) {
 		dev_err(board->gpib_dev, "only one pseudo interrupt per board allowed\n");
@@ -159,7 +159,7 @@ int gpib_request_pseudo_irq(gpib_board_t *board, irqreturn_t (*handler)(int, voi
 }
 EXPORT_SYMBOL(gpib_request_pseudo_irq);
 
-void gpib_free_pseudo_irq(gpib_board_t *board)
+void gpib_free_pseudo_irq(struct gpib_board *board)
 {
 	atomic_set(&board->pseudo_irq.active, 0);
 
@@ -178,7 +178,7 @@ unsigned int num_status_bytes(const gpib_status_queue_t *dev)
 }
 
 // push status byte onto back of status byte fifo
-int push_status_byte(gpib_board_t *board, gpib_status_queue_t *device, u8 poll_byte)
+int push_status_byte(struct gpib_board *board, gpib_status_queue_t *device, u8 poll_byte)
 {
 	struct list_head *head = &device->status_bytes;
 	status_byte_t *status;
@@ -212,7 +212,7 @@ int push_status_byte(gpib_board_t *board, gpib_status_queue_t *device, u8 poll_b
 }
 
 // pop status byte from front of status byte fifo
-int pop_status_byte(gpib_board_t *board, gpib_status_queue_t *device, u8 *poll_byte)
+int pop_status_byte(struct gpib_board *board, gpib_status_queue_t *device, u8 *poll_byte)
 {
 	struct list_head *head = &device->status_bytes;
 	struct list_head *front = head->next;
@@ -243,7 +243,7 @@ int pop_status_byte(gpib_board_t *board, gpib_status_queue_t *device, u8 *poll_b
 	return 0;
 }
 
-gpib_status_queue_t *get_gpib_status_queue(gpib_board_t *board, unsigned int pad, int sad)
+gpib_status_queue_t *get_gpib_status_queue(struct gpib_board *board, unsigned int pad, int sad)
 {
 	gpib_status_queue_t *device;
 	struct list_head *list_ptr;
@@ -258,7 +258,7 @@ gpib_status_queue_t *get_gpib_status_queue(gpib_board_t *board, unsigned int pad
 	return NULL;
 }
 
-int get_serial_poll_byte(gpib_board_t *board, unsigned int pad, int sad, unsigned int usec_timeout,
+int get_serial_poll_byte(struct gpib_board *board, unsigned int pad, int sad, unsigned int usec_timeout,
 			 uint8_t *poll_byte)
 {
 	gpib_status_queue_t *device;
@@ -270,7 +270,7 @@ int get_serial_poll_byte(gpib_board_t *board, unsigned int pad, int sad, unsigne
 		return dvrsp(board, pad, sad, usec_timeout, poll_byte);
 }
 
-int autopoll_all_devices(gpib_board_t *board)
+int autopoll_all_devices(struct gpib_board *board)
 {
 	int retval;
 
@@ -301,7 +301,7 @@ int autopoll_all_devices(gpib_board_t *board)
 	return retval;
 }
 
-static int setup_serial_poll(gpib_board_t *board, unsigned int usec_timeout)
+static int setup_serial_poll(struct gpib_board *board, unsigned int usec_timeout)
 {
 	u8 cmd_string[8];
 	int i;
@@ -333,7 +333,7 @@ static int setup_serial_poll(gpib_board_t *board, unsigned int usec_timeout)
 	return 0;
 }
 
-static int read_serial_poll_byte(gpib_board_t *board, unsigned int pad,
+static int read_serial_poll_byte(struct gpib_board *board, unsigned int pad,
 				 int sad, unsigned int usec_timeout, uint8_t *result)
 {
 	u8 cmd_string[8];
@@ -378,7 +378,7 @@ static int read_serial_poll_byte(gpib_board_t *board, unsigned int pad,
 	return 0;
 }
 
-static int cleanup_serial_poll(gpib_board_t *board, unsigned int usec_timeout)
+static int cleanup_serial_poll(struct gpib_board *board, unsigned int usec_timeout)
 {
 	u8 cmd_string[8];
 	int ret;
@@ -404,7 +404,7 @@ static int cleanup_serial_poll(gpib_board_t *board, unsigned int usec_timeout)
 	return 0;
 }
 
-static int serial_poll_single(gpib_board_t *board, unsigned int pad, int sad,
+static int serial_poll_single(struct gpib_board *board, unsigned int pad, int sad,
 			      unsigned int usec_timeout, uint8_t *result)
 {
 	int retval, cleanup_retval;
@@ -422,7 +422,7 @@ static int serial_poll_single(gpib_board_t *board, unsigned int pad, int sad,
 	return 0;
 }
 
-int serial_poll_all(gpib_board_t *board, unsigned int usec_timeout)
+int serial_poll_all(struct gpib_board *board, unsigned int usec_timeout)
 {
 	int retval = 0;
 	struct list_head *cur;
@@ -469,7 +469,7 @@ int serial_poll_all(gpib_board_t *board, unsigned int usec_timeout)
  * SPD and UNT are sent at the completion of the poll.
  */
 
-int dvrsp(gpib_board_t *board, unsigned int pad, int sad,
+int dvrsp(struct gpib_board *board, unsigned int pad, int sad,
 	  unsigned int usec_timeout, uint8_t *result)
 {
 	int status = ibstatus(board);
@@ -521,7 +521,7 @@ static int init_gpib_file_private(gpib_file_private_t *priv)
 int ibopen(struct inode *inode, struct file *filep)
 {
 	unsigned int minor = iminor(inode);
-	gpib_board_t *board;
+	struct gpib_board *board;
 	gpib_file_private_t *priv;
 
 	if (minor >= GPIB_MAX_NUM_BOARDS) {
@@ -559,7 +559,7 @@ int ibopen(struct inode *inode, struct file *filep)
 int ibclose(struct inode *inode, struct file *filep)
 {
 	unsigned int minor = iminor(inode);
-	gpib_board_t *board;
+	struct gpib_board *board;
 	gpib_file_private_t *priv = filep->private_data;
 	gpib_descriptor_t *desc;
 
@@ -605,7 +605,7 @@ int ibclose(struct inode *inode, struct file *filep)
 long ibioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 {
 	unsigned int minor = iminor(filep->f_path.dentry->d_inode);
-	gpib_board_t *board;
+	struct gpib_board *board;
 	gpib_file_private_t *file_priv = filep->private_data;
 	long retval = -ENOTTY;
 
@@ -806,7 +806,7 @@ long ibioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	return retval;
 }
 
-static int board_type_ioctl(gpib_file_private_t *file_priv, gpib_board_t *board, unsigned long arg)
+static int board_type_ioctl(gpib_file_private_t *file_priv, struct gpib_board *board, unsigned long arg)
 {
 	struct list_head *list_ptr;
 	board_type_ioctl_t cmd;
@@ -857,7 +857,7 @@ static int board_type_ioctl(gpib_file_private_t *file_priv, gpib_board_t *board,
 	return -EINVAL;
 }
 
-static int read_ioctl(gpib_file_private_t *file_priv, gpib_board_t *board,
+static int read_ioctl(gpib_file_private_t *file_priv, struct gpib_board *board,
 		      unsigned long arg)
 {
 	read_write_ioctl_t read_cmd;
@@ -933,7 +933,7 @@ static int read_ioctl(gpib_file_private_t *file_priv, gpib_board_t *board,
 }
 
 static int command_ioctl(gpib_file_private_t *file_priv,
-			 gpib_board_t *board, unsigned long arg)
+			 struct gpib_board *board, unsigned long arg)
 {
 	read_write_ioctl_t cmd;
 	u8 __user *userbuf;
@@ -1016,7 +1016,7 @@ static int command_ioctl(gpib_file_private_t *file_priv,
 	return retval;
 }
 
-static int write_ioctl(gpib_file_private_t *file_priv, gpib_board_t *board,
+static int write_ioctl(gpib_file_private_t *file_priv, struct gpib_board *board,
 		       unsigned long arg)
 {
 	read_write_ioctl_t write_cmd;
@@ -1087,7 +1087,7 @@ static int write_ioctl(gpib_file_private_t *file_priv, gpib_board_t *board,
 	return retval;
 }
 
-static int status_bytes_ioctl(gpib_board_t *board, unsigned long arg)
+static int status_bytes_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	gpib_status_queue_t *device;
 	spoll_bytes_ioctl_t cmd;
@@ -1110,7 +1110,7 @@ static int status_bytes_ioctl(gpib_board_t *board, unsigned long arg)
 	return 0;
 }
 
-static int increment_open_device_count(gpib_board_t *board, struct list_head *head,
+static int increment_open_device_count(struct gpib_board *board, struct list_head *head,
 				       unsigned int pad, int sad)
 {
 	struct list_head *list_ptr;
@@ -1145,7 +1145,7 @@ static int increment_open_device_count(gpib_board_t *board, struct list_head *he
 	return 0;
 }
 
-static int subtract_open_device_count(gpib_board_t *board, struct list_head *head,
+static int subtract_open_device_count(struct gpib_board *board, struct list_head *head,
 				      unsigned int pad, int sad, unsigned int count)
 {
 	gpib_status_queue_t *device;
@@ -1174,13 +1174,13 @@ static int subtract_open_device_count(gpib_board_t *board, struct list_head *hea
 	return -EINVAL;
 }
 
-static inline int decrement_open_device_count(gpib_board_t *board, struct list_head *head,
+static inline int decrement_open_device_count(struct gpib_board *board, struct list_head *head,
 					      unsigned int pad, int sad)
 {
 	return subtract_open_device_count(board, head, pad, sad, 1);
 }
 
-static int cleanup_open_devices(gpib_file_private_t *file_priv, gpib_board_t *board)
+static int cleanup_open_devices(gpib_file_private_t *file_priv, struct gpib_board *board)
 {
 	int retval = 0;
 	int i;
@@ -1205,7 +1205,7 @@ static int cleanup_open_devices(gpib_file_private_t *file_priv, gpib_board_t *bo
 	return 0;
 }
 
-static int open_dev_ioctl(struct file *filep, gpib_board_t *board, unsigned long arg)
+static int open_dev_ioctl(struct file *filep, struct gpib_board *board, unsigned long arg)
 {
 	open_dev_ioctl_t open_dev_cmd;
 	int retval;
@@ -1255,7 +1255,7 @@ static int open_dev_ioctl(struct file *filep, gpib_board_t *board, unsigned long
 	return 0;
 }
 
-static int close_dev_ioctl(struct file *filep, gpib_board_t *board, unsigned long arg)
+static int close_dev_ioctl(struct file *filep, struct gpib_board *board, unsigned long arg)
 {
 	close_dev_ioctl_t cmd;
 	gpib_file_private_t *file_priv = filep->private_data;
@@ -1282,7 +1282,7 @@ static int close_dev_ioctl(struct file *filep, gpib_board_t *board, unsigned lon
 	return 0;
 }
 
-static int serial_poll_ioctl(gpib_board_t *board, unsigned long arg)
+static int serial_poll_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	serial_poll_ioctl_t serial_cmd;
 	int retval;
@@ -1303,7 +1303,7 @@ static int serial_poll_ioctl(gpib_board_t *board, unsigned long arg)
 	return 0;
 }
 
-static int wait_ioctl(gpib_file_private_t *file_priv, gpib_board_t *board,
+static int wait_ioctl(gpib_file_private_t *file_priv, struct gpib_board *board,
 		      unsigned long arg)
 {
 	wait_ioctl_t wait_cmd;
@@ -1330,7 +1330,7 @@ static int wait_ioctl(gpib_file_private_t *file_priv, gpib_board_t *board,
 	return 0;
 }
 
-static int parallel_poll_ioctl(gpib_board_t *board, unsigned long arg)
+static int parallel_poll_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	u8 poll_byte;
 	int retval;
@@ -1346,7 +1346,7 @@ static int parallel_poll_ioctl(gpib_board_t *board, unsigned long arg)
 	return 0;
 }
 
-static int online_ioctl(gpib_board_t *board, unsigned long arg)
+static int online_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	online_ioctl_t online_cmd;
 	int retval;
@@ -1390,7 +1390,7 @@ static int online_ioctl(gpib_board_t *board, unsigned long arg)
 	return retval;
 }
 
-static int remote_enable_ioctl(gpib_board_t *board, unsigned long arg)
+static int remote_enable_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	int enable;
 	int retval;
@@ -1402,7 +1402,7 @@ static int remote_enable_ioctl(gpib_board_t *board, unsigned long arg)
 	return ibsre(board, enable);
 }
 
-static int take_control_ioctl(gpib_board_t *board, unsigned long arg)
+static int take_control_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	int synchronous;
 	int retval;
@@ -1414,7 +1414,7 @@ static int take_control_ioctl(gpib_board_t *board, unsigned long arg)
 	return ibcac(board, synchronous, 1);
 }
 
-static int line_status_ioctl(gpib_board_t *board, unsigned long arg)
+static int line_status_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	short lines;
 	int retval;
@@ -1430,7 +1430,7 @@ static int line_status_ioctl(gpib_board_t *board, unsigned long arg)
 	return 0;
 }
 
-static int pad_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
+static int pad_ioctl(struct gpib_board *board, gpib_file_private_t *file_priv,
 		     unsigned long arg)
 {
 	pad_ioctl_t cmd;
@@ -1466,7 +1466,7 @@ static int pad_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
 	return 0;
 }
 
-static int sad_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
+static int sad_ioctl(struct gpib_board *board, gpib_file_private_t *file_priv,
 		     unsigned long arg)
 {
 	sad_ioctl_t cmd;
@@ -1501,7 +1501,7 @@ static int sad_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
 	return 0;
 }
 
-static int eos_ioctl(gpib_board_t *board, unsigned long arg)
+static int eos_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	eos_ioctl_t eos_cmd;
 	int retval;
@@ -1513,7 +1513,7 @@ static int eos_ioctl(gpib_board_t *board, unsigned long arg)
 	return ibeos(board, eos_cmd.eos, eos_cmd.eos_flags);
 }
 
-static int request_service_ioctl(gpib_board_t *board, unsigned long arg)
+static int request_service_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	u8 status_byte;
 	int retval;
@@ -1525,7 +1525,7 @@ static int request_service_ioctl(gpib_board_t *board, unsigned long arg)
 	return ibrsv2(board, status_byte, status_byte & request_service_bit);
 }
 
-static int request_service2_ioctl(gpib_board_t *board, unsigned long arg)
+static int request_service2_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	request_service2_t request_service2_cmd;
 	int retval;
@@ -1592,7 +1592,7 @@ static int dma_ioctl(gpib_board_config_t *config, unsigned long arg)
 	return 0;
 }
 
-static int autospoll_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
+static int autospoll_ioctl(struct gpib_board *board, gpib_file_private_t *file_priv,
 			   unsigned long arg)
 {
 	autospoll_ioctl_t enable;
@@ -1630,7 +1630,7 @@ static int autospoll_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
 	return retval;
 }
 
-static int mutex_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
+static int mutex_ioctl(struct gpib_board *board, gpib_file_private_t *file_priv,
 		       unsigned long arg)
 {
 	int retval, lock_mutex;
@@ -1670,7 +1670,7 @@ static int mutex_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
 	return 0;
 }
 
-static int timeout_ioctl(gpib_board_t *board, unsigned long arg)
+static int timeout_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	unsigned int timeout;
 	int retval;
@@ -1685,7 +1685,7 @@ static int timeout_ioctl(gpib_board_t *board, unsigned long arg)
 	return 0;
 }
 
-static int ppc_ioctl(gpib_board_t *board, unsigned long arg)
+static int ppc_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	ppoll_config_ioctl_t cmd;
 	int retval;
@@ -1711,7 +1711,7 @@ static int ppc_ioctl(gpib_board_t *board, unsigned long arg)
 	return 0;
 }
 
-static int set_local_ppoll_mode_ioctl(gpib_board_t *board, unsigned long arg)
+static int set_local_ppoll_mode_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	local_ppoll_mode_ioctl_t cmd;
 	int retval;
@@ -1728,7 +1728,7 @@ static int set_local_ppoll_mode_ioctl(gpib_board_t *board, unsigned long arg)
 	return 0;
 }
 
-static int get_local_ppoll_mode_ioctl(gpib_board_t *board, unsigned long arg)
+static int get_local_ppoll_mode_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	local_ppoll_mode_ioctl_t cmd;
 	int retval;
@@ -1741,7 +1741,7 @@ static int get_local_ppoll_mode_ioctl(gpib_board_t *board, unsigned long arg)
 	return 0;
 }
 
-static int query_board_rsv_ioctl(gpib_board_t *board, unsigned long arg)
+static int query_board_rsv_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	int status;
 	int retval;
@@ -1755,7 +1755,7 @@ static int query_board_rsv_ioctl(gpib_board_t *board, unsigned long arg)
 	return 0;
 }
 
-static int board_info_ioctl(const gpib_board_t *board, unsigned long arg)
+static int board_info_ioctl(const struct gpib_board *board, unsigned long arg)
 {
 	board_info_ioctl_t info;
 	int retval;
@@ -1778,7 +1778,7 @@ static int board_info_ioctl(const gpib_board_t *board, unsigned long arg)
 	return 0;
 }
 
-static int interface_clear_ioctl(gpib_board_t *board, unsigned long arg)
+static int interface_clear_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	unsigned int usec_duration;
 	int retval;
@@ -1841,7 +1841,7 @@ unsigned int num_gpib_events(const gpib_event_queue_t *queue)
 	return queue->num_events;
 }
 
-static int push_gpib_event_nolock(gpib_board_t *board, short event_type)
+static int push_gpib_event_nolock(struct gpib_board *board, short event_type)
 {
 	gpib_event_queue_t *queue = &board->event_queue;
 	struct list_head *head = &queue->event_head;
@@ -1879,7 +1879,7 @@ static int push_gpib_event_nolock(gpib_board_t *board, short event_type)
 }
 
 // push event onto back of event queue
-int push_gpib_event(gpib_board_t *board, short event_type)
+int push_gpib_event(struct gpib_board *board, short event_type)
 {
 	unsigned long flags;
 	int retval;
@@ -1897,7 +1897,7 @@ int push_gpib_event(gpib_board_t *board, short event_type)
 }
 EXPORT_SYMBOL(push_gpib_event);
 
-static int pop_gpib_event_nolock(gpib_board_t *board, gpib_event_queue_t *queue, short *event_type)
+static int pop_gpib_event_nolock(struct gpib_board *board, gpib_event_queue_t *queue, short *event_type)
 {
 	struct list_head *head = &queue->event_head;
 	struct list_head *front = head->next;
@@ -1931,7 +1931,7 @@ static int pop_gpib_event_nolock(gpib_board_t *board, gpib_event_queue_t *queue,
 }
 
 // pop event from front of event queue
-int pop_gpib_event(gpib_board_t *board, gpib_event_queue_t *queue, short *event_type)
+int pop_gpib_event(struct gpib_board *board, gpib_event_queue_t *queue, short *event_type)
 {
 	unsigned long flags;
 	int retval;
@@ -1942,7 +1942,7 @@ int pop_gpib_event(gpib_board_t *board, gpib_event_queue_t *queue, short *event_
 	return retval;
 }
 
-static int event_ioctl(gpib_board_t *board, unsigned long arg)
+static int event_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	event_ioctl_t user_event;
 	int retval;
@@ -1961,7 +1961,7 @@ static int event_ioctl(gpib_board_t *board, unsigned long arg)
 	return 0;
 }
 
-static int request_system_control_ioctl(gpib_board_t *board, unsigned long arg)
+static int request_system_control_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	rsc_ioctl_t request_control;
 	int retval;
@@ -1975,7 +1975,7 @@ static int request_system_control_ioctl(gpib_board_t *board, unsigned long arg)
 	return 0;
 }
 
-static int t1_delay_ioctl(gpib_board_t *board, unsigned long arg)
+static int t1_delay_ioctl(struct gpib_board *board, unsigned long arg)
 {
 	t1_delay_ioctl_t cmd;
 	unsigned int delay;
@@ -2004,7 +2004,7 @@ static const struct file_operations ib_fops = {
 	.release = &ibclose,
 };
 
-gpib_board_t board_array[GPIB_MAX_NUM_BOARDS];
+struct gpib_board board_array[GPIB_MAX_NUM_BOARDS];
 
 LIST_HEAD(registered_drivers);
 
@@ -2039,7 +2039,7 @@ void gpib_unregister_driver(gpib_interface_t *interface)
 	struct list_head *list_ptr;
 
 	for (i = 0; i < GPIB_MAX_NUM_BOARDS; i++) {
-		gpib_board_t *board = &board_array[i];
+		struct gpib_board *board = &board_array[i];
 
 		if (board->interface == interface) {
 			if (board->use_count > 0)
@@ -2069,7 +2069,7 @@ static void init_gpib_board_config(gpib_board_config_t *config)
 	config->pci_slot = -1;
 }
 
-void init_gpib_board(gpib_board_t *board)
+void init_gpib_board(struct gpib_board *board)
 {
 	board->interface = NULL;
 	board->provider_module = NULL;
@@ -2104,7 +2104,7 @@ void init_gpib_board(gpib_board_t *board)
 	board->local_ppoll_mode = 0;
 }
 
-int gpib_allocate_board(gpib_board_t *board)
+int gpib_allocate_board(struct gpib_board *board)
 {
 	if (!board->buffer) {
 		board->buffer_length = 0x4000;
@@ -2117,7 +2117,7 @@ int gpib_allocate_board(gpib_board_t *board)
 	return 0;
 }
 
-void gpib_deallocate_board(gpib_board_t *board)
+void gpib_deallocate_board(struct gpib_board *board)
 {
 	short dummy;
 
@@ -2130,7 +2130,7 @@ void gpib_deallocate_board(gpib_board_t *board)
 		pop_gpib_event(board, &board->event_queue, &dummy);
 }
 
-static void init_board_array(gpib_board_t *board_array, unsigned int length)
+static void init_board_array(struct gpib_board *board_array, unsigned int length)
 {
 	int i;
 
diff --git a/drivers/staging/gpib/common/iblib.c b/drivers/staging/gpib/common/iblib.c
index 92e792e12301..6cca8a49e839 100644
--- a/drivers/staging/gpib/common/iblib.c
+++ b/drivers/staging/gpib/common/iblib.c
@@ -21,7 +21,7 @@
  * If fallback_to_async is non-zero, try to take control asynchronously
  * if synchronous attempt fails.
  */
-int ibcac(gpib_board_t *board, int sync, int fallback_to_async)
+int ibcac(struct gpib_board *board, int sync, int fallback_to_async)
 {
 	int status = ibstatus(board);
 	int retval;
@@ -61,7 +61,7 @@ int ibcac(gpib_board_t *board, int sync, int fallback_to_async)
  * set the skip_check_for_command_acceptors flag in their
  * gpib_interface_struct to avoid useless overhead.
  */
-static int check_for_command_acceptors(gpib_board_t *board)
+static int check_for_command_acceptors(struct gpib_board *board)
 {
 	int lines;
 
@@ -96,7 +96,7 @@ static int check_for_command_acceptors(gpib_board_t *board)
  *          must be called to initialize the GPIB and enable
  *          the interface to leave the controller idle state.
  */
-int ibcmd(gpib_board_t *board, uint8_t *buf, size_t length, size_t *bytes_written)
+int ibcmd(struct gpib_board *board, uint8_t *buf, size_t length, size_t *bytes_written)
 {
 	ssize_t ret = 0;
 	int status;
@@ -131,7 +131,7 @@ int ibcmd(gpib_board_t *board, uint8_t *buf, size_t length, size_t *bytes_writte
  * active state, i.e., turn ATN off.
  */
 
-int ibgts(gpib_board_t *board)
+int ibgts(struct gpib_board *board)
 {
 	int status = ibstatus(board);
 	int retval;
@@ -146,7 +146,7 @@ int ibgts(gpib_board_t *board)
 	return retval;
 }
 
-static int autospoll_wait_should_wake_up(gpib_board_t *board)
+static int autospoll_wait_should_wake_up(struct gpib_board *board)
 {
 	int retval;
 
@@ -162,7 +162,7 @@ static int autospoll_wait_should_wake_up(gpib_board_t *board)
 
 static int autospoll_thread(void *board_void)
 {
-	gpib_board_t *board = board_void;
+	struct gpib_board *board = board_void;
 	int retval = 0;
 
 	dev_dbg(board->gpib_dev, "entering autospoll thread\n");
@@ -199,7 +199,7 @@ static int autospoll_thread(void *board_void)
 	return retval;
 }
 
-int ibonline(gpib_board_t *board)
+int ibonline(struct gpib_board *board)
 {
 	int retval;
 
@@ -238,7 +238,7 @@ int ibonline(gpib_board_t *board)
 }
 
 /* XXX need to make sure board is generally not in use (grab board lock?) */
-int iboffline(gpib_board_t *board)
+int iboffline(struct gpib_board *board)
 {
 	int retval;
 
@@ -270,7 +270,7 @@ int iboffline(gpib_board_t *board)
  * Next LSB (bits 8-15) - STATUS lines mask (lines that are currently set).
  *
  */
-int iblines(const gpib_board_t *board, short *lines)
+int iblines(const struct gpib_board *board, short *lines)
 {
 	int retval;
 
@@ -297,7 +297,7 @@ int iblines(const gpib_board_t *board, short *lines)
  *          calling ibcmd.
  */
 
-int ibrd(gpib_board_t *board, uint8_t *buf, size_t length, int *end_flag, size_t *nbytes)
+int ibrd(struct gpib_board *board, uint8_t *buf, size_t length, int *end_flag, size_t *nbytes)
 {
 	ssize_t ret = 0;
 	int retval;
@@ -343,7 +343,7 @@ int ibrd(gpib_board_t *board, uint8_t *buf, size_t length, int *end_flag, size_t
  *	1.  Prior to conducting the poll the interface is placed
  *	    in the controller active state.
  */
-int ibrpp(gpib_board_t *board, uint8_t *result)
+int ibrpp(struct gpib_board *board, uint8_t *result)
 {
 	int retval = 0;
 
@@ -358,7 +358,7 @@ int ibrpp(gpib_board_t *board, uint8_t *result)
 	return retval;
 }
 
-int ibppc(gpib_board_t *board, uint8_t configuration)
+int ibppc(struct gpib_board *board, uint8_t configuration)
 {
 	configuration &= 0x1f;
 	board->interface->parallel_poll_configure(board, configuration);
@@ -367,7 +367,7 @@ int ibppc(gpib_board_t *board, uint8_t configuration)
 	return 0;
 }
 
-int ibrsv2(gpib_board_t *board, uint8_t status_byte, int new_reason_for_service)
+int ibrsv2(struct gpib_board *board, uint8_t status_byte, int new_reason_for_service)
 {
 	int board_status = ibstatus(board);
 	const unsigned int MSS = status_byte & request_service_bit;
@@ -400,7 +400,7 @@ int ibrsv2(gpib_board_t *board, uint8_t status_byte, int new_reason_for_service)
  *	    ibcmd in order to initialize the bus and enable the
  *	    interface to leave the controller idle state.
  */
-int ibsic(gpib_board_t *board, unsigned int usec_duration)
+int ibsic(struct gpib_board *board, unsigned int usec_duration)
 {
 	if (board->master == 0)
 		return -EINVAL;
@@ -419,7 +419,7 @@ int ibsic(gpib_board_t *board, unsigned int usec_duration)
 }
 
 	/* FIXME make int */
-void ibrsc(gpib_board_t *board, int request_control)
+void ibrsc(struct gpib_board *board, int request_control)
 {
 	board->master = request_control != 0;
 	if (board->interface->request_system_control)
@@ -430,7 +430,7 @@ void ibrsc(gpib_board_t *board, int request_control)
  * IBSRE
  * Send REN true if v is non-zero or false if v is zero.
  */
-int ibsre(gpib_board_t *board, int enable)
+int ibsre(struct gpib_board *board, int enable)
 {
 	if (board->master == 0)
 		return -EINVAL;
@@ -447,7 +447,7 @@ int ibsre(gpib_board_t *board, int enable)
  * change the GPIB address of the interface board.  The address
  * must be 0 through 30.  ibonl resets the address to PAD.
  */
-int ibpad(gpib_board_t *board, unsigned int addr)
+int ibpad(struct gpib_board *board, unsigned int addr)
 {
 	if (addr > MAX_GPIB_PRIMARY_ADDRESS)
 		return -EINVAL;
@@ -465,7 +465,7 @@ int ibpad(gpib_board_t *board, unsigned int addr)
  * The address must be 0 through 30, or negative disables.  ibonl resets the
  * address to SAD.
  */
-int ibsad(gpib_board_t *board, int addr)
+int ibsad(struct gpib_board *board, int addr)
 {
 	if (addr > MAX_GPIB_SECONDARY_ADDRESS)
 		return -EINVAL;
@@ -486,7 +486,7 @@ int ibsad(gpib_board_t *board, int addr)
  * Set the end-of-string modes for I/O operations to v.
  *
  */
-int ibeos(gpib_board_t *board, int eos, int eosflags)
+int ibeos(struct gpib_board *board, int eos, int eosflags)
 {
 	int retval;
 
@@ -501,12 +501,12 @@ int ibeos(gpib_board_t *board, int eos, int eosflags)
 	return retval;
 }
 
-int ibstatus(gpib_board_t *board)
+int ibstatus(struct gpib_board *board)
 {
 	return general_ibstatus(board, NULL, 0, 0, NULL);
 }
 
-int general_ibstatus(gpib_board_t *board, const gpib_status_queue_t *device,
+int general_ibstatus(struct gpib_board *board, const gpib_status_queue_t *device,
 		     int clear_mask, int set_mask, gpib_descriptor_t *desc)
 {
 	int status = 0;
@@ -552,7 +552,7 @@ int general_ibstatus(gpib_board_t *board, const gpib_status_queue_t *device,
 }
 
 struct wait_info {
-	gpib_board_t *board;
+	struct gpib_board *board;
 	struct timer_list timer;
 	int timed_out;
 	unsigned long usec_timeout;
@@ -576,7 +576,7 @@ static void init_wait_info(struct wait_info *winfo)
 static int wait_satisfied(struct wait_info *winfo, gpib_status_queue_t *status_queue,
 			  int wait_mask, int *status, gpib_descriptor_t *desc)
 {
-	gpib_board_t *board = winfo->board;
+	struct gpib_board *board = winfo->board;
 	int temp_status;
 
 	if (mutex_lock_interruptible(&board->big_gpib_mutex))
@@ -622,7 +622,7 @@ static void remove_wait_timer(struct wait_info *winfo)
  * If the mask is 0 then
  * no condition is waited for.
  */
-int ibwait(gpib_board_t *board, int wait_mask, int clear_mask, int set_mask,
+int ibwait(struct gpib_board *board, int wait_mask, int clear_mask, int set_mask,
 	   int *status, unsigned long usec_timeout, gpib_descriptor_t *desc)
 {
 	int retval = 0;
@@ -677,7 +677,7 @@ int ibwait(gpib_board_t *board, int wait_mask, int clear_mask, int set_mask,
  *          well as the interface board itself must be
  *          addressed by calling ibcmd.
  */
-int ibwrt(gpib_board_t *board, uint8_t *buf, size_t cnt, int send_eoi, size_t *bytes_written)
+int ibwrt(struct gpib_board *board, uint8_t *buf, size_t cnt, int send_eoi, size_t *bytes_written)
 {
 	int ret = 0;
 	int retval;
diff --git a/drivers/staging/gpib/common/ibsys.h b/drivers/staging/gpib/common/ibsys.h
index da20971e9c7e..19960af809c2 100644
--- a/drivers/staging/gpib/common/ibsys.h
+++ b/drivers/staging/gpib/common/ibsys.h
@@ -19,13 +19,13 @@
 #define MAX_GPIB_PRIMARY_ADDRESS 30
 #define MAX_GPIB_SECONDARY_ADDRESS 31
 
-int gpib_allocate_board(gpib_board_t *board);
-void gpib_deallocate_board(gpib_board_t *board);
+int gpib_allocate_board(struct gpib_board *board);
+void gpib_deallocate_board(struct gpib_board *board);
 
 unsigned int num_status_bytes(const gpib_status_queue_t *dev);
-int push_status_byte(gpib_board_t *board, gpib_status_queue_t *device, uint8_t poll_byte);
-int pop_status_byte(gpib_board_t *board, gpib_status_queue_t *device, uint8_t *poll_byte);
-gpib_status_queue_t *get_gpib_status_queue(gpib_board_t *board, unsigned int pad, int sad);
-int get_serial_poll_byte(gpib_board_t *board, unsigned int pad, int sad,
+int push_status_byte(struct gpib_board *board, gpib_status_queue_t *device, uint8_t poll_byte);
+int pop_status_byte(struct gpib_board *board, gpib_status_queue_t *device, uint8_t *poll_byte);
+gpib_status_queue_t *get_gpib_status_queue(struct gpib_board *board, unsigned int pad, int sad);
+int get_serial_poll_byte(struct gpib_board *board, unsigned int pad, int sad,
 			 unsigned int usec_timeout, uint8_t *poll_byte);
-int autopoll_all_devices(gpib_board_t *board);
+int autopoll_all_devices(struct gpib_board *board);
-- 
2.43.0


