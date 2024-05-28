Return-Path: <linux-kernel+bounces-192483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED4F8D1DD0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB502859A2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFA416F28C;
	Tue, 28 May 2024 14:01:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB71D16D318
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716904893; cv=none; b=oqWn5JjX3kBE6/ejvNKYOmkQgrIgtbdhcjztjFn44uDfK/xWrl2eXX5HFT8qpbzTSnubV38xHk/U5bems51u8+FvKYT+7jPTDcJaL5o5orQLd+5srhDZcM5REnbsp31m29Nd0qCtZhs6Kr4C5GiA0cNQNqrHC6UsFQlxmKjbEkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716904893; c=relaxed/simple;
	bh=hgfX7M4P5V5VSXvfr5MKFamKM46mUbUoeDFgn0M5Gsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erIhyrHvUyX8/p6AxpDWMpeqimIos4aAmUFlig+URu07MCHU016dce7kv67qtr8vxLemkKoY7q0T33RO5HIJmzsTjvy2zAmTr/cmchrw0wzG4FIonY/SaakKUCzc0+VlC2a9sEBlm66xn5dNeMmJakttbtetTXQFARjgUUhrWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5038AC3277B;
	Tue, 28 May 2024 14:01:30 +0000 (UTC)
Date: Tue, 28 May 2024 10:01:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Li zeming <zeming@nfschina.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: core: Remove unnecessary =?UTF-8?B?4oCYTlVM?=
 =?UTF-8?B?TOKAmQ==?= values from core_rq
Message-ID: <20240528100128.41ee5fbf@rorschach.local.home>
In-Reply-To: <20240528071446.59197-1-zeming@nfschina.com>
References: <20240528071446.59197-1-zeming@nfschina.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 15:14:46 +0800
Li zeming <zeming@nfschina.com> wrote:

> core_rq is assigned first, so it does not need to initialize the
> assignment.

No, it is assigned in a loop. Yes, the loop should always execute once,
but the compiler doesn't know that (hence the WARN_ON() that checks
it). That means removing the NULL assignment will likely cause the
warning from the compiler that the variable may be used uninitialized.

The assignment is there at least to quiet the compiler. It's not a fast
path, and the initialization is not a problem.

NACK.

-- Steve


> 
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e32fea8f5830..346159a24705 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6485,7 +6485,7 @@ static void sched_core_cpu_starting(unsigned int cpu)
>  static void sched_core_cpu_deactivate(unsigned int cpu)
>  {
>  	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
> -	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
> +	struct rq *rq = cpu_rq(cpu), *core_rq;
>  	int t;
>  
>  	guard(core_lock)(&cpu);


