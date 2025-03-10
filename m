Return-Path: <linux-kernel+bounces-553785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0847DA58EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD12188D569
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA9E224220;
	Mon, 10 Mar 2025 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oMss8Sdd"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C7B4A02
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597225; cv=none; b=AQjmqTsELohQZc2PAWEQpc4yoVDUtsYNoaVrdFwa3COyoivMPlVVAKHkzAdN9UP2yk85T5ybd5H1nhwJTtNXM3e8/D1njuvVdQEiIO8AUf6CVHUifPaaHWDzrlk7PH7KvOz1IG9u8AdqrAMANmtPcI67bley5hfuHjdOKt0KzpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597225; c=relaxed/simple;
	bh=NHp7ZMafCgZi0KuBw/MuMMHbK0+r7tHwyaEpZyxsNAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkhPFiHJ0Jgq9AXR+JDhQoUkg8H5OD5ixuxKC8C4gj7qmmiXylO/T/8puu5VPltrarmI6G95xJq6H22vMUenotnOcH2LRpB1+j+JM/87P45rPDUhM/FZpSeZMPprvAL+GmErMwEAnDArRoaS59zyOPqqp142vgEry9/Ym+CsWRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oMss8Sdd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abf48293ad0so635712066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741597222; x=1742202022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5Yuxxu0WAoN1GxBYvN/CmEDsSXx0gVMofLIggB5ihw=;
        b=oMss8SdduYmKgbruR7L/dFfEtVBv5mYgxy/BzyVroQbaCpafk9WC+VrTaHMPcwP8d6
         H0RTMHJzzaAOIKKzPa5HB+a8WCDAiPSsZFvpj3B8y2NGFRr2nvbVNddacs71pJZ9/x4B
         Ux/18qT4IhG0cpG5cA6vXkvIKRMhQYq9dAadI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741597222; x=1742202022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5Yuxxu0WAoN1GxBYvN/CmEDsSXx0gVMofLIggB5ihw=;
        b=JVFWz2TPgZ9Pmt0F3LwyM0+jfijZUVFxLLp8eqA9sanruekfdubznf40Z95KznYUKS
         dFDVHyVmgjJgceq8jVCM+BwS7fOUqUk0cZyW2fVWJ6TCTz/2nEQzg1ljHzSIAmnu1y9H
         e2OqLCNRpyIO56U+urSUI75OWI6cnnOoPwJWy1wj5H8rWxUZK5b28M1sHlEcfPtqJuT7
         OjyrUJrh/7QTeUH1Kr+MgpXiof198iNliMtwtBcLSvIlz7yplNPIl+v1HATIrlSZskRf
         rIHBaTNz55EZMd7d1984OD2GHarupi7a5Kt6UN4Givew2FqdIknayKzCCNZ1TVxZ4OQy
         9Buw==
X-Forwarded-Encrypted: i=1; AJvYcCWHvgw8X0B4F74xuuDx+BHkwvRVaW+FKnWOFv15Hd/9nAV2lPYjKIVrtfiCFLocc0ciVArb83Zdkm+G2Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEbwruBXHl8inlRgWYeeACqIPdS2SDipCPi7aQL7Y7DsO7+dks
	6yyMOADXMLFFFxJzbUsFhkmQTVMNQRwlexA41u65s+f9t/EHD6E3eDQxGrbkvBROEWBYImH43fY
	=
X-Gm-Gg: ASbGnct6JEATRS5ZSmmNZV/1kmhDUoLkmJK2QQ9VL9H0D3dJ09mXMeM1KZOVFp8FqFJ
	F5q/9is9fU2Sh1BsajVow5lWmLcaJAmtYqWVXCdANIqdgJ0I4jD8ESxLY2rJVB9hVBrBylxgYac
	nPj0CrgogEzxoMDzY9zwzvNRCZfdoT8rg5SnbwSh+ukEFSSYlrW6l1FjLyn/mFnzYUsqbcBjPmM
	ZFRow2GJ9QojyHl/XrktyP+qMgS0TKKcgZDAXxulPaQ74c9FaGjJmVrEb27lZdDozWPAK1OHD7W
	MIgzrFIPvS3hPP8qDmsAIvwHKBlTC2NcA8+W/5ZUY6QnPOHmb3flOpO8FacRpkljfXQogvVZzsS
	fUCm2
X-Google-Smtp-Source: AGHT+IH03nYoqePaOp8XrlG1WjsE8qyQIhjHc0XOWXBjFSYnrY/Dop1hSxH2oYkV9s+Br/HfC0q0YA==
X-Received: by 2002:a17:907:7290:b0:abb:ac56:fcf8 with SMTP id a640c23a62f3a-ac25308b91fmr1230024966b.57.1741597221840;
        Mon, 10 Mar 2025 02:00:21 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac28c11561dsm266829466b.145.2025.03.10.02.00.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 02:00:21 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5cbd8b19bso9327a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:00:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHD5FC6DiWbknd3CzDSB227XO65Sjp1IHXY0DbH2U2ulWwRW9maacEUkP9AaYgxh4v18HcvqDBiCh/fAo=@vger.kernel.org
X-Received: by 2002:a05:6402:95a:b0:5e6:887f:6520 with SMTP id
 4fb4d7f45d1cf-5e6887f672fmr62677a12.5.1741597220471; Mon, 10 Mar 2025
 02:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-b4-rkisp-noncoherent-v4-0-e32e843fb6ef@gmail.com>
 <20250303-b4-rkisp-noncoherent-v4-1-e32e843fb6ef@gmail.com>
 <8b3dac7baed1de9542452547454c53188c384391.camel@ndufresne.ca> <87wmcxs1xw.fsf@gmail.com>
In-Reply-To: <87wmcxs1xw.fsf@gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 10 Mar 2025 18:00:03 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A70T2iaN17X2Jfk_6fCKRYZdKpreb+9i76n5WMYNEt1A@mail.gmail.com>
X-Gm-Features: AQ5f1JowVCHSCv6zRQDIlGrshBtBzEUT-W75FlZzOuUhz9aDBR_F5KxVvuObz24
Message-ID: <CAAFQd5A70T2iaN17X2Jfk_6fCKRYZdKpreb+9i76n5WMYNEt1A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] media: videobuf2: Fix dmabuf cache sync/flush in dma-contig
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: Nicolas Dufresne <nicolas@ndufresne.ca>, Dafna Hirschfeld <dafna@fastmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 5:52=E2=80=AFPM Mikhail Rudenko <mike.rudenko@gmail=
.com> wrote:
>
>
> Hi Nicolas, Tomasz,
>
> On 2025-03-03 at 10:24 -05, Nicolas Dufresne <nicolas@ndufresne.ca> wrote=
:
>
> > Hi Mikhail,
> >
> > Le lundi 03 mars 2025 =C3=A0 14:40 +0300, Mikhail Rudenko a =C3=A9crit =
:
> >> When support for V4L2_FLAG_MEMORY_NON_CONSISTENT was removed in
> >> commit 129134e5415d ("media: media/v4l2: remove
> >> V4L2_FLAG_MEMORY_NON_CONSISTENT flag"),
> >> vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions were made
> >> no-ops. Later, when support for V4L2_MEMORY_FLAG_NON_COHERENT was
> >> introduced in commit c0acf9cfeee0 ("media: videobuf2: handle
> >> V4L2_MEMORY_FLAG_NON_COHERENT flag"), the above functions remained
> >> no-ops, making cache maintenance for non-coherent dmabufs allocated
> >> by
> >> dma-contig impossible.
> >>
> >> Fix this by reintroducing dma_sync_sgtable_for_{cpu,device} and
> >> {flush,invalidate}_kernel_vmap_range calls to
> >> vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions for non-coherent
> >> buffers.
> >>
> >> Fixes: c0acf9cfeee0 ("media: videobuf2: handle
> >> V4L2_MEMORY_FLAG_NON_COHERENT flag")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> >> ---
> >>  .../media/common/videobuf2/videobuf2-dma-contig.c  | 22
> >> ++++++++++++++++++++++
> >>  1 file changed, 22 insertions(+)
> >>
> >> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> >> b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> >> index
> >> a13ec569c82f6da2d977222b94af32e74c6c6c82..d41095fe5bd21faf815d6b035d7
> >> bc888a84a95d5 100644
> >> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> >> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> >> @@ -427,6 +427,17 @@ static int
> >>  vb2_dc_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
> >>                                 enum dma_data_direction
> >> direction)
> >>  {
> >> +    struct vb2_dc_buf *buf =3D dbuf->priv;
> >> +    struct sg_table *sgt =3D buf->dma_sgt;
> >> +
> >> +    if (!buf->non_coherent_mem)
> >> +            return 0;
> >> +
> >> +    if (buf->vaddr)
> >> +            invalidate_kernel_vmap_range(buf->vaddr, buf->size);
> >
> > What would make me a lot more confortable with this change is if you
> > enable kernel mappings for one test. This will ensure you cover the
> > call to "invalidate" in your testing. I'd like to know about the
> > performance impact. With this implementation it should be identical to
> > the VB2 one.
> >
>
> I have re-run my tests on RK3399, with 1280x720 XRGB capture buffers (1
> plane, 3686400 bytes). Capture process was pinned to "big" cores running
> at fixed frequency of 1.8 GHz. Libcamera was modified to request buffers
> with V4L2_MEMORY_FLAG_NON_COHERENT flag. DMA_BUF_IOCTL_SYNC ioctls were
> used as appropriate. For kernel mapping effect test, vb2_plane_vaddr
> call was inserted into rkisp1_vb2_buf_init.
>
> The timings are as following:
>
> - memcpy coherent buffer: 7570 +/- 63 us
> - memcpy non-coherent buffer: 1120 +/- 34 us
>
> without kernel mapping:
>
> - ioctl(fd, DMA_BUF_IOCTL_SYNC, {DMA_BUF_SYNC_START|DMA_BUF_SYNC_READ}): =
428 +/- 15 us
> - ioctl(fd, DMA_BUF_IOCTL_SYNC, {DMA_BUF_SYNC_END|DMA_BUF_SYNC_READ}): 42=
2 +/- 28 us
>
> with kernel mapping:
>
> - ioctl(fd, DMA_BUF_IOCTL_SYNC, {DMA_BUF_SYNC_START|DMA_BUF_SYNC_READ}): =
526 +/- 13 us
> - ioctl(fd, DMA_BUF_IOCTL_SYNC, {DMA_BUF_SYNC_END|DMA_BUF_SYNC_READ}): 51=
9 +/- 38 us
>
> So, even with kernel mapping enabled, speedup is 7570 / (1120 + 526 + 519=
) =3D 3.5,
> and the use of noncoherent buffers is justified -- at least on this platf=
orm.

Thanks a lot for the additional testing.

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

