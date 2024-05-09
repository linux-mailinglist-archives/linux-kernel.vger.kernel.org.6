Return-Path: <linux-kernel+bounces-174768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C058C14B6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F343BB2134B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545C07711F;
	Thu,  9 May 2024 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AeYJYpEw"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815E177119
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715279198; cv=none; b=FQrwwvDIMGmNmcGsTFLbSe4w8ct7tmhHOoOJF0TjtVWPtJV6lC97N3YwD2a/JL4GByazzl8uN1X0wxV7H0uVqa2EWmOXjkGO99maChY/t9PcnYZVu4Z4Kk1vLZgdUcNnfzM9EuNawauNm7phqLbmyDjLq3XaCQDrFGfDFxohebU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715279198; c=relaxed/simple;
	bh=xwX3FrShlsU2ZVlrICD/J+sXBJpXcixYuE8iS1XPi3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fq9LO6xoR17s15XNRK5w+Rm6XaDxPELYcK+0DG8iE+vd25NMnwqWRen8FUwvhCFpeiFpjlVXPejQKEVS4Uq/dZQnG0tUzrZrfw9owvOGbLHAvueKkk4wzwgfZmn+P6kr7Onl7vtCIjBAFrcNcK2rDsx+Xy+eW/qfRQ9jHDloOu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AeYJYpEw; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de6074a464aso1333955276.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 11:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715279194; x=1715883994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwX3FrShlsU2ZVlrICD/J+sXBJpXcixYuE8iS1XPi3A=;
        b=AeYJYpEwMWYr9voChMswp7B5b4DV/0KtoRHH7cFMLmVpKVKd10WViRW91IyqRaB/hV
         m3xEesYF6doAQVz52Z9DdqlHGNKIFAZScDbazrKDlkBB94YvizE7j5GQ73rKh3pEGRtC
         VQypk7xKJkPXarIvrWtwm+zVSl5Es9t2Z4bUvu5GS/Hou+5QLkbpGxBl6w8JdL8UdASi
         y27BiVn/L9xNdi+YsdtU6VEZSdDXWDTzSTT2J7JippeGzg883k0C3kkxplLygDodx65v
         xjrQxuoSN3n4l6fUSZ7WLIj3meTn4EvEjKOFlYpHTadxhGDYNn7mHga96759N67qxghl
         Zn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715279194; x=1715883994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwX3FrShlsU2ZVlrICD/J+sXBJpXcixYuE8iS1XPi3A=;
        b=RHU6aapyePvd99r/8OApHC1WHn8Nt3vdZ+oXuNLoGR2AGir0ZZDstOVDcJgu3Gknh9
         gZwuc+9W4ND0BzCH4j5T88HP1q7oXIFvQsZOcLxt0PeUpYJRdhIMcxPKqBG7PYM3CfaR
         wcU2UZxtZRPQc54JzTvcsyKktc3eyCNIxlTPKjywpAxwcUFk7kCZbr1ijZnZlfCb4vSc
         03Gwaa6lpay10TPSz2+x+wnXHwmfRhftuFIMrWIiOVSvFhCz/fasWdHMtipciRfKjBAv
         7GD95ilXxEr7DHrHxwd5JT/oC6WTlyF6NcA06l92tnG36BfO6axKRDCzYrhDZXg2T8kL
         KCSA==
X-Forwarded-Encrypted: i=1; AJvYcCUeKj/fAh1CnBjF6wHd4vRi8nTdJ6k2IynINLcpp9GpTrREjtC61FxhFyZxO3xDEclAt7lcylFi7gZcqTxFTauiIWfyadDJWvbzzDfz
X-Gm-Message-State: AOJu0YwAIsYR7+aA0geLjZUd2NGzTKoyDPD3qrllrDNnA03QYPCaW0Jr
	npMtsolUB0n0GO8si2Omhc1LJ94DoPG7aVylEEPwKPzIMzM+bGWxH+6tvVEwkloWaC/WYeDqS61
	qgBSlvm4+1UoKBXT9OmCuUcM2nA6wKZ7X7gBu
X-Google-Smtp-Source: AGHT+IEiZ1AeAFP07cQfFLqCtp+USGarpkp9LhLIX8R6emdm/gHL5dC+45h2LERG7LJDGyUSxdi3GUC42AecvGl5Q4w=
X-Received: by 2002:a5b:c07:0:b0:de4:5c94:f58f with SMTP id
 3f1490d57ef6-dee4f2ce881mr370778276.15.1715279194343; Thu, 09 May 2024
 11:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503183713.1557480-1-tjmercier@google.com>
 <20240506052955.GA4923@lst.de> <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com>
 <20240506160244.GA16248@lst.de> <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com>
 <20240506161906.GA17237@lst.de> <CABdmKX3s_HnxciDA3XGM8Qj0kLY8OWENg+ifexrON4VYVbuLsA@mail.gmail.com>
 <20240507054314.GA31814@lst.de> <CABdmKX3PgcXaRUH3L7OV+POMiMd5L6pEF4fLXYPgfmQUNu_trg@mail.gmail.com>
 <20240508113353.GA31529@lst.de> <1be83f24-15bd-43a4-b310-f62c720cf064@arm.com>
In-Reply-To: <1be83f24-15bd-43a4-b310-f62c720cf064@arm.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 9 May 2024 11:26:22 -0700
Message-ID: <CABdmKX0E97V+MGs-SZOqxA1EU4NmmP4ZyVeoskGMLD6=qYcSDg@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, isaacmanjarres@google.com, 
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 5:55=E2=80=AFAM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 08/05/2024 12:33 pm, Christoph Hellwig wrote:
> > On Tue, May 07, 2024 at 01:07:25PM -0700, T.J. Mercier wrote:
> >> On Mon, May 6, 2024 at 10:43???PM Christoph Hellwig <hch@lst.de> wrote=
:
> >>>
> >>> On Mon, May 06, 2024 at 09:39:53AM -0700, T.J. Mercier wrote:
> >>>>> You should not check, you simply must handle it by doing the proper
> >>>>> DMA API based ownership management.
> >>>>
> >>>> That doesn't really work for uncached buffers.
> >>>
> >>> What uncached buffers?
> >>
> >> For example these ones:
> >> https://android.googlesource.com/kernel/common/+/refs/heads/android-ma=
inline/drivers/dma-buf/heaps/system_heap.c#141
> >
> > Whatever that code is doing is probably not upstream because it's too
> > broken to live.
>
> Indeed, at a glance it appears to be trying to reinvent
> dma_alloc_noncontiguous(). What's not immediately obvious is whether
> it's particular about allocations being DMA-contiguous; if not then I
> think it comes down to the same thing as vb2-dma-sg and the ideas we
> were tossing around for that[1].

This heap isn't too picky about the memory being contiguous, but there
is an attempt to allocate high order pages if possible to reduce the
number of translation entries. These page orders are one thing vendors
sometimes change for the hardware they have.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/dma-buf/heaps/system_heap.c#n48

I think one problem there'd be attempting to use
dma_alloc_noncontiguous for dmabuf exporters is that memory is
typically (always?) allocated when the buffer is exported, and there
won't be any device attachments at that time.


> Thanks,
> Robin.
>
> [1]
> https://lore.kernel.org/linux-media/20231228074645.765yytb2a7hvz7ti@chrom=
ium.org/

