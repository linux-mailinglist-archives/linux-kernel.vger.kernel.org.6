Return-Path: <linux-kernel+bounces-522247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C32A3C7C9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F13F1652AB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8CD214203;
	Wed, 19 Feb 2025 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r28K8dUW"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7C91F463E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990434; cv=none; b=s42mp0wl6MKOP7FCksdRzVpPDvYZDNXVNQOOqlqkaPfQ3j9IdEti60QmGyCmEnjDVAx/n99dYlnE7gOELL0DUMbx86PyowRbiNiMWfPnF6+iCz8+vsFTnLit94CBjilUuqgElOPQnfJiegpBcOKEH7wp6WXk0nEvbB///OlYP+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990434; c=relaxed/simple;
	bh=IJ6oSyTkd1ctwZiuH77Lv05Wu1Y1AA+I4ApXQhiXiks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfAS3+wiQiezKPEmJXTTw+Pt8qyOeBgYN0OhKFh3UGyHWkGEBZxbhJdIfODp57GgNrvwCM7xegRih7JnCPAbP/1vX2R/x3zSFwS+owXxoUo3ydgbyVuh4c6FBvEzzOgcJlwnrcfRgjT1vt8s9wRFdzmiSvbBCNxFqqYofdMK44o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r28K8dUW; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-471fa3b19bcso24371cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739990431; x=1740595231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+aiBX5mYLVEQ0DzdCZoYVvQ9Fhgln1LR2vsAbHKfTg=;
        b=r28K8dUWu9VjDahP/Bd8VTTcw24dIenfGNHywWs3K+1NcfItyuvQ6D3DaDoO9Bp0iK
         TGAStIMpgW+MHfU0TKJ11xD+7UNp6bcXFzCygCkrcVxDV9ZWq8mzkStdeKSU1piYYUV6
         k/154dAGKmrpRHm2R97J/ZomEpMoRTRKOWFb32Mco+u14yheyLOefUoMOUMIOW1taZOI
         G7vmltx3MLRuWj06qegRY3XtQ1gpKm01i2XtCkVbpQdrZGXgcGVbuMHwGlsqQiOMGwbv
         ajP7Nv8Pb9h4F1PeFfkNGDOhZo8O2O2LoFNecPzoESpjZsWkJI1YXN4+6+G9CEz86nOy
         B72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739990431; x=1740595231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+aiBX5mYLVEQ0DzdCZoYVvQ9Fhgln1LR2vsAbHKfTg=;
        b=RwfGJhAC55z6rpEWt7wXPWSB4LUaFNSG31kq3b26IJCgCqZcYLZ/kj2SEMNBY/4/va
         DXU6lr2zZpm52ADGFgQhx7AWOkZo6ehVx9nQvZRk8vpNgcEQOosLbBC3S2q6cntpqAk3
         qQ/hyTJrs7+iEhO0r706TOG8ISAEPxcFHTUC1TiVdLd/OUzthhi8O704lFd7L1HJaCi9
         0A4OUx/534PlPPs+wIGEhEBzavrgoSzCw2BMGc9IgD+7kF86Qq8+kd48E2OhQRrQ9mhO
         P2ttTupFV/v5SQS+uLVHhVirNJMZobn3NLD0PrQO+yi0C5u1FeCw3duPCIecamouoIDU
         o0Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWcYLpC1kE6FKHYzahRGNz8TTroTWeQFhlM8bmpZQtukJwUntr+ViKvi5X6lIL3rpYQxvc4yZ9qRrWouAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+TLAkE4QtEBNcPy5+ZVs0z9ubKVMo3SjIKSYltzXTEmpBpdGv
	CAK+cTXAmzfWCEWlTrjcZypQ9RjFPTCUTyIoBtTFWKS7VHIx7vGG3cZPkb/+NNhs/RwKg8ePOSf
	9fChqjilmpd9ySlYkqr8MouXYu5J8TtZmnJwh
X-Gm-Gg: ASbGncuq0EA2Zt+eWvJ8DEDxsF2jD2xGXAksF8IqSEaCzS9Wp8TBTxqj/efSQyIvLX1
	pbHB76hCjUjEGtye/WMfgZkqcGnrjSQLIACgKImhp9b+Sb5LdncTgRucI+vVpk70kI6z4R8rzcP
	RNKbeI5WGDCyoJXQN8eNEkqxFDzQo=
X-Google-Smtp-Source: AGHT+IHUVP+rYco5y77I2napBK/5RAwH9AQXuSLJxRQPCAB2MeHa3z+wycIOHgqjl8/jctkRIA9PBf5Y56U49Yf86pU=
X-Received: by 2002:a05:622a:284:b0:471:f34d:1d83 with SMTP id
 d75a77b69052e-4720a4e2fadmr4025251cf.7.1739990431267; Wed, 19 Feb 2025
 10:40:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219112519.92853-1-21cnbao@gmail.com>
In-Reply-To: <20250219112519.92853-1-21cnbao@gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Wed, 19 Feb 2025 10:40:19 -0800
X-Gm-Features: AWEUYZn0eb1WdvDVflIr5RFfBe6ebJUvO0pCSFFXvZBQ6PCLVBN2j74RX1OKjWc
Message-ID: <CA+EESO5ZVODEwv7X6HET8pstzs5kB1yCaxK80nOKzQKJPMLwuQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: Barry Song <21cnbao@gmail.com>
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

On Wed, Feb 19, 2025 at 3:25=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> userfaultfd_move() checks whether the PTE entry is present or a
> swap entry.
>
> - If the PTE entry is present, move_present_pte() handles folio
>   migration by setting:
>
>   src_folio->index =3D linear_page_index(dst_vma, dst_addr);
>
> - If the PTE entry is a swap entry, move_swap_pte() simply copies
>   the PTE to the new dst_addr.
>
> This approach is incorrect because even if the PTE is a swap
> entry, it can still reference a folio that remains in the swap
> cache.
>
> If do_swap_page() is triggered, it may locate the folio in the
> swap cache. However, during add_rmap operations, a kernel panic
> can occur due to:
>  page_pgoff(folio, page) !=3D linear_page_index(vma, address)
>
> $./a.out > /dev/null
> [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c index=
:0xffffaf150 pfn:0x4667c
> [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_mapped=
:1 pincount:0
> [   13.337716] memcg:ffff00000405f000
> [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|owner_=
priv_1|head|swapbacked|node=3D0|zone=3D0|lastcpupid=3D0xffff)
> [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ff=
ff000006260361
> [   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000000 ff=
ff00000405f000
> [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b538 f=
fff000006260361
> [   13.339204] head: 0000000ffffaf150 0000000000004000 0000000600000000 f=
fff00000405f000
> [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff00000000 0=
000000000000001
> [   13.339546] head: 0000000000000004 0000000000000000 00000000ffffffff 0=
000000000000000
> [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, page=
) !=3D linear_page_index(vma, address))
> [   13.340190] ------------[ cut here ]------------
> [   13.340316] kernel BUG at mm/rmap.c:1380!
> [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT =
SMP
> [   13.340969] Modules linked in:
> [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-rc3-=
gcf42737e247a-dirty #299
> [   13.341470] Hardware name: linux,dummy-virt (DT)
> [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> [   13.342018] sp : ffff80008752bb20
> [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 000000000=
0000001
> [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 000000000=
0000001
> [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffffdffc=
0199f00
> [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 00000000f=
fffffff
> [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 662866666=
f67705f
> [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff80008=
3728ab0
> [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff80008=
011bc40
> [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff80008=
29eebf8
> [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 000000000=
0000000
> [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 000000000=
000005f
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
> Fully fixing it would be quite complex, requiring similar handling
> of folios as done in move_present_pte. For now, a quick solution
> is to return -EBUSY.
> I'd like to see others' opinions on whether a full fix is worth
> pursuing.
>

Thanks a lot for finding this.

As a user of MOVE ioctl (in Android GC) I strongly urge you to fix
this properly. Because this is not going to be a rare occurrence in
the case of Android. And when -EBUSY is returned, all that userspace
can do is touch the page, which also does not guarantee that a
subsequent retry of the ioctl will succeed.

> For anyone interested in reproducing it, the a.out test program is
> as below,
>
>  #define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <sys/mman.h>
>  #include <sys/ioctl.h>
>  #include <sys/syscall.h>
>  #include <linux/userfaultfd.h>
>  #include <fcntl.h>
>  #include <pthread.h>
>  #include <unistd.h>
>  #include <poll.h>
>  #include <errno.h>
>
>  #define PAGE_SIZE 4096
>  #define REGION_SIZE (512 * 1024)
>
>  #ifndef UFFDIO_MOVE
>  struct uffdio_move {
>      __u64 dst;
>      __u64 src;
>      __u64 len;
>      #define UFFDIO_MOVE_MODE_DONTWAKE        ((__u64)1<<0)
>      #define UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES ((__u64)1<<1)
>      __u64 mode;
>      __s64 move;
>  };
>  #define _UFFDIO_MOVE  (0x05)
>  #define UFFDIO_MOVE   _IOWR(UFFDIO, _UFFDIO_MOVE, struct uffdio_move)
>  #endif
>
>  void *src, *dst;
>  int uffd;
>
>  void *madvise_thread(void *arg) {
>      if (madvise(src, REGION_SIZE, MADV_PAGEOUT) =3D=3D -1) {
>          perror("madvise MADV_PAGEOUT");
>      }
>      return NULL;
>  }
>
>  void *fault_handler_thread(void *arg) {
>      struct uffd_msg msg;
>      struct uffdio_move move;
>      struct pollfd pollfd =3D { .fd =3D uffd, .events =3D POLLIN };
>
>      pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
>      pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);
>
>      while (1) {
>          if (poll(&pollfd, 1, -1) =3D=3D -1) {
>              perror("poll");
>              exit(EXIT_FAILURE);
>          }
>
>          if (read(uffd, &msg, sizeof(msg)) <=3D 0) {
>              perror("read");
>              exit(EXIT_FAILURE);
>          }
>
>          if (msg.event !=3D UFFD_EVENT_PAGEFAULT) {
>              fprintf(stderr, "Unexpected event\n");
>              exit(EXIT_FAILURE);
>          }
>
>          move.src =3D (unsigned long)src + (msg.arg.pagefault.address - (=
unsigned long)dst);
>          move.dst =3D msg.arg.pagefault.address & ~(PAGE_SIZE - 1);
>          move.len =3D PAGE_SIZE;
>          move.mode =3D 0;
>
>          if (ioctl(uffd, UFFDIO_MOVE, &move) =3D=3D -1) {
>              perror("UFFDIO_MOVE");
>              exit(EXIT_FAILURE);
>          }
>      }
>      return NULL;
>  }
>
>  int main() {
>  again:
>      pthread_t thr, madv_thr;
>      struct uffdio_api uffdio_api =3D { .api =3D UFFD_API, .features =3D =
0 };
>      struct uffdio_register uffdio_register;
>
>      src =3D mmap(NULL, REGION_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE =
| MAP_ANONYMOUS, -1, 0);
>      if (src =3D=3D MAP_FAILED) {
>          perror("mmap src");
>          exit(EXIT_FAILURE);
>      }
>      memset(src, 1, REGION_SIZE);
>
>      dst =3D mmap(NULL, REGION_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE =
| MAP_ANONYMOUS, -1, 0);
>      if (dst =3D=3D MAP_FAILED) {
>          perror("mmap dst");
>          exit(EXIT_FAILURE);
>      }
>
>      uffd =3D syscall(SYS_userfaultfd, O_CLOEXEC | O_NONBLOCK);
>      if (uffd =3D=3D -1) {
>          perror("userfaultfd");
>          exit(EXIT_FAILURE);
>      }
>
>      if (ioctl(uffd, UFFDIO_API, &uffdio_api) =3D=3D -1) {
>          perror("UFFDIO_API");
>          exit(EXIT_FAILURE);
>      }
>
>      uffdio_register.range.start =3D (unsigned long)dst;
>      uffdio_register.range.len =3D REGION_SIZE;
>      uffdio_register.mode =3D UFFDIO_REGISTER_MODE_MISSING;
>
>      if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) =3D=3D -1) {
>          perror("UFFDIO_REGISTER");
>          exit(EXIT_FAILURE);
>      }
>
>      if (pthread_create(&madv_thr, NULL, madvise_thread, NULL) !=3D 0) {
>          perror("pthread_create madvise_thread");
>          exit(EXIT_FAILURE);
>      }
>
>      if (pthread_create(&thr, NULL, fault_handler_thread, NULL) !=3D 0) {
>          perror("pthread_create fault_handler_thread");
>          exit(EXIT_FAILURE);
>      }
>
>      for (size_t i =3D 0; i < REGION_SIZE; i +=3D PAGE_SIZE) {
>          char val =3D ((char *)dst)[i];
>          printf("Accessing dst at offset %zu, value: %d\n", i, val);
>      }
>
>      pthread_join(madv_thr, NULL);
>      pthread_cancel(thr);
>      pthread_join(thr, NULL);
>
>      munmap(src, REGION_SIZE);
>      munmap(dst, REGION_SIZE);
>      close(uffd);
>      goto again;
>      return 0;
>  }
>
> As long as you enable mTHP (which likely increases the residency
> time of swapcache), you can reproduce the issue within a few
> seconds. But I guess the same race condition also exists with
> small folios.
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
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/userfaultfd.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 867898c4e30b..34cf1c8c725d 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -18,6 +18,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/tlb.h>
>  #include "internal.h"
> +#include "swap.h"
>
>  static __always_inline
>  bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long dst_=
end)
> @@ -1079,9 +1080,19 @@ static int move_swap_pte(struct mm_struct *mm,
>                          pmd_t *dst_pmd, pmd_t dst_pmdval,
>                          spinlock_t *dst_ptl, spinlock_t *src_ptl)
>  {
> +       struct folio *folio;
> +       swp_entry_t entry;
> +
>         if (!pte_swp_exclusive(orig_src_pte))
>                 return -EBUSY;
>
> +       entry =3D pte_to_swp_entry(orig_src_pte);
> +       folio =3D filemap_get_folio(swap_address_space(entry), swap_cache=
_index(entry));
> +       if (!IS_ERR(folio)) {
> +               folio_put(folio);
> +               return -EBUSY;
> +       }
> +
>         double_pt_lock(dst_ptl, src_ptl);
>
>         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src=
_pte,
> --
> 2.39.3 (Apple Git-146)
>

