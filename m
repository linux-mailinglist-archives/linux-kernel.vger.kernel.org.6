Return-Path: <linux-kernel+bounces-384258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1909B28D2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B781F21B85
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784011D63D3;
	Mon, 28 Oct 2024 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J2pcl76O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zI32bFzH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A39191F87
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100639; cv=none; b=Bj+EIv4xeQsk5P+X4uhkr6MdriLu/SQXUmTnq9edFsJtlkEqxkAMti0ObORPm/bJBqdsQsnWgfn4lj3FJ2kgV/peTJvvSiRyBOcnIX2ffMisNJQYNqJ20Afl9c57JkVT5HDiSnV3veb4L9ircJgg+1f7wu6UU7yBTxf28/ek3QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100639; c=relaxed/simple;
	bh=AAQLFWRoUHVygOhusGzdBe1s2eupEuCbhk2Ngr6pcJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oSKGCsJZoMdvZ1pg+1A+C633SBFLUF4ZhMeIPDKTX3ycjuam5MY9PqdkbIjvX+XFJQpGIDowZ5aGXpFxW7b//zrgywAUDndeki4pEoedEpUYWlZoXxoTjTz1p+M27siXHDhZnRizLQqqSWJWejlCDWtNcxMuQ0D3fOlDfoCqFjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J2pcl76O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zI32bFzH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slRmMQmEdb7f8rA3+n8RFcCYvgMT1T0/Oy8UU05OlVY=;
	b=J2pcl76OglaKensct5+lSXSwCIf8mbgV1MnKf3haM25D8RZymByNaYJxuj9ITPR8++VD3V
	vQ3lAzXPi68hpd0zuU6IW3vR7LoNXK2dSk8IHnIfD1+Ux0kwr8EXCpZSxP8UaMNfydTX3L
	RbreKsl0hq/bk9t8qZYa3eO6gbopHJWkUKbXLMCTjco8hJgm/H/tktxU1Kuu5gXbnlGrQA
	lQgv1RQ1zDOh/Fa50ayXnhPRvyVhBKWXOczWqlg2bigx0TDD1O46Cm9LKsWnr2fm3nETf5
	4NS8zPeZYMcGvZ/ORqpI1Y+dunOXK1FpDHS/Fug8N816iSRU5yr2Ko6LWxuryQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slRmMQmEdb7f8rA3+n8RFcCYvgMT1T0/Oy8UU05OlVY=;
	b=zI32bFzHG8pGiQuzyvcc598o1eecoAfRkoBZlPoFRmLzUCqwYAePTf88qYHN9ZROyJhHlV
	nxRe2Fn2cYtQfCDw==
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
Subject: [PATCH 18/21] sched/idle: Switch to use hrtimer_setup_on_stack()
Date: Mon, 28 Oct 2024 08:29:37 +0100
Message-Id: <db5daed82f8ba69eb155171ed96f3a5a83cd483b.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced function hrtimer_setup_on_stack(), which will
replace hrtimer_init_on_stack(). In addition to what
hrtimer_init_on_stack() does, this new function also sanity-checks and
initializes the callback function pointer.

Switch to use the new function.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index d2f096bb274c..631e42802925 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -399,8 +399,8 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
 	cpuidle_use_deepest_state(latency_ns);
=20
 	it.done =3D 0;
-	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	it.timer.function =3D idle_inject_timer_fn;
+	hrtimer_setup_on_stack(&it.timer, idle_inject_timer_fn, CLOCK_MONOTONIC,
+			       HRTIMER_MODE_REL_HARD);
 	hrtimer_start(&it.timer, ns_to_ktime(duration_ns),
 		      HRTIMER_MODE_REL_PINNED_HARD);
=20
--=20
2.39.5


