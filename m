Return-Path: <linux-kernel+bounces-516446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6F4A3719A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 02:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F823A4025
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 01:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1644610D;
	Sun, 16 Feb 2025 01:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuFKgq1a"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94494DDA9
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739670186; cv=none; b=bYNPdg8DGV2ta7jVvEV8UMG0bjksnU7lOqOrsrJ5b+OKgS/37TMN7v435WJfhvz7vVOKci4muEKzEAQL7NEHLq0rEuR2OAWezkU+ITerIXGSukZ8+/D4VmJ/omfLnBSVHd1to6IEF/6B0HbJbADS4XlY5SKdY6NvNwALUyAV1h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739670186; c=relaxed/simple;
	bh=iVxlRcjUGKUoeYp3uUr6xPeDPGy4Lv3nl+rd4UPDGu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fi+R1vdv0sppHyGACpvhw/uUJoM+spWVJf2P47iN1NJvKD5eRA1xtt+nNVqcWQe7uq8iLTtCKywsEmCoioMWiSXYuMX1Inp7l87ODLs+PG4QQ9RkWz9S8LBG93tZM621tzxtfyqs1hdii5uc3wdY6czCXhgfLLAGK3hGXJ3IZac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuFKgq1a; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-866f32750a7so2062855241.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 17:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739670183; x=1740274983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oz8gPdV3LRbojLNIjkuNDOulXZh/XmAXdk7uHwTbEGc=;
        b=UuFKgq1aE71JEpu6K4jwT0uh8cQ7WKlJ5IJJyNTFoeLFEQYkr3XRi9uUZbNkcnIw28
         X1vOI4EdH2EigcYoio9VgFI4YIwp99iSR60S65gIainOIyaiY6hm3e1+BqxpJf7wvU4I
         yTp8GjHTVyq9zPSvgwejrnb0pGNiYu20LXnrL3IcKduGAgQ1OCtmJyvoW8U2zqo4HKs7
         CCtmJ1G6JJEVWAGFZvMKOPpXsvc/FyslnoH4QsCA34rEI2hM6YvMQlX8aXZ1yEh0qeln
         cjr2fAnAyYlWMRKxtsPY9ZkC1B2H8oiuFBFNcccgRIM4gyK3nP8z3yhSVAB+p2bDsj2M
         xAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739670183; x=1740274983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oz8gPdV3LRbojLNIjkuNDOulXZh/XmAXdk7uHwTbEGc=;
        b=jIsB9oSd0+tRYZPlBTflKF8FIQ+bX0NpRhPpxsKUJyv9hMkqy0RsBisd1b1NhE6gXl
         mb/hwvttKFyL9wdu7UIDSwZvdG2x5Z2R2nvSBfEoL5LivQRv1jz/JTh756Quapy6CLJc
         5+Y8hRL6fZ4OkONpt2cbGz+pJzGgc+E8suznzNnLfgAQEyDlpja665VDhHqmg2kHzVPU
         I1nEOLV1vjbhhaG/xhTz8Fr836X01OfN72nhYAibJN6VNjgBkr/bmgojeWAL3km8USD0
         JF6HFtn/q7VQcyqKMvosAog4HEzrZIaIyDagZLeo2JrfLRaezlXJD91EaBTcf/9TAji7
         K/Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUvHc1qLpMAucnLru908LA2sg2CSyEssbEC6CeWRbpy1TGP69Swi1gMmdfXfy9y+dKG+I+IhzPVVr4ip7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRR+727rVuPBQjtlJ1Lqb+hejCvzDk/uPY9Q9Ps8u0mhLxDDSy
	RoJZJ5RYXZ3A+K+YAxyLczzauXEUC3wLjTIw5N4n8epxgtjOZO6IcXb8fgEjTLBaSF0EVqBa+Bv
	ExMvIm/a3MCr61LnycbeI4rB80lqQIeU+iz8=
X-Gm-Gg: ASbGnctfmn44jnmEpCbO+59/EZVVwgEdR5eXVlziP759YsaawGRqpkiGJWDFC6w9yt5
	8EvN6xKBEtRkQdmf/qmOVrRfAB8l1qVIzaPLpQPxMgXqDwUzYg1D/xJnm8eCmdsfCHWWcfaDE
X-Google-Smtp-Source: AGHT+IELZfSG9qgadmAGFgRgUBNleVJU39u54xzNpXFaf7xgM7ahJlVK8AQUwUHHT6+iot3V0FRVllvA89mBVAE0tP0=
X-Received: by 2002:a05:6102:150f:b0:4bb:c8e5:aa6d with SMTP id
 ada2fe7eead31-4bd3fe46605mr2964097137.17.1739670183375; Sat, 15 Feb 2025
 17:43:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f8be2606fa114184a17a48f9859ec592@honor.com>
In-Reply-To: <f8be2606fa114184a17a48f9859ec592@honor.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 16 Feb 2025 14:42:52 +1300
X-Gm-Features: AWEUYZl-ufMVHWw-G1aIPwkogcyGLMRPv76oh35rbF_LJDBXhkOEznJIxHy20O0
Message-ID: <CAGsJ_4zUbwFP+gf-Y70uGQeO08uAJn2RKj=h9nsV83GvfgVA0A@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Fix possible NULL pointer dereference in __swap_duplicate
To: gaoxu <gaoxu2@honor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, yipengxiang <yipengxiang@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 10:05=E2=80=AFPM gaoxu <gaoxu2@honor.com> wrote:
>
> Add a NULL check on the return value of swp_swap_info in __swap_duplicate
> to prevent crashes caused by NULL pointer dereference.
>
> The reason why swp_swap_info() returns NULL is unclear; it may be due to
> CPU cache issues or DDR bit flips. The probability of this issue is very
> small, and the stack info we encountered is as follows=EF=BC=9A
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000058
> [RB/E]rb_sreason_str_set: sreason_str set null_pointer
> Mem abort info:
>   ESR =3D 0x0000000096000005
>   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>   SET =3D 0, FnV =3D 0
>   EA =3D 0, S1PTW =3D 0
>   FSC =3D 0x05: level 1 translation fault
> Data abort info:
>   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
>   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> user pgtable: 4k pages, 39-bit VAs, pgdp=3D00000008a80e5000
> [0000000000000058] pgd=3D0000000000000000, p4d=3D0000000000000000,
> pud=3D0000000000000000
> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> Skip md ftrace buffer dump for: 0x1609e0
> ...
> pc : swap_duplicate+0x44/0x164
> lr : copy_page_range+0x508/0x1e78
> sp : ffffffc0f2a699e0
> x29: ffffffc0f2a699e0 x28: ffffff8a5b28d388 x27: ffffff8b06603388
> x26: ffffffdf7291fe70 x25: 0000000000000006 x24: 0000000000100073
> x23: 00000000002d2d2f x22: 0000000000000008 x21: 0000000000000000
> x20: 00000000002d2d2f x19: 18000000002d2d2f x18: ffffffdf726faec0
> x17: 0000000000000000 x16: 0010000000000001 x15: 0040000000000001
> x14: 0400000000000001 x13: ff7ffffffffffb7f x12: ffeffffffffffbff
> x11: ffffff8a5c7e1898 x10: 0000000000000018 x9 : 0000000000000006
> x8 : 1800000000000000 x7 : 0000000000000000 x6 : ffffff8057c01f10
> x5 : 000000000000a318 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : 0000006daf200000 x1 : 0000000000000001 x0 : 18000000002d2d2f
> Call trace:
>  swap_duplicate+0x44/0x164
>  copy_page_range+0x508/0x1e78

This is really strange since we already have a swap entry check before
calling swap_duplicate().

copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
                pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *dst_=
vma,
                struct vm_area_struct *src_vma, unsigned long addr, int *rs=
s)
{
        unsigned long vm_flags =3D dst_vma->vm_flags;
        pte_t orig_pte =3D ptep_get(src_pte);
        pte_t pte =3D orig_pte;
        struct folio *folio;
        struct page *page;
        swp_entry_t entry =3D pte_to_swp_entry(orig_pte);

        if (likely(!non_swap_entry(entry))) {
                if (swap_duplicate(entry) < 0)
                        return -EIO;
...
}

likely the swap_type is larger than MAX_SWAPFILES so we get a NULL?

static struct swap_info_struct *swap_type_to_swap_info(int type)
{
        if (type >=3D MAX_SWAPFILES)
                return NULL;

        return READ_ONCE(swap_info[type]); /* rcu_dereference() */
}

But non_swap_entry() guarantees that swp_type is smaller than MAX_SWAPFILES=
.

static inline int non_swap_entry(swp_entry_t entry)
{
        return swp_type(entry) >=3D MAX_SWAPFILES;
}

So another possibility is that we have an overflow of swap_info[] where typ=
e is
< MAX_SWAPFILES but is not a valid existing swapfile?

I don't see how the current patch contributes to debugging or fixing
anything related to
this dumped stack. Can we dump swp_type() as well?

>  copy_process+0x1278/0x21cc
>  kernel_clone+0x90/0x438
>  __arm64_sys_clone+0x5c/0x8c
>  invoke_syscall+0x58/0x110
>  do_el0_svc+0x8c/0xe0
>  el0_svc+0x38/0x9c
>  el0t_64_sync_handler+0x44/0xec
>  el0t_64_sync+0x1a8/0x1ac
> Code: 9139c35a 71006f3f 54000568 f8797b55 (f9402ea8)
> ---[ end trace 0000000000000000 ]---
> Kernel panic - not syncing: Oops: Fatal exception
> SMP: stopping secondary CPUs
>
> The patch seems to only provide a workaround, but there are no more
> effective software solutions to handle the bit flips problem. This path
> will change the issue from a system crash to a process exception, thereby
> reducing the impact on the entire machine.
>
> Signed-off-by: gao xu <gaoxu2@honor.com>
> ---
> v1 -> v2:
> - Add WARN_ON_ONCE.
> - update the commit info.
> v2 -> v3: Delete the review tags (This is my issue, and I apologize).
> ---
>
> mm/swapfile.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 7448a3876..a0bfdba94 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3521,6 +3521,8 @@ static int __swap_duplicate(swp_entry_t entry, unsi=
gned char usage, int nr)
>         int err, i;
>
>         si =3D swp_swap_info(entry);
> +       if (WARN_ON_ONCE(!si))

I mean, printk something related to swp_type(). This is really
strange, but the current
stack won't help with debugging.

> +               return -EINVAL;
>
>         offset =3D swp_offset(entry);
>         VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
> --
> 2.17.1

Thanks
Barry

