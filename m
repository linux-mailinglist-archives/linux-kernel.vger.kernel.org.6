Return-Path: <linux-kernel+bounces-401261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA069C17E1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17731F218F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364FC1D26E9;
	Fri,  8 Nov 2024 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="G3oypHIh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JVhX8o3I"
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25AC1DC1A2;
	Fri,  8 Nov 2024 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054379; cv=none; b=a988P3IMt6d1cWOXIcjt/d07/mAfz+xzlS2rpctl/H4lqbn2hNSQ+VKAvayMjIaKqJPN3mrByoSZPd/9kA9VLx4CG2hIV6D08AYop0dJRDC7kpZbtWwO4+tXiorT6l0JLwahayAR69pdGHqXTrVFyMe/03zOVjfQ2DG0XUBNt6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054379; c=relaxed/simple;
	bh=C3veQSVu3524Cnqs9HKXROIfh8gW53fzBWBCMZGhOnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J38u2MLQw8az6mtnsdAmRixITDz0Zo6Ixt0fXfylbktkubPx8MJdwrAgBH99yg/lhTIZwgqFKhkVwTinzEXo0EirpH4hYOnmKp/EBhtrq+4fzpOakI8DlktKM1uw1tC7u5O50YBz0pTtYf7aP7dQD9QIev2kziKvtCR9KoU4OHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=G3oypHIh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JVhX8o3I; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 724A21140181;
	Fri,  8 Nov 2024 03:26:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 08 Nov 2024 03:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731054375; x=
	1731140775; bh=MP9fVPar+7YgC7aGLJp0qPa3a2dJ4S4MvIznfgmcU9U=; b=G
	3oypHIhJym4f0LlS22GiDXcT6BkX8ceGWhdDCKPu0fvfM9mihUvRHbDEX06ABddd
	sx3ncgTbKx+RMyWdNEVyKcErK36vY3eoV2+H2Pw/lWyqJJlaG1s3aJrmi8e3L03R
	0YitRFi6vLLHE89cbK7QTsNNZ82XrqDzS2Io3xjTrl/pJtPsqBHvyY+EhPn6JUZB
	fNKL4p8QOI+Z6kruVvZc5ytk0MXxWhk+HR/D2rPhL1gkzyYfK7v1poK9uaux35zs
	XWtG9e+tQkJdqKX4/KEJBpq1MkQdgQ42zrDBECeWbJTb1GhiAEY8tr2+60+cotrt
	w/B+0DjfiJdRqDMkJyGvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731054375; x=1731140775; bh=MP9fVPar+7YgC7aGLJp0qPa3a2dJ4S4MvIz
	nfgmcU9U=; b=JVhX8o3IDek13+NrfMb1hYh/cRtk7Bw5+X1/LyDeD1deVUPlJZt
	hLcjiuUUJeAs7Zqpc7stp6aRTPOi62CwOXCxiuTanzkSw7pSMJLlHVWwoNp2uNxL
	gsUE020u6FMA9ypx82BIatE3nmzLXSgYDRiAC/zAzPpz4aRC1F5PGiJWuCAS8m1l
	Mxs+CiE6SDa+ZuPztOFH5hjDd44y1GlHpaFswnQTOezmd6qLQX/PIR8S5g/Ac/EU
	zeg9dybKnYROq2YrGv7K2KjxQbgVA7jGQfEVDjHiggnz20Ls9UZabdHTOth9ah8Z
	YvvsnIYdM8TS+MK1Zvjd2ascHsa5krGhn9A==
X-ME-Sender: <xms:JMstZ_yqqeNCuLcebP30_UOP-9YUW2CoZnMAQSFVN7OaM2rPVxT6eA>
    <xme:JMstZ3RRIs8uyJjYQFLUrf7Nsli97eLv2MvxvKZVbTdpR_iq0vv9CINEyUxO1X2Si
    p_V0-4aWS9Jflcq_oU>
X-ME-Received: <xmr:JMstZ5U-G60q8dIRpeeVu0gDYOVIgekg8TRUoLRFNmlwOdZPmyUAQeWMzQvyRK4dXL3FPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdrtghomhdprhgtphht
    thhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    eptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtoheplhhirghmrdhhohiflhgvthht
    sehorhgrtghlvgdrtghomhdprhgtphhtthhopehvsggrsghkrgesshhushgvrdgtiidprh
    gtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrlhhitggv
    rhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesgh
    hmrghilhdrtghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:JMstZ5jvElvoXTBrSPxhnAhcevph58Tq0M6NQBONmtHHwbCUECBKcA>
    <xmx:JMstZxBYtrZAJQJhHPb-e-_FYJ1VCnL0axCH_g6DAfrz80RKgTnsVg>
    <xmx:JMstZyJ7aC6aeBbcM6uUt4Q5EwcV6JzcTL2ahd5YZTfzaDSf4_J8kA>
    <xmx:JMstZwCLEhN327t1vYGQYH1fV6iyrtJikFl8txV35dPw11x43o_5KA>
    <xmx:J8stZ13SE-l2WVSqFs17ZYaeqWSeo5Hs4Q5tJx6mzUuLkiLXIAw-nNmt>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 03:26:07 -0500 (EST)
Date: Fri, 8 Nov 2024 10:26:03 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	Hillf Danton <hdanton@sina.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] docs/mm: add VMA locks documentation
Message-ID: <k2ugfhimeoos55l2ywxzdiagfif7cupkiyjfe7wd7ntvdci2xf@me536l2e5zjb>
References: <20241107190137.58000-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107190137.58000-1-lorenzo.stoakes@oracle.com>

On Thu, Nov 07, 2024 at 07:01:37PM +0000, Lorenzo Stoakes wrote:
> +.. table:: Config-specific fields
> +
> +   ================================= ===================== ======================================== ===============
> +   Field                             Configuration option  Description                              Write lock
> +   ================================= ===================== ======================================== ===============
> +   :c:member:`!anon_name`            CONFIG_ANON_VMA_NAME  A field for storing a                    mmap write,
> +                                                           :c:struct:`!struct anon_vma_name`        VMA write.
> +                                                           object providing a name for anonymous
> +                                                           mappings, or :c:macro:`!NULL` if none
> +							   is set or the VMA is file-backed.
> +   :c:member:`!swap_readahead_info`  CONFIG_SWAP           Metadata used by the swap mechanism      mmap read.
> +                                                           to perform readahead.

It is not clear how writes to the field is serialized by a shared lock.

It worth noting that it is atomic.

> +   :c:member:`!vm_policy`            CONFIG_NUMA           :c:type:`!mempolicy` object which        mmap write,
> +                                                           describes the NUMA behaviour of the      VMA write.
> +							   VMA.
> +   :c:member:`!numab_state`          CONFIG_NUMA_BALANCING :c:type:`!vma_numab_state` object which  mmap read.
> +                                                           describes the current state of
> +                                                           NUMA balancing in relation to this VMA.
> +                                                           Updated under mmap read lock by
> +							   :c:func:`!task_numa_work`.

Again, shared lock serializing writes make zero sense. There's other
mechanism in play.

I believe there's some kind of scheduler logic that excludes parallel
updates for the same process. But I cannot say I understand this.

> +   :c:member:`!vm_userfaultfd_ctx`   CONFIG_USERFAULTFD    Userfaultfd context wrapper object of    mmap write,
> +                                                           type :c:type:`!vm_userfaultfd_ctx`,      VMA write.
> +                                                           either of zero size if userfaultfd is
> +                                                           disabled, or containing a pointer
> +                                                           to an underlying
> +							   :c:type:`!userfaultfd_ctx` object which
> +                                                           describes userfaultfd metadata.
> +   ================================= ===================== ======================================== ===============

...

> +Lock ordering
> +-------------
> +
> +As we have multiple locks across the kernel which may or may not be taken at the
> +same time as explicit mm or VMA locks, we have to be wary of lock inversion, and
> +the **order** in which locks are acquired and released becomes very important.
> +
> +.. note:: Lock inversion occurs when two threads need to acquire multiple locks,
> +   but in doing so inadvertently cause a mutual deadlock.
> +
> +   For example, consider thread 1 which holds lock A and tries to acquire lock B,
> +   while thread 2 holds lock B and tries to acquire lock A.
> +
> +   Both threads are now deadlocked on each other. However, had they attempted to
> +   acquire locks in the same order, one would have waited for the other to
> +   complete its work and no deadlock would have occurred.
> +
> +The opening comment in `mm/rmap.c` describes in detail the required ordering of
> +locks within memory management code:
> +
> +.. code-block::
> +
> +  inode->i_rwsem	(while writing or truncating, not reading or faulting)
> +    mm->mmap_lock
> +      mapping->invalidate_lock (in filemap_fault)
> +        folio_lock
> +          hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share, see hugetlbfs below)
> +            vma_start_write
> +              mapping->i_mmap_rwsem
> +                anon_vma->rwsem
> +                  mm->page_table_lock or pte_lock
> +                    swap_lock (in swap_duplicate, swap_info_get)
> +                      mmlist_lock (in mmput, drain_mmlist and others)
> +                      mapping->private_lock (in block_dirty_folio)
> +                          i_pages lock (widely used)
> +                            lruvec->lru_lock (in folio_lruvec_lock_irq)
> +                      inode->i_lock (in set_page_dirty's __mark_inode_dirty)
> +                      bdi.wb->list_lock (in set_page_dirty's __mark_inode_dirty)
> +                        sb_lock (within inode_lock in fs/fs-writeback.c)
> +                        i_pages lock (widely used, in set_page_dirty,
> +                                  in arch-dependent flush_dcache_mmap_lock,
> +                                  within bdi.wb->list_lock in __sync_single_inode)
> +
> +Please check the current state of this comment which may have changed since the
> +time of writing of this document.

I think we need one canonical place for this information. Maybe it worth
moving it here from rmap.c? There's more locking ordering info in filemap.c.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

