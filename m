Return-Path: <linux-kernel+bounces-284903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA83950692
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442CF287DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3D519B59F;
	Tue, 13 Aug 2024 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="fqEwTgwc"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E5019D069
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556043; cv=none; b=R8enHOG1lBl2ShO0Whk3A9hCEnqEDVxCrOwUOy14ZWNczXjOetCqhQlEcjK+TobTX4X2TU0ekITOt2LerwhVq9EqO3k72tXn9bF7Ur8G0YFeNYO2GM9N5s6KdNpEvsT5TIGeJFWuKP/HefzLIX3sE1cQSArMsDbBg4pENmN82Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556043; c=relaxed/simple;
	bh=IUixtfKmrSEbm+DElpyKbSULFE3VCo1lZcweQ07vKZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNMLHy1mHz+zjAEMC4P2mDzJuA0scaA9yvADfG8sIHc+eX3xqTKMsoWXXGnVW2VTq5W3oO3AeT1fk30+kN+Sn/ZiOZovepiZ0jHsc26XfEycZKsjYO4A54E/Og/hjMcKcRXt0eP453WZJrG/o6xVGD8WzLcOIuT39mPKUGudn3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=fqEwTgwc; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (unknown [193.86.92.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 4C55D1E0F82;
	Tue, 13 Aug 2024 15:33:57 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1723556037; bh=t6gpWH8IPDdk9454o+l9OptGhzjcjk+DvpbWwyHTvow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fqEwTgwcxJ2kyxAQDXiU3eiP16ZLHy0gb/pH8Q1o/Geor1VdWaDiAtXcIZa7niiyZ
	 +fcueGLBlyXcPHRtbt6sOegGQLXB0I9YUgcrlFONTXeQKYgyBdsrL70jjjoxr2Zk8J
	 Ej+vVePwXBtnvuH3L5qLhTftfkXBMM30fzRvVcPGwTlnXpw+5wNDFKIhhGjNKavISH
	 tbCZ2tNuhl13OTLB+uU8yNCCv2FWu81ZVgvOIWJoDH/VwSd61f2HuTpGP9mvmKQl7r
	 Aq90gWKz5djOF0rSao1+raowUK5CePUY1ISPku9S0XJuv2Ba6gvqu1kH6xhcOLvok5
	 +uRdn8eoLetrg==
Date: Tue, 13 Aug 2024 15:33:52 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Baoquan He <bhe@redhat.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
 vgoyal@redhat.com, dyoung@redhat.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, chenjiahao16@huawei.com,
 akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH -next] crash: Fix riscv64 crash memory reserve dead loop
Message-ID: <20240813153338.1972c10c@mordecai.tesarici.cz>
In-Reply-To: <ZrtLz8VHzZIULbOT@arm.com>
References: <20240802090105.3871929-1-ruanjinjie@huawei.com>
	<ZqywtegyIS/YXOVv@MiWiFi-R3L-srv>
	<ZrJ1JkyDVpRRB_9e@arm.com>
	<ZrJ60vopeGDXFZyK@arm.com>
	<20240813104006.520bf42d@mordecai.tesarici.cz>
	<ZrtLz8VHzZIULbOT@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Aug 2024 13:04:31 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> Hi Petr,
>=20
> On Tue, Aug 13, 2024 at 10:40:06AM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > On Tue, 6 Aug 2024 20:34:42 +0100
> > Catalin Marinas <catalin.marinas@arm.com> wrote: =20
> > > I haven't tried but it's possible that this patch also breaks those
> > > arm64 platforms with all RAM above 4GB when CRASH_ADDR_LOW_MAX is
> > > memblock_end_of_DRAM(). Here all memory would be low and in the absen=
ce
> > > of no fallback, it fails to allocate. =20
> >=20
> > I'm afraid you've just opened a Pandora box... ;-) =20
>=20
> Not that bad ;) but, yeah, this patch was dropped in favour of this:
>=20
> https://lore.kernel.org/r/20240812062017.2674441-1-ruanjinjie@huawei.com/

Yes, I have noticed. That one simply preserves the status quo and a
fuzzy definition of "low".

> > Another (unrelated) patch series made us aware of a platforms where RAM
> > starts at 32G, but IIUC the host bridge maps 32G-33G to bus addresses
> > 0-1G, and there is a device on that bus which can produce only 30-bit
> > addresses.
> >=20
> > Now, what was the idea behind allocating some crash memory "low"?
> > Right, it should allow the crash kernel to access devices with
> > addressing constraints. So, on the above-mentioned platform, allocating
> > "low" would in fact mean allocating between 32G and 33G (in host address
> > domain). =20
>=20
> Indeed. If that's not available, the crash kernel won't be able to boot
> (unless the corresponding device is removed from DT or ACPI tables).

Then it may be able to boot, but it won't be able to save a crash dump
on disk or send it over the network, rendering the panic kernel
environment a bit less useful.=20

> > Should we rethink the whole concept of high/low? =20
>=20
> Yeah, it would be good to revisit those at some point. For the time
> being, 'low' in this context on arm64 means ZONE_DMA memory, basically
> the common denominator address range that supports all devices on an
> SoC. For others like x86_32, this means the memory that the kernel can
> actually map (not necessarily device/DMA related).

Ah, right. I forgot that there are also constraints on the placement of
the kernel identity mapping in CPU physical address space.

> So, it's not always about the DMA capabilities but also what the crash
> kernel can map (so somewhat different from the zone allocator case we've
> been discussing in other threads).

It seems to me that a good panic kernel environment requires:

  1. memory where kernel text/data can be mapped (even at early init)
  2. memory that is accessible to I/O devices
  3. memory that can be allocated to user space (e.g. makedumpfile)

The first two blocks may require special placement in bus/CPU physical
address space, the third does not, but it needs to be big enough for
the workload.

I'll try to transform this knowledge into something actionable or even
reviewable.

For now, I agree there's nothing more to discuss.

Thanks
Petr T

