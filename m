Return-Path: <linux-kernel+bounces-170182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DBB8BD2F7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25D51C21045
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF61B156962;
	Mon,  6 May 2024 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Wk400gV"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E624C25569
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013608; cv=none; b=Sg4tycrdtv8FCPim738Pr95AiEU7rVD9qADkhHH0Wi35SZX+OOcm0cktRpGsY5ompQIWqccwDMBCVZzJLnHk/nW4exNYFfRzA4h84IwwpyV4meFrHRxn1AhCOrAR8Zv/05OjAeAT64ktrgy0r9H+2TotRk0CxT/pWpr5m/SyZ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013608; c=relaxed/simple;
	bh=mbCxyUl0xXnMrCeHULBRH3fDeDz5G+xM5ZK97knxOjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofJI7MDpHcavZUNavnVhYkrvQPVz+sk4jL70ElE4YWWGoPQQKz3bMi7qcn/aoigGxUB5fqbINl6efwZ4054V0o7x2FEEzb4BhC+mGghVcpYA+lSEZU2V7eP+ODlTl2WM4pg+4JFh557PDV+ZTjrJx12LHqlyMlvNRhh+eeYxR4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Wk400gV; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc71031680so2202491276.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 09:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715013606; x=1715618406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbCxyUl0xXnMrCeHULBRH3fDeDz5G+xM5ZK97knxOjE=;
        b=2Wk400gVLHv1uH1+oNzd/L5K9GJxlua1f9bGeziUL8iTcDdvMIN8B7NC4cZBTop1rZ
         zYVRKOkpTGR84qdRXgUUcaCcdXsq4tNYgRRFSsdzKQ9uw9CKzjviGTRm1gZ1OgqwGOkr
         QY1+CC4eg27bDDREgl0mNUrbHE043/4uncFUDvoY52QoCCdOw2y1B49tsxckkb6+aCpo
         Al6/UD3G7/8UdYQITwgr6jyhLSp3+MQA/GVInrF3zeO2hKMtulP+1dcbGj1CCtF0rYCM
         3vlp/lgAaTeAM6maK9LNY+JENU/UxjSIGa4rxCQ4pammKgYe2mIlvWMj3PYTAMzRlkzp
         /gkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715013606; x=1715618406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbCxyUl0xXnMrCeHULBRH3fDeDz5G+xM5ZK97knxOjE=;
        b=GA4acYPxTl1rDJq1ASOIrFZXz+l6GRay49M7KLFkF54o92BKlLre0CZf1P3dwmm37P
         MEF/Ij50lVgYbVhgRJYxiGXuJZg0/uZ+Qf3aXAkCCXOjuJ9Qyt02MzgPAdVuTfPVjG8M
         au6meHjcStruhyYKqIRlF0gIoLjA8FywkNXtJbbCko88nOzT5Am8mup7/g+miRVBy7VQ
         sz2DLrakO167Ar66FQiI5sUn01gOdWgmxF6m8RnJVN7j1pBnwVC5TkTgHmQOs2QwT5+1
         fO93uFtO0jUvBoXWcCT9cFRewwjdklD3H0GfaQnPFt69b1vLJW3fRUsPJ/C98Da6Vh0a
         M50Q==
X-Forwarded-Encrypted: i=1; AJvYcCXq5IAzYNoqjog3aX+4tPZbjL/Pn4C8gsBPDKzKlKhcbuxS7tAHKwpBS7wZ40TpIibHVxW4fCQiAWUlxhOWpH1RI+JnOEEnsNRBKnhr
X-Gm-Message-State: AOJu0YzZsEdccnFlfRksJfitXUtg59r43RE8bScL/wYXEJLOcBcpJ/t9
	GcXYUMqcvbLIgN4N40o7XYTme244RuF8gbJp+RmG/MdXJ2X4P4IplhQcZ/mUT2BfHxT3bMuvClN
	qCxIYTwVZVg6agvND4DVBGtMwvDvSMV69b5Ey
X-Google-Smtp-Source: AGHT+IFBxsahP+oE3FuwfOQp/ah0jhdGLJrVrWFUoON5+ivb9iKV65nJPRyw2KFaPamsQmlgz3oHokti0ORvDc2XNIE=
X-Received: by 2002:a05:6902:2085:b0:de5:9c4b:dd5c with SMTP id
 di5-20020a056902208500b00de59c4bdd5cmr12126324ybb.23.1715013605681; Mon, 06
 May 2024 09:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503183713.1557480-1-tjmercier@google.com>
 <20240506052955.GA4923@lst.de> <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com>
 <20240506160244.GA16248@lst.de> <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com>
 <20240506161906.GA17237@lst.de>
In-Reply-To: <20240506161906.GA17237@lst.de>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 6 May 2024 09:39:53 -0700
Message-ID: <CABdmKX3s_HnxciDA3XGM8Qj0kLY8OWENg+ifexrON4VYVbuLsA@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	isaacmanjarres@google.com, Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 9:19=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Mon, May 06, 2024 at 09:10:40AM -0700, T.J. Mercier wrote:
> > I want to reject mapping a dma_buf for a device if any of the pages
> > that back the buffer require SWIOTLB. AFAICT there's no way to know
> > whether SWIOTLB is used until after calling dma_map_sg, so afterwards
> > I'm trying to check.
>
> You should not check, you simply must handle it by doing the proper
> DMA API based ownership management.

That doesn't really work for uncached buffers. Since the SWIOTLB
bounces are in the sync functions, and avoiding CMO is the point of
uncached buffers, it doesn't make sense to try to map uncached buffers
that would require SWIOTLB. So unless we can get the DMA API to fail
the map in this case (look for DMA_ATTR_SKIP_CPU_SYNC + SWIOTLB?) I'm
not sure how else this should be done.

