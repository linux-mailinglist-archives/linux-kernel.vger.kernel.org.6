Return-Path: <linux-kernel+bounces-285573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C31950FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81B37B232F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088F11ABECE;
	Tue, 13 Aug 2024 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PjbnVYiz"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5FD1A3BD6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589440; cv=none; b=Mpo2IotWR+vnOPj28U/pxnPzKxWUURawYDvBpLU1Y2WVMImYEwt7Y3LY1V26F8+Wunm9cFVsBiOkeUX2duLmgsgBI1UKQfjUriI/jFZX0rgC1hmhe9KSf4B7aza236L+k4cx+feGd0iMzD6tqH6nvLf64I5epOrQev8Z3KqF5Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589440; c=relaxed/simple;
	bh=NXjGDspvKBWPMnCvTAGp/1b02q5UB8RdhkfgCEdcc0A=;
	h=Message-Id:Date:From:To:Cc:Subject; b=AGXpplU16/ZkxZ7TfJMz0ZwgnXtVOnMqRGCNb5XOk4CefExuIQnDo46/4ToYGbClaROQLQRYhmsMyWKugMhV6gBDRkKq79Vs6wRg//rsp3hI5NitJitF6/0UZzCSZBpJhker75Nd3O7FRgzDhfR6ln7Y84XE2ZIa97DbZXv2C5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PjbnVYiz; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=sDKt5tAIOmqFNTeE89zghwIBTWKXriuWpYV0JsQgISQ=; b=PjbnVYizpA1rJhXt26eZ0K1PCv
	JZrAGkuEfg0RDkHYZPZ3a/DdhsO6ugYxxUG6G2OV7gke8MBoMeMKJw/w6EZyio+QsupeDNMTAMJwJ
	rm+Q8K+jyv63CWbEEb9AXiSZvaX8T30v6kX/XYgoN8T2Zy6FYaO4inqDZP70Ne0f3woa8Am9gTrkT
	u2B1sshIa4+jhLWK4EHo+87IFz8Gue8r9MHJW0l+BCoX9rgb259ZLAOFd85Uxj2WogcdBCZ9vdgo5
	qCn69HwxfzWswOV6cMKdx4XM0l7zFid8dWgfuQPrwmaXBdlh3Q19bwxKANLsTOFFnEY4M2qOVRzlJ
	Ymkaap1g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se0LW-00000007s0z-0iD3;
	Tue, 13 Aug 2024 22:50:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2E58330074E; Wed, 14 Aug 2024 00:50:29 +0200 (CEST)
Message-Id: <20240813222548.049744955@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 14 Aug 2024 00:25:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 tj@kernel.org,
 void@manifault.com
Cc: peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org,
 joelaf@google.com
Subject: [PATCH 0/9] sched: Prepare for sched_ext
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi,

These patches apply on top of the EEVDF series (queue/sched/core), which
re-arranges the fair pick_task() functions to make them state invariant such
that they can easily be restarted upon picking (and dequeueing) a delayed task.

This same is required to push (the final) put_prev_task() beyond pick_task(),
like we do for sched_core already.

This in turn is done to prepare for sched_ext, which wants a final callback to
be in possesion of the next task, such that it can tell if the context switch
will leave the sched_class.

As such, this all re-arranges the current order of:

  put_prev_task(rq, prev);
  next = pick_next_task(rq); /* implies set_next_task(.first=true); */

to sometihng like:

  next = pick_task(rq)
  if (next != prev) {
    put_prev_task(rq, prev, next);
    set_next_task(rq, next, true);
  }

The patches do a fair bit of cleaning up. Notably a bunch of sched_core stuff
-- Joel, could you please test this stuff, because the self-tests we have are
hardly adequate.

The EEVDF stuff was supposed to be merged already, but since Valentin seems to
be doing a read-through, I figured I'd give him a little extra time. A complete
set can be found at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/prep


