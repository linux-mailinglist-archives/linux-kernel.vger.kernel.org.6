Return-Path: <linux-kernel+bounces-522447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2335CA3CA82
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC8B3B9588
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C2A24FBE3;
	Wed, 19 Feb 2025 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W0Uz79Yz"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B56B24F5A0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998445; cv=none; b=W/vv1Q0jqrvmEGUuKKEQhEisshbZ5pa4/aR/3CODibxSUOwJZNoubg7eWI1ii5qRd6eQDJWYtY8SZc4HbhpjdXjn6jHMaHnxOJfQOpwwLfqV35ykVQJkh6uljw/tYOUCeAozHhsj4APpr42w/0P7WWLDMWmo8ySnAEA4zz3ii2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998445; c=relaxed/simple;
	bh=cE73rMAHLqy4FXyVVwLzKF328bj489xPrM0w6BFpg8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFo8XKToqNdgQJMqRBIvkIKi2B+ixscWoiijXYwhLqKbZxQHaun9QIkydUtqrsSo+M72O3HR4Dwx+cvu4IlefaOPTizg3mG8tiieUh2P8dD1NYtd1hZgHRpSemspReBoVHsm7h4CC0lD18zGyPXwbpdebB7L2ZeG/BmeUMRXv0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W0Uz79Yz; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-471fbfe8b89so93341cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739998442; x=1740603242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzt5Hpi/AT1VAdu23Qr3srzk1MhpCPooOQAWD7Sz/dw=;
        b=W0Uz79YzTEyw/t5QTpFS1jh0DfNmOH8MzZkfnC7/uxEHEIcpqsu2Q7LE0f8zE6rMcK
         SEog3O2YUHcXd2XvDIbWwH6uemsx9nNFnmHiz2Llu3j65noSKP9uXSI3GcL2kaZCJONG
         l2h0jePjiH3rMXjf1Hxn6SxOmrKpgE/Eec39+XWk2ArhmtA+juLFKDZ8eKE3h3iTwCST
         6mHtq4tzMyWi7+YwC+6nRwu86cU7YHTbFb6x05NS+pG8BF4nALtW2Ypvz9LPiaLguebY
         Gmm5dhNYc4FOSMj4791QKQCYHyJ3LKmQJIHnO2F7Qla3FtEjIcCVroKmeeNn7s+ccf5U
         EmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739998442; x=1740603242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzt5Hpi/AT1VAdu23Qr3srzk1MhpCPooOQAWD7Sz/dw=;
        b=FkgKmeNu+uR/aWY7SewZQWKz6Z830aRRRITCPY5+d6qX01LOIZ1sOzloLsGgP51Lb5
         g3XdXei8nrp60lcSSHtaj/Ee1m6mdNIZlnFaAv40Bl9WhAdcvnHSYbUj3PAChLuPEd24
         dRWVo3H1ozyAi8VELPk93DM8sCTjerH5nr0aEHBMIFgATZ/uC/pVApTVmCcFz7jWOsQt
         8iLn7yqOWE1BHaMBoLkTtcQ5m0QNC5gT/QU+QUNOcrVV4Y8XL9iSREWDnsyh/5NBiiw5
         p3q/jWIoyG+oc9HOTMBHLKHhs83LhGMKW76o6YvHzhH1L0v3MsFG3hs7bvithI8GZLgm
         ZMUA==
X-Forwarded-Encrypted: i=1; AJvYcCWJIPg23ldSsmj7N7xOwrTvt66/JQBXIVKo38fGjJkjhJoa2UQGlPFLoZzQ0zHcO32op38wnll2hZiwSbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbnRip9UZ++hTrszbsSrJPM/uvWmxY1EVSWuhYcGG7NNabWkl6
	JtyN2tflKbro6Ar0K2lGxAeWJwkx63nG9MhettT/3/cGPr4lRY7I2qfPpoh25d3gEmxSrFWNdJF
	oq4gaMCRX4o7T1Ka4wLpArzp5fjmed6NG/7Qd
X-Gm-Gg: ASbGncuy6yCAryedrsm8Ojp06siMerv8NSyCN80Dc7qW3s42csKCr+NHTDBw2b2GKgi
	DQmgLQ0MbLX9WxKu3W5qzUg69j6k5S+c3798aa0HZcj3wL1DXdIyxrdLe7B+ZLMOzA9rmm1QrPF
	MOQCo3CwCgNQhWK4EhHrL7dYqaKw8=
X-Google-Smtp-Source: AGHT+IGRdTtiTX573YtsaHnAk4Ui60BKILvwme4d/npspdhjOQ9dpR5wT3dDOhBXNH68P21Ult9iiIusH7Unzib0kW4=
X-Received: by 2002:a05:622a:5cc:b0:466:a11c:cad2 with SMTP id
 d75a77b69052e-47215df7cd2mr622451cf.7.1739998441959; Wed, 19 Feb 2025
 12:54:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219112519.92853-1-21cnbao@gmail.com> <CA+EESO5ZVODEwv7X6HET8pstzs5kB1yCaxK80nOKzQKJPMLwuQ@mail.gmail.com>
 <CAGsJ_4y_8EVTM7NfhhwKHKYPeVU6TwFAmLARxKnK6fA0LQo1dw@mail.gmail.com>
In-Reply-To: <CAGsJ_4y_8EVTM7NfhhwKHKYPeVU6TwFAmLARxKnK6fA0LQo1dw@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Wed, 19 Feb 2025 12:53:50 -0800
X-Gm-Features: AWEUYZmVfXW8ncrvvsoJTz9S1RYAbffZUNrLLxR_kGimZu4DtDFyMcCgGExpsq4
Message-ID: <CA+EESO6VbbmXq=RkBrJtee6KuYv-Dq+4ckoWzoTSzvptUMPEZg@mail.gmail.com>
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

On Wed, Feb 19, 2025 at 12:45=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Thu, Feb 20, 2025 at 7:40=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.=
com> wrote:
> >
> > On Wed, Feb 19, 2025 at 3:25=E2=80=AFAM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > userfaultfd_move() checks whether the PTE entry is present or a
> > > swap entry.
> > >
> > > - If the PTE entry is present, move_present_pte() handles folio
> > >   migration by setting:
> > >
> > >   src_folio->index =3D linear_page_index(dst_vma, dst_addr);
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
> > >  page_pgoff(folio, page) !=3D linear_page_index(vma, address)
> > >
> > > $./a.out > /dev/null
> > > [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c i=
ndex:0xffffaf150 pfn:0x4667c
> > > [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_ma=
pped:1 pincount:0
> > > [   13.337716] memcg:ffff00000405f000
> > > [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|ow=
ner_priv_1|head|swapbacked|node=3D0|zone=3D0|lastcpupid=3D0xffff)
> > > [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b53=
8 ffff000006260361
> > > [   13.338831] raw: 0000000ffffaf150 0000000000004000 000000060000000=
0 ffff00000405f000
> > > [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b5=
38 ffff000006260361
> > > [   13.339204] head: 0000000ffffaf150 0000000000004000 00000006000000=
00 ffff00000405f000
> > > [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff000000=
00 0000000000000001
> > > [   13.339546] head: 0000000000000004 0000000000000000 00000000ffffff=
ff 0000000000000000
> > > [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, =
page) !=3D linear_page_index(vma, address))
> > > [   13.340190] ------------[ cut here ]------------
> > > [   13.340316] kernel BUG at mm/rmap.c:1380!
> > > [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREE=
MPT SMP
> > > [   13.340969] Modules linked in:
> > > [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-=
rc3-gcf42737e247a-dirty #299
> > > [   13.341470] Hardware name: linux,dummy-virt (DT)
> > > [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS =
BTYPE=3D--)
> > > [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> > > [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> > > [   13.342018] sp : ffff80008752bb20
> > > [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 00000=
00000000001
> > > [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 00000=
00000000001
> > > [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffff=
dffc0199f00
> > > [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 00000=
000ffffffff
> > > [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 66286=
6666f67705f
> > > [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff8=
00083728ab0
> > > [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff8=
0008011bc40
> > > [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff8=
000829eebf8
> > > [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 00000=
00000000000
> > > [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 00000=
0000000005f
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
> > > of folios as done in move_present_pte. For now, a quick solution
> > > is to return -EBUSY.
> > > I'd like to see others' opinions on whether a full fix is worth
> > > pursuing.
> > >
> >
> > Thanks a lot for finding this.
> >
> > As a user of MOVE ioctl (in Android GC) I strongly urge you to fix
> > this properly. Because this is not going to be a rare occurrence in
> > the case of Android. And when -EBUSY is returned, all that userspace
> > can do is touch the page, which also does not guarantee that a
> > subsequent retry of the ioctl will succeed.
>
> Not trying to push this idea, but I=E2=80=99m curious if it's feasible:
>
> If UFFDIO_MOVE fails, could userspace fall back to UFFDIO_COPY?

It's possible! But it wouldn't be rare to find such pages and falling
back to COPY so many times would mellow down the benefits of using
MOVE quite a bit.
>
> I=E2=80=99m still trying to wrap my head around a few things, particularl=
y
> what exactly UFFDIO_MOVE is doing with mTHP, as I mentioned in my
> reply to Suren and you in another email:
>
> https://lore.kernel.org/linux-mm/CAGsJ_4yx1=3DjaQmDG_9rMqHFFkoXqMJw941eYv=
tby28OqDq+S7g@mail.gmail.com/
>
>
> >
> > > For anyone interested in reproducing it, the a.out test program is
> > > as below,
> > >
> > >  #define _GNU_SOURCE
> > >  #include <stdio.h>
> > >  #include <stdlib.h>
> > >  #include <string.h>
> > >  #include <sys/mman.h>
> > >  #include <sys/ioctl.h>
> > >  #include <sys/syscall.h>
> > >  #include <linux/userfaultfd.h>
> > >  #include <fcntl.h>
> > >  #include <pthread.h>
> > >  #include <unistd.h>
> > >  #include <poll.h>
> > >  #include <errno.h>
> > >
> > >  #define PAGE_SIZE 4096
> > >  #define REGION_SIZE (512 * 1024)
> > >
> > >  #ifndef UFFDIO_MOVE
> > >  struct uffdio_move {
> > >      __u64 dst;
> > >      __u64 src;
> > >      __u64 len;
> > >      #define UFFDIO_MOVE_MODE_DONTWAKE        ((__u64)1<<0)
> > >      #define UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES ((__u64)1<<1)
> > >      __u64 mode;
> > >      __s64 move;
> > >  };
> > >  #define _UFFDIO_MOVE  (0x05)
> > >  #define UFFDIO_MOVE   _IOWR(UFFDIO, _UFFDIO_MOVE, struct uffdio_move=
)
> > >  #endif
> > >
> > >  void *src, *dst;
> > >  int uffd;
> > >
> > >  void *madvise_thread(void *arg) {
> > >      if (madvise(src, REGION_SIZE, MADV_PAGEOUT) =3D=3D -1) {
> > >          perror("madvise MADV_PAGEOUT");
> > >      }
> > >      return NULL;
> > >  }
> > >
> > >  void *fault_handler_thread(void *arg) {
> > >      struct uffd_msg msg;
> > >      struct uffdio_move move;
> > >      struct pollfd pollfd =3D { .fd =3D uffd, .events =3D POLLIN };
> > >
> > >      pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> > >      pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);
> > >
> > >      while (1) {
> > >          if (poll(&pollfd, 1, -1) =3D=3D -1) {
> > >              perror("poll");
> > >              exit(EXIT_FAILURE);
> > >          }
> > >
> > >          if (read(uffd, &msg, sizeof(msg)) <=3D 0) {
> > >              perror("read");
> > >              exit(EXIT_FAILURE);
> > >          }
> > >
> > >          if (msg.event !=3D UFFD_EVENT_PAGEFAULT) {
> > >              fprintf(stderr, "Unexpected event\n");
> > >              exit(EXIT_FAILURE);
> > >          }
> > >
> > >          move.src =3D (unsigned long)src + (msg.arg.pagefault.address=
 - (unsigned long)dst);
> > >          move.dst =3D msg.arg.pagefault.address & ~(PAGE_SIZE - 1);
> > >          move.len =3D PAGE_SIZE;
> > >          move.mode =3D 0;
> > >
> > >          if (ioctl(uffd, UFFDIO_MOVE, &move) =3D=3D -1) {
> > >              perror("UFFDIO_MOVE");
> > >              exit(EXIT_FAILURE);
> > >          }
> > >      }
> > >      return NULL;
> > >  }
> > >
> > >  int main() {
> > >  again:
> > >      pthread_t thr, madv_thr;
> > >      struct uffdio_api uffdio_api =3D { .api =3D UFFD_API, .features =
=3D 0 };
> > >      struct uffdio_register uffdio_register;
> > >
> > >      src =3D mmap(NULL, REGION_SIZE, PROT_READ | PROT_WRITE, MAP_PRIV=
ATE | MAP_ANONYMOUS, -1, 0);
> > >      if (src =3D=3D MAP_FAILED) {
> > >          perror("mmap src");
> > >          exit(EXIT_FAILURE);
> > >      }
> > >      memset(src, 1, REGION_SIZE);
> > >
> > >      dst =3D mmap(NULL, REGION_SIZE, PROT_READ | PROT_WRITE, MAP_PRIV=
ATE | MAP_ANONYMOUS, -1, 0);
> > >      if (dst =3D=3D MAP_FAILED) {
> > >          perror("mmap dst");
> > >          exit(EXIT_FAILURE);
> > >      }
> > >
> > >      uffd =3D syscall(SYS_userfaultfd, O_CLOEXEC | O_NONBLOCK);
> > >      if (uffd =3D=3D -1) {
> > >          perror("userfaultfd");
> > >          exit(EXIT_FAILURE);
> > >      }
> > >
> > >      if (ioctl(uffd, UFFDIO_API, &uffdio_api) =3D=3D -1) {
> > >          perror("UFFDIO_API");
> > >          exit(EXIT_FAILURE);
> > >      }
> > >
> > >      uffdio_register.range.start =3D (unsigned long)dst;
> > >      uffdio_register.range.len =3D REGION_SIZE;
> > >      uffdio_register.mode =3D UFFDIO_REGISTER_MODE_MISSING;
> > >
> > >      if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) =3D=3D -1) {
> > >          perror("UFFDIO_REGISTER");
> > >          exit(EXIT_FAILURE);
> > >      }
> > >
> > >      if (pthread_create(&madv_thr, NULL, madvise_thread, NULL) !=3D 0=
) {
> > >          perror("pthread_create madvise_thread");
> > >          exit(EXIT_FAILURE);
> > >      }
> > >
> > >      if (pthread_create(&thr, NULL, fault_handler_thread, NULL) !=3D =
0) {
> > >          perror("pthread_create fault_handler_thread");
> > >          exit(EXIT_FAILURE);
> > >      }
> > >
> > >      for (size_t i =3D 0; i < REGION_SIZE; i +=3D PAGE_SIZE) {
> > >          char val =3D ((char *)dst)[i];
> > >          printf("Accessing dst at offset %zu, value: %d\n", i, val);
> > >      }
> > >
> > >      pthread_join(madv_thr, NULL);
> > >      pthread_cancel(thr);
> > >      pthread_join(thr, NULL);
> > >
> > >      munmap(src, REGION_SIZE);
> > >      munmap(dst, REGION_SIZE);
> > >      close(uffd);
> > >      goto again;
> > >      return 0;
> > >  }
> > >
> > > As long as you enable mTHP (which likely increases the residency
> > > time of swapcache), you can reproduce the issue within a few
> > > seconds. But I guess the same race condition also exists with
> > > small folios.
> > >
> > > Fixes: adef440691bab ("userfaultfd: UFFDIO_MOVE uABI")
> > > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Axel Rasmussen <axelrasmussen@google.com>
> > > Cc: Brian Geffon <bgeffon@google.com>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: Hugh Dickins <hughd@google.com>
> > > Cc: Jann Horn <jannh@google.com>
> > > Cc: Kalesh Singh <kaleshsingh@google.com>
> > > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > Cc: Lokesh Gidra <lokeshgidra@google.com>
> > > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> > > Cc: Nicolas Geoffray <ngeoffray@google.com>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > > Cc: Shuah Khan <shuah@kernel.org>
> > > Cc: ZhangPeng <zhangpeng362@huawei.com>
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > ---
> > >  mm/userfaultfd.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index 867898c4e30b..34cf1c8c725d 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -18,6 +18,7 @@
> > >  #include <asm/tlbflush.h>
> > >  #include <asm/tlb.h>
> > >  #include "internal.h"
> > > +#include "swap.h"
> > >
> > >  static __always_inline
> > >  bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long =
dst_end)
> > > @@ -1079,9 +1080,19 @@ static int move_swap_pte(struct mm_struct *mm,
> > >                          pmd_t *dst_pmd, pmd_t dst_pmdval,
> > >                          spinlock_t *dst_ptl, spinlock_t *src_ptl)
> > >  {
> > > +       struct folio *folio;
> > > +       swp_entry_t entry;
> > > +
> > >         if (!pte_swp_exclusive(orig_src_pte))
> > >                 return -EBUSY;
> > >
> > > +       entry =3D pte_to_swp_entry(orig_src_pte);
> > > +       folio =3D filemap_get_folio(swap_address_space(entry), swap_c=
ache_index(entry));
> > > +       if (!IS_ERR(folio)) {
> > > +               folio_put(folio);
> > > +               return -EBUSY;
> > > +       }
> > > +
> > >         double_pt_lock(dst_ptl, src_ptl);
> > >
> > >         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig=
_src_pte,
> > > --
> > > 2.39.3 (Apple Git-146)
> > >
> >
>
> Thanks
> Barry

