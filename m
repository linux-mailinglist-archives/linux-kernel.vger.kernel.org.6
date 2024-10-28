Return-Path: <linux-kernel+bounces-384252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341339B28CB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633111C211F2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487E41CCEE5;
	Mon, 28 Oct 2024 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jVUDfg00";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="coJ4NMyD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39679192B81
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100636; cv=none; b=ABcvyWDyvhYOsFDXIhrV3CFj2gd33ohwxu1RjcgTDNZqJ97HfMXPlW8KAWy6I9tH8ChrBZEIg1xQyPGySDn20UAq9Zu6jRx3SJMSCNXOumkihtOCWTCg8HtcuW08WE7nMlxNkd7aUGJf50+ZTAmMByud1fc9P+gOpzmMNKebIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100636; c=relaxed/simple;
	bh=K2U0twQP+MNfkVfGVWqYOHHr4dbqMXiii56EKtn0bNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZS6M1CklOBD5njASJE6bYAxqZLxtImsS8vTD43JAZlJxwnzlWQ1fyqZ1+OWI7uhQMPXUxNQzs7ljDOsZ0WaLS49pfBzyDxm8jCjAq6/Roa0uYulE0OgeL/qX60CfxNXgtmzvYg/DspJkMMXexoYPShV9bXGpFIr6hwiSY9HxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jVUDfg00; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=coJ4NMyD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D4JYGaFdslzTFMLcylYq2m2bbzwGTzv81asbS4XQJYw=;
	b=jVUDfg00xyCvq9fVWO9yWLXDg/Yp9RdvVgbOplWjCdZk2fhgDyjA6aT+nz2WpU6EybiwOF
	becvprC0JO9nZEEcXa+2kGqrbv4ZspVn9QiherVnhOEUDPkYnFqyX0301gV7PCT449BUAa
	Kwg+F/o/DY/iRy5FPGPTU4qN/EMK6JLdkvsSCj4nu7WO1OyPByYNyVL/vlzTOZ42uEOlXV
	zxsEjzN2yQ7Q81BIW9uSUXaLj68Ep7K8/STGGuN5A2um+8jjAQP5v5yQ3vFTmRUgCQj4mn
	eddId3e0VULQ+EPu58eeo/h8iyLcic0tZidd28cm/pDRi3NnR4F4Afbrva49PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D4JYGaFdslzTFMLcylYq2m2bbzwGTzv81asbS4XQJYw=;
	b=coJ4NMyD3DJkNADte7yvfA97ArpkNrZRmX7+GOLkxBXHcV/LyLy73auHSGkrWCvsxI9YpQ
	xZCyk+8W4tdL09Bg==
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
Subject: [PATCH 13/21] futex: Switch to use hrtimer_setup_sleeper_on_stack()
Date: Mon, 28 Oct 2024 08:29:32 +0100
Message-Id: <3a9eb9d88c4b184f5a588ccdb74bf61023279840.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced hrtimer_setup_sleeper_on_stack() which will
replace hrtimer_init_sleeper_on_stack(). Switch to use this new function.

This function is the same as the old hrtimer_init_sleeper_on_stack(), but
it was introduced to keep the names consistent with other changes with
hrtimer.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/futex/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 136768ae2637..fb7214c7a36f 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -140,9 +140,9 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper=
 *timeout,
 	if (!time)
 		return NULL;
=20
-	hrtimer_init_sleeper_on_stack(timeout, (flags & FLAGS_CLOCKRT) ?
-				      CLOCK_REALTIME : CLOCK_MONOTONIC,
-				      HRTIMER_MODE_ABS);
+	hrtimer_setup_sleeper_on_stack(timeout,
+				       (flags & FLAGS_CLOCKRT) ? CLOCK_REALTIME : CLOCK_MONOTONIC,
+				       HRTIMER_MODE_ABS);
 	/*
 	 * If range_ns is 0, calling hrtimer_set_expires_range_ns() is
 	 * effectively the same as calling hrtimer_set_expires().
--=20
2.39.5


