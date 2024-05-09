Return-Path: <linux-kernel+bounces-174773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BB58C14CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46251C20BC0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179FD73535;
	Thu,  9 May 2024 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w/wAx8uQ"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79761A2C35
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715279573; cv=none; b=GR1IH8l/obwUQCBCzV1RWh66QjXr6iahvH/FHh/+p/10RkBKv1bxbRPA3kubgxmLJRenWo+ln98U0Kdja0HpQyajnfJ+qPW2btpX7IGxDfkJYt85WLx2qpjgyt2YxlWVVgCcq1HUz9l54veAiRkWpP0334lii+Q2lddUY7mRwFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715279573; c=relaxed/simple;
	bh=JpQJVTrL89+adP7TCtxgEVivnuWjp3XuE1s1dwjRF0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyBGMST+5VmpzWlsVGGr1JDx119phl2OfgO2HOodDQmrLW0caNsxf156HRwR43CuQ6hUGF6J42rXkfAbBs/QqtsSDpVXZyaqO1P6JBBseJvsps3M5/bMEvdX8FmXHk1olPRyl2EjuEbmDcMB8I2wNBdNbWjTN6ojnbrIj5GJ16o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w/wAx8uQ; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de610800da0so1115682276.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 11:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715279571; x=1715884371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K85R4aKMySjln2h5zunsCFNfpJdcOEMgD33+b72i2sA=;
        b=w/wAx8uQUCx5fayeWsg7yiNAUgXEoOteNQZRdKXThJy7Uiu8XVfKb5VMsGa46E3SKa
         NtIgu4OL78cvi5Of3uEt/bu+SANaJcPbYUTVQ223vBIDNprrPQVt9pIrEW+KWlq4rf5o
         ApnErzjSXj4E9Zyz2tnCRjlQu60zfzHV4QIJNc94cy2QWVPuIoAPC6XOIRb9nOkefnks
         uWSnB09KPEIV2MtzuhoRDYxBRe6KE3lpAcA1GJQ+AdaNI94DTw9ydDo5wVmQH9dkjcTX
         yV9foEXNsCldyE8EUfTEglWfi3DOINfWsCzpUqME9Fhv39rKm0kBwynsLqkmsFbpGJMi
         NZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715279571; x=1715884371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K85R4aKMySjln2h5zunsCFNfpJdcOEMgD33+b72i2sA=;
        b=LFFB4e5ucA6AGE8IhNIJZbe3CUBl6fnsebFcPzn+ww21XsjdO9TuzxI3XedpjM+S97
         pKLYTOEGS9Ck0ql3Lsr/407fa4WGouxspIQlgoS94r7l7U1GKr3QE7EWpOPhC2TwUbZc
         tK/x0zC1V/M5EHgBQBGcmp5YxCwMPxAwoAGi71IhnkPJrctJsJfUWs5WmyD9OiaQSBml
         Je2RO2sCPcaIMBoGheGzyf7vAo9eyuvmlxOgT9YqKEFLL4bLJkAysEh8JoZ5nh5Sk9Rw
         uZ2au+xu3y4/GcwCr9W5Qr5heAIKfQNWpsIA6BdN2bTYuvlAc1TVpCfS9+zEVkLFaeDq
         Z6TA==
X-Forwarded-Encrypted: i=1; AJvYcCVJjPIjV7uz1PujgaHvg1QJ93fVp/Ozqm1lSZjzsAHzqA4GVTvfC7xPjiTWAy9EQM7qu9DOuGSqmsA/ojt4yJ/owbXIFUCoaZ/jknKN
X-Gm-Message-State: AOJu0YzG0Bc7+MRcq59m2aSTXv4T5uVmbRwpr6bNhai1h5GS6U7LK8/x
	mZgQC+DuQKz3oOVQqs5DIDvnGxw+RlYCR9QFAeeZpx8SAzmmObK46EeUDMqDMRL+8ne6kmhb7t9
	vVN8p5yHLY+Zwm4C2gS2kSM0DHEV2ghMcYggU
X-Google-Smtp-Source: AGHT+IGoQ2OQpf2a8CpZ5SCSZQupeF8o9KNIqCdhZ/BNEQqydxmcWTO4hvBdvCBICJBUvCrXjuuGbdZWLIdfO05cRUc=
X-Received: by 2002:a25:d0d4:0:b0:dd1:491e:bf0 with SMTP id
 3f1490d57ef6-dee4f37dbe6mr351885276.60.1715279570531; Thu, 09 May 2024
 11:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com>
 <20240506160244.GA16248@lst.de> <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com>
 <20240506161906.GA17237@lst.de> <CABdmKX3s_HnxciDA3XGM8Qj0kLY8OWENg+ifexrON4VYVbuLsA@mail.gmail.com>
 <20240507054314.GA31814@lst.de> <CABdmKX3PgcXaRUH3L7OV+POMiMd5L6pEF4fLXYPgfmQUNu_trg@mail.gmail.com>
 <Zju0JOx_ij1qH-34@arm.com> <CABdmKX3LANk-0ThrQ86ay5EnToM38gVH3oddBUnXq=9cmS0gCQ@mail.gmail.com>
 <ZjyAFE4Fk_r7KnDA@arm.com> <20240509130659.GA12345@lst.de>
In-Reply-To: <20240509130659.GA12345@lst.de>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 9 May 2024 11:32:38 -0700
Message-ID: <CABdmKX0KRA3NHiEJYsq5LqtwwEdM4LaONpyukd6zgk7hHzp3Cg@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
To: Christoph Hellwig <hch@lst.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, isaacmanjarres@google.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 6:07=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Thu, May 09, 2024 at 08:49:40AM +0100, Catalin Marinas wrote:
> > I see the swiotlb use as some internal detail of the DMA API
> > implementation that should not leak outside this framework.
>
> And that's what it is.
>
> > I think we should prevent bouncing if DMA_ATTR_SKIP_CPU_SYNC is passed.
> > However, this is not sufficient with a proper use of the DMA API since
> > the first dma_map_*() without this attribute can still do the bouncing.
> > IMHO what we need is a DMA_ATTR_NO_BOUNCE or DMA_ATTR_SHARED that will
> > be used on the first map and potentially on subsequent calls in
> > combination with DMA_ATTR_SKIP_CPU_SYNC (though we could use the latter
> > to imply "shared"). The downside is that mapping may fail if the
> > coherent mask is too narrow.
>
> We have two big problems here that kinda interact:
>
>  1) DMA_ATTR_SKIP_CPU_SYNC is just a horrible API.  It exposes an
>     implementation detail instead of dealing with use cases.
>     The original one IIRC was to deal with networking receive
>     buffers that are often only partially filled and the networking
>     folks wanted to avoid the overhead for doing the cache operations
>     for the rest.  It kinda works for that but already gets iffy
>     when swiotlb is involved.  The other abuses of the flag just
>     went downhill form there.
>
>  2) the model of dma mapping a single chunk of memory to multiple
>     devices is not really well accounted for in the DMA API.
>
> So for two we need a memory allocator that can take the constraints
> of multiple devices into account, and probably a way to fail a
> dma-buf attach when the importer can't address the memory.
> We also then need to come up with a memory ownership / cache
> maintenance protocol that works for this use case.

Being able to fail the attach without necessarily performing any
mapping yet would be an improvement. However I think the original idea
was for dmabuf exporters to perform the constraint solving (if
possible) as attachments get added and then finally allocate however
is best when the buffer is first mapped. But as far as I know there
are no exporters that currently do this. Instead I think the problem
is currently being avoided by using custom exporters for particular
sets of usecases that are known to work on a given system. This
swiotlb + uncached example is one reason we'd want to fail the
constraint solving. The DMA API knows about the swiotlb part but not
really about the uncached part.

