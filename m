Return-Path: <linux-kernel+bounces-342046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426D3988A04
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8892F283428
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25931C1AD6;
	Fri, 27 Sep 2024 18:19:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846091C1AB0;
	Fri, 27 Sep 2024 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727461170; cv=none; b=tICGtQvzm/ee01ZRqy+AZtVlsni3zCwBGwIuIoCpvwtpVLd4Q8/33a4TsbDZ3fjyFajLhVGts4cvt9GfJ7lHFAc4ezE8682p+j06eeBzz6P6rJtubHtop2k7/8NOfGHt0VGOKpLkDlethHHNeJQ3rvhYHbaXPcz9fCju1BfpPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727461170; c=relaxed/simple;
	bh=ExF5NdFyt2gwt2UFq/9gjmINDypBVoNqff3CF4CiT9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nncGqzeRocrTdZgQ8z6YP1g3Vgc9ZxN/OWVapLlVSF5qavAPExbgz5ZaL+kCjlYV5ZKssXTSfgt3kHTcwjsV9PcI1Q/aBhgzjO96XEbgKQAMgCq0ackaSU4dPm7ZbYiRqNodRRUadPgfKO0ud8HQJKSi9nCr/04VdvO+3bxMCWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A3FC4CEC4;
	Fri, 27 Sep 2024 18:19:29 +0000 (UTC)
Date: Fri, 27 Sep 2024 14:20:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Masami Hiramatsu
 <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the ftrace tree with Linus' tree
Message-ID: <20240927142009.16fe7e19@gandalf.local.home>
In-Reply-To: <CAEf4BzbU_hzj=BQQC5arRwN5TY+vHS9S9acts=c1kX28C95zkg@mail.gmail.com>
References: <20240927113620.7a673f55@canb.auug.org.au>
	<CAEf4BzbU_hzj=BQQC5arRwN5TY+vHS9S9acts=c1kX28C95zkg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Sep 2024 11:13:30 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> Hm... sounds like two versions of my patch were applied to two
> different trees or something? FWIW, 10cdb82aa77f is the right one cto
> pick (I didn't check which one is in Linus' tree), but the differences
> are tiny.
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 87b468d93f6a..c3df411a2684 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -834,7 +834,7 @@ static int probes_profile_seq_show(struct seq_file
> *m, void *v)
> 
>         nhits = 0;
>         for_each_possible_cpu(cpu) {
> -               nhits += READ_ONCE(*per_cpu_ptr(tu->nhits, cpu));
> +               nhits += per_cpu(*tu->nhits, cpu);
>         }
> 
>         seq_printf(m, "  %s %-44s %15lu\n", tu->filename,
> 
> >

It looks like Masami rebased his tree and I didn't do the update yet.

I updated the latest for-next in the tracing repo, so everything should be
good again.

-- Steve


