Return-Path: <linux-kernel+bounces-384275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E10BF9B28E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C3B281FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF5E1DA631;
	Mon, 28 Oct 2024 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ob67aNQV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CMSwTDVw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7075192B78
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100744; cv=none; b=SSgy47Ywufbxg/q0vRlx7RLmRmCnImqGsa3G0lVjBP0hZDiD4Tn4dw+Uln3iD9vP0ISNydv8Y+HWr1T5VgM63oQm/CP2trZ+Sus5oteBtEDTJBQR8T/YpmALGcYaOKPhKPLbEdwRTZnH7o0ukUSSsKpf/ZivKbRsdRtXHLlogek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100744; c=relaxed/simple;
	bh=5MZt17PaMlsHfNRKyGAIFHUJ+wkj5i3UiEoH00D7aik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=daknXdVl5zWSim8ZM5qSlLGV7jIeaVYX6QwZRL6Ya/lVAtYK9wlHk6pP6aaHTpMg7vKLtAIyjJNvICeEfY6zWICKsRXtH7lAmGwHGZj2XL/sf6R6RvO2Puk941/ic66ybAMOf8nm0O6lwVN45RndGIcYbVZGllOXGuRUyJDvFso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ob67aNQV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CMSwTDVw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxwZp1odMq9uoPIq7uyz56U1ANYVR+uLtMQUbFRNsoI=;
	b=Ob67aNQVJ2vmXD48JMg76G9LAhvRtlYe+BZwJp8xAhCUxyJ1XUdQjRTN4S3Wp6d0m/r3cP
	jhVy7fMDd0fpiBC9J+2P8M+6UzHHJ5Fa7r2y8iNKhltFKdl1aPrc0b77M4op6xZ8PPwMSi
	EwApT8qLARocXytNnNx5aAGinbIG/cUQH8ygO6QYobK/Uc1sLEH2lhpoGBDPJyaPbl8utD
	e2wYCKUj/x03in5TP44zu3iHhL+ju7oq2obuQg3oZAFNQ5bOBHddsmzPgfenEEysZU3YXO
	5kySGjo4M+KTTd0SSy0Jt9dNNwInjCrnAFsQokA78XmRYTUUxF2vD3Wn0MK3LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxwZp1odMq9uoPIq7uyz56U1ANYVR+uLtMQUbFRNsoI=;
	b=CMSwTDVw7VVUHDmc42Bsf+4kqEpFAgsrg0NWOJtTIw8M9YcLv0pHEx2YXmpjRBfBA4vTrI
	zR+dKTFRhCnjPXDA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 10/31] powerpc/watchdog: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:43 +0100
Message-Id: <80cf6f14a74a374903997670926b8ce3a9439558.1729864823.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864823.git.namcao@linutronix.de>
References: <cover.1729864823.git.namcao@linutronix.de>
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
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/watchdog.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 8c464a5d8246..2429cb1c7baa 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -495,8 +495,7 @@ static void start_watchdog(void *arg)
=20
 	*this_cpu_ptr(&wd_timer_tb) =3D get_tb();
=20
-	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	hrtimer->function =3D watchdog_timer_fn;
+	hrtimer_setup(hrtimer, watchdog_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_R=
EL);
 	hrtimer_start(hrtimer, ms_to_ktime(wd_timer_period_ms),
 		      HRTIMER_MODE_REL_PINNED);
 }
--=20
2.39.5


