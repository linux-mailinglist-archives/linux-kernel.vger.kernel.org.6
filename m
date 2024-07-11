Return-Path: <linux-kernel+bounces-248449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8811792DD4A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F971C21B75
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5662A64D;
	Thu, 11 Jul 2024 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkezWg/q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79A36C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720656428; cv=none; b=ApV9BCgWsLN17wzHJT6MT7wyFDd+dKAiWKndpKLPsBZFmlLhVPvjuLJ3JFI1K+BBEBAcKxkF6Z3TdRKAap1jWIzqMLUoDyjzG78hHM92TTRwVSolHsMaGVwTKDGuuGTGODIxB6nRh++sRzjyHlsR1rmdbPVlmFpqfI+Pif5ZCIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720656428; c=relaxed/simple;
	bh=xHh00YildqCYFquwkJLPao1gWzbY+zfZiQ6Mt3A0MBg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BuvDHKSmxgUdp/YTd8fHKgCdBywFEO9cikQsSYr05jV/HpP6XwlKKentxwptbwHgVR1XKNm7RL6iRpls4GHg+6vrXAD31GG7CC3Cw8XWd+VULRcBxj3Zuy+gTpVNhrWgpEkTLWwK24bMLI5XUfC3siTKGL+L5ns8zZouWr5TZFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkezWg/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74790C32781;
	Thu, 11 Jul 2024 00:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720656428;
	bh=xHh00YildqCYFquwkJLPao1gWzbY+zfZiQ6Mt3A0MBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NkezWg/qqsIAV3Ix8X9MnPrkaEqopHK1jOMNNhc926kdMpH21GvomkynwsYIgVE4a
	 rr+60cy3SCQR1aGmNb6xGooKrW3ZQmm4g6BbpvFXHNbYoUTtD9zJ/KBMlg7a8ih4Ri
	 FDqszWV11ZMGqG6+70oFKSQD8jtxzE1+BNPIcw42txkN+3rjjP/Pf9tZm47Zw9ZAFq
	 yYtzOLMWjvL0ffqMj4gXoUvGccUnQmvSPo1rd9D4wj0RYwKQBsWaVc0xfvNMyWmNML
	 Tbp6YQ9Q6duFQhr+wpqpg7TiJi8iMaEs40FdETnEGr6/ag6Dqup85blv/C5yjXNMJ1
	 zd7qKvAWC1kMQ==
Date: Thu, 11 Jul 2024 09:07:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, peterz@infradead.org, clm@meta.com, jolsa@kernel.org,
 mingo@kernel.org, paulmck@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] uprobes: document the usage of mm->mmap_lock
Message-Id: <20240711090704.556216a0bca595ad44ee9dbf@kernel.org>
In-Reply-To: <20240710151006.GB9228@redhat.com>
References: <20240710140017.GA1074@redhat.com>
	<20240710140045.GA1084@redhat.com>
	<20240710235159.23b8bc0f5247c358ccea699d@kernel.org>
	<20240710151006.GB9228@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 17:10:07 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 07/10, Masami Hiramatsu wrote:
> >
> > On Wed, 10 Jul 2024 16:00:45 +0200
> > Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > The comment above uprobe_write_opcode() is wrong, unapply_uprobe() calls
> > > it under mmap_read_lock() and this is correct.
> > >
> > > And it is completely unclear why register_for_each_vma() takes mmap_lock
> > > for writing, add a comment to explain that mmap_write_lock() is needed to
> > > avoid the following race:
> > >
> > > 	- A task T hits the bp installed by uprobe and calls
> > > 	  find_active_uprobe()
> > >
> > > 	- uprobe_unregister() removes this uprobe/bp
> > >
> > > 	- T calls find_uprobe() which returns NULL
> > >
> > > 	- another uprobe_register() installs the bp at the same address
> > >
> > > 	- T calls is_trap_at_addr() which returns true
> > >
> > > 	- T returns to handle_swbp() and gets SIGTRAP.
> 
> ...
> 
> > >  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> > > @@ -1046,7 +1046,12 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
> > >
> > >  		if (err && is_register)
> > >  			goto free;
> > > -
> > > +		/*
> > > +		 * We take mmap_lock for writing to avoid the race with
> > > +		 * find_active_uprobe(), install_breakpoint() must not
> > > +		 * make is_trap_at_addr() true right after find_uprobe()
> > > +		 * returns NULL.
> >
> > Sorry, I couldn't catch the latter part. What is the relationship of
> > taking the mmap_lock and install_breakpoint() and is_trap_at_addr() here?
> 
> Please the the changelog above, it tries to explain this race with more
> details...

OK, but it seems we should write the above longer explanation here.
What about the comment like this?

/*
 * We take mmap_lock for writing to avoid the race with
 * find_active_uprobe() and is_trap_at_adder() in reader
 * side.
 * If the reader, which hits a swbp and is handling it,
 * does not take mmap_lock for reading, it is possible
 * that find_active_uprobe() returns NULL (because
 * uprobe_unregister() removes uprobes right before that),
 * but is_trap_at_addr() can return true afterwards (because
 * another thread calls uprobe_register() on the same address).
 * This causes unexpected SIGTRAP on reader thread.
 * Taking mmap_lock avoids this race.
*/

> 
> > You meant that find_active_uprobe() is using find_uprobe() which searchs
> > uprobe form rbtree?
> 
> Yes,
> 
> > But it seems uprobe is already inserted to the rbtree
> > in alloc_uprobe() so find_uprobe() will not return NULL here, right?
> 
> uprobe_register() -> alloc_uprobe() can come after
> find_active_uprobe() -> find_uprobe() returns NULL.
> 
> Now, if uprobe_register() -> register_for_each_vma() used mmap_read_lock(), it
> could do install_breakpoint() before find_active_uprobe() calls is_trap_at_addr().
> 
> In this case find_active_uprobe() returns with uprobe == NULL and is_swbp == 1,
> handle_swbp() treat this case as the "normal" int3 without uprobe and do
> 
> 	if (!uprobe) {
> 		if (is_swbp > 0) {
> 			/* No matching uprobe; signal SIGTRAP. */
> 			force_sig(SIGTRAP);
> 
> Does this answer your question?

No, thanks for the explanation.

Thank you!

> 
> Oleg.
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

