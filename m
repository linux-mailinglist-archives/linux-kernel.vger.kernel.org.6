Return-Path: <linux-kernel+bounces-524959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90532A3E92C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3433BFCF5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBD379FD;
	Fri, 21 Feb 2025 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OPTAuUEc"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FBBA31
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740098183; cv=none; b=JYFBXoSTV9fn2TJgbT5qIkOaB5SSzk3nxyJ7bqEI3Slb3VknagNRFsz0eYyz4K/2I/yLo7nj+0mWu0Gr/UepjOnhFeZZZm2fob8ZzA/lDogp7oUZwgNGp/XSYTA5h9vgsIJKWjYwIdBpK6LHIWsrkcDDuVyUhYt7wZRjbJUp7Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740098183; c=relaxed/simple;
	bh=gEnS80rCqQ507kGmSH2X6BN1GafijNf0Icp4TgQxWiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IctXtilkVKC4QrPGolvWboaeNyk/a1lSGZr8I6wvLRlMu+XhMjmKtr8CHQqTZdE4O0In9eSMSq854D89x9N/oRP/2dRxjMLvdyTw0R33sf39TtQvZPS3cM7v0y3Upaqr54NcgveY4IdQ5OsGxUyMTtGxaZKx2hXAcUKPyEnKPLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OPTAuUEc; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-472098e6e75so70231cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740098180; x=1740702980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndbATN2bQYxCQ40vKy6hYq1kBt06N1Kmt7sbVE6aE6M=;
        b=OPTAuUEcsoC3pKfBE/w94M3nzY2ie9FiXfkZl/9GVVslrsukQ+PIRuADL3eI1ZWdb+
         NVg4dLJevRX4krtj3l5u6Ay9dLeNMVJRN+MMij4Xy4askR5LGJ4aYsZm8QnpWMmpGpD9
         8JW5qJT63trum86y46t7kaxOwWnZjHixdfLWscRb6vOjsvw+mKrXToKWDwBlXCScjXvh
         PSyH7nT3twUxvJzXO68PR+njkXb37NRrN0JVXdds++iCUsQgbQ57gwY0GCpPOfqqfVx1
         Wh4Mnc9jl9i6k2T5j8a5BTfY4QLcDvJnfXFXFIKenpMlUfCdrU+JOP+N34gOraRC73Op
         e5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740098180; x=1740702980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndbATN2bQYxCQ40vKy6hYq1kBt06N1Kmt7sbVE6aE6M=;
        b=Dcm59UzGNJtqi9UZ8imNINYAokBTFsV2UCu+uaPXGxA5V5CVsVURdfuuh3K+cB0zdJ
         qQjADUo1yMbz4whzsISv3ytpxb0oDRDfrZ8V9DXSzJm6h6Sz/qASLDWrFBfCt4qjoi3h
         46KBmHMhdguthwKAKel3ZCySBgTerxlPeObMX3B06IpLZCXcYhhOuA0LKjtTq91Uk6+h
         8mS2qDqDRzCYj8hbIeHLU8uX7otvXtxyK+fVBGRDChcekwWbXKLQfk7lKB+sqGVsIqqQ
         PMAWuiMjk+GLJV9aT5awnDlBdQrExv4joZdG6TEGmSvo1TztMVeIw6J90tyY+hXIPnma
         u8sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbEXiLTTKBxTrPOE0IDXMsMmdzezEBFJKMCQpMTubhOUALv1Nbzr99SLBHxw0FjBlNYUUtb1Ne0xpeXf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuVUlCgffNj6SnIhHHd9ZQZcbHO1YuytscMyQswYhHT1VtRvOg
	3Z85gp6S5OUNwLw0OziN8f3B4YEcPES5aSY/B0dtEmsUWqhjiI2NPFQF+D9GdO/TPo9rUE5qH/X
	FbkQb6bMM/i+gsC1gn913w/ntCYNxjYUci9Oi
X-Gm-Gg: ASbGncssiFi9cI+UPxCEWkfoBSmEHemlJEMP/0RPffVuFyglM9YdsB+Gg4B1ncDupiR
	KXZP/r01KMLuAWP3QBSrqbVEtyCnL8gUCYImQc+h5rg85VeTiUDl+I8HiIgApDNPs9M+iMuWh
X-Google-Smtp-Source: AGHT+IE92lIZZbQYgejE/zFDjDSUSYgBR8VlYgUVrXto+vwpwaz2n/RkKysVuugmqszQijY20EYb8Hi2LNd0zwnYHu8=
X-Received: by 2002:a05:622a:1a06:b0:471:e982:c73d with SMTP id
 d75a77b69052e-472250dbc04mr673351cf.11.1740098179481; Thu, 20 Feb 2025
 16:36:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219112519.92853-1-21cnbao@gmail.com> <CAJuCfpEWFz14R1vD4Rezy98WBk25HWWX+6DsGBekeYMugKTsfQ@mail.gmail.com>
 <CAGsJ_4yx1=jaQmDG_9rMqHFFkoXqMJw941eYvtby28OqDq+S7g@mail.gmail.com>
 <Z7ZX28XARM7seknO@x1.local> <CAGsJ_4wptMn8HX6Uam7AQpWeE=nOUDHE-Vr81SQJq_oSjmTFHg@mail.gmail.com>
 <Z7ez2Vl8Sa_bRb4e@x1.local> <CAJuCfpHmS7y-gb7YTn4TfPz-YHau3po7TU3tN+8q+1JxXm-rtQ@mail.gmail.com>
 <CAJuCfpHMpEJRAb9O+aRX4f638Ubb7FgwLorm+f1TJ8mUTMV7hA@mail.gmail.com>
In-Reply-To: <CAJuCfpHMpEJRAb9O+aRX4f638Ubb7FgwLorm+f1TJ8mUTMV7hA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 20 Feb 2025 16:36:08 -0800
X-Gm-Features: AWEUYZnStP-lAeMijR0y6LNLygrcaQlKBYJ8BbZJ6dED70knG-ILcs1ltaL_Xu4
Message-ID: <CAJuCfpEeEbdE2ycEQ+3zSbCE3NJsG1vTbqMtZyzry6FRFZB61w@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: Peter Xu <peterx@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	zhengtangquan@oppo.com, Barry Song <v-songbaohua@oppo.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Axel Rasmussen <axelrasmussen@google.com>, Brian Geffon <bgeffon@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Jann Horn <jannh@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Nicolas Geoffray <ngeoffray@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Shuah Khan <shuah@kernel.org>, ZhangPeng <zhangpeng362@huawei.com>, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:52=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Feb 20, 2025 at 3:47=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Thu, Feb 20, 2025 at 2:59=E2=80=AFPM Peter Xu <peterx@redhat.com> wr=
ote:
> > >
> > > On Thu, Feb 20, 2025 at 12:04:40PM +1300, Barry Song wrote:
> > > > On Thu, Feb 20, 2025 at 11:15=E2=80=AFAM Peter Xu <peterx@redhat.co=
m> wrote:
> > > > >
> > > > > On Thu, Feb 20, 2025 at 09:37:50AM +1300, Barry Song wrote:
> > > > > > On Thu, Feb 20, 2025 at 7:27=E2=80=AFAM Suren Baghdasaryan <sur=
enb@google.com> wrote:
> > > > > > >
> > > > > > > On Wed, Feb 19, 2025 at 3:25=E2=80=AFAM Barry Song <21cnbao@g=
mail.com> wrote:
> > > > > > > >
> > > > > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > > > > >
> > > > > > > > userfaultfd_move() checks whether the PTE entry is present =
or a
> > > > > > > > swap entry.
> > > > > > > >
> > > > > > > > - If the PTE entry is present, move_present_pte() handles f=
olio
> > > > > > > >   migration by setting:
> > > > > > > >
> > > > > > > >   src_folio->index =3D linear_page_index(dst_vma, dst_addr)=
;
> > > > > > > >
> > > > > > > > - If the PTE entry is a swap entry, move_swap_pte() simply =
copies
> > > > > > > >   the PTE to the new dst_addr.
> > > > > > > >
> > > > > > > > This approach is incorrect because even if the PTE is a swa=
p
> > > > > > > > entry, it can still reference a folio that remains in the s=
wap
> > > > > > > > cache.
> > > > > > > >
> > > > > > > > If do_swap_page() is triggered, it may locate the folio in =
the
> > > > > > > > swap cache. However, during add_rmap operations, a kernel p=
anic
> > > > > > > > can occur due to:
> > > > > > > >  page_pgoff(folio, page) !=3D linear_page_index(vma, addres=
s)
> > > > > > >
> > > > > > > Thanks for the report and reproducer!
> > > > > > >
> > > > > > > >
> > > > > > > > $./a.out > /dev/null
> > > > > > > > [   13.336953] page: refcount:6 mapcount:1 mapping:00000000=
f43db19c index:0xffffaf150 pfn:0x4667c
> > > > > > > > [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 n=
r_pages_mapped:1 pincount:0
> > > > > > > > [   13.337716] memcg:ffff00000405f000
> > > > > > > > [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodat=
e|dirty|owner_priv_1|head|swapbacked|node=3D0|zone=3D0|lastcpupid=3D0xffff)
> > > > > > > > [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff8=
0008507b538 ffff000006260361
> > > > > > > > [   13.338831] raw: 0000000ffffaf150 0000000000004000 00000=
00600000000 ffff00000405f000
> > > > > > > > [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff=
80008507b538 ffff000006260361
> > > > > > > > [   13.339204] head: 0000000ffffaf150 0000000000004000 0000=
000600000000 ffff00000405f000
> > > > > > > > [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffff=
ffff00000000 0000000000000001
> > > > > > > > [   13.339546] head: 0000000000000004 0000000000000000 0000=
0000ffffffff 0000000000000000
> > > > > > > > [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgo=
ff(folio, page) !=3D linear_page_index(vma, address))
> > > > > > > > [   13.340190] ------------[ cut here ]------------
> > > > > > > > [   13.340316] kernel BUG at mm/rmap.c:1380!
> > > > > > > > [   13.340683] Internal error: Oops - BUG: 00000000f2000800=
 [#1] PREEMPT SMP
> > > > > > > > [   13.340969] Modules linked in:
> > > > > > > > [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not taint=
ed 6.14.0-rc3-gcf42737e247a-dirty #299
> > > > > > > > [   13.341470] Hardware name: linux,dummy-virt (DT)
> > > > > > > > [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -=
DIT -SSBS BTYPE=3D--)
> > > > > > > > [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> > > > > > > > [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> > > > > > > > [   13.342018] sp : ffff80008752bb20
> > > > > > > > [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 =
x27: 0000000000000001
> > > > > > > > [   13.342404] x26: 0000000000000000 x25: 0000000000000001 =
x24: 0000000000000001
> > > > > > > > [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 =
x21: fffffdffc0199f00
> > > > > > > > [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 =
x18: 00000000ffffffff
> > > > > > > > [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f =
x15: 662866666f67705f
> > > > > > > > [   13.343033] x14: 6567617028454741 x13: 2929737365726464 =
x12: ffff800083728ab0
> > > > > > > > [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 =
x9 : ffff80008011bc40
> > > > > > > > [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 =
x6 : ffff8000829eebf8
> > > > > > > > [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 =
x3 : 0000000000000000
> > > > > > > > [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 =
x0 : 000000000000005f
> > > > > > > > [   13.343876] Call trace:
> > > > > > > > [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
> > > > > > > > [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
> > > > > > > > [   13.344333]  do_swap_page+0x1060/0x1400
> > > > > > > > [   13.344417]  __handle_mm_fault+0x61c/0xbc8
> > > > > > > > [   13.344504]  handle_mm_fault+0xd8/0x2e8
> > > > > > > > [   13.344586]  do_page_fault+0x20c/0x770
> > > > > > > > [   13.344673]  do_translation_fault+0xb4/0xf0
> > > > > > > > [   13.344759]  do_mem_abort+0x48/0xa0
> > > > > > > > [   13.344842]  el0_da+0x58/0x130
> > > > > > > > [   13.344914]  el0t_64_sync_handler+0xc4/0x138
> > > > > > > > [   13.345002]  el0t_64_sync+0x1ac/0x1b0
> > > > > > > > [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d=
4210000)
> > > > > > > > [   13.345504] ---[ end trace 0000000000000000 ]---
> > > > > > > > [   13.345715] note: a.out[107] exited with irqs disabled
> > > > > > > > [   13.345954] note: a.out[107] exited with preempt_count 2
> > > > > > > >
> > > > > > > > Fully fixing it would be quite complex, requiring similar h=
andling
> > > > > > > > of folios as done in move_present_pte.
> > > > > > >
> > > > > > > How complex would that be? Is it a matter of adding
> > > > > > > folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap()=
 and
> > > > > > > folio->index =3D linear_page_index like in move_present_pte()=
 or
> > > > > > > something more?
> > > > > >
> > > > > > My main concern is still with large folios that require a split=
_folio()
> > > > > > during move_pages(), as the entire folio shares the same index =
and
> > > > > > anon_vma. However, userfaultfd_move() moves pages individually,
> > > > > > making a split necessary.
> > > > > >
> > > > > > However, in split_huge_page_to_list_to_order(), there is a:
> > > > > >
> > > > > >         if (folio_test_writeback(folio))
> > > > > >                 return -EBUSY;
> > > > > >
> > > > > > This is likely true for swapcache, right? However, even for mov=
e_present_pte(),
> > > > > > it simply returns -EBUSY:
> > > > > >
> > > > > > move_pages_pte()
> > > > > > {
> > > > > >                 /* at this point we have src_folio locked */
> > > > > >                 if (folio_test_large(src_folio)) {
> > > > > >                         /* split_folio() can block */
> > > > > >                         pte_unmap(&orig_src_pte);
> > > > > >                         pte_unmap(&orig_dst_pte);
> > > > > >                         src_pte =3D dst_pte =3D NULL;
> > > > > >                         err =3D split_folio(src_folio);
> > > > > >                         if (err)
> > > > > >                                 goto out;
> > > > > >
> > > > > >                         /* have to reacquire the folio after it=
 got split */
> > > > > >                         folio_unlock(src_folio);
> > > > > >                         folio_put(src_folio);
> > > > > >                         src_folio =3D NULL;
> > > > > >                         goto retry;
> > > > > >                 }
> > > > > > }
> > > > > >
> > > > > > Do we need a folio_wait_writeback() before calling split_folio(=
)?
> > > > >
> > > > > Maybe no need in the first version to fix the immediate bug?
> > > > >
> > > > > It's also not always the case to hit writeback here. IIUC, writeb=
ack only
> > > > > happens for a short window when the folio was just added into swa=
pcache.
> > > > > MOVE can happen much later after that anytime before a swapin.  M=
y
> > > > > understanding is that's also what Matthew wanted to point out.  I=
t may be
> > > > > better justified of that in a separate change with some performan=
ce
> > > > > measurements.
> > > >
> > > > The bug we=E2=80=99re discussing occurs precisely within the short =
window you
> > > > mentioned.
> > > >
> > > > 1. add_to_swap: The folio is added to swapcache.
> > > > 2. try_to_unmap: PTEs are converted to swap entries.
> > > > 3. pageout
> > > > 4. Swapcache is cleared.
> > >
> > > Hmm, I see. I was expecting step 4 to be "writeback is cleared".. or =
at
> > > least that should be step 3.5, as IIUC "writeback" needs to be cleare=
d
> > > before "swapcache" bit being cleared.
> > >
> > > >
> > > > The issue happens between steps 2 and 4, where the PTE is not prese=
nt, but
> > > > the folio is still in swapcache - the current code does move_swap_p=
te() but does
> > > > not fixup folio->index within swapcache.
> > >
> > > One thing I'm still not clear here is why it's a race condition, rath=
er
> > > than more severe than that.  I mean, folio->index is definitely wrong=
, then
> > > as long as the page still in swapcache, we should be able to move the=
 swp
> > > entry over to dest addr of UFFDIO_MOVE, read on dest addr, then it'll=
 see
> > > the page in swapcache with the wrong folio->index already and trigger=
.
> > >
> > > I wrote a quick test like that, it actually won't trigger..
> > >
> > > I had a closer look in the code, I think it's because do_swap_page() =
has
> > > the logic to detect folio->index matching first, and allocate a new f=
olio
> > > if it doesn't match in ksm_might_need_to_copy().  IIUC that was for
> > > ksm.. but it looks like it's functioning too here.
> > >
> > > ksm_might_need_to_copy:
> > >         if (folio_test_ksm(folio)) {
> > >                 if (folio_stable_node(folio) &&
> > >                     !(ksm_run & KSM_RUN_UNMERGE))
> > >                         return folio;   /* no need to copy it */
> > >         } else if (!anon_vma) {
> > >                 return folio;           /* no need to copy it */
> > >         } else if (folio->index =3D=3D linear_page_index(vma, addr) &=
& <---------- [1]
> > >                         anon_vma->root =3D=3D vma->anon_vma->root) {
> > >                 return folio;           /* still no need to copy it *=
/
> > >         }
> > >         ...
> > >
> > >         new_folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, a=
ddr); <---- [2]
> > >         ...
> > >
> > > So I believe what I hit is at [1] it sees index doesn't match, then i=
t
> > > decided to allocate a new folio.  In this case, it won't hit your BUG
> > > because it'll be "folio !=3D swapcache" later, so it'll setup the
> > > folio->index for the new one, rather than the sanity check.
> > >
> > > Do you know how your case got triggered, being able to bypass the abo=
ve [1]
> > > which should check folio->index already?
> >
> > To understand the change I tried applying the proposed patch to both
> > mm-unstable and Linus' ToT and got conflicts for both trees. Barry,
> > which baseline are you using?
>
> Oops, never mind. My mistake. Copying from the email messed up tabs...
> It applies cleanly.

Overall the code seems correct to me, however the new code has quite
complex logical structure IMO. Original simplified code structure is
like this:

if (pte_present(orig_src_pte)) {
        if (is_zero_pfn) {
                move_zeropage_pte()
                return
        }
        // pin and lock src_folio
        spin_lock(src_ptl)
        folio_get(folio)
        folio_trylock(folio)
        if (folio_test_large(src_folio))
                split_folio(src_folio)
        anon_vma_trylock_write(src_anon_vma)
        move_present_pte()
} else {
        if (non_swap_entry(entry))
                if (is_migration_entry(entry))
                        handle migration entry
        else
                move_swap_pte()
}

The new structure looks like this:

if (!pte_present(orig_src_pte)) {
        if (is_migration_entry(entry)) {
                handle migration entry
                return
       }
        if (!non_swap_entry() ||  !pte_swp_exclusive())
                return
        si =3D get_swap_device(entry);
}
if (pte_present(orig_src_pte) && is_zero_pfn(pte_pfn(orig_src_pte)))
        move_zeropage_pte()
        return
}
pin and lock src_folio
        spin_lock(src_ptl)
        if (pte_present(orig_src_pte))
                folio_get(folio)
        else {
                folio =3D filemap_get_folio(swap_entry)
                if (IS_ERR(folio))
                        move_swap_pte()
                        return
                }
        }
        folio_trylock(folio)
if (folio_test_large(src_folio))
        split_folio(src_folio)
if (pte_present(orig_src_pte))
        anon_vma_trylock_write(src_anon_vma)
move_pte_and_folio()

This looks more complex and harder to follow. Might be the reason
David was not in favour of treating swapcache and present pages in the
same path. And now I would agree that refactoring some common parts
and not breaking the original structure might be cleaner.

>
> >
> > >
> > > >
> > > > My point is that if we want a proper fix for mTHP, we'd better hand=
le writeback.
> > > > Otherwise, this isn=E2=80=99t much different from directly returnin=
g -EBUSY as proposed
> > > > in this RFC.
> > > >
> > > > For small folios, there=E2=80=99s no split_folio issue, making it r=
elatively
> > > > simpler. Lokesh
> > > > mentioned plans to madvise NOHUGEPAGE in ART, so fixing small folio=
s is likely
> > > > the first priority.
> > >
> > > Agreed.
> > >
> > > --
> > > Peter Xu
> > >

