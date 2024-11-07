Return-Path: <linux-kernel+bounces-400454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA909C0DBB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0F41C22427
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AD82170DA;
	Thu,  7 Nov 2024 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hv4rarCx"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C020F5DA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004089; cv=none; b=F/tdAX6j6tA47tGCu2KNUyOzTwpe7Pf774rwxqgK0i0CRQIflJ5AsIDbsRTwaV8icdBANJCoQZrns5yksL51U2m2dqa9SH75qvXVT2EU3OjLs66yTKI6QKsc7w+TjcQlyvYFVFrR9L/d0m0lLhcdb1Y0MwJs9a15nCOIYxkIyuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004089; c=relaxed/simple;
	bh=gtBgQbF7EyTqgiqVBfm9Rfx45b3mX9SrS/HXbEs6An4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqQ9id8AuIQXRYf6JSa/TTvmbfaMaXTpntKEQSVZpZBgxk0cMZKIjT4ubv1719jpI8aKisKeUTXkxfY1C/lsqneSbdTiR8KEkO9CMGUNCPuEV4rcBJXqk6858yTzUEE2BsDEKPvxQyU4F67coyeZBgR1OvybMPfbllWAdxlr/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hv4rarCx; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460b295b9eeso18171cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 10:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731004086; x=1731608886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYEQg+g4Q7NoHB+IWDIywyY3OWw5hRhwFTQaILRh4xo=;
        b=Hv4rarCxpM+d+kjSKKOK3vFOGbECBRjm99N4VmAwz2lCpvKVG1V5PkN+DHpKhyZ/Ae
         nrmmYITgEunIV6MgTx2LpZOD2B4F/Si9OClKp0Lo2aUK1zxTC0THnRUFUJLiVTjXE21o
         3k6ijBCWEwwNU1FGSIivULvD2jFHQGIBHrK5wahN9qcB8GY6WxUb4XN6eXt6tfTtBaSO
         wtOQSVd0GXhCJbLQy3JNTpaegQc7azTB7FEu7ao1VfQe7OfvOXaQ01UAnTKpDsC5iWka
         1gM6FGkU1QqXMJOqEe1dpicMWLxGmyD5ykXZWYn2/CS/3IZcNNabgYg8qxyJmpRJb0/k
         d9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731004086; x=1731608886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYEQg+g4Q7NoHB+IWDIywyY3OWw5hRhwFTQaILRh4xo=;
        b=af6KJRAlWCUHtcRYfmlm0NjI7XljCRxnA3UVVXrOlTeBCz+demhtZTaWXnFdVQvGBP
         mMFIMeOn6foc6LJHlUQ1hljl4fv2sHzl7hB8Mem2MYiUSdMkH9/Y68gvgaMPNHQeuYA3
         oUY1xNwMMgLraCb0o3PCDGh2E7udLnLgHv7Gk1sGeV5yWwJY7oVwztf2i53U9g2Aw/96
         lMOj0hZDvBwpskl+6ZYFUVS4RABxlT+TgfoK7QwqDxPtYUcsAaX0oMaudHRnPukiWf8n
         GXIOY+Ht5WWztehm124mahBIV8ifVx+l6GrPG3H3VjGPK8zvGJ7xp1/gnpKqFRTzqwUZ
         CIwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYCWUjB1Wy/Dgk2mqmFhI37BZMbfhSJVS51+pzYIUj45Ac4lwvljYPPcZWqCxMEaT0ojmhIgV4j0OgdKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWSijj+K/4MoDrRgAd65i2eDqsEJJlVsL/4+eeqI5t0FNP9ECs
	ymsZF813dyuyxXwfrlHAkAb9jQyMy5M3BBKb4Aku/dhqQr3QZE/uC2YppLuumVoG54nE+b0h2Rg
	FZ2h4QpkXi8Kg8t9fZxI8yInf6oOVFqnBkVPK
X-Gm-Gg: ASbGnctceRAKNa5vCNfuMN0swXWF3L8kRcuewRf9aQG0p/BE2uoBfBwaMbK7SyfFCsZ
	EJrz5f6aJMnf2WvLQW3mMXwYtIiWjvrG6YK5PyqSY299kWDeLB8jxlV9sraTA1A==
X-Google-Smtp-Source: AGHT+IFqvziSIj3WKICtIlpwS3CPOJcPa1l9kGLtWovNsWwGYqW+Kkkg3K4sjJKSMZHXTQ8n7qVP1e56yMwrq08w5Jw=
X-Received: by 2002:a05:622a:14d4:b0:462:9e4:de13 with SMTP id
 d75a77b69052e-462fa58dddcmr5801011cf.9.1731004086234; Thu, 07 Nov 2024
 10:28:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107040239.2847143-1-cmllamas@google.com> <20241107040239.2847143-9-cmllamas@google.com>
 <CAJuCfpHM8J0S4dXhxmVuFSTUV0czg1CTFpf_C=k7M57T9qh-VQ@mail.gmail.com>
 <Zyz--bjvkVXngc5U@google.com> <CAJuCfpHAsgDgqjWmxqwGPxs_i184mrzMSAUZ9fj9PN8eJcGdvQ@mail.gmail.com>
 <Zy0EyMVq0xEdyKNt@google.com>
In-Reply-To: <Zy0EyMVq0xEdyKNt@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 7 Nov 2024 10:27:55 -0800
Message-ID: <CAJuCfpF2ZyEPfV_rTsftnc=XKCiwGG2-mL67Bt6o3tEBWn+KwQ@mail.gmail.com>
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

On Thu, Nov 7, 2024 at 10:19=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> On Thu, Nov 07, 2024 at 10:04:23AM -0800, Suren Baghdasaryan wrote:
> > On Thu, Nov 7, 2024 at 9:55=E2=80=AFAM Carlos Llamas <cmllamas@google.c=
om> wrote:
> > > On Thu, Nov 07, 2024 at 08:16:39AM -0800, Suren Baghdasaryan wrote:
> > > > On Wed, Nov 6, 2024 at 8:03=E2=80=AFPM Carlos Llamas <cmllamas@goog=
le.com> wrote:
> > > > > +static int binder_page_insert(struct binder_alloc *alloc,
> > > > > +                             unsigned long addr,
> > > > > +                             struct page *page)
> > > > > +{
> > > > > +       struct mm_struct *mm =3D alloc->mm;
> > > > > +       struct vm_area_struct *vma;
> > > > > +       int ret =3D -ESRCH;
> > > > > +
> > > > > +       if (!mmget_not_zero(mm))
> > > > > +               return -ESRCH;
> > > > > +
> > > > > +       /* attempt per-vma lock first */
> > > > > +       vma =3D lock_vma_under_rcu(mm, addr);
> > > > > +       if (!vma)
> > > > > +               goto lock_mmap;
> > > > > +
> > > > > +       if (binder_alloc_is_mapped(alloc))
> > > >
> > > > I don't think you need this check here. lock_vma_under_rcu() ensure=
s
> > > > that the VMA was not detached from the tree after locking the VMA, =
so
> > > > if you got a VMA it's in the tree and it can't be removed (because
> > > > it's locked). remove_vma()->vma_close()->vma->vm_ops->close() is
> > > > called after VMA gets detached from the tree and that won't happen
> > > > while VMA is locked. So, if lock_vma_under_rcu() returns a VMA,
> > > > binder_alloc_is_mapped() has to always return true. A WARN_ON() che=
ck
> > > > here to ensure that might be a better option.
> > >
> > > Yes we are guaranteed to have _a_ non-isolated vma. However, the chec=
k
> > > validates that it's the _expected_ vma. IIUC, our vma could have been
> > > unmapped (clearing alloc->mapped) and a _new_ unrelated vma could hav=
e
> > > gotten the same address space assigned?
> >
> > No, this should never happen. lock_vma_under_rcu() specifically checks
> > the address range *after* it locks the VMA:
> > https://elixir.bootlin.com/linux/v6.11.6/source/mm/memory.c#L6026
>
> The scenario I'm describing is the following:
>
> Proc A                          Proc B
>                                 mmap(addr, binder_fd)
> binder_page_insert()
> mmget_not_zero()
>                                 munmap(addr)
>                                 alloc->mapped =3D false;
>                                 [...]
>                                 // mmap other vma but same addr
>                                 mmap(addr, other_fd)
>
> vma =3D lock_vma_under_rcu()
>
> Isn't there a chance for the vma that Proc A receives is an unrelated
> vma that was placed in the same address range?

Ah, I see now. The VMA is a valid one and at the address we specified
but it does not belong to the binder. Yes, then you do need this
check.

