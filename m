Return-Path: <linux-kernel+bounces-407938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B8E9C779F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09138281BB8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D61884D13;
	Wed, 13 Nov 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tF0iuYO0"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F318070833
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512876; cv=none; b=YW/Qx2HQKWAlmRA7IOJI8D9GIyMMW6qpQDfIKTN2EJvY6CiGp4YL54CSq1Ag6qVfAQSFOrw8xXsIxl1cvjPpdAW4VcDopBafW24Plw7TYT0HqQQtf2Dpfcl7qws9ZjRFhB/vlE6qeLuIG3QuYpwHqsY8HAcVsR83ZnV3cQjFknM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512876; c=relaxed/simple;
	bh=aZanYtoH2JtS2g8af3PpzbKTAzHp5hOKXOITzZ2ZP+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bwi/3ulBC3SXQkQpTn/loT7FWTU+E8h1RL0e8jRfXDdOZlDT6OmtUqXwBQ9hyZX4BjcBKbwSu3XW5tcBtNBxTnfs8RrncHDic6f6ZwtszqwAIIUaRS6Uy23IfJMQP4uy71aeDsZfqxSQADZp9pSkv64wTbykh5C+2J04KJp587s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tF0iuYO0; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460a8d1a9b7so261771cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731512873; x=1732117673; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIGBOTsMnscnNMh+xLfadwOTEgGK5dsWKgIHabjBrcw=;
        b=tF0iuYO0lP3DVodr6nfs7boeB7Fn0FrHwjHKz8TM/t2yavPjCeGA18+cHyPgvrRjA3
         9PFQCWm5kFMqLuGm44tSKgxnBslZWhxebkDr9VvCMecV8adX2gzRF8+nYKKuUV28n0nz
         Nj0cS7TAzSqGW626xfnPLaX1rZpP5dhCMlYNx03wPaLRzU5L15LsrXjoOYOcm8BZoUJc
         1qZMx56Mra8PXXk8b7oHmQloRceJ8oZGu+7K9cRV20dM6QyqhV2xJghtFmAaemD1A4xl
         1CZZCDRLM6ltbuy8Y5kZtpxqtE6U+jXMdn7eUzDrEUuDMLUl4f2Nha94lhcIdPzzjqJO
         Nf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731512873; x=1732117673;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIGBOTsMnscnNMh+xLfadwOTEgGK5dsWKgIHabjBrcw=;
        b=DDhuv0HtAu++ngc31YEM98pSHstyjSQdpkCe2ea6CeDpcwRC8DCviIwTe68Yt2fVL/
         hZbwd/3oZOf52f4LaIw/wjSR1v0sftphT0sNfMJL5vT3rjdepMu9vJxCiEDeZhTRZUqx
         aySv4e0aQMWG4tHGELNQa6YE1GVj8X2y+JImnsafr3T7Qy/4yF9PYOlnEkY3TrbCj0z/
         gWV2KDk3z/uMfMLpudgbLIF5Z6X51zzRf0spVBFUh50aqzpK5S0j+Q8G7wo9YbWaekN9
         rSapEyxpfrsjMAD552XROpKntpSmSEK5hLbGr418hliVLWduRteS/mqsYq4wr6HyMrXH
         fBsA==
X-Forwarded-Encrypted: i=1; AJvYcCXMNcmhoDbt8UeDA8GavXkURNaLUjP1neSGpOfITYvCaJ7uQTKEqWx3iTXx7q5iapFXPoFLjtoKIQXk/98=@vger.kernel.org
X-Gm-Message-State: AOJu0YziimKBGm1R5TqB5RCcUVlJbC68kME8U7iPBHgwoXCofwaJ/v2A
	iVhWitRVMMzOZenD2rvSfZ1wI10HuqBHw+3jToVtTraeNPjA0uiS5jffQVMMtoeOiE7iKzh2zPE
	aDNUwj18d8aBs/A05vB1DuZ6AXf+thm3CAAvX
X-Gm-Gg: ASbGnct0UMBvp5l9VLdGQ/UJi6q6GZ+fNBe4vp5dvZVcLYR9FqcbVUzLDPWPhcpLroU
	UwaDjg9uLyoRnN16nrnaPWIxhh22QD1k=
X-Google-Smtp-Source: AGHT+IHsSjvVs37dTOPQ3ErUpR9I/gQJNeIrUh7ZMqQExz8MALQ2x9yDJvhWkgfyU4Kq0PkEtMwp2O/D/tQ8ohR1+N8=
X-Received: by 2002:ac8:5915:0:b0:462:ffaa:938d with SMTP id
 d75a77b69052e-4634bbeba0emr3417911cf.10.1731512872451; Wed, 13 Nov 2024
 07:47:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112194635.444146-1-surenb@google.com> <20241112194635.444146-5-surenb@google.com>
 <54b8d0b9-a1c7-4c1b-a588-2e5308a977fb@suse.cz> <sdfh56itaffzhpk4rft2tsjm7r44auhjomfthzgxzrmj5632eq@noi2uhgp3a3h>
 <ZzSwM5qwStadOZvv@casper.infradead.org> <k26pa6fhn2j6bgfwtcdp6u5vk25mkclitzvqqeqvji77k4lqop@yowwrqusmdyp>
 <CAJuCfpHjuMWCzeONq2YOOkr1JGH=E=xn=BAcjQyo_=P1cz=crA@mail.gmail.com> <aa4i3inhnkyi6yazttb55khbm7swt7xq2sklmhp5y63kxw7bsc@i4wlyyzoo7h3>
In-Reply-To: <aa4i3inhnkyi6yazttb55khbm7swt7xq2sklmhp5y63kxw7bsc@i4wlyyzoo7h3>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 13 Nov 2024 07:47:41 -0800
Message-ID: <CAJuCfpF_fEVwyDAStueNoEW=MNS5MoLPc1RaQMaOHZxODmw_0A@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, hannes@cmpxchg.org, 
	mjguzik@gmail.com, oliver.sang@intel.com, mgorman@techsingularity.net, 
	david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, 
	paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, 
	hughd@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 7:29=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [241113 10:25]:
> > On Wed, Nov 13, 2024 at 7:23=E2=80=AFAM 'Liam R. Howlett' via kernel-te=
am
> > <kernel-team@android.com> wrote:
> > >
> > > * Matthew Wilcox <willy@infradead.org> [241113 08:57]:
> > > > On Wed, Nov 13, 2024 at 07:38:02AM -0500, Liam R. Howlett wrote:
> > > > > > Hi, I was wondering if we actually need the detached flag. Coul=
dn't
> > > > > > "detached" simply mean vma->vm_mm =3D=3D NULL and we save 4 byt=
es? Do we ever
> > > > > > need a vma that's detached but still has a mm pointer? I'd hope=
 the places
> > > > > > that set detached to false have the mm pointer around so it's n=
ot inconvenient.
> > > > >
> > > > > I think the gate vmas ruin this plan.
> > > >
> > > > But the gate VMAs aren't to be found in the VMA tree.  Used to be t=
hat
> > > > was because the VMA tree was the injective RB tree and so VMAs coul=
d
> > > > only be in one tree at a time.  We could change that now!
> > >
> > > \o/
> > >
> > > >
> > > > Anyway, we could use (void *)1 instead of NULL to indicate a "detac=
hed"
> > > > VMA if we need to distinguish between a detached VMA and a gate VMA=
.
> > >
> > > I was thinking a pointer to itself vma->vm_mm =3D vma, then a check f=
or
> > > this, instead of null like we do today.
> >
> > The motivation for having a separate detached flag was that vma->vm_mm
> > is used when read/write locking the vma, so it has to stay valid even
> > when vma gets detached. Maybe we can be more cautious in
> > vma_start_read()/vma_start_write() about it but I don't recall if
> > those were the only places that was an issue.
>
> We have the mm form the callers though, so it could be passed in?

Let me try and see if something else blows up. When I was implementing
per-vma locks I thought about using vma->vm_mm to indicate detached
state but there were some issues that caused me reconsider.

>
> >
> > >
> > > Either way, we should make it a function so it's easier to reuse for
> > > whatever we need in the future, wdyt?
> > >
> > > To unsubscribe from this group and stop receiving emails from it, sen=
d an email to kernel-team+unsubscribe@android.com.
> > >

