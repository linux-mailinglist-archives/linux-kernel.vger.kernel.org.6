Return-Path: <linux-kernel+bounces-384289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779359B28F0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A498F1C21502
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E271DDC30;
	Mon, 28 Oct 2024 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gN1SIfI4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XKAzwu9U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00BD1D9A65
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100749; cv=none; b=oTAo79qEzCdPGs3ALMKyorPBfRCLpYzBqgn59iPpJmPfb0FtWtt/QXYEF9YKAM/g9o1h6q1oGdplylqoOyydwFyhWa+NIUvbMjmN6a7RUUkE6AgAGs+cWnuJTqOII1KL3ITcDuSnAFqPemn62NUUPwaAgUtiKJq6/ZdyRdPr+xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100749; c=relaxed/simple;
	bh=Ew+TKsZ3uXdb1xQGbj+3wauKU40de7RZ2fzPnuiA6o8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZzjuLmQ5stqrshYzVPMwLMo4RLOAIYqPm098IKxvP6X6fNR79QCcdDHc4CxZt4FZowJuERVYpEmU3yYMeyTMQtEIA1ooffB21R6uO+nOnRRO/bnIxCEIhB6Zng9UVUEsKWh3hQ41OkSj2ideirfq134XvgBjcCBBbhXG1s/ssxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gN1SIfI4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XKAzwu9U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I7kFf9pAcvdmeBgd8q5rvVb62slmZ5vf490qFQNjGiY=;
	b=gN1SIfI4D6WO46H2xv9myHRS06FeIal+xkTHJTONyafiZuBDUDJ7MYO1l2OAiEW+uZpbeG
	5+FKUq3MBD0E00uc/EC/+QS7QS2qNgte3FyKTfOs3qmmBrv96JzBksfnfubSSafW7IBbW5
	VCwAKIBWE+fNnCyJY3gHoSJdLmwtJd8OWLo0HgVDCbhKAnusuKOKQ5LY6ozpFGrI+9rU7n
	6LOOFm5+zXJekvWuMsnyXoTirsDxXAgI8q+qXJBZ15USXOOcU9Q75xsD333OZQTc7f8/wk
	aAPtlYVbKQUQq9IF+d7CWpBE/y0JcjN3EK+lI99LgAxY9r1wu2j55KT5pClb4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I7kFf9pAcvdmeBgd8q5rvVb62slmZ5vf490qFQNjGiY=;
	b=XKAzwu9UVTVOFcw/KrpKD0twPlDiVolNoUjiy9uxyTKLYeKVidRSA++4ggMQ3c5ZIZwDEs
	CUSLeFd9ch22FpBQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 17/31] fork: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:50 +0100
Message-Id: <83e8fe18090bd092f2ea022a053ae8be2edefefd.1729864823.git.namcao@linutronix.de>
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
Cc: Oleg Nesterov <oleg@redhat.com>
---
 kernel/fork.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 60c0b4868fd4..9a2e1905232f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1864,8 +1864,7 @@ static int copy_signal(unsigned long clone_flags, str=
uct task_struct *tsk)
=20
 #ifdef CONFIG_POSIX_TIMERS
 	INIT_HLIST_HEAD(&sig->posix_timers);
-	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	sig->real_timer.function =3D it_real_fn;
+	hrtimer_setup(&sig->real_timer, it_real_fn, CLOCK_MONOTONIC, HRTIMER_MODE=
_REL);
 #endif
=20
 	task_lock(current->group_leader);
--=20
2.39.5


