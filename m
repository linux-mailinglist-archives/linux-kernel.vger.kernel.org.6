Return-Path: <linux-kernel+bounces-522428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA915A3CA50
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C5717753C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F563241C87;
	Wed, 19 Feb 2025 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjodZe3o"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4AC1B87EE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997946; cv=none; b=K7mewZUf/KInvtEbwRUaKvzmpCGhToZnyG5hNIeTxbAMKiQ5QICMrCBha50oZ/qcDYGD5pn3NDELL8Kc0fMVckmET/wO6wMCeDam9rcCuPhFf6AQY11/DYE2K0bm+/BUziPgyigj1xi922uKkf9+RELI6MU8jjzKOsS1ArG+XF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997946; c=relaxed/simple;
	bh=UJABzK2/FF66xTY2eyXSEYtcUP1ZTxpfYWHGK4mpa6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AULq4dIJUo6wpU0fGXDK7oFV/urNLcY6J+6BERpj/Pmf/EKp1hM9crQRcsleR5lhfkDAyGVT6RHOChhDudXB7t4RfYeZwRKJ8WTs8t/u2MQi1l4dGkoo2pZ1mwKfrVjIPE9gBEqb4X1WU5+ib6TWs72oTQdVe3uY5D0huF1qfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjodZe3o; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4be4de0c038so96661137.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739997943; x=1740602743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kdz4SCba9xdhN8nuXdn7O8wnIsJaLIGPRVuUKnzGCw=;
        b=CjodZe3ouBqHZusWiHlkSul9yz/AtdtPzVONAt1WJkn7q2fdSGkr8crjeyLk0tWTw5
         ufyzBOxec+bShv79Ic1A/Lfajzs0ShlSa8GoU9cxxas+vPobzUyp07Qx2M8tdX+WJhfg
         xWdDzF4BqUcp34N8+vQPt92Gi1aq9cf6vujC02NWTrRYyosTlDok+j/UlPk+5l73jf8L
         Oi1NNrmR+W9HDKe9jSwEeOzuKadZZ9WyGsPlbbYTmMWAaYf//RrXQ3PixQXZz+n0gg7F
         /wJ8ejWwEBFEP3Dfkvzxy6uF7s0We0QV6fVxC6merf7ND2g6QZsSXpiHgwcojXK10GbJ
         olRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997943; x=1740602743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kdz4SCba9xdhN8nuXdn7O8wnIsJaLIGPRVuUKnzGCw=;
        b=KCH0239lsznYR502J5JthxDCkvEAlbBy1B1SI6tJXgoQRnGQsEVz/O342WTIUJ/w3C
         tYsCtz3buOqegAPsewrAZVY15YuRY2nkjN9FOf5P1eO/NcuiOddSPDxjN5QDf4mYczH3
         ZkR0EkXq7DHKROu//ZMEHLJnJyYLnNpFohrQY2CgNxrXOGKfijIZI4PcLbFP/lgKxDD3
         qgCMPp0OeOOpNOVnmIBJBBO+NUAi/XnsYiaEkbpjZpiVeWSPqEj4Tr5tFd+L9rznfTnA
         PPYFnDkO8J7ImZLAiyU4TK+YWynViihBUfa3oXxjjvHntzZKQls75iKkMZcr631TF8jH
         2lBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhLrlXS9VRG4qbp8CfP21bCARCfAN4ZLrQ3Do937YTktNGmIOS+kl6SVV7KCxOHoh9sChUPQK44K0epm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtxlzU7OdLU9UGymMM9EyCKKlrGT8Ych608fVuyCoEpTW7Cr6k
	L0prR8UtO1xoLINt5qKmLl2/mFAjXQejZOXI/ly1ZBVZy+4xMqQulQNfMMleboKVbhlDekOEjoY
	H0X2Lom6ldMhi+xcR7MXsqrBmO+0=
X-Gm-Gg: ASbGncsLdgO4xHO3mmOh74QHZCimOeqN7qGPMTTFE/hg3XBYKBV0p4KfkbH1SN15dOv
	scWaDsRtZEfrlLu/fcHNKC2fxpEKorBjKg9hOKlOY3Nf863ZGPP1ucBc4S3w7B1VhXMiGgE4t
X-Google-Smtp-Source: AGHT+IFRyFHSbPg3/hU95ww3EgpIsFXMJqe9Iqd9gJrZQxjPUkB7mpRhnebwjC3Ub46zGGpSlp3kFmM+cTMGDycR79Q=
X-Received: by 2002:a05:6102:38d0:b0:4b2:af77:b53a with SMTP id
 ada2fe7eead31-4bd3fca53b5mr12554016137.11.1739997942703; Wed, 19 Feb 2025
 12:45:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219112519.92853-1-21cnbao@gmail.com> <CA+EESO5ZVODEwv7X6HET8pstzs5kB1yCaxK80nOKzQKJPMLwuQ@mail.gmail.com>
In-Reply-To: <CA+EESO5ZVODEwv7X6HET8pstzs5kB1yCaxK80nOKzQKJPMLwuQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 20 Feb 2025 09:45:31 +1300
X-Gm-Features: AWEUYZnRLDo1Bbx1Y126RSQSoIOiOt_dGqBvxIzKKQC-3id9cE10C0cXBZJnITY
Message-ID: <CAGsJ_4y_8EVTM7NfhhwKHKYPeVU6TwFAmLARxKnK6fA0LQo1dw@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, zhengtangquan@oppo.com, 
	Barry Song <v-songbaohua@oppo.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Axel Rasmussen <axelrasmussen@google.com>, Brian Geffon <bgeffon@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Jann Horn <jannh@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Nicolas Geoffray <ngeoffray@google.com>, Peter Xu <peterx@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>, 
	ZhangPeng <zhangpeng362@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 7:40=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.co=
m> wrote:
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
> > of folios as done in move_present_pte. For now, a quick solution
> > is to return -EBUSY.
> > I'd like to see others' opinions on whether a full fix is worth
> > pursuing.
> >
>
> Thanks a lot for finding this.
>
> As a user of MOVE ioctl (in Android GC) I strongly urge you to fix
> this properly. Because this is not going to be a rare occurrence in
> the case of Android. And when -EBUSY is returned, all that userspace
> can do is touch the page, which also does not guarantee that a
> subsequent retry of the ioctl will succeed.

Not trying to push this idea, but I=E2=80=99m curious if it's feasible:

If UFFDIO_MOVE fails, could userspace fall back to UFFDIO_COPY?

I=E2=80=99m still trying to wrap my head around a few things, particularly
what exactly UFFDIO_MOVE is doing with mTHP, as I mentioned in my
reply to Suren and you in another email:

https://lore.kernel.org/linux-mm/CAGsJ_4yx1=3DjaQmDG_9rMqHFFkoXqMJw941eYvtb=
y28OqDq+S7g@mail.gmail.com/


>
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
>

Thanks
Barry

