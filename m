Return-Path: <linux-kernel+bounces-408525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 767C79C8003
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D71F1F23249
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80A81DC075;
	Thu, 14 Nov 2024 01:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XKY3DVkT"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7590EE573
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731547921; cv=none; b=GDscmLQiCIY1tKs8h5YpWw2YCyjwipKUhPhtd0uAr9OWv5ufyuvS6df2vU/tCgNmJtUK5VnLR5NIq9+/sBAusQ3rz+4klbdVNLiVdABurKejzlmGdPpnQrhMIj3zwfJ6wxqnxQFitA3/82/lil7DpQoJJqaZ1G83pfugVqYpJLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731547921; c=relaxed/simple;
	bh=02xwN1Tg1EgqsZwrGVNMZad7q32powaUqRFsUciLUtQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=flSROx+IarlYkdpa5N93ucIq+F35Q7MMGwvcsUi7TbJBkwdoTm/i4cLWkA0Dzupdhpfh/Ku6DJkLclm/2BYchv0ZXvfzxsZXs1w1ZEY/XBdfRAv/F2misRPgyTgR4feaSJa3BiFp0y9Hr2KC2+zjXaOja/rXkJJb9eFsiAPuOcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XKY3DVkT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-211c1bd14f6so2315165ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 17:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731547919; x=1732152719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D2fhl252bm516NpmPrHeKOKvYyVObr6Huw6uoNZ0xnE=;
        b=XKY3DVkTF9C9wbkBWfcsQGFGVt5zF2KF9Ce5OHPyBinFgbZe266gPvO4KNGRnvJskQ
         AiDmgsNDK1JpOLpvYPTr1HUTtQiJv4JC/wDB0lyLg/YEhX+seoG9E9XRoPcsC5g6fyHy
         2w0Wd9UWtKfm7DHc/SR0dzAOBaWNBUwlYQZX1Rzf7PazcrkrbrmpUrpSrPF1mN8ggkNH
         +/8at06sNEWjjeSc2NLVXtwOocdvIPeIDwZLZlhPGq28QKq8fW3Ut8Ax8sRWWZ0KpQSK
         8WM0CBm6xXxb2lKbZMZmAcEKTjpw78l/sNYfpaAnAowGdXuHuod2k7IAbbjwB3FhyCur
         O2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731547919; x=1732152719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2fhl252bm516NpmPrHeKOKvYyVObr6Huw6uoNZ0xnE=;
        b=PZI3rbkZxfxhkc0PotYMCmfblMser91OidTOK/GRZxoV+Xm0TcXHDnY0dSSM6t2Tit
         02ivAOMSfo9adkCP2uqZ2cplNSrlDW9gLz+JnwBHlba0qr2Juil5Ru5gar8Y4M9BW3qP
         ijZLjhMNaBP/3A8cVq20/4Ii1/OpFfwOZeFT7Mkrc3XRMBQGXzggHV3JPl24WnnU+5HC
         C5AhfG3fmtPc9rz7ofZo4UChwt5mAxm24YR9b16pDj3TzDA8IvQBwFLFe++NexxKU+94
         UM7aU3knm5o++pNQazCOlCNPhxt/nfHG5R11j2pWndyBy414NXZ8TkAS441w8TMkKtJf
         TaRw==
X-Gm-Message-State: AOJu0Yz9JGXScd5SquDflO+CcW9NRps27pZX9T02KoLZYJ/ivOdXXlxJ
	4EZmBm+TT+V7lBvaZW0liOL5gFaHhjXJhR4JO4djPTgAwbnrjsbNZllM2ChP3kVIfGFbm1w3Utv
	v4Q==
X-Google-Smtp-Source: AGHT+IFJHdCWqULcWmgQVusKhNyyrz8Gh7VzByYMY0+ApPJfTPwovgEt6Q5alaoC4Fnn/L1XuSlVEI/RW0w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:902:b68e:b0:20c:6bff:fcab with SMTP id
 d9443c01a7336-211c0f596a3mr56615ad.2.1731547918547; Wed, 13 Nov 2024 17:31:58
 -0800 (PST)
Date: Wed, 13 Nov 2024 17:31:56 -0800
In-Reply-To: <20241108155056.332412-4-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108155056.332412-1-pbonzini@redhat.com> <20241108155056.332412-4-pbonzini@redhat.com>
Message-ID: <ZzVTDCwLTMB_fagq@google.com>
Subject: Re: [PATCH 3/3] KVM: gmem: track preparedness a page at a time
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 08, 2024, Paolo Bonzini wrote:
> With support for large pages in gmem, it may happen that part of the gmem
> is mapped with large pages and part with 4k pages.  For example, if a
> conversion happens on a small region within a large page, the large
> page has to be smashed into small pages even if backed by a large folio.
> Each of the small pages will have its own state of preparedness,
> which makes it harder to use the uptodate flag for preparedness.
> 
> Just switch to a bitmap in the inode's i_private data.  This is
> a bit gnarly because ordinary bitmap operations in Linux are not
> atomic, but otherwise not too hard.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  virt/kvm/guest_memfd.c | 103 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 100 insertions(+), 3 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 416e02a00cae..e08503dfdd8a 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -68,8 +68,13 @@ static struct file *kvm_gmem_create_file(const char *name, const struct file_ope
>  }
>  
>  
> +#define KVM_GMEM_INODE_SIZE(size)			\
> +	struct_size_t(struct kvm_gmem_inode, prepared,	\
> +		      DIV_ROUND_UP(size, PAGE_SIZE * BITS_PER_LONG))
> +
>  struct kvm_gmem_inode {
>  	unsigned long flags;
> +	unsigned long prepared[];
>  };
>  
>  struct kvm_gmem {
> @@ -107,18 +112,110 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
>  	return 0;
>  }
>  
> +/*
> + * The bitmap of prepared pages has to be accessed atomically, because
> + * preparation is not protected by any guest.

Not entirely sure what you intended to say here.  KVM should never rely on the
guest to provide protection for anything :-)

> +   This unfortunately means that we cannot use regular bitmap operations.

No "we" please.

> + * The logic becomes a bit simpler for set and test, which operate a
> + * folio at a time and therefore can assume that the range is naturally
> + * aligned (meaning that either it is smaller than a word, or it is does
> + * not include fractions of a word).  For punch-hole operations however
> + * there is all the complexity.
> + */

This entire comment feels like it belongs in the changelog.

> +
> +static void bitmap_set_atomic_word(unsigned long *p, unsigned long start, unsigned long len)

I vote to keep wrapping at ~80 chars by default.  I have no objection to running
slightly past 80 when the result is a net postive, and in some cases prefer to do
so, but as a general rule I like wrapping at ~80 better than wrapping at ~100.

> +{
> +	unsigned long mask_to_set =
> +		BITMAP_FIRST_WORD_MASK(start) & BITMAP_LAST_WORD_MASK(start + len);

Align the right hand side?  E.g.

	unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start) &
				    BITMAP_LAST_WORD_MASK(start + len);

Though I think it makes sense to add a macro to generate the mask, maybe with an
assert that the inputs are sane?  E.g. something like BITMAP_WORD_MASK().

> +
> +	atomic_long_or(mask_to_set, (atomic_long_t *)p);
> +}
> +
> +static void bitmap_clear_atomic_word(unsigned long *p, unsigned long start, unsigned long len)

If these are going to stay in KVM, I think it would be better to force the caller
to cast to atomic_long_t.  Actually, I think kvm_gmem_inode.prepared itself should
be an array of atomic_long_t.  More below.

> +{
> +	unsigned long mask_to_set =

mask_to_clear, though if we add a macro, this could probably be something like:

	atomic_long_andnot(BITMAP_WORD_MASK(start, len), p);

> +		BITMAP_FIRST_WORD_MASK(start) & BITMAP_LAST_WORD_MASK(start + len);
> +
> +	atomic_long_andnot(mask_to_set, (atomic_long_t *)p);
> +}
> +
> +static bool bitmap_test_allset_word(unsigned long *p, unsigned long start, unsigned long len)
> +{
> +	unsigned long mask_to_set =

mask_to_test, though using a macro would make the local variables go away.  At
that point, it might even make sense to forego the helpers entirely.

> +		BITMAP_FIRST_WORD_MASK(start) & BITMAP_LAST_WORD_MASK(start + len);
> +
> +	return (*p & mask_to_set) == mask_to_set;

Dereferencing *p should be READ_ONCE(), no?  And if everything is tracked as
atomic_long_t, then KVM is forced to do the right thing via atomic_long_read().

> +}
> +
>  static void kvm_gmem_mark_prepared(struct file *file, pgoff_t index, struct folio *folio)
>  {
> -	folio_mark_uptodate(folio);
> +	struct kvm_gmem_inode *i_gmem = (struct kvm_gmem_inode *)file->f_inode->i_private;
> +	unsigned long *p = i_gmem->prepared + BIT_WORD(index);
> +	unsigned long npages = folio_nr_pages(folio);
> +
> +	/* Folios must be naturally aligned */
> +	WARN_ON_ONCE(index & (npages - 1));
> +	index &= ~(npages - 1);
> +
> +	/* Clear page before updating bitmap.  */
> +	smp_wmb();
> +
> +	if (npages < BITS_PER_LONG) {
> +		bitmap_set_atomic_word(p, index, npages);
> +	} else {
> +		BUILD_BUG_ON(BITS_PER_LONG != 64);
> +		memset64((u64 *)p, ~0, BITS_TO_LONGS(npages));

More code that could be deduplicated (unprepared path below).

But more importantly, I'm pretty sure the entire lockless approach is unsafe.

Callers of kvm_gmem_get_pfn() do not take any locks that protect kvm_gmem_mark_prepared()
from racing with kvm_gmem_mark_range_unprepared().  kvm_mmu_invalidate_begin()
prevents KVM from installing a stage-2 mapping, i.e. from consuming the PFN, but
it doesn't prevent kvm_gmem_mark_prepared() from being called.  And
sev_handle_rmp_fault() never checks mmu_notifiers, which is probably fine?  But
sketchy.

Oof.  Side topic.  sev_handle_rmp_fault() is suspect for other reasons.  It does
its own lookup of the PFN, and so could see an entirely different PFN than was
resolved by kvm_mmu_page_fault().  And thanks to KVM's wonderful 0/1/-errno
behavior, sev_handle_rmp_fault() is invoked even when KVM wants to retry the
fault, e.g. due to an active MMU invalidation.

Anyways, KVM wouldn't _immediately_ consume bad data, as the invalidation
would block the current page fault.  But clobbering i_gmem->prepared would result
in a missed "prepare" phase if the hole-punch region were restored.

One idea would be to use a rwlock to protect updates to the bitmap (setters can
generally stomp on each other).  And to avoid contention whenever possible in
page fault paths, only take the lock if the page is not up-to-date, because again
kvm_mmu_invalidate_{begin,end}() protects against UAF, it's purely updates to the
bitmap that need extra protection.

Note, using is mmu_invalidate_retry_gfn() is unsafe, because it must be called
under mmu_lock to ensure it doesn't get false negatives.

> +	}
>  }
>  
>  static void kvm_gmem_mark_range_unprepared(struct inode *inode, pgoff_t index, pgoff_t npages)
>  {
> +	struct kvm_gmem_inode *i_gmem = (struct kvm_gmem_inode *)inode->i_private;
> +	unsigned long *p = i_gmem->prepared + BIT_WORD(index);
> +
> +	index &= BITS_PER_LONG - 1;
> +	if (index) {
> +		int first_word_count = min(npages, BITS_PER_LONG - index);

Newline.

> +		bitmap_clear_atomic_word(p, index, first_word_count);
> +		npages -= first_word_count;
> +		p++;
> +	}
> +
> +	if (npages > BITS_PER_LONG) {
> +		BUILD_BUG_ON(BITS_PER_LONG != 64);
> +		memset64((u64 *)p, 0, BITS_TO_LONGS(npages));
> +		p += BIT_WORD(npages);
> +		npages &= BITS_PER_LONG - 1;
> +	}
> +
> +	if (npages)
> +		bitmap_clear_atomic_word(p++, 0, npages);
>  }
>  
>  static bool kvm_gmem_is_prepared(struct file *file, pgoff_t index, struct folio *folio)
>  {
> -	return folio_test_uptodate(folio);
> +	struct kvm_gmem_inode *i_gmem = (struct kvm_gmem_inode *)file->f_inode->i_private;
> +	unsigned long *p = i_gmem->prepared + BIT_WORD(index);
> +	unsigned long npages = folio_nr_pages(folio);
> +	bool ret;
> +
> +	/* Folios must be naturally aligned */
> +	WARN_ON_ONCE(index & (npages - 1));
> +	index &= ~(npages - 1);
> +
> +	if (npages < BITS_PER_LONG) {
> +		ret = bitmap_test_allset_word(p, index, npages);
> +	} else {
> +		for (; npages > 0; npages -= BITS_PER_LONG)

for-loop needs curly braces.

> +			if (*p++ != ~0)

Presumably a READ_ONCE() here as well.

> +				break;
> +		ret = (npages == 0);
> +	}
> +
> +	/* Synchronize with kvm_gmem_mark_prepared().  */
> +	smp_rmb();
> +	return ret;
>  }
>  
>  /*
> @@ -499,7 +596,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  	struct file *file;
>  	int fd, err;
>  
> -	i_gmem = kvzalloc(sizeof(struct kvm_gmem_inode), GFP_KERNEL);
> +	i_gmem = kvzalloc(KVM_GMEM_INODE_SIZE(size), GFP_KERNEL);
>  	if (!i_gmem)
>  		return -ENOMEM;
>  	i_gmem->flags = flags;
> -- 
> 2.43.5
> 

