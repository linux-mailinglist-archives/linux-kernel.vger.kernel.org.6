Return-Path: <linux-kernel+bounces-274078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E424B947327
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D016E1C20E64
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 01:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519DA3B29D;
	Mon,  5 Aug 2024 01:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXCzPccp"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB825740;
	Mon,  5 Aug 2024 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722822444; cv=none; b=BiYth5Efx8lYHaKGubG1tfPMyynGoBkxQ23gQCEJPE2i2TIam9IX91J5VBT9s2UPX1rlydVlflhF9F6eRjWoLMMU6bExi+/1tVVs4DtxHRIUm2i25KYgJ7U2CsHjBHQ0DQCkXP8CPCJjQgOa0r7KyMJ5sxxjWRiiKO+WNI6ndvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722822444; c=relaxed/simple;
	bh=DeHDe8MfsNlJ9sfFT8ATjD03GaPBravxSwhN/0wMOTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGK34RDcuANQvqfB2SlTgu8/9soD31AoYRutsnmFaQxY2w5fvDFO8m8nq3fRlJQTX7auEvM9ezh/rJYPz4grvjBYQ3DgCxn9trLaS+y7IgrGjwkoenR5qH98l9e3bg5OJ0eakw5pPuM3ALLqaX7DGunc+6CdxB1n3giu4deIET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXCzPccp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc47abc040so64948535ad.0;
        Sun, 04 Aug 2024 18:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722822442; x=1723427242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwJabViyOwOqlsyuvl72Ko23CJ5ZXu78YeavmKzmGHg=;
        b=DXCzPccpCVmoHN0IPqDC4iUOWlnCdmaiWb08wIDknhYNS4x0oVQAmPv7yjKxwkRyDX
         AaoBaRl4Zz7EShKVtAetI9OV4s5SMim0bau7ewDdMzSiEVyYcmzb9KU9IyLQtOC9SA4v
         ngFvgneDUpSZUMccUjASD82oWioOzKdByADMuz83s/ofChQaymcl7Z50OvQSmUjX6DJI
         YJvrEc42T3l9zAFWC3BuMIGqv9nI/s5ZzVOPkc1KfnPdR3QlZKzVHkCQBT9zZXooA5S6
         9gLiyjfoIUbA0/dLSuO3+3HXGty+XN6KcTeXLq/V6Bx9PtcmvNSZ1G7eEw/jc4PoFYe9
         UPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722822442; x=1723427242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwJabViyOwOqlsyuvl72Ko23CJ5ZXu78YeavmKzmGHg=;
        b=FXI5fhd86IvMaHp3ad9wH7usqB78421YXdwKCGdbprDAKeFx29Soiyr8grF9ThgN+e
         hQPGfPrZyoKLafBJl4xa9goJ+iqdBeUYB9WpxADCjHqVtdi/pfMR3c6Q3Qax5gtrUW6N
         1L+lFkB8qL3HvNDY3LJixCctWBIpWIcFG7Qfu53+WMdJUCnUPNLUwIE7me9WZ+sSYDwy
         l1lG26QPzfsXiOnnc7tY7IUAM4qembZ9q3fTtMP45zC9KzpiqdUVHL0p7FWGq3G8SD1a
         iWBQvC1TkBIqW46yr9CTTY6unFCpFQxShodA5u4q6kp5JgAp3xBcYCjjPzyCE1e36ZTP
         YDbw==
X-Forwarded-Encrypted: i=1; AJvYcCXys5v2dwGsK6bvHF0PS24ftaLLocvA1kM+eSs2wdmAPPLg5xvUjxvmc2OS8M9iaigvgvce7es8fnpG4DHW1hdkNjk/rd2jHkkilLWPtswFA5O1HuuvQyg6LBQiSICizoJpi/E6xXpfDms=
X-Gm-Message-State: AOJu0Yx+KiKPDv+S9xq55Cl8UP64f6h2yPWPXJZS7+o3oexczFy9NxX7
	ISQ17WztoYRUi8kqCMGKjstKB5ulPy3GOMDKFk2l3zcyeKJaNWZh
X-Google-Smtp-Source: AGHT+IGqwFPnuoOcmLqV0N/ujzd8JY77yP2Twv7LpGxD6AnhEF82wcYDFjWQijLX+wgx8uEDkpH7hg==
X-Received: by 2002:a17:902:db0b:b0:1ff:6715:70f7 with SMTP id d9443c01a7336-1ff67158218mr47347265ad.28.1722822442416;
        Sun, 04 Aug 2024 18:47:22 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:22e4:17a:28a:7497])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59295790sm55836015ad.261.2024.08.04.18.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 18:47:22 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Haojian Zhuang <haojian.zhuang@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	soc@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH 1/5] Input: matrix_keypad - remove support for clustered interrupt
Date: Sun,  4 Aug 2024 18:47:04 -0700
Message-ID: <20240805014710.1961677-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
In-Reply-To: <20240805014710.1961677-1-dmitry.torokhov@gmail.com>
References: <20240805014710.1961677-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no users of this functionality in the mainline kernel (it was
only available to boards using platform data and not device tree).
Remove it to simplify the code.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/matrix_keypad.c | 61 ++++++++++----------------
 1 file changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 7a56f3d3aacd..604e90d13ed0 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -29,7 +29,6 @@ struct matrix_keypad {
 	unsigned int row_shift;
 
 	unsigned int row_irqs[MATRIX_MAX_ROWS];
-	unsigned int num_row_irqs;
 	DECLARE_BITMAP(wakeup_enabled_irqs, MATRIX_MAX_ROWS);
 
 	uint32_t last_key_state[MATRIX_MAX_COLS];
@@ -88,7 +87,7 @@ static void enable_row_irqs(struct matrix_keypad *keypad)
 {
 	int i;
 
-	for (i = 0; i < keypad->num_row_irqs; i++)
+	for (i = 0; i < keypad->pdata->num_row_gpios; i++)
 		enable_irq(keypad->row_irqs[i]);
 }
 
@@ -96,7 +95,7 @@ static void disable_row_irqs(struct matrix_keypad *keypad)
 {
 	int i;
 
-	for (i = 0; i < keypad->num_row_irqs; i++)
+	for (i = 0; i < keypad->pdata->num_row_gpios; i++)
 		disable_irq_nosync(keypad->row_irqs[i]);
 }
 
@@ -225,7 +224,8 @@ static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
 {
 	int i;
 
-	for_each_clear_bit(i, keypad->wakeup_enabled_irqs, keypad->num_row_irqs)
+	for_each_clear_bit(i, keypad->wakeup_enabled_irqs,
+			   keypad->pdata->num_row_gpios)
 		if (enable_irq_wake(keypad->row_irqs[i]) == 0)
 			__set_bit(i, keypad->wakeup_enabled_irqs);
 }
@@ -234,7 +234,8 @@ static void matrix_keypad_disable_wakeup(struct matrix_keypad *keypad)
 {
 	int i;
 
-	for_each_set_bit(i, keypad->wakeup_enabled_irqs, keypad->num_row_irqs) {
+	for_each_set_bit(i, keypad->wakeup_enabled_irqs,
+			 keypad->pdata->num_row_gpios) {
 		disable_irq_wake(keypad->row_irqs[i]);
 		__clear_bit(i, keypad->wakeup_enabled_irqs);
 	}
@@ -302,48 +303,30 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 		gpio_direction_input(pdata->row_gpios[i]);
 	}
 
-	if (pdata->clustered_irq > 0) {
+	for (i = 0; i < pdata->num_row_gpios; i++) {
+		irq = gpio_to_irq(pdata->row_gpios[i]);
+		if (irq < 0) {
+			err = irq;
+			dev_err(&pdev->dev,
+				"Unable to convert GPIO line %i to irq: %d\n",
+				pdata->row_gpios[i], err);
+			return err;
+		}
+
 		err = devm_request_any_context_irq(&pdev->dev,
-				pdata->clustered_irq,
+				irq,
 				matrix_keypad_interrupt,
-				pdata->clustered_irq_flags,
+				IRQF_TRIGGER_RISING |
+					IRQF_TRIGGER_FALLING,
 				"matrix-keypad", keypad);
 		if (err < 0) {
 			dev_err(&pdev->dev,
-				"Unable to acquire clustered interrupt\n");
+				"Unable to acquire interrupt for GPIO line %i\n",
+				pdata->row_gpios[i]);
 			return err;
 		}
 
-		keypad->row_irqs[0] = pdata->clustered_irq;
-		keypad->num_row_irqs = 1;
-	} else {
-		for (i = 0; i < pdata->num_row_gpios; i++) {
-			irq = gpio_to_irq(pdata->row_gpios[i]);
-			if (irq < 0) {
-				err = irq;
-				dev_err(&pdev->dev,
-					"Unable to convert GPIO line %i to irq: %d\n",
-					pdata->row_gpios[i], err);
-				return err;
-			}
-
-			err = devm_request_any_context_irq(&pdev->dev,
-					irq,
-					matrix_keypad_interrupt,
-					IRQF_TRIGGER_RISING |
-						IRQF_TRIGGER_FALLING,
-					"matrix-keypad", keypad);
-			if (err < 0) {
-				dev_err(&pdev->dev,
-					"Unable to acquire interrupt for GPIO line %i\n",
-					pdata->row_gpios[i]);
-				return err;
-			}
-
-			keypad->row_irqs[i] = irq;
-		}
-
-		keypad->num_row_irqs = pdata->num_row_gpios;
+		keypad->row_irqs[i] = irq;
 	}
 
 	/* initialized as disabled - enabled by input->open */
-- 
2.46.0.rc2.264.g509ed76dc8-goog


