Return-Path: <linux-kernel+bounces-403401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3669C3520
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 23:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD24DB216CB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0DD158A13;
	Sun, 10 Nov 2024 22:43:49 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B27149011
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 22:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731278628; cv=none; b=J74PBwYnBaoSsxD0cWkN2GL7oefRpHMe8u9GYPSnMqWj/4wUg4tdJNp5FbpXjB2ZofTtW8C7v8VHhw3ibsd7mv6uSEIFf3WSsZ8i6CTost6WXS+B6uYikEOtyW4/c7GVdYSQ3MLA6L8gjtnLgPeIPtGY4cbeNtkcrnLBgkQ2n/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731278628; c=relaxed/simple;
	bh=q1YevvDrssk6FKxVvlDBJCyta4t2uTnUfqqsy041gx0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=rIf8QXR3kBH+vGS6YQZ96fLh55dwUBOzxS+DfFN+uQwL0T7q7kybC5XBTFtyWTe2t3hbWQS1QxjS7ESEWdG38vCDHyFFuiLs4iNGqS/y1KhkGeftISgHoi3iRYsBHRsRFM1wpFMf6mgrXEXMwHyzoXLzF8VXVKtJC6CllF/YyXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-85-HCYrDg3LPFuWclGmJlvsfA-1; Sun, 10 Nov 2024 22:43:37 +0000
X-MC-Unique: HCYrDg3LPFuWclGmJlvsfA-1
X-Mimecast-MFC-AGG-ID: HCYrDg3LPFuWclGmJlvsfA
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 10 Nov
 2024 22:43:37 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 10 Nov 2024 22:43:37 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mikel Rychliski' <mikel@mikelr.com>, 'Thomas Gleixner'
	<tglx@linutronix.de>, 'Ingo Molnar' <mingo@redhat.com>, 'Borislav Petkov'
	<bp@alien8.de>, 'Dave Hansen' <dave.hansen@linux.intel.com>,
	"'x86@kernel.org'" <x86@kernel.org>, "'H. Peter Anvin'" <hpa@zytor.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86: Fix off-by-one error in __access_ok
Thread-Topic: [PATCH] x86: Fix off-by-one error in __access_ok
Thread-Index: AQHbMuurJ3dP3nIEdEmbtgzS5bNbELKw4lyggAA2p4A=
Date: Sun, 10 Nov 2024 22:43:36 +0000
Message-ID: <61f2d90d45524e5b931de90f32216e26@AcuMS.aculab.com>
References: <20241109210313.440495-1-mikel@mikelr.com>
 <382372a83d1644f8b3a701ff7e14d5f1@AcuMS.aculab.com>
In-Reply-To: <382372a83d1644f8b3a701ff7e14d5f1@AcuMS.aculab.com>
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
X-Mimecast-MFC-PROC-ID: ms6NXsPelZoDuh-66wrCFaUU2o0VOCSu-F9d4_0RQbY_1731278617
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: David Laight
> Sent: 10 November 2024 19:37
>=20
> From: Mikel Rychliski
> > Sent: 09 November 2024 21:03
> >
> > We were checking one byte beyond the actual range that would be accesse=
d.
> > Originally, valid_user_address would consider the user guard page to be
> > valid, so checks including the final accessible byte would still succee=
d.
>=20
> Did it allow the entire page or just the first byte?
> The test for ignoring small constant sizes rather assumes that accesses
> to the guard page are errored (or transfers start with the first byte).
>=20
> > However, after commit 86e6b1547b3d ("x86: fix user address masking
> > non-canonical speculation issue") this is no longer the case.
> >
> > Update the logic to always consider the final address in the range.
> >
> > Fixes: 86e6b1547b3d ("x86: fix user address masking non-canonical specu=
lation issue")
> > Signed-off-by: Mikel Rychliski <mikel@mikelr.com>
> > ---
> >  arch/x86/include/asm/uaccess_64.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/u=
access_64.h
> > index b0a887209400..3e0eb72c036f 100644
> > --- a/arch/x86/include/asm/uaccess_64.h
> > +++ b/arch/x86/include/asm/uaccess_64.h
> > @@ -100,9 +100,11 @@ static inline bool __access_ok(const void __user *=
ptr, unsigned long size)
> >  =09if (__builtin_constant_p(size <=3D PAGE_SIZE) && size <=3D PAGE_SIZ=
E) {
> >  =09=09return valid_user_address(ptr);
> >  =09} else {
> > -=09=09unsigned long sum =3D size + (__force unsigned long)ptr;
> > +=09=09unsigned long end =3D (__force unsigned long)ptr;
> >
> > -=09=09return valid_user_address(sum) && sum >=3D (__force unsigned lon=
g)ptr;
> > +=09=09if (size)
> > +=09=09=09end +=3D size - 1;
> > +=09=09return valid_user_address(end) && end >=3D (__force unsigned lon=
g)ptr;
>=20
> Why not:
> =09if (statically_true(size <=3D PAGE_SIZE) || !size)
> =09=09return vaid_user_address(ptr);
> =09end =3D ptr + size - 1;
> =09return ptr <=3D end && valid_user_address(end);

Thinking more that version probably bloats the code with two
copies of valid_user_address().

> Although it is questionable whether a zero size should be allowed.
> Also, if you assume that the actual copies are 'reasonably sequential',
> it is valid to just ignore the length completely.
>=20
> It also ought to be possible to get the 'size =3D=3D 0' check out of the =
common path.
> Maybe something like:
> =09if (statically_true(size <=3D PAGE_SIZE)
> =09=09return vaid_user_address(ptr);
> =09end =3D ptr + size - 1;
> =09return (ptr <=3D end || (end++, !size)) && valid_user_address(end);
> You might want a likely() around the <=3D, but I suspect it makes little
> difference on modern x86 (esp. Intel ones).

I can't actually remember Linus's final version and don't have it to hand.
But I'm sure I remember something about a 64bit address constant.
(Probably 'cmpi, sbb, or' and then test the sign or carry flag.)
It might just be enough to increase that by one so that buffers that
end at the boundary are ok.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


