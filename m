Return-Path: <linux-kernel+bounces-518966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4030BA39675
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8CE27A0FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318CB22AE59;
	Tue, 18 Feb 2025 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMnzHWQO"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E3B154C12
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869626; cv=none; b=diEcZE3lzAmGoliL3NWl/0UYB3S48CbjHKlzJncEmc2miCITaoekqcESWR7bnVRvyiVKiu9nECzSv1tlR3XrLMhag3nLQADdq9mFIa/8MhADy1R0/Gc/BnudrYKL3moS1z/MnZqTJJlH73DAfAERSZTADjJrbR7AEhSHGl3cX4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869626; c=relaxed/simple;
	bh=Th7RKvnGBHtEPYFg655NOHi2WCCFFyNHaciIJxGUmMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzDd0QW6A/Hqk1PPkHJTQehWGMUH7scc+AtwK6EV+19CaZtv5cnth9t39kWGB1tUAhUU3W/hjijLt+czZE/epv/UUn74Fh+TYrjKLOis3llGNHKQaEGYrD7IZs4rtQdp/5cgOLcD2jlUehtvyibab9QayI9uUomDfi2yRrIwPJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMnzHWQO; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4be75b2bbceso183734137.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739869623; x=1740474423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijdjM3r9vkpZ8G053Cd08J6zp9Cs6ATHk1eNMLvlcx4=;
        b=aMnzHWQOlNIFsRkED6C1bxhCu3//OLsgv9lTaReZatjaeC84E96qrmrD5LBI/NhZN0
         YBCCQXvl2cDuvk6yamRjV2pxBxtg97QPKIpYyGvTUoEB6tUDeE3JB6GZk4YmXCXb3a0w
         UyKql7WDW5Yjt1ZBLzqqO0COs4utS1blnrO5PXCpc1r5QuZJxwnqu1K4TwtfuoODEZHf
         m/e8qrCvvSn+3XRtx5p4pZbiedaNpKG3B5c6KpUSw0s/s7HWtV6WRBjzvqH3tNTIwrSN
         VltUa/th2n4V0CSDUDJPIEHzCOAEVVv0ST705cDLHX2QKUUZMa6yMC/q8UqMoXD6Bqsq
         fUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739869623; x=1740474423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijdjM3r9vkpZ8G053Cd08J6zp9Cs6ATHk1eNMLvlcx4=;
        b=HVs2pO3+Mc+MGumYXX4aT5PHVY8fU22dUN3EIPGJ8DQC4zGHNyQfT4mQhlgcQZHpNN
         HrRo3BYEMfwWJ/9cdtWPh3sh4DaToH5YeH3P4AdUuuVBEUIRT7vJ7tT277fCvX3KYnsv
         aPF41Vcixy1cakVFKpVV3peZYMzdRRyk1a85ZdAMuFaPrSok8YHrnkYoc8GwAghVdErk
         EUEJ/PIzoEHloy3sBq8cVn6GfqTeJ7DbJcpP5QzZ9oV2pbENUna3ByV/5ITj9RN5NC4L
         JcOcv6dY7bvtJhy1uypDgeDvp80OmNeQ+rLTjpN1/gCmIDfPI4BXSb/JYa+XsexODTRE
         0aDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOtyA+Zr8cdGfhPHUn/jaQyalxuf2XR3dbXKAnvpmsvFTC10MDGrjm76ao6222iOV7zzuIb8vEhHqWCfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYxQaIdZDPUfVFHC8jsdP36XVfzUWOcOfX8sZuy1bnqnhSywEj
	Zl0KxLX+i2dkibo3pFUyD+UQHCZGz36pWUAcUdnL5ajWyBVA/TLb5RLkAqgHPEPzPsVHwB0lbLs
	83hDbBQFpPGtvD3iaPwVL1HRuYEYJGUowCFQ=
X-Gm-Gg: ASbGncvyQO/LtU+fAkCgh7OaWi8UuSiNnk8CGQvYQqProXnFCIg4fIwVeymqhFO7SM6
	k0qgHKWNbzG8kCxNfXrjWNesQnQZbo3nB4KKi4IqriOXxCzJhP29K6YUq+ZVPYpMI8NSsprrN
X-Google-Smtp-Source: AGHT+IH9CMOEQXkf0kPuge0tCdRrS3FrQlBb7x4NFefPzJBTvyhzrcC7t70h/ZxmzipsRMKSfv5Y76Hp0OsuwUAbOJk=
X-Received: by 2002:a05:6102:290a:b0:4bb:ba51:7d48 with SMTP id
 ada2fe7eead31-4bd3fc1799fmr6564855137.5.1739869623027; Tue, 18 Feb 2025
 01:07:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f8be2606fa114184a17a48f9859ec592@honor.com> <CAGsJ_4zUbwFP+gf-Y70uGQeO08uAJn2RKj=h9nsV83GvfgVA0A@mail.gmail.com>
 <ef92dcc88e914c9c8d8dbcc3adbb06bb@honor.com> <CAGsJ_4w4iewqi0a+WN0bEVRV-r_EopJcSNDWObLSeRDd4CJhaQ@mail.gmail.com>
 <55a1c2fa3f4248c28e4f06e0432b4252@honor.com>
In-Reply-To: <55a1c2fa3f4248c28e4f06e0432b4252@honor.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 18 Feb 2025 22:06:52 +1300
X-Gm-Features: AWEUYZl16hTrpeBax75duMTkOaWkk3SOcRoPBNSpmfZeB0XVroOTNUVh21SG4dQ
Message-ID: <CAGsJ_4x97ZvEpTW6XD7ruG_wD4k=nmHvy9bmJnt_Y7KyoZoyzA@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Fix possible NULL pointer dereference in __swap_duplicate
To: gaoxu <gaoxu2@honor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, yipengxiang <yipengxiang@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 8:13=E2=80=AFPM gaoxu <gaoxu2@honor.com> wrote:
>
> >
> > Thank you!
> >
> > On Tue, Feb 18, 2025 at 3:51=E2=80=AFPM gaoxu <gaoxu2@honor.com> wrote:
> > >
> > > >
> > > > On Sat, Feb 15, 2025 at 10:05=E2=80=AFPM gaoxu <gaoxu2@honor.com> w=
rote:
> > > > >
> > > > > Add a NULL check on the return value of swp_swap_info in
> > > > > __swap_duplicate to prevent crashes caused by NULL pointer
> > dereference.
> > > > >
> > > > > The reason why swp_swap_info() returns NULL is unclear; it may be
> > > > > due to CPU cache issues or DDR bit flips. The probability of this
> > > > > issue is very small, and the stack info we encountered is as
> > > > > follows=EF=BC=9A
> > > > > Unable to handle kernel NULL pointer dereference at virtual
> > > > > address
> > > > > 0000000000000058
> > > > > [RB/E]rb_sreason_str_set: sreason_str set null_pointer Mem abort =
info:
> > > > >   ESR =3D 0x0000000096000005
> > > > >   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > > > >   SET =3D 0, FnV =3D 0
> > > > >   EA =3D 0, S1PTW =3D 0
> > > > >   FSC =3D 0x05: level 1 translation fault Data abort info:
> > > > >   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
> > > > >   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > > > >   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0 user pgtable=
: 4k
> > > > > pages, 39-bit VAs, pgdp=3D00000008a80e5000 [0000000000000058]
> > > > > pgd=3D0000000000000000, p4d=3D0000000000000000,
> > > > > pud=3D0000000000000000
> > > > > Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP Skip md
> > > > > ftrace buffer dump for: 0x1609e0 ...
> > > > > pc : swap_duplicate+0x44/0x164
> > > > > lr : copy_page_range+0x508/0x1e78
> > > > > sp : ffffffc0f2a699e0
> > > > > x29: ffffffc0f2a699e0 x28: ffffff8a5b28d388 x27: ffffff8b06603388
> > > > > x26: ffffffdf7291fe70 x25: 0000000000000006 x24: 0000000000100073
> > > > > x23: 00000000002d2d2f x22: 0000000000000008 x21:
> > 0000000000000000
> > > > > x20: 00000000002d2d2f x19: 18000000002d2d2f x18: ffffffdf726faec0
> > > > > x17: 0000000000000000 x16: 0010000000000001 x15:
> > 0040000000000001
> > > > > x14: 0400000000000001 x13: ff7ffffffffffb7f x12: ffeffffffffffbff
> > > > > x11: ffffff8a5c7e1898 x10: 0000000000000018 x9 : 0000000000000006
> > > > > x8 : 1800000000000000 x7 : 0000000000000000 x6 : ffffff8057c01f10
> > > > > x5 : 000000000000a318 x4 : 0000000000000000 x3 : 0000000000000000
> > > > > x2 : 0000006daf200000 x1 : 0000000000000001 x0 : 18000000002d2d2f
> > > > > Call
> > > > > trace:
> > > > >  swap_duplicate+0x44/0x164
> > > > >  copy_page_range+0x508/0x1e78
> > > >
> > > > This is really strange since we already have a swap entry check
> > > > before calling swap_duplicate().
> > > >
> > > > copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct
> > *src_mm,
> > > >                 pte_t *dst_pte, pte_t *src_pte, struct
> > > > vm_area_struct *dst_vma,
> > > >                 struct vm_area_struct *src_vma, unsigned long addr,
> > > > int
> > > > *rss) {
> > > >         unsigned long vm_flags =3D dst_vma->vm_flags;
> > > >         pte_t orig_pte =3D ptep_get(src_pte);
> > > >         pte_t pte =3D orig_pte;
> > > >         struct folio *folio;
> > > >         struct page *page;
> > > >         swp_entry_t entry =3D pte_to_swp_entry(orig_pte);
> > > >
> > > >         if (likely(!non_swap_entry(entry))) {
> > > >                 if (swap_duplicate(entry) < 0)
> > > >                         return -EIO; ...
> > > > }
> > > >
> > > > likely the swap_type is larger than MAX_SWAPFILES so we get a NULL?
> > > >
> > > > static struct swap_info_struct *swap_type_to_swap_info(int type) {
> > > >         if (type >=3D MAX_SWAPFILES)
> > > >                 return NULL;
> > > >
> > > >         return READ_ONCE(swap_info[type]); /* rcu_dereference() */ =
}
> > > >
> > > > But non_swap_entry() guarantees that swp_type is smaller than
> > > > MAX_SWAPFILES.
> > > >
> > > > static inline int non_swap_entry(swp_entry_t entry) {
> > > >         return swp_type(entry) >=3D MAX_SWAPFILES; }
> > > >
> > > > So another possibility is that we have an overflow of swap_info[]
> > > > where type is < MAX_SWAPFILES but is not a valid existing swapfile?
> > > In the log of this issue, there is a printed entry: get_swap_device:
> > > Bad swap file entry 18000000002d2d2f.
> > > It can be calculated that swp_type(18000000002d2d2f) =3D 6.
> > > In the Android 15-linux6.6:
> > > system: MAX_SWAPFILES =3D 28, nr_swapfiles =3D 1.
> > > Since swp_type(18000000002d2d2f)=3D6 is less than MAX_SWAPFILES but
> > > greater than nr_swapfiles, the value of this entry is abnormal.
> > >
> > > static unsigned int nr_swapfiles;
> > > static struct swap_info_struct *swap_info[MAX_SWAPFILES]; swap_info i=
s
> > > a static array, with its values initialized to 0.
> > > The size of the array is MAX_SWAPFILES, and the size of valid values
> > > in the array is nr_swapfiles. Therefore, when we validate the validit=
y
> > > of swp_type(entry), we should compare it with nr_swapfiles, not
> > MAX_SWAPFILES.
> > > The code for validating swp_type may need to be modified as follows:
> >
> > That might be true, but on a normal system, we only need to distinguish
> > between a swap entry and a migrate entry. Therefore, comparing with
> > MAX_SWAPFILES is sufficient.
> >
> > > static inline int non_swap_entry(swp_entry_t entry) {
> > > -       return swp_type(entry) >=3D MAX_SWAPFILES;
> > > +       return swp_type(entry) >=3D nr_swapfiles;
> > > }
> > >
> > > static struct swap_info_struct *swap_type_to_swap_info(int type) {
> > > -       if (type >=3D MAX_SWAPFILES)
> > > +       if (type >=3D nr_swapfiles)
> > >                 return NULL;
> > >
> > >         return READ_ONCE(swap_info[type]); /* rcu_dereference() */ }
> > > >
> > > > I don't see how the current patch contributes to debugging or fixin=
g
> > > > anything related to this dumped stack. Can we dump swp_type() as we=
ll?
> > > >
> > > > >  copy_process+0x1278/0x21cc
> > > > >  kernel_clone+0x90/0x438
> > > > >  __arm64_sys_clone+0x5c/0x8c
> > > > >  invoke_syscall+0x58/0x110
> > > > >  do_el0_svc+0x8c/0xe0
> > > > >  el0_svc+0x38/0x9c
> > > > >  el0t_64_sync_handler+0x44/0xec
> > > > >  el0t_64_sync+0x1a8/0x1ac
> > > > > Code: 9139c35a 71006f3f 54000568 f8797b55 (f9402ea8) ---[ end
> > > > > trace
> > > > > 0000000000000000 ]--- Kernel panic - not syncing: Oops: Fatal
> > > > > exception
> > > > > SMP: stopping secondary CPUs
> > > > >
> > > > > The patch seems to only provide a workaround, but there are no
> > > > > more effective software solutions to handle the bit flips problem=
.
> > > > > This path will change the issue from a system crash to a process
> > > > > exception, thereby reducing the impact on the entire machine.
> > > > >
> > > > > Signed-off-by: gao xu <gaoxu2@honor.com>
> > > > > ---
> > > > > v1 -> v2:
> > > > > - Add WARN_ON_ONCE.
> > > > > - update the commit info.
> > > > > v2 -> v3: Delete the review tags (This is my issue, and I apologi=
ze).
> > > > > ---
> > > > >
> > > > > mm/swapfile.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/mm/swapfile.c b/mm/swapfile.c index
> > > > > 7448a3876..a0bfdba94
> > > > > 100644
> > > > > --- a/mm/swapfile.c
> > > > > +++ b/mm/swapfile.c
> > > > > @@ -3521,6 +3521,8 @@ static int __swap_duplicate(swp_entry_t
> > > > > entry,
> > > > unsigned char usage, int nr)
> > > > >         int err, i;
> > > > >
> > > > >         si =3D swp_swap_info(entry);
> > > > > +       if (WARN_ON_ONCE(!si))
> > > >
> > > > I mean, printk something related to swp_type(). This is really
> > > > strange, but the current stack won't help with debugging.
> > > The log can find info related to "get_swap_device: Bad swap file entr=
y xxx"
> > > when an entry encounters an exception.
> > > Add a print info log like the following:
> > > pr_err("%s%08d\n", Bad swap type, swp_type(entry));
> >
> > This is really strange. It would be better to have the entire PTE value=
 dumped so
> > we can determine if a bit-flip occurred on critical bits like PTE_PRESE=
NT.
> Do you mean to convert the SWP entry to PTE and then print it out?
> pr_err("%s%08lx\n", Bad pte, pte_val(swp_entry_to_pte(entry)));
>
> Or is it sufficient to print the SWP entry directly?
> pr_err("%s%08lx\n", Bad swap entry, entry.val);

Yes, I think so. With that, we can convert it to PTE offline and debug usin=
g
that value.

By the way, I don=E2=80=99t have a strong opinion on whether this patch get=
s merged
or not, but it=E2=80=99s still nice to have. :)

I=E2=80=99m more interested in the bug itself and curious whether other And=
roid
products using the same kernel will encounter the same issue.

> >
> > In that case, a present PTE could be misinterpreted as a swap entry.
> >
> > On arm64,
> > /*
> >  * Encode and decode a swap entry:
> >  *      bits 0-1:       present (must be zero)
> >  *      bits 2:         remember PG_anon_exclusive
> >  *      bits 3-7:       swap type
> >  *      bits 8-57:      swap offset
> >  *      bit  58:        PTE_PROT_NONE (must be zero)
> >  */
> >
> > #define __SWP_TYPE_SHIFT        3
> > #define __SWP_TYPE_BITS         5
> > #define __SWP_OFFSET_BITS       50
> > #define __SWP_TYPE_MASK         ((1 << __SWP_TYPE_BITS) - 1)
> > #define __SWP_OFFSET_SHIFT      (__SWP_TYPE_BITS +
> > __SWP_TYPE_SHIFT)
> > #define __SWP_OFFSET_MASK       ((1UL << __SWP_OFFSET_BITS) - 1)
> >
> > _swp_type is bits3-7.
> >
> > For a present pte,  bits 3-7 are:
> > AP[7-6], NS[5], AttributeIndex[4-2].
> >
> > > >
> > > > > +               return -EINVAL;
> > > > >
> > > > >         offset =3D swp_offset(entry);
> > > > >         VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset %
> > > > SWAPFILE_CLUSTER);
> > > > > --
> > > > > 2.17.1
> >

Thanks
Barry

