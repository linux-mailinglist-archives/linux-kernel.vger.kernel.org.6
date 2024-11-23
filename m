Return-Path: <linux-kernel+bounces-419107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711789D6995
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 16:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDA3AB2147A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 15:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141823FB0E;
	Sat, 23 Nov 2024 15:13:23 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09853BB24
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732374802; cv=none; b=F5dS/fJ6iucS8Zwm1KFQ2GLKh3bcUkWPJ0+BwQBkY69+coEUfEfcU93KvWQ6OTPJn1oSAzx3b326FA3BoNrzaYIq0JAyPr0QvkkMyAsW/qJ7WZY/apMLqrKGPYz7rpPvOjxHWkw99YFS6yCgnBN7qekd8UH43/lkbwTmXq8kc88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732374802; c=relaxed/simple;
	bh=4wvubPOf9jW1pFpxkBhGsajdzo2sg3WLPpNhRgkXBp0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=VJcSVXZU/RSpR8cBYo6dvCLN5ZgPEwTrNylat0jSrZpOYzcDGB23A7b25+6k+8elOB7zQjrLBkVr0Ql02Xl5G2al+/LbEFxjd5LBj5/uu/csyiZaL0eiYoA1laNVVclzmirNOzc8y1EUfn0IaVy5xK/ivMJRNn3Bh2ymPjT0atg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-20-DIREUW6pN_yi7j3_wFxjqw-1; Sat, 23 Nov 2024 15:13:11 +0000
X-MC-Unique: DIREUW6pN_yi7j3_wFxjqw-1
X-Mimecast-MFC-AGG-ID: DIREUW6pN_yi7j3_wFxjqw
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 23 Nov
 2024 15:13:09 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 23 Nov 2024 15:13:09 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mateusz Guzik' <mjguzik@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>, "andy@kernel.org"
	<andy@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: RE: [PATCH 2/2] string: retire bcmp()
Thread-Topic: [PATCH 2/2] string: retire bcmp()
Thread-Index: AQHbPYzPSi+EdCwHIEmNTEknO+eDubLE+IsQ
Date: Sat, 23 Nov 2024 15:13:09 +0000
Message-ID: <5f510b8238824aa6b3534e755f965d85@AcuMS.aculab.com>
References: <20241123094729.1099378-1-mjguzik@gmail.com>
 <20241123094729.1099378-3-mjguzik@gmail.com>
In-Reply-To: <20241123094729.1099378-3-mjguzik@gmail.com>
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
X-Mimecast-MFC-PROC-ID: BASfZHZC5m7GSNozKLWg3CdT2rvF-jH7jIlNvehsNFY_1732374790
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Mateusz Guzik
> Sent: 23 November 2024 09:47
>=20
> While architectures could override it thanks to __HAVE_ARCH_BCMP, none
> of them did. Instead it was implemented as a call to memcmp().
>=20
> These routines differ in the API contract: memcmp()'s result indicates
> which way the difference goes (making it usable for sorting), whereas
> bcmp()'s result merely states whether the buffers differ in any way.
>=20
> This means that a dedicated optimized bcmp() is cheaper to execute than
> memcmp() for differing buffers as there is no need to compute the return
> value.
>=20
> However, per the above nobody bothered to write one and it is unclear if
> it makes sense to do it.
>=20
> Users which really want to compare stuff may want to handle it
> differently (like e.g., the path lookup).
>=20
> As there are no users and the code is merely a wrapper around memcmp(),
> just whack it.
>=20
...
>=20
> -/*
> - * Clang may lower `memcmp =3D=3D 0` to `bcmp =3D=3D 0`.
> - */
> -int bcmp(const void *s1, const void *s2, size_t len)
> -{
> -=09return memcmp(s1, s2, len);
> -}
> -

As per the comment I thought that clang would sometimes generate
calls to bcmp().

So while the two symbols could refer to the same code I don't
think it can be removed.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


