Return-Path: <linux-kernel+bounces-546258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BE9A4F87C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4882716D971
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2490D1F4CAD;
	Wed,  5 Mar 2025 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eWgeGFu/"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8421EDA0E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162376; cv=none; b=R1YPT/vynIIzfV0/rDmf0OkSFIV+H1oOCBwZiyyH0ktw++F6KJcI8i74Tcwp7eZ8+le47zAIg6utzSDd6iyrIQurhf0kstKFiuIpcpNYz3MXlAfZ6m3IutbDMlVPV80OrFBbZzfJZTU7nLE500pywEyTDP7/VEwuqsuPB5yzr64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162376; c=relaxed/simple;
	bh=C0/8hW1TkNk5j1MdVgSV3Ikl0qmLYuEJPKaklUIObiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTzNPyaGxTIXGc5/0rhYVSAa4WSM/3VNya8R8TyG6i/XIfyQ0Kg2rc2ngbA+tpV9AcZPdU5ewB3RPPg53gd5feAx7YMSvpjr1dxf+ftnzdwdTbfF8Y80nVQVnrs2VmsKUemykaglZEov+bpuK5zn/jZiptzQlWffRKnYyTR+j/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eWgeGFu/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e4cbade42aso1043134a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741162372; x=1741767172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXA/TkGXM5NxtIFR0Rkc5MLIvPVEhtWeAVEIdjIqSAA=;
        b=eWgeGFu/1Kedmj4Kzd304QUXKg+sJRL+Bb06jsRnGMWCiid6NcX15byRJPQQlWAW9+
         hCdfYHmyrXaVnN7Oabe31N1Ou3jQQgoEmXKRHeKf6msvSwOqZqo6LMDK9rIOzOiu4JCn
         nRMgsWJd6sgosZvojlVX5UUmscTuiav8Lue1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162372; x=1741767172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXA/TkGXM5NxtIFR0Rkc5MLIvPVEhtWeAVEIdjIqSAA=;
        b=OiWLucxt6xNOiGlZ1av9GvmeNODII4uTtDMIALZfjomGHQ2YuIlPZ6G0S04jqPv/7X
         fmIs7JQgAsCAxiRpKgeJ+72S9kt3POIwS45pLGqUlR4hIVJ1qDPE95CM09Ea9e2YMRQ0
         gkMvIZnHPtUGH09785mHwQ+fEBFZdmSpAWg0humUD/j9HxC8SFnLvHuP5KpgoiXo32bO
         zfke8puwRnaj01ewDHM8HGY5iZ+L0ACiBeqa3fNtd7DETjyOhKmxQKWKykbKTZKtwwlh
         pMJq1SrgjgpD3AmJkuOgCSoft7IDHfS7HGXKBs1H00SWJ/dCt85hJeP6+8lzyfOK+sP6
         9iMA==
X-Forwarded-Encrypted: i=1; AJvYcCVsJj3vMh4xLRLqTphp4OtUouahyhQACCuD9Yt/2jM8ilSRvi/KUNOCag4QQvKAjtt5roj09q3/zy0Vhiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVKrKHRTcpt2vORlOhTn1apYBHmuT8Xb359iFOYjLKicVkoc4P
	wiV7JxlkCbjWN1D2V42gfHwE209p7SR9GC3SRxJmMiCWpLjbXbenVyTPP8J+RCtbw14uebziSt+
	eXw==
X-Gm-Gg: ASbGncsS90WW812tu2eUga65Rf8UdKZbhNmPPh50yXulDw0SBm9HSr9veMeg6ZTvoJr
	wfG3hX/ZQ0DTwxprhvSPlo5/lxj7aOPNdiSYBUnoqxkfvfCnmavayEmKnk9kXzYNKcENm21w9CO
	RlBHqqS+8NKwFrQk26T6u2psGNLWUvylIx3lQY7EYbiX/vFHYK0QsYMDULhbL2rMuGN5Pr1+X/w
	miSraPyI/k7HNsY0mUXPE4jLieOOflXTqLZ3eX44OPtJMnN0JlbrDn6yl7g6p7CRzd0YiZeWcO4
	wTudXez5FeIUwP8hyLU3PULphscRfCWuiESsliFUHFWS5JQskDZhyNZmvDHcqZhiZmDpyLwh+uB
	mV6oV
X-Google-Smtp-Source: AGHT+IFuCQK3PhmcYlJ9Aso9i9UkamM/YF7khdT+gADUx0UAtOsFpDPvvcCI8FU3JaXdMu8mIHeS7Q==
X-Received: by 2002:a17:906:7955:b0:abf:24f8:cc1e with SMTP id a640c23a62f3a-ac1f0e61fc1mr575006066b.2.1741162372160;
        Wed, 05 Mar 2025 00:12:52 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1fa431529sm215853166b.148.2025.03.05.00.12.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:12:50 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e4b6827fd9so4778a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:12:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVC+/W+ot1b6f0n0LI9y59S0pdaaGDZwpY7abbOE1z4j5ohgT9oEYVfjr9imDMML2gxKhtXoY7xH1CFETA=@vger.kernel.org
X-Received: by 2002:a05:6402:682:b0:5e0:8003:67a7 with SMTP id
 4fb4d7f45d1cf-5e59f582d2bmr77034a12.0.1741162370247; Wed, 05 Mar 2025
 00:12:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-b4-rkisp-noncoherent-v4-0-e32e843fb6ef@gmail.com>
 <20250303-b4-rkisp-noncoherent-v4-1-e32e843fb6ef@gmail.com> <8b3dac7baed1de9542452547454c53188c384391.camel@ndufresne.ca>
In-Reply-To: <8b3dac7baed1de9542452547454c53188c384391.camel@ndufresne.ca>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 5 Mar 2025 17:12:31 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CMsgjs9t3Lp-r3rqHG1dFJV5bFEFciWmKU+vq=TtAOvA@mail.gmail.com>
X-Gm-Features: AQ5f1JqMbRJjwTyn4eHWZnhmp3yyPL8Rgkfmk3Wh029t14UkPKDmnySUbUDhBgc
Message-ID: <CAAFQd5CMsgjs9t3Lp-r3rqHG1dFJV5bFEFciWmKU+vq=TtAOvA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] media: videobuf2: Fix dmabuf cache sync/flush in dma-contig
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Mikhail Rudenko <mike.rudenko@gmail.com>, Dafna Hirschfeld <dafna@fastmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 12:24=E2=80=AFAM Nicolas Dufresne <nicolas@ndufresne=
.ca> wrote:
>
> Hi Mikhail,
>
> Le lundi 03 mars 2025 =C3=A0 14:40 +0300, Mikhail Rudenko a =C3=A9crit :
> > When support for V4L2_FLAG_MEMORY_NON_CONSISTENT was removed in
> > commit 129134e5415d ("media: media/v4l2: remove
> > V4L2_FLAG_MEMORY_NON_CONSISTENT flag"),
> > vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions were made
> > no-ops. Later, when support for V4L2_MEMORY_FLAG_NON_COHERENT was
> > introduced in commit c0acf9cfeee0 ("media: videobuf2: handle
> > V4L2_MEMORY_FLAG_NON_COHERENT flag"), the above functions remained
> > no-ops, making cache maintenance for non-coherent dmabufs allocated
> > by
> > dma-contig impossible.
> >
> > Fix this by reintroducing dma_sync_sgtable_for_{cpu,device} and
> > {flush,invalidate}_kernel_vmap_range calls to
> > vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions for non-coherent
> > buffers.
> >
> > Fixes: c0acf9cfeee0 ("media: videobuf2: handle
> > V4L2_MEMORY_FLAG_NON_COHERENT flag")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> > ---
> >  .../media/common/videobuf2/videobuf2-dma-contig.c  | 22
> > ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > index
> > a13ec569c82f6da2d977222b94af32e74c6c6c82..d41095fe5bd21faf815d6b035d7
> > bc888a84a95d5 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > @@ -427,6 +427,17 @@ static int
> >  vb2_dc_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
> >                                  enum dma_data_direction
> > direction)
> >  {
> > +     struct vb2_dc_buf *buf =3D dbuf->priv;
> > +     struct sg_table *sgt =3D buf->dma_sgt;
> > +
> > +     if (!buf->non_coherent_mem)
> > +             return 0;
> > +
> > +     if (buf->vaddr)
> > +             invalidate_kernel_vmap_range(buf->vaddr, buf->size);
>
> What would make me a lot more confortable with this change is if you
> enable kernel mappings for one test. This will ensure you cover the
> call to "invalidate" in your testing. I'd like to know about the
> performance impact. With this implementation it should be identical to
> the VB2 one.

I agree that it would be good to test that path as well. I wonder if
we could somehow do it with one of the vi* drivers...

>
> What I was trying to say in previous comments, is that my impression is
> that we can skip this for CPU read access, since we don't guaranty
> concurrent access anyway. Both address space can keep their cache in
> that case. Though, I see RKISP does not use kernel mapping plus I'm not
> reporting a bug, but checking if we should leave a comment for possible
> users of kernel mapping in the future ?

We can't skip it for CPU read access, because it may be the first read
after the DMA writing to the buffer, so we need to invalidate the
caches.

That said, on majority of systems this will be a no-op, because it
only applies to VIVT and VIPT aliasing caches + only when the kernel
mapping is actually used (the buf->vaddr mapping is created on
demand).

>
> > +
> > +     dma_sync_sgtable_for_cpu(buf->dev, sgt, direction);
> > +
> >       return 0;
> >  }
> >
> > @@ -434,6 +445,17 @@ static int
> >  vb2_dc_dmabuf_ops_end_cpu_access(struct dma_buf *dbuf,
> >                                enum dma_data_direction direction)
> >  {
> > +     struct vb2_dc_buf *buf =3D dbuf->priv;
> > +     struct sg_table *sgt =3D buf->dma_sgt;
> > +
> > +     if (!buf->non_coherent_mem)
> > +             return 0;
> > +
> > +     if (buf->vaddr)
> > +             flush_kernel_vmap_range(buf->vaddr, buf->size);
> > +
> > +     dma_sync_sgtable_for_device(buf->dev, sgt, direction);
> > +
> >       return 0;
> >  }
> >
> >
>

