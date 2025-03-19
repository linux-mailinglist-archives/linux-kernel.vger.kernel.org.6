Return-Path: <linux-kernel+bounces-568887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A369DA69BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC17483338
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D54221D9B;
	Wed, 19 Mar 2025 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="EZXlB+5e"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322A72206B9
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421596; cv=none; b=qU0xQJGMVkfT4XmpNrwrNiYg2MjbAWtrU4PTsPoAa7S8T3coceqXRlvjIzam2VZlO1VQMJzbHxJHvAfasycmTjvZiFwF8k/11oFu5DTAKrpdu75WxugbCFCtctUMwt8P8U5qZ/j/cYrZ9UCbyrsuIk2xjpr2VDiwRg0mTvp90Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421596; c=relaxed/simple;
	bh=D9jHv4F3beF/tfaKVhG+ozyOsdkV+NSWO9RfknO2eDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TiWmyyKF+HmtrH78tgVpSNPBN1YLciiwk2N+DHC3IgDTYdIr8eTYs7lo09EGXuf+JdPi5ZctpcxemGZMNSavjpLtj1DtQCgqe/Eb8F4+GIMHLqvWP4NjuSHchsgI4MCYPvIwqITyFPZwR9WuI80y7bq6zqwCEqBJ2EHn8G82aNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=EZXlB+5e; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223594b3c6dso848315ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421593; x=1743026393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdZGZ77wjlRTZO+CcfVmzyPhMaV94Mgkkl1OdMTPEqo=;
        b=EZXlB+5elVvSXmJrWQGbD0qvyp6BDkONT0NbTS2480VUkyhw8LsGIt7ff52kiFPnVN
         UgXU29vl58TuU2+oYP5B1ZatF11qV6WijBajG2WKpYv93I2hriOztYrl5+aI6HfL9Pje
         PEcSQhg7NZvyHRT+4WXXHZUkvL9p0U3WA2uY0qhxgvOikNK0dPh2g8rGEaD1TeDdV7as
         vQB7d/YtCsmv9Y135KyPKM0adBQIHZ4N6RS60VbxvFzGOjnI/uL9yJK2wVT+e3deOece
         6mS/IXjRzvYglkNPHUT1bmRhwnavPgFMRvluR4iMoslbF555oKjgathB2waxx54rd1OU
         tP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421593; x=1743026393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdZGZ77wjlRTZO+CcfVmzyPhMaV94Mgkkl1OdMTPEqo=;
        b=Pj/bIFkeSnOb2Y71XWBxNjoPIT9WNoB6XbfXogxcfraYuQxpwWa8bLFuyfnhDcmK4u
         jyta0rh7S1Y2LNnT6xhdUJdHrHBZYBGBHdxSI776UuoSAUBulE4jwcOuY7Co17hYC7OE
         yfdiDql4Yp0M2haUVPbSs8QjS2BSaRWX3arXtNThmh1a4NAYCvALI6IsfuUlnY3zsC79
         LOIrIGh1M4Rfi0jv3iwTZAmcgAQVo8FkrqNXWm15tj1FRpKr2A+N/oYEi7ZnjmRxtsin
         y/dXGUnzVo7AwPBioDWKs5zExFARYBSmjT6KjK2gx5yL59987GGArElOipa+7/7yC/w8
         gGZw==
X-Forwarded-Encrypted: i=1; AJvYcCUKpdYmi0roujIgvQHijY53zBJDnnD4omAapfbGVcr0FQbuyvlYasT6iu2+cNqY4pACrrK/0z0rAqQ+CeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YziVxk7d8EKPSk9tLN9fd8qqY8b3tk5owB+PsmixaC+HyV+CwW1
	w14AA1thLcf/bgSHAxht040kJRSYMq/+nnxhBERL0u1vPFpekmWNTfHlH3T2vw==
X-Gm-Gg: ASbGncvSsDp6nPQH/FmEeYL5AA4pU9n8CeGCasvkGT1sR73+EGEyRcumcjmnQGyXSho
	0P1Q9kRKXJUmrgXbTXTm5ndWaXromjbPr/IyBJ2jd6O+IRze5EdlyPsX8ljnYvNuUNL1WF1h0Z2
	HvzfMeZF36aoF1CAx0CyTO/acDu+lVOM6kzr2BAPm5GzUIgangTGwG40gJXZAtpKjvvzpwNiHYM
	LjqJWIXYSfzn9RmYjlsdgtC6vZBzgowlWQ4WDD2uoz69j0/fAYJ77IYMpJHEL2MUw4DDu6JmtLm
	+QEBaMp8SOICWkIAvC+oNd1gK83mQ7OittgBy8NyKdvzAe5oUF43zD5ZDlXI3ws41so0KQO+K4A
	lAYTRZ61YWw==
X-Google-Smtp-Source: AGHT+IGOzwauxkMf+TqYgZvWJWEnbL8FWR8n0Uw8+339Ig3NLlSoKeZMkib7RehvHJZdxWTjd71CYQ==
X-Received: by 2002:a05:6a00:851:b0:736:5725:59b4 with SMTP id d2e1a72fcca58-7376d5e2d98mr7107523b3a.3.1742421593231;
        Wed, 19 Mar 2025 14:59:53 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm11657944a12.6.2025.03.19.14.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:59:52 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 13/20] staging: gpib: lpvo_usb_gpib: struct gpib_board
Date: Wed, 19 Mar 2025 21:59:17 +0000
Message-ID: <20250319215924.19387-14-matchstick@neverthere.org>
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
 .../gpib/lpvo_usb_gpib/lpvo_usb_gpib.c        | 66 +++++++++----------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 011096ece7d6..1675aa2aff6c 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -146,7 +146,7 @@ struct usb_gpib_priv {		/* private data to the device */
 
 #define GPIB_DEV (((struct usb_gpib_priv *)board->private_data)->dev)
 
-static void show_status(gpib_board_t *board)
+static void show_status(struct gpib_board *board)
 {
 	DIA_LOG(2, "# - buffer_length %d\n", board->buffer_length);
 	DIA_LOG(2, "# - status %lx\n", board->status);
@@ -184,8 +184,8 @@ static struct mutex minors_lock;     /* operations on usb_minors are to be prote
 struct usb_skel;
 static ssize_t skel_do_write(struct usb_skel *, const char *, size_t);
 static ssize_t skel_do_read(struct usb_skel *, char *, size_t);
-static int skel_do_open(gpib_board_t *, int);
-static int skel_do_release(gpib_board_t *);
+static int skel_do_open(struct gpib_board *, int);
+static int skel_do_release(struct gpib_board *);
 
 /*
  *   usec_diff : take difference in MICROsec between two 'timespec'
@@ -237,7 +237,7 @@ static int write_loop(void *dev, char *msg, int leng)
  *	      it has to be given explicitly.
  */
 
-static int send_command(gpib_board_t *board, char *msg, int leng)
+static int send_command(struct gpib_board *board, char *msg, int leng)
 {
 	char buffer[64];
 	int nchar;
@@ -278,7 +278,7 @@ static int send_command(gpib_board_t *board, char *msg, int leng)
  *
  */
 
-static int set_control_line(gpib_board_t *board, int line, int value)
+static int set_control_line(struct gpib_board *board, int line, int value)
 {
 	char msg[] = USB_GPIB_SET_LINES;
 	int retval;
@@ -309,7 +309,7 @@ static int set_control_line(gpib_board_t *board, int line, int value)
  * @char_buf:	the routine private data structure
  */
 
-static int one_char(gpib_board_t *board, struct char_buf *b)
+static int one_char(struct gpib_board *board, struct char_buf *b)
 {
 	struct timespec64 before, after;
 
@@ -343,7 +343,7 @@ static int one_char(gpib_board_t *board, struct char_buf *b)
  *	   not supported.
  */
 
-static void set_timeout(gpib_board_t *board)
+static void set_timeout(struct gpib_board *board)
 {
 	int n, val;
 	char command[sizeof(USB_GPIB_TTMO) + 6];
@@ -391,7 +391,7 @@ static void set_timeout(gpib_board_t *board)
  * detach() will be called. Always.
  */
 
-static int usb_gpib_attach(gpib_board_t *board, const gpib_board_config_t *config)
+static int usb_gpib_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	int retval, j;
 	u32 base = config->ibbase;
@@ -510,7 +510,7 @@ static int usb_gpib_attach(gpib_board_t *board, const gpib_board_config_t *confi
  *
  */
 
-static void usb_gpib_detach(gpib_board_t *board)
+static void usb_gpib_detach(struct gpib_board *board)
 {
 	int retval;
 
@@ -537,7 +537,7 @@ static void usb_gpib_detach(gpib_board_t *board)
  *   Other functions follow in alphabetical order
  */
 /* command */
-static int usb_gpib_command(gpib_board_t *board,
+static int usb_gpib_command(struct gpib_board *board,
 			    u8 *buffer,
 			    size_t length,
 			    size_t *bytes_written)
@@ -570,7 +570,7 @@ static int usb_gpib_command(gpib_board_t *board,
  *   Cannot do nothing here, but remember for future use.
  */
 
-static void usb_gpib_disable_eos(gpib_board_t *board)
+static void usb_gpib_disable_eos(struct gpib_board *board)
 {
 	((struct usb_gpib_priv *)board->private_data)->eos_flags &= ~REOS;
 	DIA_LOG(1, "done: %x\n",
@@ -586,7 +586,7 @@ static void usb_gpib_disable_eos(gpib_board_t *board)
  *
  */
 
-static int usb_gpib_enable_eos(gpib_board_t *board,
+static int usb_gpib_enable_eos(struct gpib_board *board,
 			       u8 eos_byte,
 			       int compare_8_bits)
 {
@@ -606,7 +606,7 @@ static int usb_gpib_enable_eos(gpib_board_t *board,
  * @board:    the gpib_board data area for this gpib interface
  */
 
-static int usb_gpib_go_to_standby(gpib_board_t *board)
+static int usb_gpib_go_to_standby(struct gpib_board *board)
 {
 	int retval = set_control_line(board, IB_BUS_ATN, 0);
 
@@ -628,7 +628,7 @@ static int usb_gpib_go_to_standby(gpib_board_t *board)
  *    the de-assert request.
  */
 
-static void usb_gpib_interface_clear(gpib_board_t *board, int assert)
+static void usb_gpib_interface_clear(struct gpib_board *board, int assert)
 {
 	int retval = 0;
 
@@ -655,7 +655,7 @@ static void usb_gpib_interface_clear(gpib_board_t *board, int assert)
 #define WQH head
 #define WQE entry
 
-static int usb_gpib_line_status(const gpib_board_t *board)
+static int usb_gpib_line_status(const struct gpib_board *board)
 {
 	int buffer;
 	int line_status = VALID_ALL;   /* all lines will be read */
@@ -686,7 +686,7 @@ static int usb_gpib_line_status(const gpib_board_t *board)
 		msleep(sleep);
 	}
 
-	buffer = send_command((gpib_board_t *)board, USB_GPIB_STATUS, 0);
+	buffer = send_command((struct gpib_board *)board, USB_GPIB_STATUS, 0);
 
 	if (buffer < 0) {
 		dev_err(board->gpib_dev, "line status read failed with %d\n", buffer);
@@ -717,7 +717,7 @@ static int usb_gpib_line_status(const gpib_board_t *board)
 
 /* parallel_poll */
 
-static int usb_gpib_parallel_poll(gpib_board_t *board, uint8_t *result)
+static int usb_gpib_parallel_poll(struct gpib_board *board, uint8_t *result)
 {
 	/* request parallel poll asserting ATN | EOI;
 	 * we suppose ATN already asserted
@@ -744,7 +744,7 @@ static int usb_gpib_parallel_poll(gpib_board_t *board, uint8_t *result)
 
 /* read */
 
-static int usb_gpib_read(gpib_board_t *board,
+static int usb_gpib_read(struct gpib_board *board,
 			 u8 *buffer,
 			 size_t length,
 			 int *end,
@@ -908,7 +908,7 @@ static int usb_gpib_read(gpib_board_t *board,
 
 /* remote_enable */
 
-static void usb_gpib_remote_enable(gpib_board_t *board, int enable)
+static void usb_gpib_remote_enable(struct gpib_board *board, int enable)
 {
 	int retval;
 
@@ -921,7 +921,7 @@ static void usb_gpib_remote_enable(gpib_board_t *board, int enable)
 
 /* request_system_control */
 
-static void usb_gpib_request_system_control(gpib_board_t *board,
+static void usb_gpib_request_system_control(struct gpib_board *board,
 					    int request_control)
 {
 	if (request_control)
@@ -935,7 +935,7 @@ static void usb_gpib_request_system_control(gpib_board_t *board,
 /* take_control */
 /* beware: the sync flag is ignored; what is its real meaning? */
 
-static int usb_gpib_take_control(gpib_board_t *board, int sync)
+static int usb_gpib_take_control(struct gpib_board *board, int sync)
 {
 	int retval;
 
@@ -950,7 +950,7 @@ static int usb_gpib_take_control(gpib_board_t *board, int sync)
 
 /* update_status */
 
-static unsigned int usb_gpib_update_status(gpib_board_t *board,
+static unsigned int usb_gpib_update_status(struct gpib_board *board,
 					   unsigned int clear_mask)
 {
 	/* There is nothing we can do here, I guess */
@@ -965,7 +965,7 @@ static unsigned int usb_gpib_update_status(gpib_board_t *board,
 /* write */
 /* beware: DLE characters are not escaped - can only send ASCII data */
 
-static int usb_gpib_write(gpib_board_t *board,
+static int usb_gpib_write(struct gpib_board *board,
 			  u8 *buffer,
 			  size_t length,
 			  int send_eoi,
@@ -1008,33 +1008,33 @@ static int usb_gpib_write(gpib_board_t *board,
 
 /* parallel_poll configure */
 
-static void usb_gpib_parallel_poll_configure(gpib_board_t *board,
+static void usb_gpib_parallel_poll_configure(struct gpib_board *board,
 					     uint8_t configuration)
 {
 }
 
 /* parallel_poll_response */
 
-static void usb_gpib_parallel_poll_response(gpib_board_t *board, int ist)
+static void usb_gpib_parallel_poll_response(struct gpib_board *board, int ist)
 {
 }
 
 /* primary_address */
 
-static int  usb_gpib_primary_address(gpib_board_t *board, unsigned int address)
+static int  usb_gpib_primary_address(struct gpib_board *board, unsigned int address)
 {
 	return 0;
 }
 
 /* return_to_local */
 
-static	void usb_gpib_return_to_local(gpib_board_t *board)
+static	void usb_gpib_return_to_local(struct gpib_board *board)
 {
 }
 
 /* secondary_address */
 
-static int usb_gpib_secondary_address(gpib_board_t *board,
+static int usb_gpib_secondary_address(struct gpib_board *board,
 				      unsigned int address,
 				      int enable)
 {
@@ -1043,20 +1043,20 @@ static int usb_gpib_secondary_address(gpib_board_t *board,
 
 /* serial_poll_response */
 
-static void usb_gpib_serial_poll_response(gpib_board_t *board, uint8_t status)
+static void usb_gpib_serial_poll_response(struct gpib_board *board, uint8_t status)
 {
 }
 
 /* serial_poll_status */
 
-static uint8_t usb_gpib_serial_poll_status(gpib_board_t *board)
+static uint8_t usb_gpib_serial_poll_status(struct gpib_board *board)
 {
 	return 0;
 }
 
 /* t1_delay */
 
-static unsigned int usb_gpib_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static unsigned int usb_gpib_t1_delay(struct gpib_board *board, unsigned int nano_sec)
 {
 	return 0;
 }
@@ -1295,7 +1295,7 @@ static void skel_delete(struct kref *kref)
  *   skel_do_open() - to be called by usb_gpib_attach
  */
 
-static int skel_do_open(gpib_board_t *board, int subminor)
+static int skel_do_open(struct gpib_board *board, int subminor)
 {
 	struct usb_skel *dev;
 	struct usb_interface *interface;
@@ -1332,7 +1332,7 @@ static int skel_do_open(gpib_board_t *board, int subminor)
  *   skel_do_release() - to be called by usb_gpib_detach
  */
 
-static int skel_do_release(gpib_board_t *board)
+static int skel_do_release(struct gpib_board *board)
 {
 	struct usb_skel *dev;
 
-- 
2.43.0


