Return-Path: <linux-kernel+bounces-525663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C20A3F2E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2F53AFD59
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9B21EEA56;
	Fri, 21 Feb 2025 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2AnMbjA"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9D12AE89
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740137087; cv=none; b=ZKS0v9ZgFa+/9ytNE3A5tBEB4B/PSpbrb3ezJyxON1D5rDXqUfYWT+Y24DIeZHorezrTxZCP/TqgjWySmgj3PHkcScCSfDhjcTFKOjKsNtmJK/RIK5vM7YP6ecN8YNrNq4Q77vxSnM9BQQa3AVZJaq3I6QGCMGfVqAXeyR+4390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740137087; c=relaxed/simple;
	bh=mO2jRFaFJdWmTcwxZnmDPcxRdQBDuoP9Nw670+BH+Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XiQzB9LsKuD9G1gOiFrwxBbXZfO2LOoLssOptlK49uwtU7CU6tl0/RDjJ8x6C9vD56RNVd7t+wqbw3tUUxpYvbiJY9uKyK0vf1wHUA8bYBvPJhV30JHJht15ZteGMLodhjCXaM/1jwfhv/57aGTKXdo0XeNcSZCtChPHQgjD880=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M2AnMbjA; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-866faa61728so1080032241.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740137084; x=1740741884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mQpj5OYtvrzGwuvsGqLuFUVRvPktL6wX4C7ZRj/Lz9g=;
        b=M2AnMbjAw05oC9q8TFgGjgnKbULoQF34OFSU4B86FikkhIgh2Rfk/4EsCgNloA0D97
         1PT/vJA9XAWqFPjfKP1pREeBlzPHs+XZqj3rzQczTC0pAq+cxiBuExQ1EyXzw5d8Wpfs
         ldkcagB98vHj6KMT3y6/sJokO8uWI6iYkaLqm+3Gr9zVx6sA59DKCETqxi7Yv8njPdjV
         dTlbvzZct+HDD7yWUlQIqYV0vT6vIX+RdtIJXmliSSEEMAB0+wG+RgVbW9h6KgxPLQ5a
         NbGwDvcKtD8Hx0QWQbAhvodgr0LGL+sZlcjAQooTKeydt8r0SfZeiODHYQ6+cyvolNvk
         epWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740137084; x=1740741884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQpj5OYtvrzGwuvsGqLuFUVRvPktL6wX4C7ZRj/Lz9g=;
        b=WqoIiJAWcflnr8dOFy/OPZkPPmgH6RU0YJD5XCWLCY0OIwjGtY3/eOS0C8W0pYwzXG
         ugt9UXyjnwu5IFQuXbphS+549v+M368FLwKHh01ib2NORg25WVrGkK7uM1LRJFEentQB
         PPjSMzAenCLJkxHDPnc9CJXGni4sSKlELxnUowqQlsMLrQ3QQMFbwFxnHHe9duiVDVZD
         JePeubdwc5keaJeYcvttDFjwlg8OIPz2egQJQtCNALV67W/iO2J/mw2PnRHYhA0nkU6/
         Dhu4GGVJ3w0Esu9ndGAMl3KGAYkNaky6fWatM5eS6dREDA9YvS99nd3QAtk3gtXT+Ml3
         DyRA==
X-Forwarded-Encrypted: i=1; AJvYcCVh2IjLfPF6F4w0QIu/AfpzhfxrMC8LdJVZoOgq512YlUah5rV57Ea2MLjGi/wqIOB5LVZTJNc7upqVFa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6+iLqVPp2szX8NDnu/1o1isVyPslMglnMRpjwgSRYMXGsuvJA
	t9ODWbgobwhCjnz4L4vXSic0XBLAeljIMoXtCJoxez8a9lpNm3F5Dr3fyw9yCIaXD4wqj6lomwx
	mcHqiSnPJZsnUaGbZn72w1KQFfXkqb+IHPiTp+A==
X-Gm-Gg: ASbGncsg1xd1NK3x9J6Wyt/JeBPPHxEjcsxj1l/mAYJ8M/nwUZQZpdo/7iBGvpQ/xcw
	rrZ6QcRd5wSNiM4Z3k0KTuCSRkrSKiJcXSvgYk/wtwMFo8DgbLvTfSC638CGYpRxrf1DMhBCThk
	ORgT+IyDPUtw==
X-Google-Smtp-Source: AGHT+IEEFDT7zw2jzeYUu4scukbdYB4lknasD3bWh5ghSoREMknA9fEDbTJjpM6XHz/2KAnn95mbCSQMBgCOtTskL2U=
X-Received: by 2002:a05:6102:32d6:b0:4bb:ba51:7d4d with SMTP id
 ada2fe7eead31-4bfc0025f2bmr1746137137.8.1740137084336; Fri, 21 Feb 2025
 03:24:44 -0800 (PST)
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
 <CAPj87rN-OYTzh5=Gdv619UQD5=x=U6Yt=uV4N1kCs4Zao4RVAg@mail.gmail.com>
In-Reply-To: <CAPj87rN-OYTzh5=Gdv619UQD5=x=U6Yt=uV4N1kCs4Zao4RVAg@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 21 Feb 2025 16:54:33 +0530
X-Gm-Features: AWEUYZmWGLJSr8dI5fGVPvBYBUuW01AR9UFyCT0aSOf_de_3Q9BR4iWL6l6nzQw
Message-ID: <CAFA6WYMLLLSuz3y5J+DuRFAGrmwpZoWax5sasfAUhXoQXmrNNA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
To: Daniel Stone <daniel@fooishbar.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
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

On Tue, 18 Feb 2025 at 21:52, Daniel Stone <daniel@fooishbar.org> wrote:
>
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
>
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

Can you elaborate the non-TEE use-case for Secure Video Path (SVP) a
bit more? As to how the protected/encrypted media content pipeline
works? Which architecture support does your use-case require? Is there
any higher privileged level firmware interaction required to perform
media content decryption into restricted memory? Do you plan to
upstream corresponding support in near future?

Let me try to elaborate on the Secure Video Path (SVP) flow requiring
a TEE implementation (in general terms a higher privileged firmware
managing the pipeline as the kernel/user-space has no access
permissions to the plain text media content):

- Firstly a content decryption key is securely provisioned into the
TEE implementation.
- Interaction with TEE to set up access permissions of different
peripherals in the media pipeline so that they can access restricted
memory.
- Interaction with TEE to allocate restricted memory buffers.
- Interaction with TEE to decrypt downloaded encrypted media content
from normal memory buffers to restricted memory buffers.
- Then the further media pipeline is able to process the plain media
content in restricted buffers and display it.

>
> So that's 'why not TEE as the single uAPI for SVP'.

Let's try to see if your SVP use-case really converges with TEE based
SVP such that we really need a single uAPI.

> So, again, let's
> please turn this around: _why_ TEE? Who benefits from exposing this as
> completely separate to the more generic uAPI that we specifically
> designed to handle things like this?

The bridging between DMA heaps and TEE would still require user-space
to perform an IOCTL into TEE to register the DMA-bufs as you can see
here [1]. Then it will rather be two handles for user-space to manage.
Similarly during restricted memory allocation/free we need another
glue layer under DMA heaps to TEE subsystem.

The reason is simply which has been iterated over many times in the
past threads that:

    "If user-space has to interact with a TEE device for SVP use-case
then why it's not better to ask TEE to allocate restricted DMA-bufs
too"

[1] https://lkml.indiana.edu/hypermail/linux/kernel/2408.3/08296.html

-Sumit

