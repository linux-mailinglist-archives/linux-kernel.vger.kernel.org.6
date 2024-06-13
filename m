Return-Path: <linux-kernel+bounces-212723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7AB906551
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32EF28627A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD7213C3F5;
	Thu, 13 Jun 2024 07:38:06 +0000 (UTC)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E1513C3CD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264285; cv=none; b=BaPqOXucDnI7/MCihCMukNmshvQJH3BSR+3Quz4DHslr/DCLVty0DVDzL/jQDTb319zynAT1UWWuALDAd77vFGnYJ5l7at9LbF99+0G91glePu4IU8qtPVOBpRFGEqv92YC1iT7b4F7HAzZd6TWJiLhJzNZteUv93YAIuwEux84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264285; c=relaxed/simple;
	bh=W3N1DzNDsF6mEvewYurtAxQGbm71c9lyf2vO4E7gQos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsH8okB31fDr/gaH2lL0JsKypPsun/oSBwQM+aHDfksUh97KQBvmH3MlT4/dOvTUpzwepUXTyPlyTfO2/c9fVKg4pjUZZHUfFkfiKQnxzIO0NtMsHhQUuns7EYtembjftCFIilmjn8t4vKsklTYHPdKgKpXzJr18z1JbwkRSa+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48d9998787fso283433137.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718264282; x=1718869082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MymSWJYhL1v+2rUurUeDUD4VHdSslicZc71deUFMgPU=;
        b=f0VHh0T5pu1HEndgIVkTaKSkwb9nWn+AAN7VbXjHtjm/mVctJR0hsEMOx5rfSthAHJ
         a188wEfCUvvSo8Q3RfHv1VOe2oQTWue1nxbUAYQCT9vSm9PCL5uamWr2iqpeMtVtXoAt
         dg0wTCpdRuYSc14RVFS4p69vr4sYactEmgnKVDtq4lzPdx3cPmyf2lsxP4b7WkbnEj7y
         dFAGgeqvMZP6Jj3S1RzgNGLaWQrhAIyiS2RxVdcfcFkK2QCx6D0yK+dhw2K1F+O8uahd
         AU0P6o85TSe0FlfZeLVMDrCxCirwjTcj+H73bGG7iW3c08sNRpDZUDQcdgXPlAUZC2Nh
         HG1g==
X-Forwarded-Encrypted: i=1; AJvYcCUYTQ3EMRI3Dol3pt6Ht2ChE6DLHtpR9n6NT6igzw0xindJB9DkuGWIr1uI8NmtrXJmQmOrhiQv3a7GcmtjxEdaRMEeVkCMn2HFGVE+
X-Gm-Message-State: AOJu0YzT8DUS4arGgLg+c8FwjLF0uH5tWysJDkALleDYcQjM4kVhqDco
	A21Rxfi08TFOTaRlPpsL4v9gjyOe8fmqxzB+teY5jhlgHVergoozBWqOSyIye5nToS16EVWXTv9
	nWigHoTySeUM/+IIsHM4zHi7Lr00=
X-Google-Smtp-Source: AGHT+IH9yKYZaGt2hz2gcwrMgyDuNqcuFmZFwtpgbnrWk3ZNTmQGrkR98Gsv/5NDV00wmOKLM/Km8+XXdCvyHxDi2H4=
X-Received: by 2002:a05:6102:a4f:b0:48c:2f38:fd3 with SMTP id
 ada2fe7eead31-48d91db98b1mr5325731137.10.1718264282437; Thu, 13 Jun 2024
 00:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612081216.1319089-1-zhai.he@nxp.com> <20240612114748.bf5983b50634f23d674bc749@linux-foundation.org>
 <CAGsJ_4wsAh8C08PXutYZx9xV3rLRwLG-E6Mq-JgoSO5LA1ns=A@mail.gmail.com>
 <AS1PR04MB9559D82F720BC9A64077186AEAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
 <CAGsJ_4zGRnGhn1zA1=H+TgqL8z59_Dy7x7YVKsKY0wRFt4tu9w@mail.gmail.com>
 <AS1PR04MB955915A33F184E141BCD69A2EAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
 <CAGsJ_4w=MYMOoQnY7c9nE-iCdzP9amCyYTkje-PNGYe35u+1Kg@mail.gmail.com> <AS1PR04MB955988579ADFC6B5CCC8BBB3EAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
In-Reply-To: <AS1PR04MB955988579ADFC6B5CCC8BBB3EAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 13 Jun 2024 19:37:51 +1200
Message-ID: <CAGsJ_4wyQnAhzq_KoAoMp6g89DHgjKo3VfmE=o=g3HANGj6n+Q@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
To: Zhai He <zhai.he@nxp.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "sboyd@kernel.org" <sboyd@kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhipeng Wang <zhipeng.wang_1@nxp.com>, 
	Jindong Yue <jindong.yue@nxp.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 7:11=E2=80=AFPM Zhai He <zhai.he@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Barry Song <baohua@kernel.org>
> > Sent: Thursday, June 13, 2024 2:15 PM
> > To: Zhai He <zhai.he@nxp.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>; sboyd@kernel.org;
> > linux-mm@kvack.org; linux-kernel@vger.kernel.org; Zhipeng Wang
> > <zhipeng.wang_1@nxp.com>; Jindong Yue <jindong.yue@nxp.com>; Christoph
> > Hellwig <hch@lst.de>
> > Subject: Re: [EXT] Re: [PATCH v2] Supports to use the default CMA when =
the
> > device-specified CMA memory is not enough.
> >
> > Caution: This is an external email. Please take care when clicking link=
s or
> > opening attachments. When in doubt, report the message using the 'Repor=
t
> > this email' button
> >
> >
> > On Thu, Jun 13, 2024 at 5:32=E2=80=AFPM Zhai He <zhai.he@nxp.com> wrote=
:
> > >
> > > > -----Original Message-----
> > > > From: Barry Song <baohua@kernel.org>
> > > > Sent: Thursday, June 13, 2024 11:28 AM
> > > > To: Zhai He <zhai.he@nxp.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>; sboyd@kernel.org;
> > > > linux-mm@kvack.org; linux-kernel@vger.kernel.org; Zhipeng Wang
> > > > <zhipeng.wang_1@nxp.com>; Jindong Yue <jindong.yue@nxp.com>;
> > > > Christoph Hellwig <hch@lst.de>
> > > > Subject: Re: [EXT] Re: [PATCH v2] Supports to use the default CMA
> > > > when the device-specified CMA memory is not enough.
> > > >
> > > > Caution: This is an external email. Please take care when clicking
> > > > links or opening attachments. When in doubt, report the message
> > > > using the 'Report this email' button
> > > >
> > > >
> > > > On Thu, Jun 13, 2024 at 2:34=E2=80=AFPM Zhai He <zhai.he@nxp.com> w=
rote:
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Barry Song <baohua@kernel.org>
> > > > > > Sent: Thursday, June 13, 2024 5:37 AM
> > > > > > To: Andrew Morton <akpm@linux-foundation.org>
> > > > > > Cc: Zhai He <zhai.he@nxp.com>; sboyd@kernel.org;
> > > > > > linux-mm@kvack.org; linux-kernel@vger.kernel.org;
> > > > > > stable@vger.kernel.org; Zhipeng Wang <zhipeng.wang_1@nxp.com>;
> > > > > > Jindong Yue <jindong.yue@nxp.com>; Christoph Hellwig
> > > > > > <hch@lst.de>
> > > > > > Subject: [EXT] Re: [PATCH v2] Supports to use the default CMA
> > > > > > when the device-specified CMA memory is not enough.
> > > > > >
> > > > > > Caution: This is an external email. Please take care when
> > > > > > clicking links or opening attachments. When in doubt, report th=
e
> > > > > > message using the 'Report this email' button
> > > > > >
> > > > > >
> > > > > > On Thu, Jun 13, 2024 at 6:47=E2=80=AFAM Andrew Morton
> > > > > > <akpm@linux-foundation.org>
> > > > > > wrote:
> > > > > > >
> > > > > > > On Wed, 12 Jun 2024 16:12:16 +0800 "zhai.he" <zhai.he@nxp.com=
>
> > > > wrote:
> > > > > > >
> > > > > > > > From: He Zhai <zhai.he@nxp.com>
> > > > > > >
> > > > > > > (cc Barry & Christoph)
> > > > > > >
> > > > > > > What was your reason for adding cc:stable to the email header=
s?
> > > > > > > Does this address some serious problem?  If so, please fully
> > > > > > > describe that problem.
> > > > > > >
> > > > > > > > In the current code logic, if the device-specified CMA
> > > > > > > > memory allocation fails, memory will not be allocated from =
the
> > default CMA area.
> > > > > > > > This patch will use the default cma region when the device'=
s
> > > > > > > > specified CMA is not enough.
> > > > > > > >
> > > > > > > > In addition, the log level of allocation failure is changed=
 to debug.
> > > > > > > > Because these logs will be printed when memory allocation
> > > > > > > > from the device specified CMA fails, but if the allocation
> > > > > > > > fails, it will be allocated from the default cma area. It
> > > > > > > > can easily mislead
> > > > developers'
> > > > > > > > judgment.
> > > > > >
> > > > > > I am not convinced that this patch is correct. If
> > > > > > device-specific CMA is too small, why not increase it in the de=
vice tree?
> > > > > > Conversely, if the default CMA size is too large, why not reduc=
e
> > > > > > it via the cmdline?  CMA offers all kinds of flexible
> > > > > > configuration options based
> > > > on users=E2=80=99 needs.
> > > > > >
> > > > > > One significant benefit of device-specific CMA is that it helps
> > > > > > decrease fragmentation in the common CMA pool. While many
> > > > > > devices allocate memory from the same pool, they have different
> > > > > > memory requirements in terms of sizes and alignments. Occasions
> > > > > > of memory allocation and release can lead to situations where
> > > > > > the CMA pool has enough free space, yet someone fails to obtain
> > contiguous memory from it.
> > > > > >
> > > > > > This patch entirely negates the advantage we gain from device-s=
pecific
> > CMA.
> > > > > > My point is that instead of modifying the core code, please
> > > > > > consider correcting your device tree or cmdline configurations.
> > > > > >
> > > > > Because we enabled secure heap to support widevine DRM, and secur=
e
> > > > > heap requires security configuration, its starting address cannot
> > > > > be specified arbitrarily, which causes the default CMA to be
> > > > > reduced. So we
> > > > reduced the CMA, but in order to avoid the impact of reducing the
> > > > CMA, we used a multi-segment CMA and gave one segment to the VPU.
> > > > >
> > > > > However, under our memory configuration, the device-specific CMA
> > > > > is not
> > > > enough to support the VPU decoding high-resolution code streams, so
> > > > this patch is added so that the VPU can work properly.
> > > > > Thanks.
> > > >
> > > > I don=E2=80=99t quite understand what you are saying. Why can=E2=80=
=99t you increase
> > > > VPU=E2=80=99s CMA size?
> > > Thanks for your quick reply.
> > > Because we added a secure heap to support Widevine DRM, this heap
> > requires hardware protection, so its starting address cannot be specifi=
ed
> > arbitrarily. This causes the secure heap to occupy part of the default =
CMA, and
> > the default CMA is therefore reduced, so in order to avoid default CMA
> > Shrinking introduces other problems. We added a specific CMA area for t=
he
> > VPU. However, due to the large size of the secure heap and default CMA,=
 There
> > is no remaining memory available to increase specific CMA for VPU.
> >
> > I assume the secure heap you are referring to is a section of memory th=
at
> > should only be accessed by TrustZone and not be visible to Linux runnin=
g in
> > non-secure mode. How do you allocate this secure heap from the default =
CMA?
>
> No, secure heap is a reserved memory, secure heap is not allocated from C=
MA, secure heap has been reserved during the kernel startup phase.
> And this reserved memory is protected by hardware. Only specific hardware=
 and secure world can accessed it.
> For example:
> &{/reserved-memory/} {
>         secure_region: secure {
>                 compatible =3D "imx-secure-ion-pool";
>                 reg =3D <0x0 0xA0000000 0 0x1EF00000>;
>         };
> };
>
> > Do you use the cma_alloc() APIs or the dma_alloc_coherent() APIs? Given=
 that
> > the VPU has its own device-specific CMA, why is this secure heap alloca=
ted
> > from the default CMA instead of the VPU's CMA?
> >
> The VPU driver will use dma_alloc_coherent() to allocate contiguous memor=
y. The secure heap is not allocated from the CMA, but because the secure he=
ap is enabled, it occupies some contiguous memory, causing the default CMA =
to be reduced.
>
> > If this secure heap was allocated before the kernel booted, why did the
> > kernel(your dts) fail to mark this area as nomap/reserved to prevent th=
e
> > default CMA from intersecting with it?
> >
> Secure heap does not intersect with the CMA.
> for example:
> before secure heap enabled:
> 0xA000 0000 ~ 0xFFFFFFFF: default CMA
> after secure heap enabled:
> 0x9000 0000 ~0x9FFF FFFF is the CMA specified by VPU,
> 0xA000 0000 ~0xAFFF FFFF is secure heap, (the start address cannot be spe=
cified arbitrarily, because this memory is protected by hardware, if the st=
art address is 0x9000 0000, uboot will use this memory, but uboot can't acc=
ess this memory because of hardware protection. So we find a section of mem=
ory that UBOOT will not use as secure heap.
> Note: The memory of uboot can be adjusted, but avoiding the secure heap w=
ill limit the memory range that uboot can use, causing problems such as the=
 uboot stack)
> 0xB000 0000 ~0xFFFFFFFF is default CMA.
> So default CMA is reduced.

How is that related to your patch? I assume the default CMA is reduced beca=
use
you modified it in the DTS after enabling the secure heap, as the CMA
size is set
by you. The default CMA size won't automatically decrease due to the secure
heap. To me, 0xB0000000-0xFFFFFFFF(1.25GiB) is still too large a CMA.

>
> > >
> > > > It seems you mean that only in some corner cases do you need a larg=
e
> > > > CMA, but most of the time, you don=E2=80=99t need it to be this big=
? So you have
> > to "borrow"
> > > > memory from the
> > > > default CMA. but why not move that portion from the default CMA to
> > > > your VPU=E2=80=99s CMA?
> > > >
> > > This is a method, but because for VPU, the continuous memory size all=
ocated
> > by the driver is based on the video stream, we cannot determine the max=
imum
> > size of memory required by the VPU. This makes it impossible for us to
> > determine the size of the specific CMA assigned to the VPU. Thanks.
> >
> > I don't understand how this can happen. You should precisely know the
> > maximum size required for the VPU based on your multimedia pipeline and
> > resolutions.
> >
> We cannot estimate the maximum contiguous memory required by the VPU beca=
use it depends on how the video is encoded.
> Thanks very much.

Yes, you can. Please ask your multimedia team; they will give
you a number.

>
> > I still don't understand your scenarios or the problem you are facing.
>
>

Thanks
Barry

