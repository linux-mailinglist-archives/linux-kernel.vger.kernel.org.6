Return-Path: <linux-kernel+bounces-328983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E889978BB8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175A41F25058
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3B017D377;
	Fri, 13 Sep 2024 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="qcpULeM/"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701C6126F02;
	Fri, 13 Sep 2024 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726269028; cv=none; b=VS6hYGzvk4siJq/flAy8WmNShyG8/PEEMwA7MI5LGzzAZePL1qDOxf8Z9+VXw5UXrIdw4oKzslspqTJuv+IZeuuaUHNDvoCy2fBhI7mp1oLX6u15TuhV8OA77HLk56mbjvM+3K5UB0sjqetd3VtQZSKmvh/iBS4o4A1FwZiFJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726269028; c=relaxed/simple;
	bh=2yLhbFWAWF2luOrMk+Vflvgb19tLgTcvxbbwE4a7hiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TBGkoo7GwMJRINXbXWAA3p5L4q+XgUBSYCLdGN7DOzDc5wg5bYuo345FZt/KF6LB7G3GicHGl/vnNbSeFog51Zsu3lcpffgvsaV+mEKJhZkWGcKgaiQN+jnUmUiZZx5vl74pSxspC2PkuBpKpdTzwQA3fNYV+/8l5p8V1o5lCIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=qcpULeM/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726269023;
	bh=gy3hRIQfFMt+naW5uo5M4vgY3O8DQ+s8NBlJGzQZOSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qcpULeM/kqlHDKMJdI99cEZTIQVTUG1Ecedaa6xxZ2uQ3S9WQcM7etXghncO5Prbv
	 B/++QsNVSrw+L08LnkqU/PQPUcwrmjyPFJ8LMWPHoP4JiOqxVU8DQ5S2aBwCdHzxgj
	 JOrqdd9pFb81Gk7i9npf4WZj9gI3xMKGhc52A260yT6MtmxkBLbrH8kWhQZnpEmAes
	 lzYmDQ1Ebg0iml/6IPQhhzzUAj0V/JM8wKMxcCI5OTs7+gBZrxQgdbZDcPaZ4V6Fhm
	 eYwbYbgCLqABXGzISOv7/yAuerVBRW1S7F93NF+mypdUNZCgikRr7cFuZIPoiVWrab
	 hB9aXGh+0fBUw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X595C0jDtz4x8c;
	Sat, 14 Sep 2024 09:10:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Saravana Kannan
 <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] of: address: Unify resource bounds overflow checking
In-Reply-To: <CAL_JsqLYQyue9WyYiQPaM1D8Hxve-a4RXCaDRvyeF2VWWx=Ozg@mail.gmail.com>
References: <20240906-of-address-overflow-v1-1-19567aaa61da@linutronix.de>
 <87plp7r8ye.fsf@mail.lhotse>
 <CAL_JsqLYQyue9WyYiQPaM1D8Hxve-a4RXCaDRvyeF2VWWx=Ozg@mail.gmail.com>
Date: Sat, 14 Sep 2024 09:10:20 +1000
Message-ID: <87mskbqher.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rob Herring <robh@kernel.org> writes:
> On Fri, Sep 13, 2024 at 8:15=E2=80=AFAM Michael Ellerman <mpe@ellerman.id=
.au> wrote:
>> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:
>> > The members "start" and "end" of struct resource are of type
>> > "resource_size_t" which can be 32bit wide.
>> > Values read from OF however are always 64bit wide.
>> >
>> > Refactor the diff overflow checks into a helper function.
>> > Also extend the checks to validate each calculation step.
>> >
>> > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>> > ---
>> >  drivers/of/address.c | 45 ++++++++++++++++++++++++++-----------------=
--
>> >  1 file changed, 26 insertions(+), 19 deletions(-)
>> >
>> > diff --git a/drivers/of/address.c b/drivers/of/address.c
>> > index 7e59283a4472..df854bb427ce 100644
>> > --- a/drivers/of/address.c
>> > +++ b/drivers/of/address.c
>> > @@ -198,6 +198,25 @@ static u64 of_bus_pci_map(__be32 *addr, const __b=
e32 *range, int na, int ns,
>> >
>> >  #endif /* CONFIG_PCI */
>> >
>> > +static int __of_address_resource_bounds(struct resource *r, u64 start=
, u64 size)
>> > +{
>> > +     u64 end =3D start;
>> > +
>> > +     if (overflows_type(start, r->start))
>> > +             return -EOVERFLOW;
>> > +     if (size =3D=3D 0)
>> > +             return -EOVERFLOW;
>> > +     if (check_add_overflow(end, size - 1, &end))
>> > +             return -EOVERFLOW;
>> > +     if (overflows_type(end, r->end))
>> > +             return -EOVERFLOW;
>>
>> This breaks PCI on powerpc qemu. Part of the PCI probe reads a resource
>> that's zero sized, which used to succeed but now fails due to the size
>> check above.
>>
>> The diff below fixes it for me.
>
> I fixed it up with your change.

Thanks.

cheers

