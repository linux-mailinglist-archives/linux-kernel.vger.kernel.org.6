Return-Path: <linux-kernel+bounces-384256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2539A9B28D0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B31DEB21B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B57E1D45F3;
	Mon, 28 Oct 2024 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="frSveYTY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/WNFafgu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80CB1B373B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100638; cv=none; b=Kv7+F2HQyXt0isbhTWb8NktkpaEljNGZo8Nk6QFj9fOLb1wrX4Cgb7PhX1R+ZTU6xxaW1CSTa6lpxAdGiwNa+InBMK+DwuIF0olAA5xQSeGVkovvgZPbbktLSRo02Mz5JjDhsEBk6H3+rjceuznk2girB7wR1sLFPAf9utuWcAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100638; c=relaxed/simple;
	bh=89P76W4dxG4vwr80/xFiizISI31t+pXL1ooPfIFUkgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KeXN4KV69N9YT7NPyS7s5IbBdpQ7MnW5uqNKWYCc3A5jvbaoaE7XqtA0C67tPsquY3DRB5f0wQJQuPsGF5gOHuOc1+YskERU30ensmcEVk4mjoeTiRCKbWNQdB5aO/Zkt9NH3L7H9dBAfOBfVaT1XFZb5BCKwhUQnCRPepOGQdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=frSveYTY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/WNFafgu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mv28Ug65bgMJCZtlcqqT11iFuRa7ViPaVxpmJ5oe1ns=;
	b=frSveYTY9YNQqY10O3Skq3c5piX4zHsVAMIVDkCh0wMXtIKg4ELHSwnCykURj95FJvT4PB
	ydxsws4pq6ugylZJxewWT7roGeA5YlyqY6qLeXlq8wFEpwIuBJdaTuf2GmU+ZKV/uL2Ecr
	nYba3IuJZWdGUGxsevbLZFaXZIQHFHXy0vC1L+1zZHGjRsMFtrutW2iWeM2GcfaI2gqhtZ
	NYx+GINzllYhZxQx7pb49q1FldCYVMGUHCX8eUBiAIsz/lcJK+dcSN5DHarm2U090NTw5j
	oogBKW9cE00IlicWVPHMi0Cr4htCvHiKcbunJnAngK7RUhoPi5FnE9sAsEXQyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mv28Ug65bgMJCZtlcqqT11iFuRa7ViPaVxpmJ5oe1ns=;
	b=/WNFafguuzWcU95r8fS6ZuK4GQbeAC92nhOmzO3HaVQER5HQWrTeTD+bVweZfgeR55rmgE
	4gxPa3uI3akhGXCg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 16/21] wait: Switch to use hrtimer_setup_sleeper_on_stack()
Date: Mon, 28 Oct 2024 08:29:35 +0100
Message-Id: <31f243f57c7c67222edd266cff133419483404f6.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced function hrtimer_setup_sleeper_on_stack() which
will replace hrtimer_init_sleeper_on_stack().

This function is the same as the old hrtimer_init_sleeper_on_stack(), but
it was introduced to keep the names consistent with other changes with
hrtimer.

Switch to use the new function.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/wait.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 8aa3372f21a0..643b7c7bf376 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -541,8 +541,8 @@ do {										\
 	int __ret =3D 0;								\
 	struct hrtimer_sleeper __t;						\
 										\
-	hrtimer_init_sleeper_on_stack(&__t, CLOCK_MONOTONIC,			\
-				      HRTIMER_MODE_REL);			\
+	hrtimer_setup_sleeper_on_stack(&__t, CLOCK_MONOTONIC,			\
+				       HRTIMER_MODE_REL);			\
 	if ((timeout) !=3D KTIME_MAX) {						\
 		hrtimer_set_expires_range_ns(&__t.timer, timeout,		\
 					current->timer_slack_ns);		\
--=20
2.39.5


