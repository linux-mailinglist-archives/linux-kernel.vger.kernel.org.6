Return-Path: <linux-kernel+bounces-522418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05388A3CA0A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810911883097
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC63323CEE5;
	Wed, 19 Feb 2025 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNvtg72B"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD28C23BF9B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997484; cv=none; b=VuULabPbqCp6trEQNImko/dLVVPg/zZXz/rr+K6D0qG/255PXh6MEli6qxvK3GTYc9g+jxJWHjTus10R4bs4pEv1c/hP8gPg4m24ApjLbcHADpi2NP8cGNF8KOfVmc0wwuNVU5sWCP28pTpSbzRibcz6CDYHlbJ792jNDl1Dbec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997484; c=relaxed/simple;
	bh=eMH4GSQCP0g6Tc9rK4mvqYmePQW4tex/SfaVGh1JYbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CM+59URq0ISqegFTvSNUFzXdjftqrk2GRBVrBXatiryfc2IclTMYx9mtFPqSDPK49jE2RNB4eIZwQWYowbYA63MR8sHBR7o49bFMzy6pWUIC53b/bD+95D4AAnWY3ylESAtL0K7cdXiJGVRJHANDfhaetsWO5Ci6GdL384v/Img=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNvtg72B; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-866faa61728so68428241.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739997481; x=1740602281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpcqkinJ93f+CbkMM1VHBdXQ4JmZq4404Dgq5xr26Z8=;
        b=BNvtg72Bzds9TZuOAPq5DjQCQzdbQcy2/lcKXKEoZiLTQV/IllD3RGu9wy+ONvxflz
         gnqZQm4QuZCHRDW4Kt9/e+u4Fki65TdbaaQBleMzxr3o/QRvDBjxbophwG+gUqL3vkDP
         ENlqXUUbMmy1amdWEd4YuJGAMerBeg0SuQYogSYEy+56OT/MTUK/YgaITsWCzWkMjDhW
         TojTTAy4Tca2j7X/kKo/C4djKOQwc2QFcFEl1KqBd+7+jIw6KljKAfFc4G6JX0V1Wve1
         PmbKECi+UcJQRN5wm9sWKe4JheOyOX5hGWBw1b/VgsaFzxCiIxjBSnP31VMXbbXgUKc2
         C2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997481; x=1740602281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpcqkinJ93f+CbkMM1VHBdXQ4JmZq4404Dgq5xr26Z8=;
        b=Py+Qkdzp4XwjnYXUyz+Qzgjfr7gczaoKp509B8muqiIn9mLMTuZl13jYShJb0lU6gB
         ZHN4P7Z8h426WHmqADWhD/Vd1bbJzDblP9P26I23d3j5rM/wtBBIgaTcROPhY+Wbb5Rs
         7VfR7tLb4LSUpo7qQuJhfVZBo5e52f8RysLMBF7qyc6Xmykzl87O3Xrl134YoMRDouhr
         oOd5MLs6++rssRyssLvyqcusldNSsAybEh7/aUZLC29OrLWC7nJIJYfShchoM8B3lupY
         ChhTd6GUq620ukM0XnOe8tabpCawuh6hI1KFuwZ+tzjTYG8T0ptOulqCNoVbNUWGaolU
         g2CA==
X-Forwarded-Encrypted: i=1; AJvYcCV78eKNoZeljc0pKSH5hHzrjpfTLs200nfPF12kxYGvr6H7O/lkOE+CHHEMaiKDIkNL/UTktCY6DPhHjRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmXkvAvs7cpOvqAG21JnTys0Rg1FeSd1EXoS7NFtl5p6OUUkU2
	vvIS5pDtVU5+l+1Zf/954qCVjCTp22UeLxnnBjUMhUbyX/ViuNfoB/3XOnDCWhGLaAGVC4rr5N3
	aoGbXof5ADeltVar5T8e9z5xjs/M=
X-Gm-Gg: ASbGncssKv0NZADTDN1yUCaFXvA1WU0W0u4ZixU8mqOJpVsR/h6US2auKRkDSId4m34
	JAvmAUChuUEWc3hn+7oRzGiiPI/ZOsw5MzqxqNVF+/3FxHfZhQkMGzQMbOOjt5qWJR7P0erCe
X-Google-Smtp-Source: AGHT+IFdnwehAYkZywx+tA0tW4jREW61yS//5FmAojgTiBJ+2cvY6p+xxxxBBL0ClnyyH+Qn6FoSZ99eKGrgAkgRPuc=
X-Received: by 2002:a05:6102:4b8b:b0:4bb:9b46:3f92 with SMTP id
 ada2fe7eead31-4be85b54ffemr3821290137.1.1739997481357; Wed, 19 Feb 2025
 12:38:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219112519.92853-1-21cnbao@gmail.com> <CAJuCfpEWFz14R1vD4Rezy98WBk25HWWX+6DsGBekeYMugKTsfQ@mail.gmail.com>
In-Reply-To: <CAJuCfpEWFz14R1vD4Rezy98WBk25HWWX+6DsGBekeYMugKTsfQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 20 Feb 2025 09:37:50 +1300
X-Gm-Features: AWEUYZl7Fs8Gu_Y7BfTXg3BRwmUDrbvzxOZDuitqXWykGGxoHxM2vqATgdWqhp8
Message-ID: <CAGsJ_4yx1=jaQmDG_9rMqHFFkoXqMJw941eYvtby28OqDq+S7g@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: Suren Baghdasaryan <surenb@google.com>, Lokesh Gidra <lokeshgidra@google.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, zhengtangquan@oppo.com, 
	Barry Song <v-songbaohua@oppo.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Axel Rasmussen <axelrasmussen@google.com>, 
	Brian Geffon <bgeffon@google.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Nicolas Geoffray <ngeoffray@google.com>, Peter Xu <peterx@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>, 
	ZhangPeng <zhangpeng362@huawei.com>, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 7:27=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Feb 19, 2025 at 3:25=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > userfaultfd_move() checks whether the PTE entry is present or a
> > swap entry.
> >
> > - If the PTE entry is present, move_present_pte() handles folio
> >   migration by setting:
> >
> >   src_folio->index =3D linear_page_index(dst_vma, dst_addr);
> >
> > - If the PTE entry is a swap entry, move_swap_pte() simply copies
> >   the PTE to the new dst_addr.
> >
> > This approach is incorrect because even if the PTE is a swap
> > entry, it can still reference a folio that remains in the swap
> > cache.
> >
> > If do_swap_page() is triggered, it may locate the folio in the
> > swap cache. However, during add_rmap operations, a kernel panic
> > can occur due to:
> >  page_pgoff(folio, page) !=3D linear_page_index(vma, address)
>
> Thanks for the report and reproducer!
>
> >
> > $./a.out > /dev/null
> > [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c ind=
ex:0xffffaf150 pfn:0x4667c
> > [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_mapp=
ed:1 pincount:0
> > [   13.337716] memcg:ffff00000405f000
> > [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|owne=
r_priv_1|head|swapbacked|node=3D0|zone=3D0|lastcpupid=3D0xffff)
> > [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b538 =
ffff000006260361
> > [   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000000 =
ffff00000405f000
> > [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b538=
 ffff000006260361
> > [   13.339204] head: 0000000ffffaf150 0000000000004000 0000000600000000=
 ffff00000405f000
> > [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff00000000=
 0000000000000001
> > [   13.339546] head: 0000000000000004 0000000000000000 00000000ffffffff=
 0000000000000000
> > [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, pa=
ge) !=3D linear_page_index(vma, address))
> > [   13.340190] ------------[ cut here ]------------
> > [   13.340316] kernel BUG at mm/rmap.c:1380!
> > [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMP=
T SMP
> > [   13.340969] Modules linked in:
> > [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-rc=
3-gcf42737e247a-dirty #299
> > [   13.341470] Hardware name: linux,dummy-virt (DT)
> > [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> > [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> > [   13.342018] sp : ffff80008752bb20
> > [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 0000000=
000000001
> > [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 0000000=
000000001
> > [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffffdf=
fc0199f00
> > [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 0000000=
0ffffffff
> > [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 6628666=
66f67705f
> > [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff800=
083728ab0
> > [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff800=
08011bc40
> > [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff800=
0829eebf8
> > [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 0000000=
000000000
> > [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 0000000=
00000005f
> > [   13.343876] Call trace:
> > [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
> > [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
> > [   13.344333]  do_swap_page+0x1060/0x1400
> > [   13.344417]  __handle_mm_fault+0x61c/0xbc8
> > [   13.344504]  handle_mm_fault+0xd8/0x2e8
> > [   13.344586]  do_page_fault+0x20c/0x770
> > [   13.344673]  do_translation_fault+0xb4/0xf0
> > [   13.344759]  do_mem_abort+0x48/0xa0
> > [   13.344842]  el0_da+0x58/0x130
> > [   13.344914]  el0t_64_sync_handler+0xc4/0x138
> > [   13.345002]  el0t_64_sync+0x1ac/0x1b0
> > [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
> > [   13.345504] ---[ end trace 0000000000000000 ]---
> > [   13.345715] note: a.out[107] exited with irqs disabled
> > [   13.345954] note: a.out[107] exited with preempt_count 2
> >
> > Fully fixing it would be quite complex, requiring similar handling
> > of folios as done in move_present_pte.
>
> How complex would that be? Is it a matter of adding
> folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
> folio->index =3D linear_page_index like in move_present_pte() or
> something more?

My main concern is still with large folios that require a split_folio()
during move_pages(), as the entire folio shares the same index and
anon_vma. However, userfaultfd_move() moves pages individually,
making a split necessary.

However, in split_huge_page_to_list_to_order(), there is a:

        if (folio_test_writeback(folio))
                return -EBUSY;

This is likely true for swapcache, right? However, even for move_present_pt=
e(),
it simply returns -EBUSY:

move_pages_pte()
{
                /* at this point we have src_folio locked */
                if (folio_test_large(src_folio)) {
                        /* split_folio() can block */
                        pte_unmap(&orig_src_pte);
                        pte_unmap(&orig_dst_pte);
                        src_pte =3D dst_pte =3D NULL;
                        err =3D split_folio(src_folio);
                        if (err)
                                goto out;

                        /* have to reacquire the folio after it got split *=
/
                        folio_unlock(src_folio);
                        folio_put(src_folio);
                        src_folio =3D NULL;
                        goto retry;
                }
}

Do we need a folio_wait_writeback() before calling split_folio()?

By the way, I have also reported that userfaultfd_move() has a fundamental
conflict with TAO (Cc'ed Yu Zhao), which has been part of the Android commo=
n
kernel. In this scenario, folios in the virtual zone won=E2=80=99t be split=
 in
split_folio(). Instead, the large folio migrates into nr_pages small folios=
.

Thus, the best-case scenario would be:

mTHP -> migrate to small folios in split_folio() -> move small folios to
dst_addr

While this works, it negates the performance benefits of
userfaultfd_move(), as it introduces two PTE operations (migration in
split_folio() and move in userfaultfd_move() while retry), nr_pages memory
allocations, and still requires one memcpy(). This could end up
performing even worse than userfaultfd_copy(), I guess.

The worst-case scenario would be failing to allocate small folios in
split_folio(), then userfaultfd_move() might return -ENOMEM?

Given these issues, I strongly recommend that ART hold off on upgrading
to userfaultfd_move() until these problems are fully understood and
resolved. Otherwise, we=E2=80=99re in for a rough ride!

>
> > For now, a quick solution
> > is to return -EBUSY.
> > I'd like to see others' opinions on whether a full fix is worth
> > pursuing.
> >
> > For anyone interested in reproducing it, the a.out test program is
> > as below,
> >
> >  #define _GNU_SOURCE
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> >  #include <sys/mman.h>
> >  #include <sys/ioctl.h>
> >  #include <sys/syscall.h>
> >  #include <linux/userfaultfd.h>
> >  #include <fcntl.h>
> >  #include <pthread.h>
> >  #include <unistd.h>
> >  #include <poll.h>
> >  #include <errno.h>
> >
> >  #define PAGE_SIZE 4096
> >  #define REGION_SIZE (512 * 1024)
> >
> >  #ifndef UFFDIO_MOVE
> >  struct uffdio_move {
> >      __u64 dst;
> >      __u64 src;
> >      __u64 len;
> >      #define UFFDIO_MOVE_MODE_DONTWAKE        ((__u64)1<<0)
> >      #define UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES ((__u64)1<<1)
> >      __u64 mode;
> >      __s64 move;
> >  };
> >  #define _UFFDIO_MOVE  (0x05)
> >  #define UFFDIO_MOVE   _IOWR(UFFDIO, _UFFDIO_MOVE, struct uffdio_move)
> >  #endif
> >
> >  void *src, *dst;
> >  int uffd;
> >
> >  void *madvise_thread(void *arg) {
> >      if (madvise(src, REGION_SIZE, MADV_PAGEOUT) =3D=3D -1) {
> >          perror("madvise MADV_PAGEOUT");
> >      }
> >      return NULL;
> >  }
> >
> >  void *fault_handler_thread(void *arg) {
> >      struct uffd_msg msg;
> >      struct uffdio_move move;
> >      struct pollfd pollfd =3D { .fd =3D uffd, .events =3D POLLIN };
> >
> >      pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> >      pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);
> >
> >      while (1) {
> >          if (poll(&pollfd, 1, -1) =3D=3D -1) {
> >              perror("poll");
> >              exit(EXIT_FAILURE);
> >          }
> >
> >          if (read(uffd, &msg, sizeof(msg)) <=3D 0) {
> >              perror("read");
> >              exit(EXIT_FAILURE);
> >          }
> >
> >          if (msg.event !=3D UFFD_EVENT_PAGEFAULT) {
> >              fprintf(stderr, "Unexpected event\n");
> >              exit(EXIT_FAILURE);
> >          }
> >
> >          move.src =3D (unsigned long)src + (msg.arg.pagefault.address -=
 (unsigned long)dst);
> >          move.dst =3D msg.arg.pagefault.address & ~(PAGE_SIZE - 1);
> >          move.len =3D PAGE_SIZE;
> >          move.mode =3D 0;
> >
> >          if (ioctl(uffd, UFFDIO_MOVE, &move) =3D=3D -1) {
> >              perror("UFFDIO_MOVE");
> >              exit(EXIT_FAILURE);
> >          }
> >      }
> >      return NULL;
> >  }
> >
> >  int main() {
> >  again:
> >      pthread_t thr, madv_thr;
> >      struct uffdio_api uffdio_api =3D { .api =3D UFFD_API, .features =
=3D 0 };
> >      struct uffdio_register uffdio_register;
> >
> >      src =3D mmap(NULL, REGION_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVAT=
E | MAP_ANONYMOUS, -1, 0);
> >      if (src =3D=3D MAP_FAILED) {
> >          perror("mmap src");
> >          exit(EXIT_FAILURE);
> >      }
> >      memset(src, 1, REGION_SIZE);
> >
> >      dst =3D mmap(NULL, REGION_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVAT=
E | MAP_ANONYMOUS, -1, 0);
> >      if (dst =3D=3D MAP_FAILED) {
> >          perror("mmap dst");
> >          exit(EXIT_FAILURE);
> >      }
> >
> >      uffd =3D syscall(SYS_userfaultfd, O_CLOEXEC | O_NONBLOCK);
> >      if (uffd =3D=3D -1) {
> >          perror("userfaultfd");
> >          exit(EXIT_FAILURE);
> >      }
> >
> >      if (ioctl(uffd, UFFDIO_API, &uffdio_api) =3D=3D -1) {
> >          perror("UFFDIO_API");
> >          exit(EXIT_FAILURE);
> >      }
> >
> >      uffdio_register.range.start =3D (unsigned long)dst;
> >      uffdio_register.range.len =3D REGION_SIZE;
> >      uffdio_register.mode =3D UFFDIO_REGISTER_MODE_MISSING;
> >
> >      if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) =3D=3D -1) {
> >          perror("UFFDIO_REGISTER");
> >          exit(EXIT_FAILURE);
> >      }
> >
> >      if (pthread_create(&madv_thr, NULL, madvise_thread, NULL) !=3D 0) =
{
> >          perror("pthread_create madvise_thread");
> >          exit(EXIT_FAILURE);
> >      }
> >
> >      if (pthread_create(&thr, NULL, fault_handler_thread, NULL) !=3D 0)=
 {
> >          perror("pthread_create fault_handler_thread");
> >          exit(EXIT_FAILURE);
> >      }
> >
> >      for (size_t i =3D 0; i < REGION_SIZE; i +=3D PAGE_SIZE) {
> >          char val =3D ((char *)dst)[i];
> >          printf("Accessing dst at offset %zu, value: %d\n", i, val);
> >      }
> >
> >      pthread_join(madv_thr, NULL);
> >      pthread_cancel(thr);
> >      pthread_join(thr, NULL);
> >
> >      munmap(src, REGION_SIZE);
> >      munmap(dst, REGION_SIZE);
> >      close(uffd);
> >      goto again;
> >      return 0;
> >  }
> >
> > As long as you enable mTHP (which likely increases the residency
> > time of swapcache), you can reproduce the issue within a few
> > seconds. But I guess the same race condition also exists with
> > small folios.
> >
> > Fixes: adef440691bab ("userfaultfd: UFFDIO_MOVE uABI")
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Axel Rasmussen <axelrasmussen@google.com>
> > Cc: Brian Geffon <bgeffon@google.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Kalesh Singh <kaleshsingh@google.com>
> > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Cc: Lokesh Gidra <lokeshgidra@google.com>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> > Cc: Nicolas Geoffray <ngeoffray@google.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: ZhangPeng <zhangpeng362@huawei.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/userfaultfd.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 867898c4e30b..34cf1c8c725d 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -18,6 +18,7 @@
> >  #include <asm/tlbflush.h>
> >  #include <asm/tlb.h>
> >  #include "internal.h"
> > +#include "swap.h"
> >
> >  static __always_inline
> >  bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long ds=
t_end)
> > @@ -1079,9 +1080,19 @@ static int move_swap_pte(struct mm_struct *mm,
> >                          pmd_t *dst_pmd, pmd_t dst_pmdval,
> >                          spinlock_t *dst_ptl, spinlock_t *src_ptl)
> >  {
> > +       struct folio *folio;
> > +       swp_entry_t entry;
> > +
> >         if (!pte_swp_exclusive(orig_src_pte))
> >                 return -EBUSY;
> >
>
> Would be helpful to add a comment explaining that this is the case
> when the folio is in the swap cache.
>
> > +       entry =3D pte_to_swp_entry(orig_src_pte);
> > +       folio =3D filemap_get_folio(swap_address_space(entry), swap_cac=
he_index(entry));
> > +       if (!IS_ERR(folio)) {
> > +               folio_put(folio);
> > +               return -EBUSY;
> > +       }
> > +
> >         double_pt_lock(dst_ptl, src_ptl);
> >
> >         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_s=
rc_pte,
> > --
> > 2.39.3 (Apple Git-146)
> >

Thanks
Barry

