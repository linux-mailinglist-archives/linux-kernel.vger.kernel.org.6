Return-Path: <linux-kernel+bounces-384346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0119B2943
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF65E1C217C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48671201249;
	Mon, 28 Oct 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WtW31ZX9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1zInMeUx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE271F7576
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100945; cv=none; b=ajFkxn3WXlXRCWywJyp6x7AOEBr83Ao64d31R1FF4AGVdvpW/8huB3Z8LV3uyu4mmonkwGtxhJzTV6ncx3/RCEta1HgUHY+aCAjBhvo7Rx1hC/krL0S3iUYZuNU6v87S2a9G9rGuur83CjVtFJNVrEbQfg0HDNZ5+h3+2fLm/sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100945; c=relaxed/simple;
	bh=oDeujpoBqZWZizA02W+hknPR2VCps+F+DQ9APeuhWvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GWnyHmZx1fKQ74wPQVFAYwkqJqQVOTQVrRHU7tXTYq1E08BRagYRRD42/qSfXLheQsAJYVI51bgdAI2/FikipdjzYT/fpi8w704iCFH3lMs/e9TcVYaK2k03srMkRAeEh58pMozGjeUzgsM8qSxDK60OVNErd6PjouMjqxMD/AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WtW31ZX9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1zInMeUx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75QZv1QektY+iXyS9vVN8n9LCzJqE7Lsc4cQ8j41z4E=;
	b=WtW31ZX9VzBnBjqla2slWXAsaKpXT1RJ3LXiEtZ8anOYXQjPQzMfYqaD2AUV2pX0C/D6OE
	DqvxPH4dJe7tg7hRtvh292aSA6njAVLKrNdLy0/Ptje7g4Y+K7pgaGwp1/V0H8W2m/46Fk
	SGAjTCw9y2DnuCexafeBoB/dulU1QZ+KIkbGxhSC17VFg041r9SKZ7Q3mLTVAwNQgXMpW4
	Npi+fN5PAURzDrcTg3U/2Mx6EceK/ncEuNaZrIqZPD1yRuGxc5WtXnalVMEcd2MVuuYeBW
	Csrc2m9FbWxby6i+TaieWV227F2jjsrHuW9SC1wla6XASoAUbdWt4MJN6iYXkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75QZv1QektY+iXyS9vVN8n9LCzJqE7Lsc4cQ8j41z4E=;
	b=1zInMeUxCBLvFo4XC6I56e8euEGAnwZLSkRQ465mr9VDjbYF/qQSVE94H4QBNeYiG1DX/I
	saBI/ou6QMEDl/BQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 24/44] leds: trigger: pattern: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:00 +0100
Message-Id: <9e97d867e4a289cd3c7aa081302d439e656f138b.1729865485.git.namcao@linutronix.de>
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
Cc: Pavel Machek <pavel@ucw.cz>
---
 drivers/leds/trigger/ledtrig-pattern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/=
ledtrig-pattern.c
index aad48c2540fc..a594bd5e2233 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -483,8 +483,8 @@ static int pattern_trig_activate(struct led_classdev *l=
ed_cdev)
 	data->led_cdev =3D led_cdev;
 	led_set_trigger_data(led_cdev, data);
 	timer_setup(&data->timer, pattern_trig_timer_function, 0);
-	hrtimer_init(&data->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	data->hrtimer.function =3D pattern_trig_hrtimer_function;
+	hrtimer_setup(&data->hrtimer, pattern_trig_hrtimer_function, CLOCK_MONOTO=
NIC,
+		      HRTIMER_MODE_REL);
 	led_cdev->activated =3D true;
=20
 	if (led_cdev->flags & LED_INIT_DEFAULT_TRIGGER) {
--=20
2.39.5


