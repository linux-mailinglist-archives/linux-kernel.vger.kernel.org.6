Return-Path: <linux-kernel+bounces-521598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D3EA3BFBF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8A918863C1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2E71E32D3;
	Wed, 19 Feb 2025 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GEdv5sNb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D17A1E0080
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971327; cv=none; b=LVlobsgah/5jGU81UsphVlssmaZvn6JdenjDc7SMN4/68hXYxqDxqnN5YPnIx3qpa3LTGfduHvVq6WaAW98VWmO9bgmkZKU9Gk2FCbuB0pm+zFX4vdn9ds/IHkpqz062F9DwgW3SRiU7BiJE2rXmYUbYNv8qCffbJmIJ4dokqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971327; c=relaxed/simple;
	bh=YUJnJ8rhFc5+I3E/mQ85kMmP6w34U3tXi31VSVl/cVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmmNcgAdP1ZD5hXXw+Go1NO8EcBMaZx90KGbT0emaxzX1AvQ4EL2UcHyTKiw2GAzlAePyiDk2DHqtuc5SNKr/pWJY2WyCgEz0Aj/Il4CyBR9xYLr8n4KYlkEUpwiq1FWRxpm6dP48KCR8mBWv6rWb6eMU9RQU/mp40wJK79OUew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=GEdv5sNb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4398e3dfc66so25338075e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1739971323; x=1740576123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItERCttD4ZqCJ2HvXTOXVmKnbOGbB9MYcRuiAClfxiU=;
        b=GEdv5sNbDi5b8ZzkRcaHABWfsg7coesfr1FjBksAfTWv3wu+XsAJSwsOiipmPG5WCb
         VtE8KXX2Dq7/ZB8enCA21wP4IJzEawxotKD+XXncpunW63WH6t75n1/LFBB/lZMGAioH
         +MD4RJpGBExuALUY3ucPq3OkzLBoA1LnOkQ34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739971323; x=1740576123;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItERCttD4ZqCJ2HvXTOXVmKnbOGbB9MYcRuiAClfxiU=;
        b=QWxz/h6js1MPhjxAMKLyd+9OwHuN0vJbb+GEIBe/2gdQGwIAV6rMKNVjdHr0D2X2pB
         7wTTl1LANrMAAx6S2Sd4/iq3opwwaoBornBgrYK/DHcwTUvxPx3X9c6VIbGDdaNNe2Le
         dKGCCiNb3PFIZ5w1KrHTxbdkfeyigws26EthwnPaHEVIJIZhjErV9jl7ZDqynzfwzbD/
         dloDNVKczTFPJOsjxng5d+fSP3grc7mmxBAmf8ESL/AB4qIsZhMX3QJKasJhZxWoIgXh
         cEJq3k7a3VYTpQl8WeqL6Ok+jlcJDOP9v6uutYsSzE5cFb8mymdFEI0JaY5oVzVPvWbU
         N67A==
X-Forwarded-Encrypted: i=1; AJvYcCUL4XIqTEgt+/x4fpnqoZ08THSZhgwiIzcDas3RTuzTkXT3343GPaeQeCQ8D8rBNd5bRbH6HDnWxzhqTf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Nth+gW+hvKlgNQuDTQu5bfzDfDlhahccNrhvXNHMQ58iMgr6
	Vqe494mXfBF0oi1ao1LzbruoZu1yQD81VzW05orWtyTdWMrEe8EtHtJY2mLlJco=
X-Gm-Gg: ASbGncuvyFU9iq/S8eWECv0jkB1rFG1QMvlIfmZ2cMvSGNCpfSNVMnWsNHArAcYt9IQ
	zrcJJj+E7LTmq8+WF4pRlfB//utFQhwMJtETAq7qGY4W71w4L4+SGvCjYVhG3r4ZXROORFmR/sz
	NJ/+sUkt96qKBdXRpH1RV/vEzLKUEjVLs3SbMmcF6mByQE+fkqNY5BTyofTtYTwivmDDHiT7n+Q
	od9yweodeE0ixk3AZxyMdfW+ftfwddYcKcIEue3GV+y47rK3W6hm6K7Qfg1TXGixNyrAW5nHkmW
	jHT6FPAcN+PH4VlmZQSAjYyT7nM=
X-Google-Smtp-Source: AGHT+IFOilwBJ5aoh97zcLA4mj4xU/YMSCmbCjCXU9wojxNHTeliFqqcujswwLdduRHkO4EdT9IN9A==
X-Received: by 2002:a05:600c:1c18:b0:439:6e12:fdb4 with SMTP id 5b1f17b1804b1-43999da3ac7mr40722565e9.14.1739971323224;
        Wed, 19 Feb 2025 05:22:03 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5ef9sm17846401f8f.76.2025.02.19.05.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:22:02 -0800 (PST)
Date: Wed, 19 Feb 2025 14:22:00 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Daniel Stone <daniel@fooishbar.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	"moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Olivier Masse <olivier.masse@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	azarrabi@qti.qualcomm.com,
	Florent Tomasin <florent.tomasin@arm.com>
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
Message-ID: <Z7Xa-K0aOqcndICH@phenom.ffwll.local>
Mail-Followup-To: Daniel Stone <daniel@fooishbar.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	"moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Olivier Masse <olivier.masse@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	azarrabi@qti.qualcomm.com,
	Florent Tomasin <florent.tomasin@arm.com>
References: <CAFA6WYOJkSRsH-15QdqXNMd08Q=Dg4NkRd1Cr9LXA+5nozTF6g@mail.gmail.com>
 <20250213134008.4cbef142@collabora.com>
 <CAPj87rM5Y=-Jgf4mwukicF6Yb-vccn2fpG2X1jNq0upH2+cAEQ@mail.gmail.com>
 <CAHUa44G9hw-z6wzxg=HkVAxPKEW1yES5JTEqRWMvJUJAtcUDkQ@mail.gmail.com>
 <CAPj87rPHnME5Osgnf5-FSAu22mDpLj=dzvhi_NqEcOwr1ThgGw@mail.gmail.com>
 <CAHUa44Gs0D1fBD0=+EDgcQUMeDv4knci9trUkYEc1J98qFV7HQ@mail.gmail.com>
 <CAFA6WYOuTwRPEh3L7+hMyARB_E73xmp+OwhKyS-r4+ryS7=9sw@mail.gmail.com>
 <20250214164856.0d2ead8a@collabora.com>
 <CAFA6WYPc6EHQwcPuMZRm4C1P6SoDrCzEPUmju_meupB6NXQ1sg@mail.gmail.com>
 <CAPj87rN-OYTzh5=Gdv619UQD5=x=U6Yt=uV4N1kCs4Zao4RVAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPj87rN-OYTzh5=Gdv619UQD5=x=U6Yt=uV4N1kCs4Zao4RVAg@mail.gmail.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Tue, Feb 18, 2025 at 04:22:10PM +0000, Daniel Stone wrote:
> Hi Sumit,
> 
> On Mon, 17 Feb 2025 at 06:13, Sumit Garg <sumit.garg@linaro.org> wrote:
> > On Fri, 14 Feb 2025 at 21:19, Boris Brezillon <boris.brezillon@collabora.com> wrote:
> > > I would say one heap per-profile.
> >
> > And then it would have a per vendor multiplication factor as each
> > vendor enforces memory restriction in a platform specific manner which
> > won't scale.
> 
> Yes, they do enforce it in a platform-specific manner, but so does
> TEE. There is no one golden set of semantics which is globally
> applicable between all hardware and all products in a useful manner.
> 
> So, if we define protected,secure-video +
> protected,secure-video-record + protected,trusted-ui heap names, we
> have exactly the same number of axes. The only change is from uint32_t
> to string.
> 
> > > > Christian gave an historical background here [1] as to why that hasn't
> > > > worked in the past with DMA heaps given the scalability issues.
> > > >
> > > > [1] https://lore.kernel.org/dri-devel/e967e382-6cca-4dee-8333-39892d532f71@gmail.com/
> > >
> > > Hm, I fail to see where Christian dismiss the dma-heaps solution in
> > > this email. He even says:
> > >
> > > > If the memory is not physically attached to any device, but rather just
> > > memory attached to the CPU or a system wide memory controller then
> > > expose the memory as DMA-heap with specific requirements (e.g. certain
> > > sized pages, contiguous, restricted, encrypted, ...).
> >
> > I am not saying Christian dismissed DMA heaps but rather how
> > scalability is an issue. What we are proposing here is a generic
> > interface via TEE to the firmware/Trusted OS which can perform all the
> > platform specific memory restrictions. This solution will scale across
> > vendors.
> 
> I read something completely different into Christian's mail.
> 
> What Christian is saying is that injecting generic constraint solving
> into the kernel doesn't scale. It's not OK to build out generic
> infrastructure in the kernel which queries a bunch of leaf drivers and
> attempts to somehow come up with something which satisfies
> userspace-provided constraints.

Fully agreeing. The one thing we discussed, but haven't implemented yet,
is that we'd add sysfs links from devices to the dma-heaps they support.
Including allowing for priorities and different use-cases on the same
device. We just haven't gotten there yet.

But even with that it's up to userspace to do the constraint solving, not
the kernel.

> But this isn't the same thing as saying 'dma-heaps is wrong'! Again,
> there is no additional complexity in the kernel between a dma-heap
> which bridges over to TEE, and a TEE userspace interface which also
> bridges over to TEE. Both of them are completely fine according to
> what he's said.
>
> > > Honestly, when I look at dma-heap implementations, they seem
> > > to be trivial shells around existing (more complex) allocators, and the
> > > boiler plate [1] to expose a dma-heap is relatively small. The dma-buf
> > > implementation, you already have, so we're talking about a hundred
> > > lines of code to maintain, which shouldn't be significantly more than
> > > what you have for the new ioctl() to be honest.
> >
> > It will rather be redundant vendor specific code under DMA heaps
> > calling into firmware/Trusted OS to enforce memory restrictions as you
> > can look into Mediatek example [1]. With TEE subsystem managing that
> > it won't be the case as we will provide a common abstraction for the
> > communication with underlying firmware/Trusted OS.
> 
> Yes, it's common for everyone who uses TEE to implement SVP. It's not
> common for the people who do _not_ use TEE to implement SVP. Which
> means that userspace has to type out both, and what we're asking in
> this thread is: why?
> 
> Why should userspace have to support dma-heap allocation for platforms
> supporting SVP via a static DT-defined carveout as well as supporting
> TEE API allocation for platforms supporting SVP via a dynamic
> carveout? What benefit does it bring to have this surfaced as a
> completely separate uAPI?
> 
> > > And I'll insist on what
> > > Daniel said, it's a small price to pay to have a standard interface to
> > > expose to userspace. If dma-heaps are not used for this kind things, I
> > > honestly wonder what they will be used for...
> >
> > Let's try not to forcefully find a use-case for DMA heaps when there
> > is a better alternative available.
> 
> What makes it better? If you could explain very clearly the benefit
> userspace will gain from asking TEE to allocate $n bytes for
> TEE_IOC_UC_SECURE_VIDEO_PLAY, compared to asking dma-heap to allocate
> $n bytes for protected,secure-video, I think that would really help.
> Right now, I don't understand how it would be better in any way
> whatsoever for userspace. And I think your decision to implement it as
> a separate API is based on a misunderstanding of Christian's position.
> 
> > I am still failing to see why you
> > don't consider following as a standardised user-space interface:
> >
> > "When user-space has to work with restricted memory, ask TEE device to
> > allocate it"
> 
> As far as I can tell, having userspace work with the TEE interface
> brings zero benefit (again, please correct me if I'm wrong and explain
> how it's better). The direct cost - call it a disbenefit - it brings
> is that we have to spend a pile of time typing out support for TEE
> allocation in every media/GPU/display driver/application, and when we
> do any kind of negotiation, we have to have one protocol definition
> for TEE and one for non-TEE.
> 
> dma-heaps was created to solve the problem of having too many
> 'allocate $n bytes from $specialplace' uAPIs. The proliferation was
> painful and making it difficult for userspace to do what it needed to
> do. Userspace doesn't _yet_ make full use of it, but the solution is
> to make userspace make full use of it, not to go create entirely
> separate allocation paths for unclear reasons.
> 
> Besides, I'm writing this from a platform that implements SVP not via
> TEE. I've worked on platforms which implement SVP without any TEE,
> where the TEE implementation would be at best a no-op stub, and at
> worst flat-out impossible.
> 
> So that's 'why not TEE as the single uAPI for SVP'. So, again, let's
> please turn this around: _why_ TEE? Who benefits from exposing this as
> completely separate to the more generic uAPI that we specifically
> designed to handle things like this?

Completely concurring on everything said above. TEE exposed through a
dma-buf heap (or maybe special v4l allocation flag for secure video
playback) and then we prime import that on the display side. Maybe also
through drm render drivers for the EGL/VK protected content extensions.
Same for any other hw means to allocate content protected buffers, TEE is
not special here at all.

Anything else needs seriously good justifications why the entire dma-buf
heap design is busted.

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

