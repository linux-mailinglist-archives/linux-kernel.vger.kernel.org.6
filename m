Return-Path: <linux-kernel+bounces-261997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A9C93BF25
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE6F281636
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD0B197A86;
	Thu, 25 Jul 2024 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMIcY9cQ"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC66197559
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900111; cv=none; b=F+OW8tdcZq/ZbqkNgZJa4bGJy/4SWtLfeiSM2xvlOmLvNF/FAugqh9U0Nk0SLHLqfoKVT0zJ3FTKxTAmpCf0keET+oJET1k62hrvIp2O2f9JudZXWe1wFI1NkXsEpAEh9z89IzVj5JHkDj4iYzBarP2UxDBeVuRsc7VmezweUJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900111; c=relaxed/simple;
	bh=jP6eOQEUEARtt9nz1eIpoHjNnq05FjhkjZZmqwgrfBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xh33QtD5J0jfuzwc1BcaYk79yKXWxBps2xNK4G5CLvXw/LX8tNSGnCb/qXKvKA3h2fFsNqvn/T5mXQDduJ4BCI4JGIHUPkBajVSCU3zIPolr3VVOJAoBIwZkZ+L5U0zTZMjyOcKaMMs0zcTNCE9JYDPvvK0YiaCLA2Gl06oQA+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMIcY9cQ; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4f6c9e8e0f2so164829e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 02:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721900105; x=1722504905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9yOUnzDlzPd3C7+qAj+S0EJyMFKc+8zKUmimt6IWTY=;
        b=QMIcY9cQ/IJsW7OKMWwXXFP+2nuJr/8vuYO59L49mSqBQ0lvHzkcQU2IuWhDEw1RZP
         eiY48Uo1D+nYizVcRJtPIBgk6DmbqEmNC09AQ9dNJGTT+JQjNANl0YGkQl4mg505B71t
         DSaH1NexYc12S4kCrwJ7Te0lUJWvwIcBw6LwVMNSo2BBvtlfhaFtLoVeJ453jCRkTUuJ
         cx0z76NG64pAP4YgnLKQY/KCooV84loBNrKHuQGaBA8mvCXRv9+7w8bH+9ySLDz0YdQj
         nkAv2CIxnqE7UM39WNyagpLUrnKqM5KF5UYqrx8TknPYMH66ULnEa0gqgBJ3xRqY2s2o
         yPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900105; x=1722504905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9yOUnzDlzPd3C7+qAj+S0EJyMFKc+8zKUmimt6IWTY=;
        b=OLU1ODKfxOifCzaT4tyveiWmidkb8f6Z5wlNGgXSa2k9mJCClYPllMhUWn2LHcTyrY
         DVnTWwTzWGA/cuD8EpX0ebuwZQgsw0hYykPClUyqMfETJAxoz4IWSkxkL0YyLolRzZWo
         IMz0fci3F9CnQzdQdITKVwIbnksTIpqmFn05uL8x7T/CpqECbpL/k554zeIgQu2CKyLg
         QHv38pgKywfGQxJxt5PWoR4hXzUJk0SRG4SF2WZBFyj3WyY5vF0P1EWsJfzRkNJqxsJ+
         0In1IVIA8Nik9PRu9+CfDuUUO+OeL4o2N2n0dctZXES6ubsgxmiYVBogQeEo98e/aVD8
         faHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeHGYm4yT9+nZiKGVKIljw014DhqXOjkUybfd03tT70VGCSL/1Ng9Br9HxYBrd5cLrUR9n8bYPX7t/UFnnUDMvxCgv27dCNpTT+SHU
X-Gm-Message-State: AOJu0YyyVusN9gJ13SFZ1NZNNDDcXKGpF5FTm8oHMi67tZ9Kz9Vm8hH4
	vLld1JZSCrIf70R3vpS7EXCSWIwIoKYBh0eNerB6hL8Bc8/QIaO4m02F1ytdD2sVkF7OrX7DVJC
	EFFkntpINmsyzJGRGlh6JOftpIYs=
X-Google-Smtp-Source: AGHT+IGFSkmHvph99nWdKLrDFzDlpZHGJpTz2ErGoL9sqk+PNUJlRz4I6GWG0kJGTUG6ZfxcTuDdzEe+k+Jc9faNN7c=
X-Received: by 2002:a05:6122:2094:b0:4f5:d98:5ef2 with SMTP id
 71dfb90a1353d-4f6ca2c36f7mr1240963e0c.4.1721900105141; Thu, 25 Jul 2024
 02:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725035318.471-1-hailong.liu@oppo.com> <CAGsJ_4zWsh50Pzp0ntskT=eyfStALxD5BMNdWFrYJewrrx7V5Q@mail.gmail.com>
 <20240725091703.tsjpgltwgu3jwy5e@oppo.com>
In-Reply-To: <20240725091703.tsjpgltwgu3jwy5e@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 25 Jul 2024 21:34:52 +1200
Message-ID: <CAGsJ_4xF2J=xxG1rVvFARJtVrvfrGAr7ZLtMCgp8obL6Q0TcMw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm/vmalloc: fix incorrect __vmap_pages_range_noflush()
 if vm_area_alloc_pages() from high order fallback to order0
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@suse.com>, Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	"Tangquan . Zheng" <zhengtangquan@oppo.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 9:17=E2=80=AFPM Hailong Liu <hailong.liu@oppo.com> =
wrote:
>
> On Thu, 25. Jul 18:21, Barry Song wrote:
> > On Thu, Jul 25, 2024 at 3:53=E2=80=AFPM <hailong.liu@oppo.com> wrote:
> [snip]
> >
> > This is still incorrect because it undoes Michal's work. We also need t=
o break
> > the loop if (!nofail), which you're currently omitting.
>
> IIUC, the origin issue is to fix kvcalloc with __GFP_NOFAIL return NULL.
> https://lore.kernel.org/all/ZAXynvdNqcI0f6Us@dhcp22.suse.cz/T/#u
> if we disable huge flag in kmalloc_node, the issue will be fixed.

No, this just bypasses kvmalloc and doesn't solve the underlying issue. Pro=
blems
can still be triggered by vmalloc_huge() even after the bypass. Once we
reorganize vmap_huge to support the combination of PMD and PTE
mapping, we should re-enable HUGE_VMAP for kvmalloc.

I would consider dropping VM_ALLOW_HUGE_VMAP() for kvmalloc as
an short-term "optimization" to save memory rather than a long-term fix. Th=
is
'optimization' is only valid until we reorganize HUGE_VMAP in a way
similar to THP. I mean, for a 2.1MB kvmalloc, we can map 2MB as PMD
and 0.1 as PTE.

> >
> > To avoid reverting Michal's work, the simplest "fix" would be,
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index caf032f0bd69..0011ca30df1c 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3775,7 +3775,7 @@ void *__vmalloc_node_range_noprof(unsigned long
> > size, unsigned long align,
> >                 return NULL;
> >         }
> >
> > -       if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
> > +       if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP) &
> > !(gfp_mask & __GFP_NOFAIL)) {
> >                 unsigned long size_per_node;
> >
> >                 /*
> > >
> > > [1] https://lore.kernel.org/lkml/20240724182827.nlgdckimtg2gwns5@oppo=
.com/
> > > 2.34.1
> >
> > Thanks
> > Barry
>
> --
> help you, help me,
> Hailong.

