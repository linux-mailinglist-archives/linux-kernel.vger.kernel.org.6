Return-Path: <linux-kernel+bounces-400474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5472D9C0E18
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75964B2304E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6862170D6;
	Thu,  7 Nov 2024 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8ucNsaw"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8089E2101B0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731005564; cv=none; b=gtn3VaACCBgwC1frOGVjr95/Ecf6VKRjnpjEfzp6fOeQrTRYGZh+kI7HZnU/SPkhQH4K8mkoqnQRoYteCPpR40GQjgkYi7SMeExyBPXMpfO9Y+FQ7ny/kas12pE153J/w1ueqa9RvRxDIO/PaDl8XQax7EAdMTy49RQBG5TrUFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731005564; c=relaxed/simple;
	bh=z8ThK9cupI19VYwlYoPetHO7sa1yXqdBUhTL1+gjxQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvar6wuj1Md1nViDpalIiYw6xulm4I60irFZzlMXwfrm3a5Caf0q3A8ljkBj7vItkyMTHOa0MFqQklvSgtE3+9qqz52a4fyVBqApTj62WSKf8MROdSxGHu9tk+mSJdk1t9Ker6XAnYtfv7zUBHUiDN+6/R29bb1sHi2qJHZpOAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s8ucNsaw; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460b295b9eeso24751cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 10:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731005561; x=1731610361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSPZp/vkkxm4PmcRnhLRUlap3/JSxQYD2+2CrIS/7/A=;
        b=s8ucNsawbUta4d4HyT8JMVNSU3t/niQREY0VTk6urhh+dSvIOIB53qusQcP6PmeDJ3
         9NT4h2sueQk0feR3nFLPU2CK0yb1UCrbg8Y4jRaJldGN4miJGtfXUSsLqjoLSI7hDiU/
         /LDP6AHeRunk7JXSmRA9Z01Vgjk0nClRsW6Fyn+nQRx48f3d6w2gBF/sXIfqCIHeItIM
         mVvoGc9E7pynIbbmXRPlHc3a6ZPP9sXXDalW+JVtHcRyClcqavi6a+oolXDIwwh7y+VR
         c9UgP/1cnWWyOAW2IqTcua0f2LDsFJR7EPchryGe3EWSta6wK4EPZ3eTB2kXQxM/+NIF
         MMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731005561; x=1731610361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSPZp/vkkxm4PmcRnhLRUlap3/JSxQYD2+2CrIS/7/A=;
        b=MHSZ2KNfFthS7/wTWUtrCRm2sgHoLhCxHpym/JMl9zgUqmUTic77hbNwpIVPcO9VCT
         OmsuntqNV3QZrjZLmLs1MYa54zyHq+x67uEZkd6JB40cm9eMCMtyW6HtoqzEB9MaZvSV
         H+kaqq0Wxs+QNuDgNMW9HJj92jcCucLGVLy8ocpSg/2oi0Id6uMv5stuYUB/AVzw5Qub
         mVg2SzKx9rzlDDCeocmpK45zBfHbajC1LIXVy68iSE4KIbDMg+f/j2TbCTa9MfHN4xQg
         doT/Cnfkyz2AYp2SbaEpQ4rWx4gFRIt+nD6HS5sGE+nZnJqeMs/gwabD6pyHPEt35eTj
         JH4A==
X-Forwarded-Encrypted: i=1; AJvYcCX2jbG8p8Ccoe9avQPDtn5y7YCxbBmnAZWm1WYaLh0bjg9x4Ph+TrhSn4DBV/x87KzF20R2JKmH7LgoD0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFL3TjPuMo0NZ4Hh5b5sueDT4zx7aG6gPUSiRvx9oFk9rHvlEG
	2eL2Km3T2yrSArk+V3QyTTtSfJHKQszj2bkU+xbP4GI97rknhxQhc9al3V1uNMhzcPLQKIojDxG
	4S0KiEW6CPowroBaWY+n/cmvKf34MGsW1NVxV
X-Gm-Gg: ASbGncu+KsKbwsS/svoWy3UUW1ESJb0QT7UwpGB+5BwsajqgMCGQaQGVoHqL4PXKzsR
	ivhQiiDaQJ2cRoR/Ig3dGeZDmEEzBqYezsc0erXXKb6iwWcZvj0/720zSh/5skw==
X-Google-Smtp-Source: AGHT+IF6Lz40AZM4gEZbd60uLeRf+A4xggcfUbVS+7mikK/NnN35Bv/xCssdb3WwArmt3jlGxIU4f7Mp0FwQ1aJHskk=
X-Received: by 2002:a05:622a:14d4:b0:462:9e4:de13 with SMTP id
 d75a77b69052e-462fa58dddcmr5947181cf.9.1731005561078; Thu, 07 Nov 2024
 10:52:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107040239.2847143-1-cmllamas@google.com> <20241107040239.2847143-9-cmllamas@google.com>
 <CAJuCfpHM8J0S4dXhxmVuFSTUV0czg1CTFpf_C=k7M57T9qh-VQ@mail.gmail.com>
 <Zyz--bjvkVXngc5U@google.com> <CAJuCfpHAsgDgqjWmxqwGPxs_i184mrzMSAUZ9fj9PN8eJcGdvQ@mail.gmail.com>
 <Zy0EyMVq0xEdyKNt@google.com> <CAJuCfpF2ZyEPfV_rTsftnc=XKCiwGG2-mL67Bt6o3tEBWn+KwQ@mail.gmail.com>
In-Reply-To: <CAJuCfpF2ZyEPfV_rTsftnc=XKCiwGG2-mL67Bt6o3tEBWn+KwQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 7 Nov 2024 10:52:30 -0800
Message-ID: <CAJuCfpF7Q-uD+Tdyoar_djw+LwckgAbH1uZOABqoRe2=gpGN-Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] binder: use per-vma lock in page installation
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <v-songbaohua@oppo.com>, Hillf Danton <hdanton@sina.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 10:27=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Nov 7, 2024 at 10:19=E2=80=AFAM Carlos Llamas <cmllamas@google.co=
m> wrote:
> >
> > On Thu, Nov 07, 2024 at 10:04:23AM -0800, Suren Baghdasaryan wrote:
> > > On Thu, Nov 7, 2024 at 9:55=E2=80=AFAM Carlos Llamas <cmllamas@google=
.com> wrote:
> > > > On Thu, Nov 07, 2024 at 08:16:39AM -0800, Suren Baghdasaryan wrote:
> > > > > On Wed, Nov 6, 2024 at 8:03=E2=80=AFPM Carlos Llamas <cmllamas@go=
ogle.com> wrote:
> > > > > > +static int binder_page_insert(struct binder_alloc *alloc,
> > > > > > +                             unsigned long addr,
> > > > > > +                             struct page *page)
> > > > > > +{
> > > > > > +       struct mm_struct *mm =3D alloc->mm;
> > > > > > +       struct vm_area_struct *vma;
> > > > > > +       int ret =3D -ESRCH;
> > > > > > +
> > > > > > +       if (!mmget_not_zero(mm))
> > > > > > +               return -ESRCH;
> > > > > > +
> > > > > > +       /* attempt per-vma lock first */
> > > > > > +       vma =3D lock_vma_under_rcu(mm, addr);
> > > > > > +       if (!vma)
> > > > > > +               goto lock_mmap;
> > > > > > +
> > > > > > +       if (binder_alloc_is_mapped(alloc))
> > > > >
> > > > > I don't think you need this check here. lock_vma_under_rcu() ensu=
res
> > > > > that the VMA was not detached from the tree after locking the VMA=
, so
> > > > > if you got a VMA it's in the tree and it can't be removed (becaus=
e
> > > > > it's locked). remove_vma()->vma_close()->vma->vm_ops->close() is
> > > > > called after VMA gets detached from the tree and that won't happe=
n
> > > > > while VMA is locked. So, if lock_vma_under_rcu() returns a VMA,
> > > > > binder_alloc_is_mapped() has to always return true. A WARN_ON() c=
heck
> > > > > here to ensure that might be a better option.
> > > >
> > > > Yes we are guaranteed to have _a_ non-isolated vma. However, the ch=
eck
> > > > validates that it's the _expected_ vma. IIUC, our vma could have be=
en
> > > > unmapped (clearing alloc->mapped) and a _new_ unrelated vma could h=
ave
> > > > gotten the same address space assigned?
> > >
> > > No, this should never happen. lock_vma_under_rcu() specifically check=
s
> > > the address range *after* it locks the VMA:
> > > https://elixir.bootlin.com/linux/v6.11.6/source/mm/memory.c#L6026
> >
> > The scenario I'm describing is the following:
> >
> > Proc A                          Proc B
> >                                 mmap(addr, binder_fd)
> > binder_page_insert()
> > mmget_not_zero()
> >                                 munmap(addr)
> >                                 alloc->mapped =3D false;
> >                                 [...]
> >                                 // mmap other vma but same addr
> >                                 mmap(addr, other_fd)
> >
> > vma =3D lock_vma_under_rcu()
> >
> > Isn't there a chance for the vma that Proc A receives is an unrelated
> > vma that was placed in the same address range?
>
> Ah, I see now. The VMA is a valid one and at the address we specified
> but it does not belong to the binder. Yes, then you do need this
> check.

Is this scenario possible?:

 Proc A                          Proc B
                                 mmap(addr, binder_fd)
 binder_page_insert()
 mmget_not_zero()
                                 munmap(addr)
                                 alloc->mapped =3D false;
                                 [...]
                                 // mmap other vma but same addr
                                 mmap(addr, other_fd)
                                 mmap(other_addr, binder_fd)
 vma =3D lock_vma_under_rcu(addr)

If so, I think your binder_alloc_is_mapped() check will return true
but the binder area is mapped at a different other_addr. To avoid that
I think you can check that "addr" still belongs to [alloc->vm_start,
alloc->buffer_size] after you obtained and locked the VMA.

