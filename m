Return-Path: <linux-kernel+bounces-199716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24768D8B3A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EBDEB26202
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC11413AD20;
	Mon,  3 Jun 2024 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjlmPjOC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3826880624
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 21:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717448614; cv=none; b=RKiLa/3YJ8Ib+bKIpCOJncX6fZmo2JCh8Dt6mCkABWCA/P7lkHQfoGhQZ1YMTBiA6Qmpk6KICihL+w1AbUwyIiUIgTEAxpN+blM2hALlNXygp5fIftnYXAoAuHBc9EXQ+yvrQHESPc9jw+fNkdrijOO33fWKhIS1zMc6b3Mf59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717448614; c=relaxed/simple;
	bh=cUoAPNR6+cPUvAwJGLf0B7EO/+cVduteoIReIVRSLyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mbg+m+wUoLx5DHMqermFAhx2kk130C2pk525V4b0X5HRfh94B+JEOJ9sKUH6K4QVIPfpMO6Jxgj5iqX29Z7AFsz9G5MKumrxckz9ycpQuZMOX2URWpPoURFc9tMFY9ugNbYQUV0UElLRUCa6XcZragh2S1CTRDvZLT3NdzoTqcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PjlmPjOC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717448612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VEDuWhQuGEPzJhpEOxaS9d3tMD6BYnvGMI8BEwxCK50=;
	b=PjlmPjOCjKJBkwUy9v9ndbWNUA0Q4PoF3gF/0Tj39X0Cr1w0FUKj6nEponW8fjQ8532hqr
	QX7EL1TFtGoRvb53F/AYaa0QrTTNPfnys3bYcWOty1UjzMlM5CuHn7JF5fJXHIBLILF6vu
	LdwbSnSO+6KEW/qSKvbx5nxoiIuQoJE=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-UCKT6kboMPSV-EjBppEr5Q-1; Mon, 03 Jun 2024 17:03:28 -0400
X-MC-Unique: UCKT6kboMPSV-EjBppEr5Q-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-df78eaac8b7so949947276.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 14:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717448606; x=1718053406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEDuWhQuGEPzJhpEOxaS9d3tMD6BYnvGMI8BEwxCK50=;
        b=fOR7cKeKABPk2i82VEqgJ/c0j1iQgRx7drQ4ckxcG3xXBOWbTzEjd9lgjuKBdzwoVY
         14Sfcsoj+x0iW5uPcYR5VMlbHOwU6gsBwNMUEjW+2i1mCfHFGQJlM+W9s7K4FZ/epIM5
         rdZex6sLVhq6f5YVITWi3KRjnMB9MJZ/gn7ReQS0BtIcObkgJ7iZy5cPpWAOZqTA7nei
         twhtoh4eZJ/mL8EtR9yjLidlpsL1de/cD1gaMnwSgVBxPnMDw/V1IcbeBCPlNFAdDz3q
         KMgBmftSvq+DVOgUNxAeFU6oVpDvStYYFNRXdeNMJpoRpZuZKWkrjv+gyRn5TrckMaND
         B01w==
X-Forwarded-Encrypted: i=1; AJvYcCVyp3lWeyDvKyk5qozcAQyyMfq14shWNOPE1+iJVNgx/oD7sxBQxlLpE70cc3bAD0d+nnvwVGS/PDWypb8srbXCMAV7E789fq+MLtpG
X-Gm-Message-State: AOJu0Yy++XmA3s31euC1WcaG8YIR2F5zU8JwaNnBdFki4lk6qhjNw4Qi
	38jQHm/G0X1f23pR9GuJNcPz4YlpzDB4XWWUnldx6Fi5DqOFvWgX+vuNpU3xUQheIWLfZzZCEPu
	cBkMsOIKxedlLHw3ZV7V5ljIfbsyV6pBWs/iFhyxjjhqMooGOhZtLL215i0lwGg==
X-Received: by 2002:a05:690c:f10:b0:627:a1d9:9665 with SMTP id 00721157ae682-62c7969b5bcmr82966177b3.2.1717448605500;
        Mon, 03 Jun 2024 14:03:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmBe0GMHCdZ0r6fkSAfWUvPEKF1qHRXrtSn4Hjy+uROa9hIF4Z/g0l+fOgW8yCYbcvblG8+Q==
X-Received: by 2002:a05:690c:f10:b0:627:a1d9:9665 with SMTP id 00721157ae682-62c7969b5bcmr82965857b3.2.1717448604860;
        Mon, 03 Jun 2024 14:03:24 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6afbf0449c1sm13389106d6.141.2024.06.03.14.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 14:03:24 -0700 (PDT)
Date: Mon, 3 Jun 2024 17:03:16 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>,
	kernel test robot <oliver.sang@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Rik van Riel <riel@surriel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christopher Lameter <cl@linux.com>, linux-mm@kvack.org
Subject: Re: [linus:master] [mm] efa7df3e3b:
 kernel_BUG_at_include/linux/page_ref.h
Message-ID: <Zl4vlGJsbHiahYil@x1n>
References: <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
 <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com>
 <ZlpcRnuZUEYJJ0JA@x1n>
 <CAHbLzkrRw-xf819gYJwRQ=-u971LQYnB2FNJMkN=s6u-pJ4Z8g@mail.gmail.com>
 <CAHbLzkoB+oFTxtVYpeXQvko2q9HUVzUYrr83S6M6PUmXDQpkag@mail.gmail.com>
 <0edfcfed-e8c4-4c46-bbce-528c07084792@redhat.com>
 <Zl3cakfiRsPQDb8q@x1n>
 <8da12503-839d-459f-a2fa-4abd6d21935d@redhat.com>
 <Zl4m-sAhZknHOHdb@x1n>
 <9d9a5730-161b-4a9d-a696-1cf6d0c5123c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d9a5730-161b-4a9d-a696-1cf6d0c5123c@redhat.com>

On Mon, Jun 03, 2024 at 10:37:55PM +0200, David Hildenbrand wrote:
> > > try_get_folio() is all about grabbing a folio that might get freed
> > > concurrently. That's why it calls folio_ref_try_add_rcu() and does
> > > complicated stuff.
> > 
> > IMHO we can define it.. e.g. try_get_page() wasn't defined as so.
> > 
> > If we want to be crystal clear on that and if we think that's what we want,
> > again I would suggest we rename it differently from try_get_page() to avoid
> > future misuses, then add documents. We may want to also even assert the
> 
> Yes, absolutely.
> 
> > rcu/irq implications in try_get_folio() at entrance, then that'll be
> > detected even without TINY_RCU config.
> > 
> > > 
> > > On !CONFIG_TINY_RCU, it performs a folio_ref_add_unless(). That's
> > > essentially a atomic_add_unless(), which in the worst case ends up being a
> > > cmpxchg loop.
> > > 
> > > 
> > > Stating that we should be using try_get_folio() in paths where we are sure
> > > the folio refcount is not 0 is the same as using folio_try_get() where
> > > folio_get() would be sufficient.
> > > 
> > > The VM_BUG_ON in folio_ref_try_add_rcu() really tells us here that we are
> > > using a function in the wrong context, although in our case, it is safe to
> > > use (there is now BUG). Which is true, because we know we have a folio
> > > reference and can simply use a simple folio_ref_add().
> > > 
> > > Again, just like we have folio_get() and folio_try_get(), we should
> > > distinguish in GUP whether we are adding more reference to a folio (and
> > > effectively do what folio_get() would), or whether we are actually grabbing
> > > a folio that could be freed concurrently (what folio_try_get() would do).
> > 
> > Yes we can.  Again, IMHO it's a matter of whether it will worth it.
> > 
> > Note that even with SMP and even if we keep this code, the
> > atomic_add_unless only affects gup slow on THP only, and even with that
> > overhead it is much faster than before when that path was introduced.. and
> > per my previous experience we don't care too much there, really.
> > 
> > So it's literally only three paths that are relevant here on the "unless"
> > overhead:
> > 
> >    - gup slow on THP (I just added it; used to be even slower..)
> > 
> >    - vivik's new path
> > 
> >    - hugepd (which may be gone for good in a few months..)
> > IMHO none of them has perf concerns.  The real perf concern paths is
> > gup-fast when pgtable entry existed, but that must use atomic_add_unless()
> > anyway.  Even gup-slow !thp case won't regress as that uses try_get_page().
> 
> My point is primarily that we should be clear that the one thing is
> GUP-fast, and the other is for GUP-slow.

Yes, understood.

> 
> Sooner or later we'll see more code that uses try_grab_page() to be
> converted to folios, and people might naturally use try_grab_folio(), just
> like we did with Vivik's code.
> 
> And I don't think we'll want to make GUP-slow in general using
> try_grab_folio() in the future.
> 
> So ...
> 
> > 
> > So again, IMHO the easist way to fix this WARN is we drop the TINY_RCU bit,
> > if nobody worries on UP perf.
> > 
> > I don't have a strong opinion, if any of us really worry about above three
> > use cases on "unless" overhead, and think it worthwhile to add the code to
> > support it, I won't object. But to me it's adding pain with no real benefit
> > we could ever measure, and adding complexity to backport too since we'll
> > need a fix for as old as 6.6.
> 
> ... for the sake of fixing this WARN, I don't primarily care. Adjusting the
> TINY_RCU feels wrong because I suspect somebody had good reasons to do it
> like that, and it actually reported something valuable (using the wrong
> function for the job).
> 
> In any case, if we take the easy route to fix the WARN, I'll come back and
> clean the functions here up properly.

Definitely, then there can also be some measurements which will be even
better.  I mean, if the diff is minimal, we can be clearer on the path we
choose; while if it shows improvements we have more solid results than
predictions and discussions.

Yes I do worry about the UP change too, hence I sincerely was trying to
collect some feedback.  My current guess is the UP was still important in
2008 when the code first wrote, and maybe it changed over the 16 years. I
just notice Nicolas wrote it; I know he's still active so I've added him
into the loop too.

Just for easier reference, the commit introduced the UP change is:

commit e286781d5f2e9c846e012a39653a166e9d31777d
Author: Nicholas Piggin <npiggin@gmail.com>
Date:   Fri Jul 25 19:45:30 2008 -0700

    mm: speculative page references

+static inline int page_cache_get_speculative(struct page *page)
+{
+       VM_BUG_ON(in_interrupt());
+
+#if !defined(CONFIG_SMP) && defined(CONFIG_CLASSIC_RCU)
+# ifdef CONFIG_PREEMPT
+       VM_BUG_ON(!in_atomic());
+# endif
+       /*
+        * Preempt must be disabled here - we rely on rcu_read_lock doing
+        * this for us.
+        *
+        * Pagecache won't be truncated from interrupt context, so if we have
+        * found a page in the radix tree here, we have pinned its refcount by
+        * disabling preempt, and hence no need for the "speculative get" that
+        * SMP requires.
+        */
+       VM_BUG_ON(page_count(page) == 0);
+       atomic_inc(&page->_count);
+
+#else
+       if (unlikely(!get_page_unless_zero(page))) {
+               /*
+                * Either the page has been freed, or will be freed.
+                * In either case, retry here and the caller should
+                * do the right thing (see comments above).
+                */
+               return 0;
+       }
+#endif
+       VM_BUG_ON(PageTail(page));
+
+       return 1;
+}

Thanks,

-- 
Peter Xu


