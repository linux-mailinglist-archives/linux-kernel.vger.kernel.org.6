Return-Path: <linux-kernel+bounces-518663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9795CA392C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BE0169CA1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 05:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8990F1B0F1B;
	Tue, 18 Feb 2025 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh7oGQ8x"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0138C17333F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857264; cv=none; b=aOC8s6JfK73gtZDYa3/lHzXt75jp1qonKeKv4yGQuKKNeiilIzxQejHyFg/YsR2bBJqHXiGPngMaADcmMv3vAOGLfTAPIy2dpg8fiHkQD2MOcXCXIGVM3o/gPG4feTYhraJM7nsUslynZ6h1O4PIgJZAP5SNdvXqPksCGMsM3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857264; c=relaxed/simple;
	bh=t3Oa6WJ3xwJqIKsDLQjt36wU6ohjsaRiFpJTjT8oImM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8jCCYpJhABFlMyRP4VXwm/EeDJo16rlJGTatsqOJM1pWMxQFmZURax5WSPbHP1t8eazR3SiI5Ccg+0wp8dn1ED1G1VCLro1KqXrk8Wys4LN/PrFEEBhFHcml+/4m5N1X0d/bq4GXzy+5eiSrgDbWxia2iFgeGJmqgDiZwW3/rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh7oGQ8x; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4be707fffbcso247361137.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 21:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739857262; x=1740462062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MifYh++JAuvD0qZvmXaJQvX960rDJK4fzbBnF35BdDY=;
        b=Zh7oGQ8xZDtBIyn4b4w36j/ZKs1rnkW7HgbQsfhvoSnM8Hx0w9kUY25aKaEqOJp4nW
         Y5BCSXLVZxANiwvcH5PM19qwyilVSGk14PCL6ZF+N25aOSouAn1EFcdi+7EYTF9sP6vh
         6o5+Uz5vlnCnYPuHNDX7poU8CwKUxpv+X+sQ3Zdumxp6inX+FOEZbXAwKt6ghfDLFx7O
         vQVrE8Gt8hRjdkwVFsi/QXFbGztMmPnBZ8OJIFym0ZbF7jE4SZjMrgG06++TGyIacZz7
         KHTMmmlqjiysfp3xLdO/wDnTFg5En442AUHwKkhO2/v8ZyuRofrdXYzMohFCggITZjhe
         2rKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739857262; x=1740462062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MifYh++JAuvD0qZvmXaJQvX960rDJK4fzbBnF35BdDY=;
        b=P+Doa4sKmDCDBAOnV1AwkXNMXfNKU9eS04kdyxF6qhp7g76HVNkHnZrxuXA5zZ0otE
         o8AduDzl99lvzeSyO0bQsiR6kiXScEsRr3Ekntrx1NzAgSZddt1hEZ7PV0MClYgmXzqk
         6XBgxQZ3iKCQow6Iooe+tE6YaF4DZx7/0TD+Ygx/+QxpkIcVZDS7GdPzSjSX9tVTzQFM
         QbVplY35WqaeC5OfSssccbNGezIxw43Y/yG4fpkWHSXdXzPZHngBSx/Mc3cVnDnsG/Oz
         CJytlJ3zPwNjWa2e6XYsZc3pZJmyxR7/rKv+WDeKgbWCwl3TRmBz1fv2SWvwntZZwl4G
         1kbw==
X-Forwarded-Encrypted: i=1; AJvYcCV1S9nXxXxIhioRfpy7r647f7+eJsjQsqSbgY7L5mwGLZNclY0vRCpQC7ErW1L+mGm5PCrLVO5aENK6T/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhkXmfvcs+7goSw9PQaz6lmMJcVeLehp34ep4ref9cuUKkbFII
	54Ctp7fYEkcG6yZ/KIWMgDNjHKQTNORtri/T/ipWBzppIaL1/pY+rG6hFeBC7kts0g94dTYZs1E
	Xon3NXfZcTLA+mBoZ6xp6YqHTipBvhNbkAmk=
X-Gm-Gg: ASbGncsoV5shjNtFlVq8hJS5UHHz+g3QWtEOTiQte2OZLbIs13juT2DUxCBUqPJpmpO
	WXXQJ2fP1hgD9RbLsFDbhBqLN5RcWbgSo7Zmcwonsr4Uvt9mcAn4VQLVcOdQgXaAnWQNS8BDi
X-Google-Smtp-Source: AGHT+IGR7ulYUkokYF6mOlYBL+Q9buDJnVmvFe9JxfmdfiSj3xbT9BLP20AyUrpmZXe7JuKrQ3wm4zhEQsRVNWwXQ4Q=
X-Received: by 2002:a05:6102:442b:b0:4bb:cf25:c5a7 with SMTP id
 ada2fe7eead31-4bd3fd4882amr6529257137.7.1739857261737; Mon, 17 Feb 2025
 21:41:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f8be2606fa114184a17a48f9859ec592@honor.com> <CAGsJ_4zUbwFP+gf-Y70uGQeO08uAJn2RKj=h9nsV83GvfgVA0A@mail.gmail.com>
 <ef92dcc88e914c9c8d8dbcc3adbb06bb@honor.com>
In-Reply-To: <ef92dcc88e914c9c8d8dbcc3adbb06bb@honor.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 18 Feb 2025 18:40:49 +1300
X-Gm-Features: AWEUYZmrzTbh2ql9JksTax0dFkC3yuh-suhge5VV8sP3McTaFwVSAJzAWWlPK10
Message-ID: <CAGsJ_4w4iewqi0a+WN0bEVRV-r_EopJcSNDWObLSeRDd4CJhaQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Fix possible NULL pointer dereference in __swap_duplicate
To: gaoxu <gaoxu2@honor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, yipengxiang <yipengxiang@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you!

On Tue, Feb 18, 2025 at 3:51=E2=80=AFPM gaoxu <gaoxu2@honor.com> wrote:
>
> >
> > On Sat, Feb 15, 2025 at 10:05=E2=80=AFPM gaoxu <gaoxu2@honor.com> wrote=
:
> > >
> > > Add a NULL check on the return value of swp_swap_info in
> > > __swap_duplicate to prevent crashes caused by NULL pointer dereferenc=
e.
> > >
> > > The reason why swp_swap_info() returns NULL is unclear; it may be due
> > > to CPU cache issues or DDR bit flips. The probability of this issue i=
s
> > > very small, and the stack info we encountered is as follows=EF=BC=9A
> > > Unable to handle kernel NULL pointer dereference at virtual address
> > > 0000000000000058
> > > [RB/E]rb_sreason_str_set: sreason_str set null_pointer Mem abort info=
:
> > >   ESR =3D 0x0000000096000005
> > >   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > >   SET =3D 0, FnV =3D 0
> > >   EA =3D 0, S1PTW =3D 0
> > >   FSC =3D 0x05: level 1 translation fault Data abort info:
> > >   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
> > >   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > >   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0 user pgtable: 4k=
 pages,
> > > 39-bit VAs, pgdp=3D00000008a80e5000 [0000000000000058]
> > > pgd=3D0000000000000000, p4d=3D0000000000000000,
> > > pud=3D0000000000000000
> > > Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP Skip md ftrac=
e
> > > buffer dump for: 0x1609e0 ...
> > > pc : swap_duplicate+0x44/0x164
> > > lr : copy_page_range+0x508/0x1e78
> > > sp : ffffffc0f2a699e0
> > > x29: ffffffc0f2a699e0 x28: ffffff8a5b28d388 x27: ffffff8b06603388
> > > x26: ffffffdf7291fe70 x25: 0000000000000006 x24: 0000000000100073
> > > x23: 00000000002d2d2f x22: 0000000000000008 x21: 0000000000000000
> > > x20: 00000000002d2d2f x19: 18000000002d2d2f x18: ffffffdf726faec0
> > > x17: 0000000000000000 x16: 0010000000000001 x15: 0040000000000001
> > > x14: 0400000000000001 x13: ff7ffffffffffb7f x12: ffeffffffffffbff
> > > x11: ffffff8a5c7e1898 x10: 0000000000000018 x9 : 0000000000000006
> > > x8 : 1800000000000000 x7 : 0000000000000000 x6 : ffffff8057c01f10
> > > x5 : 000000000000a318 x4 : 0000000000000000 x3 : 0000000000000000
> > > x2 : 0000006daf200000 x1 : 0000000000000001 x0 : 18000000002d2d2f Cal=
l
> > > trace:
> > >  swap_duplicate+0x44/0x164
> > >  copy_page_range+0x508/0x1e78
> >
> > This is really strange since we already have a swap entry check before =
calling
> > swap_duplicate().
> >
> > copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >                 pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct
> > *dst_vma,
> >                 struct vm_area_struct *src_vma, unsigned long addr, int
> > *rss) {
> >         unsigned long vm_flags =3D dst_vma->vm_flags;
> >         pte_t orig_pte =3D ptep_get(src_pte);
> >         pte_t pte =3D orig_pte;
> >         struct folio *folio;
> >         struct page *page;
> >         swp_entry_t entry =3D pte_to_swp_entry(orig_pte);
> >
> >         if (likely(!non_swap_entry(entry))) {
> >                 if (swap_duplicate(entry) < 0)
> >                         return -EIO;
> > ...
> > }
> >
> > likely the swap_type is larger than MAX_SWAPFILES so we get a NULL?
> >
> > static struct swap_info_struct *swap_type_to_swap_info(int type) {
> >         if (type >=3D MAX_SWAPFILES)
> >                 return NULL;
> >
> >         return READ_ONCE(swap_info[type]); /* rcu_dereference() */ }
> >
> > But non_swap_entry() guarantees that swp_type is smaller than
> > MAX_SWAPFILES.
> >
> > static inline int non_swap_entry(swp_entry_t entry) {
> >         return swp_type(entry) >=3D MAX_SWAPFILES; }
> >
> > So another possibility is that we have an overflow of swap_info[] where=
 type is <
> > MAX_SWAPFILES but is not a valid existing swapfile?
> In the log of this issue, there is a printed entry: get_swap_device:
> Bad swap file entry 18000000002d2d2f.
> It can be calculated that swp_type(18000000002d2d2f) =3D 6.
> In the Android 15-linux6.6:
> system: MAX_SWAPFILES =3D 28, nr_swapfiles =3D 1.
> Since swp_type(18000000002d2d2f)=3D6 is less than MAX_SWAPFILES but great=
er
> than nr_swapfiles, the value of this entry is abnormal.
>
> static unsigned int nr_swapfiles;
> static struct swap_info_struct *swap_info[MAX_SWAPFILES];
> swap_info is a static array, with its values initialized to 0.
> The size of the array is MAX_SWAPFILES, and the size of valid values in t=
he array is
> nr_swapfiles. Therefore, when we validate the validity of swp_type(entry)=
,
> we should compare it with nr_swapfiles, not MAX_SWAPFILES.
> The code for validating swp_type may need to be modified as follows:

That might be true, but on a normal system, we only need to distinguish
between a swap entry and a migrate entry. Therefore, comparing with
MAX_SWAPFILES is sufficient.

> static inline int non_swap_entry(swp_entry_t entry)
> {
> -       return swp_type(entry) >=3D MAX_SWAPFILES;
> +       return swp_type(entry) >=3D nr_swapfiles;
> }
>
> static struct swap_info_struct *swap_type_to_swap_info(int type)
> {
> -       if (type >=3D MAX_SWAPFILES)
> +       if (type >=3D nr_swapfiles)
>                 return NULL;
>
>         return READ_ONCE(swap_info[type]); /* rcu_dereference() */
> }
> >
> > I don't see how the current patch contributes to debugging or fixing an=
ything
> > related to this dumped stack. Can we dump swp_type() as well?
> >
> > >  copy_process+0x1278/0x21cc
> > >  kernel_clone+0x90/0x438
> > >  __arm64_sys_clone+0x5c/0x8c
> > >  invoke_syscall+0x58/0x110
> > >  do_el0_svc+0x8c/0xe0
> > >  el0_svc+0x38/0x9c
> > >  el0t_64_sync_handler+0x44/0xec
> > >  el0t_64_sync+0x1a8/0x1ac
> > > Code: 9139c35a 71006f3f 54000568 f8797b55 (f9402ea8) ---[ end trace
> > > 0000000000000000 ]--- Kernel panic - not syncing: Oops: Fatal
> > > exception
> > > SMP: stopping secondary CPUs
> > >
> > > The patch seems to only provide a workaround, but there are no more
> > > effective software solutions to handle the bit flips problem. This
> > > path will change the issue from a system crash to a process exception=
,
> > > thereby reducing the impact on the entire machine.
> > >
> > > Signed-off-by: gao xu <gaoxu2@honor.com>
> > > ---
> > > v1 -> v2:
> > > - Add WARN_ON_ONCE.
> > > - update the commit info.
> > > v2 -> v3: Delete the review tags (This is my issue, and I apologize).
> > > ---
> > >
> > > mm/swapfile.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c index 7448a3876..a0bfdba94
> > > 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -3521,6 +3521,8 @@ static int __swap_duplicate(swp_entry_t entry,
> > unsigned char usage, int nr)
> > >         int err, i;
> > >
> > >         si =3D swp_swap_info(entry);
> > > +       if (WARN_ON_ONCE(!si))
> >
> > I mean, printk something related to swp_type(). This is really strange,=
 but the
> > current stack won't help with debugging.
> The log can find info related to "get_swap_device: Bad swap file entry xx=
x"
> when an entry encounters an exception.
> Add a print info log like the following:
> pr_err("%s%08d\n", Bad swap type, swp_type(entry));

This is really strange. It would be better to have the entire PTE value
dumped so we can determine if a bit-flip occurred on critical bits like
PTE_PRESENT.

In that case, a present PTE could be misinterpreted as a swap entry.

On arm64,
/*
 * Encode and decode a swap entry:
 *      bits 0-1:       present (must be zero)
 *      bits 2:         remember PG_anon_exclusive
 *      bits 3-7:       swap type
 *      bits 8-57:      swap offset
 *      bit  58:        PTE_PROT_NONE (must be zero)
 */

#define __SWP_TYPE_SHIFT        3
#define __SWP_TYPE_BITS         5
#define __SWP_OFFSET_BITS       50
#define __SWP_TYPE_MASK         ((1 << __SWP_TYPE_BITS) - 1)
#define __SWP_OFFSET_SHIFT      (__SWP_TYPE_BITS + __SWP_TYPE_SHIFT)
#define __SWP_OFFSET_MASK       ((1UL << __SWP_OFFSET_BITS) - 1)

_swp_type is bits3-7.

For a present pte,  bits 3-7 are:
AP[7-6], NS[5], AttributeIndex[4-2].

> >
> > > +               return -EINVAL;
> > >
> > >         offset =3D swp_offset(entry);
> > >         VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset %
> > SWAPFILE_CLUSTER);
> > > --
> > > 2.17.1

Thanks
Barry

