Return-Path: <linux-kernel+bounces-384304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 759439B2913
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72B31C215B3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85C71D6DA9;
	Mon, 28 Oct 2024 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cN/EetKn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A5lin1M5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48251D3187
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100891; cv=none; b=dym8WpUAQstQIlBm1UG6MJ7w16MkoNgBhh5TTJEIBdnnHxBGuH+Sg47GFLTEjcpgyjFlA1mQyXzkKBoTbKL+PGeACCzB+R9mPutFGgCrkN6D7CQjD5eyX5zGYJHWg/y/O7Hhm34xty+eBjRn0RZjMUu9/m48D3HXYolmhpUQgj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100891; c=relaxed/simple;
	bh=KbPFQP63/ovAgqBdm7wnwSuk1n+U+vQAA9GyfG0Q04o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zhqzvq09GPwaSexHqlX/Uwxv71+Lnf7ibmFCeQl55FT+AhrXCcmdzkX/oH7S1C3ETc4/cSif8EAji0xuLawOKy64qSh0CkV1yDLdJ/WQz63zv1YiiOtZv5WCvmxY9ITI+i1aOyTbwXTPO27wJIoEIfRoIIsNUwonBgceRDpS3K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cN/EetKn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A5lin1M5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7qiAY8VJqUm2qD8urA303ZZHGYQFyPGELI3HR/BMzg=;
	b=cN/EetKnFGkXPnqcP21zVx17pXJ1ewThskU9/HS/TrZgZgmLwLTrCwSTnwxUSXTn8nrr4V
	zaMmA4z/NthmO54udTfKlAa+HpSHDukFmfxfvdnQwJHnSePPPJsklCw8wO+iCsKV+M459p
	03vOijTObA+h15PFW3CBprUzRW8EUhxqZnKGr8Xpf/Yfx+IaPYdVczCHwW0tM+lAi6hF7J
	qFwB6A1Xxa8gW6XLkGTcl082J0QIxUriPX4H7AQ8rfXz8CH55nsvMsBQFf6CanpXjFSUeN
	aLaVlJmrSUTwyzIO+pCxQ7TTmJhr1HpSXgpgDgIISmcrHN5i21OHu5WimvWzrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7qiAY8VJqUm2qD8urA303ZZHGYQFyPGELI3HR/BMzg=;
	b=A5lin1M56QDJMrxk0m9zJm0yQ6Gj7lhW14vUK+7UCUtxan2UfQyNLtF5ARFjjKldgZ/WJV
	8HKgHI9/Dn58uaBA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 06/24] can: mcp251xfd: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:19 +0100
Message-Id: <e84e3b89e4e023743b4e599959e5efb6937803f0.1729865232.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865232.git.namcao@linutronix.de>
References: <cover.1729865232.git.namcao@linutronix.de>
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
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/c=
an/spi/mcp251xfd/mcp251xfd-ring.c
index 83c18035b2a2..de2ae204beaa 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -539,11 +539,11 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 	}
 	priv->rx_ring_num =3D i;
=20
-	hrtimer_init(&priv->rx_irq_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	priv->rx_irq_timer.function =3D mcp251xfd_rx_irq_timer;
+	hrtimer_setup(&priv->rx_irq_timer, mcp251xfd_rx_irq_timer, CLOCK_MONOTONI=
C,
+		      HRTIMER_MODE_REL);
=20
-	hrtimer_init(&priv->tx_irq_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	priv->tx_irq_timer.function =3D mcp251xfd_tx_irq_timer;
+	hrtimer_setup(&priv->tx_irq_timer, mcp251xfd_tx_irq_timer, CLOCK_MONOTONI=
C,
+		      HRTIMER_MODE_REL);
=20
 	return 0;
 }
--=20
2.39.5


