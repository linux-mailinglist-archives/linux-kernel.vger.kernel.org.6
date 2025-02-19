Return-Path: <linux-kernel+bounces-522596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22918A3CC25
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E5F170639
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4604E1C831A;
	Wed, 19 Feb 2025 22:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtsjQTTl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB1B286280
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003334; cv=none; b=HNDVZhJH0i6BrcjKJA3QT6V1ZQUS2mzivBv/XBXCHLEyZxw8Ww0MoQ7DNXOI2rSwt6cpITslF229FJI4nFyrrGC9nXqTYiq8J5G2tXik1F6MOr7L1l6l1lPg/rL2j5StdhF36djNR7YCHuuNnP2fsqOdHDgYaxLvBgTAXjNmVOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003334; c=relaxed/simple;
	bh=9SHOsNYy9Y8SxMn/z77/4Qpl9FE0yS/ciGb+YLVb17A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQVkACPA7IJdofGwPL/zADdNxazcpYixLDqEspimJgvyIYUSMk5mIjEHdj4prvHdkyV0ZwpehO1P/87CtNbPplgcW+UDm6pIGkCQhsazhVOZpcKA1lm1a39seypgZo7bLeUla1AeEO/JtXL6cC9JkP7eA3YRZnHHPUjfQT+bBSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GtsjQTTl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740003331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrS3w5cPkfUyAbuuPgZnTzClRhX+WafKJW4l7dP2oU8=;
	b=GtsjQTTlUthTezHykJjlheGiiBkOQs03eRL7YpAMPotk87EZk6wPldzNXDf2jEIG9pLV62
	yuIdVDLHgx9tXdA9m7O0lwE4dsQmT2CkIuERluJDNo+x/P/dvPP4BeJ5kbtcrCONUNDzzX
	Tb3eTp3qQXD8/h8974ShNoINUk1bPNw=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-WQgay5PcPmOqwhj4Wteolw-1; Wed, 19 Feb 2025 17:14:58 -0500
X-MC-Unique: WQgay5PcPmOqwhj4Wteolw-1
X-Mimecast-MFC-AGG-ID: WQgay5PcPmOqwhj4Wteolw_1740003297
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-72739d998e3so82388a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:14:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740003297; x=1740608097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lrS3w5cPkfUyAbuuPgZnTzClRhX+WafKJW4l7dP2oU8=;
        b=DrLPfjW6LTpa8DHCTZBe5nIrfmfw2uD5uiVb0YNqp24FBkyA0bGhox7XJQI0xeju9y
         wcccvcqzCSu50D6wKXgXoppwOLrMgKNqaMThIvBgVAiZObSnOOhpZiN74SjoaTnYGwxZ
         ZZRSi12PjaIGc9VQDekFt0jyXACAVPYyKMvUSmpHBfPWYg3B2zPYe7ytOySfSaGO4Ovt
         vY6KYrhG7ym5Gp17KsoeHYRGTcZB9G/Y7dKR4VBgoVwG5d4SnqqClge/CVPD8c+I0WlU
         Sr34X6TaGz6ONaRtcP86Db8jWfXAYNIT/sMjz9oB5verzqu2XFsRJl9dOJqxHuDXVfP2
         a/Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXckTD+i8GhELUoXyrpuJ0kh5jtvGfU86DokBiW2uJeVazsutJ3pZZcjmQFkd6r1d3M5OkzKOaX86XhTao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJqzUA8bzyxVhXy/OwsBM2oRThV0zsz7P5Ft3y/HHPPt+2iEE
	8F1sSkpNnnMskTzxQG9q2i4cESdcD2IBoi0aUCw7c6aUOHRLX81Wt+K9EcfT47+wk9Pmnux6xTe
	AV1eZOLr7G1TQ2SP2V1s1txees/lN4o5fPKMmvCIuDaQV8VoW99Y7gyqKzBidQw==
X-Gm-Gg: ASbGncsYWhSFGCNoxHGmKax5pJYWzfyqKqtmJNfao1eZVdwgdzQOK2LzPAVpV55qvuv
	MNfhRH8ujwuSm4Hi6cZ0NXT4M2M5GNbeShu5LGADj3oHfTxahJLK8xKh//K0IbP0VhwYyT2QDhV
	Pt6wAawXJpcyESAMzpSTIXZuByQ/eCtRcAmEjEKHPf6gUZWV5N/S4YWohUbmk5XiaPs+8v5n8Fk
	0a/hUJZSDL1Ub3C7nTf4tWEUdvkQCES0f+s3Ecze87usGa5AvpLN7SmHV0=
X-Received: by 2002:a05:6830:350b:b0:71e:1c5:4f7c with SMTP id 46e09a7af769-72712063768mr15587667a34.14.1740003297333;
        Wed, 19 Feb 2025 14:14:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXyLlYbrucTQyJqzFh7DpMS9GEM7XBiUCb/ep7FSUF4SGHuxa+Aa5ctHnroDraOSsLjL1yZw==
X-Received: by 2002:a05:6830:350b:b0:71e:1c5:4f7c with SMTP id 46e09a7af769-72712063768mr15587625a34.14.1740003296856;
        Wed, 19 Feb 2025 14:14:56 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7272c6a7e40sm1711881a34.69.2025.02.19.14.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 14:14:55 -0800 (PST)
Date: Wed, 19 Feb 2025 17:14:51 -0500
From: Peter Xu <peterx@redhat.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	zhengtangquan@oppo.com, Barry Song <v-songbaohua@oppo.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Brian Geffon <bgeffon@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Nicolas Geoffray <ngeoffray@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
	ZhangPeng <zhangpeng362@huawei.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters
 swapcache
Message-ID: <Z7ZX28XARM7seknO@x1.local>
References: <20250219112519.92853-1-21cnbao@gmail.com>
 <CAJuCfpEWFz14R1vD4Rezy98WBk25HWWX+6DsGBekeYMugKTsfQ@mail.gmail.com>
 <CAGsJ_4yx1=jaQmDG_9rMqHFFkoXqMJw941eYvtby28OqDq+S7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4yx1=jaQmDG_9rMqHFFkoXqMJw941eYvtby28OqDq+S7g@mail.gmail.com>

On Thu, Feb 20, 2025 at 09:37:50AM +1300, Barry Song wrote:
> On Thu, Feb 20, 2025 at 7:27 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Wed, Feb 19, 2025 at 3:25 AM Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > userfaultfd_move() checks whether the PTE entry is present or a
> > > swap entry.
> > >
> > > - If the PTE entry is present, move_present_pte() handles folio
> > >   migration by setting:
> > >
> > >   src_folio->index = linear_page_index(dst_vma, dst_addr);
> > >
> > > - If the PTE entry is a swap entry, move_swap_pte() simply copies
> > >   the PTE to the new dst_addr.
> > >
> > > This approach is incorrect because even if the PTE is a swap
> > > entry, it can still reference a folio that remains in the swap
> > > cache.
> > >
> > > If do_swap_page() is triggered, it may locate the folio in the
> > > swap cache. However, during add_rmap operations, a kernel panic
> > > can occur due to:
> > >  page_pgoff(folio, page) != linear_page_index(vma, address)
> >
> > Thanks for the report and reproducer!
> >
> > >
> > > $./a.out > /dev/null
> > > [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c index:0xffffaf150 pfn:0x4667c
> > > [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_mapped:1 pincount:0
> > > [   13.337716] memcg:ffff00000405f000
> > > [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|owner_priv_1|head|swapbacked|node=0|zone=0|lastcpupid=0xffff)
> > > [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
> > > [   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
> > > [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
> > > [   13.339204] head: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
> > > [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff00000000 0000000000000001
> > > [   13.339546] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
> > > [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, page) != linear_page_index(vma, address))
> > > [   13.340190] ------------[ cut here ]------------
> > > [   13.340316] kernel BUG at mm/rmap.c:1380!
> > > [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> > > [   13.340969] Modules linked in:
> > > [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-rc3-gcf42737e247a-dirty #299
> > > [   13.341470] Hardware name: linux,dummy-virt (DT)
> > > [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> > > [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> > > [   13.342018] sp : ffff80008752bb20
> > > [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 0000000000000001
> > > [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 0000000000000001
> > > [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffffdffc0199f00
> > > [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 00000000ffffffff
> > > [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 662866666f67705f
> > > [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff800083728ab0
> > > [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff80008011bc40
> > > [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff8000829eebf8
> > > [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 0000000000000000
> > > [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 000000000000005f
> > > [   13.343876] Call trace:
> > > [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
> > > [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
> > > [   13.344333]  do_swap_page+0x1060/0x1400
> > > [   13.344417]  __handle_mm_fault+0x61c/0xbc8
> > > [   13.344504]  handle_mm_fault+0xd8/0x2e8
> > > [   13.344586]  do_page_fault+0x20c/0x770
> > > [   13.344673]  do_translation_fault+0xb4/0xf0
> > > [   13.344759]  do_mem_abort+0x48/0xa0
> > > [   13.344842]  el0_da+0x58/0x130
> > > [   13.344914]  el0t_64_sync_handler+0xc4/0x138
> > > [   13.345002]  el0t_64_sync+0x1ac/0x1b0
> > > [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
> > > [   13.345504] ---[ end trace 0000000000000000 ]---
> > > [   13.345715] note: a.out[107] exited with irqs disabled
> > > [   13.345954] note: a.out[107] exited with preempt_count 2
> > >
> > > Fully fixing it would be quite complex, requiring similar handling
> > > of folios as done in move_present_pte.
> >
> > How complex would that be? Is it a matter of adding
> > folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
> > folio->index = linear_page_index like in move_present_pte() or
> > something more?
> 
> My main concern is still with large folios that require a split_folio()
> during move_pages(), as the entire folio shares the same index and
> anon_vma. However, userfaultfd_move() moves pages individually,
> making a split necessary.
> 
> However, in split_huge_page_to_list_to_order(), there is a:
> 
>         if (folio_test_writeback(folio))
>                 return -EBUSY;
> 
> This is likely true for swapcache, right? However, even for move_present_pte(),
> it simply returns -EBUSY:
> 
> move_pages_pte()
> {
>                 /* at this point we have src_folio locked */
>                 if (folio_test_large(src_folio)) {
>                         /* split_folio() can block */
>                         pte_unmap(&orig_src_pte);
>                         pte_unmap(&orig_dst_pte);
>                         src_pte = dst_pte = NULL;
>                         err = split_folio(src_folio);
>                         if (err)
>                                 goto out;
> 
>                         /* have to reacquire the folio after it got split */
>                         folio_unlock(src_folio);
>                         folio_put(src_folio);
>                         src_folio = NULL;
>                         goto retry;
>                 }
> }
> 
> Do we need a folio_wait_writeback() before calling split_folio()?

Maybe no need in the first version to fix the immediate bug?

It's also not always the case to hit writeback here. IIUC, writeback only
happens for a short window when the folio was just added into swapcache.
MOVE can happen much later after that anytime before a swapin.  My
understanding is that's also what Matthew wanted to point out.  It may be
better justified of that in a separate change with some performance
measurements.

Thanks,

-- 
Peter Xu


