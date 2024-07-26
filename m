Return-Path: <linux-kernel+bounces-263113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1409A93D133
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404B41C20887
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F12B17A58E;
	Fri, 26 Jul 2024 10:29:37 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0EF17A590
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989776; cv=none; b=Dk3vbGcWqxgyask6IJ9NZfGDEoQxNkeggDE6nYaZFQr/wtYEkczGjk50Qg0DwyETOgQn36qecy1vm9+8//twV72JskOUZGHkOAdLQpZSpzNY+awD4YM5xHsXT5YXrNMEGGnrALVoV99BnAGxQJM7vIWiSMlVUswoeEQeQtyWTRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989776; c=relaxed/simple;
	bh=n7kiIQ38MFcTinQvdq7X6fj186s02hw35AiRh/b6lXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mc8s9ZlNIBM5uvFcEXar6zdb3avIeXv8UBhEgzFZM7APmy0MPAs7sEl7AkrQjZ/bW2v+FydaaXCR/E+bAz3+x9ZPWZfc4s5G5X5Iu/hOJmtLXOCjE1cUrh7BDx1IKaI011nIasaGB3gSMUbHh+XkWK1LuElm6q5Ow/BL7zLdGfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp82t1721989668two3r8a0
X-QQ-Originating-IP: cRm4Zkq3759MHVhSZsxaQUepPhgM0cdObXPgPoV19fM=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jul 2024 18:27:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2863466132143720355
From: Qiang Ma <maqianga@uniontech.com>
To: dmitry.torokhov@gmail.com,
	hdegoede@redhat.com
Cc: inux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] Input: atkbd - fix LED state at suspend/resume
Date: Fri, 26 Jul 2024 18:27:30 +0800
Message-Id: <20240726102730.24836-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0

After we turn on the keyboard CAPSL LED and let the system suspend,
the keyboard LED is not off, and the kernel log is as follows:

[  185.987574] i8042: [44060] ed -> i8042 (kbd-data)
[  185.988057] i8042: [44061] ** <- i8042 (interrupt, 0, 1)
[  185.988067] i8042: [44061] 04 -> i8042 (kbd-data)
[  185.988248] i8042: [44061] ** <- i8042 (interrupt, 0, 1)

The log shows that after the command 0xed is sent, the data
sent is 0x04 instead of 0x00.

Solution:
Add a bitmap variable ledon in the atkbd structure, and then set ledon
according to code-value in the event, in the atkbd_set_leds function,
first look at the value of lenon, if it is 0, there is no need to
look at the value of dev->led, otherwise, Need to look at dev->led
to determine the keyboard LED on/off.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 drivers/input/keyboard/atkbd.c | 35 +++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 7f67f9f2946b..27d8f375929e 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -237,6 +237,8 @@ struct atkbd {
 	struct mutex mutex;
 
 	struct vivaldi_data vdata;
+
+	unsigned long ledon[BITS_TO_LONGS(LED_CNT)];
 };
 
 /*
@@ -604,24 +606,34 @@ static int atkbd_set_repeat_rate(struct atkbd *atkbd)
 	return ps2_command(&atkbd->ps2dev, &param, ATKBD_CMD_SETREP);
 }
 
+#define ATKBD_DO_LED_TOGGLE(dev, atkbd, type, v, bits, on)		\
+({									\
+	unsigned char __tmp = 0;					\
+	if (test_bit(LED_##type, atkbd->on))				\
+		__tmp = test_bit(LED_##type, dev->bits) ? v : 0;	\
+	else								\
+		__tmp = 0;						\
+	__tmp;								\
+})
+
 static int atkbd_set_leds(struct atkbd *atkbd)
 {
 	struct input_dev *dev = atkbd->dev;
-	unsigned char param[2];
+	unsigned char param[2] = {0};
 
-	param[0] = (test_bit(LED_SCROLLL, dev->led) ? 1 : 0)
-		 | (test_bit(LED_NUML,    dev->led) ? 2 : 0)
-		 | (test_bit(LED_CAPSL,   dev->led) ? 4 : 0);
+	param[0] = ATKBD_DO_LED_TOGGLE(dev, atkbd, SCROLLL, 1, led, ledon)
+		 | ATKBD_DO_LED_TOGGLE(dev, atkbd, NUML,    2, led, ledon)
+		 | ATKBD_DO_LED_TOGGLE(dev, atkbd, CAPSL,   4, led, ledon);
 	if (ps2_command(&atkbd->ps2dev, param, ATKBD_CMD_SETLEDS))
 		return -1;
 
 	if (atkbd->extra) {
 		param[0] = 0;
-		param[1] = (test_bit(LED_COMPOSE, dev->led) ? 0x01 : 0)
-			 | (test_bit(LED_SLEEP,   dev->led) ? 0x02 : 0)
-			 | (test_bit(LED_SUSPEND, dev->led) ? 0x04 : 0)
-			 | (test_bit(LED_MISC,    dev->led) ? 0x10 : 0)
-			 | (test_bit(LED_MUTE,    dev->led) ? 0x20 : 0);
+		param[1] = ATKBD_DO_LED_TOGGLE(dev, atkbd, COMPOSE, 0x01, led, ledon)
+			 | ATKBD_DO_LED_TOGGLE(dev, atkbd, SLEEP,   0x02, led, ledon)
+			 | ATKBD_DO_LED_TOGGLE(dev, atkbd, SUSPEND, 0x04, led, ledon)
+			 | ATKBD_DO_LED_TOGGLE(dev, atkbd, MISC,    0x10, led, ledon)
+			 | ATKBD_DO_LED_TOGGLE(dev, atkbd, MUTE,    0x20, led, ledon);
 		if (ps2_command(&atkbd->ps2dev, param, ATKBD_CMD_EX_SETLEDS))
 			return -1;
 	}
@@ -695,6 +707,11 @@ static int atkbd_event(struct input_dev *dev,
 	switch (type) {
 
 	case EV_LED:
+		if (value)
+			__set_bit(code, atkbd->ledon);
+		else
+			__clear_bit(code, atkbd->ledon);
+
 		atkbd_schedule_event_work(atkbd, ATKBD_LED_EVENT_BIT);
 		return 0;
 
-- 
2.20.1


