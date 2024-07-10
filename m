Return-Path: <linux-kernel+bounces-247867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1586992D5BD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C616828742A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F081919538D;
	Wed, 10 Jul 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ROHHWhpW"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22EB1946AD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627666; cv=none; b=lBhY70tUkIaa+tFdU84DcbB5GEmN6/AkTUcNjNC0jhM1PyVPjA+vaWIJwHQrCaKCyAQhPuLltWEtuRgx6mTizT6DYhFCdm+syD1+Jeh5ilz4QDGnae1cVX2pk3BuaER8aZ3r9gVIC2Ke4Tb96vMR3BZK7X/oyc/aJ8dsYYWgTyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627666; c=relaxed/simple;
	bh=VGQr1x48FZtyRgV4QcACu+Gv3I85uYcfHn8pJAiuUgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=R+3EZkpqmAYswN7Utgq8ZQaP2ZqafyAsLHt8iUw2pqxqYG7dGgL2Oc6Zwi1SmlUkijPm9opwKJaNz4pOIGRToSeJ3/YMqLmNnKvmRl1BQYpfYyK/ZsCl1LXmz3wb1AdBKWQTLrpsot9U5TAuE5LZqPEL8W785DYOsUGWiM4By1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ROHHWhpW; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-64d408a5d01so60391297b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720627664; x=1721232464; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IPWMNSHPG0jt5D2DB0oJLSOfyEu5ju1yz0tYHzAJRc=;
        b=ROHHWhpWmqTWJVviT2AsB3IO92CibcA4D3zXpwScTcTlbAxeAWsB1Wm0tSkZmpnLwK
         Iok+mcsZccVvvo3TfCZ2h3PAjkCVNLzoX4a2te0HYsnLhR8e/XtTWsoCiVEb84jBf0J0
         2u4eS7ibRtbq+Z891BjxTJvrqIEy2sUMu5GXTLh7mjfpcTCI1rHWAPaOpurDxBhXji93
         yQhkG8oXFR5AHfayoRwV2qxsaOem2QdGltvwttsiw9xxr8gLH2sYsfzFYU85fljOv+Ki
         3EIhHpaI/XzMsHn6vLNNGl7rWL6mD6qojSTcgG6ZaervuE/k3/urrgPiBpuTqFmIfoA3
         f/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627664; x=1721232464;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IPWMNSHPG0jt5D2DB0oJLSOfyEu5ju1yz0tYHzAJRc=;
        b=MAjxW/4o1t1TZ2x23DDuUQ3F0JJ9/JgnAvYYscC4HeLTyRB4rsaVE9weCxnZM/NwRG
         HN/AohHm6J4FuqM6B8esHnE+PvSVL08xF3idh/Gz+RGWeuVlWv4sfctlWm06/hlR6OUh
         YYvoc9ZPRYvQewYPuOlqHgb/i8Fu/JA6P5rY/b8UffLdL11IbTLMVyT1zN/Ex1E3ED00
         w9yIVVa8u8k+TjYfy7wDpvtQdPNY5j9chhCCXsQW2aOXfK0mIJLMABR288LKUFGjshrC
         sTtBmqhpdhK+Asom4NfKPladOIAQ8GFv7k5SUdJerA13N7YDwDmlOrE2C9ZHdbQecl3Z
         2ARQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs0L1bhz4Aef5lVan+WDESDq3uAicSwNfjL7ZOSZIY5MrmTNoy/LdYzznjwrCr/30OViEjy7ERaKtsUTUCysAR2892t3s0fH5cBujH
X-Gm-Message-State: AOJu0YyE8ILAqsOJh+TWvb7RsPVrbvlJesokdFD/67wAkYbntYhKIM3V
	l4+qihqTkmfAuCtvsOkAb0O3YJ4+omZZDMaw3I2uHTOKcp7eRu2H1zqjsbZqjaYy+zny+D05oyc
	qjCcInxgAxM1y2Cw0PXcr+J1kLwlx4er8zEuZ
X-Google-Smtp-Source: AGHT+IG95Ds1vL1Lxc6rxvpgc0LZ9RAvUdPaRPYzzaTXRLygP88EEhWnO7DJ1al0B8Jjc4ePUl7qyTWTQArnO/49JyM=
X-Received: by 2002:a05:690c:3688:b0:650:82d0:c12c with SMTP id
 00721157ae682-658eed5ea72mr67690917b3.19.1720627663451; Wed, 10 Jul 2024
 09:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-7-Liam.Howlett@oracle.com> <f12e65e3-adfb-4140-9aaa-e7b11cab972d@lucifer.local>
 <l6j7mytvepxnpxzq6i4kru4datfxhijf44lzugltbxs5f23f6i@lsfcft2tkg7j>
In-Reply-To: <l6j7mytvepxnpxzq6i4kru4datfxhijf44lzugltbxs5f23f6i@lsfcft2tkg7j>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Jul 2024 09:07:32 -0700
Message-ID: <CAJuCfpG0UQwuuw=u+J8E3=CLKBzFuE=YLh=Hi9eebD9yZHcntg@mail.gmail.com>
Subject: Re: [PATCH v3 06/16] mm/mmap: Change munmap to use
 vma_munmap_struct() for accounting and surrounding vmas
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 12:59=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240705 15:27]:
> > On Thu, Jul 04, 2024 at 02:27:08PM GMT, Liam R. Howlett wrote:
> > > Clean up the code by changing the munmap operation to use a structure
> > > for the accounting and munmap variables.
> > >
> > > Since remove_mt() is only called in one location and the contents wil=
l
> > > be reduce to almost nothing.  The remains of the function can be adde=
d
> > > to vms_complete_munmap_vmas().
> > >
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > ---
> > >  mm/internal.h |  6 ++++
> > >  mm/mmap.c     | 81 ++++++++++++++++++++++++++-----------------------=
--
> > >  2 files changed, 47 insertions(+), 40 deletions(-)
> > >
> > > diff --git a/mm/internal.h b/mm/internal.h
> > > index f1e6dea2efcf..8cbbbe7d40f3 100644
> > > --- a/mm/internal.h
> > > +++ b/mm/internal.h
> > > @@ -1488,12 +1488,18 @@ struct vma_munmap_struct {
> > >     struct vma_iterator *vmi;
> > >     struct mm_struct *mm;
> > >     struct vm_area_struct *vma;     /* The first vma to munmap */
> > > +   struct vm_area_struct *next;    /* vma after the munmap area */
> > > +   struct vm_area_struct *prev;    /* vma before the munmap area */
> >
> > I mean this is about as pedantic as it gets, and, admittedly an annoyin=
g
> > comment to make, but the ordering... can't we at least put prev before
> > next? ;)
>
> I can do that, no problem.
> ...
>
> >
> > This is a big improvement overall, very fiddly code.
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> Thanks!

