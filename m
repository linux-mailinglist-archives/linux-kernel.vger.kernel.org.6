Return-Path: <linux-kernel+bounces-212974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6668B906930
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF47E1F243E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F4614039A;
	Thu, 13 Jun 2024 09:44:04 +0000 (UTC)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3899B13D529
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271843; cv=none; b=moR5IoKzXzGW67HGJZG3J1JCzjlpjYqHJQVgbXcZEbMDyS9X+/IR1QPzOc9wWfr0kTDSxg+W0kf8E1yiV5IEYs8uVCn+k465a2l0b9vxzmZMBDexJkT9j/PPxkKZqwdiNbWpAi78OgfgtxfBLX5vIa/30uVxiR+G9DP41ZdZ384=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271843; c=relaxed/simple;
	bh=gomJKyQwZcBRO7Pw5T+bCYMk+FZgxySizruZkVy7MBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LESlBcSMsvn7moMtvxBcnUYcUkYAIV+oOoqIQ6byObqOLQjVTVqcMjKWmmHFVAKzzjeS3pLo/2WtjyDuveaIyIo3NVXC5AUmeSf+W0LwYHpLMH2O+wwIallIAg193Q9NBhgY93bLr5JXb6N2Am4N8iq0aGGIsKwfE7iSWC13RzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-80b7c11aaf9so238601241.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 02:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718271840; x=1718876640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGZpwvvFWoUM4hVcXQNXUXevJ3SayuXE1Zat2o0h0YY=;
        b=aR7Ou7IesXUQrgIHCJixmKpD82lYZifSK6Uz7mPrY6OH/wF170zugrTuvD0v2SrcdI
         25EdCaQqPU8R8CZldM25ryCdLFgnM4DPNG4/kj7FbRTWmihZJhtNyVXEDgrlWackEoFc
         c+QuvMHbgEvuJqj4AENrI9ZzguAWgDjNaJ6PVjDuObKUN3g5Uv+0iq86qGrEjlSsdvXA
         YC3KhtVmcbiYJvc9PH0timYekQq+T/NPp4iopqPU4OHKqHIeTTqLzO/ed+IyjnL/ZKK5
         C301Mr2iNTX1tLGKXwSrSn7Pyrs2NBGuuxOnx5Pguj99s6yDCfVzVc7B1VLvn1TPzlPi
         2EaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgJOsGYB4HFbdTQFD2yzz6mZvmXbyiEbT/dIRInmdUusxhwFTo6W2qDMMIFVN6XzN7RzdaEeop9Sg4fsgVNTNkxJHrNQT+RbqUDb5Z
X-Gm-Message-State: AOJu0YzQ8X31KEjQNQ7FcFBZ8AOdDeVjs2NgtH/9N3WxiRYYJkVTCMXj
	eRn2hV8CMSaoddiP1zxj369ImzTF6Jrur+PgS5BG7+/H+7vYqD4s5aGReXU1j3U4QkIhKXcc89Y
	8cDJsxuaWMW+q98xpVqzQV4A4lXI=
X-Google-Smtp-Source: AGHT+IGzVboPNn9QwP00HuEIScFGw9jAyxyp7d/HTvGYqatEmQgQOs87kiAZnvyqZ+VNoxlfAX7WDSMTcRpcUVhu3AU=
X-Received: by 2002:a05:6122:6107:b0:4ed:145:348f with SMTP id
 71dfb90a1353d-4ed07b90d72mr3768649e0c.12.1718271839964; Thu, 13 Jun 2024
 02:43:59 -0700 (PDT)
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
 <CAGsJ_4w=MYMOoQnY7c9nE-iCdzP9amCyYTkje-PNGYe35u+1Kg@mail.gmail.com>
 <AS1PR04MB955988579ADFC6B5CCC8BBB3EAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
 <CAGsJ_4wyQnAhzq_KoAoMp6g89DHgjKo3VfmE=o=g3HANGj6n+Q@mail.gmail.com> <AS1PR04MB95593F3D6C60573707DFFF0DEAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
In-Reply-To: <AS1PR04MB95593F3D6C60573707DFFF0DEAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 13 Jun 2024 21:43:48 +1200
Message-ID: <CAGsJ_4xXwU0ebCPcwpC3PCOGwV4sZQAAzVTvFW+uuz4cwOnS4w@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
To: Zhai He <zhai.he@nxp.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "sboyd@kernel.org" <sboyd@kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhipeng Wang <zhipeng.wang_1@nxp.com>, 
	Jindong Yue <jindong.yue@nxp.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 8:49=E2=80=AFPM Zhai He <zhai.he@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Barry Song <baohua@kernel.org>
> > Sent: Thursday, June 13, 2024 3:38 PM
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
t this
> > email' button
> >
> >
> > On Thu, Jun 13, 2024 at 7:11=E2=80=AFPM Zhai He <zhai.he@nxp.com> wrote=
:
> > >
> > > > -----Original Message-----
> > > > From: Barry Song <baohua@kernel.org>
> > > > Sent: Thursday, June 13, 2024 2:15 PM
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
> > > > On Thu, Jun 13, 2024 at 5:32=E2=80=AFPM Zhai He <zhai.he@nxp.com> w=
rote:
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Barry Song <baohua@kernel.org>
> > > > > > Sent: Thursday, June 13, 2024 11:28 AM
> > > > > > To: Zhai He <zhai.he@nxp.com>
> > > > > > Cc: Andrew Morton <akpm@linux-foundation.org>; sboyd@kernel.org=
;
> > > > > > linux-mm@kvack.org; linux-kernel@vger.kernel.org; Zhipeng Wang
> > > > > > <zhipeng.wang_1@nxp.com>; Jindong Yue <jindong.yue@nxp.com>;
> > > > > > Christoph Hellwig <hch@lst.de>
> > > > > > Subject: Re: [EXT] Re: [PATCH v2] Supports to use the default
> > > > > > CMA when the device-specified CMA memory is not enough.
> > > > > >
> > > > > > Caution: This is an external email. Please take care when
> > > > > > clicking links or opening attachments. When in doubt, report th=
e
> > > > > > message using the 'Report this email' button
> > > > > >
> > > > > >
> > > > > > On Thu, Jun 13, 2024 at 2:34=E2=80=AFPM Zhai He <zhai.he@nxp.co=
m> wrote:
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Barry Song <baohua@kernel.org>
> > > > > > > > Sent: Thursday, June 13, 2024 5:37 AM
> > > > > > > > To: Andrew Morton <akpm@linux-foundation.org>
> > > > > > > > Cc: Zhai He <zhai.he@nxp.com>; sboyd@kernel.org;
> > > > > > > > linux-mm@kvack.org; linux-kernel@vger.kernel.org;
> > > > > > > > stable@vger.kernel.org; Zhipeng Wang
> > > > > > > > <zhipeng.wang_1@nxp.com>; Jindong Yue <jindong.yue@nxp.com>=
;
> > > > > > > > Christoph Hellwig <hch@lst.de>
> > > > > > > > Subject: [EXT] Re: [PATCH v2] Supports to use the default
> > > > > > > > CMA when the device-specified CMA memory is not enough.
> > > > > > > >
> > > > > > > > Caution: This is an external email. Please take care when
> > > > > > > > clicking links or opening attachments. When in doubt, repor=
t
> > > > > > > > the message using the 'Report this email' button
> > > > > > > >
> > > > > > > >
> > > > > > > > On Thu, Jun 13, 2024 at 6:47=E2=80=AFAM Andrew Morton
> > > > > > > > <akpm@linux-foundation.org>
> > > > > > > > wrote:
> > > > > > > > >
> > > > > > > > > On Wed, 12 Jun 2024 16:12:16 +0800 "zhai.he"
> > > > > > > > > <zhai.he@nxp.com>
> > > > > > wrote:
> > > > > > > > >
> > > > > > > > > > From: He Zhai <zhai.he@nxp.com>
> > > > > > > > >
> > > > > > > > > (cc Barry & Christoph)
> > > > > > > > >
> > > > > > > > > What was your reason for adding cc:stable to the email he=
aders?
> > > > > > > > > Does this address some serious problem?  If so, please
> > > > > > > > > fully describe that problem.
> > > > > > > > >
> > > > > > > > > > In the current code logic, if the device-specified CMA
> > > > > > > > > > memory allocation fails, memory will not be allocated
> > > > > > > > > > from the
> > > > default CMA area.
> > > > > > > > > > This patch will use the default cma region when the
> > > > > > > > > > device's specified CMA is not enough.
> > > > > > > > > >
> > > > > > > > > > In addition, the log level of allocation failure is cha=
nged to debug.
> > > > > > > > > > Because these logs will be printed when memory
> > > > > > > > > > allocation from the device specified CMA fails, but if
> > > > > > > > > > the allocation fails, it will be allocated from the
> > > > > > > > > > default cma area. It can easily mislead
> > > > > > developers'
> > > > > > > > > > judgment.
> > > > > > > >
> > > > > > > > I am not convinced that this patch is correct. If
> > > > > > > > device-specific CMA is too small, why not increase it in th=
e device
> > tree?
> > > > > > > > Conversely, if the default CMA size is too large, why not
> > > > > > > > reduce it via the cmdline?  CMA offers all kinds of flexibl=
e
> > > > > > > > configuration options based
> > > > > > on users=E2=80=99 needs.
> > > > > > > >
> > > > > > > > One significant benefit of device-specific CMA is that it
> > > > > > > > helps decrease fragmentation in the common CMA pool. While
> > > > > > > > many devices allocate memory from the same pool, they have
> > > > > > > > different memory requirements in terms of sizes and
> > > > > > > > alignments. Occasions of memory allocation and release can
> > > > > > > > lead to situations where the CMA pool has enough free space=
,
> > > > > > > > yet someone fails to obtain
> > > > contiguous memory from it.
> > > > > > > >
> > > > > > > > This patch entirely negates the advantage we gain from
> > > > > > > > device-specific
> > > > CMA.
> > > > > > > > My point is that instead of modifying the core code, please
> > > > > > > > consider correcting your device tree or cmdline configurati=
ons.
> > > > > > > >
> > > > > > > Because we enabled secure heap to support widevine DRM, and
> > > > > > > secure heap requires security configuration, its starting
> > > > > > > address cannot be specified arbitrarily, which causes the
> > > > > > > default CMA to be reduced. So we
> > > > > > reduced the CMA, but in order to avoid the impact of reducing
> > > > > > the CMA, we used a multi-segment CMA and gave one segment to th=
e
> > VPU.
> > > > > > >
> > > > > > > However, under our memory configuration, the device-specific
> > > > > > > CMA is not
> > > > > > enough to support the VPU decoding high-resolution code streams=
,
> > > > > > so this patch is added so that the VPU can work properly.
> > > > > > > Thanks.
> > > > > >
> > > > > > I don=E2=80=99t quite understand what you are saying. Why can=
=E2=80=99t you
> > > > > > increase VPU=E2=80=99s CMA size?
> > > > > Thanks for your quick reply.
> > > > > Because we added a secure heap to support Widevine DRM, this heap
> > > > requires hardware protection, so its starting address cannot be
> > > > specified arbitrarily. This causes the secure heap to occupy part o=
f
> > > > the default CMA, and the default CMA is therefore reduced, so in
> > > > order to avoid default CMA Shrinking introduces other problems. We
> > > > added a specific CMA area for the VPU. However, due to the large
> > > > size of the secure heap and default CMA, There is no remaining memo=
ry
> > available to increase specific CMA for VPU.
> > > >
> > > > I assume the secure heap you are referring to is a section of memor=
y
> > > > that should only be accessed by TrustZone and not be visible to
> > > > Linux running in non-secure mode. How do you allocate this secure h=
eap
> > from the default CMA?
> > >
> > > No, secure heap is a reserved memory, secure heap is not allocated fr=
om CMA,
> > secure heap has been reserved during the kernel startup phase.
> > > And this reserved memory is protected by hardware. Only specific hard=
ware
> > and secure world can accessed it.
> > > For example:
> > > &{/reserved-memory/} {
> > >         secure_region: secure {
> > >                 compatible =3D "imx-secure-ion-pool";
> > >                 reg =3D <0x0 0xA0000000 0 0x1EF00000>;
> > >         };
> > > };
> > >
> > > > Do you use the cma_alloc() APIs or the dma_alloc_coherent() APIs?
> > > > Given that the VPU has its own device-specific CMA, why is this
> > > > secure heap allocated from the default CMA instead of the VPU's CMA=
?
> > > >
> > > The VPU driver will use dma_alloc_coherent() to allocate contiguous m=
emory.
> > The secure heap is not allocated from the CMA, but because the secure h=
eap is
> > enabled, it occupies some contiguous memory, causing the default CMA to=
 be
> > reduced.
> > >
> > > > If this secure heap was allocated before the kernel booted, why did
> > > > the kernel(your dts) fail to mark this area as nomap/reserved to
> > > > prevent the default CMA from intersecting with it?
> > > >
> > > Secure heap does not intersect with the CMA.
> > > for example:
> > > before secure heap enabled:
> > > 0xA000 0000 ~ 0xFFFFFFFF: default CMA
> > > after secure heap enabled:
> > > 0x9000 0000 ~0x9FFF FFFF is the CMA specified by VPU,
> > > 0xA000 0000 ~0xAFFF FFFF is secure heap, (the start address cannot be
> > specified arbitrarily, because this memory is protected by hardware, if=
 the start
> > address is 0x9000 0000, uboot will use this memory, but uboot can't acc=
ess this
> > memory because of hardware protection. So we find a section of memory t=
hat
> > UBOOT will not use as secure heap.
> > > Note: The memory of uboot can be adjusted, but avoiding the secure
> > > heap will limit the memory range that uboot can use, causing problems
> > > such as the uboot stack)
> > > 0xB000 0000 ~0xFFFFFFFF is default CMA.
> > > So default CMA is reduced.
> >
> > How is that related to your patch? I assume the default CMA is reduced =
because
> > you modified it in the DTS after enabling the secure heap, as the CMA s=
ize is set
> > by you. The default CMA size won't automatically decrease due to the se=
cure
> > heap. To me, 0xB0000000-0xFFFFFFFF(1.25GiB) is still too large a CMA.
> >
>
> Sorry, This example is just an example. In fact, the size of our default =
CMA is less than 1.25GiB.
> Our current memory distribution is as follows. Now the size of "c" (defau=
lt CMA) could not meet the needs of our requirement. And "b" (reserved memo=
ry for secure) is fixed, so we couldn't expand "c" (default CMA) through mo=
dify DTS. Then we reserved "a" (specific CMA) for VPU. However, we have con=
firmed with the multimedia team that the maximum size required is It is unc=
ertain, so specify "a" for VPU to use first, and "c" for other devices that=
 require continuous memory. If "a" is not enough, use "c".
> That's the purpose of this patch.
>         --------------------------------------------------
>         | a. VPU specific cma             |
>         --------------------------------------------------
>         | b. reserved memory for secure    |
>         ---------------------------------------------------
>     | c. default CMA                 |
>     ---------------------------------------------------
> > >

Ok, I understand your problem. Because B is enabled, you can't have C as la=
rge
as you would without B. So you add A, but A might have insufficient space f=
or
high-resolution video. You also don't know the exact size needed for A. In =
the
corner case of encoding/decoding high-resolution video, A might be insuffic=
ient,
forcing you to borrow memory from C.  Because B is situated between A and C=
,
creating a gap, you cannot merge A and C into a single default CMA.

This does indeed seem like a valid requirement. Please ensure to
clearly describe
the problem next time. However, as a general rule, allowing device-specific=
 CMAs
to borrow from the default CMA is not advisable. This would undermine
the reasons
why we started supporting device-specific CMAs in the first place.

So the problem is that memory holes may prevent the formation of large CMAs=
.

This situation raises a question: can we have two or more default CMAs due =
to
memory holes like B, which might hinder the system from obtaining a suffici=
ently
large default CMA?

If you could define both A and C as default CMAs, you wouldn't require
these kinds of
fallbacks. Is it possible for you to make dma_contiguous_default_area
a list rather
than a global variant ?

Another option is that we allow devices to have more than one memory-region=
,
we can use device tree to fallback.
memory-region =3D <&mem1, &mem2>;

My perspective is that I acknowledge your problem as a valid requirement.
However, I find the approach to be too aggressive.

> > > > >
> > > > > > It seems you mean that only in some corner cases do you need a
> > > > > > large CMA, but most of the time, you don=E2=80=99t need it to b=
e this
> > > > > > big? So you have
> > > > to "borrow"
> > > > > > memory from the
> > > > > > default CMA. but why not move that portion from the default CMA
> > > > > > to your VPU=E2=80=99s CMA?
> > > > > >
> > > > > This is a method, but because for VPU, the continuous memory size
> > > > > allocated
> > > > by the driver is based on the video stream, we cannot determine the
> > > > maximum size of memory required by the VPU. This makes it impossibl=
e
> > > > for us to determine the size of the specific CMA assigned to the VP=
U. Thanks.
> > > >
> > > > I don't understand how this can happen. You should precisely know
> > > > the maximum size required for the VPU based on your multimedia
> > > > pipeline and resolutions.
> > > >
> > > We cannot estimate the maximum contiguous memory required by the VPU
> > because it depends on how the video is encoded.
> > > Thanks very much.
> >
> > Yes, you can. Please ask your multimedia team; they will give you a num=
ber.
> >
> > >
> > > > I still don't understand your scenarios or the problem you are faci=
ng.
> > >
> > >
> >

Thanks
Barry

