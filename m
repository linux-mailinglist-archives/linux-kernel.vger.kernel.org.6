Return-Path: <linux-kernel+bounces-384312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B14F99B291B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7577728254B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D401DF740;
	Mon, 28 Oct 2024 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0FTdeYzd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CCJWymg5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB911D5AB4
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100894; cv=none; b=KBWCMf+PQCHdrMoyrHPmQdxiUI40TlocRHev+MDHZCOpTzhcHkWuaVrt0y3WxJGc6/4cGcv3OmrP5rZF4BGzx1tnJcInPMb8q52scfKQHwQeTswSH0Ac/lMR7LJIp8K8HLK8qjADXAoZ8xeH56wxb96u0fNZSc1S0chpQsJ5ehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100894; c=relaxed/simple;
	bh=FgH+4oSFObwGJ6HnAfIGc8i9ehCagLGw5KwoO+DxTqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OI+QbBRzSmxyRccNN3mMMWiT9g85+a2JvgU0W0tYnzlMEEwl0u4QLKROSmJE8bHffekcG9jBfqydfn5AS4umDe0SEyht+N3boVKFsB/0c0syk3YJrg+h1M289l87uicu+isrfH2xh72hgqJ3tymGtFME1qa13XjjKwNjZYn7nMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0FTdeYzd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CCJWymg5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTKC6D++uGTdE7vVcbbnaEeewmEp+B/DaXmcW6uXuo0=;
	b=0FTdeYzd0H8IeImmDi0qKoq5NzGdMZ9cXu1pkgeHRm5F7HfrGw48WOp8JYHInqrdcSqvQW
	qaWPPcKvRKnJW7IfES0dDpp7X2EoCd1AqoTK/P1uv4w9H+WRUebW6cfwu9b+KhB5Zsqh0O
	rWi+EswTyMzvyjl1r6muIFBIiYuwh+3YihkfunGo7+TcXawhyD+3Mj3GKEQ25I130aUsDK
	gmGnZCJ64+AS9rTXp9ByWr5iOVtuz+ZdQ8PwiIszgUb9VASraCypalZmaUNlzgV9rDr6/M
	j/KsKTMpxfBn7D3rQunrQ5pgoxSzS4ckaZcBfkptb6kN9OaAEwpxHyN6ogBhaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTKC6D++uGTdE7vVcbbnaEeewmEp+B/DaXmcW6uXuo0=;
	b=CCJWymg5dmJrFFrp6uQuXwxilNowTQdSn6UqxumhDKiHPnfyH/wov7tUbaM84JL9sryRmb
	hzUtwSRVBtG/FIAw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 13/24] net: ieee802154: at86rf230: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:26 +0100
Message-Id: <89dcfc5c1cbf4c38d72bd565552abd4946aa99a8.1729865232.git.namcao@linutronix.de>
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

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ieee802154/at86rf230.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at=
86rf230.c
index f632b0cfd5ae..fd91f8a45bce 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -776,8 +776,8 @@ at86rf230_setup_spi_messages(struct at86rf230_local *lp,
 	state->trx.tx_buf =3D state->buf;
 	state->trx.rx_buf =3D state->buf;
 	spi_message_add_tail(&state->trx, &state->msg);
-	hrtimer_init(&state->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	state->timer.function =3D at86rf230_async_state_timer;
+	hrtimer_setup(&state->timer, at86rf230_async_state_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 }
=20
 static irqreturn_t at86rf230_isr(int irq, void *data)
--=20
2.39.5


