Return-Path: <linux-kernel+bounces-239383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AB9925E85
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365BB1C2308D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CCF183097;
	Wed,  3 Jul 2024 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="HU926B91"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2316DEAC;
	Wed,  3 Jul 2024 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006246; cv=none; b=WuRYQfBJIy/cW3vHWTlkhFaKJIqGV6sJRuNif/bdUdl2KjLDro5XNFAASrY2J45lDKcqobILcCZxj9KgART8m1q8UNO3ZTf1/90J6HBXRIDCzAROc8KMXVOahQ7g4703/Q5cE97zDF0b5UWpb/wOXrLHFo/UpDbT+ec5NbXKmQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006246; c=relaxed/simple;
	bh=hHU8qyvZllQ9YNTnZjbz56zaVVYuI4Ya3gnqfITbJTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Do7yZWRz6QDCyL3aoaviOEXx/oh/oRVKWCux2TfjoizlOpOUWgct3p0M2RHmiv8zhvhgIGB3fIi/s+BWi1/UNWxrA5I2g0rqnX+SDKZ+twmN4/O/tPHjuHfllCRBhVfoUDBUZOI7oi9snjfiOtZAvg0W+lpKlc7L0MzmBPNOcqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=HU926B91; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1720006241;
	bh=hBPfcphJy7Ev3mtEEvsbdYBglsS6/5WB3ZZqmCXJ/5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HU926B91N24lEUx6TCxkH/GKqKj/7NXDsOnGaHqcTfPaoG6/I5SNKLCA7y6EC/YeQ
	 Sv7VirV9nzzOXJUHRJUwpvW5jRDXVbfY1JjEZ2WG7Lky05vbK7t6hWL6YTS5SD2BPO
	 WU4rce17jT8OGRQVKayXyEqpl1haKHOJwR3xVzPYV3eEDvgISidfZSeiYVbUX60GM+
	 2nxD9Hg7Mz+/zf0G78gfhx0LJ0U5vjdX48mJZneviZgO4CAG9xk00t9yknCn6TCGg4
	 r7JUiWmxvtuHE72Un7pYAqzo3UweMNvJTlqrYIPGTBeJCiWSK43iHsGA7xrcbo3yMJ
	 c6IozzeKGp3ww==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WDcz34b52z4xQd;
	Wed,  3 Jul 2024 21:30:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>, Christian
 Zigotzky <chzigotzky@xenosoft.de>
Cc: apatel@ventanamicro.com, DTML <devicetree@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, mad skateman <madskateman@gmail.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Matthew Leaman <matthew@a-eon.biz>,
 Darren Stevens <darren@stevens-zone.net>, Christian Zigotzky
 <info@xenosoft.de>
Subject: Re: [PowerPC] [PASEMI] Issue with the identification of ATA drives
 after the of/irq updates 2024-05-29
In-Reply-To: <CAL_Jsq+_QZHMJGHqw8vFA5CspuouvY_U=+NobYQ52DcwPQx-2w@mail.gmail.com>
References: <3ab66fab-c3f2-4bed-a04d-a10c57dcdd9b@xenosoft.de>
 <86zfqzhgys.wl-maz@kernel.org>
 <CAL_Jsq+_QZHMJGHqw8vFA5CspuouvY_U=+NobYQ52DcwPQx-2w@mail.gmail.com>
Date: Wed, 03 Jul 2024 21:30:38 +1000
Message-ID: <87le2ik90h.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rob Herring <robh@kernel.org> writes:
> On Tue, Jul 2, 2024 at 10:54=E2=80=AFAM Marc Zyngier <maz@kernel.org> wro=
te:
>>
>> On Sun, 30 Jun 2024 11:21:55 +0100,
>> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>> >
>> > Hello,
>> >
>> > There is an issue with the identification of ATA drives with our
>> > P.A. Semi Nemo boards [1] after the
>> > commit "of/irq: Factor out parsing of interrupt-map parent
>> > phandle+args from of_irq_parse_raw()" [2].
>>
>> [snip]
>>
>> My earlier request for valuable debug information still stands. But
>> while you're at it, can you please give the following hack a go?
>>
>>         M.
>>
>> --- a/drivers/of/irq.c
>> +++ b/drivers/of/irq.c
>> @@ -282,8 +282,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_=
phandle_args *out_irq)
>>
>>                         oldimap =3D imap;
>>                         imap =3D of_irq_parse_imap_parent(oldimap, imapl=
en, out_irq);
>> -                       if (!imap)
>> -                               goto fail;
>> +                       if (!imap) {
>> +                               match =3D 0;
>> +                               break;
>> +                       }
>
> AFAICT reading the DT, I don't think this would fix it. imap should
> only be null if malformed. This case to me looks like interrupt-map
> has the correct cell sizes, but just never matches to do the mapping.
> So maybe imaplen is off and that causes us to end up here, but if
> there's an error I don't see it. A boot with DEBUG enabled in
> drivers/of/irq.c would help.
>
>>
>>                         match &=3D of_device_is_available(out_irq->np);
>>                         if (match)
>>
>> This may not be the final workaround even if it solves your boot
>> problem, but will at least give us a hint at what is going wrong.
>>
>> I have the fuzzy feeling that we may be able to lob this broken system
>> as part of the of_irq_imap_abusers[] array, which would solve things
>> pretty "neatly".
>
> I think this would work and would consolidate the work-arounds. It
> would need either "pasemi,rootbus" or "pa-pxp" added to the list.

Not sure if it helps, but there's already some code in arch/powerpc to
"fixup" the nemo device tree at boot.

I'm not sure if it's actually the problem here, but it might be, it does
renumber some interrupts. Or possibly it could be tweaked to fix
whatever the issue is.

The code is in fixup_device_tree_pasemi():

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/powerpc/kernel/prom_init.c?h=3Dv6.10-rc5#n3114

cheers

