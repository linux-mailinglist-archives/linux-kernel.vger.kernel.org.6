Return-Path: <linux-kernel+bounces-197300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCA88D68FD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11329B22382
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD687D3E3;
	Fri, 31 May 2024 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUjfBw6F"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E6B17758
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717180260; cv=none; b=K0tGXW8BRItmarpq3g7tQojKHVJVunyqyC2DLI1OTA5DjUQw2AIvYQOA1F462raTxrOm5z95CO/6wWzfVzchC1R2jC8h/fkgvjWJ1obc8uaF+iZGLMMVuanKlc2v6eJrdX5xyY6r0ib8Suhuddp3FuFJ/tMeI8eqqqVR17CncnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717180260; c=relaxed/simple;
	bh=qPcOHWZiYHKTrjK6D6Ot7NPGi0iSUgsI8VYbfKFSUm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhX7h8yevN5k5xpq3R8g07UYhHWV/A1R8BJhz8GouDUu5/0yh8RaxfsREABBAUjzJMiHFPzjh1pJ71yBQNYetPU+ZrPvFXk0OewlWW2tNTmRbuXNi1UFSMdAC9Y8StBEJlz3zuXgHbhqMADnKsm8ruynJLvEryHLHPsR1oMwgRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUjfBw6F; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a68952bade2so66991766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717180257; x=1717785057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAcV3nRDrrpO9NXiDx5moxXJI52iIOrccnZ04YPs0bA=;
        b=FUjfBw6FKddfTl2z3i1DYrmJhVLDqyYrPeRAygaqjN/Ih+EZUNgc2TqpzzayTVR+xs
         2ecHbZAnBwpkBnxb9LXM4yo/HzWfAyT0i+/7otTrKEbeAdL9J3TyFa+PnsTS7e8VZrBi
         zdL5ZG75bVIFATS6efVB4fopwup1Lo2HFifZHM9LG/KoyFVRAMLNl6yYSQhUA4X8AS43
         ZcqkLwIaGE8OsUds9caMwfrwIiXtn8RbaGqddk+nPwxAV0bXfnIkWl8bq0iZki8t1m/S
         4h0qCLrMXbmXeWWrsI3+TF9IlIXCngm26WKZdTzxu6F2MI6PSYUai67DevepKg1FAQQv
         eZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717180257; x=1717785057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAcV3nRDrrpO9NXiDx5moxXJI52iIOrccnZ04YPs0bA=;
        b=IG6g9Yn6AA/mf3i0t2RAteS2xhkkxVLPD5xQ5YJPynwJCS8NvRl9kdq9DEyxTzX7Rl
         dPCkscrayF58S3amiSF5d5PkQiKhLbt+R/CJ+sb82m8JCuoHU7kP0DXlYEy9Dk43/eQ0
         jQpyt8OFjaYfEAtnx+dhpb7VpaI0pNQl9qGNGzE+Sxo6WxxsYM04fCb4UPlsa28WnIjL
         8WEzTrd0IbDtmZ7BEd18o8o4TnyicDFHfs0b5rAyqMJuKSdGDLY1d/QB7UIxfdSfYrPN
         9/M9iI5pQA6K31tljodJscEvsCwjI9oBRlUymuyMB/kH1gyWfZecS1OENWi3oaTVlE9x
         FVJg==
X-Forwarded-Encrypted: i=1; AJvYcCViFuTAZVivdIIoH+UIWjmC+PnYjiivL4saRfbcStyLyqHNguIIHbMNavLReAEVINda7TUoythy96A37A/BQcQKzI1IWOm0+vu7Oa1m
X-Gm-Message-State: AOJu0Yx720jeTm3vSyfgmOQgKL9axquSyGoI7uGgLIm/C2d+oUHELPG0
	nVlpuX6NBQXiivVfLk8wXRGFJgq01iclxS6IEN87uVGjEf7QDtTc5JDNkdWxfSJdnSnfxw7iFtE
	FaS5u60fBaNHIleyuMRkyz43wIaw=
X-Google-Smtp-Source: AGHT+IGukBgOEB/woAAro6+00wDZDArNYp7YhSIFBLTxiy77FJ9GAthlcaf0roy4SzO6wECnVjOpzwXbIxeSaYkEeC8=
X-Received: by 2002:a17:907:5c4:b0:a59:9af5:2c9c with SMTP id
 a640c23a62f3a-a6820902b7amr254096266b.38.1717180256923; Fri, 31 May 2024
 11:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405311534.86cd4043-lkp@intel.com> <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
 <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com> <CAHbLzkqphyX473LBCXXf8rWEr-8m2PB--CT0cwCax3mUyZPGhA@mail.gmail.com>
 <CAHbLzkqG=9VmAcOgFr-50ZdZtf7xj2PqpfD3UHUsMX3jR=+snw@mail.gmail.com> <f4599bd2-72af-4e8d-a0fe-153b69816133@redhat.com>
In-Reply-To: <f4599bd2-72af-4e8d-a0fe-153b69816133@redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 31 May 2024 11:30:45 -0700
Message-ID: <CAHbLzkrOspjVuQw=BN2+RZmV_Ydpz_50yY7FEakJw8Zm14Y9-Q@mail.gmail.com>
Subject: Re: [linus:master] [mm] efa7df3e3b: kernel_BUG_at_include/linux/page_ref.h
To: David Hildenbrand <david@redhat.com>
Cc: kernel test robot <oliver.sang@intel.com>, Peter Xu <peterx@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Rik van Riel <riel@surriel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Christopher Lameter <cl@linux.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 11:24=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 31.05.24 20:13, Yang Shi wrote:
> > On Fri, May 31, 2024 at 11:07=E2=80=AFAM Yang Shi <shy828301@gmail.com>=
 wrote:
> >>
> >> On Fri, May 31, 2024 at 10:46=E2=80=AFAM David Hildenbrand <david@redh=
at.com> wrote:
> >>>
> >>> On 31.05.24 18:50, Yang Shi wrote:
> >>>> On Fri, May 31, 2024 at 1:24=E2=80=AFAM kernel test robot <oliver.sa=
ng@intel.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> Hello,
> >>>>>
> >>>>> kernel test robot noticed "kernel_BUG_at_include/linux/page_ref.h" =
on:
> >>>>>
> >>>>> commit: efa7df3e3bb5da8e6abbe37727417f32a37fba47 ("mm: align larger=
 anonymous mappings on THP boundaries")
> >>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git mas=
ter
> >>>>>
> >>>>> [test failed on linus/master      e0cce98fe279b64f4a7d81b7f5c3a23d8=
0b92fbc]
> >>>>> [test failed on linux-next/master 6dc544b66971c7f9909ff038b62149105=
272d26a]
> >>>>>
> >>>>> in testcase: trinity
> >>>>> version: trinity-x86_64-6a17c218-1_20240527
> >>>>> with following parameters:
> >>>>>
> >>>>>           runtime: 300s
> >>>>>           group: group-00
> >>>>>           nr_groups: 5
> >>>>>
> >>>>>
> >>>>>
> >>>>> compiler: gcc-13
> >>>>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp =
2 -m 16G
> >>>>>
> >>>>> (please refer to attached dmesg/kmsg for entire log/backtrace)
> >>>>>
> >>>>>
> >>>>> we noticed the issue does not always happen. 34 times out of 50 run=
s as below.
> >>>>> the parent is clean.
> >>>>>
> >>>>> 1803d0c5ee1a3bbe efa7df3e3bb5da8e6abbe377274
> >>>>> ---------------- ---------------------------
> >>>>>          fail:runs  %reproduction    fail:runs
> >>>>>              |             |             |
> >>>>>              :50          68%          34:50    dmesg.Kernel_panic-=
not_syncing:Fatal_exception
> >>>>>              :50          68%          34:50    dmesg.RIP:try_get_f=
olio
> >>>>>              :50          68%          34:50    dmesg.invalid_opcod=
e:#[##]
> >>>>>              :50          68%          34:50    dmesg.kernel_BUG_at=
_include/linux/page_ref.h
> >>>>>
> >>>>>
> >>>>>
> >>>>> If you fix the issue in a separate patch/commit (i.e. not just a ne=
w version of
> >>>>> the same patch/commit), kindly add following tags
> >>>>> | Reported-by: kernel test robot <oliver.sang@intel.com>
> >>>>> | Closes: https://lore.kernel.org/oe-lkp/202405311534.86cd4043-lkp@=
intel.com
> >>>>>
> >>>>>
> >>>>> [  275.267158][ T4335] ------------[ cut here ]------------
> >>>>> [  275.267949][ T4335] kernel BUG at include/linux/page_ref.h:275!
> >>>>> [  275.268526][ T4335] invalid opcode: 0000 [#1] KASAN PTI
> >>>>> [  275.269001][ T4335] CPU: 0 PID: 4335 Comm: trinity-c3 Not tainte=
d 6.7.0-rc4-00061-gefa7df3e3bb5 #1
> >>>>> [  275.269787][ T4335] Hardware name: QEMU Standard PC (i440FX + PI=
IX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> >>>>> [ 275.270679][ T4335] RIP: 0010:try_get_folio (include/linux/page_r=
ef.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
> >>>>> [ 275.271159][ T4335] Code: c3 cc cc cc cc 44 89 e6 48 89 df e8 e4 =
54 11 00 eb ae 90 0f 0b 90 31 db eb d5 9c 58 0f 1f 40 00 f6 c4 02 0f 84 46 =
ff ff ff 90 <0f> 0b 48 c7 c6 a0 54 d2 87 48 89 df e8 a9 e9 ff ff 90 0f 0b b=
e 04
> >>>>
> >>>> If I read this BUG correctly, it is:
> >>>>
> >>>> VM_BUG_ON(!in_atomic() && !irqs_disabled());
> >>>>
> >>>
> >>> Yes, that seems to be the one.
> >>>
> >>>> try_grab_folio() actually assumes it is in an atomic context (irq
> >>>> disabled or preempt disabled) for this call path. This is achieved b=
y
> >>>> disabling irq in gup fast or calling it in rcu critical section in
> >>>> page cache lookup path
> >>>
> >>> try_grab_folio()->try_get_folio()->folio_ref_try_add_rcu()
> >>>
> >>> Is called (mm-unstable) from:
> >>>
> >>> (1) gup_fast function, here IRQs are disable
> >>> (2) gup_hugepte(), possibly problematic
> >>> (3) memfd_pin_folios(), possibly problematic
> >>> (4) __get_user_pages(), likely problematic
> >>>
> >>> (1) should be fine.
> >>>
> >>> (2) is possibly problematic on the !fast path. If so, due to commit
> >>>       a12083d721d7 ("mm/gup: handle hugepd for follow_page()") ? CCin=
g Peter.
> >>>
> >>> (3) is possibly wrong. CCing Vivek.
> >>>
> >>> (4) is what we hit here
> >>>
> >>>>
> >>>> And try_grab_folio() is used when the folio is a large folio. The
> >>>
> >>>
> >>> We come via process_vm_rw()->pin_user_pages_remote()->__get_user_page=
s()->try_grab_folio()
> >>>
> >>> That code was added in
> >>>
> >>> commit 57edfcfd3419b4799353d8cbd6ce49da075cfdbd
> >>> Author: Peter Xu <peterx@redhat.com>
> >>> Date:   Wed Jun 28 17:53:07 2023 -0400
> >>>
> >>>       mm/gup: accelerate thp gup even for "pages !=3D NULL"
> >>>
> >>>       The acceleration of THP was done with ctx.page_mask, however it=
'll be
> >>>       ignored if **pages is non-NULL.
> >>>
> >>>
> >>> Likely the try_grab_folio() in __get_user_pages() is wrong?
> >>>
> >>> As documented, we already hold a refcount. Likely we should better do=
 a
> >>> folio_ref_add() and sanity check the refcount.
> >>
> >> Yes, a plain folio_ref_add() seems ok for these cases.
> >>
> >> In addition, the comment of folio_try_get_rcu() says, which is just a
> >> wrapper of folio_ref_try_add_rcu():
> >>
> >> You can also use this function if you're holding a lock that prevents
> >> pages being frozen & removed; eg the i_pages lock for the page cache
> >> or the mmap_lock or page table lock for page tables.  In this case, it
> >> will always succeed, and you could have used a plain folio_get(), but
> >> it's sometimes more convenient to have a common function called from
> >> both locked and RCU-protected contexts.
> >>
> >> So IIUC we can use the plain folio_get() at least for
> >> process_vm_readv/writev since mmap_lock is held in this path.
> >>
> >>>
> >>>
> >>> In essence, I think: try_grab_folio() should only be called from GUP-=
fast where
> >>> IRQs are disabled.
> >>
> >> Yes, I agree. Just the fast path should need to call try_grab_folio().
> >
> > try_grab_folio() also handles FOLL_PIN and FOLL_GET, so we may just
> > keep calling it and add a flag to try_grab_folio, just like:
> >
> > if flag is true
> >      folio_ref_add()
> > else
> >      try_get_folio()
>
>
> try_grab_page() is what we use on the GUP-slow path. We'd likely want a
> folio variant of that.
>
> We might want to call that gup_try_grab_folio() and rename the other one
> to gup_fast_try_grab_folio().

Won't we duplicate the most code with two versions try_grab_folio()?

I meant something like:

try_grab_folio(struct page *page, int refs, unsigned int flags, bool fast)
{
    if fast
        try_get_folio()
    else
        folio_ref_add()
}

We can keep the duplicated code minimum in this way.

>
> Or something like that :)
>
> --
> Cheers,
>
> David / dhildenb
>

