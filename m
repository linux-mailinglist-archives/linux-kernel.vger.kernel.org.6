Return-Path: <linux-kernel+bounces-384369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24E89B2956
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348991C218DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A4D204F81;
	Mon, 28 Oct 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XIqkwEHi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rcpBA6L+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9BF20265F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100953; cv=none; b=QSm2GgrupRbpUjgVD9/5b3L2KWXL5nYDDzyY+T459dK6cIxMDdI64Yc1utB8l7G8l5C3nSHth1/30peskFAWpMoAs1TLc49xX5km1honQ671CGA2d2c0SK0u0TYu5M/4qDJOHOse3141W6JpWqszTkuFEAKH4hlWTmg3fr5dLxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100953; c=relaxed/simple;
	bh=hoyqZIZCv5MJ7Kj0VkxJqB9LMUHDHxf67C5AktmKBRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQJviinN5jpsHfbwNBCDCZDQdXa06acaKd/Nvdm2ashDm3yfPMkM3/oErMB2SR0gIRxexXX9+ASNOitJhOJVcH0L01r6hkNdiCPQHqI7+cZRm0vRGAtZG1atpwUDcY6xIEUTDYR3BBKW520OwUQVZIgGF9rjMCVLhXJLaZJhGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XIqkwEHi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rcpBA6L+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x01u9Fk/s1XQy+TFU41e2Vj5FMlNRRmu2G+U5PHZCso=;
	b=XIqkwEHiEZZS/qpHeHInLKTuIFASwpf/5Q/t9dyaIFmepBnhIM9WrBaqoG7lPOvEXmpIO2
	AFzQC6+2werpJKaB2HroZqfyOKzKiH8HHb6MtgeEbVJJHZQnXxgV+8p5IFK5/0ud1cZpaB
	sfqnZws8jefXrcFIUmOjcnxqCRBnl0wGaj2hDSjHEznKTlHHkMnq7JMv02ZBldSmu0NqXW
	lN9KDRJDioB/PdoQamXr7jdAlu/hp7MUIMWJ7YEL9GSFV4oCjSjiDSWs/D5xq441+JdM9G
	5TSVUFb55RhIDwa9xvLnk12OI943WcsL6x0QmKzvQEtzyQEMl2f38cTNO39A8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x01u9Fk/s1XQy+TFU41e2Vj5FMlNRRmu2G+U5PHZCso=;
	b=rcpBA6L+GCROq36zxZ0PKEuewfntB8JkQ/4IHiQgKqmqKUo2+RqL+AFt8TbomPR2x0iOm3
	wZrn9wiax4n2y2Bw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH 42/44] pwm: gpio: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:18 +0100
Message-Id: <9f43677f484a559c36fd4fd9b1dd3cef0d4b20b4.1729865485.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865485.git.namcao@linutronix.de>
References: <cover.1729865485.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

There is a newly introduced hrtimer_setup() which will replace
hrtimer_init(). This new function is similar to the old one, except that it
also sanity-checks and initializes the timer's callback function.

Switch to use this new function.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: "Uwe Kleine-K=C3=B6nig" <ukleinek@kernel.org>
---
 drivers/pwm/pwm-gpio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-gpio.c b/drivers/pwm/pwm-gpio.c
index 9f8884ac7504..5f4edeb394a9 100644
--- a/drivers/pwm/pwm-gpio.c
+++ b/drivers/pwm/pwm-gpio.c
@@ -207,13 +207,12 @@ static int pwm_gpio_probe(struct platform_device *pde=
v)
 	chip->ops =3D &pwm_gpio_ops;
 	chip->atomic =3D true;
=20
-	hrtimer_init(&gpwm->gpio_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_setup(&gpwm->gpio_timer, pwm_gpio_timer, CLOCK_MONOTONIC, HRTIMER=
_MODE_REL);
+
 	ret =3D devm_add_action_or_reset(dev, pwm_gpio_disable_hrtimer, gpwm);
 	if (ret)
 		return ret;
=20
-	gpwm->gpio_timer.function =3D pwm_gpio_timer;
-
 	ret =3D pwmchip_add(chip);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "could not add pwmchip\n");
--=20
2.39.5


