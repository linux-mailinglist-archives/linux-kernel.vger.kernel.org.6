Return-Path: <linux-kernel+bounces-203565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 606AE8FDD32
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 05:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EAC1F2386E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A931DFE4;
	Thu,  6 Jun 2024 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="FZjQrAcb"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA692629C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 03:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717643525; cv=none; b=Jc+j+i6g0WX+mGmCer4UP5cmPMVWZ/oQgYbOjAbdFTW7lvXUF0Fu4aQHGCJSqIvsXWH9I0HCebR+gk4LaE3b/4x08OxsKTMAtVCuyYO5Bpp2x795o9oaZOGej0pd/wlg05cwFzQSILyOdWb1vvHnf4W0iMQdQ9eru7c2qRXRTh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717643525; c=relaxed/simple;
	bh=PQDvAOJ/NePyr5xbzBU4sHe719ff3jT8xXEWgA2oi+s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pdzflPwtQdhvNgHcV5TjWLC9jORm+DSCuufJuomT/6evHoT8aosZroC3Lqsv6k7fURgYOREEEMnSCq4t/rrmyjwzhX5s/bjSKtXLaR1xLHR3LVOypBK74xe9d3yoa0K7VdSaiPfz3EbXiKm2Xo3F7kUfeDKHqSeIfr6i+KQHvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=FZjQrAcb; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1717643521;
	bh=uhEiQiptyrYsxItCJnv0z0F+tLwNLlQZxlw5seCMjNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FZjQrAcbKwFxwA8ICfiJcWVszxOw6HBkn6aKkD9VbGYIo9uxin3cwzFK0dbzidONL
	 Ja4DUXaYMayOTjS7pFRVx0qeVZSr9tfWDsWOJ/UtYcKR62Lh/rkmii8fvhROtQ+zSm
	 BM0wJF3WXMmRGCZlUvx1jKFhw7FRAgNrxCyvMQegfsIJKyXo4kQ5Ey4nvQl6NS3ZyA
	 ceQW9rYkMNPDfaRCyVKQJiEFCnIpD/Mn6CqXsaQktk9SyRbvKhwjcfay2lFYKONvvN
	 rWio03m88Ghz30n7sPjlNuvW9sB8Zfj+nTWmnyDlxl9l/6/VwnTB6PQFs6xvaEu/8T
	 mPWFstwZ5H3PQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VvqB84pDKz4wc4;
	Thu,  6 Jun 2024 13:12:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Hildenbrand <david@redhat.com>, Yu Zhao <yuzhao@google.com>,
 Erhard Furtner <erhard_f@mailbox.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: kswapd0: page allocation failure: order:0,
 mode:0x820(GFP_ATOMIC), nodemask=(null),cpuset=/,mems_allowed=0 (Kernel
 v6.5.9, 32bit ppc)
In-Reply-To: <45fc081c-ee8d-4774-a597-708d2924f812@redhat.com>
References: <20240508202111.768b7a4d@yea> <20240515224524.1c8befbe@yea>
 <CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
 <CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
 <45fc081c-ee8d-4774-a597-708d2924f812@redhat.com>
Date: Thu, 06 Jun 2024 13:11:59 +1000
Message-ID: <87tti6pxxc.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Hildenbrand <david@redhat.com> writes:
> On 01.06.24 08:01, Yu Zhao wrote:
>> On Wed, May 15, 2024 at 4:06=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrot=
e:
...
>>=20
>> Your system has 2GB memory and it uses zswap with zsmalloc (which is
>> good since it can allocate from the highmem zone) and zstd/lzo (which
>> doesn't matter much). Somehow -- I couldn't figure out why -- it
>> splits the 2GB into a 0.25GB DMA zone and a 1.75GB highmem zone:
>>=20
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
>> [    0.000000]   Normal   empty
>> [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffffff]
>
> That's really odd. But we are messing with "PowerMac3,6", so I don't=20
> really know what's right or wrong ...

The DMA zone exists because 9739ab7eda45 ("powerpc: enable a 30-bit
ZONE_DMA for 32-bit pmac") selects it.

It's 768MB (not 0.25GB) because it's clamped at max_low_pfn:

#ifdef CONFIG_ZONE_DMA
	max_zone_pfns[ZONE_DMA]	=3D min(max_low_pfn,
				      1UL << (zone_dma_bits - PAGE_SHIFT));
#endif

Which comes eventually from CONFIG_LOWMEM_SIZE, which defaults to 768MB.

I think it's 768MB because the user:kernel split is 3G:1G, and then the
kernel needs some of that 1G virtual space for vmalloc/ioremap/highmem,
so it splits it 768M:256M.

Then ZONE_NORMAL is empty because it is also limited to max_low_pfn:

	max_zone_pfns[ZONE_NORMAL] =3D max_low_pfn;

The rest of RAM is highmem.

So I think that's all behaving as expected, but I don't know 32-bit /
highmem stuff that well so I could be wrong.

cheers

