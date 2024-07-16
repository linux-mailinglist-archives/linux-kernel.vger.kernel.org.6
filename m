Return-Path: <linux-kernel+bounces-254126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2662932F45
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53671C20CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B341A00C1;
	Tue, 16 Jul 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tu6+MjrJ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872419E832
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721151636; cv=none; b=HTaTgNE7zhhe+ih3kdy01Tj7XurZ9s0Mml67E1p9QRWmtIU3DgQPFUxjCt0kDTIb850zoUT7HSyyteGlx9FnKteryKwpQByDzKbYYXRIvy5DV9OAUpjD5dIWDIQCU+FAYd0LNYnigWrrGz8XWnABwSTuYc6s5PxkxR+QjV6kHUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721151636; c=relaxed/simple;
	bh=547/twQviiaTa5GtBUxbh3v0E1wENmh1ohZvQkTSD3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5/YpSDNH2JlIo4Q5axJs/h9U3OFr7zQgV8AtIrFxd2/kavXGRupL1OX82U5jX0Z/CJ69Iw7/NxetJaxbAXvxyAdg0a4mjxzVyIrmbaOOrGzWSzGU0bxdbk6sMKbq1dQdFyifrBRT8dkSqyNOKeHe/KjAkACUhJAMNN2yCjm7qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tu6+MjrJ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so1861a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721151633; x=1721756433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8Rz9WOH+F2+72IWzA24Tq2s5LRNQxaoM647pGeCPDg=;
        b=Tu6+MjrJHtEq2rkELWaio/Nq0Rwgw6DQFiiOhtFZhcufhriFNnq3w5XVAbTBIvdFtN
         7nW8RmC8ckiBtUP+ef6+hRlm6naRhlWWfwgka7h55CaV/AsiMi10tbAYAPnIuwrk8JGZ
         URj6+zTVv7BNPPPTZZAqHcZoHHxNl5a7oE4GGPVSIDsCWQwq07Yn1RGuFwEDl0Ij0NTM
         N38N2xKa9SvEr0f9fEw8LLBpWH+LvsTkqp02xJ0zniukAU2RA2EVBQK+KAXh8B8L23ye
         fTltqTDe3BTXufrBuL/uIEdgKh0U2AHqKEtA/cNcdjVvry8+p2dNS6VWlR+cIUAlOyPh
         z7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721151633; x=1721756433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8Rz9WOH+F2+72IWzA24Tq2s5LRNQxaoM647pGeCPDg=;
        b=QoPQVTYMVFsUccrkcLVRV30cBhqiE7+2K+0+FODMwLJVSVkFpjGiwb81B8Yl5EWyVV
         FWvTwTdT+5WYT2IvaRTeVRrdIG1Wj2aFFJjrebJCYHqQXc7oECoKdd1lJsJVm2sxAI51
         LLnHYz1ez3YA0L2jAhs4hdqf4RCOutxAC72OM5SC0buYWzJYoJRxLHNfx/B0sxsoKD4Y
         RFVv+AwsL7PFVkyuN8/B6BYLT3u7bjoIQPGADEMRf8to2pTKNa4U/1LLjrW38XiQ+dzR
         cSWMjoy9WhWNEXj3Zke2CArYruZym6zStj4fEnOlOehxXK1AAD5fDXQuEC022xIaXrsC
         ZeMg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ83+W3ZUtoee2irNFVxVuBhM6SWFZdxF3DVw4EvQ8c3P4uKRM4R0qKI9x7Lj/CHbiYt8Dh1R6aNowKFFxRCmeCOgc8SMw1Fft29a1
X-Gm-Message-State: AOJu0Yx+itUG5xS5c+B8T0VBKMpa8yRIpuWvmlLwRAnoAdDEYyzdffPb
	KYF0AZ+iTPc/95Pg7Ayvf2mOQe/ATJRvQrm1QCycdUr2GLf+zKi7h8zhC4iGUowG/F/J/UJ/bMr
	8lOmNE61m75i5d/gaXtKFHIKIPKICmCc3M44k
X-Google-Smtp-Source: AGHT+IG/I+SEeAm/bm+sPZAfHCB0bFCXolLvcEhFvCDsLmCtDmBLmI1sOm3LISIwYdOKl6hvHoSWRT9tVeX2LGH/+yI=
X-Received: by 2002:a05:6402:5205:b0:59e:9fb1:a0dc with SMTP id
 4fb4d7f45d1cf-5a01aa1ea5amr6319a12.6.1721151631517; Tue, 16 Jul 2024 10:40:31
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000601513061d51ea72@google.com> <20240716042856.871184-1-cmllamas@google.com>
In-Reply-To: <20240716042856.871184-1-cmllamas@google.com>
From: Todd Kjos <tkjos@google.com>
Date: Tue, 16 Jul 2024 10:40:20 -0700
Message-ID: <CAHRSSEwkXhuGj0PKXEG1AjKFcJRKeE=QFHWzDUFBBVaS92ApSA@mail.gmail.com>
Subject: Re: [PATCH] binder: fix descriptor lookup for context manager
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, syzkaller-bugs@googlegroups.com, 
	stable@vger.kernel.org, syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 9:29=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> In commit 15d9da3f818c ("binder: use bitmap for faster descriptor
> lookup"), it was incorrectly assumed that references to the context
> manager node should always get descriptor zero assigned to them.
>
> However, if the context manager dies and a new process takes its place,
> then assigning descriptor zero to the new context manager might lead to
> collisions, as there could still be references to the older node. This
> issue was reported by syzbot with the following trace:
>
>   kernel BUG at drivers/android/binder.c:1173!
>   Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>   Modules linked in:
>   CPU: 1 PID: 447 Comm: binder-util Not tainted 6.10.0-rc6-00348-g31643d8=
4b8c3 #10
>   Hardware name: linux,dummy-virt (DT)
>   pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>   pc : binder_inc_ref_for_node+0x500/0x544
>   lr : binder_inc_ref_for_node+0x1e4/0x544
>   sp : ffff80008112b940
>   x29: ffff80008112b940 x28: ffff0e0e40310780 x27: 0000000000000000
>   x26: 0000000000000001 x25: ffff0e0e40310738 x24: ffff0e0e4089ba34
>   x23: ffff0e0e40310b00 x22: ffff80008112bb50 x21: ffffaf7b8f246970
>   x20: ffffaf7b8f773f08 x19: ffff0e0e4089b800 x18: 0000000000000000
>   x17: 0000000000000000 x16: 0000000000000000 x15: 000000002de4aa60
>   x14: 0000000000000000 x13: 2de4acf000000000 x12: 0000000000000020
>   x11: 0000000000000018 x10: 0000000000000020 x9 : ffffaf7b90601000
>   x8 : ffff0e0e48739140 x7 : 0000000000000000 x6 : 000000000000003f
>   x5 : ffff0e0e40310b28 x4 : 0000000000000000 x3 : ffff0e0e40310720
>   x2 : ffff0e0e40310728 x1 : 0000000000000000 x0 : ffff0e0e40310710
>   Call trace:
>    binder_inc_ref_for_node+0x500/0x544
>    binder_transaction+0xf68/0x2620
>    binder_thread_write+0x5bc/0x139c
>    binder_ioctl+0xef4/0x10c8
>   [...]
>
> This patch adds back the previous behavior of assigning the next
> non-zero descriptor if references to previous context managers still
> exist. It amends both strategies, the newer dbitmap code and also the
> legacy slow_desc_lookup_olocked(), by allowing them to start looking
> for available descriptors at a given offset.
>
> Fixes: 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: syzbot+3dae065ca76952a67257@syzkaller.appspotmail=
.com
> Closes: https://lore.kernel.org/all/000000000000c1c0a0061d1e6979@google.c=
om/
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder.c  | 15 ++++++---------
>  drivers/android/dbitmap.h | 16 ++++++----------
>  2 files changed, 12 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index f26286e3713e..905290c98c3c 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1044,13 +1044,13 @@ static struct binder_ref *binder_get_ref_olocked(=
struct binder_proc *proc,
>  }
>
>  /* Find the smallest unused descriptor the "slow way" */
> -static u32 slow_desc_lookup_olocked(struct binder_proc *proc)
> +static u32 slow_desc_lookup_olocked(struct binder_proc *proc, u32 offset=
)
>  {
>         struct binder_ref *ref;
>         struct rb_node *n;
>         u32 desc;
>
> -       desc =3D 1;
> +       desc =3D offset;
>         for (n =3D rb_first(&proc->refs_by_desc); n; n =3D rb_next(n)) {
>                 ref =3D rb_entry(n, struct binder_ref, rb_node_desc);
>                 if (ref->data.desc > desc)
> @@ -1071,21 +1071,18 @@ static int get_ref_desc_olocked(struct binder_pro=
c *proc,
>                                 u32 *desc)
>  {
>         struct dbitmap *dmap =3D &proc->dmap;
> +       unsigned int nbits, offset;
>         unsigned long *new, bit;
> -       unsigned int nbits;
>
>         /* 0 is reserved for the context manager */
> -       if (node =3D=3D proc->context->binder_context_mgr_node) {
> -               *desc =3D 0;
> -               return 0;
> -       }
> +       offset =3D (node =3D=3D proc->context->binder_context_mgr_node) ?=
 0 : 1;

If context manager doesn't need to be bit 0 anymore, then why do we
bother to prefer bit 0? Does it matter?

It would simplify the code below if the offset is always 0 since you
wouldn't need an offset at all.

>
>         if (!dbitmap_enabled(dmap)) {
> -               *desc =3D slow_desc_lookup_olocked(proc);
> +               *desc =3D slow_desc_lookup_olocked(proc, offset);
>                 return 0;
>         }
>
> -       if (dbitmap_acquire_first_zero_bit(dmap, &bit) =3D=3D 0) {
> +       if (dbitmap_acquire_next_zero_bit(dmap, offset, &bit) =3D=3D 0) {
>                 *desc =3D bit;
>                 return 0;
>         }
> diff --git a/drivers/android/dbitmap.h b/drivers/android/dbitmap.h
> index b8ac7b4764fd..1d58c2e7abd6 100644
> --- a/drivers/android/dbitmap.h
> +++ b/drivers/android/dbitmap.h
> @@ -6,8 +6,7 @@
>   *
>   * Used by the binder driver to optimize the allocation of the smallest
>   * available descriptor ID. Each bit in the bitmap represents the state
> - * of an ID, with the exception of BIT(0) which is used exclusively to
> - * reference binder's context manager.
> + * of an ID.
>   *
>   * A dbitmap can grow or shrink as needed. This part has been designed
>   * considering that users might need to briefly release their locks in
> @@ -132,16 +131,17 @@ dbitmap_grow(struct dbitmap *dmap, unsigned long *n=
ew, unsigned int nbits)
>  }
>
>  /*
> - * Finds and sets the first zero bit in the bitmap. Upon success @bit
> + * Finds and sets the next zero bit in the bitmap. Upon success @bit
>   * is populated with the index and 0 is returned. Otherwise, -ENOSPC
>   * is returned to indicate that a dbitmap_grow() is needed.
>   */
>  static inline int
> -dbitmap_acquire_first_zero_bit(struct dbitmap *dmap, unsigned long *bit)
> +dbitmap_acquire_next_zero_bit(struct dbitmap *dmap, unsigned long offset=
,
> +                             unsigned long *bit)
>  {
>         unsigned long n;
>
> -       n =3D find_first_zero_bit(dmap->map, dmap->nbits);
> +       n =3D find_next_zero_bit(dmap->map, dmap->nbits, offset);
>         if (n =3D=3D dmap->nbits)
>                 return -ENOSPC;
>
> @@ -154,9 +154,7 @@ dbitmap_acquire_first_zero_bit(struct dbitmap *dmap, =
unsigned long *bit)
>  static inline void
>  dbitmap_clear_bit(struct dbitmap *dmap, unsigned long bit)
>  {
> -       /* BIT(0) should always set for the context manager */
> -       if (bit)
> -               clear_bit(bit, dmap->map);
> +       clear_bit(bit, dmap->map);
>  }
>
>  static inline int dbitmap_init(struct dbitmap *dmap)
> @@ -168,8 +166,6 @@ static inline int dbitmap_init(struct dbitmap *dmap)
>         }
>
>         dmap->nbits =3D NBITS_MIN;
> -       /* BIT(0) is reserved for the context manager */
> -       set_bit(0, dmap->map);
>
>         return 0;
>  }
> --
> 2.45.2.993.g49e7a77208-goog
>

