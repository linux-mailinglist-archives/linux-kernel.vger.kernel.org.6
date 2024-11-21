Return-Path: <linux-kernel+bounces-416440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF179D44C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 01:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840961F232D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984A933D8;
	Thu, 21 Nov 2024 00:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V+LqOzat"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DB763A9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732147514; cv=none; b=V7voDYMv/ienoF0NEtmRsAZej695RHQb+db45ke1j4QCxYx5e9PXicy2mATeM+gCpvXlf/fPCRPb2WCBzyMCN61mHlX67F3SZl3iPnKFFkBc9ijKkF549sfYC+lAZt4/zLEu8yKI7K5T0N5bXMe801FsBGWN9QQlyOzAHRduxPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732147514; c=relaxed/simple;
	bh=RKTg6HYYPtBs09QM0y4RfHS5ViGNVO7xYSrASGP70rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwt4vB1iGTPR8x7lFRknGY8ioLjCMjEdy80pnVH4yu2Z2baKTfMJ3sF+hUFnlDjIoDCHUycT30/yuvidnAbvKYwu+qzipBJH0OP1kZ59O3DsoYJl7JTwjxkW+7GTHjq/1wEOzwzOW1EG+WmzIaaDzdBNUJw0/hTml4KxloJYC6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V+LqOzat; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Nov 2024 16:04:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732147508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3aB6iWKBZ4UsqZogpLqRAn1MMLH9eAxB//u6YU0jng=;
	b=V+LqOzatU5Ivl6Cf2KD1FyV2ON79Lx4pFkr8issZZA6XRQhqAKVDx0eHlOzrhUPuHAh3IJ
	s0GL20YUSyYEXADVKco/jZ/mwE7i7BHXe9+t5ZByGMSysWD6DwuSkuWk7mCcDN01WZGgse
	s17wSYswscYvDA5lhSjB0FSoE+WpoEg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, 
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, oleg@redhat.com, 
	dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, 
	hdanton@sina.com, hughd@google.com, minchan@google.com, jannh@google.com, 
	souravpanda@google.com, pasha.tatashin@soleen.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Subject: Re: [PATCH v4 2/5] mm: move per-vma lock into vm_area_struct
Message-ID: <wnwfgk32wyvx7tzd522ajwk5uixls7iayksrtho6c3dkvgdpek@25yqv3ohljzc>
References: <20241120000826.335387-1-surenb@google.com>
 <20241120000826.335387-3-surenb@google.com>
 <zfd7xdkr5dkvvx3caqao3oorh2pxxifhdhwsw2iyxcuzbevo3n@sobu7xhw24vv>
 <CAJuCfpFAh-gw_BVCaEB4+saedVC6aPB7HfyPikvTujyGRLXPwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFAh-gw_BVCaEB4+saedVC6aPB7HfyPikvTujyGRLXPwQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 20, 2024 at 03:44:29PM -0800, Suren Baghdasaryan wrote:
> On Wed, Nov 20, 2024 at 3:33 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Tue, Nov 19, 2024 at 04:08:23PM -0800, Suren Baghdasaryan wrote:
> > > Back when per-vma locks were introduces, vm_lock was moved out of
> > > vm_area_struct in [1] because of the performance regression caused by
> > > false cacheline sharing. Recent investigation [2] revealed that the
> > > regressions is limited to a rather old Broadwell microarchitecture and
> > > even there it can be mitigated by disabling adjacent cacheline
> > > prefetching, see [3].
> > > Splitting single logical structure into multiple ones leads to more
> > > complicated management, extra pointer dereferences and overall less
> > > maintainable code. When that split-away part is a lock, it complicates
> > > things even further. With no performance benefits, there are no reasons
> > > for this split. Merging the vm_lock back into vm_area_struct also allows
> > > vm_area_struct to use SLAB_TYPESAFE_BY_RCU later in this patchset.
> > > Move vm_lock back into vm_area_struct, aligning it at the cacheline
> > > boundary and changing the cache to be cacheline-aligned as well.
> > > With kernel compiled using defconfig, this causes VMA memory consumption
> > > to grow from 160 (vm_area_struct) + 40 (vm_lock) bytes to 256 bytes:
> > >
> > >     slabinfo before:
> > >      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> > >      vma_lock         ...     40  102    1 : ...
> > >      vm_area_struct   ...    160   51    2 : ...
> > >
> > >     slabinfo after moving vm_lock:
> > >      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> > >      vm_area_struct   ...    256   32    2 : ...
> > >
> > > Aggregate VMA memory consumption per 1000 VMAs grows from 50 to 64 pages,
> > > which is 5.5MB per 100000 VMAs. Note that the size of this structure is
> > > dependent on the kernel configuration and typically the original size is
> > > higher than 160 bytes. Therefore these calculations are close to the
> > > worst case scenario. A more realistic vm_area_struct usage before this
> > > change is:
> > >
> > >      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> > >      vma_lock         ...     40  102    1 : ...
> > >      vm_area_struct   ...    176   46    2 : ...
> > >
> > > Aggregate VMA memory consumption per 1000 VMAs grows from 54 to 64 pages,
> > > which is 3.9MB per 100000 VMAs.
> > > This memory consumption growth can be addressed later by optimizing the
> > > vm_lock.
> > >
> > > [1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.com/
> > > [2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
> > > [3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com/
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Thanks!
> 
> >
> >
> > One question below.
> >
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -716,8 +716,6 @@ struct vm_area_struct {
> > >        * slowpath.
> > >        */
> > >       unsigned int vm_lock_seq;
> > > -     /* Unstable RCU readers are allowed to read this. */
> > > -     struct vma_lock *vm_lock;
> > >  #endif
> > >
> > >       /*
> > > @@ -770,6 +768,10 @@ struct vm_area_struct {
> > >       struct vma_numab_state *numab_state;    /* NUMA Balancing state */
> > >  #endif
> > >       struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +     /* Unstable RCU readers are allowed to read this. */
> > > +     struct vma_lock vm_lock ____cacheline_aligned_in_smp;
> > > +#endif
> > >  } __randomize_layout;
> >
> > Do we just want 'struct vm_area_struct' to be cacheline aligned or do we
> > want 'struct vma_lock vm_lock' to be on a separate cacheline as well?
> 
> We want both to minimize cacheline sharing.
> 

For later, you will need to add a pad after vm_lock as well, so any
future addition will not share the cacheline with vm_lock. I would do
something like below. This is a nit and can be done later.

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7654c766cbe2..5cc4fff163a0 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -751,10 +751,12 @@ struct vm_area_struct {
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
 #ifdef CONFIG_PER_VMA_LOCK
+	CACHELINE_PADDING(__pad1__);
 	/* Unstable RCU readers are allowed to read this. */
-	struct vma_lock vm_lock ____cacheline_aligned_in_smp;
+	struct vma_lock vm_lock;
+	CACHELINE_PADDING(__pad2__);
 #endif
-} __randomize_layout;
+} __randomize_layout ____cacheline_aligned_in_smp;
 
 #ifdef CONFIG_NUMA
 #define vma_policy(vma) ((vma)->vm_policy)

