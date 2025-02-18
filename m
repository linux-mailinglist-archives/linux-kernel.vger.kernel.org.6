Return-Path: <linux-kernel+bounces-519848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD4DA3A2B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08D0173558
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFDA26FA56;
	Tue, 18 Feb 2025 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="G6D/Cz8a"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7531026F46E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895747; cv=none; b=BbcEyBNtUS7KYZjW8nfiSlna1NU13HFT68YgSvAPhH+aPH8/t4BejbRHAMghZLacsROohHwliuvJ7/VbcnHQ/scXGc8u9WP8IRAdWmZOLN7spstwOjRLjovN130wYV+z6G4qcF+jK2+kawVUJHaVDQ1jAe2HJDiMb/hhPbtV7lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895747; c=relaxed/simple;
	bh=KjXMgQyDFOilO3Xu47Ib173LdeZX8gmPYDyKndrcKnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ADdiO51GCYdTYoiOfMmUJUq/TZQIpbf9wWvrFPfKBBWAG6mmZEQWSmTTxltNRlTASw2k0oQv2dVTbb0qwZOAayOlN+Zn0SYprB3KBmEuW/6mZx8/Rcwj0J2488aC9uY52DtaqFrcaEecqzaIEXAZHKZd6iMVr8zWJTKyUXtNRlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=G6D/Cz8a; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c0a159ded2so171039485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1739895743; x=1740500543; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KjXMgQyDFOilO3Xu47Ib173LdeZX8gmPYDyKndrcKnk=;
        b=G6D/Cz8aEb5dJ83dZ9JsiHCGz0TlhpYgbtgzy4aETpPLcWWV0Z+ceMRvHoze1CWHra
         AqgEIDGJD6GtUUALYhwcFezDSD/5p5/4hUCFEZIsp6xq6yMXv16/2N0yYOtVWu689plF
         rkKHYo4miiGG6MDfS6y8MzxqE2y6wltqAKa/uvqzngkLj16RPJUkqKlD087qkc/L6dMm
         ordbGe4pvWl+grsu+EZVPfq/7rPfJb7pL+N4i8nuQRVb/wqIadoeKpFsKaholCFvyILv
         EMzZTKJolnOiTaiMDKHBp/qn5x6xbjxcrozahLjF0rv3iERDmpCenKzfy5NEf+bSKpQ7
         9z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739895743; x=1740500543;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjXMgQyDFOilO3Xu47Ib173LdeZX8gmPYDyKndrcKnk=;
        b=MFBBHwHLAvlGDPXnko8peiUyspe+mEUSc94fthNzs3CncjcTmn3t9EPzXJtq+cVV2U
         E5sly2e/jEIfj0EYT7kG29r4tp5VCJqBgm/vGz0OPnre9FgsdgsT6pJ4V6xZsgMaDGn9
         bHs2td3VziYxPYmWWM0edN1twvnWEOfrN6PwxnnD9xf3BDQ/j3FAPDa0kDBsV70CvSOo
         TeKRnQurqPbIakNZmcMFdc5Ead7nZRxoRqTbrXnxXePuFfB9WtNOch7Ik8DdPQXYAY8f
         zIOKELWSj8T7HXPBN2WSjCm/w+qe8M7YWwpsquR7cvba6SAMxjumFA7O6y5rjWvDitWT
         vnJw==
X-Forwarded-Encrypted: i=1; AJvYcCUt0Zk6F2qgp8hNtbERt7rE4b6RZCsukd13vfQ0aP4MT6mcujtOdZO6cEgCq74wYaTBdOqVvwa+5h1/fXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQOeV6ETP+Js6Fz4Y9gb686GJODsyw9UyqsoDNGLDmtF46DhpZ
	Da/tbQ5y3JAFPWLy8Qh1rT8squRWP4AgZ/AaM1WZortEIOGX3OWBnM0QcrL2jFzsgU/P6dZZaRk
	n3fjV7OLBEWdd/GTXGU+uLIqaO4jYjZ+VmpWR/dXfsIFKJi+i
X-Gm-Gg: ASbGncvotFVOFoi28RUgheNlt/j4tYiXkg0tkYvPaHhFbjQuguhOs7Ic/PdYDCUxsvp
	IoHbOBlfk4dRBdM85uywxyqXD+vauB0+/LpwNOAA9rZDX38HZ8FTvMKfW4XfLNXTuoe799Q==
X-Google-Smtp-Source: AGHT+IEbV3293ASWpwU6KwIQOOU1vJS5NgcKsmd6eL12KHdOz9KO5J5HKfrJx309aUhi1VkMOaqfdyrVi2QFW0IL94s=
X-Received: by 2002:a05:620a:1905:b0:7c0:7303:8d78 with SMTP id
 af79cd13be357-7c0b534e90cmr15243285a.44.1739895742877; Tue, 18 Feb 2025
 08:22:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217100809.3962439-1-jens.wiklander@linaro.org>
 <20250212205613.4400a888@collabora.com> <CAFA6WYOaGEPj0xNEDBCoEmjJreEHChjQ2hyXRJ_CYoGhiBonfw@mail.gmail.com>
 <20250213093557.278f5d19@collabora.com> <CAFA6WYOJkSRsH-15QdqXNMd08Q=Dg4NkRd1Cr9LXA+5nozTF6g@mail.gmail.com>
 <20250213134008.4cbef142@collabora.com> <CAPj87rM5Y=-Jgf4mwukicF6Yb-vccn2fpG2X1jNq0upH2+cAEQ@mail.gmail.com>
 <CAHUa44G9hw-z6wzxg=HkVAxPKEW1yES5JTEqRWMvJUJAtcUDkQ@mail.gmail.com>
 <CAPj87rPHnME5Osgnf5-FSAu22mDpLj=dzvhi_NqEcOwr1ThgGw@mail.gmail.com>
 <CAHUa44Gs0D1fBD0=+EDgcQUMeDv4knci9trUkYEc1J98qFV7HQ@mail.gmail.com>
 <CAFA6WYOuTwRPEh3L7+hMyARB_E73xmp+OwhKyS-r4+ryS7=9sw@mail.gmail.com>
 <20250214164856.0d2ead8a@collabora.com> <CAFA6WYPc6EHQwcPuMZRm4C1P6SoDrCzEPUmju_meupB6NXQ1sg@mail.gmail.com>
In-Reply-To: <CAFA6WYPc6EHQwcPuMZRm4C1P6SoDrCzEPUmju_meupB6NXQ1sg@mail.gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 18 Feb 2025 16:22:10 +0000
X-Gm-Features: AWEUYZm4DmHXwV4iRPDNo2H2j8DSqPPY_t2q4WxWwnT6ATyeMsQki0rC9akhuRA
Message-ID: <CAPj87rN-OYTzh5=Gdv619UQD5=x=U6Yt=uV4N1kCs4Zao4RVAg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
To: Boris Brezillon <boris.brezillon@collabora.com>, 
	Jens Wiklander <jens.wiklander@linaro.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Media Mailing List <linux-media@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, 
	"moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, op-tee@lists.trustedfirmware.org, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, 
	Florent Tomasin <florent.tomasin@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Sumit,

On Mon, 17 Feb 2025 at 06:13, Sumit Garg <sumit.garg@linaro.org> wrote:
> On Fri, 14 Feb 2025 at 21:19, Boris Brezillon <boris.brezillon@collabora.com> wrote:
> > I would say one heap per-profile.
>
> And then it would have a per vendor multiplication factor as each
> vendor enforces memory restriction in a platform specific manner which
> won't scale.

Yes, they do enforce it in a platform-specific manner, but so does
TEE. There is no one golden set of semantics which is globally
applicable between all hardware and all products in a useful manner.

So, if we define protected,secure-video +
protected,secure-video-record + protected,trusted-ui heap names, we
have exactly the same number of axes. The only change is from uint32_t
to string.

> > > Christian gave an historical background here [1] as to why that hasn't
> > > worked in the past with DMA heaps given the scalability issues.
> > >
> > > [1] https://lore.kernel.org/dri-devel/e967e382-6cca-4dee-8333-39892d532f71@gmail.com/
> >
> > Hm, I fail to see where Christian dismiss the dma-heaps solution in
> > this email. He even says:
> >
> > > If the memory is not physically attached to any device, but rather just
> > memory attached to the CPU or a system wide memory controller then
> > expose the memory as DMA-heap with specific requirements (e.g. certain
> > sized pages, contiguous, restricted, encrypted, ...).
>
> I am not saying Christian dismissed DMA heaps but rather how
> scalability is an issue. What we are proposing here is a generic
> interface via TEE to the firmware/Trusted OS which can perform all the
> platform specific memory restrictions. This solution will scale across
> vendors.

I read something completely different into Christian's mail.

What Christian is saying is that injecting generic constraint solving
into the kernel doesn't scale. It's not OK to build out generic
infrastructure in the kernel which queries a bunch of leaf drivers and
attempts to somehow come up with something which satisfies
userspace-provided constraints.

But this isn't the same thing as saying 'dma-heaps is wrong'! Again,
there is no additional complexity in the kernel between a dma-heap
which bridges over to TEE, and a TEE userspace interface which also
bridges over to TEE. Both of them are completely fine according to
what he's said.

> > Honestly, when I look at dma-heap implementations, they seem
> > to be trivial shells around existing (more complex) allocators, and the
> > boiler plate [1] to expose a dma-heap is relatively small. The dma-buf
> > implementation, you already have, so we're talking about a hundred
> > lines of code to maintain, which shouldn't be significantly more than
> > what you have for the new ioctl() to be honest.
>
> It will rather be redundant vendor specific code under DMA heaps
> calling into firmware/Trusted OS to enforce memory restrictions as you
> can look into Mediatek example [1]. With TEE subsystem managing that
> it won't be the case as we will provide a common abstraction for the
> communication with underlying firmware/Trusted OS.

Yes, it's common for everyone who uses TEE to implement SVP. It's not
common for the people who do _not_ use TEE to implement SVP. Which
means that userspace has to type out both, and what we're asking in
this thread is: why?

Why should userspace have to support dma-heap allocation for platforms
supporting SVP via a static DT-defined carveout as well as supporting
TEE API allocation for platforms supporting SVP via a dynamic
carveout? What benefit does it bring to have this surfaced as a
completely separate uAPI?

> > And I'll insist on what
> > Daniel said, it's a small price to pay to have a standard interface to
> > expose to userspace. If dma-heaps are not used for this kind things, I
> > honestly wonder what they will be used for...
>
> Let's try not to forcefully find a use-case for DMA heaps when there
> is a better alternative available.

What makes it better? If you could explain very clearly the benefit
userspace will gain from asking TEE to allocate $n bytes for
TEE_IOC_UC_SECURE_VIDEO_PLAY, compared to asking dma-heap to allocate
$n bytes for protected,secure-video, I think that would really help.
Right now, I don't understand how it would be better in any way
whatsoever for userspace. And I think your decision to implement it as
a separate API is based on a misunderstanding of Christian's position.

> I am still failing to see why you
> don't consider following as a standardised user-space interface:
>
> "When user-space has to work with restricted memory, ask TEE device to
> allocate it"

As far as I can tell, having userspace work with the TEE interface
brings zero benefit (again, please correct me if I'm wrong and explain
how it's better). The direct cost - call it a disbenefit - it brings
is that we have to spend a pile of time typing out support for TEE
allocation in every media/GPU/display driver/application, and when we
do any kind of negotiation, we have to have one protocol definition
for TEE and one for non-TEE.

dma-heaps was created to solve the problem of having too many
'allocate $n bytes from $specialplace' uAPIs. The proliferation was
painful and making it difficult for userspace to do what it needed to
do. Userspace doesn't _yet_ make full use of it, but the solution is
to make userspace make full use of it, not to go create entirely
separate allocation paths for unclear reasons.

Besides, I'm writing this from a platform that implements SVP not via
TEE. I've worked on platforms which implement SVP without any TEE,
where the TEE implementation would be at best a no-op stub, and at
worst flat-out impossible.

So that's 'why not TEE as the single uAPI for SVP'. So, again, let's
please turn this around: _why_ TEE? Who benefits from exposing this as
completely separate to the more generic uAPI that we specifically
designed to handle things like this?

Cheers,
Daniel

