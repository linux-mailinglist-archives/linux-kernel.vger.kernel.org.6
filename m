Return-Path: <linux-kernel+bounces-197286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D28098D68C0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B301F23B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E579717C9F0;
	Fri, 31 May 2024 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHOKU8Ks"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E90176258
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179217; cv=none; b=QiCQAZkUobNbM7FKw6oT/nd3s+gaHYtfsXAdlGwlcqQ8NJAzcbyZpUiKsX9pSheY0tvx/s4dlghafBNjapVwzK1lgbIJ4BeF6JwXqYAelAPwSoOorgT5UxQzG0w1CSh8h0M3JQ9pZY+kZs5Qgb1Qi/OocNFFd/MVvAw8w76Z/mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179217; c=relaxed/simple;
	bh=sycUjc3OZZqg8FbTdSMUb3WOv78EsOe3JI+crskrlWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKb1crFepGiU+ei+wNB5Kz7ipcMmPHijFtpliEmXcyTPWfOuCGSmvHLFaqLZ8vhev8pGfcA5mVvIgeBc4mNUQnt9ZvLBL8FUf/0+MhDylElARcvBkubHMoqrIIZWXSv97x+I9zFOv3cyobGPLJtNbZ38K781wK0QX6BOrytCVOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHOKU8Ks; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6269885572so442634266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717179214; x=1717784014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TV0ewj2ofkJ+QHrN9fyLdzF3zHHEdMhA4Fe/wK0Sbc=;
        b=CHOKU8KsPoF3oKAeZiizvXG4htZ9lhE5y1D6sUlWj4CZQjF4Fs33zxWM5hkjinvWYI
         Bu+thh9yV9jdX7NcTrKdbyLc9fhG+dgXQ1Ryih+IpbO190QGJS0YlZRox1WwTOo/50Iw
         7SZN/YJbQgoexgRC+4e3FcySZ3ymQO2LfFUo0jHBuyVthdfITV/vPnstlCM1fQF8G4kK
         1+BlqHHmD+T0VCwUj60sfzy3j9SJcbNwpD0UYQiZ8zWryEfIGZZP80M6ScIF82seiEJL
         leo52l4j3hrFwRyDf6cT7l9/WQW1EOCP//VwYjZngzKxpuAFLWpxMiEE7JUzqD00U3i7
         BDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717179214; x=1717784014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TV0ewj2ofkJ+QHrN9fyLdzF3zHHEdMhA4Fe/wK0Sbc=;
        b=jsZtPgQEQR+xrhx3K5jgfETR9xTxW6gb+guyDdIm7IINCJHQgccTz7R57J/pc06oly
         JjpCQ+oo3RrdMae163PfNRnXZNCX+319aVsVGyDASLlNdtMmlXNykkZVlsvTZ4CgGZvE
         lrCdbXMYSvadlZP+cVLd9qeReiX1iQhtLBpbLrxOGGKibBfcpRS9jusTufXHfje8uA4G
         i540Ofo0HVNgob6H7eRPUqVEsgYqKjW5XoTrxbU3Mwgro2DlSBQZeH9SfZGU2ToBnK/T
         EQDL8K37Jui9p617egkkgH1FFn37Zm/3PfMB33JTTz7J8mOwjb74JNiEX5ORCZqNvGoX
         UoHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJZoyBc8tHkO2GW3WOTuWEko7oUnYqZWNBJq3Ew5CHZHnwEsEL9IVARL5mhUi5VqdtEDO7FUzJKQj9dHHkNOK5J2zY+cj0tqMWLDJb
X-Gm-Message-State: AOJu0Yy734+l/cTa5izM7fcVVfTQt4MAkcJq55kXa1/ID0Go9ENuFa7F
	fmioubZrHxFaNJbKF5uw99J9QZvGS2bc/AOXdJf38hDGwLe91YZslQgpfV8o0VrWwmdKNSpdA5H
	V2wsdMwmge54A230uUVu6s/r1E2s=
X-Google-Smtp-Source: AGHT+IH5c9rwggcCjXylCD0ZnbzPCrk0Gl4eHGtauFqpDgl8dd86r3TRRFV5PN4OnFkwPD2Y0nAofHwux6jU/ttA88U=
X-Received: by 2002:a17:906:8886:b0:a66:4045:2c52 with SMTP id
 a640c23a62f3a-a681a8774famr237261466b.28.1717179213449; Fri, 31 May 2024
 11:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405311534.86cd4043-lkp@intel.com> <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
 <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com> <CAHbLzkqphyX473LBCXXf8rWEr-8m2PB--CT0cwCax3mUyZPGhA@mail.gmail.com>
In-Reply-To: <CAHbLzkqphyX473LBCXXf8rWEr-8m2PB--CT0cwCax3mUyZPGhA@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 31 May 2024 11:13:22 -0700
Message-ID: <CAHbLzkqG=9VmAcOgFr-50ZdZtf7xj2PqpfD3UHUsMX3jR=+snw@mail.gmail.com>
Subject: Re: [linus:master] [mm] efa7df3e3b: kernel_BUG_at_include/linux/page_ref.h
To: David Hildenbrand <david@redhat.com>
Cc: kernel test robot <oliver.sang@intel.com>, Peter Xu <peterx@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Rik van Riel <riel@surriel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Christopher Lameter <cl@linux.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 11:07=E2=80=AFAM Yang Shi <shy828301@gmail.com> wro=
te:
>
> On Fri, May 31, 2024 at 10:46=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> >
> > On 31.05.24 18:50, Yang Shi wrote:
> > > On Fri, May 31, 2024 at 1:24=E2=80=AFAM kernel test robot <oliver.san=
g@intel.com> wrote:
> > >>
> > >>
> > >>
> > >> Hello,
> > >>
> > >> kernel test robot noticed "kernel_BUG_at_include/linux/page_ref.h" o=
n:
> > >>
> > >> commit: efa7df3e3bb5da8e6abbe37727417f32a37fba47 ("mm: align larger =
anonymous mappings on THP boundaries")
> > >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git mast=
er
> > >>
> > >> [test failed on linus/master      e0cce98fe279b64f4a7d81b7f5c3a23d80=
b92fbc]
> > >> [test failed on linux-next/master 6dc544b66971c7f9909ff038b621491052=
72d26a]
> > >>
> > >> in testcase: trinity
> > >> version: trinity-x86_64-6a17c218-1_20240527
> > >> with following parameters:
> > >>
> > >>          runtime: 300s
> > >>          group: group-00
> > >>          nr_groups: 5
> > >>
> > >>
> > >>
> > >> compiler: gcc-13
> > >> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2=
 -m 16G
> > >>
> > >> (please refer to attached dmesg/kmsg for entire log/backtrace)
> > >>
> > >>
> > >> we noticed the issue does not always happen. 34 times out of 50 runs=
 as below.
> > >> the parent is clean.
> > >>
> > >> 1803d0c5ee1a3bbe efa7df3e3bb5da8e6abbe377274
> > >> ---------------- ---------------------------
> > >>         fail:runs  %reproduction    fail:runs
> > >>             |             |             |
> > >>             :50          68%          34:50    dmesg.Kernel_panic-no=
t_syncing:Fatal_exception
> > >>             :50          68%          34:50    dmesg.RIP:try_get_fol=
io
> > >>             :50          68%          34:50    dmesg.invalid_opcode:=
#[##]
> > >>             :50          68%          34:50    dmesg.kernel_BUG_at_i=
nclude/linux/page_ref.h
> > >>
> > >>
> > >>
> > >> If you fix the issue in a separate patch/commit (i.e. not just a new=
 version of
> > >> the same patch/commit), kindly add following tags
> > >> | Reported-by: kernel test robot <oliver.sang@intel.com>
> > >> | Closes: https://lore.kernel.org/oe-lkp/202405311534.86cd4043-lkp@i=
ntel.com
> > >>
> > >>
> > >> [  275.267158][ T4335] ------------[ cut here ]------------
> > >> [  275.267949][ T4335] kernel BUG at include/linux/page_ref.h:275!
> > >> [  275.268526][ T4335] invalid opcode: 0000 [#1] KASAN PTI
> > >> [  275.269001][ T4335] CPU: 0 PID: 4335 Comm: trinity-c3 Not tainted=
 6.7.0-rc4-00061-gefa7df3e3bb5 #1
> > >> [  275.269787][ T4335] Hardware name: QEMU Standard PC (i440FX + PII=
X, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > >> [ 275.270679][ T4335] RIP: 0010:try_get_folio (include/linux/page_re=
f.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
> > >> [ 275.271159][ T4335] Code: c3 cc cc cc cc 44 89 e6 48 89 df e8 e4 5=
4 11 00 eb ae 90 0f 0b 90 31 db eb d5 9c 58 0f 1f 40 00 f6 c4 02 0f 84 46 f=
f ff ff 90 <0f> 0b 48 c7 c6 a0 54 d2 87 48 89 df e8 a9 e9 ff ff 90 0f 0b be=
 04
> > >
> > > If I read this BUG correctly, it is:
> > >
> > > VM_BUG_ON(!in_atomic() && !irqs_disabled());
> > >
> >
> > Yes, that seems to be the one.
> >
> > > try_grab_folio() actually assumes it is in an atomic context (irq
> > > disabled or preempt disabled) for this call path. This is achieved by
> > > disabling irq in gup fast or calling it in rcu critical section in
> > > page cache lookup path
> >
> > try_grab_folio()->try_get_folio()->folio_ref_try_add_rcu()
> >
> > Is called (mm-unstable) from:
> >
> > (1) gup_fast function, here IRQs are disable
> > (2) gup_hugepte(), possibly problematic
> > (3) memfd_pin_folios(), possibly problematic
> > (4) __get_user_pages(), likely problematic
> >
> > (1) should be fine.
> >
> > (2) is possibly problematic on the !fast path. If so, due to commit
> >      a12083d721d7 ("mm/gup: handle hugepd for follow_page()") ? CCing P=
eter.
> >
> > (3) is possibly wrong. CCing Vivek.
> >
> > (4) is what we hit here
> >
> > >
> > > And try_grab_folio() is used when the folio is a large folio. The
> >
> >
> > We come via process_vm_rw()->pin_user_pages_remote()->__get_user_pages(=
)->try_grab_folio()
> >
> > That code was added in
> >
> > commit 57edfcfd3419b4799353d8cbd6ce49da075cfdbd
> > Author: Peter Xu <peterx@redhat.com>
> > Date:   Wed Jun 28 17:53:07 2023 -0400
> >
> >      mm/gup: accelerate thp gup even for "pages !=3D NULL"
> >
> >      The acceleration of THP was done with ctx.page_mask, however it'll=
 be
> >      ignored if **pages is non-NULL.
> >
> >
> > Likely the try_grab_folio() in __get_user_pages() is wrong?
> >
> > As documented, we already hold a refcount. Likely we should better do a
> > folio_ref_add() and sanity check the refcount.
>
> Yes, a plain folio_ref_add() seems ok for these cases.
>
> In addition, the comment of folio_try_get_rcu() says, which is just a
> wrapper of folio_ref_try_add_rcu():
>
> You can also use this function if you're holding a lock that prevents
> pages being frozen & removed; eg the i_pages lock for the page cache
> or the mmap_lock or page table lock for page tables.  In this case, it
> will always succeed, and you could have used a plain folio_get(), but
> it's sometimes more convenient to have a common function called from
> both locked and RCU-protected contexts.
>
> So IIUC we can use the plain folio_get() at least for
> process_vm_readv/writev since mmap_lock is held in this path.
>
> >
> >
> > In essence, I think: try_grab_folio() should only be called from GUP-fa=
st where
> > IRQs are disabled.
>
> Yes, I agree. Just the fast path should need to call try_grab_folio().

try_grab_folio() also handles FOLL_PIN and FOLL_GET, so we may just
keep calling it and add a flag to try_grab_folio, just like:

if flag is true
    folio_ref_add()
else
    try_get_folio()

>
> >
> > (2), (3) and (4) are possible offenders of that.
> >
> >
> > Or am I getting it all wrong? :)
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

