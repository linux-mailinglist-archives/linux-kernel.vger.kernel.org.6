Return-Path: <linux-kernel+bounces-384260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8DA9B28C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CE28B2105F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB9A192B7A;
	Mon, 28 Oct 2024 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LGQZ4WjS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dBGOkLqy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FEC191489
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100640; cv=none; b=VzrCWvHool7pijXoOVBH1b7Q7mNSerO1vVLYMtIQjzTGsLwBlD4Tk/ewOBi3s+mi05kbu54PmXJODc1FIu8F0C+qePX/spao+2QKUFVlXcTZf13zGz/mkeT/tSS8ApymO/J4A3bAeneV5gPhoL2rvH1xif7m8o0u9VLntdSOY2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100640; c=relaxed/simple;
	bh=SDsWig1abADkGoEilxW6zwUHpoZk394qMZP7AwtvOak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L1XRaQVgTFcOg9oM6vXnqSd6cjfaB0fnUefSmr7Z/85obLVTUKKQ8rrz5YyrQSTUttpLN6rsqIgMFzogy3AhOTOt5CdeNV+cuHuMbwCx6GnAoGlKxnYTfAkhuu5PqGgdVV7wk4ijiQXfpU32mObh+XZPcZKJyF3HXeCSiodUrmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LGQZ4WjS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dBGOkLqy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghm5t5hu/x6JQgXUC1QAejuM9cCD5lTbm5O7D/1weMw=;
	b=LGQZ4WjSxQK58/P8WHwZfUBvFhyr0thRj2YK4/zyoaJOCVtlc4T6IP/HEvVqisF8Y7sklW
	3EQgCnYp7ty1D+s7nOzMbfiIb8uBrmAyLfS1ymKdxGDqJcYrdKj3Fat7SsDH91VV3cPZWZ
	CgvTJrSYGUYe5znXPvje1upPqeWijxvatlnnYUI7/RuNM8fu0ZgLsce86yPS4UAgLVJiTe
	z6W9pM9jk5QDySo0pl0zUJm5+rOhI0SfBA1fwknYcT6n079wtgkcmTShHt0sbIKlJtbzvv
	iJywPnyth+GbrtazIC1LiTNocSbCWWM6lzUfazJibMe4PCWCqje9fjhy9fB5vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghm5t5hu/x6JQgXUC1QAejuM9cCD5lTbm5O7D/1weMw=;
	b=dBGOkLqyK0z4NeTKXssV3a8c+1P5LvkFczO1MtkY8feoMqswisAswo3aBur8bjMo26V/2p
	IYYvkZIsWIDn9oCQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 21/21] hrtimers: Delete hrtimer_init_on_stack()
Date: Mon, 28 Oct 2024 08:29:40 +0100
Message-Id: <f9bf5aec125d71ec1ac0f4e42d05a2d9cdad920e.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hrtimer_init_on_stack() is unused. Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/hrtimer.h |  2 --
 kernel/time/hrtimer.c   | 17 -----------------
 2 files changed, 19 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 4e4f04b3c0c2..7ef5f7ef31a9 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -230,8 +230,6 @@ extern void hrtimer_init(struct hrtimer *timer, clockid=
_t which_clock,
 			 enum hrtimer_mode mode);
 extern void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*fu=
nction)(struct hrtimer *),
 			  clockid_t clock_id, enum hrtimer_mode mode);
-extern void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t which_c=
lock,
-				  enum hrtimer_mode mode);
 extern void hrtimer_setup_on_stack(struct hrtimer *timer,
 				   enum hrtimer_restart (*function)(struct hrtimer *),
 				   clockid_t clock_id, enum hrtimer_mode mode);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 376b8182b72e..55e9ffbcd49a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1629,23 +1629,6 @@ void hrtimer_setup(struct hrtimer *timer, enum hrtim=
er_restart (*function)(struc
 }
 EXPORT_SYMBOL_GPL(hrtimer_setup);
=20
-/**
- * hrtimer_init_on_stack - initialize a timer in stack memory
- * @timer:	The timer to be initialized
- * @clock_id:	The clock to be used
- * @mode:       The timer mode
- *
- * Similar to hrtimer_init(), except that this one must be used if struct =
hrtimer is in stack
- * memory.
- */
-void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t clock_id,
-			   enum hrtimer_mode mode)
-{
-	debug_init_on_stack(timer, clock_id, mode);
-	__hrtimer_init(timer, clock_id, mode);
-}
-EXPORT_SYMBOL_GPL(hrtimer_init_on_stack);
-
 /**
  * hrtimer_setup_on_stack - initialize a timer on stack memory
  * @timer:	The timer to be initialized
--=20
2.39.5


