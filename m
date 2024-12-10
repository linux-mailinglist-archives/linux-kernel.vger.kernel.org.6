Return-Path: <linux-kernel+bounces-439840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91229EB49E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5036C188DB10
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81E21BBBCA;
	Tue, 10 Dec 2024 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fj55Kfpi"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0B31BBBCC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843956; cv=none; b=Bp3zrmSIXBEJBJgD08yQPwItHABlSHmIHRYtJzPXvId6e4nNE2Ht88UzEmUPGZbXB4vDLkKf7MKprUe5nL8gx8mkMEudhQPcEq/ja9eYEeTBxsDkO8sJIWigIbhAbR20UkKjpuJELYY/8GFfbgn0bAYhN/9XG8zR+xi3YSj6GYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843956; c=relaxed/simple;
	bh=Gg2oNBjNBXY01WDBSRXddcnxNvbCRBHKzceAlww11Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vxl8ROvJSSX8yWOFU3mZmTXyhH71HBZSNYMucGRXNDvXkYF591yJdOd3eQl3tMw5ZKj4mMyw9C8C6jQjXA3KqFaFRyF40ICmTLsqviLbTP66IypmS5Z7cQPCxkaYEK5kdr0Xk08QLtmSF8M1hpwYStF8SA+rUvqh6QGh/lvPoSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fj55Kfpi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k0faFFEYVoBv9xcNQAGoF2CE+4Y2G63vAsBhrti6hWA=; b=fj55KfpiM0zkYOHH7CHnZEjGAk
	HedwhOG1es1tNJjEPoPJ1L6aImbPVR7mKcxzuo581jHwGd19yPa4p3+xfIfavEk6PaMdJz0gm743m
	7FRnX1en86fdVvKZlD7IqPs4UBJ93Ao2fXR2tWE0iIGdb/DIwD8ngUL4Zq+L0R2NrVpQ9HpZirE4R
	fkA7adfksP0+1LN6wZB+IXyzY72hJZEToCvVk3s7FEv6z6X9LewoX6tBp6iz8Bj42fBtoO7IqyQ3W
	e3un8CzuRGQac+UWk0s4+cP9I6DZQ9a8RkDwJTPkYKcJNCNR223JxBcec/1KQqJ/xDGMnm9qhtCtW
	IXs2KigQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tL20s-0000000A3eJ-0wQQ;
	Tue, 10 Dec 2024 15:19:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9BFEE300402; Tue, 10 Dec 2024 16:18:59 +0100 (CET)
Date: Tue, 10 Dec 2024 16:18:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, mhiramat@kernel.org,
	oleg@redhat.com, Jann Horn <jannh@google.com>,
	syzbot <syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] general protection fault in
 find_mergeable_anon_vma
Message-ID: <20241210151859.GW35539@noisy.programming.kicks-ass.net>
References: <4d05caee-d900-42e5-84e1-448cc62435b2@lucifer.local>
 <emgf7rbacg4jqsnyg2mgmlbbeehc34o33fpnkmlaghb3xynzjx@gmldlwjliwiv>
 <c946c9d2-aff3-4492-99d1-d50e6e2659f6@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c946c9d2-aff3-4492-99d1-d50e6e2659f6@lucifer.local>

On Mon, Dec 09, 2024 at 05:09:13PM +0000, Lorenzo Stoakes wrote:
> On Mon, Dec 09, 2024 at 11:12:52AM -0500, Liam R. Howlett wrote:
> > +Cc maintainers listed of kernel/events/uprobe.c
> >
> > TL;DR:
> > dup_mmap() fails, but uprobe thinks it's fine and keeps trying to use an
> > incomplete mm_struct.
> >
> > We're looking for a way to signal to uprobe to abort, cleanly.
> >
> > Looking at kernel/fork.c, dup_mmap():
> >
> > fail_uprobe_end:
> >         uprobe_end_dup_mmap();
> >         return retval;
> >
> > So uprobe is aware it could fail, but releases the semaphore and then
> > doesn't check if the mm struct is okay to use.
> >
> > What should happen in the failed mm_struct case?
> >
> > Thanks,
> > Liam
> >
> 
> (As discussed on IRC) how about moving up the dup_mmap_sem lock one level, we
> can put the mm before the rmap lookup in build_map_info() is able to find it,
> which should avoid the whole issue?
> 
> Untested patch attached.

Urgh, bit of a maze this. So BPF does a uprobe_register(), which walks
rmap and finds an incomplete mm.

uprobe_{start,end}_dup_mmap() serialize uprobe_register(), but are too
narrow to cover the whole fail case.

So *bang* happens.

The below moves this serialization up to cover the whole of dup_mmap(),
such that register can no longer find partial mm's in the rmap.

Which will cure problem, but it does leave me uncomfortable vs other
rmap users.

Also, you need to fix fail_uprobe_end label, that's left dangling as is.

> ----8<----
> From 629b04fe8cfdf6b4fad0ff91a316d4643ccd737d Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Mon, 9 Dec 2024 16:58:14 +0000
> Subject: [PATCH] tmp
> 
> ---
>  kernel/fork.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 1450b461d196..4d62e776c413 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -639,7 +639,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  	LIST_HEAD(uf);
>  	VMA_ITERATOR(vmi, mm, 0);
> 
> -	uprobe_start_dup_mmap();
>  	if (mmap_write_lock_killable(oldmm)) {
>  		retval = -EINTR;
>  		goto fail_uprobe_end;
> @@ -783,7 +782,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  	else
>  		dup_userfaultfd_fail(&uf);
>  fail_uprobe_end:
> -	uprobe_end_dup_mmap();
>  	return retval;
> 
>  fail_nomem_anon_vma_fork:
> @@ -1692,9 +1690,11 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
>  	if (!mm_init(mm, tsk, mm->user_ns))
>  		goto fail_nomem;
> 
> +	uprobe_start_dup_mmap();
>  	err = dup_mmap(mm, oldmm);
>  	if (err)
>  		goto free_pt;
> +	uprobe_end_dup_mmap();
> 
>  	mm->hiwater_rss = get_mm_rss(mm);
>  	mm->hiwater_vm = mm->total_vm;
> @@ -1709,6 +1709,7 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
>  	mm->binfmt = NULL;
>  	mm_init_owner(mm, NULL);
>  	mmput(mm);
> +	uprobe_end_dup_mmap();
> 
>  fail_nomem:
>  	return NULL;
> --
> 2.47.1

