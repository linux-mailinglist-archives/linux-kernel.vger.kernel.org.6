Return-Path: <linux-kernel+bounces-188237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A9A8CDF8E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE281C20F17
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 02:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09DE28DC1;
	Fri, 24 May 2024 02:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTnx1dpT"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFCB374FE
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 02:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716518516; cv=none; b=P3O7l2aClsEHddaH5At63YgafR1XcFXV86gaDA4swHw9NcL0Az0O8w3tOztfcCe649tvjKjLi+G8LjT+5NjYUnYpVpbIRe6zM+aAHqM4WjiNvGFmM8kiH0K6NKz2LgIOj4Ts1OxgNG6Z873olTUS7TxjTkYf4ZfjLs2wDLSG65I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716518516; c=relaxed/simple;
	bh=Muh0sPUC/Lk4gJvxjKCTctk1m1G8krloPm0JSKYOW88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NF9FrfFel0raXOw0OB88UOWz+x+XpJuhiZqTjeRGQxupiujZBa66XTFlVrgNlKTa7fj6cQvKiaRnxwDSfBafpcbDu/vAdOhpwg0iDKWo9mNfOl4Afp90KeMbqDpGaETZS+JyRCj93Cwsm1IYzpYzWhV5BzctnCFZucOsd6kPg6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTnx1dpT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57824fa0a8fso4288453a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 19:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716518513; x=1717123313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWYitP/mKok0KulkRpR08gHkHosJXhe6t/yNEPgAOq4=;
        b=lTnx1dpT/QaitVdr20gdBT+6oZgYp2EQEQJcywlMz1jk02wBvu8udHIQ+USzuYV+EI
         yb4nwaQUxMi3xhfnY4O9EKwEgdcF/ny4YjyBjfPOs9lKuvkjsB3Q3g+HkhJsS0wCbwrd
         o7BQApt/7Ck4B1mZWt1MW0pnOtQlYoCO4gs8NGKfv3YwcG3BFjKVskZ+mTsFqqLWzw3k
         Cm8VIaeOq4mkGw2YEhdt0dyvOu+/YtrsMCCxhLmG73x17SuxjnI30K+P9Lvc9LGubkPP
         jIAdAqXMMQzILztxTKV4DbWmZEST03XX9BJoi3L/7fos8M95bqyy+T2/I0FyiS3w/qQk
         LLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716518513; x=1717123313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWYitP/mKok0KulkRpR08gHkHosJXhe6t/yNEPgAOq4=;
        b=I1eAW5PkooIp0lzd83QdLkDFBSDx2JHDHiMO54Pn4K+uCvXiadGInGHTBJ0qKXK3rp
         /sKNBCmZMMEYdwwKcIZxu+uVvjKxf8eUxxfs5Dp4xIxaqR9wYAZPc/6f2JxC2Q9lqXU9
         Lk1xJzXUwn4gNO0kSDYdBJZmymCNlu1/SB0B61RuHmilahz32NSfgvPa+34d0BS6dNMz
         BAJ1EIfvXCYTWNo3SsNfgacgzcqE/bbtKeSIKXXGYTtN3P14soyzeInkyTS1ZkYw61Ln
         rcRIJvfJ4d4U03E30LpBK5z9rWNXYvb0yOuo59OWUyamQhQ37baX5D+/iOqKbEDMsfIL
         6XkA==
X-Forwarded-Encrypted: i=1; AJvYcCX0NOAyWQAwXexYDYxLOjstEiCosCFAPZ23S9+m+XRaICndLmrdyZiNDr/sY+FWmj1zGinP0Jql6MhgTjK3AAQbNEWxgQ1kbxR2kSOv
X-Gm-Message-State: AOJu0Yw1zBXxQAimh5rhO/8lNBEuA1NKYRIxidXUHdDQsH7D4ZnYkQia
	+9BCcswjB04y7+aNKYs9llBx8ZJiZVohW7N3k0pb0A3Ozi6Kz9LR/75fv5Rdlcos+lZ+DWJOIBE
	vOhrzyGD7gHkEd/E2krDFxIX06IE=
X-Google-Smtp-Source: AGHT+IGxhUTktEkdPHHzD30YF7TkOm9Uh9zE6iPqyXCGxtrc7t2gCZb9swNURxyMBZ9Q9BZEbJhiJn7ShMYmSwlo4Rk=
X-Received: by 2002:a50:8e17:0:b0:572:7b08:d497 with SMTP id
 4fb4d7f45d1cf-5785199cf06mr564442a12.17.1716518512599; Thu, 23 May 2024
 19:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418134435.6092-1-ioworker0@gmail.com> <20240418134435.6092-5-ioworker0@gmail.com>
 <CAGsJ_4zjV31JvUyzoiKibYDjg+gQMvuBA3bDE1a1K_APcHozkg@mail.gmail.com>
In-Reply-To: <CAGsJ_4zjV31JvUyzoiKibYDjg+gQMvuBA3bDE1a1K_APcHozkg@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 24 May 2024 10:41:41 +0800
Message-ID: <CAK1f24kX551pfJvbfkxOrraiNp1OqzTpOjCfhTAap+mgiPfgOg@mail.gmail.com>
Subject: Re: [PATCH v10 4/4] mm/madvise: optimize lazyfreeing with mTHP in madvise_free
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Barry,

Thanks a lot for reporting!

On Fri, May 24, 2024 at 6:20=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Fri, Apr 19, 2024 at 1:44=E2=80=AFAM Lance Yang <ioworker0@gmail.com> =
wrote:
> >
> > This patch optimizes lazyfreeing with PTE-mapped mTHP[1]
> > (Inspired by David Hildenbrand[2]). We aim to avoid unnecessary folio
> > splitting if the large folio is fully mapped within the target range.
> >
> > If a large folio is locked or shared, or if we fail to split it, we jus=
t
> > leave it in place and advance to the next PTE in the range. But note th=
at
> > the behavior is changed; previously, any failure of this sort would cau=
se
> > the entire operation to give up. As large folios become more common,
> > sticking to the old way could result in wasted opportunities.
> >
> > On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by PTE-mapped folios =
of
> > the same size results in the following runtimes for madvise(MADV_FREE) =
in
> > seconds (shorter is better):
> >
> > Folio Size |   Old    |   New    | Change
> > ------------------------------------------
> >       4KiB | 0.590251 | 0.590259 |    0%
> >      16KiB | 2.990447 | 0.185655 |  -94%
> >      32KiB | 2.547831 | 0.104870 |  -95%
> >      64KiB | 2.457796 | 0.052812 |  -97%
> >     128KiB | 2.281034 | 0.032777 |  -99%
> >     256KiB | 2.230387 | 0.017496 |  -99%
> >     512KiB | 2.189106 | 0.010781 |  -99%
> >    1024KiB | 2.183949 | 0.007753 |  -99%
> >    2048KiB | 0.002799 | 0.002804 |    0%
> >
> > [1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@arm=
com
> > [2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redh=
at.com
> >
> > Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
>
> Hi Lance,
> I am getting kernel panic with this patch,

Good spot!

I just noticed that you posted a patch[1] to fix the bug introduced by the
commit 89e86854fb0a (mm/arm64: override clear_young_dirty_ptes() batch help=
er).

Could you please try your patch and see if the kernel panic issue still occ=
urs?

[1] https://lore.kernel.org/all/20240524005444.135417-1-21cnbao@gmail.com/

>
> / # /home/barry/develop/linux/madvfree
> [   78.345305] watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [madvfre=
e:101]
> [   78.345992] Modules linked in:
> [   78.346942] irq event stamp: 0
> [   78.347311] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [   78.348407] hardirqs last disabled at (0): [<ffff8000800add04>]
> copy_process+0x654/0x19a8
> [   78.349291] softirqs last  enabled at (0): [<ffff8000800add04>]
> copy_process+0x654/0x19a8
> [   78.349851] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [   78.350544] CPU: 3 PID: 101 Comm: madvfree Not tainted
> 6.9.0-ge51ae633c861 #253
> [   78.351200] Hardware name: linux,dummy-virt (DT)
> [   78.351747] pstate: 01400005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D--)
> [   78.352314] pc : queued_spin_lock_slowpath+0x5c/0x528
> [   78.352772] lr : do_raw_spin_lock+0xc8/0x120
> [   78.353245] sp : ffff8000863d3720
> [   78.353657] x29: ffff8000863d3720 x28: ffff0000c45a8ff8 x27: 080000010=
3b24003
> [   78.354632] x26: ffff0000c3b26080 x25: fffffdffc0000000 x24: ffff80008=
22c2d10
> [   78.355446] x23: ffff80008403018f x22: ffff8000863d38e0 x21: 0000ffff7=
f000000
> [   78.356259] x20: ffff800082fbe008 x19: ffff0000c3b26080 x18: 000000000=
0000000
> [   78.357120] x17: 0000000000000000 x16: 0000000000000000 x15: 000000000=
0000000
> [   78.357967] x14: 0000000000000000 x13: 0000000000000000 x12: 000000000=
0000000
> [   78.358878] x11: ff7ffffffffffbff x10: 0040000000000041 x9 : ffff80008=
0143750
> [   78.359818] x8 : ffff8000863d3708 x7 : 0000000000000000 x6 : ffff80008=
03b34e8
> [   78.360688] x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008=
2fbe008
> [   78.361602] x2 : ffff80012ac1f000 x1 : 0000000000000000 x0 : 000000000=
0000080
> [   78.362755] Call trace:
> [   78.363132]  queued_spin_lock_slowpath+0x5c/0x528
> [   78.363614]  do_raw_spin_lock+0xc8/0x120
> [   78.364041]  _raw_spin_lock+0x58/0x70
> [   78.364455]  __pte_offset_map_lock+0x98/0x210
> [   78.364891]  madvise_free_pte_range+0x88/0xa58
> [   78.365406]  walk_pgd_range+0x390/0x808
> [   78.365829]  __walk_page_range+0x1e0/0x1f0
> [   78.366256]  walk_page_range+0x1f0/0x2c8
> [   78.366676]  madvise_free_single_vma+0x16c/0x308
> [   78.367115]  madvise_vma_behavior+0x504/0xa20
> [   78.367549]  madvise_walk_vmas+0xc0/0x128
> [   78.367972]  do_madvise.part.0+0x110/0x558
> [   78.368398]  __arm64_sys_madvise+0x68/0x88
> [   78.368826]  invoke_syscall+0x50/0x128
> [   78.369332]  el0_svc_common.constprop.0+0x48/0xf8
> [   78.369778]  do_el0_svc+0x28/0x40
> [   78.370184]  el0_svc+0x50/0x150
> [   78.370583]  el0t_64_sync_handler+0x13c/0x158
> [   78.371017]  el0t_64_sync+0x1a4/0x1a8
> [  102.345217] watchdog: BUG: soft lockup - CPU#3 stuck for 45s! [madvfre=
e:101]
> [  102.345835] Modules linked in:
> [  102.346290] irq event stamp: 0
> [  102.346715] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [  102.347252] hardirqs last disabled at (0): [<ffff8000800add04>]
> copy_process+0x654/0x19a8
> [  102.347796] softirqs last  enabled at (0): [<ffff8000800add04>]
> copy_process+0x654/0x19a8
> [  102.348333] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [  102.348925] CPU: 3 PID: 101 Comm: madvfree Tainted: G             L
>     6.9.0-ge51ae633c861 #253
> [  102.349549] Hardware name: linux,dummy-virt (DT)
> [  102.349988] pstate: 01400005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D--)
> [  102.350535] pc : queued_spin_lock_slowpath+0x5c/0x528
> [  102.351010] lr : do_raw_spin_lock+0xc8/0x120
> [  102.351508] sp : ffff8000863d3720
> [  102.351939] x29: ffff8000863d3720 x28: ffff0000c45a8ff8 x27: 080000010=
3b24003
> [  102.352811] x26: ffff0000c3b26080 x25: fffffdffc0000000 x24: ffff80008=
22c2d10
> [  102.353772] x23: ffff80008403018f x22: ffff8000863d38e0 x21: 0000ffff7=
f000000
> [  102.354625] x20: ffff800082fbe008 x19: ffff0000c3b26080 x18: 000000000=
0000000
> [  102.355495] x17: 0000000000000000 x16: 0000000000000000 x15: 000000000=
0000000
> [  102.356370] x14: 0000000000000000 x13: 0000000000000000 x12: 000000000=
0000000
> [  102.357333] x11: ff7ffffffffffbff x10: 0040000000000041 x9 : ffff80008=
0143750
> [  102.358273] x8 : ffff8000863d3708 x7 : 0000000000000000 x6 : ffff80008=
03b34e8
> [  102.359112] x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008=
2fbe008
> [  102.360001] x2 : ffff80012ac1f000 x1 : 0000000000000000 x0 : 000000000=
0000080
> [  102.360887] Call trace:
> [  102.361289]  queued_spin_lock_slowpath+0x5c/0x528
> [  102.361768]  do_raw_spin_lock+0xc8/0x120
> [  102.362294]  _raw_spin_lock+0x58/0x70
> [  102.362825]  __pte_offset_map_lock+0x98/0x210
> [  102.363299]  madvise_free_pte_range+0x88/0xa58
> [  102.363771]  walk_pgd_range+0x390/0x808
> [  102.364268]  __walk_page_range+0x1e0/0x1f0
> [  102.364729]  walk_page_range+0x1f0/0x2c8
> [  102.365263]  madvise_free_single_vma+0x16c/0x308
> [  102.365786]  madvise_vma_behavior+0x504/0xa20
> [  102.366315]  madvise_walk_vmas+0xc0/0x128
> [  102.366779]  do_madvise.part.0+0x110/0x558
> [  102.367269]  __arm64_sys_madvise+0x68/0x88
> [  102.367714]  invoke_syscall+0x50/0x128
> [  102.368110]  el0_svc_common.constprop.0+0x48/0xf8
> [  102.368574]  do_el0_svc+0x28/0x40
> [  102.369001]  el0_svc+0x50/0x150
> [  102.369464]  el0t_64_sync_handler+0x13c/0x158
> [  102.369916]  el0t_64_sync+0x1a4/0x1a8
> [  126.345236] watchdog: BUG: soft lockup - CPU#3 stuck for 67s! [madvfre=
e:101]
>
> the test code is as belows,
>
> #define MADV_PAGEOUT    21      /* reclaim these pages */
>
> #define DATA_SIZE (128UL * 1024 * 1024)
> #define PAGE_SIZE (4UL * 1024)
> #define LARGE_FOLIO_SIZE (64UL * 1024)
>
> static void *read_data(void *addr)
> {
>         unsigned long i;
>
>         for (i =3D 0; i < DATA_SIZE * 2; i +=3D PAGE_SIZE) {
>                 if (*((char *)addr + i) !=3D (char)i) {
>                 }
>         }
> }
>
> static void *lazyfree(void *addr)
> {
>         unsigned long i;
>
>         madvise(addr, DATA_SIZE * 2, MADV_FREE);
> }
>
> int main(int argc, char **argv)
> {
>         void *addr =3D mmap(NULL, DATA_SIZE * 2, PROT_READ | PROT_WRITE,
>                         MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);

Could you please check the /sys/kernel/mm/transparent_hugepage/enabled?

Is it set to 'always'?

Also, what size of mTHP are you using here?

>         memset(addr, 0x11, DATA_SIZE * 2);
>         lazyfree(addr);
>
>         while(1) {
>                 sleep(1);
>                 read_data(addr);
>         }
>         return 0;
> }

Thanks again for reaching out!
Lance
>
> >  mm/madvise.c | 85 +++++++++++++++++++++++++++-------------------------
> >  1 file changed, 44 insertions(+), 41 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 4597a3568e7e..ed125ad8a21e 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -643,6 +643,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsig=
ned long addr,
> >                                 unsigned long end, struct mm_walk *walk=
)
> >
> >  {
> > +       const cydp_t cydp_flags =3D CYDP_CLEAR_YOUNG | CYDP_CLEAR_DIRTY=
;
> >         struct mmu_gather *tlb =3D walk->private;
> >         struct mm_struct *mm =3D tlb->mm;
> >         struct vm_area_struct *vma =3D walk->vma;
> > @@ -697,44 +698,57 @@ static int madvise_free_pte_range(pmd_t *pmd, uns=
igned long addr,
> >                         continue;
> >
> >                 /*
> > -                * If pmd isn't transhuge but the folio is large and
> > -                * is owned by only this process, split it and
> > -                * deactivate all pages.
> > +                * If we encounter a large folio, only split it if it i=
s not
> > +                * fully mapped within the range we are operating on. O=
therwise
> > +                * leave it as is so that it can be marked as lazyfree.=
 If we
> > +                * fail to split a folio, leave it in place and advance=
 to the
> > +                * next pte in the range.
> >                  */
> >                 if (folio_test_large(folio)) {
> > -                       int err;
> > +                       bool any_young, any_dirty;
> >
> > -                       if (folio_likely_mapped_shared(folio))
> > -                               break;
> > -                       if (!folio_trylock(folio))
> > -                               break;
> > -                       folio_get(folio);
> > -                       arch_leave_lazy_mmu_mode();
> > -                       pte_unmap_unlock(start_pte, ptl);
> > -                       start_pte =3D NULL;
> > -                       err =3D split_folio(folio);
> > -                       folio_unlock(folio);
> > -                       folio_put(folio);
> > -                       if (err)
> > -                               break;
> > -                       start_pte =3D pte =3D
> > -                               pte_offset_map_lock(mm, pmd, addr, &ptl=
);
> > -                       if (!start_pte)
> > -                               break;
> > -                       arch_enter_lazy_mmu_mode();
> > -                       pte--;
> > -                       addr -=3D PAGE_SIZE;
> > -                       continue;
> > +                       nr =3D madvise_folio_pte_batch(addr, end, folio=
, pte,
> > +                                                    ptent, &any_young,=
 &any_dirty);
> > +
> > +                       if (nr < folio_nr_pages(folio)) {
> > +                               int err;
> > +
> > +                               if (folio_likely_mapped_shared(folio))
> > +                                       continue;
> > +                               if (!folio_trylock(folio))
> > +                                       continue;
> > +                               folio_get(folio);
> > +                               arch_leave_lazy_mmu_mode();
> > +                               pte_unmap_unlock(start_pte, ptl);
> > +                               start_pte =3D NULL;
> > +                               err =3D split_folio(folio);
> > +                               folio_unlock(folio);
> > +                               folio_put(folio);
> > +                               pte =3D pte_offset_map_lock(mm, pmd, ad=
dr, &ptl);
> > +                               start_pte =3D pte;
> > +                               if (!start_pte)
> > +                                       break;
> > +                               arch_enter_lazy_mmu_mode();
> > +                               if (!err)
> > +                                       nr =3D 0;
> > +                               continue;
> > +                       }
> > +
> > +                       if (any_young)
> > +                               ptent =3D pte_mkyoung(ptent);
> > +                       if (any_dirty)
> > +                               ptent =3D pte_mkdirty(ptent);
> >                 }
> >
> >                 if (folio_test_swapcache(folio) || folio_test_dirty(fol=
io)) {
> >                         if (!folio_trylock(folio))
> >                                 continue;
> >                         /*
> > -                        * If folio is shared with others, we mustn't c=
lear
> > -                        * the folio's dirty flag.
> > +                        * If we have a large folio at this point, we k=
now it is
> > +                        * fully mapped so if its mapcount is the same =
as its
> > +                        * number of pages, it must be exclusive.
> >                          */
> > -                       if (folio_mapcount(folio) !=3D 1) {
> > +                       if (folio_mapcount(folio) !=3D folio_nr_pages(f=
olio)) {
> >                                 folio_unlock(folio);
> >                                 continue;
> >                         }
> > @@ -750,19 +764,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsi=
gned long addr,
> >                 }
> >
> >                 if (pte_young(ptent) || pte_dirty(ptent)) {
> > -                       /*
> > -                        * Some of architecture(ex, PPC) don't update T=
LB
> > -                        * with set_pte_at and tlb_remove_tlb_entry so =
for
> > -                        * the portability, remap the pte with old|clea=
n
> > -                        * after pte clearing.
> > -                        */
> > -                       ptent =3D ptep_get_and_clear_full(mm, addr, pte=
,
> > -                                                       tlb->fullmm);
> > -
> > -                       ptent =3D pte_mkold(ptent);
> > -                       ptent =3D pte_mkclean(ptent);
> > -                       set_pte_at(mm, addr, pte, ptent);
> > -                       tlb_remove_tlb_entry(tlb, pte, addr);
> > +                       clear_young_dirty_ptes(vma, addr, pte, nr, cydp=
_flags);
> > +                       tlb_remove_tlb_entries(tlb, pte, nr, addr);
> >                 }
> >                 folio_mark_lazyfree(folio);
> >         }
> > --
> > 2.33.1
> >

