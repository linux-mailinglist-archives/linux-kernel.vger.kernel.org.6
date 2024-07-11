Return-Path: <linux-kernel+bounces-249962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0190492F239
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C531C227E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D49519FA86;
	Thu, 11 Jul 2024 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpTv6tuC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C02A12C477
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720738067; cv=none; b=f7imlBWWHTvsd0sD4FIpzujnn+78ViD0m6gdICh7GA6IprRCnjamOuSJWUKZShluIv5ts/9qznN9I8ebfETQJpyGWBZWGeVg9UU/4aauyXQkkShofbt1Cmku/1zme9jFB8To8/NM81fLi4uaUqjDxW9O/ZGsz+p1kh48pVy6/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720738067; c=relaxed/simple;
	bh=RVPB+kgxEAOGVrCf+IxrqUC2VKA71l8WoyiFRqAk7bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OC+KQa68WS2mFt6rj+uf50mDc45QplWUjl4LuSuep8cqvoHmAP5Yh7l6ZQs2qoDRw/2vp6KYsXMZIPz5j3HsIcttaLL6CaXQ0Wo+H2pNI3YwdE1TDFOT5g+fWspjYltNi28B2qGF53ZZymIw3C7Q1NTe4itLItuQdep+Sjxv4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpTv6tuC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720738064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jUUE4IEeDu26fE4TU1o+NLYPFE26wbQVbpeOsn3UXXI=;
	b=CpTv6tuC3Uv3hR778hcMZJPYNPoLKbar9tMFpcVPaNk+oglfIAPcYhRlhIEY3p+ITjzEsB
	O6eSw7N3COZY0zOAD9x4VCABAl91zQYGjlnbfAgl3QOxrP+YrYEZyX4pA3o3ZR8XMTTSKK
	JIYd83LMJlLzmrwYFh/yuVSm4BzaFC8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-gOD9nvNcNAuIkOR3gTtuTw-1; Thu, 11 Jul 2024 18:47:41 -0400
X-MC-Unique: gOD9nvNcNAuIkOR3gTtuTw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-704496bca36so122530a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720738060; x=1721342860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUUE4IEeDu26fE4TU1o+NLYPFE26wbQVbpeOsn3UXXI=;
        b=hp/XAuojAgXl6s6xQtrsglkqOXOvvXBoZtDpNKRSfh6tCsjBzIb5kPVEKUrVPAZ2im
         sEGbeZ2kecuTSpRP7WfrmrFZmBfjM7shOZFdecbHYwy1rDZsuhrmVp1YlJwsEbcRV0ik
         NGRjPJpSHd5R9huap17Lxqnow99sT1e1vJT4uXkr2+2uA9IQIxpZZBmuG0uArZ/XE7Q6
         3AlD9dAUeVFMjzMkZM9EoVG/lkeb3r6zjVJKaNShQXmwTzg+JIasYczKXzYZt7Ug/LJX
         /JRHmumDsUXzUQ0oxN0LTP8wiMmFtKnvFi/XpwV+YnqDcJkF6v6u5I40SxA0iBGZVHC6
         bkHg==
X-Forwarded-Encrypted: i=1; AJvYcCWXlTNNEcukHEbcU7rcWp/MsCQTFi+5gP+AFOFVatk45nIDBEkBU0zN/s2ILOPu/mhSmymWM3UGLJ6Y69eJVkEGjA8KKZ2djtztwez6
X-Gm-Message-State: AOJu0YyX6nem+KB0wRuUD7G0Dqks3D8S4lA0J7u2DUco4RfMtjrGvKrj
	MVV3WvV+mwaSVXT4+XqyL5j5AR/DAEznd+nQkDHyMV5KUlXO7QE0UnYeL8sD6vyrjI01Xu9VQ7B
	a/PLrsy0MH9SYwhAS+SmTMq6pbdEZ98Tfq58iN73BdGwDenWsPu52K1+6oTPxmg==
X-Received: by 2002:a05:6870:b48b:b0:25e:dce:491b with SMTP id 586e51a60fabf-2603a6b1846mr4151081fac.1.1720738060532;
        Thu, 11 Jul 2024 15:47:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGifGQLAfLsA3PvJ0N0vhdzW8eV9Axj5BbRdepNcpr12Y+xwkO3ea+jL3/qN/UDGzQlYNNLpQ==
X-Received: by 2002:a05:6870:b48b:b0:25e:dce:491b with SMTP id 586e51a60fabf-2603a6b1846mr4151066fac.1.1720738060089;
        Thu, 11 Jul 2024 15:47:40 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a148df63c1sm107037485a.11.2024.07.11.15.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 15:47:39 -0700 (PDT)
Date: Thu, 11 Jul 2024 18:47:36 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Pei Li <peili.dev@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm: Fix mmap_assert_locked() in follow_pte()
Message-ID: <ZpBhCHsG39wIVnQN@x1n>
References: <20240710-bug12-v1-1-0e5440f9b8d3@gmail.com>
 <92a2dc30-6e48-44ea-9cde-693b911f200d@redhat.com>
 <3879ee72-84de-4d2a-93a8-c0b3dc3f0a4c@redhat.com>
 <e4719acd-4ee4-435d-a596-093794d15be6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4719acd-4ee4-435d-a596-093794d15be6@redhat.com>

On Thu, Jul 11, 2024 at 11:51:41PM +0200, David Hildenbrand wrote:
> On 11.07.24 23:45, David Hildenbrand wrote:
> > On 11.07.24 23:33, David Hildenbrand wrote:
> > > On 11.07.24 07:13, Pei Li wrote:
> > > > This patch fixes this warning by acquiring read lock before entering
> > > > untrack_pfn() while write lock is not held.
> > > > 
> > > > syzbot has tested the proposed patch and the reproducer did not
> > > > trigger any issue.
> > > > 
> > > > Reported-by: syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=35a4414f6e247f515443
> > > > Tested-by: syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com
> > > > Signed-off-by: Pei Li <peili.dev@gmail.com>
> > > > ---
> > > > Syzbot reported the following warning in follow_pte():
> > > > 
> > > > WARNING: CPU: 3 PID: 5192 at include/linux/rwsem.h:195 rwsem_assert_held include/linux/rwsem.h:195 [inline]
> > > > WARNING: CPU: 3 PID: 5192 at include/linux/rwsem.h:195 mmap_assert_locked include/linux/mmap_lock.h:65 [inline]
> > > > WARNING: CPU: 3 PID: 5192 at include/linux/rwsem.h:195 follow_pte+0x414/0x4c0 mm/memory.c:5980
> > > > 
> > > > This is because we are assuming that mm->mmap_lock should be held when
> > > > entering follow_pte(). This is added in commit c5541ba378e3 (mm:
> > > > follow_pte() improvements).
> > > > 
> > > > However, in the following call stack, we are not acquring the lock:
> > > >     follow_phys arch/x86/mm/pat/memtype.c:957 [inline]
> > > >     get_pat_info+0xf2/0x510 arch/x86/mm/pat/memtype.c:991
> > > >     untrack_pfn+0xf7/0x4d0 arch/x86/mm/pat/memtype.c:1104
> > > >     unmap_single_vma+0x1bd/0x2b0 mm/memory.c:1819
> > > >     zap_page_range_single+0x326/0x560 mm/memory.c:1920
> > > 
> > > That implies that unmap_vmas() is called without the mmap lock in read
> > > mode, correct?
> > > 
> > > Do we know how this happens?
> > > 
> > > * exit_mmap() holds the mmap lock in read mode
> > > * unmap_region is documented to hold the mmap lock in read mode
> > 
> > I think this is it (missed the call from zap_page_range_single()):
> > 
> >    follow_phys arch/x86/mm/pat/memtype.c:957 [inline]
> >    get_pat_info+0xf2/0x510 arch/x86/mm/pat/memtype.c:991
> >    untrack_pfn+0xf7/0x4d0 arch/x86/mm/pat/memtype.c:1104
> >    unmap_single_vma+0x1bd/0x2b0 mm/memory.c:1819
> >    zap_page_range_single+0x326/0x560 mm/memory.c:1920
> >    unmap_mapping_range_vma mm/memory.c:3684 [inline]
> >    unmap_mapping_range_tree mm/memory.c:3701 [inline]
> >    unmap_mapping_pages mm/memory.c:3767 [inline]
> >    unmap_mapping_range+0x1ee/0x280 mm/memory.c:3804
> >    truncate_pagecache+0x53/0x90 mm/truncate.c:731
> >    simple_setattr+0xf2/0x120 fs/libfs.c:886
> >    notify_change+0xec6/0x11f0 fs/attr.c:499
> >    do_truncate+0x15c/0x220 fs/open.c:65
> >    handle_truncate fs/namei.c:3308 [inline]
> > 
> > I think Peter recently questioned whether untrack_pfn() should be even
> > called from the place, but I might misremember things.
> > 
> > Fix should work (I suspect we are not violating some locking rules?),
> > PFNMAP should not happen there too often that we really care.
> 
> ... thinking again, likely we reach this point with "!mm_wr_locked" and the
> mmap lock already held in read mode. So I suspect the fix won't work as is.

Ah yes, I had one rfc patch for that, I temporarily put that aside as it
seemed nobody cared except myself.. it's here:

https://lore.kernel.org/all/20240523223745.395337-2-peterx@redhat.com

I didn't know it can already cause real trouble.  It looks like that patch
should fix this.

Thanks,

-- 
Peter Xu


