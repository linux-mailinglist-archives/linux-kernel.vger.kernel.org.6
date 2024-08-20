Return-Path: <linux-kernel+bounces-294015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6392D9587CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B02C284463
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB73190667;
	Tue, 20 Aug 2024 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hcR43R34"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CE618E77B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160175; cv=none; b=lcGWjL6L0uH1y+wCiUd2PV2FcQNDrG7P+yQIn6Vz2xjzKVpAsJcP9VrlNaREWJkU18R7GsIbk5IV7nOEr4xi5lg5VjaAdWeelr8WQxLMEBO3abkxr5BhT1ZfJ7Q85MSQ/CWiWcG0StLVyiNmf9MBQCmeg0QkPZJu6yDzRY6c5Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160175; c=relaxed/simple;
	bh=gWY6eEb5kQA622IuNwu2GxpBpJ4n3ZSXpMCxt8b6zNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eT+v6WDY2Wbmt/0qDAv2P83XvcvuLhsHQpSyfoSd0tkwfTr1tCJ4hlValld0CJIgFeIrG/R8MVp4V/qNRG8/DDuZ27fcJyLqocgVSJaZymPgIBSXFIZqHT909We5UaleF/IKYGjsH07Z/kbKhPQESZAWgcTl6IhfDWXVt+1hIRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hcR43R34; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7093c94435bso2056094a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724160173; x=1724764973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWY6eEb5kQA622IuNwu2GxpBpJ4n3ZSXpMCxt8b6zNM=;
        b=hcR43R34WRYojl3JKxHVHbXj0hHelYHmJZ9g7gpJjMii+dOAqvIXCIu8B0LDqNuKGO
         FJ8jINxwfp2hPmeWuQ/POntcihAbGjKFyKRSWMYGozfANNERg8cNrQBCuobRwfV1zAXJ
         b1Z8A/ZwD5g1WJdRIWOFMtS99fUrYVxS27ZLv3lmAxgDQEtId0a4GlZ3JYi0b5OrB5WD
         dg5y/+6UbtddVr6AVbqtb6a2d8ZSneFYZR2GPqzL52BxcC6zxSaFEug7zrVMmlXw0WkY
         x2qKlTzZ8J4HHLOM5IUuN2J3LWrziYS0QbTEe1kzgWiturJft1XwVnkBleGKfPrdFtTn
         tpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724160173; x=1724764973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWY6eEb5kQA622IuNwu2GxpBpJ4n3ZSXpMCxt8b6zNM=;
        b=Zb6OviM9QOjCSy0M4/1k7hWsgS36b4yaYfmAwyx2mUlynz3MXqi3hsJVoUIrSiiJPd
         hbgcy64MytCHYsomYcHCkvWXDp1fYBnn1CIlF1EJHz12EVjFodZldnQ6fB0REj6cdEaJ
         HYZWN/VrcC6fBY1s4wS9S6/+pIkT4FWQu/4l7fKPN3tVfOH5XC38Uixu+BCPAsD15jRj
         OSIkz5cGm1Sra389gKkmygQPbMvxOu+QdsobW7eD/mBU+vHjh8/5p96NRJ7LseWWD/mQ
         ZEVdrewzspnX35vRvbGHx2lES6ONxSdVuos+FEUDJcv2SZ6GAvcG2TqTu+4J9cw8H8TQ
         rKMg==
X-Forwarded-Encrypted: i=1; AJvYcCV6l8yCWD3ZPNZ783rBfP5NNdevXvPA51HDp+XsZ8K48UuvkC3IVO8s7oniuVkyvNVeSeKnjdRzqeY5gDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4FjQhx2F2vR1zR6nMZ6Dc4EJf8wNK6IOFBaIPdI4N77oMKpdg
	lqdCt3D+EKGuroui9F+4SMpYekyDyuOG6vfyTPrmXCjtx0fUv8bcMLq7PvfrTII5SApybdQg7j0
	AyzGSg4qeLoLW/CbKKLX9fcjFhTvQCQn9N9Uu
X-Google-Smtp-Source: AGHT+IEo+EPu/E8LXltAbMl1cUiNyPjkKyZAcLGG+ibPVJnZgD4HtnkqyMOufQ6wBdUbt1G5TRGFrPFKkL2ZQJ/X5QE=
X-Received: by 2002:a05:6830:d87:b0:709:4829:47bd with SMTP id
 46e09a7af769-70deec90226mr2702353a34.22.1724160172867; Tue, 20 Aug 2024
 06:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
 <8743264a-9700-4227-a556-5f931c720211@huawei.com> <e980d20f-ea8a-43e3-8d3f-179a269b5956@kernel.org>
 <CAOBf=musxZcjYNHjdD+MGp0y6epnNO5ryC6JgeAJbP6YQ+sVUA@mail.gmail.com>
 <ad84acd2-36ba-433c-bdf7-c16c0d992e1c@huawei.com> <190d5a15-d6bf-47d6-be86-991853b7b51d@arm.com>
 <5b0415ff-9bbe-4553-89d6-17d12fd44b47@huawei.com> <ae995d55-daa9-4060-85fa-31b4f725a17d@arm.com>
 <20240806135017.GG676757@ziepe.ca>
In-Reply-To: <20240806135017.GG676757@ziepe.ca>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 20 Aug 2024 09:22:39 -0400
Message-ID: <CAHS8izP-MWSFJi8zMW2P144-5p+KyWwNT2+UXBwSf=ocseQycQ@mail.gmail.com>
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at iommu_get_dma_domain+0xc/0x20
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Yonglong Liu <liuyonglong@huawei.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, ilias.apalodimas@linaro.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Duyck <alexander.duyck@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	"shenjian (K)" <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, joro@8bytes.org, 
	will@kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 9:50=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Tue, Aug 06, 2024 at 01:50:08PM +0100, Robin Murphy wrote:
> > On 06/08/2024 12:54 pm, Yunsheng Lin wrote:
> > > On 2024/8/5 20:53, Robin Murphy wrote:
> > > > > > >
> > > > > > > The page_pool bumps refcnt via get_device() + put_device() on=
 the DMA
> > > > > > > 'struct device', to avoid it going away, but I guess there is=
 also some
> > > > > > > IOMMU code that we need to make sure doesn't go away (until a=
ll inflight
> > > > > > > pages are returned) ???
> > > > >
> > > > > I guess the above is why thing went wrong here, the question is w=
hich
> > > > > IOMMU code need to be called here to stop them from going away.
> > > >
> > > > This looks like the wrong device is being passed to dma_unmap_page(=
) - if a device had an IOMMU DMA domain at the point when the DMA mapping w=
as create, then neither that domain nor its group can legitimately have dis=
appeared while that device still had a driver bound. Or if it *was* the rig=
ht device, but it's already had device_del() called on it, then you have a =
fundamental lifecycle problem - a device with no driver bound should not be=
 passed to the DMA API, much less a dead device that's already been removed=
 from its parent bus.
> > >
> > > Yes, the device *was* the right device, And it's already had device_d=
el()
> > > called on it.
> > > page_pool tries to call get_device() on the DMA 'struct device' to av=
oid the
> > > above lifecycle problem, it seems get_device() does not stop device_d=
el()
> > > from being called, and that is where we have the problem here:
> > > https://elixir.bootlin.com/linux/v6.11-rc2/source/net/core/page_pool.=
c#L269
> > >
> > > The above happens because driver with page_pool support may hand over
> > > page still with dma mapping to network stack and try to reuse that pa=
ge
> > > after network stack is done with it and passes it back to page_pool t=
o avoid
> > > the penalty of dma mapping/unmapping. With all the caching in the net=
work
> > > stack, some pages may be held in the network stack without returning =
to the
> > > page_pool soon enough, and with VF disable causing the driver unbound=
, the
> > > page_pool does not stop the driver from doing it's unbounding work, i=
nstead
> > > page_pool uses workqueue to check if there is some pages coming back =
from the
> > > network stack periodically, if there is any, it will do the dma unmma=
pping
> > > related cleanup work.
> >
> > OK, that sounds like a more insidious problem - it's not just IOMMU stu=
ff,
> > in general the page pool should not be holding and using the device poi=
nter
> > after the device has already been destroyed. Even without an IOMMU,
> > attempting DMA unmaps after the driver has already unbound may leak
> > resources or at worst corrupt memory. Fundamentally, the page pool code
> > cannot allow DMA mappings to outlive the driver they belong to.
>
> +1
>
> There is more that gets broken here if these basic driver model rules
> are not followed!
>
> netdev must fix this by waiting during driver remove until all this DMA
> activity is finished somehow.
>
>

Sorry if naive question, but why don't non-pp drivers run into this
issue? On driver unload, GVE seems to loop over the pages in its rx
queues, and calls gve_free_page_dqo, which simply subtracts the bias
refcount, dma_unmap_page(), and put_page(). The pages will live on if
they have references in the net stack, but the driver is free to
unload.

Is it for some reason not feasible for the page_pool to release the
pages on driver unload and destroy itself, rather than have to stick
around until all pending pages have been returned from the net stack?

--=20
Thanks,
Mina

