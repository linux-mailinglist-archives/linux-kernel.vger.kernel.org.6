Return-Path: <linux-kernel+bounces-384350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746CD9B2942
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E7D1C217CD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41410201118;
	Mon, 28 Oct 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c7HY9wTQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yW99dwKJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378581F9406
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100945; cv=none; b=js0GfLmdllUvDZdEAxh1uUEhm83ijqRZjaW5jkhd4OODf7ZBtpbrXL7Fm5UtwyVytd0sQG23FxFGYi4Brj27FpY/YHLvbx5PHdZ8o/klQ5a8Lh8HHJy5DXpBqyLNUZpPKKhQfGQJpCqy5iuPC6YyiBrllo7cvvaF7saOKPIPFCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100945; c=relaxed/simple;
	bh=/4Nuqcj3kTNRKFyUA6wT7QZz40iowVq9/OLs+YcyEGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eF/7BVT8hXXsSsAxrh1XBl2Nax848aTQJXKG7JL2YsRPyCx17oHAi8g0PTU8u3Yhrn1nG0sm7RuzLgoBZBZN8pv4SwQ+ByS1IHEHoyP0+XYJ+KVRlTrh89SPGmxzzCSwPT14ga9P7gTrtqvHlsMeaR+VUJoPiDqrrUaSDGc9GjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c7HY9wTQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yW99dwKJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ec7C/cA57wjWbNibU2/Vqg9GEPP3jYR70BfJS1OAeY=;
	b=c7HY9wTQ6rrb/VZaMOBjpjLBs4YUCSumOMF9Gjqxr6o6rhYEtRuB90KrV7nQwvACIeqmhp
	PpiFrILdgeaA0xmCjzKvim4tdCKCIh1+j8dRW8ifWZ+T1S5FiCbKMS8NIwu6Oli7BwOwzV
	C1W4iIjUbmoMnwMalsD4KuindBa7SrlmkPDFyZdRlw7lCxDZkkgqMLwnce7RaCW1mgAGq+
	cHLlp1O8t9j31oN5b2lH93J9scufIrivJmPISXNZIFByBje8mtNfJdrdcTsAFIPgvzEGJe
	DVUQGhRSayS1dLM0atl28dkpyMLCX2qM+lsqUdUm5HKv32xS64p7M5PUrelh5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ec7C/cA57wjWbNibU2/Vqg9GEPP3jYR70BfJS1OAeY=;
	b=yW99dwKJBuzX3GCj4h54VNcTImSFtvtMB3lR+bJbeKZqrduLgElYHtfYFhl9IHlAJA/FFp
	IcdDxHKuU0pkIBBQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 25/44] Input: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:01 +0100
Message-Id: <fde9f1aad11bbf87ece3f166b5feda38713c05a2.1729865485.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865485.git.namcao@linutronix.de>
References: <cover.1729865485.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced hrtimer_setup() which will replace
hrtimer_init(). This new function is similar to the old one, except that it
also sanity-checks and initializes the timer's callback function.

Switch to use this new function.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/walkera0701.c |  3 +--
 drivers/input/keyboard/gpio_keys.c   | 10 ++++------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/input/joystick/walkera0701.c b/drivers/input/joystick/=
walkera0701.c
index 59eea813f258..15370fb82317 100644
--- a/drivers/input/joystick/walkera0701.c
+++ b/drivers/input/joystick/walkera0701.c
@@ -232,8 +232,7 @@ static void walkera0701_attach(struct parport *pp)
 		goto err_unregister_device;
 	}
=20
-	hrtimer_init(&w->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	w->timer.function =3D timer_handler;
+	hrtimer_setup(&w->timer, timer_handler, CLOCK_MONOTONIC, HRTIMER_MODE_REL=
);
=20
 	w->input_dev =3D input_allocate_device();
 	if (!w->input_dev) {
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gp=
io_keys.c
index 380fe8dab3b0..224cfd0062a1 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -592,9 +592,8 @@ static int gpio_keys_setup_key(struct platform_device *=
pdev,
=20
 		INIT_DELAYED_WORK(&bdata->work, gpio_keys_gpio_work_func);
=20
-		hrtimer_init(&bdata->debounce_timer,
-			     CLOCK_REALTIME, HRTIMER_MODE_REL);
-		bdata->debounce_timer.function =3D gpio_keys_debounce_timer;
+		hrtimer_setup(&bdata->debounce_timer, gpio_keys_debounce_timer, CLOCK_RE=
ALTIME,
+			      HRTIMER_MODE_REL);
=20
 		isr =3D gpio_keys_gpio_isr;
 		irqflags =3D IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
@@ -630,9 +629,8 @@ static int gpio_keys_setup_key(struct platform_device *=
pdev,
 		}
=20
 		bdata->release_delay =3D button->debounce_interval;
-		hrtimer_init(&bdata->release_timer,
-			     CLOCK_REALTIME, HRTIMER_MODE_REL_HARD);
-		bdata->release_timer.function =3D gpio_keys_irq_timer;
+		hrtimer_setup(&bdata->release_timer, gpio_keys_irq_timer, CLOCK_REALTIME,
+			      HRTIMER_MODE_REL_HARD);
=20
 		isr =3D gpio_keys_irq_isr;
 		irqflags =3D 0;
--=20
2.39.5


