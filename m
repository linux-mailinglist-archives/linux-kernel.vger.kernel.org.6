Return-Path: <linux-kernel+bounces-250561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4383592F911
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6111F23CD7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E744B158A35;
	Fri, 12 Jul 2024 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaMh4ffo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA2614E2E8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720780666; cv=none; b=hEv5mMrtytowA1gJTc5tahvCeDPPpHmkjlkwzxUgiRegk1Nhg63Cbgx45Exn6sExzJhzk77XIpIQ2rB1DPrinX67dcWAjbSJcLDMLDd77DZukBIBQCuhOZu0cTcchK4ai/YPG1uHGVi6JK0D/VO+SC8kyRVn93fdLL8fKQMYdGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720780666; c=relaxed/simple;
	bh=qz2O/MprPmBzNSiPtCWHRajDdNanqFOrS14tWtMM04Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imsFb7gy/8a0nQLLinN0fa4gYvFa0CsQadLU47y8h2awZvleU1OvAGsxdSxE+cnQHCXw4RkeG1LaKz2XA2D/6VFs5mg4mgpsMNwq7uWFYUjfXK4oah9CuaXND/eA77yZptfzvstIKu7aQlgtVcj/6rjgW3ES3pN5g6H5Ql0q2dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WaMh4ffo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720780663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GxLBBwSqa+0c5TKVpHyNF//OUvkQJIf+ltYzYVrXt3E=;
	b=WaMh4ffoI7EnjFudaO/fXZyQjPK7TDYkJApQ+HceLEdgaX38p2kcY35OgDxm5pjkyXXmol
	uE5wG6UsFzi+2J8Q5f1xznKAJipUNz9eotEZETEtoMWSMYJW0MsRR1fIbH0VI2cPwMhMNP
	f58zQVd5URCLfN23meqZPE6K16yHTJ8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-8EXkAw8vOXOxbx0nUEOgqQ-1; Fri,
 12 Jul 2024 06:37:39 -0400
X-MC-Unique: 8EXkAw8vOXOxbx0nUEOgqQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D774B1955BCE;
	Fri, 12 Jul 2024 10:37:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.173])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D146D19560AA;
	Fri, 12 Jul 2024 10:37:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 12 Jul 2024 12:35:57 +0200 (CEST)
Date: Fri, 12 Jul 2024 12:35:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Phil Auld <pauld@redhat.com>, Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH v3 03/10] task_work, sched: Add a _locked variant to
 task_work_cancel()
Message-ID: <20240712103544.GB31100@redhat.com>
References: <20240711130004.2157737-1-vschneid@redhat.com>
 <20240711130004.2157737-4-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711130004.2157737-4-vschneid@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 07/11, Valentin Schneider wrote:
>
> Later commits will need to issue a task_work_cancel() from within the
> scheduler with the task's ->pi_lock held.
>
> Add a _locked variant that expects p->pi_lock to be held. Expose it in a
> separate scheduler header file, as this really is a scheduler-only
> interface.
>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/sched/task_work_sched.h | 14 +++++++
>  kernel/task_work.c             | 67 ++++++++++++++++++++++++++--------
>  2 files changed, 66 insertions(+), 15 deletions(-)
>  create mode 100644 kernel/sched/task_work_sched.h

I am not sure the new task_work_sched.h makes sense, but I won't argue.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


