Return-Path: <linux-kernel+bounces-223439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D03FE9112FC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7741C2190C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FF11BA87E;
	Thu, 20 Jun 2024 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QbA0ZBkv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9721BA86F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718914810; cv=none; b=nHL0hhg7rsbISeeN4QXh4V2S3iXmgbblXgTQVNlv5Zj5zvCsh2IhTWrsEM3mkSAQ+RVmVxL5Bxv5KkSckpDTXK2Lkh7po8p0WoLkwlb12nzH+qHbiqBjUeRkQF5wuk0oSYVuigM0NLEG0BFAI8rLTxNhD4C590UWLwexZqu/gks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718914810; c=relaxed/simple;
	bh=PtxNTecXGccGW5GNzW6Jx+zQBTKFKysFM00Tb72eOWg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MJIlv1WYWqJdGwgUHEkTuM9WhD36BfesOi/zPW3T53OZFhlYn23Ut4a6VFujt534ctOlY4KmkLMA19PcRh8hjxVYcdmZ3Teip9TTXYCBwrvUE2rgBswHh/XkI+PVfE8V2QudTwdh735pyFJcEGgeWVLM5pM90nnGmtOxR7v+YNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QbA0ZBkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DFCC4AF09;
	Thu, 20 Jun 2024 20:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718914810;
	bh=PtxNTecXGccGW5GNzW6Jx+zQBTKFKysFM00Tb72eOWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QbA0ZBkv3vOJ4F6l5i8kroD30/BnBfE+660CSwKPvAulAu/jcGt4hodf1cfAJqbxU
	 1QeMrUyahNbj2As8zNDgDUn+PCRBMYJ0WTvHjeza1Xrm+FiGHC3befdMwTpkJ9CUB9
	 LV7hoUEWqdwXmjwhYi5xAttpyHaSgMvQpbsdO20w=
Date: Thu, 20 Jun 2024 13:20:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: alexjlzheng@gmail.com
Cc: brauner@kernel.org, axboe@kernel.dk, oleg@redhat.com,
 tandersen@netflix.com, willy@infradead.org, mjguzik@gmail.com,
 alexjlzheng@tencent.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: optimize the redundant loop of
 mm_update_owner_next()
Message-Id: <20240620132009.d354aadd6e79999f2d61dd14@linux-foundation.org>
In-Reply-To: <20240620122123.3877432-1-alexjlzheng@tencent.com>
References: <20240620122123.3877432-1-alexjlzheng@tencent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 20:21:24 +0800 alexjlzheng@gmail.com wrote:

> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> When mm_update_owner_next() is racing with swapoff (try_to_unuse()) or /proc or
> ptrace or page migration (get_task_mm()), it is impossible to find an
> appropriate task_struct in the loop whose mm_struct is the same as the target
> mm_struct.
> 
> If the above race condition is combined with the stress-ng-zombie and
> stress-ng-dup tests, such a long loop can easily cause a Hard Lockup in
> write_lock_irq() for tasklist_lock.

This is not an optimization!  Userspace-triggerable hard lockup is a
serious bug.

> Recognize this situation in advance and exit early.
> 
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
>  kernel/exit.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index f95a2c1338a8..81fcee45d630 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -484,6 +484,8 @@ void mm_update_next_owner(struct mm_struct *mm)
>  	 * Search through everything else, we should not get here often.
>  	 */
>  	for_each_process(g) {
> +		if (atomic_read(&mm->mm_users) <= 1)
> +			break;
>  		if (g->flags & PF_KTHREAD)
>  			continue;
>  		for_each_thread(g, c) {

I agree that the patch is an optimization in some cases.  But does it
really fix the issue?  Isn't the problem simply that this search is too
lengthy?

Isn't it still possible for this search to have taken too much time
even before the new test triggers?

I wonder if this loop really does anything useful.  "we should not get
here often".  Well, under what circumstances *do* we get here?  What
goes wrong if we simply remove the entire loop?

