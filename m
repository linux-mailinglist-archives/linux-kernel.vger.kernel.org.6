Return-Path: <linux-kernel+bounces-170126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 269018BD22A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2AF1F2314B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0093155A57;
	Mon,  6 May 2024 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P0Vi149W"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35651DFE1
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011854; cv=none; b=NVIR1p4egAVpJOwJiUg9T/1VTjWOyXHvp6OL06m9q3v7SBGtzi0KDAbpUkQudrwZNrg8/3e/tMgk6qxiuMl9/Vvpx/HDRAb+6npsafQisvoVGH526FWIhIdrL4q7PPcG/jZOiXfHMAt4oVn+/5tBJp7Mo17WGlov8KotPxS02zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011854; c=relaxed/simple;
	bh=yo0nITJjRLWahgSa48uioCkDwC6+fwDal7OzgmHRdnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jv5U92rCV7iBOA9UBeodlf9k2sbkcorT5Ldn0m1se8r9jdNNNXD9gcAcXhocsnu1ubYIP+ssxPlSVW9i7+DZ+xmNSz/v7ZhscsyfAK8ztHPGC1J3xxMOBo5Rc5laJ9lQQWBF+r6ob9OvkvjEBPcbfWuclTIc0MIohGwhHzpxIvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P0Vi149W; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-de45dba157cso1627666276.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 09:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715011852; x=1715616652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZdW7T7aub3HEQGqdk4tAKNjulXPSd/s5jyMU+52RF8=;
        b=P0Vi149Wi0px6jBmNRj+7RnBJwB9YbSBBmeek0jCf3WT1FLxY56eINOEfx0fCaXDr+
         HJBRYwfHTwq2HMOxpWaIZg06rf5J6hyOPFyBvrekZWtwLhj0C5CHHi+tLGueCNrnOYPR
         BmPN8nITbFt6aQ98KSXcmSDJTF1v2nMXapWWYhpzKsI56sbUYQJetyePrtwlLAnpDI6o
         Bldsuw7Vy63e6wTNt28abEbTDG5wG7JFJQLh8Or9fMLR5U91Ze4UFua2ZMClgUBM5wja
         lb2ytHoqL0nMD44dbziIBwy70qNpI3+AtEW8xiwEpxoEO9u9/Ss5xHN9EsV4AH9/fi5f
         P34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715011852; x=1715616652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZdW7T7aub3HEQGqdk4tAKNjulXPSd/s5jyMU+52RF8=;
        b=URuFFtzX7zUOCmb707w6s/Fsu8ki+MKvtjUss0Qvzwt2zDESLXbP23zOfwsOZR9nWC
         piYAokiTtAkQpLGJceikOuZteU+ALU0E69EY0yafkcCcbrYQBx2peGbfsqO50907K6hl
         7hiFoa6tRsp9M8iWS2Wdy02uVtSHMqIomCXgBFZKGQg2mYGdkx8haGXFYFtSltLQN7HC
         r3XyDewmVYEBArdF0hgslSLMwbnMejpOCe0XW+AZhOO+0X3HsrdoL3vwj9zYmsBqZMLR
         ExJyo/tLfeA+61M6URVOsxjSJGjFkBKN7lzUWnNy5kwlDhsdQcAssBZYXfMBDI5IJVpx
         JyEg==
X-Forwarded-Encrypted: i=1; AJvYcCWrbL1tZGJ7Ln3Zk2t3EUvfKQnnvNWZR5zCOkic79eBYp7ivnxiNT+0GB/swnrb4iL+cHrv36PW9odCsYQjOdEyoLeeZQLSRI26XHbX
X-Gm-Message-State: AOJu0Yx8Pu04CpVePHNd+I0oSKjgGzbvYVW3AoEWV8rzvHbZoQeOyGfP
	4N7jJddSJoVkMxjLDBNysC5O5k8PWnaSeG0yGKJGvJb11DMejtza+cWjTIH0bC3srcuVZQvOEuX
	gJv9oJu2yLpV2LZYkfg4IliIm3MXnhsErO6mW
X-Google-Smtp-Source: AGHT+IH8jnlh3YhBo9wAl/F96iqiRp8ETCI/ORncWjUCqbkz6bq8Nss/cI5z2ygcutWvZS2K3UNSgRNsHBT1vx2KzG8=
X-Received: by 2002:a05:6902:2743:b0:de5:1f5f:3682 with SMTP id
 ea3-20020a056902274300b00de51f5f3682mr12555260ybb.30.1715011851402; Mon, 06
 May 2024 09:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503183713.1557480-1-tjmercier@google.com>
 <20240506052955.GA4923@lst.de> <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com>
 <20240506160244.GA16248@lst.de>
In-Reply-To: <20240506160244.GA16248@lst.de>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 6 May 2024 09:10:40 -0700
Message-ID: <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	isaacmanjarres@google.com, Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 9:02=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Mon, May 06, 2024 at 09:00:59AM -0700, T.J. Mercier wrote:
> > Oh, that's disappointing. I'm looking for a way to quickly check if
> > any addresses point at a SWIOTLB buffer without doing a potentially
> > expensive call to iommu_iova_to_phys. Since it's meant to be dma-iommu
> > only I guess I could use sg_dma_is_swiotlb if iommu_get_domain_for_dev
> > returns a domain, and is_swiotlb_buffer otherwise for dma-direct, but
> > it'd be nice to have just one way to check which it looked like the
> > SG_DMA_SWIOTLB flag could be used for.
>
> This sounds like you're trying to do that from a consumer of the
> DMA API, which is simply wrong.  What is the actual problem you are
> trying to solve?

I want to reject mapping a dma_buf for a device if any of the pages
that back the buffer require SWIOTLB. AFAICT there's no way to know
whether SWIOTLB is used until after calling dma_map_sg, so afterwards
I'm trying to check.

