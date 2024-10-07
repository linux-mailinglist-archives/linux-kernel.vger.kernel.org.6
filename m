Return-Path: <linux-kernel+bounces-353340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5109992C7A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB541F238C0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927EE1D3634;
	Mon,  7 Oct 2024 13:01:07 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828A1D2796
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306067; cv=none; b=O0H4W4wnfZIEN+AzU3LA9GsWBSc9vI8+b4dSGSk3GYqicldB7c0gWciNui7v3HxiWedgJ8XxisuDCKD4rc//Pb+Sv4z6CjSTeAmzstvPZ8eIA0YJ0D7GY5BvbBPXMevF1e759pBokFWDYn3caUYdNdynhwRcjkUcvNq/3s3OIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306067; c=relaxed/simple;
	bh=1sP1Ynk9VMiTABE6zvnLe2UpYgZmhFwGdyubfrSipu8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Yx087RXowCanCl/7r/rvjChGXFcApwEnh/ze2cjKHxYrJwpsO6ytIRT1LmoRsmBZMhGf/NycLC1maI546t//N4WBquQHm44loKATE/yTYYBOZ7dOUX2dsX+LH0pw8XJONgyg6CcZ7Bw6+NB+XjsjEuB6QMX4w8Hj1W1zm0rWX1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-100-pseT8Iq8O6OlYBL7pVlG4g-1; Mon, 07 Oct 2024 14:00:59 +0100
X-MC-Unique: pseT8Iq8O6OlYBL7pVlG4g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 7 Oct
 2024 14:00:02 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 7 Oct 2024 14:00:02 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Thomas Gleixner' <tglx@linutronix.de>, Bart Van Assche
	<bvanassche@acm.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King
	<linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Clemens Ladisch <clemens@ladisch.de>
Subject: RE: [PATCH 07/21] hpet: Switch to number_of_interrupts()
Thread-Topic: [PATCH 07/21] hpet: Switch to number_of_interrupts()
Thread-Index: AQHbE2TzBkWyNMbR9ESEodEWAH4CWbJ5/e4wgAE/H8eAAAumMA==
Date: Mon, 7 Oct 2024 13:00:02 +0000
Message-ID: <18b139e4a0674892ba69d00e5f170b7f@AcuMS.aculab.com>
References: <20240930181600.1684198-1-bvanassche@acm.org>
 <20240930181600.1684198-8-bvanassche@acm.org>
 <b315cbe2e1264d98b57ce57fe5f66a23@AcuMS.aculab.com>
 <cb045717-5eb8-456f-aa50-667e9f8aabfd@acm.org> <874j5oun7x.ffs@tglx>
In-Reply-To: <874j5oun7x.ffs@tglx>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Thomas Gleixner <tglx@linutronix.de>
> Sent: 07 October 2024 13:12
>=20
> On Sun, Oct 06 2024 at 17:45, Bart Van Assche wrote:
> > On 10/6/24 10:13 AM, David Laight wrote:
> >> From: Bart Van Assche
> >>> Sent: 30 September 2024 19:16
> >>> --- a/drivers/char/hpet.c
> >>> +++ b/drivers/char/hpet.c
> >>> @@ -195,7 +195,7 @@ static void hpet_timer_set_irq(struct hpet_dev *d=
evp)
> >>>   =09=09v &=3D ~0xffff;
> >>>
> >>>   =09for_each_set_bit(irq, &v, HPET_MAX_IRQ) {
> >>> -=09=09if (irq >=3D nr_irqs) {
> >>> +=09=09if (irq >=3D number_of_interrupts()) {
> >>>   =09=09=09irq =3D HPET_MAX_IRQ;
> >>>   =09=09=09break;
> >>>   =09=09}
> >>
> >> This is horrid.
> >> You've replaced the read of a global variable (which, in some cases th=
e
> >> compiler might be able to pull outside the loop) with a real function
> >> call in every loop iteration.
> >>
> >> With all the mitigations for cpu speculative execution 'issues' you
> >> pretty much don't want trivial function calls.
> >>
> >> If you are worried about locals shadowing globals just change one of t=
he names.
> >
> > Since HPET_MAX_IRQ =3D=3D 32 and since the lower 16 bits of 'v' are cle=
ared
> > on modern systems, would it be such a big deal if number_of_interrupts(=
)
> > is called 16 times?
>=20
> No. The context is open() which is a slow path operation.

This was one example of that code loop - and probably not the best
to have picked.
Indeed, it is using a long[] bitmap designed for 'big' bitmaps
for one that fits in 32 bits and (probably) coding a 'find first bit'
function using the impossible HPET_NAX_IRQ value as an error exit.

In any case 'accessor functions' just move the global symbol from
being a data symbol to a code symbol while obfuscating the
code and making it harder to find where values are set and used.

=09David

>=20
> > Since number_of_interrupts() has been marked as __pure, and since the
> > kernel is built with -O2, do you agree that this should be sufficient t=
o
> > let the compiler CSE optimization step move function calls like the
> > above from inside a loop out of the loop?
>=20
> It could do so.
>=20
> Thanks,
>=20
>         tglx

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


