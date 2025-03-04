Return-Path: <linux-kernel+bounces-545778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4C8A4F148
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08DFC3A900E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D688278115;
	Tue,  4 Mar 2025 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EoRZKUy3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86D2620EF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 23:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130157; cv=none; b=InqyYcRC2wKY4zD7DM8rKF44ImTyxMp9HxuIm89Q4MMyaTEn8l3qaOtE/k1qb2NOjX1QGZBxiHs/vqhSZRt1vDtRk6sggwxPcoIHYnLh+rUGfOjxMP122MIzetIhPLMetZHFrQxQG+akE85yjOOlhL9wIcEOsGHzVy+d3Fh+ay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130157; c=relaxed/simple;
	bh=2txhcLgzVWb+dW/4Gd1kiuD+BIpXnIJ+gXwCmx8kpbw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l9bcAinHJsN0AwfNs9yIPfXIzOzD5WF8BkanwO2ryajSlgUGGdrnLPurMcIljaeihsLVUMWPdy825bGYJ6iIgFo1IB31KVqt282waoTY/p+N5fzfBZyyGlj3esUdeSSdEtBlwhG0vFyXSqvRPq52Q2Gqq0+UpIKXdtCn8yJFSz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EoRZKUy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDE1C4CEE5;
	Tue,  4 Mar 2025 23:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741130157;
	bh=2txhcLgzVWb+dW/4Gd1kiuD+BIpXnIJ+gXwCmx8kpbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EoRZKUy3ieMDVjUy7tnt+KDs52VME2kCRbAxOpC4ExjSHbisnmDrTHAuBRzgo82F1
	 /IyLQoUqyhrFkltu7mwDqNrP/sCP0Nf1l927hQ1+BOlhzrsfcbKhQwajGY+ku3CXFA
	 7fVCKdZaPpjStmn6PTfoTXv62HqD3uBumWXCXPts=
Date: Tue, 4 Mar 2025 15:15:56 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn
 <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] mm/mremap: initial refactor of move_vma()
Message-Id: <20250304151556.635d9041a7ca36f1960fe664@linux-foundation.org>
In-Reply-To: <Z8d0d9N26JBGwi8N@google.com>
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
	<b4e64684d6ac753d5a66c0da0da5f4b94d033859.1740911247.git.lorenzo.stoakes@oracle.com>
	<Z8d0d9N26JBGwi8N@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 21:45:27 +0000 Yosry Ahmed <yosry.ahmed@linux.dev> wrote:

> On Mon, Mar 03, 2025 at 11:08:34AM +0000, Lorenzo Stoakes wrote:
> > Update move_vma() to use the threaded VRM object, de-duplicate code and
> > separate into smaller functions to aid readability and debug-ability.
> > 
> > This in turn allows further simplification of expand_vma() as we can simply
> > thread VRM through the function.
> > 
> > We also take the opportunity to abstract the account charging page count
> > into the VRM in order that we can correctly thread this through the
> > operation.
> > 
> > We additionally do the same for tracking mm statistics - exec_vm, stack_vm,
> > data_vm, and locked_vm.
> > 
> > As part of this change, we slightly modify when locked pages statistics are
> > counted for in mm_struct statistics. However this should cause no issues,
> > as there is no chance of underflow, nor will any rlimit failures occur as a
> > result.
> > 
> > This is an intermediate step before a further refactoring of move_vma() in
> > order to aid review.
> > 
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> [..]
> > +/*
> > + * Perform checks  before attempting to write a VMA prior to it being
> > + * moved.
> > + */
> > +static unsigned long prep_move_vma(struct vma_remap_struct *vrm,
> > +				   unsigned long *vm_flags_ptr)
> > +{
> > +	unsigned long err;
> 
> I am getting a warning on mm-unstable because 'err' is sometimes used
> uninitialized, I think here:
> 
>         if (vma->vm_ops && vma->vm_ops->may_split) {
>                 if (vma->vm_start != old_addr)
>                         err = vma->vm_ops->may_split(vma, old_addr);
>                 if (!err && vma->vm_end != old_addr + old_len)
>                         err = vma->vm_ops->may_split(vma, old_addr + old_len);
>                 if (err)
>                         return err;
>         }

yep, thanks.  I added this:

--- a/mm/mremap.c~mm-mremap-initial-refactor-of-move_vma-fix
+++ a/mm/mremap.c
@@ -892,7 +892,7 @@ static void vrm_stat_account(struct vma_
 static unsigned long prep_move_vma(struct vma_remap_struct *vrm,
 				   unsigned long *vm_flags_ptr)
 {
-	unsigned long err;
+	unsigned long err = 0;
 	struct vm_area_struct *vma = vrm->vma;
 	unsigned long old_addr = vrm->addr;
 	unsigned long old_len = vrm->old_len;
_


