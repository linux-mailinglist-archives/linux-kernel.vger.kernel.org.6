Return-Path: <linux-kernel+bounces-384247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2889B28C1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26BB281451
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F69192D63;
	Mon, 28 Oct 2024 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZA4agdT/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+XidrmnK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE81615EFA1
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100633; cv=none; b=mJW6OEGsJKHZ47NabMqeJp380rFP4I9R4eodjvfgN621UhhHRMDi9lpZD3vAJk72aGC3FwVNCGIIEZNdnHZIZvTd7wJDWdAqALcnYCZfcRS77y2nR4JL+Xz/Lbl8VVYqodiuJYC69uJq4ecfw7/yezkKv0zQ9aKJ63WG6FuFou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100633; c=relaxed/simple;
	bh=Y4sc8uvLB5tZSTIwkWXcFtWHyLAOZiC1u0cSBzzPJHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hEoHW/Cn2Dm+8+9uIg5nRSr0LVdsfkM9jCb4mlL+k7dVL//51rJnyb1Kpql29aG7jA9nGoY1ILoiIiHjgj8bYeSF49kMdSdSjpZVZzEtfgabSaeommJlqxAclevN/eJSHTQ8a9buanTY4YM+QWQa3BsPWORqDZxi6jkGc7WuZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZA4agdT/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+XidrmnK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FpvILPcEEZYBzJpW+S8htdJ1Ku71+tSghbMeHdyKSws=;
	b=ZA4agdT/GIAzq8UKYB5VjZb9I6K6woN0B+3qmFhppakmSs69MG+1sTKk/N+h2GafdVgEgA
	GTgCK72j52aX7Y6wNspe2owiwraEg0bLYUCFz3Su0MxM7YYCoiSNAVYh6q0DuNrxDaEEGs
	lI1kWPqLw27zLS/V8v0K7YkYJBsCXRpMwEFaEi1/wknjEJWz02GORz1iY5jrv40Ogole+o
	Och0+KKk2Sp8aEvcN4nXowe6Fs4p84lAaJok6Ys/Qw1Sz85xNaxIJys4M+HhgAwPEadNJi
	qEgws0jCvVemWNjz5CwIwFZY1xlmjVWBh4zF7nz+TgxKvekCcwcDVHvo1OwxAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FpvILPcEEZYBzJpW+S8htdJ1Ku71+tSghbMeHdyKSws=;
	b=+XidrmnKHrcvjg9TUbV+TDgKU1Gr4p4Uaf32vLOBE0P3Lovkjxym5heX9b6Jphy18LK9YE
	W0gPI/uulUwA+/Cw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/21] io_uring: Remove redundant hrtimer's callback function setup
Date: Mon, 28 Oct 2024 08:29:26 +0100
Message-Id: <61a7783e6359b77338f6b2e87c1f19de4b3508de.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The IORING_OP_TIMEOUT command uses hrtimer underneath. The timer's callback
function is setup in io_timeout(), and then the callback function is setup
again when the timer is rearmed.

Since the callback function is the same for both cases, the latter setup is
redundant, therefore remove it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Jens Axboe <axboe@kernel.dk>
---
 io_uring/timeout.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index 9973876d91b0..2ffe5e1dc68a 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -76,7 +76,6 @@ static void io_timeout_complete(struct io_kiocb *req, str=
uct io_tw_state *ts)
 			/* re-arm timer */
 			spin_lock_irq(&ctx->timeout_lock);
 			list_add(&timeout->list, ctx->timeout_list.prev);
-			data->timer.function =3D io_timeout_fn;
 			hrtimer_start(&data->timer, timespec64_to_ktime(data->ts), data->mode);
 			spin_unlock_irq(&ctx->timeout_lock);
 			return;
--=20
2.39.5


