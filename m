Return-Path: <linux-kernel+bounces-197332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED178D6966
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491A01F2746B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2C580626;
	Fri, 31 May 2024 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpjJLEFC"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A2317D341
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182428; cv=none; b=Xf6HWloWg7G3aF0+k8i77OWcU0JGzQrYQ+oOUmkJawyIj1gW/ngw5v1EtsS6HuAb2gHId6/xFi5JIaQmpjNsxL3JXEwho8uiQvONAvTuoPhlQ8+V2h6REf1rPIwwrK/t6udKTUCRWp3z6kM8LMph2+xz3GA9NiaWXZzib098NpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182428; c=relaxed/simple;
	bh=psDIRGw/p1HTpAFUs8I8e4yFg07bWf+upVWE+2G2y7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSCpZZ7EYellJF/ry3CKpXH7T67eDxLQPxloKLVWmMLATm9XAnmwa53Pr0sSPmOd5mIWcI6CzpkQjjKnCqunvzP3jlzkHxo61R0UqskOVFXkD59Z9M1mF6ZQeMsDQaQCBitNKvDWM4038gbuWXZO6cPuPuktQROgwaMamIHCWjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpjJLEFC; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so2014263a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717182424; x=1717787224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVtamtoLjBUIgm4i4LenDIZErQ4EHLQZ6pMrvvKRsL0=;
        b=QpjJLEFCDVqv7prCQtxC1JchiUIdfkvMCGnVS0H92mHQLiSfMaVtW9v5QURba6XDuD
         1qyP9M+cB4Fv35Y1RM1WGieTNoPsnDjHi4tjy8LrqsMIAGZH0EJPmjBe2m0MzN0PrI8v
         oQmist83uwB2qdcInLOUCrW3SVH/zSBKNn94RRYlZoYhwN3WQRTplSbQLY/IIetbVpy7
         RrWAvGkmE0x0U4L0x2ENtjGYTDDnTcA2bU/5uhf6q9eO52QZNGEHTBT24q8pdZxypgMB
         EPorwGYhnEqPlGN7WFRTTve/RC4EObV4UtUOgq6xao2pyiUvpBQcrAvUlBVopef+2G6s
         CoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717182424; x=1717787224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVtamtoLjBUIgm4i4LenDIZErQ4EHLQZ6pMrvvKRsL0=;
        b=NNCa96yHF2XZIDBp3uliojMI6GW7JvOdWWIGwTASbx6ziGVQ/haZCWWd9Xi4uGfXNs
         SfOMcamGhigdkQqPgU2+M0w5pp4XieDhIxnjKu8DwMEf9UKUDxriqbd5TRgtEJuLwJIN
         qnQhieVkDTwQm3ibJEtCIZ8qeD3hcY2vqlsCx/wIR9VHf3HJpwHQiB9SMizvIk9as4bn
         2CKfHRydzILmSw2jxk8nqEy5bsoYVAYPGGRTQ/OUM4nU9xLEhanxI7yC4oSITxjPssk0
         KRmBbbqKgwUj242eKWkhodgUndydFZ33F1ixMt+pEMHRmn6NO+JXwg3T34yPpl5Xh1ti
         dvHw==
X-Forwarded-Encrypted: i=1; AJvYcCVqcmFR9xbrwXUJhXFenf4dELBXl1BMe4hzqdRVXWew4iFjoWFGrQaJribY+8vSRIgVLUB/uquHINEcyLgKzqweODt/D34DazhlB2fC
X-Gm-Message-State: AOJu0YzBnZXtGXgf+Wspk1Nya7o1XhRnMuD9MEAN2jaugxOPzfbdiTqU
	JAWmvEZ8+EF7mh/kjD66ief+o7LZ0e2HcZwYzKpuqll+AXv/9UkqutVaS9gia/0I+T/tJOkbXMJ
	8UTk0s7Atm6cGoGjWXi1QpV8i9F4=
X-Google-Smtp-Source: AGHT+IHF4MW9s+DpQRuXD1FsKWZU8O0P9SLamvtQYcbpNqjX8gv3aZ/wSJJeGHjiYrcfIJ6biq+kpPmTLemxlxFImsc=
X-Received: by 2002:a50:9509:0:b0:57a:3114:7d07 with SMTP id
 4fb4d7f45d1cf-57a3638221emr1932877a12.9.1717182423876; Fri, 31 May 2024
 12:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405311534.86cd4043-lkp@intel.com> <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
 <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com> <CAHbLzkqphyX473LBCXXf8rWEr-8m2PB--CT0cwCax3mUyZPGhA@mail.gmail.com>
 <CAHbLzkqG=9VmAcOgFr-50ZdZtf7xj2PqpfD3UHUsMX3jR=+snw@mail.gmail.com>
 <f4599bd2-72af-4e8d-a0fe-153b69816133@redhat.com> <CAHbLzkrOspjVuQw=BN2+RZmV_Ydpz_50yY7FEakJw8Zm14Y9-Q@mail.gmail.com>
 <a088b5cf-503e-4ed7-b427-f17a9ec5d1a8@redhat.com>
In-Reply-To: <a088b5cf-503e-4ed7-b427-f17a9ec5d1a8@redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 31 May 2024 12:06:52 -0700
Message-ID: <CAHbLzkpnDPYWq=HnaJcKhKnppdNikX4YG+1Ysu8Z+XJCoKK4SQ@mail.gmail.com>
Subject: Re: [linus:master] [mm] efa7df3e3b: kernel_BUG_at_include/linux/page_ref.h
To: David Hildenbrand <david@redhat.com>
Cc: kernel test robot <oliver.sang@intel.com>, Peter Xu <peterx@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Rik van Riel <riel@surriel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Christopher Lameter <cl@linux.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 11:38=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 31.05.24 20:30, Yang Shi wrote:
> > On Fri, May 31, 2024 at 11:24=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >> On 31.05.24 20:13, Yang Shi wrote:
> >>> On Fri, May 31, 2024 at 11:07=E2=80=AFAM Yang Shi <shy828301@gmail.co=
m> wrote:
> >>>>
> >>>> On Fri, May 31, 2024 at 10:46=E2=80=AFAM David Hildenbrand <david@re=
dhat.com> wrote:
> >>>>>
> >>>>> On 31.05.24 18:50, Yang Shi wrote:
> >>>>>> On Fri, May 31, 2024 at 1:24=E2=80=AFAM kernel test robot <oliver.=
sang@intel.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> Hello,
> >>>>>>>
> >>>>>>> kernel test robot noticed "kernel_BUG_at_include/linux/page_ref.h=
" on:
> >>>>>>>
> >>>>>>> commit: efa7df3e3bb5da8e6abbe37727417f32a37fba47 ("mm: align larg=
er anonymous mappings on THP boundaries")
> >>>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git m=
aster
> >>>>>>>
> >>>>>>> [test failed on linus/master      e0cce98fe279b64f4a7d81b7f5c3a23=
d80b92fbc]
> >>>>>>> [test failed on linux-next/master 6dc544b66971c7f9909ff038b621491=
05272d26a]
> >>>>>>>
> >>>>>>> in testcase: trinity
> >>>>>>> version: trinity-x86_64-6a17c218-1_20240527
> >>>>>>> with following parameters:
> >>>>>>>
> >>>>>>>            runtime: 300s
> >>>>>>>            group: group-00
> >>>>>>>            nr_groups: 5
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> compiler: gcc-13
> >>>>>>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -sm=
p 2 -m 16G
> >>>>>>>
> >>>>>>> (please refer to attached dmesg/kmsg for entire log/backtrace)
> >>>>>>>
> >>>>>>>
> >>>>>>> we noticed the issue does not always happen. 34 times out of 50 r=
uns as below.
> >>>>>>> the parent is clean.
> >>>>>>>
> >>>>>>> 1803d0c5ee1a3bbe efa7df3e3bb5da8e6abbe377274
> >>>>>>> ---------------- ---------------------------
> >>>>>>>           fail:runs  %reproduction    fail:runs
> >>>>>>>               |             |             |
> >>>>>>>               :50          68%          34:50    dmesg.Kernel_pan=
ic-not_syncing:Fatal_exception
> >>>>>>>               :50          68%          34:50    dmesg.RIP:try_ge=
t_folio
> >>>>>>>               :50          68%          34:50    dmesg.invalid_op=
code:#[##]
> >>>>>>>               :50          68%          34:50    dmesg.kernel_BUG=
_at_include/linux/page_ref.h
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> If you fix the issue in a separate patch/commit (i.e. not just a =
new version of
> >>>>>>> the same patch/commit), kindly add following tags
> >>>>>>> | Reported-by: kernel test robot <oliver.sang@intel.com>
> >>>>>>> | Closes: https://lore.kernel.org/oe-lkp/202405311534.86cd4043-lk=
p@intel.com
> >>>>>>>
> >>>>>>>
> >>>>>>> [  275.267158][ T4335] ------------[ cut here ]------------
> >>>>>>> [  275.267949][ T4335] kernel BUG at include/linux/page_ref.h:275=
!
> >>>>>>> [  275.268526][ T4335] invalid opcode: 0000 [#1] KASAN PTI
> >>>>>>> [  275.269001][ T4335] CPU: 0 PID: 4335 Comm: trinity-c3 Not tain=
ted 6.7.0-rc4-00061-gefa7df3e3bb5 #1
> >>>>>>> [  275.269787][ T4335] Hardware name: QEMU Standard PC (i440FX + =
PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> >>>>>>> [ 275.270679][ T4335] RIP: 0010:try_get_folio (include/linux/page=
_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
> >>>>>>> [ 275.271159][ T4335] Code: c3 cc cc cc cc 44 89 e6 48 89 df e8 e=
4 54 11 00 eb ae 90 0f 0b 90 31 db eb d5 9c 58 0f 1f 40 00 f6 c4 02 0f 84 4=
6 ff ff ff 90 <0f> 0b 48 c7 c6 a0 54 d2 87 48 89 df e8 a9 e9 ff ff 90 0f 0b=
 be 04
> >>>>>>
> >>>>>> If I read this BUG correctly, it is:
> >>>>>>
> >>>>>> VM_BUG_ON(!in_atomic() && !irqs_disabled());
> >>>>>>
> >>>>>
> >>>>> Yes, that seems to be the one.
> >>>>>
> >>>>>> try_grab_folio() actually assumes it is in an atomic context (irq
> >>>>>> disabled or preempt disabled) for this call path. This is achieved=
 by
> >>>>>> disabling irq in gup fast or calling it in rcu critical section in
> >>>>>> page cache lookup path
> >>>>>
> >>>>> try_grab_folio()->try_get_folio()->folio_ref_try_add_rcu()
> >>>>>
> >>>>> Is called (mm-unstable) from:
> >>>>>
> >>>>> (1) gup_fast function, here IRQs are disable
> >>>>> (2) gup_hugepte(), possibly problematic
> >>>>> (3) memfd_pin_folios(), possibly problematic
> >>>>> (4) __get_user_pages(), likely problematic
> >>>>>
> >>>>> (1) should be fine.
> >>>>>
> >>>>> (2) is possibly problematic on the !fast path. If so, due to commit
> >>>>>        a12083d721d7 ("mm/gup: handle hugepd for follow_page()") ? C=
Cing Peter.
> >>>>>
> >>>>> (3) is possibly wrong. CCing Vivek.
> >>>>>
> >>>>> (4) is what we hit here
> >>>>>
> >>>>>>
> >>>>>> And try_grab_folio() is used when the folio is a large folio. The
> >>>>>
> >>>>>
> >>>>> We come via process_vm_rw()->pin_user_pages_remote()->__get_user_pa=
ges()->try_grab_folio()
> >>>>>
> >>>>> That code was added in
> >>>>>
> >>>>> commit 57edfcfd3419b4799353d8cbd6ce49da075cfdbd
> >>>>> Author: Peter Xu <peterx@redhat.com>
> >>>>> Date:   Wed Jun 28 17:53:07 2023 -0400
> >>>>>
> >>>>>        mm/gup: accelerate thp gup even for "pages !=3D NULL"
> >>>>>
> >>>>>        The acceleration of THP was done with ctx.page_mask, however=
 it'll be
> >>>>>        ignored if **pages is non-NULL.
> >>>>>
> >>>>>
> >>>>> Likely the try_grab_folio() in __get_user_pages() is wrong?
> >>>>>
> >>>>> As documented, we already hold a refcount. Likely we should better =
do a
> >>>>> folio_ref_add() and sanity check the refcount.
> >>>>
> >>>> Yes, a plain folio_ref_add() seems ok for these cases.
> >>>>
> >>>> In addition, the comment of folio_try_get_rcu() says, which is just =
a
> >>>> wrapper of folio_ref_try_add_rcu():
> >>>>
> >>>> You can also use this function if you're holding a lock that prevent=
s
> >>>> pages being frozen & removed; eg the i_pages lock for the page cache
> >>>> or the mmap_lock or page table lock for page tables.  In this case, =
it
> >>>> will always succeed, and you could have used a plain folio_get(), bu=
t
> >>>> it's sometimes more convenient to have a common function called from
> >>>> both locked and RCU-protected contexts.
> >>>>
> >>>> So IIUC we can use the plain folio_get() at least for
> >>>> process_vm_readv/writev since mmap_lock is held in this path.
> >>>>
> >>>>>
> >>>>>
> >>>>> In essence, I think: try_grab_folio() should only be called from GU=
P-fast where
> >>>>> IRQs are disabled.
> >>>>
> >>>> Yes, I agree. Just the fast path should need to call try_grab_folio(=
).
> >>>
> >>> try_grab_folio() also handles FOLL_PIN and FOLL_GET, so we may just
> >>> keep calling it and add a flag to try_grab_folio, just like:
> >>>
> >>> if flag is true
> >>>       folio_ref_add()
> >>> else
> >>>       try_get_folio()
> >>
> >>
> >> try_grab_page() is what we use on the GUP-slow path. We'd likely want =
a
> >> folio variant of that.
> >>
> >> We might want to call that gup_try_grab_folio() and rename the other o=
ne
> >> to gup_fast_try_grab_folio().
> >
> > Won't we duplicate the most code with two versions try_grab_folio()?
> >
> > I meant something like:
> >
> > try_grab_folio(struct page *page, int refs, unsigned int flags, bool fa=
st)
> > {
> >      if fast
> >          try_get_folio()
> >      else
> >          folio_ref_add()
> > }
> >
>
> That's insufficient to handle FOLL_PIN. Likely we should do this:
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 231711efa390d..fea93a64bf235 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -203,8 +203,8 @@ static void gup_put_folio(struct folio *folio, int re=
fs, unsigned int flags)
>   }
>
>   /**
> - * try_grab_page() - elevate a page's refcount by a flag-dependent amoun=
t
> - * @page:    pointer to page to be grabbed
> + * try_grab_folio() - elevate a folios's refcount by a flag-dependent am=
ount
> + * @folio:   pointer to folio to be grabbed
>    * @flags:   gup flags: these are the FOLL_* flag values.
>    *
>    * This might not do anything at all, depending on the flags argument.
> @@ -216,16 +216,16 @@ static void gup_put_folio(struct folio *folio, int =
refs, unsigned int flags)
>    * time. Cases: please see the try_grab_folio() documentation, with
>    * "refs=3D1".
>    *
> + * Must not be called from GUP-fast: the folio must not get freed concur=
rently.
> + *
>    * Return: 0 for success, or if no action was required (if neither FOLL=
_PIN
>    * nor FOLL_GET was set, nothing is done). A negative error code for fa=
ilure:
>    *
>    *   -ENOMEM           FOLL_GET or FOLL_PIN was set, but the page could=
 not
>    *                     be grabbed.
>    */
> -int __must_check try_grab_page(struct page *page, unsigned int flags)
> +int __must_check try_grab_page(struct folio *folio, unsigned int flags)
>   {
> -       struct folio *folio =3D page_folio(page);
> -
>          if (WARN_ON_ONCE(folio_ref_count(folio) <=3D 0))
>                  return -ENOMEM;
>
> @@ -239,7 +239,7 @@ int __must_check try_grab_page(struct page *page, uns=
igned int flags)
>                   * Don't take a pin on the zero page - it's not going an=
ywhere
>                   * and it is used in a *lot* of places.
>                   */
> -               if (is_zero_page(page))
> +               if (is_zero_folio(folio))
>                          return 0;
>
>                  /*
> @@ -260,6 +260,11 @@ int __must_check try_grab_page(struct page *page, un=
signed int flags)
>          return 0;
>   }
>
> +int __must_check try_grab_page(struct page *page, unsigned int flags)
> +{
> +       return gup_try_grab_folio(page_folio(page), flags);
> +}
> +
>   /**
>    * unpin_user_page() - release a dma-pinned page
>    * @page:            pointer to page to be released
>
>
> Then, fix the callers and rename the other one to gup_fast_*.

I see your point. Replace try_grab_page() to try_grab_folio() for slow
path, it returns 0 or errno, but it should never fail in slow path
since we already hold at least one reference IIUC. The fast version
should just like old try_grab_folio(), which returns the pointer to
folio or NULL.

>
>
> --
> Cheers,
>
> David / dhildenb
>

