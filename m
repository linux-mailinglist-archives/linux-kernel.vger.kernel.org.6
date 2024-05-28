Return-Path: <linux-kernel+bounces-191948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 454E28D167B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C700D2838AE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A161613C8F2;
	Tue, 28 May 2024 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTw5Q/P1"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09197D07D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885611; cv=none; b=JbvqP4KnQArH1gDW+2awkUcGlWDSreH9G9gqXY+tppSXB1AmCnoF8lPYrW066ziXnUSHZTBz0/UM92LQOFlzTzNwhMHXnHYRouPE+rJOeluapVeyBdUFsjuJjq3i4HeWfPfHfHkYn7IoHihYjSQrLa3JrCkeuLAVCg562O0TpmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885611; c=relaxed/simple;
	bh=YXHu/tYiP47/HnpENtBLi4VJJkOFZoX2HmzpUwK7qJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmNJ8Z4rS8c48BFHPMopg+NJUqqN/r2658bA2kNDDFjNODgYdzDizFF1ZJdU7Th6BFt9jpVK2ZrW8JlYttXNAfX1rQy76jPLJz+hjR/Ql3OUe+gfPbcd92Zytowzlx3FmjG0XXv38ATUSakGDNhoVNS22MLiEHzJbciY6UFTPcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTw5Q/P1; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-48a314805d9so177559137.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 01:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716885608; x=1717490408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWuC8xgrTpZG5Uvy93xdyyoFAubSFjnfdPMHtKysMIs=;
        b=lTw5Q/P13yhiZajSqEh6j3l0q/nl0XmRRYR93XDh6cRzGk//QnzZIDQME30akUouRM
         jGq14v7Rg6vtewj7SNckfBrxscj4q8F0kKMZMSp6sl7iCENJRjruDRjs/I4v5A4VwZMk
         sUAvLkGh7qhe/id52VHEjj0yoHUDFex1mSqI6+cz2bWVZ5yN4C2pknnHXGWPknxd9IrO
         svK1hXyi60l8Jw0DI+SSl9pTTLucFE+tzHCLtwOiXR2opwO3WVB5Aqg7SB6IwkfbNLp5
         38TOOFuBPBgpY9itW4n78A85P6o25uucnXsfM+2+91rA1OPaOIOSadeLwMzzL5M46gyh
         OrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716885608; x=1717490408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWuC8xgrTpZG5Uvy93xdyyoFAubSFjnfdPMHtKysMIs=;
        b=PIBYwf0L0n/rGbr/dlOzpisFvuNqANUwBvXnST2lUIxAnFp/3Gd6UgnoeiC4OA5NlA
         LewipQeU4AYB/mFnwLo9cvnVoVnouT9IsO9F4oA7l0VA7rTwm3wUXDyx9P+RhF9eKB/6
         aIEfR5O7kWC9NqNN0ITRpP+14pO9VE9h0u/kp0V0pLY+KlexchKD913GNA9zPMJKhuCz
         12oNCWscC+i0BVfq6hAKyaPdpLICbKXp16bA/n8VWyYL12z+x3QZbg/fEkIlLytEz3qz
         YY1It0rcR2yp8n1M+E8fminGK2BDY9njWltrKlzgpTTD1s15vkwnwJxHx8i4GA/olpvM
         P6LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa0ZuzzPqnm4jPPj7LW6y+2KpN/B1zGMX9TfQ+ZUdUgLd3Mg7TBjH8/V9ow32W532M75sy2iYiir5ldHDA9aJfQ6Qzr83dEh4LQuqz
X-Gm-Message-State: AOJu0YwuBAsUjdo7JbGUoBkcxgiHrGGZaNBstNDN6e5w5ej0Nvh7RXRX
	pr633dEgJEDcIHhG1QMBzuee/Af8x7XrYMekEDGRPwVCvFVVLciITnbibd8pJz5ug+3BQANSpQN
	akpmUsnMYIEgZPBxMUcsjTMPqVyQ=
X-Google-Smtp-Source: AGHT+IF13MovFPCZamxq7SoRZIg8j15/Ti552guT68JxrpbWpf9K2PO2JhDh2O1HCO44j9AT+vZ4cf686VUPP4sPj9A=
X-Received: by 2002:a67:ec50:0:b0:47c:11ba:fea9 with SMTP id
 ada2fe7eead31-48a3866f8famr10912129137.23.1716885607091; Tue, 28 May 2024
 01:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524005444.135417-1-21cnbao@gmail.com> <ZlWVHC0e2OadjwIa@J2N7QTR9R3>
In-Reply-To: <ZlWVHC0e2OadjwIa@J2N7QTR9R3>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 28 May 2024 20:39:55 +1200
Message-ID: <CAGsJ_4xMdyBxwwh1AQeFM5a_ZMV2=y68M9eEuJf-D6NtYP-8dA@mail.gmail.com>
Subject: Re: [PATCH] mm: arm64: Fix the out-of-bounds issue in contpte_clear_young_dirty_ptes
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Lance Yang <ioworker0@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, Jeff Xie <xiehuan09@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Michal Hocko <mhocko@suse.com>, 
	Minchan Kim <minchan@kernel.org>, Muchun Song <songmuchun@bytedance.com>, 
	Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, "Zach O'Keefe" <zokeefe@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 8:26=E2=80=AFPM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Fri, May 24, 2024 at 12:54:44PM +1200, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > We are passing a huge nr to __clear_young_dirty_ptes() right
> > now. While we should pass the number of pages, we are actually
> > passing CONT_PTE_SIZE. This is causing lots of crashes of
> > MADV_FREE, panic oops could vary everytime.
> >
> > Fixes: 89e86854fb0a ("mm/arm64: override clear_young_dirty_ptes() batch=
 helper")
>
> I was seeing ths same thing on v6.10-rc1 (syzkaller splat and reproducer
> included at the end of the mail). The patch makes sense to me, and fixed =
the
> splat in testing, so:
>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks!

>
> Since this only affects arm64 and is already in mainline, I assume the fi=
x
> should go via the arm64 tree even though the broken commit went via mm.


Either mm or arm64 is fine with me, but I noticed that Andrew has already
included it in mm-hotfixes-unstable. If it works, we may want to stick with
that. :-)


>
> Mark.
>
> > Cc: Lance Yang <ioworker0@gmail.com>
> > Cc: Barry Song <21cnbao@gmail.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Jeff Xie <xiehuan09@gmail.com>
> > Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Muchun Song <songmuchun@bytedance.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Yang Shi <shy828301@gmail.com>
> > Cc: Yin Fengwei <fengwei.yin@intel.com>
> > Cc: Zach O'Keefe <zokeefe@google.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  arch/arm64/mm/contpte.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> > index 9f9486de0004..a3edced29ac1 100644
> > --- a/arch/arm64/mm/contpte.c
> > +++ b/arch/arm64/mm/contpte.c
> > @@ -376,7 +376,7 @@ void contpte_clear_young_dirty_ptes(struct vm_area_=
struct *vma,
> >        * clearing access/dirty for the whole block.
> >        */
> >       unsigned long start =3D addr;
> > -     unsigned long end =3D start + nr;
> > +     unsigned long end =3D start + nr * PAGE_SIZE;
> >
> >       if (pte_cont(__ptep_get(ptep + nr - 1)))
> >               end =3D ALIGN(end, CONT_PTE_SIZE);
> > @@ -386,7 +386,7 @@ void contpte_clear_young_dirty_ptes(struct vm_area_=
struct *vma,
> >               ptep =3D contpte_align_down(ptep);
> >       }
> >
> > -     __clear_young_dirty_ptes(vma, start, ptep, end - start, flags);
> > +     __clear_young_dirty_ptes(vma, start, ptep, (end - start) / PAGE_S=
IZE, flags);
> >  }
> >  EXPORT_SYMBOL_GPL(contpte_clear_young_dirty_ptes);
> >
> > --
> > 2.34.1
>
> ---->8----
> Syzkaller hit 'KASAN: use-after-free Read in contpte_clear_young_dirty_pt=
es' bug.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: use-after-free in __ptep_get arch/arm64/include/asm/pgtable.h=
:315 [inline]
> BUG: KASAN: use-after-free in __clear_young_dirty_ptes arch/arm64/include=
/asm/pgtable.h:1309 [inline]
> BUG: KASAN: use-after-free in contpte_clear_young_dirty_ptes+0x264/0x288 =
arch/arm64/mm/contpte.c:389
> Read of size 8 at addr ffff000018c0d000 by task syz-executor392/193
>
> CPU: 0 PID: 193 Comm: syz-executor392 Not tainted 6.10.0-rc1-00001-g30b7f=
99b25b6 #1
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace+0x12c/0x1f8 arch/arm64/kernel/stacktrace.c:317
>  show_stack+0x34/0x50 arch/arm64/kernel/stacktrace.c:324
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x184/0x360 lib/dump_stack.c:114
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0xf4/0x5b0 mm/kasan/report.c:488
>  kasan_report+0xc0/0x100 mm/kasan/report.c:601
>  __asan_report_load8_noabort+0x20/0x30 mm/kasan/report_generic.c:381
>  __ptep_get arch/arm64/include/asm/pgtable.h:315 [inline]
>  __clear_young_dirty_ptes arch/arm64/include/asm/pgtable.h:1309 [inline]
>  contpte_clear_young_dirty_ptes+0x264/0x288 arch/arm64/mm/contpte.c:389
>  clear_young_dirty_ptes arch/arm64/include/asm/pgtable.h:1715 [inline]
>  madvise_free_pte_range+0xa5c/0x16d8 mm/madvise.c:767
>  walk_pmd_range mm/pagewalk.c:143 [inline]
>  walk_pud_range mm/pagewalk.c:221 [inline]
>  walk_p4d_range mm/pagewalk.c:256 [inline]
>  walk_pgd_range+0xca4/0x1900 mm/pagewalk.c:293
>  __walk_page_range+0x4bc/0x5b8 mm/pagewalk.c:395
>  walk_page_range+0x4a4/0x840 mm/pagewalk.c:521
>  madvise_free_single_vma+0x3a0/0x798 mm/madvise.c:815
>  madvise_dontneed_free mm/madvise.c:929 [inline]
>  madvise_vma_behavior mm/madvise.c:1046 [inline]
>  madvise_walk_vmas mm/madvise.c:1268 [inline]
>  do_madvise+0x54c/0x2990 mm/madvise.c:1464
>  __do_sys_madvise mm/madvise.c:1481 [inline]
>  __se_sys_madvise mm/madvise.c:1479 [inline]
>  __arm64_sys_madvise+0x94/0xf8 mm/madvise.c:1479
>  __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
>  invoke_syscall+0x8c/0x2e0 arch/arm64/kernel/syscall.c:48
>  el0_svc_common.constprop.0+0xec/0x2a8 arch/arm64/kernel/syscall.c:133
>  do_el0_svc+0x4c/0x70 arch/arm64/kernel/syscall.c:152
>  el0_svc+0x54/0x160 arch/arm64/kernel/entry-common.c:712
>  el0t_64_sync_handler+0x120/0x130 arch/arm64/kernel/entry-common.c:730
>  el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:598
>
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x58c0=
d
> flags: 0x3fffe0000000000(node=3D0|zone=3D0|lastcpupid=3D0x1ffff)
> raw: 03fffe0000000000 fffffdffc0630388 fffffdffc071cc48 0000000000000000
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff000018c0cf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff000018c0cf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff000018c0d000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                    ^
>  ffff000018c0d080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff000018c0d100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> Syzkaller reproducer:
> # {Threaded:false Repeat:false RepeatTimes:0 Procs:1 Slowdown:1 Sandbox: =
SandboxArg:0 Leak:false NetInjection:false NetDevices:false NetReset:false =
Cgroups:false BinfmtMisc:false CloseFDs:false KCSAN:false DevlinkPCI:false =
NicVF:false USB:false VhciInjection:false Wifi:false IEEE802154:false Sysct=
l:false Swap:false UseTmpDir:false HandleSegv:false Trace:false LegacyOptio=
ns:{Collide:false Fault:false FaultCall:0 FaultNth:0}}
> madvise(&(0x7f0000ffd000/0x3000)=3Dnil, 0x3000, 0x17)
> mprotect(&(0x7f0000ffc000/0x4000)=3Dnil, 0x4000, 0x0)
> mprotect(&(0x7f0000800000/0x800000)=3Dnil, 0x800000, 0x1)
> madvise(&(0x7f0000400000/0xc00000)=3Dnil, 0xc00000, 0x8)
>
>
> C reproducer:
> // autogenerated by syzkaller (https://github.com/google/syzkaller)
>
> #define _GNU_SOURCE
>
> #include <endian.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <unistd.h>
>
> #ifndef __NR_madvise
> #define __NR_madvise 233
> #endif
> #ifndef __NR_mmap
> #define __NR_mmap 222
> #endif
> #ifndef __NR_mprotect
> #define __NR_mprotect 226
> #endif
>
> int main(void)
> {
>                 syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1=
000ul, /*prot=3D*/0ul, /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32u=
l, /*fd=3D*/-1, /*offset=3D*/0ul);
>         syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul=
, /*prot=3DPROT_WRITE|PROT_READ|PROT_EXEC*/7ul, /*flags=3DMAP_FIXED|MAP_ANO=
NYMOUS|MAP_PRIVATE*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
>         syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /=
*prot=3D*/0ul, /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=
=3D*/-1, /*offset=3D*/0ul);
>                                 if (write(1, "executing program\n", sizeo=
f("executing program\n") - 1)) {}
>         syscall(__NR_madvise, /*addr=3D*/0x20ffd000ul, /*len=3D*/0x3000ul=
, /*advice=3DMADV_POPULATE_WRITE*/0x17ul);
>         syscall(__NR_mprotect, /*addr=3D*/0x20ffc000ul, /*len=3D*/0x4000u=
l, /*prot=3D*/0ul);
>         syscall(__NR_mprotect, /*addr=3D*/0x20800000ul, /*len=3D*/0x80000=
0ul, /*prot=3DPROT_READ*/1ul);
>         syscall(__NR_madvise, /*addr=3D*/0x20400000ul, /*len=3D*/0xc00000=
ul, /*advice=3D*/8ul);
>         return 0;
> }
>
>

Thanks
Barry

