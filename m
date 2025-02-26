Return-Path: <linux-kernel+bounces-532750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C080FA451CC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477CD189A606
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9349515382E;
	Wed, 26 Feb 2025 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4Vm5KGh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8042030A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740531629; cv=none; b=kAgeT5Hm2jKYFsEI5TJfKQ8gwZKPZxrjBSJszB8TuFl5CSpLuvw6iR5iAcFZzglMfmwS6cOoJOjyuBLd4O+AohuIBFKFAw+yi38e1SzFu17Txw33bqrbzKIFSrtzqUkhDVzeld221CgwvXKDQvqYv6cLZV9bEn2w6+og7DM0Nrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740531629; c=relaxed/simple;
	bh=LPoch6vDJyPzsEHR0IrgI85cEioyNrYuQTqhn8ite5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CctjLC1tPFSjm9To10BchFbVZbZrUJwpU+2q2U+2SvukHaGJHcuoV+u9p7qnPMM0lhyJS3ktkSTvB1OupjAyG4GGfjwBbPr9+TnhUPeT0jd1719vn83f6SU8cfeiaID4cLfx5MtPhhhMPmUPEOklkriNhmH885oR60UaaRkoywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4Vm5KGh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740531626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LlunlS80VHH5jVGoIKOsJ5HRL508+NZGIkDXyQZb5Ro=;
	b=Z4Vm5KGhKFeOcaEO5Hbrux4hKYFFjWL+P+UsGyojL8Nd6TmfhrAcrb1lPsJLHU7Uj959ha
	7ySKRTD6E+wElA1IUhDZ0C46qQ2NsA2R2cD5q5c7+ijdCeuYSxLlBiuKPdbc5bJYV3TXWT
	VbdFKXd5BZlHn681rGJv0nMBusYqrz4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-mkK-oTqpNpi4taSVf5FOZw-1; Tue, 25 Feb 2025 20:00:24 -0500
X-MC-Unique: mkK-oTqpNpi4taSVf5FOZw-1
X-Mimecast-MFC-AGG-ID: mkK-oTqpNpi4taSVf5FOZw_1740531624
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e66c406bb4so7990676d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740531624; x=1741136424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlunlS80VHH5jVGoIKOsJ5HRL508+NZGIkDXyQZb5Ro=;
        b=cvVd/oWL/qBKnnoaiVsYRwgkfTAsGigcM8DdbJxpRE43DIX5zCIMZZQgA40h8XGqJr
         nP761vRLcxsTxsUMEQw0VKBL8OXhO5psEMLIV85IK/jWjVPnxS4vd2DxiFW/4VYX0Xfz
         peAfhnMvqahgCOoxwTfANv5Ym+bm8/wqq5B7t7bgfUMvOY3pSun9ybsyjIBIRSI1WX6J
         e3ArDh3ZNLdvWddfmE2dbw5aCQ06PSaB+HoENv6zYGfRs43VQFvGzp8t53SuHj5/6s/F
         /++DbcRfoXFmXdGWOXt9gBxkItmB15QNYTPDw70uYu3MuAsHrICYHVz0nkvPY9CK6aYj
         +Pdw==
X-Forwarded-Encrypted: i=1; AJvYcCW0nYC2nAkGbpeoAZ4wbAWmPYowo+4IFHs16yo64/HlimkSM388ZMoaoyACDsLDY33Ji5q1E/JGj7xm4nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ce6CCnv4J4scfpa3LVURaVi33VIUJxzSka1qv7yY4lnf0pAu
	zuF3YX0SZyyqVtFcqGgMgXu1Qaler3e/EMXSDbcf/GO1ZRWP4ed1EQc9i3sKRAyI/BEmC38o68S
	hx9a5QpONCcG0bUMVKB0yTeUwICp1DGGEVva4Sh8FLXgQmKA9v7i2ZoCOqINV0g==
X-Gm-Gg: ASbGncvMYpjclyItD49BxXEhQ+tdyJzd94z0QBzArsxrJyR79SXkbbRPmSaLzqNu1nJ
	h/vPNXD1yXHAk0m/kJfx8rhGW3anhCPDE+hjIrTuVlLHrVfZDX6/vbjUwHMbc8mHREI49/qgNkZ
	ulTMvx9/NtKgamOW6MlnQzJ0nrC2SDaNwy4iUztkyAumif0J3UW7+51V1MIuSU1Q7mKlfm/CQ1q
	5dJqpbsUIT3rxPgf0AvaecFOSr7DJu0WQcnY8+BZw79kvkrMwdvQzXFaewWzy8LpNQ9zQ==
X-Received: by 2002:a05:6214:1c43:b0:6e6:646d:7550 with SMTP id 6a1803df08f44-6e6ae8b0dddmr294586736d6.19.1740531623612;
        Tue, 25 Feb 2025 17:00:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHU2P9sv6oy5pfSwZSHR05ikYvhpDFMlvn2SB/fC59WzmCk4kPsUvs4Qcp69VXxmPb+ISpcxA==
X-Received: by 2002:a05:6214:1c43:b0:6e6:646d:7550 with SMTP id 6a1803df08f44-6e6ae8b0dddmr294585656d6.19.1740531622706;
        Tue, 25 Feb 2025 17:00:22 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b06dc62sm16122516d6.1.2025.02.25.17.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 17:00:22 -0800 (PST)
Date: Tue, 25 Feb 2025 20:00:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Brian Geffon <bgeffon@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Nicolas Geoffray <ngeoffray@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
	ZhangPeng <zhangpeng362@huawei.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: Fix kernel BUG when userfaultfd_move encounters
 swapcache
Message-ID: <Z75nokRl5Bp0ywiX@x1.local>
References: <20250226001400.9129-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226001400.9129-1-21cnbao@gmail.com>

On Wed, Feb 26, 2025 at 01:14:00PM +1300, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> userfaultfd_move() checks whether the PTE entry is present or a
> swap entry.
> 
> - If the PTE entry is present, move_present_pte() handles folio
>   migration by setting:
> 
>   src_folio->index = linear_page_index(dst_vma, dst_addr);
> 
> - If the PTE entry is a swap entry, move_swap_pte() simply copies
>   the PTE to the new dst_addr.
> 
> This approach is incorrect because, even if the PTE is a swap entry,
> it can still reference a folio that remains in the swap cache.
> 
> This creates a race window between steps 2 and 4.
>  1. add_to_swap: The folio is added to the swapcache.
>  2. try_to_unmap: PTEs are converted to swap entries.
>  3. pageout: The folio is written back.
>  4. Swapcache is cleared.
> If userfaultfd_move() occurs in the window between steps 2 and 4,
> after the swap PTE has been moved to the destination, accessing the
> destination triggers do_swap_page(), which may locate the folio in
> the swapcache. However, since the folio's index has not been updated
> to match the destination VMA, do_swap_page() will detect a mismatch.
> 
> This can result in two critical issues depending on the system
> configuration.
> 
> If KSM is disabled, both small and large folios can trigger a BUG
> during the add_rmap operation due to:
> 
>  page_pgoff(folio, page) != linear_page_index(vma, address)
> 
> [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c index:0xffffaf150 pfn:0x4667c
> [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_mapped:1 pincount:0
> [   13.337716] memcg:ffff00000405f000
> [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|owner_priv_1|head|swapbacked|node=0|zone=0|lastcpupid=0xffff)
> [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
> [   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
> [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
> [   13.339204] head: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
> [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff00000000 0000000000000001
> [   13.339546] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
> [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, page) != linear_page_index(vma, address))
> [   13.340190] ------------[ cut here ]------------
> [   13.340316] kernel BUG at mm/rmap.c:1380!
> [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> [   13.340969] Modules linked in:
> [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-rc3-gcf42737e247a-dirty #299
> [   13.341470] Hardware name: linux,dummy-virt (DT)
> [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> [   13.342018] sp : ffff80008752bb20
> [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 0000000000000001
> [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 0000000000000001
> [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffffdffc0199f00
> [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 00000000ffffffff
> [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 662866666f67705f
> [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff800083728ab0
> [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff80008011bc40
> [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff8000829eebf8
> [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 0000000000000000
> [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 000000000000005f
> [   13.343876] Call trace:
> [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
> [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
> [   13.344333]  do_swap_page+0x1060/0x1400
> [   13.344417]  __handle_mm_fault+0x61c/0xbc8
> [   13.344504]  handle_mm_fault+0xd8/0x2e8
> [   13.344586]  do_page_fault+0x20c/0x770
> [   13.344673]  do_translation_fault+0xb4/0xf0
> [   13.344759]  do_mem_abort+0x48/0xa0
> [   13.344842]  el0_da+0x58/0x130
> [   13.344914]  el0t_64_sync_handler+0xc4/0x138
> [   13.345002]  el0t_64_sync+0x1ac/0x1b0
> [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
> [   13.345504] ---[ end trace 0000000000000000 ]---
> [   13.345715] note: a.out[107] exited with irqs disabled
> [   13.345954] note: a.out[107] exited with preempt_count 2
> 
> If KSM is enabled, Peter Xu also discovered that do_swap_page() may
> trigger an unexpected CoW operation for small folios because
> ksm_might_need_to_copy() allocates a new folio when the folio index
> does not match linear_page_index(vma, addr).
> 
> This patch also checks the swapcache when handling swap entries. If a
> match is found in the swapcache, it processes it similarly to a present
> PTE.
> However, there are some differences. For example, the folio is no longer
> exclusive because folio_try_share_anon_rmap_pte() is performed during
> unmapping.
> Furthermore, in the case of swapcache, the folio has already been
> unmapped, eliminating the risk of concurrent rmap walks and removing the
> need to acquire src_folio's anon_vma or lock.
> 
> Note that for large folios, in the swapcache handling path, we directly
> return -EBUSY since split_folio() will return -EBUSY regardless if
> the folio is under writeback or unmapped. This is not an urgent issue,
> so a follow-up patch may address it separately.
> 
> Fixes: adef440691bab ("userfaultfd: UFFDIO_MOVE uABI")
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Brian Geffon <bgeffon@google.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Lokesh Gidra <lokeshgidra@google.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: Nicolas Geoffray <ngeoffray@google.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: ZhangPeng <zhangpeng362@huawei.com>
> Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Acked-by: Peter Xu <peterx@redhat.com>

Some nitpicks below, maybe no worth for a repost..

> ---
>  mm/userfaultfd.c | 76 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 67 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 867898c4e30b..2df5d100e76d 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -18,6 +18,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/tlb.h>
>  #include "internal.h"
> +#include "swap.h"
>  
>  static __always_inline
>  bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long dst_end)
> @@ -1072,16 +1073,14 @@ static int move_present_pte(struct mm_struct *mm,
>  	return err;
>  }
>  
> -static int move_swap_pte(struct mm_struct *mm,
> +static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
>  			 unsigned long dst_addr, unsigned long src_addr,
>  			 pte_t *dst_pte, pte_t *src_pte,
>  			 pte_t orig_dst_pte, pte_t orig_src_pte,
>  			 pmd_t *dst_pmd, pmd_t dst_pmdval,
> -			 spinlock_t *dst_ptl, spinlock_t *src_ptl)
> +			 spinlock_t *dst_ptl, spinlock_t *src_ptl,
> +			 struct folio *src_folio)
>  {
> -	if (!pte_swp_exclusive(orig_src_pte))
> -		return -EBUSY;
> -
>  	double_pt_lock(dst_ptl, src_ptl);
>  
>  	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
> @@ -1090,10 +1089,20 @@ static int move_swap_pte(struct mm_struct *mm,
>  		return -EAGAIN;
>  	}
>  
> +	/*
> +	 * The src_folio resides in the swapcache, requiring an update to its
> +	 * index and mapping to align with the dst_vma, where a swap-in may
> +	 * occur and hit the swapcache after moving the PTE.
> +	 */
> +	if (src_folio) {
> +		folio_move_anon_rmap(src_folio, dst_vma);
> +		src_folio->index = linear_page_index(dst_vma, dst_addr);
> +	}
> +
>  	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
>  	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
> -	double_pt_unlock(dst_ptl, src_ptl);
>  
> +	double_pt_unlock(dst_ptl, src_ptl);

Unnecessary line move.

>  	return 0;
>  }
>  
> @@ -1137,6 +1146,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>  			  __u64 mode)
>  {
>  	swp_entry_t entry;
> +	struct swap_info_struct *si = NULL;
>  	pte_t orig_src_pte, orig_dst_pte;
>  	pte_t src_folio_pte;
>  	spinlock_t *src_ptl, *dst_ptl;
> @@ -1318,6 +1328,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>  				       orig_dst_pte, orig_src_pte, dst_pmd,
>  				       dst_pmdval, dst_ptl, src_ptl, src_folio);
>  	} else {
> +		struct folio *folio = NULL;
> +
>  		entry = pte_to_swp_entry(orig_src_pte);
>  		if (non_swap_entry(entry)) {
>  			if (is_migration_entry(entry)) {
> @@ -1331,9 +1343,53 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>  			goto out;
>  		}
>  
> -		err = move_swap_pte(mm, dst_addr, src_addr, dst_pte, src_pte,
> -				    orig_dst_pte, orig_src_pte, dst_pmd,
> -				    dst_pmdval, dst_ptl, src_ptl);
> +		if (!pte_swp_exclusive(orig_src_pte)) {
> +			err = -EBUSY;
> +			goto out;
> +		}
> +
> +		si = get_swap_device(entry);
> +		if (unlikely(!si)) {
> +			err = -EAGAIN;
> +			goto out;
> +		}
> +		/*
> +		 * Verify the existence of the swapcache. If present, the folio's
> +		 * index and mapping must be updated even when the PTE is a swap
> +		 * entry. The anon_vma lock is not taken during this process since
> +		 * the folio has already been unmapped, and the swap entry is
> +		 * exclusive, preventing rmap walks.
> +		 *
> +		 * For large folios, return -EBUSY immediately, as split_folio()
> +		 * also returns -EBUSY when attempting to split unmapped large
> +		 * folios in the swapcache. This issue needs to be resolved
> +		 * separately to allow proper handling.
> +		 */
> +		if (!src_folio)
> +			folio = filemap_get_folio(swap_address_space(entry),
> +					swap_cache_index(entry));
> +		if (!IS_ERR_OR_NULL(folio)) {
> +			if (folio && folio_test_large(folio)) {

Can drop this folio check as it just did check "!IS_ERR_OR_NULL(folio)"..

> +				err = -EBUSY;
> +				folio_put(folio);
> +				goto out;
> +			}
> +			src_folio = folio;
> +			src_folio_pte = orig_src_pte;
> +			if (!folio_trylock(src_folio)) {
> +				pte_unmap(&orig_src_pte);
> +				pte_unmap(&orig_dst_pte);
> +				src_pte = dst_pte = NULL;
> +				/* now we can block and wait */
> +				folio_lock(src_folio);
> +				put_swap_device(si);
> +				si = NULL;

Not sure if it can do any harm, but maybe still nicer to put swap before
locking folio.

Thanks,

> +				goto retry;
> +			}
> +		}
> +		err = move_swap_pte(mm, dst_vma, dst_addr, src_addr, dst_pte, src_pte,
> +				orig_dst_pte, orig_src_pte, dst_pmd, dst_pmdval,
> +				dst_ptl, src_ptl, src_folio);
>  	}
>  
>  out:
> @@ -1350,6 +1406,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>  	if (src_pte)
>  		pte_unmap(src_pte);
>  	mmu_notifier_invalidate_range_end(&range);
> +	if (si)
> +		put_swap_device(si);
>  
>  	return err;
>  }
> -- 
> 2.39.3 (Apple Git-146)
> 

-- 
Peter Xu


