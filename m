Return-Path: <linux-kernel+bounces-208588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C259026FE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30201286031
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B7D155CA0;
	Mon, 10 Jun 2024 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bOl04P/V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XfXAlRMy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47729155A2B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037759; cv=none; b=NIsUsw/tlwcqQmijmlTHfffYnaToCSMN5iutREaFNg1VfNpahwRBhZbxJsHhtKNTLYn6rhTWo7esxzPFGnZ4AXX6Asl/EuEBxqsrTVm1S2DbICKfMDGfsqxkucHZFuphBuYhsJP7Wx+R7CuKuvTnTSlKE/1RfHXz+aVpDUpNChc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037759; c=relaxed/simple;
	bh=d1BJ7Kja+UEwMgVwc6Tt6tmvcnKhbXaS3H8LE3K80r4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=PGoOUDn7vN50wuEld5F43hbUoUxynowObQrPB0afh4GgDXVnGRjqQ4FOm6+nUlIDS8sm0nEqUwqixp/JrilVsmukNrHUFGeJrCtZ7yukdU6/ZLl9RedmusNPD8v7ihTl1MfzB2+0E+V1vBBDBKkV/+3hAhLa7olauZxI0KHNZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bOl04P/V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XfXAlRMy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164026.992475995@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Qgv0rOS1X6FuYj5LENG49jFoHaTII1ldHQt4poVGsnc=;
	b=bOl04P/VxIRlk0A/cs0WrD231whGwrzsLd+OpYoKeVyecflRVg3Yp6TOBUL7QJypZC4FDT
	l10eCKY0ELR79UMYtZR3V5yjAgO/Xn109WU6YnPlKOVoF0KYjwtsWII3NF8RdRtUVZb1Ow
	3/acV3dUEujIqqHSEK6w5rlpu2g6lRBQyn3tAQaIR5E62aLPCwgWJkhrv6CA5UmjZYT23y
	T4kjLF3b1djHKKG7zeqc9e3rEDTPUz1oAxCFzkYQeDg5ZCsOXBiHeIPPJgNn2IAn+Dh2/I
	CbBizImIDELWodIjSXZo4KuiaYKW+KzyWdq80bh4JLBHXz+ea26W/1cCCXW4SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Qgv0rOS1X6FuYj5LENG49jFoHaTII1ldHQt4poVGsnc=;
	b=XfXAlRMy8hhmQtBX6rTA1Kcq7EoUOaaf+WPuOAY21WOpp7eEjgSrQrt/P2tucKmhetqOo9
	LtdAtMBa/q/dDXBA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch V3 24/51] signal: Replace BUG_ON()s
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:34 +0200 (CEST)

These really can be handled gracefully without killing the machine.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/signal.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1940,10 +1940,11 @@ struct sigqueue *sigqueue_alloc(void)
 
 void sigqueue_free(struct sigqueue *q)
 {
-	unsigned long flags;
 	spinlock_t *lock = &current->sighand->siglock;
+	unsigned long flags;
 
-	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
+	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
+		return;
 	/*
 	 * We must hold ->siglock while testing q->list
 	 * to serialize with collect_signal() or with
@@ -1971,7 +1972,10 @@ int send_sigqueue(struct sigqueue *q, st
 	unsigned long flags;
 	int ret, result;
 
-	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
+	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
+		return 0;
+	if (WARN_ON_ONCE(q->info.si_code != SI_TIMER))
+		return 0;
 
 	ret = -1;
 	rcu_read_lock();
@@ -2006,7 +2010,6 @@ int send_sigqueue(struct sigqueue *q, st
 		 * If an SI_TIMER entry is already queue just increment
 		 * the overrun count.
 		 */
-		BUG_ON(q->info.si_code != SI_TIMER);
 		q->info.si_overrun++;
 		result = TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;


