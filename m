Return-Path: <linux-kernel+bounces-349548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F3998F820
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F131C2102F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C111A76CE;
	Thu,  3 Oct 2024 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dCvxBh9N"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4C6224D1
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727987488; cv=none; b=gfHQ71rkOIiPlUQCnPsdNUEfio17ReUVhNOKzIVE4bfVpHf5cV0mPvxvgmJoufxdutgp8YoPkfYS0jl9WRAiVJWD6rVAhVZyuKLOu5h1BmYeamBMUdrZOi5qWIFrDlX1AXdiqAtIQ2ZxQTpogooj/DqJbL1F3uSn4KlQczfXn+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727987488; c=relaxed/simple;
	bh=mPpk9zWDMt7VgRH7i4nMSnpxGbCme3rEz91hGbFdnlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4lfcNTvCWLoE5F4RXlBI90Wx4MGs4gRISkcIhc1sohnAspzKHYa0TmSpK7jLDt2R+PH9jB3WUfEMBEqD29DQE2a+k8i2Mnb9pgvh0A/avdYdy65nqx6z2UbEYXeE+QPPZRuVhzwhAHeV9tAqlMUJ77BIqsolKZvXv8tjsLN/Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dCvxBh9N; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y93QfhMbNUGJ3Zi7gxrPO0Kcu0rDQNeWR7L7Fu7eqS0=; b=dCvxBh9NAQBMVql/1THdU8AoG+
	9FxX7GTA8uQSRxxHesgCFjWVNKVEOI+6oKure5aiksOi8oxE8v9hw8ODqPdymetzQJT2BIzvvxsUl
	2B8RNXRnSPpJGMvQ90NjiciorOiWa1T+mcYaoOp12GtrkAnYxCaYuQsQ2ghlmWQEQ84y2b1UBNPBP
	kPhAatbZmCav9z8RE7nUJSUmvpxOVJ2lq0ZDLuzvyrr9SVbEYy8oCTZH4BO5WqBA5kXW3XFgiJxqC
	NHJUkBNOP7civYbf0aMZ47Uc5OSxnwkk0XaFvTIJMww5H4YkDxZAr1YFbqfJ6imjE9elCwkkmkGl/
	jZgy0pww==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swSTl-00000008gio-3lsn;
	Thu, 03 Oct 2024 20:31:17 +0000
Date: Thu, 3 Oct 2024 21:31:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: manas18244@iiitd.ac.in
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anup Sharma <anupnewsmail@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fixes: null pointer dereference in pfnmap_lockdep_assert
Message-ID: <Zv7_Fcg4cvzwi7LS@casper.infradead.org>
References: <20241003-fix-null-deref-v1-1-0a45df9d016a@iiitd.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003-fix-null-deref-v1-1-0a45df9d016a@iiitd.ac.in>

On Thu, Oct 03, 2024 at 09:31:06PM +0530, Manas via B4 Relay wrote:
> From: Manas <manas18244@iiitd.ac.in>
> 
> syzbot has pointed to a possible null pointer dereference in
> pfnmap_lockdep_assert. vm_file member of vm_area_struct is being
> dereferenced without any checks.
> 
> This fix returns if vm_file member in vm_area_struct is NULL.

This seems like the wrong fix.  It's mmap'ing a file, so vm_file should
not be NULL.  Or have I forgotten something very important about how the
MM works?

> Reported-by: syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=093d096417e7038a689b
> ---
> This bug[1] triggers a general protection fault in follow_pfnmap_start
> function. An assertion pfnmap_lockdep_assert inside this function
> dereferences vm_file member of vm_area_struct. And panic gets triggered
> when vm_file is NULL.
> 
> This patch returns from the assertion pfnmap_lockdep_assert if vm_file
> is found to be NULL.
> 
> [1] https://syzkaller.appspot.com/bug?extid=093d096417e7038a689b
> 
> Signed-off-by: Manas <manas18244@iiitd.ac.in>
> ---
>  mm/memory.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 2366578015ad..b152a95e543f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6346,6 +6346,9 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
>  static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
>  {
>  #ifdef CONFIG_LOCKDEP
> +	if (!vma->vm_file)
> +		return;
> +
>  	struct address_space *mapping = vma->vm_file->f_mapping;
>  
>  	if (mapping)
> 
> ---
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> change-id: 20241003-fix-null-deref-6bfa0337efc3
> 
> Best regards,
> -- 
> Manas <manas18244@iiitd.ac.in>
> 
> 
> 

