Return-Path: <linux-kernel+bounces-355519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A47699536C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0322A284A3D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D057818C327;
	Tue,  8 Oct 2024 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QznOkguB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7KS5E0mm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94C225D7
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728401557; cv=none; b=GUto6HKJ+ywygppC93urAPBLFdhEyLzzzKTf5wQ5YzSbThHabzewvLr6zoYY67VM7OCvg5oWxFGQ24GBdWubdvID2lpOoFAxPynsFfsxhX8bq7sR9TVIeQfzPRzPt0Nr/a1g4HObiaYMJWc+Spp/LHU2r5epUjrQwIku/3l9UGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728401557; c=relaxed/simple;
	bh=ppJPaRCKwQA0kgyTZmF/QDHXaIjQnLk0VBaXJ6KQgtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKng+paVF/y1Opw8rDc5Lj2LcnrER/za/C93D0pxFvUvURGFcjmrG5i+i7L4Aru+X4vavJlN46DfyZ02ezo7AOdJoFLlg7Y4q8g3Zl0wxmFOCzxerf/F+5vyl4UPTPGI+a3IJ/SNj2WKE+mv3/sbqteO5wRylujRfUctEmIc7AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QznOkguB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7KS5E0mm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 8 Oct 2024 17:32:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728401554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMqIs6oIguO8hqz7gtUdwCEP0ZaOEHzmt5wh9mf3P6A=;
	b=QznOkguBInzUNZ3uD7qpRKevfcyNcJMjbdp5kb+ts5sdvGZbxN4rpLAxOywWHnPFfT3R4J
	xZZbKIg+ZKf0WTAMnBA5YiHmPutijaD/uzFH3XUA6TXy9KE8u5Mg9Fkz016QEm4L9a7Xer
	8NEv5gaXNYZn/1J4aeE9IHLmNc3NhCLdq3/b/T2aSwFSkW38sPMKRFK3zi6aSFZlh8JiC9
	FbKCixEmJ2uPyFLgW94+Etj6WtOP5lJob+uFiRNNWMVq+w9KP+iT4Lqh/UQYzLlh/aLae8
	CaaQMRqCeH+rVebcPcFB1SoT4ck/VvXF4yKrIZ8dd8FUWfAeXNVq2uEa13F+zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728401554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMqIs6oIguO8hqz7gtUdwCEP0ZaOEHzmt5wh9mf3P6A=;
	b=7KS5E0mmTXkH7DZGUJS6EO+Rc7PRBxKp8glCxoxiuZCh4IETAbATePq1SZNuWzBcI25l2M
	qxiRZz1qiF9lh8BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
	efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
Message-ID: <20241008153232.YwZfzF0r@linutronix.de>
References: <20241007074609.447006177@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241007074609.447006177@infradead.org>

On 2024-10-07 09:46:09 [+0200], Peter Zijlstra wrote:
> Hi!
>=20
> During LPC Thomas reminded me that the lazy preemption stuff was not ther=
e yet.
>=20
> So here goes, robot says it builds, and I checked both a regular and PREE=
MPT_RT
> build boots and can change the mode.
>=20
> Please have a poke.

While comparing this vs what I have:
- need_resched()
  It checked both (tif_need_resched_lazy() || tif_need_resched()) while
  now it only looks at tif_need_resched().
  Also ensured that raw_irqentry_exit_cond_resched() does not trigger on
  lazy.=20
  I guess you can argue both ways what makes sense, just noting=E2=80=A6

- __account_cfs_rq_runtime() and hrtick_start_fair()
  Both have a resched_curr() instead of resched_curr_lazy(). Is this on
  purpose?

This is actually the main difference (ignoring the moving the RT bits
and dynamic-sched). The lazy-resched is slightly different but it should
do the same thing.
I have also tracing and riscv bits which I port tomorrow, test and add
to your pile.

Sebastian

