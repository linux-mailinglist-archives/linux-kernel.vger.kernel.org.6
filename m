Return-Path: <linux-kernel+bounces-199712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5588D8B32
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D5BFB24A6A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FCC13B284;
	Mon,  3 Jun 2024 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMA04pPj"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA6A125D6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717448459; cv=none; b=B/vEjjRLhWDzYa6EIpZUxNeA752azFsKL8yaBuRy9EQ/2GCqHkR1RLpqfdKnsypTTxDZ8mmOYDTgcB4kF8Lk0WLbTO6fyIG57vJldN9Oqj0UBDY6jqdn6Z/tdvMS8NyBpA+krgXsACWmCtIzmX/21FX6zuIVakKF4eP5MvTCVGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717448459; c=relaxed/simple;
	bh=U0d0C2Qc8nhW+Pxro5e9VxmwRw0Do3zIr3QiofiBzs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8S+7L3QciU8EN3Llub+IuUMQn/YPCBp07xgpvylUsjijCCKAl36yRJIvSGEtcr0ASc80p7YKmT3X8V6EN0h5JA9IObs7dX1+1riwgndQg/OHjHYmmCq6aaaJL99odDnPUjtvj9GjxDYPnLWbxHkGDSp6c71/1unsPKIB91cwR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMA04pPj; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-48bd4cefe5cso521584137.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717448456; x=1718053256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tl/tLmHUxVE8PR415A8/Y/rCk+YfJ+4K/h4oejfCHnM=;
        b=DMA04pPj3WZO+20Swz9GhEB6+MtZFrze4FgyNERQfuRBuncXs8S1D7p3rpc/pt9oVd
         AVMvL573AI2RCy6mfAqgjaE2Y5w1sh+0v/5p+sdyMlKITBIqnr1o17FfXPdG8NEOqFW3
         1yB8DPWydM3y9pQ2aiZ0liGoEQi+neai0zxcF1Kn9pIMSx0TJE7bas52JLFkKJmcVfoz
         uj+q5HGjA74Vm4FtNeMZq3pBWTZGff5odyJZimhIb+PiQhAhHAU31pIpgR4v6hkGpPnz
         QIk0peEbmY6RaLk3jXIwNtwqx26BXhjrRaTbb6hKWMUAi5/Y9efvMpBc7QPxMuFFEZ3+
         MnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717448456; x=1718053256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tl/tLmHUxVE8PR415A8/Y/rCk+YfJ+4K/h4oejfCHnM=;
        b=bDc9Dw8TbEhjjGtdPqZB5seNAI1eJFTn0qTQsxQj2J7JFSxTsZZ7PMSrjNCBT+cRRi
         BW/y9oXEWvvoZe1NazRz/obRaQOARQBCCQoY3xY5lK6K+1L5wBIPcE8Tjl9DeHALgWuh
         cFGxXoWCZGS05ajwPCEfrIDas7pMzZ3TloCRTIUudLgF7HZUzd6g5k4B9rGvbrhHWLFJ
         S7/rr37wze+yPP52++z/yntIansRnBR10OpiFHsDS9jjqQh//xhMxbG1jB+vH+8niq7n
         Y4P00rjp86ZUR4VoKj/zbOnP3MQ75gjbPVNAN8+mfLtefpZa0CkTtSW6dANHZRS15Eb5
         3Z6w==
X-Forwarded-Encrypted: i=1; AJvYcCUTU5sQkVDqvH6cPJpBCDhxWgPQ0I/tf8jt3jRmQRmMDiyqHybL0zOp77+ILrg5CI5HcV8m8meoGS0/CYSwUOm1jZ6HpXW55X2Rkhj/
X-Gm-Message-State: AOJu0YyX6SEassrqRTeO1ov7q6AMQooVbrbvAOYjvmcqEMge1BaDPu4D
	/QjBvOyV34w9hz2VW2/qk8tdOMntnJvI9pD4DVsl07yWYwb7RHI+DQ4xT1khTuLkA2pdZT8ciUG
	4mhbVq+B3Upm/QAtKHttXA7pObJ0=
X-Google-Smtp-Source: AGHT+IEvPvzqYmJeRojd3qT1NEMLMX0goTyVSSdJMab9ylacn0zwvrUz4LBErlIDXHllCWdHfZSGyURC/rJZWCEeVWc=
X-Received: by 2002:a67:fa03:0:b0:48b:abba:5d8f with SMTP id
 ada2fe7eead31-48bc211f15cmr10267933137.19.1717448456522; Mon, 03 Jun 2024
 14:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603140745.83880-1-ioworker0@gmail.com> <Zl3Wjh9_aGY8Xxm7@casper.infradead.org>
 <c0309ab6-8bae-42b7-8d27-1df895689fb8@redhat.com> <Zl3axbhcljTg_X0C@casper.infradead.org>
 <db8d4d78-a519-4642-a882-2a84f7a1366b@redhat.com> <CAK1f24=Xa-n2J4_sYL161PMB3hhJ8tcQtJ0qdV7ChPtjMTrPQg@mail.gmail.com>
In-Reply-To: <CAK1f24=Xa-n2J4_sYL161PMB3hhJ8tcQtJ0qdV7ChPtjMTrPQg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 4 Jun 2024 09:00:45 +1200
Message-ID: <CAGsJ_4wwz9gBT35PSffcjQUwPCA2bE=_8Z75RuhsjuQHZnRCVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/mlock: implement folio_mlock_step() using folio_pte_batch()
To: Lance Yang <ioworker0@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	ryan.roberts@arm.com, baolin.wang@linux.alibaba.com, ziy@nvidia.com, 
	fengwei.yin@intel.com, ying.huang@intel.com, libang.li@antgroup.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 3:46=E2=80=AFAM Lance Yang <ioworker0@gmail.com> wro=
te:
>
> On Mon, Jun 3, 2024 at 11:26=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 03.06.24 17:01, Matthew Wilcox wrote:
> > > On Mon, Jun 03, 2024 at 04:56:05PM +0200, David Hildenbrand wrote:
> > >> On 03.06.24 16:43, Matthew Wilcox wrote:
> > >>> On Mon, Jun 03, 2024 at 10:07:45PM +0800, Lance Yang wrote:
> > >>>> +++ b/mm/mlock.c
> > >>>> @@ -307,26 +307,15 @@ void munlock_folio(struct folio *folio)
> > >>>>    static inline unsigned int folio_mlock_step(struct folio *folio=
,
> > >>>>                    pte_t *pte, unsigned long addr, unsigned long e=
nd)
> > >>>>    {
> > >>>> -  unsigned int count, i, nr =3D folio_nr_pages(folio);
> > >>>> -  unsigned long pfn =3D folio_pfn(folio);
> > >>>> +  const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DI=
RTY;
> > >>>> +  unsigned int count =3D (end - addr) >> PAGE_SHIFT;
> > >>>
> > >>> This is a pre-existing bug, but ... what happens if you're on a 64-=
bit
> > >>> system and you mlock() a range that is exactly 2^44 bytes?  Seems t=
o me
> > >>> that count becomes 0.  Why not use an unsigned long here and avoid =
the
> > >>> problem entirely?
> > >>>
> > >>> folio_pte_batch() also needs to take an unsigned long max_nr in tha=
t
> > >>> case, because you aren't restricting it to folio_nr_pages().
> > >>
> > >> Yeah, likely we should also take a look at other folio_pte_batch() u=
sers
> > >> like copy_present_ptes() that pass the count as an int. Nothing shou=
ld
> > >> really be broken, but we might not batch as much as we could, which =
is
> > >> unfortunate.
> > >
> > > You did include:
> > >
> > >          VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, fol=
io);
> > >
> > > so at the least we have a userspace-triggerable warning.
> >
> > Yes, and max_nr =3D=3D 0 would likely not be healthy to the system.
> >
> > But
> >
> > For copy_pte_range(), zap_pte_range() and the madvise users, we should
> > always have:
> >         next =3D pmd_addr_end(addr, end);
> >
> > and use "next" as the actual "end" -- not the VMA end. So "end - addr" =
=3D
> > "next - addr" should never exceed a single PMD size.
> >
> >
> > mlock_pte_range() is also called from walk_page_range(), which uses
> >         next =3D pmd_addr_end(addr, end);
> >
> > So likely exceeding PMD size is not possible here and all is working as
> > expected.
>
> Thanks for clarifying!
>
> I agree that currently all is fine, so perhaps we don't worry about that =
:)

I agree with this point.

These functions are all scanning PTEs under a PMD. Any value exceeding
the PTE entries of one PMD has been a bug of callers but not the callee.

>
> >
> > Will double check later.
>
> I did a double-check and you're correct.
>
> Thanks,
> Lance
>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

Thanks
Barry

