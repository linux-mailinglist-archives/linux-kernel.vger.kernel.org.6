Return-Path: <linux-kernel+bounces-558039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E047A5E0CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45435173C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712BB242923;
	Wed, 12 Mar 2025 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnrYzVal"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1CC288BA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794347; cv=none; b=XdjPekGE8MeJK3R4f0sMJG4uK3M/jGiC8KoR3E9UodqC37iHbSweMDff1JjBV4DzI/MG0msBVbdxIIT2tz8RBbs6FxK8OjqhVFh93wNyn46TLD9q/GNrDQ30A7wxWw4XperWdTgUL0+pyHXk8b6bmG8pomkdqeSzshwOicRs0cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794347; c=relaxed/simple;
	bh=D/wZ1TUBH9NL6fkDzSIbr43ucRHs/N+gCZnO6yydIP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xe/w8JMH7tRP8J+Dy/ygCvSiw8rJBgtf4UOSZaEnwTUAGFAvj5t9c5sW1pVxB4eC4nNv0TfOyXypaBq1LihmknwU5rRpOdW4HkPsVfEv1pYQyg8sbGNl/5NdoVh7xSXnvisy/pmJpvv3jzZJfNTk+hy6HJNDX5UqU/xnQld2OLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnrYzVal; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741794344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ut4pbapSzhs8uCjUUCSZVy14MK3K3nRSMdDH7UTR4MM=;
	b=bnrYzValpZWTaBjWXJr+DCu/2Z8E2LCxVjlzSgIpMInTZL52+GHbVK9xWw2orA8NZ+fCBU
	RzRogLLabOzlPjGko5B6CvAN4qHyfIBo/kCHIZeLW2Mo2UsRUIR71g9HTyTvaxJeZwnxVX
	bJX9eidYlg+BvVvhclzTQOuXtcQ6tcM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-kaqU3NLgNFCtnoS_O8oLxA-1; Wed, 12 Mar 2025 11:45:42 -0400
X-MC-Unique: kaqU3NLgNFCtnoS_O8oLxA-1
X-Mimecast-MFC-AGG-ID: kaqU3NLgNFCtnoS_O8oLxA_1741794341
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c0c1025a6cso2049889785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741794341; x=1742399141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ut4pbapSzhs8uCjUUCSZVy14MK3K3nRSMdDH7UTR4MM=;
        b=DHOXdJnBOAkvtdd7pdAOC9wq0alZonnFj5eF/z6ChjD9l4t8SzqVhRLPKMD+ixwptb
         BPX3wnszgdfZH5B8baY053lKHacAXBUB0cS2iCiLSE9uLPmU2wg7IpdiqErtftCDcKRP
         VjeL2spcG+rnbcre3qdekCN9DNikSbRhD2a8JAjUlGgISUURHfXidltJCdc7pB1Y8kvP
         HOT61Ucj430KvObzaURick5a7tPKUpl1ePlv+xdRZATrM7VK1FfWNEbUoRFm1AVOt95+
         jFvbMLobWBghoyXHZkYUpW36qT62IWECgOf3WR8FlB6TN0XRsf2OvyQNKVzcmRRYBwIp
         zJQg==
X-Forwarded-Encrypted: i=1; AJvYcCUS3KSzcxZ5gdSgoasatnPen4u+Yqdzv2ZFLzH6Z+U32ETpaflwTup/VUSTC9YJA6GOzQrHZkTedmpz2Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4zvPAz2JmbyJ/96trj6rlpNrVDaa0o8jUxAbwmx6whjKUfD7
	kluYvgBxEOaJIlo5qENxW5tzkDsuxMxtIWcmV1RVscfXM6GDTr3SsIqoOE4PiVHbsVRMPf6mH3G
	9x17TBM3jNCD+w+po9pVSs8/XfORKX0Xg88Brwp1xFGpYWRcSRZpgNhIZJEuudA==
X-Gm-Gg: ASbGnctxjNx0ov/F0rPRR4ZLdff1D68YwoTEYDj4dfShHNWIjEVQihpyT3wIZc/5cs4
	9a5vYVzFnZu5HgzYv+pkxn4/LdgYMyfsJ44CcKZKyQqKkyreqcSX/jMK9y0Y1FVsP+ZDOzhcGLo
	iqjtaoEcQAPcJNwJiCv36vin2Zqry65AnZ4xjm/2thVUbbl1ttSYbKWgMeaqR6ISBETHTR7u0Ov
	Roz/N4iWZ9TQ24l0Oh/sy9AMh8J0jTWA7tze5t/dI/xHTlyTQDlts7UZNAwnS7kuPVXbl2Y/Oa3
	K8rOUeA=
X-Received: by 2002:a05:620a:26a3:b0:7c5:5692:ee91 with SMTP id af79cd13be357-7c55692f028mr1679142985a.23.1741794341511;
        Wed, 12 Mar 2025 08:45:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeUONLhGbcchFtsON6vku9vRaOBMh9M5T52ggQTNZ6v7izQr/2SjLlIdPk6U0xKsrrhbgKhA==
X-Received: by 2002:a05:620a:26a3:b0:7c5:5692:ee91 with SMTP id af79cd13be357-7c55692f028mr1679137385a.23.1741794341075;
        Wed, 12 Mar 2025 08:45:41 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c545fd5772sm634042685a.35.2025.03.12.08.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:45:40 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:45:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: James Houghton <jthoughton@google.com>, akpm@linux-foundation.org,
	pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, david@redhat.com,
	ryan.roberts@arm.com, quic_eberman@quicinc.com, graf@amazon.de,
	jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com,
	nsaenz@amazon.es, xmarcalx@amazon.com
Subject: Re: [RFC PATCH 0/5] KVM: guest_memfd: support for uffd missing
Message-ID: <Z9GsIDVYWoV8d8-C@x1.local>
References: <20250303133011.44095-1-kalyazin@amazon.com>
 <Z8YfOVYvbwlZST0J@x1.local>
 <CADrL8HXOQ=RuhjTEmMBJrWYkcBaGrqtXmhzPDAo1BE3EWaBk4g@mail.gmail.com>
 <Z8i0HXen8gzVdgnh@x1.local>
 <fdae95e3-962b-4eaf-9ae7-c6bd1062c518@amazon.com>
 <Z89EFbT_DKqyJUxr@x1.local>
 <9e7536cc-211d-40ca-b458-66d3d8b94b4d@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e7536cc-211d-40ca-b458-66d3d8b94b4d@amazon.com>

On Tue, Mar 11, 2025 at 04:56:47PM +0000, Nikita Kalyazin wrote:
> 
> 
> On 10/03/2025 19:57, Peter Xu wrote:
> > On Mon, Mar 10, 2025 at 06:12:22PM +0000, Nikita Kalyazin wrote:
> > > 
> > > 
> > > On 05/03/2025 20:29, Peter Xu wrote:
> > > > On Wed, Mar 05, 2025 at 11:35:27AM -0800, James Houghton wrote:
> > > > > I think it might be useful to implement an fs-generic MINOR mode. The
> > > > > fault handler is already easy enough to do generically (though it
> > > > > would become more difficult to determine if the "MINOR" fault is
> > > > > actually a MISSING fault, but at least for my userspace, the
> > > > > distinction isn't important. :)) So the question becomes: what should
> > > > > UFFDIO_CONTINUE look like?
> > > > > 
> > > > > And I think it would be nice if UFFDIO_CONTINUE just called
> > > > > vm_ops->fault() to get the page we want to map and then mapped it,
> > > > > instead of having shmem-specific and hugetlb-specific versions (though
> > > > > maybe we need to keep the hugetlb specialization...). That would avoid
> > > > > putting kvm/gmem/etc. symbols in mm/userfaultfd code.
> > > > > 
> > > > > I've actually wanted to do this for a while but haven't had a good
> > > > > reason to pursue it. I wonder if it can be done in a
> > > > > backwards-compatible fashion...
> > > > 
> > > > Yes I also thought about that. :)
> > > 
> > > Hi Peter, hi James.  Thanks for pointing at the race condition!
> > > 
> > > I did some experimentation and it indeed looks possible to call
> > > vm_ops->fault() from userfault_continue() to make it generic and decouple
> > > from KVM, at least for non-hugetlb cases.  One thing is we'd need to prevent
> > > a recursive handle_userfault() invocation, which I believe can be solved by
> > > adding a new VMF flag to ignore the userfault path when the fault handler is
> > > called from userfault_continue().  I'm open to a more elegant solution
> > > though.
> > 
> > It sounds working to me.  Adding fault flag can also be seen as part of
> > extension of vm_operations_struct ops.  So we could consider reusing
> > fault() API indeed.
> 
> Great!
> 
> > > 
> > > Regarding usage of the MINOR notification, in what case do you recommend
> > > sending it?  If following the logic implemented in shmem and hugetlb, ie if
> > > the page is _present_ in the pagecache, I can't see how it is going to work
> > 
> > It could be confusing when reading that chunk of code, because it looks
> > like it notifies minor fault when cache hit. But the critical part here is
> > that we rely on the pgtable missing causing the fault() to trigger first.
> > So it's more like "cache hit && pgtable missing" for minor fault.
> 
> Right, but the cache hit still looks like a precondition for the minor fault
> event?

Yes.

> 
> > > with the write syscall, as we'd like to know when the page is _missing_ in
> > > order to respond with the population via the write.  If going against
> > > shmem/hugetlb logic, and sending the MINOR event when the page is missing
> > > from the pagecache, how would it solve the race condition problem?
> > 
> > Should be easier we stick with mmap() rather than write().  E.g. for shmem
> > case of current code base:
> > 
> >          if (folio && vma && userfaultfd_minor(vma)) {
> >                  if (!xa_is_value(folio))
> >                          folio_put(folio);
> >                  *fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
> >                  return 0;
> >          }
> > 
> > vma is only availble if vmf!=NULL, aka in fault context.  With that, in
> > write() to shmem inodes, nothing will generate a message, because minor
> > fault so far is only about pgtable missing.  It needs to be mmap()ed first,
> > and has nothing yet to do with write() syscalls.
> 
> Yes, that's true that write() itself isn't going to generate a message. My
> idea was to _respond_ to a message generated by the fault handler (vmf !=
> NULL) with a write().  I didn't mean to generate it from write().
> 
> What I wanted to achieve was send a message on fault + cache miss and
> respond to the message with a write() to fill the cache followed by a
> UFFDIO_CONTINUE to set up pagetables.  I understand that a MINOR trap (MINOR
> + UFFDIO_CONTINUE) is preferable, but how does it fit into this model?
> What/how will guarantee a cache hit that would trigger the MINOR message?
> 
> To clarify, I would like to be able to populate pages _on-demand_, not only
> proactively (like in the original UFFDIO_CONTINUE cover letter [1]).  Do you
> think the MINOR trap could still be applicable or would it necessarily
> require the MISSING trap?

I think MINOR can also achieve similar things.  MINOR traps the pgtable
missing event (let's imagine page cache is already populated, or at least
when MISSING mode not registered, it'll auto-populate on 1st access).  So
as long as the content can only be accessed from the pgtable (either via
mmap() or GUP on top of it), then afaiu it could work similarly like
MISSING faults, because anything trying to access it will be trapped.

Said that, we can also choose to implement MISSING first.  In that case
write() is definitely not enough, because MISSING is at least so far based
on top of whether the page cache present, and write() won't be atomic on
update a page.  We need to implement UFFDIO_COPY for gmemfd MISSING.

Either way looks ok to me.

> 
> [1] https://lore.kernel.org/linux-fsdevel/20210301222728.176417-1-axelrasmussen@google.com/T/
> 
> > > 
> > > Also, where would the check for the folio_test_uptodate() mentioned by James
> > > fit into here?  Would it only be used for fortifying the MINOR (present)
> > > against the race?
> > > 
> > > > When Axel added minor fault, it's not a major concern as it's the only fs
> > > > that will consume the feature anyway in the do_fault() path - hugetlbfs has
> > > > its own path to take care of.. even until now.
> > > > 
> > > > And there's some valid points too if someone would argue to put it there
> > > > especially on folio lock - do that in shmem.c can avoid taking folio lock
> > > > when generating minor fault message.  It might make some difference when
> > > > the faults are heavy and when folio lock is frequently taken elsewhere too.
> > > 
> > > Peter, could you expand on this?  Are you referring to the following
> > > (shmem_get_folio_gfp)?
> > > 
> > >        if (folio) {
> > >                folio_lock(folio);
> > > 
> > >                /* Has the folio been truncated or swapped out? */
> > >                if (unlikely(folio->mapping != inode->i_mapping)) {
> > >                        folio_unlock(folio);
> > >                        folio_put(folio);
> > >                        goto repeat;
> > >                }
> > >                if (sgp == SGP_WRITE)
> > >                        folio_mark_accessed(folio);
> > >                if (folio_test_uptodate(folio))
> > >                        goto out;
> > >                /* fallocated folio */
> > >                if (sgp != SGP_READ)
> > >                        goto clear;
> > >                folio_unlock(folio);
> > >                folio_put(folio);
> > >        }

[1]

> > > 
> > > Could you explain in what case the lock can be avoided?  AFAIC, the function
> > > is called by both the shmem fault handler and userfault_continue().
> > 
> > I think you meant the UFFDIO_CONTINUE side of things.  I agree with you, we
> > always need the folio lock.
> > 
> > What I was saying is the trapping side, where the minor fault message can
> > be generated without the folio lock now in case of shmem.  It's about
> > whether we could generalize the trapping side, so handle_mm_fault() can
> > generate the minor fault message instead of by shmem.c.
> > 
> > If the only concern is "referring to a module symbol from core mm", then
> > indeed the trapping side should be less of a concern anyway, because the
> > trapping side (when in the module codes) should always be able to reference
> > mm functions.
> > 
> > Actually.. if we have a fault() flag introduced above, maybe we can
> > generalize the trap side altogether without the folio lock overhead.  When
> > the flag set, if we can always return the folio unlocked (as long as
> > refcount held), then in UFFDIO_CONTINUE ioctl we can lock it.
> 
> Where does this locking happen exactly during trapping?  I was thinking it
> was only done when the page was allocated.  The trapping part (quoted by you
> above) only looks up the page in the cache and calls handle_userfault().  Am
> I missing something?

That's only what I worry if we want to reuse fault() to generalize the trap
code in core mm, because fault() by default takes the folio lock at least
for shmem.  I agree the folio doesn't need locking when trapping the fault
and sending the message.

Thanks,

> 
> > > 
> > > > It might boil down to how many more FSes would support minor fault, and
> > > > whether we would care about such difference at last to shmem users. If gmem
> > > > is the only one after existing ones, IIUC there's still option we implement
> > > > it in gmem code.  After all, I expect the change should be very under
> > > > control (<20 LOCs?)..
> > > > 
> > > > --
> > > > Peter Xu
> > > > 
> > > 
> > 
> > --
> > Peter Xu
> > 
> 

-- 
Peter Xu


