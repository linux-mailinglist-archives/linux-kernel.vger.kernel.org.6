Return-Path: <linux-kernel+bounces-247787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7E792D48A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBDF2B21C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15EE193462;
	Wed, 10 Jul 2024 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQSHrNF4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3157915E97
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720623124; cv=none; b=ovAkECVaQVfC5JhMEH5w2349QYR1vj1vpZQA+mh3pDEJijHlyziEXuUyGbeumxFLeq2AeMbHnimC6s+PO2nxi2ykyMuA8zZ3Vb2Z08OE47SEJ7KD5WR5j/YiTZaIYV0zSGTeJktW59Trvsrjia1Id0lXsjOemyv1QbbK+B2GRQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720623124; c=relaxed/simple;
	bh=6v7MmdrjvBjtmq4zAnDalq+Hgqf5n1EhZ9LB18i61Eo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VJkgfR2MScrG5oe0tlFI5ntDIw/qDusT7y9N1d10MvQmg+o0zYMvDg79T84Dq/Hv2N2vT7euGiu1p8y61buxDJI5hu27c7QKLPCLAGdu0caPC+o8M8PWDmW1SxssWVItwOY8L111rMS24lBeO5qGTECGh0qLOqdvFeCWqCvy7JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQSHrNF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7331C4AF0B;
	Wed, 10 Jul 2024 14:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720623123;
	bh=6v7MmdrjvBjtmq4zAnDalq+Hgqf5n1EhZ9LB18i61Eo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IQSHrNF40+znhWV4VRq7IgRW+TixQaGFJ8XLTew5eJfUnuojkPpswwflD90TTFfQO
	 Rejzghwon6KCVmog+zTQPzit+fPteKrqmAcECIyiPxnAgsSGpc3fCS1I6yLeocI1Wb
	 g7GU4JNCp54Bdat10EaseweEbdAeNNhu6JFbbLGUp8d+sokynJrtsuSYImBd7bYf1l
	 R2pTtSVLGeuRK5yluHMK6m1mbcZpTM9Z8NXL+fEjxBHGMi0HjOgehbyXidQAsehNXV
	 IZBUAKNf60fbPpOv+hBFKDAWRURoMCf/Ctp9zDWX+NpK1YaBhA9GU6wx4l89oN9FWV
	 qj+MmF96UZDZA==
Date: Wed, 10 Jul 2024 23:51:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, peterz@infradead.org, clm@meta.com, jolsa@kernel.org,
 mingo@kernel.org, paulmck@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] uprobes: document the usage of mm->mmap_lock
Message-Id: <20240710235159.23b8bc0f5247c358ccea699d@kernel.org>
In-Reply-To: <20240710140045.GA1084@redhat.com>
References: <20240710140017.GA1074@redhat.com>
	<20240710140045.GA1084@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 16:00:45 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> The comment above uprobe_write_opcode() is wrong, unapply_uprobe() calls
> it under mmap_read_lock() and this is correct.
> 
> And it is completely unclear why register_for_each_vma() takes mmap_lock
> for writing, add a comment to explain that mmap_write_lock() is needed to
> avoid the following race:
> 
> 	- A task T hits the bp installed by uprobe and calls
> 	  find_active_uprobe()
> 
> 	- uprobe_unregister() removes this uprobe/bp
> 
> 	- T calls find_uprobe() which returns NULL
> 
> 	- another uprobe_register() installs the bp at the same address
> 
> 	- T calls is_trap_at_addr() which returns true
> 
> 	- T returns to handle_swbp() and gets SIGTRAP.
> 
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/events/uprobes.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 2c83ba776fc7..d52b624a50fa 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -453,7 +453,7 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
>   * @vaddr: the virtual address to store the opcode.
>   * @opcode: opcode to be written at @vaddr.
>   *
> - * Called with mm->mmap_lock held for write.
> + * Called with mm->mmap_lock held for read or write.
>   * Return 0 (success) or a negative errno.
>   */
>  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> @@ -1046,7 +1046,12 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
>  
>  		if (err && is_register)
>  			goto free;
> -
> +		/*
> +		 * We take mmap_lock for writing to avoid the race with
> +		 * find_active_uprobe(), install_breakpoint() must not
> +		 * make is_trap_at_addr() true right after find_uprobe()
> +		 * returns NULL.

Sorry, I couldn't catch the latter part. What is the relationship of
taking the mmap_lock and install_breakpoint() and is_trap_at_addr() here?

You meant that find_active_uprobe() is using find_uprobe() which searchs
uprobe form rbtree? But it seems uprobe is already inserted to the rbtree
in alloc_uprobe() so find_uprobe() will not return NULL here, right?

Thank you,

> +		 */
>  		mmap_write_lock(mm);
>  		vma = find_vma(mm, info->vaddr);
>  		if (!vma || !valid_vma(vma, is_register) ||
> -- 
> 2.25.1.362.g51ebf55
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

