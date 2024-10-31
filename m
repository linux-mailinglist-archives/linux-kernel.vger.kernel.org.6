Return-Path: <linux-kernel+bounces-390756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8536A9B7E26
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19857281789
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB381CC162;
	Thu, 31 Oct 2024 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2k27J3wq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7QOgfZIu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D51C9DD7
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387715; cv=none; b=QnHbchP9g5xu65jjghmHjmnNfzLydJ9yik2T6LxJ/RXxuIulLz99dR00Paaryp9E41uj+RPItZz3tuM1Ze5+OgM2ClYSCJgssdmg28cvwxd+Uz/WF94Cx5Ly7Chkwpj8ywM5bM4oHrajludLjR9I/Ik135mzgfX0Le2G9F9Jrtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387715; c=relaxed/simple;
	bh=A8JkiuYfdKuC28T0KIOOEpzfr4l1InScsh9qYcKJJtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oot1fjgCAFODVH1xcdTuNE8dQQfnCNP2ujBedprH2rP9wntcMj/1DKdfjzOt47mOM8Tzuk6ACVKulfCUzIvQSLNnNl34zaxZ0F6CBj+WYMFsPaXDHKt7nBRB+a3qUXI7ea16w6U5XGp/8552B8vvdsmBipwLVsXUH6yM97POWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2k27J3wq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7QOgfZIu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730387711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYfjK6Ca0PZ7u6hxJjuMYHahvzL9jhDTXWFMtws/RE8=;
	b=2k27J3wqOQVhl9MKvgZskQoH9r0+R/+UdOyqQAvYOzy4xnayx7Hva90FcqfWzTU2Up7+XL
	z+Ae1TUKWy+KKqkHi/Ib2pPvSi5n6kBjw1yeVitMynA1HmNZTLwPHD03vefIBM/+Shmf1v
	oXGClDDPteefEyRPDzjTVrza/dMoqtt/Ikf4qGw+s3vAdV0umJo1HiXB8PbqIDSDEOb5V1
	skO+vI9951uZC/BhBWOrycQD+dRQnBCZvw7rvXTAaTqik/a2q9ct1j6MpopAmCmwj+dVmH
	j0Whw4D4CmjButJ4OV2zy7DJ2kK02sC7p4VYCHwDaK/A9lre1VfnRNX25XdU1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730387711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYfjK6Ca0PZ7u6hxJjuMYHahvzL9jhDTXWFMtws/RE8=;
	b=7QOgfZIusMOviCnFOXXtb31+1DxjDGaTQgD2d/m9I/g+V89vz6mSaJXN3c4JIgpGVfKIJ8
	klW9pVtvT4O9KcCw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	x86@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Nam Cao <namcao@linutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RESEND PATCH v2 17/19] io_uring: Switch to use hrtimer_setup_on_stack()
Date: Thu, 31 Oct 2024 16:14:31 +0100
Message-Id: <f0d4ac32ec4050710a656cee8385fa4427be33aa.1730386209.git.namcao@linutronix.de>
In-Reply-To: <cover.1730386209.git.namcao@linutronix.de>
References: <cover.1730386209.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hrtimer_setup_on_stack() takes the callback function pointer as argument
and initializes the timer completely.

Replace hrtimer_init_on_stack() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index feb61d68dca6..0842aa3f60e7 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2435,13 +2435,14 @@ static int io_cqring_schedule_timeout(struct io_wai=
t_queue *iowq,
 {
 	ktime_t timeout;
=20
-	hrtimer_init_on_stack(&iowq->t, clock_id, HRTIMER_MODE_ABS);
 	if (iowq->min_timeout) {
 		timeout =3D ktime_add_ns(iowq->min_timeout, start_time);
-		iowq->t.function =3D io_cqring_min_timer_wakeup;
+		hrtimer_setup_on_stack(&iowq->t, io_cqring_min_timer_wakeup, clock_id,
+				       HRTIMER_MODE_ABS);
 	} else {
 		timeout =3D iowq->timeout;
-		iowq->t.function =3D io_cqring_timer_wakeup;
+		hrtimer_setup_on_stack(&iowq->t, io_cqring_timer_wakeup, clock_id,
+				       HRTIMER_MODE_ABS);
 	}
=20
 	hrtimer_set_expires_range_ns(&iowq->t, timeout, 0);
--=20
2.39.5


