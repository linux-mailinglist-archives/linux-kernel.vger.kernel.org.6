Return-Path: <linux-kernel+bounces-384331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8091C9B2931
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457642826F5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C5B1EF959;
	Mon, 28 Oct 2024 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kp46gt7G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S4FXGH7Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A5E1D8E12
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100939; cv=none; b=tku+Q1wiUcIOeTVj11GOyoyQCg+fhLQsCXMleZMm97Y6WJpBzvU8dCpHCdZc2Ye1K/qsCYANG3L9XOcPv+jc+X4thFO31qc0n52KhicIM1b01DD4JEo/b3hznLMPWC1GSVBJyNJsXNdw1DBUPz1M1byg85S6MRV/lY3Z05YTIDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100939; c=relaxed/simple;
	bh=UWtNd6X90JFlmzOQaxaeH0W1A6Y1qf7ydVJb2UDlJW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZVD6OMo4RKhNQt6gDxU1TK7BHW8/we/jqeBsWEN/Du+OcAQ+Oy/Z9CW2WUTR36k5OK/Bu7CDbI2ad5EDjFJRLd5sA09m0sk1uxHCZu5HDR8xM2ebqMyD4S4QQXl1cDTeWrromJFkiKUXxq1HHwKf9KTwdI9sw1+VrEtz3JemmlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kp46gt7G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S4FXGH7Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DE5x6gmEAuO/dXtOClYJ59fHqtORiAXE5xfwUqoTonU=;
	b=Kp46gt7G24LoHz8Ebzs9X2BSriwr0zjq31qrjgHiO5sk4tAHs+6GjRo24GhmILG2oEYUk/
	9bRN/JpUlqRf/bSIImqdnHYJYHRAU/BOaSZMuiklnvFMfjWqW9aMaq2h88uEUq58+P8+tX
	d5xJSL4fzEm7cbMdolNO9BVlUWAGCKwqRWi+jV8gQ7+ksDGm6xZ6EMo1fF1/WeJXLfHzWX
	xyl81M4Ap5XK7bkS4c7LR3B13JDRLN5yLsk4kxKk/5HHoZQAptwJ3KZhTH4w9eIubjhb76
	oS70yF5dIbmixsQ9f2pjlAEvv6aSWFbqRzVMjmbtOkAi1tBn31574EIY27I+kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DE5x6gmEAuO/dXtOClYJ59fHqtORiAXE5xfwUqoTonU=;
	b=S4FXGH7ZiuqQoCxgjsNHabu1JdED+DBw/XDoodWYLOqKyMQPMfLRKMluV/PXi9Z6el9GsM
	VUQY3MKeKt5xT7Ag==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 08/44] serial: 8250: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:44 +0100
Message-Id: <54c77747be2b79062970d874bd8003bd47096d70.1729865485.git.namcao@linutronix.de>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_bcm7271.c |  3 +--
 drivers/tty/serial/8250/8250_port.c    | 10 ++++------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/82=
50/8250_bcm7271.c
index 2569ca69223f..766bbdb36d19 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1056,8 +1056,7 @@ static int brcmuart_probe(struct platform_device *pde=
v)
 	}
=20
 	/* setup HR timer */
-	hrtimer_init(&priv->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	priv->hrt.function =3D brcmuart_hrtimer_func;
+	hrtimer_setup(&priv->hrt, brcmuart_hrtimer_func, CLOCK_MONOTONIC, HRTIMER=
_MODE_ABS);
=20
 	up.port.shutdown =3D brcmuart_shutdown;
 	up.port.startup =3D brcmuart_startup;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/=
8250_port.c
index 3509af7dc52b..36820eed535a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -546,12 +546,10 @@ static int serial8250_em485_init(struct uart_8250_por=
t *p)
 	if (!p->em485)
 		return -ENOMEM;
=20
-	hrtimer_init(&p->em485->stop_tx_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	hrtimer_init(&p->em485->start_tx_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	p->em485->stop_tx_timer.function =3D &serial8250_em485_handle_stop_tx;
-	p->em485->start_tx_timer.function =3D &serial8250_em485_handle_start_tx;
+	hrtimer_setup(&p->em485->stop_tx_timer, &serial8250_em485_handle_stop_tx,=
 CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
+	hrtimer_setup(&p->em485->start_tx_timer, &serial8250_em485_handle_start_t=
x, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	p->em485->port =3D p;
 	p->em485->active_timer =3D NULL;
 	p->em485->tx_stopped =3D true;
--=20
2.39.5


