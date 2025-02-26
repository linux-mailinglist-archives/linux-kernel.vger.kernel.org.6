Return-Path: <linux-kernel+bounces-532701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 579FCA45128
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56C6189AA6E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3E71C36;
	Wed, 26 Feb 2025 00:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TKbztSDH"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3970FEBE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740528411; cv=none; b=VxHt3Gdosq1LAPUjtmRjcmvZ5pqjh7l9dAG0OupqXhetj8h/bHsrDdcIHCsSFn9Y5VxSjVtaVw+kmOS/XbAQL1JNjBqPOBvUHULO1kzshZODPJbu0vUxMBVzecY3aroNi064cCnDo2P12R+pKuAHg27HC6gltHKYbYzW2WKLxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740528411; c=relaxed/simple;
	bh=S4fMM43XNumxy2Y2WHeMAhzCBwUnO+gGCPA/D0hCFBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obblj8e8uq4NebEamgtA++czC1suBDXO5NeWEXvdXI6r7248+fV81I14dM8ZmCESzO976PKDWearR+tRbn3WKjeHyLEqYLXECD8WMnQPjm7FVgq+S8bJdoAEaMhRX8B3mnz2yqbRYxWStm46IVAVdUPQ+WiBA/+pSTcpHUcdLjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TKbztSDH; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5fce7745a8fso113468eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740528409; x=1741133209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEQHtnjF2vZRn83mHHMuyJ6nMFok4NklDXTEXMMMyT8=;
        b=TKbztSDHrRrD82GBKHC1DEqbom1m7Q7oqFabsXCwIZ9h161hqCawupmceHueDA/vsX
         46wSivpyMFboCFyC8RwZSMqL+uB0lFKvrFY8i0YGA3CAfCHsbwrmck/hQkZeLxAjtvIL
         01rkdydhejh3OBC5YNUaDFDKKc6AEllHR7kbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740528409; x=1741133209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEQHtnjF2vZRn83mHHMuyJ6nMFok4NklDXTEXMMMyT8=;
        b=mALkQftzqYPf/kxsACJ12G2J0SEQpNTevJrlrzehwb9OnWkQwWAtRnjSBxBgz8xpKP
         nZCE2J2P8ZS5O/+YcB1S1Rajv8KyRy1RUwvi/dg0y7Tn2iK5Brq9dwcUk4Ks+M/Rh5TQ
         FIYmLiBcCrQMm16CzWbzhTHrhym6BOT5Vehq3NlYIY6jShjJxoJT8G0axP3I6Vtr1imd
         EbCF3ZYz86g5r44SoIei6PofSw3wkI6Px1/z7riZZB62dxOnTQNk50alYVVCoQWdxavY
         JnWPzs+sqocduQMyTi0M/AaIflDjz+QI/hdaeFPfWyzHf7NT8E9sYFlWiogu6RBwi7oz
         7sDw==
X-Forwarded-Encrypted: i=1; AJvYcCVPEvrpXgztvnoJqgjeBpynjmO3pS4Pc6u52qPR9EVs6mNGUrxxO8azfzrGPjDv7QkBybgxiww41lob2JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnOg0ExmFzQGX97p+AYCfTxqt4Ns2Y5Va+YNal+SGgM09VboSS
	omfGoNScyYEhIB0eO+nOWjP8rf07ymDoAXY/pnvQHt9fl+J4Gvl7bImvpoOcerNp2Ikg4Oz6isI
	/fco9pdwUGsPN++ewL3dIrqiRfe7/t3kM3US2
X-Gm-Gg: ASbGnctOnXWee1GBiIVB4JwrePlse7rXUlaVtdVDJVex8uPV+751vHIksuCd+wD+Sq3
	KxD95dcn3JLtVi+PLkDnwHWFnxtUD0KGTaRE9S1lEYsgcyeXHjtsjw2gq5MZ1ilED0ShH9kDp10
	yKKIpFgp4tCFqvNiq/tpsc1H3uicc0wlKHLfA=
X-Google-Smtp-Source: AGHT+IEkVNQlEk7Bxd7v+XujCfyFZChBzX7n2px0GzS5hBJ1gxxX5fMOBHcLpxDKLvHORzQ6goY6cV15X1nVnc4Q2A0=
X-Received: by 2002:a05:6820:1692:b0:5fc:f0fd:3cf7 with SMTP id
 006d021491bc7-5fd19389a0fmr4090988eaf.0.1740528409160; Tue, 25 Feb 2025
 16:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-7-jeffxu@google.com>
 <55a9ff15-c72e-45cb-ab38-ad814011e27e@lucifer.local>
In-Reply-To: <55a9ff15-c72e-45cb-ab38-ad814011e27e@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 25 Feb 2025 16:06:37 -0800
X-Gm-Features: AQ5f1JqtMYoP2_skx7V3vIqYOv2gZjuF55AZ7cU2O2tsMHOlHUe0nuXvc4MgPGA
Message-ID: <CABi2SkVRG8-j7T30tFQySOU9G8Lvyxqf_aRTrE2KXhj9GeBOkw@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] mseal, system mappings: uprobe mapping
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Oleg Nesterov <oleg@redhat.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, avagin@gmail.com, benjamin@sipsolutions.net, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 10:24=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Feb 24, 2025 at 10:52:45PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Provide support to mseal the uprobe mapping.
> >
> > Unlike other system mappings, the uprobe mapping is not
> > established during program startup. However, its lifetime is the same
> > as the process's lifetime. It could be sealed from creation.
> >
>
> I thought we agreed not to enable this for now? What testing
> have you done to ensure this is functional?
>
I honestly don't know much about uprobe. I don't recall that I agree
to ignore that though.

As indicated in the cover letter, it is my understanding that uprobe's
mapping's lifetime are the same as process's lifetime, thus sealable.
[1]
Oleg Nesterov, also cc, seems OK with mseal it in the early version of
this patch [2]

Are there any potential downsides of doing this? If yes, I can remove it.

I'm also looking at Oleg to give more guidance on this :-), or if
there are some functional tests that I need to do for uprobe.


[1] https://lore.kernel.org/all/20241005200741.GA24353@redhat.com/
[2] https://lore.kernel.org/all/20241005200741.GA24353@redhat.com/

> I mean is this literally _all_ uprobe mappings now being sealed?
>
> I'd really like some more assurances on this one. And what are you
> mitigating by sealing these? I get VDSO (kinda) but uprobes?
>
> You really need to provide more justification here.

Sure. In our threat model, we need to seal all r-x, r--, and --x
mappings to prevent them from becoming writable. This applies to all
mappings, regardless of whether they're created by the kernel or
dynamic linker.


> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  kernel/events/uprobes.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 2ca797cbe465..8dcdfa0d306b 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -1662,6 +1662,7 @@ static const struct vm_special_mapping xol_mappin=
g =3D {
> >  static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
> >  {
> >       struct vm_area_struct *vma;
> > +     unsigned long vm_flags;
> >       int ret;
> >
> >       if (mmap_write_lock_killable(mm))
> > @@ -1682,8 +1683,10 @@ static int xol_add_vma(struct mm_struct *mm, str=
uct xol_area *area)
> >               }
> >       }
> >
> > +     vm_flags =3D VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO;
> > +     vm_flags |=3D VM_SEALED_SYSMAP;
> >       vma =3D _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> > -                             VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
> > +                             vm_flags,
> >                               &xol_mapping);
> >       if (IS_ERR(vma)) {
> >               ret =3D PTR_ERR(vma);
> > --
> > 2.48.1.658.g4767266eb4-goog
> >

