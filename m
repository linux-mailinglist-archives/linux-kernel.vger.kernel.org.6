Return-Path: <linux-kernel+bounces-514881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D49A35CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1344E16E65E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023AF264A80;
	Fri, 14 Feb 2025 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQcNNmQ9"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB71263C73
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533667; cv=none; b=qBLIoRczogikqENgDhmZFBao5iJ48kvJybH45FilSGDqq+CE7E1hpGYtmBQtDhpxs9nvt3ZKhy4omZ6PydrUjmu3dxASRVh5qiaJ6OV3uHi1KG75jxxghwiDdEzBtjj5h7eDyJKvOuiPfchJ9GWsSqFTXWoN+pMYvy7zTGY0VZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533667; c=relaxed/simple;
	bh=tohAi5nBFkHj/tAgmQNpX3rhDfpyKrO/zJJ46ZJn49E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwtUc4K8vHnXxTMKVO7PwVobw/hzXVjHVcpUJHKgOuX2Q/MtbY7LZ1e7qkrA0s2ZTAZqRbFAfgwUTqPyJROpp256J1RsC/xMI5wtBW1RZqb//z2W9JbaOvUDI9tLwKZ2JQGcu2gIVmkm6xokzOr81vNYthrJPO/YvRJ98nLh2qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQcNNmQ9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f2cb1ba55so518929f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533663; x=1740138463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTJq08jTmKdGfD1Y04JBtH26qiXRl5lyzw01SEJq/fg=;
        b=EQcNNmQ9WsSAtEJqi3UhgHKqo2zzziTevc5GUnpijZazxvdIydENyRDtTiMTJ6uYjx
         QOY4iQsoPMegAqnSaSLRvhNTwruV1ACLdgtczvtN7frhqTsTCTuE1ggO8/AcZZvV/Nri
         nc2egdVcFmGt4wu3kN0h/N0K+g4NeHKT/HWimDn8djo4eazHLQcMg2mx/7nzs8i2GYOK
         KCMBTeobzL9m+Sp6WYO1QVP/MjHPtHmEb9YWBGfG2dwRNkSWuVSz7IiXJykZLrRSUYLI
         19aqRUyqpgGA01TEz7Tx+Ni8u41qpBi8GpH7P4JZwLdPojkSS6wYzVi5vAfMPDBzzhjE
         xXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533663; x=1740138463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTJq08jTmKdGfD1Y04JBtH26qiXRl5lyzw01SEJq/fg=;
        b=RM10LsYNFmKjsB58P2DJDsuG3NRoW9H1654uU41Iznc0Zy8dd3b+fqu3KK8H4/6yzV
         imulSykWHQrqVi5kV6UtafHzSnLuiI9m3x2/JX6fWyRewMfHjoNFT2LW5DV40xEztc8E
         PA6RahmxlrcvFly1P69TJgGTMEIH7VbNr+keZrN+70r5tkhs6/A1sB++BYZanL9+0fqq
         QE1nExNr+dhIGaVueQ6wy6OkrHhgCX/fdTafkG9OOjH3oaozUGV6mdQYqcnm976/gEds
         CTgxP0IwYblKXROWCdqKiTRwplQNkC0KVhNlvC5Y8J0tvofUsobtiMz0byVzzkUjwk6H
         R6nw==
X-Forwarded-Encrypted: i=1; AJvYcCWuqR+oLnri6E1rvyVLNjMlTgb5Ic4Au0VUPwJCWYFqtH2JgIjeaLeZBhwG/jT7tRysk8XK3FArdtWLB54=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBf9CDKDA7i4wXrnycwXZrkLH+FBteyQPqdoBSbIwLXs7Acfuc
	SoU2AL5O9g7Jvi3dz1BPGm4MUz1dqwaZ0J3CCk6Mp5FzpeCwusuzSCYXPw==
X-Gm-Gg: ASbGncvRub0pTjxpzaph3WEeVr3X0RBemdSSOQ0qdPLyaGoBqc3CSts+S3GLZhoWOAR
	BFfheHIhmfTxXK8aAWhMEEJedEJxIRSswGNexZsksmXGBW5SJk9qOKV86jNm84LU2PnlpWx2NIA
	hosxpjLTTLvZ1HGiz1UOP4LQd4WsO1aJ61cjz1AWMvAUE/np2dq60TuT2G5Y5uDTGK11lx6NtSf
	kc4mOXlUwL5t1sGvBLh75sgwJQqkVmJDIvZ9UIEAFq/lUBj54tbQeCcLkoshptEXpc1bqRtOcCu
	PBlirK3UyNqD3Cv7U3DQfHvLvMc2oifGw5qRFozKCdzoZHHP9S4=
X-Google-Smtp-Source: AGHT+IH3wicaWkeg29PW3y29BTX1IqB2mNLTjCCohqYxqTgqaedsp7JwXU3vPw0NBa0TmTQN+0R5ZA==
X-Received: by 2002:a05:6000:18ab:b0:38f:276a:1662 with SMTP id ffacd0b85a97d-38f276a1705mr8044195f8f.13.1739533662814;
        Fri, 14 Feb 2025 03:47:42 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617fccfesm41945245e9.11.2025.02.14.03.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:47:42 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 08/17] staging: gpib: gpio bitbang console messaging cleanup
Date: Fri, 14 Feb 2025 12:46:59 +0100
Message-ID: <20250214114708.28947-9-dpenkler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214114708.28947-1-dpenkler@gmail.com>
References: <20250214114708.28947-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable module name to be printed in pr_xxx and dev_xxx

Change pr_info in the dbg_printk macro to dev_dbg.

In order for dbg_printk macro to have the board variable
defined the signatures and calls to bb_buffer_print and
set_atn were changed to include board as a parameter.

Remove the #ifdef CONFIG_GPIB_DEBUG code.

Remove commented dbk_printk's.

Change dbg_printk(0, to dev_err where an error message is needed.

Remove dbg_printk for "not implemented" functions.

Remove "gpib_bitbang:" prefix in pr_err as it will be printed
with the module name.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/gpio/gpib_bitbang.c | 56 ++++++++++--------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 828c99ea613f..2012db188f58 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -25,6 +25,8 @@
  *	device support (non master operation)
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt pr_fmt
 #define NAME KBUILD_MODNAME
 
 #define ENABLE_IRQ(IRQ, TYPE) irq_set_irq_type(IRQ, TYPE)
@@ -41,7 +43,7 @@
  */
 #define dbg_printk(level, frm, ...)					\
 	do { if (debug >= (level))					\
-			pr_info("%s:%s - " frm, NAME, __func__, ## __VA_ARGS__); } \
+			dev_dbg(board->gpib_dev, frm, ## __VA_ARGS__); } \
 	while (0)
 
 #define LINVAL gpiod_get_value(DAV),		\
@@ -316,13 +318,14 @@ struct bb_priv {
 };
 
 static inline long usec_diff(struct timespec64 *a, struct timespec64 *b);
-static void bb_buffer_print(unsigned char *buffer, size_t length, int cmd, int eoi);
+static void bb_buffer_print(gpib_board_t *board, unsigned char *buffer, size_t length,
+			    int cmd, int eoi);
 static void set_data_lines(u8 byte);
 static u8 get_data_lines(void);
 static void set_data_lines_input(void);
 static void set_data_lines_output(void);
 static inline int check_for_eos(struct bb_priv *priv, uint8_t byte);
-static void set_atn(struct bb_priv *priv, int atn_asserted);
+static void set_atn(gpib_board_t *board, int atn_asserted);
 
 static inline void SET_DIR_WRITE(struct bb_priv *priv);
 static inline void SET_DIR_READ(struct bb_priv *priv);
@@ -334,11 +337,7 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("GPIB helper functions for bitbanging I/O");
 
 /****  global variables	 ****/
-#ifdef CONFIG_GPIB_DEBUG
-static int debug = 1;
-#else
 static int debug;
-#endif
 module_param(debug, int, 0644);
 
 static char printable(char x)
@@ -508,7 +507,7 @@ static int bb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 		   board, mutex_is_locked(&board->user_mutex), length);
 
 	if (debug > 1)
-		bb_buffer_print(buffer, length, priv->cmd, send_eoi);
+		bb_buffer_print(board, buffer, length, priv->cmd, send_eoi);
 	priv->count = 0;
 	priv->phase = 300;
 
@@ -550,7 +549,6 @@ static int bb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 			dbg_printk(1, "timeout after %zu/%zu at %d " LINFMT " eoi: %d\n",
 				   priv->w_cnt, length, priv->phase, LINVAL, send_eoi);
 		} else {
-			// dbg_printk(1,"written %zu\n", priv->w_cnt);
 			retval = priv->w_cnt;
 		}
 	} else {
@@ -811,7 +809,8 @@ static char *cmd_string[32] = {
 	"CFE"  // 0x1f
 };
 
-static void bb_buffer_print(unsigned char *buffer, size_t length, int cmd, int eoi)
+static void bb_buffer_print(gpib_board_t *board, unsigned char *buffer, size_t length,
+			    int cmd, int eoi)
 {
 	int i;
 
@@ -843,11 +842,13 @@ static void bb_buffer_print(unsigned char *buffer, size_t length, int cmd, int e
  * STATUS Management							   *
  *									   *
  ***************************************************************************/
-static void set_atn(struct bb_priv *priv, int atn_asserted)
+static void set_atn(gpib_board_t *board, int atn_asserted)
 {
+	struct bb_priv *priv = board->private_data;
+
 	if (priv->listener_state != listener_idle &&
 	    priv->talker_state != talker_idle) {
-		dbg_printk(0, "listener/talker state machine conflict\n");
+		dev_err(board->gpib_dev, "listener/talker state machine conflict\n");
 	}
 	if (atn_asserted) {
 		if (priv->listener_state == listener_active)
@@ -869,7 +870,7 @@ static void set_atn(struct bb_priv *priv, int atn_asserted)
 static int bb_take_control(gpib_board_t *board, int synchronous)
 {
 	dbg_printk(2, "%d\n", synchronous);
-	set_atn(board->private_data, 1);
+	set_atn(board, 1);
 	set_bit(CIC_NUM, &board->status);
 	return 0;
 }
@@ -877,7 +878,7 @@ static int bb_take_control(gpib_board_t *board, int synchronous)
 static int bb_go_to_standby(gpib_board_t *board)
 {
 	dbg_printk(2, "\n");
-	set_atn(board->private_data, 0);
+	set_atn(board, 0);
 	return 0;
 }
 
@@ -988,13 +989,11 @@ static int bb_secondary_address(gpib_board_t *board, unsigned int address, int e
 
 static int bb_parallel_poll(gpib_board_t *board, uint8_t *result)
 {
-	dbg_printk(1, "%s\n", "not implemented");
-	return -EPERM;
+	return -ENOENT;
 }
 
 static void bb_parallel_poll_configure(gpib_board_t *board, uint8_t config)
 {
-	dbg_printk(1, "%s\n", "not implemented");
 }
 
 static void bb_parallel_poll_response(gpib_board_t *board, int ist)
@@ -1003,13 +1002,11 @@ static void bb_parallel_poll_response(gpib_board_t *board, int ist)
 
 static void bb_serial_poll_response(gpib_board_t *board, uint8_t status)
 {
-	dbg_printk(1, "%s\n", "not implemented");
 }
 
 static uint8_t bb_serial_poll_status(gpib_board_t *board)
 {
-	dbg_printk(1, "%s\n", "not implemented");
-	return 0; // -ENOSYS;
+	return 0; // -ENOENT;
 }
 
 static unsigned int bb_t1_delay(gpib_board_t *board,  unsigned int nano_sec)
@@ -1030,15 +1027,12 @@ static unsigned int bb_t1_delay(gpib_board_t *board,  unsigned int nano_sec)
 
 static void bb_return_to_local(gpib_board_t *board)
 {
-	dbg_printk(1, "%s\n", "not implemented");
 }
 
 static int bb_line_status(const gpib_board_t *board)
 {
 	int line_status = ValidALL;
 
-//	  dbg_printk(1,"\n");
-
 	if (gpiod_get_value(REN) == 0)
 		line_status |= BusREN;
 	if (gpiod_get_value(IFC) == 0)
@@ -1091,11 +1085,11 @@ static int bb_get_irq(gpib_board_t *board, char *name,
 	*irq = gpiod_to_irq(gpio);
 	dbg_printk(2, "IRQ %s: %d\n", name, *irq);
 	if (*irq < 0) {
-		dbg_printk(0, "gpib: can't get IRQ for %s\n", name);
+		dev_err(board->gpib_dev, "can't get IRQ for %s\n", name);
 		return -1;
 	}
 	if (request_threaded_irq(*irq, handler, thread_fn, flags, name, board)) {
-		dbg_printk(0, "gpib: can't request IRQ for %s %d\n", name, *irq);
+		dev_err(board->gpib_dev, "can't request IRQ for %s %d\n", name, *irq);
 		*irq = 0;
 		return -1;
 	}
@@ -1163,8 +1157,8 @@ static int allocate_gpios(gpib_board_t *board)
 				gpiod_add_lookup_table(lookup_table);
 				goto try_again;
 			}
-			dbg_printk(0, "Unable to obtain gpio descriptor for pin %d error %ld\n",
-				   gpios_vector[j], PTR_ERR(desc));
+			dev_err(board->gpib_dev, "Unable to obtain gpio descriptor for pin %d error %ld\n",
+				gpios_vector[j], PTR_ERR(desc));
 			error = true;
 			break;
 		}
@@ -1253,7 +1247,7 @@ static int bb_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		gpios_vector[&(DC)  - &all_descriptors[0]] = -1;
 		gpios_vector[&(ACT_LED)	 - &all_descriptors[0]] = -1;
 	} else {
-		dbg_printk(0, "Unrecognized pin mapping.\n");
+		dev_err(board->gpib_dev, "Unrecognized pin map %s\n", pin_map);
 		goto bb_attach_fail;
 	}
 	dbg_printk(0, "Using pin map \"%s\" %s\n", pin_map, (sn7516x) ?
@@ -1344,19 +1338,15 @@ static int __init bb_init_module(void)
 	int result = gpib_register_driver(&bb_interface, THIS_MODULE);
 
 	if (result) {
-		pr_err("gpib_bitbang: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		return result;
 	}
 
-	dbg_printk(0, "module loaded with pin map \"%s\"%s\n",
-		   pin_map, (sn7516x_used) ? " and SN7516x driver support" : "");
 	return 0;
 }
 
 static void __exit bb_exit_module(void)
 {
-	dbg_printk(0, "module unloaded!");
-
 	gpib_unregister_driver(&bb_interface);
 }
 
-- 
2.48.1


