Return-Path: <linux-kernel+bounces-340530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CEF9874CC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A881C22D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC9D27470;
	Thu, 26 Sep 2024 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+GV8oJV"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA450535DC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358793; cv=none; b=JsgUTZ47zIHCSz/2YnsOnmLBsRJ0ykVbexDZhONeAfID149+gy7ASKc9D9Q9mJMtNSnBVeqaz3PnlYkqZjrPfHNDoDpLWDD9gv5aKV5RhPJcx0htT5XVGUdk4dfpfO4Te/rzsgHSusdnnYSB2p/Bim7AbtMhGVZ3cPnNBhlPsOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358793; c=relaxed/simple;
	bh=v7tAPySwmdQHAtA+YRpD9HZ0WA3SFgtNuMS1LZNdOfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrTS5tHd/9jXadkvBcwa8eGyI4iFRG/JteHqP24B2rwb720Po8AkfRt4vPo8A26OT0W5okTd1lmc2AwufdCtN+SBcVG87DmYltdL5N13+nHp4K3QbjxTVWLRSNe43n7x8P9AtBtnKad1OqZMQmXh6Z+goM40uZjBu7cFLUpxmU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O+GV8oJV; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-49bcd11fc37so392824137.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727358791; x=1727963591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7tAPySwmdQHAtA+YRpD9HZ0WA3SFgtNuMS1LZNdOfM=;
        b=O+GV8oJVhXMDzbcuHZZkODuUxRGoEt/tfV7VHTKyr+BkhbVaAfmSMnCWxVirljxprk
         aGfHt2tgHuGEatWRt4LksBrMdAqDETK59LX+UgV+pMSWxUIQMRhwEu6zVvWmzlfAoWVT
         b8dipyx09D+yxVEAEM0bBsN79/FoA32p21JIlgUyVGoqcNfsjZHnlq842oKmP7zmheSF
         oWOUWoBezlhxDOLt/o8eT4U3+jEHUnbHiOnz8OSnrwRiplFB4hXkH6CgQ0EcnRYJOTVl
         GNXpfjidSdxsmR1ZCNolJgyRJFIALS6RxIUrKfyNk+L8rYcJqRQPOjfmooTVU9kpTP2Q
         UICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727358791; x=1727963591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7tAPySwmdQHAtA+YRpD9HZ0WA3SFgtNuMS1LZNdOfM=;
        b=DWFrvIc5xFx40GQyBcrTSGQPb3OyfUkyn4puGqKbp6PugWO0uAVsz00ab4fOgrIrwL
         IcwMahKBtnbPrDO2qNK6OvSpEc1aEfwCcCQ+FHaikYp++DH5o07WMdKsYPWEcKZq7QCH
         rCAOAjl9kvsZOUHyPjRReBAyY6uT2T4rdjE905NHUMNY8B4K9BBOttVIE2hCJdXLnCIe
         xMrNQ+3etDFwTaCKACPpSFATbzrrc1n8Gy3UrjhDpAWDFqaDgfaHDJyRsIUu8Dpa3R59
         w7kRSJp1vmAM5UP1EHu5geiALGuHRnrfEZ2EILZHDmcdMbPT9sZbegTqT12QvHXfT9U4
         TwOA==
X-Forwarded-Encrypted: i=1; AJvYcCUmavvq7NwkA0PNciRWPs7DFj1oU/FsxS8MQmcQ9CiaCIUr2jIW+ppNBoai6D7jYTloi3oRr/6ZIQJl89s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI6NI4x/Ck7dscplj3FUkQnlOimBe4z/5G/A1TG5iYJJiydVrk
	I9YEX1eUrbA8zBiDE2JMT2R3TZPXVr7RY3iptvbIn3H0UCCoG6da8aJD6QD2Gm0vNK7XREJqaT/
	WB4ZY5zQX5S8eDb/bgT3/LbAxKzlupDo0KSzetg==
X-Google-Smtp-Source: AGHT+IGiiwbrTmw9dljjWSN9d0gHwqaQUj+Fn0r4rGaVn1FGbJ9M6TMGDh8ZVVMliTp3gdeL94LIECqfDzeHqpj4reg=
X-Received: by 2002:a05:6102:3e8f:b0:49b:d1e7:5442 with SMTP id
 ada2fe7eead31-4a15dd44cd9mr6602413137.18.1727358790467; Thu, 26 Sep 2024
 06:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830070351.2855919-1-jens.wiklander@linaro.org>
 <dhxvyshwi4qmcmwceokhqey2ww4azjcs6qrpnkgivdj7tv5cke@r36srvvbof6q>
 <d8e0cb78-7cfb-42bf-b3a5-f765592e8dd4@ti.com> <mzur3odofwwrdqnystozjgf3qtvb73wqjm6g2vf5dfsqiehaxk@u67fcarhm6ge>
 <e967e382-6cca-4dee-8333-39892d532f71@gmail.com> <lk7a2xuqrctyywuanjwseh5lkcz3soatc2zf3kn3uwc43pdyic@edm3hcd2koas>
 <04caa788-19a6-4336-985c-4eb191c24438@amd.com> <2f9a4abe-b2fc-4bc7-9926-1da2d38f5080@linaro.org>
In-Reply-To: <2f9a4abe-b2fc-4bc7-9926-1da2d38f5080@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 26 Sep 2024 19:22:59 +0530
Message-ID: <CAFA6WYMd46quafJoGXjkCiPOKpYoDZdXwrNbG3QekyjB3_2FTA@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [RFC PATCH 0/4] Linaro restricted heap
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Andrew Davis <afd@ti.com>, Jens Wiklander <jens.wiklander@linaro.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Resend in plain text format as my earlier message was rejected by
some mailing lists]

On Thu, 26 Sept 2024 at 19:17, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On 9/25/24 19:31, Christian K=C3=B6nig wrote:
>
> Am 25.09.24 um 14:51 schrieb Dmitry Baryshkov:
>
> On Wed, Sep 25, 2024 at 10:51:15AM GMT, Christian K=C3=B6nig wrote:
>
> Am 25.09.24 um 01:05 schrieb Dmitry Baryshkov:
>
> On Tue, Sep 24, 2024 at 01:13:18PM GMT, Andrew Davis wrote:
>
> On 9/23/24 1:33 AM, Dmitry Baryshkov wrote:
>
> Hi,
>
> On Fri, Aug 30, 2024 at 09:03:47AM GMT, Jens Wiklander wrote:
>
> Hi,
>
> This patch set is based on top of Yong Wu's restricted heap patch set [1]=
.
> It's also a continuation on Olivier's Add dma-buf secure-heap patch set [=
2].
>
> The Linaro restricted heap uses genalloc in the kernel to manage the heap
> carvout. This is a difference from the Mediatek restricted heap which
> relies on the secure world to manage the carveout.
>
> I've tried to adress the comments on [2], but [1] introduces changes so I=
'm
> afraid I've had to skip some comments.
>
> I know I have raised the same question during LPC (in connection to
> Qualcomm's dma-heap implementation). Is there any reason why we are
> using generic heaps instead of allocating the dma-bufs on the device
> side?
>
> In your case you already have TEE device, you can use it to allocate and
> export dma-bufs, which then get imported by the V4L and DRM drivers.
>
> This goes to the heart of why we have dma-heaps in the first place.
> We don't want to burden userspace with having to figure out the right
> place to get a dma-buf for a given use-case on a given hardware.
> That would be very non-portable, and fail at the core purpose of
> a kernel: to abstract hardware specifics away.
>
> Unfortunately all proposals to use dma-buf heaps were moving in the
> described direction: let app select (somehow) from a platform- and
> vendor- specific list of dma-buf heaps. In the kernel we at least know
> the platform on which the system is running. Userspace generally doesn't
> (and shouldn't). As such, it seems better to me to keep the knowledge in
> the kernel and allow userspace do its job by calling into existing
> device drivers.
>
> The idea of letting the kernel fully abstract away the complexity of inte=
r
> device data exchange is a completely failed design. There has been plenty=
 of
> evidence for that over the years.
>
> Because of this in DMA-buf it's an intentional design decision that
> userspace and *not* the kernel decides where and what to allocate from.
>
> Hmm, ok.
>
> What the kernel should provide are the necessary information what type of
> memory a device can work with and if certain memory is accessible or not.
> This is the part which is unfortunately still not well defined nor
> implemented at the moment.
>
> Apart from that there are a whole bunch of intentional design decision wh=
ich
> should prevent developers to move allocation decision inside the kernel. =
For
> example DMA-buf doesn't know what the content of the buffer is (except fo=
r
> it's total size) and which use cases a buffer will be used with.
>
> So the question if memory should be exposed through DMA-heaps or a driver
> specific allocator is not a question of abstraction, but rather one of th=
e
> physical location and accessibility of the memory.
>
> If the memory is attached to any physical device, e.g. local memory on a
> dGPU, FPGA PCIe BAR, RDMA, camera internal memory etc, then expose the
> memory as device specific allocator.
>
> So, for embedded systems with unified memory all buffers (maybe except
> PCIe BARs) should come from DMA-BUF heaps, correct?
>
>
> From what I know that is correct, yes. Question is really if that will st=
ay this way.
>
> Neural accelerators look a lot stripped down FPGAs these days and the ben=
efit of local memory for GPUs is known for decades.
>
> Could be that designs with local specialized memory see a revival any tim=
e, who knows.
>
> If the memory is not physically attached to any device, but rather just
> memory attached to the CPU or a system wide memory controller then expose
> the memory as DMA-heap with specific requirements (e.g. certain sized pag=
es,
> contiguous, restricted, encrypted, ...).
>
> Is encrypted / protected a part of the allocation contract or should it
> be enforced separately via a call to TEE / SCM / anything else?
>
>
> Well that is a really good question I can't fully answer either. From wha=
t I know now I would say it depends on the design.
>

IMHO, I think Dmitry's proposal to rather allow the TEE device to be
the allocator and exporter of DMA-bufs related to restricted memory
makes sense to me. Since it's really the TEE implementation (OP-TEE,
AMD-TEE, TS-TEE or future QTEE) which sets up the restrictions on a
particular piece of allocated memory. AFAIK, that happens after the
DMA-buf gets allocated and then user-space calls into TEE to set up
which media pipeline is going to access that particular DMA-buf. It
can also be a static contract depending on a particular platform
design.

As Jens noted in the other thread, we already manage shared memory
allocations (from a static carve-out or dynamically mapped) for
communications among Linux and TEE that were based on DMA-bufs earlier
but since we didn't required them to be shared with other devices, so
we rather switched to anonymous memory.

From user-space perspective, it's cleaner to use TEE device IOCTLs for
DMA-buf allocations since it already knows which underlying TEE
implementation it's communicating with rather than first figuring out
which DMA heap to use for allocation and then communicating with TEE
implementation.

-Sumit

