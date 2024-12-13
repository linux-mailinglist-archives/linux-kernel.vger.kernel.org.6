Return-Path: <linux-kernel+bounces-445287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D74839F141B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4471889406
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A031E5708;
	Fri, 13 Dec 2024 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORwLZEX7"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD817B505
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734111697; cv=none; b=jpwI9lHjkAPdg5X8UKGdqwWaqQyA5AuRjRvqbPxmIQUCoWteLETONDJpHEgy9Oaolp11BfDLps7CDfHFrQINXfEFgHki7gcygGI1xh8nIgSJkPIZMqngcmW6fzewuXCPSRHK8Kxr0dgmaafRHKBvP5Vzu8L3L7JXjlQyPK/AxPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734111697; c=relaxed/simple;
	bh=vj4HagS7fJXapOeggRa0fGuFOpSw3V9W5jQqX9jeS8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYkkZ6nq54ej9e5meEzlTxEO193/ZDKMjIK1uzuOmsqv+KhxSXhOoq4o9dK9USjmp0QxziG5clGJTs4dwrg3yVzsCG4UVhywrPc+9OALDC7IKTI62tDVXsdYELvohcPBK57he6KlBD8ELxxIaVSCctUpbezw3G/R4j8ssjG9XNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ORwLZEX7; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-467896541e1so3461cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734111694; x=1734716494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4qzw5gnIvrJ4Oafcqo/5vhxoLnxjAIY9Rxm1LIG2b8=;
        b=ORwLZEX7n0e3fg1zLx2zox3ie3iv2FRlvsV/Btrc83tXrMsX17oYkf/yEJ5tCWkHof
         QC8gmADk0VSuQoigVEf05MUOd9zQa12F8NtclFTA5rqQQeQw5ZemEc8shpQeoTdR7MhZ
         4sBqVFKth0QBC0a30LLbOvr0q+lJgKl/nGPESEgWPHtm350K60kiXiWv6UiyCuHMt4ME
         C53x0/in/EwQes2wOsmgt+Jcjfj94yuq9vy3azWVXK/5uEHOurodiajpWHrbeNP9RFmr
         aNvJuUUDI1JaqmBHCONK5WWTbUmcIHKDe8IFdvgVHNFAhWqfkM14QIUMz0ZcDlVNywWb
         P8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734111694; x=1734716494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4qzw5gnIvrJ4Oafcqo/5vhxoLnxjAIY9Rxm1LIG2b8=;
        b=wO1zWyYv4t+wlmxSH9RDCmgMxx1oHy9ud/e03G2iJXFT/Ie1m9H4NbhCLlP8fcgVST
         oqPAG9Ed9idIizBx0Ot7/bhWxOK9AGM0m4lwaDLdHvYKIqCqJagwNWrbKSsc2b4Yfnos
         +c7EOjNP91ZA3QKuync1aJnwIZLembb6+mDuQ6W3WxW05HTrpCxbpT/m7sy1/OCc2l8J
         +OrXOrKAczf+8+NLIUwC2YX0+wigTHINk7gPQK83RFGdDY72NRAjSAtUBmfICyeX05wn
         eEgZIXFuWkiRYjaXIh86bRz48pMY+7Nk1LjaIQwiqzAkgbKtDMAYI+Tcq5U7UACKUOao
         3Z6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVWFWRvaeRvVRaJhLdf3iPWuGP+0Xf0xR+OR+AsSx4zPBp14cqP0j9ncG0wID2nqIIh2xmgYCGI96LYFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMqVZhx65Za0GL0eHx9oRM08T5U0N0kDNGJ+lCGgZwss1a1k6N
	uLojmEQ93ATAVliWXOrn5VbwsxPznrm15Hw8h1b9pTSei1JwL4i3DFCEjFc9TYn5427ezvY5iHX
	XCIcSeSaC3LaVVpjVJvsmMHp8eVPYUF1t5Btx
X-Gm-Gg: ASbGncuLsqVYFPp8ga8WaOrNq1Briiol/V8YPduefw6orcayyYm7S/cfK7hveCZAmXD
	X01A6JO2WUGHNLV5nqOoDxAVq1FZqKgTJg76hcw==
X-Google-Smtp-Source: AGHT+IEb8ceLkAOZST8OwjF14xilDtpsMHM4R5Cfaax8Aipk1tchxHW6ZcyJ1KL4yNAuuPq8HL4xbBOYM3ENgeKkYv4=
X-Received: by 2002:a05:622a:a09:b0:466:8c7c:3663 with SMTP id
 d75a77b69052e-467a5895ebemr3457691cf.5.1734111693572; Fri, 13 Dec 2024
 09:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111205506.3404479-4-surenb@google.com> <ZzLgZTH9v5io1Elx@casper.infradead.org>
 <CAJuCfpHpGSpix8+mB76Virb+HAMrOqB3wG8E4EXPrRCnBoBGeA@mail.gmail.com>
 <20241210223850.GA2484@noisy.programming.kicks-ass.net> <CAJuCfpETJZVFYwf+P=6FnY_6n8E7fQsKH6HrOV1Q_q9cFizEKw@mail.gmail.com>
 <20241211082541.GQ21636@noisy.programming.kicks-ass.net> <CAJuCfpEMYhAmOPwjGO+j1t+069MJZxUs1O1co-zJ4+vEeXCtng@mail.gmail.com>
 <CAJuCfpGOOcRAJ46sbPRoCUNuuhi2fnkM97F=CfZ1=_N5ZFUcLw@mail.gmail.com>
 <20241212091659.GU21636@noisy.programming.kicks-ass.net> <CAJuCfpHKFZ2Q1R1Knh-LFLUYcTX6CJuEsqNM5AwxRyDUAzdcVw@mail.gmail.com>
 <20241213092223.GB2484@noisy.programming.kicks-ass.net>
In-Reply-To: <20241213092223.GB2484@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 13 Dec 2024 09:41:22 -0800
Message-ID: <CAJuCfpFtH7K_fkQ9anW94SZr1Ltq8wxJkP0fkG-SHr_HWWCORQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: replace rw_semaphore with atomic_t in vma_lock
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, minchan@google.com, 
	jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com, 
	pasha.tatashin@soleen.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 1:22=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Dec 12, 2024 at 06:17:44AM -0800, Suren Baghdasaryan wrote:
> > On Thu, Dec 12, 2024 at 1:17=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Wed, Dec 11, 2024 at 07:01:16PM -0800, Suren Baghdasaryan wrote:
> > >
> > > > > > > I think your proposal should work. Let me try to code it and =
see if
> > > > > > > something breaks.
> > > >
> > > > Ok, I tried it out and things are a bit more complex:
> > > > 1. We should allow write-locking a detached VMA, IOW vma_start_writ=
e()
> > > > can be called when vm_refcnt is 0.
> > >
> > > This sounds dodgy, refcnt being zero basically means the object is de=
ad
> > > and you shouldn't be touching it no more. Where does this happen and
> > > why?
> > >
> > > Notably, it being 0 means it is no longer in the mas tree and can't b=
e
> > > found anymore.
> >
> > It happens when a newly created vma that was not yet attached
> > (vma->vm_refcnt =3D 0) is write-locked before being added into the vma
> > tree. For example:
> > mmap()
> >   mmap_write_lock()
> >   vma =3D vm_area_alloc() // vma->vm_refcnt =3D 0 (detached)
> >   //vma attributes are initialized
> >   vma_start_write() // write 0x8000 0001 into vma->vm_refcnt
> >   mas_store_gfp()
> >   vma_mark_attached()
> >   mmap_write_lock() // vma_end_write_all()
> >
> > In this scenario, we write-lock the VMA before adding it into the tree
> > to prevent readers (pagefaults) from using it until we drop the
> > mmap_write_lock().
>
> Ah, but you can do that by setting vma->vm_lock_seq and setting the ref
> to 1 before adding it (its not visible before adding anyway, so nobody
> cares).
>
> You'll note that the read thing checks both the msb (or other high bit
> depending on the actual type you're going with) *and* the seq. That is
> needed because we must not set the sequence number before all existing
> readers are drained, but since this is pre-add that is not a concern.

Yes, I realized that there is an interesting rule that help in this
case: vma_mark_attached() is called only on a newly created vma which
can't be found by anyone else or the vma is already locked, therefore
vma_start_write() can never race with vma_mark_attached(). Considering
that vma_mark_attached() is the only one that can raise vma->vm_refcnt
from 0, vma_start_write() can set vma->vm_lock_seq without modifying
vma->vm_refcnt at all if vma->vm_refcnt=3D=3D0.

>
> > > > 2. Adding 0x80000000 saturates refcnt, so I have to use a lower bit
> > > > 0x40000000 to denote writers.
> > >
> > > I'm confused, what? We're talking about atomic_t, right?
> >
> > I thought you suggested using refcount_t. According to
> > https://elixir.bootlin.com/linux/v6.13-rc2/source/include/linux/refcoun=
t.h#L22
> > valid values would be [0..0x7fff_ffff] and 0x80000000 is outside of
> > that range. What am I missing?
>
> I was talking about atomic_t :-), but yeah, maybe we can use refcount_t,
> but I hadn't initially considered that.

My current implementation is using refcount_t but I might have to
change that to atomic_t to handle vm_refcnt overflows in
vma_start_read().

>

