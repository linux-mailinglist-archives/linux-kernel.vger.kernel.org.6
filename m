Return-Path: <linux-kernel+bounces-384280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0B29B28E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B92CB22035
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5D11DC19A;
	Mon, 28 Oct 2024 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x/CAwXhl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2PzDTKpg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E811D9A41
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100747; cv=none; b=C1EXURS+JeWbdr8szXNvqFWTYruxXJjPq/I8OpR6NqfnC2PTMBeeGeyPHpVgY65oaXa2uG2hcW8aWOLTTryfkt5FXXftLuNlZqu2YN6mSKVGT+OHwfEojszbhass+YNx96ETZTa/Kk/3kwrMTz3UUVgV/HURkyE14jneZHaOB8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100747; c=relaxed/simple;
	bh=CYN2F4nmYOv1X5ETWaW+HtQmDogIdnj83TRshJhjxOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jyHc3cQtDkVwxDXe3wO47VGCiTjo/1ZaPqSpWJscvx0+IYE6X5l8QvysRLyCgC2pnZ9upOc6VY2aKVTsbjQzJd/z+TcXgKgs/FgF91WNX0dhuQC+8q5/ASVanHlW8Cqb0SyHrviZdCw5DJFz9jko2Y0YUtn5eJbXWRCGBBzdKvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x/CAwXhl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2PzDTKpg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7bpCQiI2JfjFnV7/EMF4stz4GlAScPSQTmIH11qGxw=;
	b=x/CAwXhlL8lGBbyTbC5mSCD+azuHF67u+M9KfXytVrY5ROn7kYlzv2AFghA/apygwzrzys
	a9jDbybf1LNsoc5SXso8m4W7tmTf/8j8oFPiWoCOurMrfnWhkScLYpSWm1ktsGAz/jmoGk
	+PA13Ttf2sJY2rAxoP0CsdHxVC80OGO0wf9N9Wv+MMp1ryBV3/jbIq9/n15IR1n0ZCu+Mb
	9oEXSk5fozMKt/q+dO3uU6nqMEwsLqKXYcrJKhCc4UXF2+YhBZ1Cl9wLaa6REtLpFYwO7G
	rezIcq9Mfskqa/+7BQtZQYOirKG0yZxUdIfkkqYDFKRmPACseK2lcq91fgSXLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7bpCQiI2JfjFnV7/EMF4stz4GlAScPSQTmIH11qGxw=;
	b=2PzDTKpgh1ftKdN8ocu2Jcx9hsrqDcyUrru+H6StSG3Qn0XXr9jVEMRjqnVh+7C7yedZ2B
	tQbdEZkJKk7FfuCQ==
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
Subject: [PATCH 16/31] io_uring/timeout: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:49 +0100
Message-Id: <8bc0762e419b6fd1d0a0da31a187d19826d71187.1729864823.git.namcao@linutronix.de>
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

Switch to use the new function.

This new function is also used to initialize the callback function in
.prep() (the callback function depends on whether it is IORING_OP_TIMEOUT
or IORING_OP_LINK_TIMEOUT). Thus, callback function setup in io_timeout()
and io_queue_linked_timeout() are now redundant, therefore remove them.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Jens Axboe <axboe@kernel.dk>
---
 io_uring/timeout.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index 2ffe5e1dc68a..a4165e54238b 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -388,8 +388,7 @@ static int io_linked_timeout_update(struct io_ring_ctx =
*ctx, __u64 user_data,
 	io =3D req->async_data;
 	if (hrtimer_try_to_cancel(&io->timer) =3D=3D -1)
 		return -EALREADY;
-	hrtimer_init(&io->timer, io_timeout_get_clock(io), mode);
-	io->timer.function =3D io_link_timeout_fn;
+	hrtimer_setup(&io->timer, io_link_timeout_fn, io_timeout_get_clock(io), m=
ode);
 	hrtimer_start(&io->timer, timespec64_to_ktime(*ts), mode);
 	return 0;
 }
@@ -409,8 +408,7 @@ static int io_timeout_update(struct io_ring_ctx *ctx, _=
_u64 user_data,
 	timeout->off =3D 0; /* noseq */
 	data =3D req->async_data;
 	list_add_tail(&timeout->list, &ctx->timeout_list);
-	hrtimer_init(&data->timer, io_timeout_get_clock(data), mode);
-	data->timer.function =3D io_timeout_fn;
+	hrtimer_setup(&data->timer, io_timeout_fn, io_timeout_get_clock(data), mo=
de);
 	hrtimer_start(&data->timer, timespec64_to_ktime(*ts), mode);
 	return 0;
 }
@@ -537,7 +535,6 @@ static int __io_timeout_prep(struct io_kiocb *req,
 		return -EINVAL;
=20
 	data->mode =3D io_translate_timeout_mode(flags);
-	hrtimer_init(&data->timer, io_timeout_get_clock(data), data->mode);
=20
 	if (is_timeout_link) {
 		struct io_submit_link *link =3D &req->ctx->submit_state.link;
@@ -548,6 +545,10 @@ static int __io_timeout_prep(struct io_kiocb *req,
 			return -EINVAL;
 		timeout->head =3D link->last;
 		link->last->flags |=3D REQ_F_ARM_LTIMEOUT;
+		hrtimer_setup(&data->timer, io_link_timeout_fn, io_timeout_get_clock(dat=
a),
+			      data->mode);
+	} else {
+		hrtimer_setup(&data->timer, io_timeout_fn, io_timeout_get_clock(data), d=
ata->mode);
 	}
 	return 0;
 }
@@ -607,7 +608,6 @@ int io_timeout(struct io_kiocb *req, unsigned int issue=
_flags)
 	}
 add:
 	list_add(&timeout->list, entry);
-	data->timer.function =3D io_timeout_fn;
 	hrtimer_start(&data->timer, timespec64_to_ktime(data->ts), data->mode);
 	spin_unlock_irq(&ctx->timeout_lock);
 	return IOU_ISSUE_SKIP_COMPLETE;
@@ -626,7 +626,6 @@ void io_queue_linked_timeout(struct io_kiocb *req)
 	if (timeout->head) {
 		struct io_timeout_data *data =3D req->async_data;
=20
-		data->timer.function =3D io_link_timeout_fn;
 		hrtimer_start(&data->timer, timespec64_to_ktime(data->ts),
 				data->mode);
 		list_add_tail(&timeout->list, &ctx->ltimeout_list);
--=20
2.39.5


