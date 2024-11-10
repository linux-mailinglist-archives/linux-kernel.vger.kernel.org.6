Return-Path: <linux-kernel+bounces-403343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDF39C3469
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 20:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A33C1F21A0C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 19:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB6E13B5B3;
	Sun, 10 Nov 2024 19:36:56 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A2C10A3E
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731267415; cv=none; b=dVh4M8hGY2MmWPROnfPM+Z3+3+a2Wvq9+ifg8hp6/PdEiF16ChV5w6IALq4p/MeK9oO4+C7ixICrzwiKeY1VKXcIiX8Og5j0oKYuamJ34lA8oY2OG06T8+HCvvX5FyGhB/+lBI14ki4gT/DfSUCK5Bo53dIKFxI9HIHaDURyPrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731267415; c=relaxed/simple;
	bh=RSjYjlMBAPgjWvDqrJ6wSYyz64FvRDdzioBJPkK+s4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=FsRJpLYcl4S40iUM9TrVPnb0NPi3KWe8HjjzKxsWmtZi1JpmUKc9mkpxyiXBce3zFzh212YX33PxYnvpT4bedpnU+d8w2cebaFuUs3y0yk2LAdrRtnJ316yWm5flgIMnEVrU4C5vQalkzAqcDIHq5qSB8yOomv8SIo7yCs3aKcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-315-YmImktNINPKmDW0WXpIjdA-1; Sun, 10 Nov 2024 19:36:50 +0000
X-MC-Unique: YmImktNINPKmDW0WXpIjdA-1
X-Mimecast-MFC-AGG-ID: YmImktNINPKmDW0WXpIjdA
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 10 Nov
 2024 19:36:49 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 10 Nov 2024 19:36:49 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mikel Rychliski' <mikel@mikelr.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86: Fix off-by-one error in __access_ok
Thread-Topic: [PATCH] x86: Fix off-by-one error in __access_ok
Thread-Index: AQHbMuurJ3dP3nIEdEmbtgzS5bNbELKw4lyg
Date: Sun, 10 Nov 2024 19:36:49 +0000
Message-ID: <382372a83d1644f8b3a701ff7e14d5f1@AcuMS.aculab.com>
References: <20241109210313.440495-1-mikel@mikelr.com>
In-Reply-To: <20241109210313.440495-1-mikel@mikelr.com>
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
X-Mimecast-MFC-PROC-ID: h2f-XIJxAUIEdafxzaJKlFomBS0WH8GQA6uWq4GBuHk_1731267409
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Mikel Rychliski
> Sent: 09 November 2024 21:03
>=20
> We were checking one byte beyond the actual range that would be accessed.
> Originally, valid_user_address would consider the user guard page to be
> valid, so checks including the final accessible byte would still succeed.

Did it allow the entire page or just the first byte?
The test for ignoring small constant sizes rather assumes that accesses
to the guard page are errored (or transfers start with the first byte).

> However, after commit 86e6b1547b3d ("x86: fix user address masking
> non-canonical speculation issue") this is no longer the case.
>=20
> Update the logic to always consider the final address in the range.
>=20
> Fixes: 86e6b1547b3d ("x86: fix user address masking non-canonical specula=
tion issue")
> Signed-off-by: Mikel Rychliski <mikel@mikelr.com>
> ---
>  arch/x86/include/asm/uaccess_64.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uac=
cess_64.h
> index b0a887209400..3e0eb72c036f 100644
> --- a/arch/x86/include/asm/uaccess_64.h
> +++ b/arch/x86/include/asm/uaccess_64.h
> @@ -100,9 +100,11 @@ static inline bool __access_ok(const void __user *pt=
r, unsigned long size)
>  =09if (__builtin_constant_p(size <=3D PAGE_SIZE) && size <=3D PAGE_SIZE)=
 {
>  =09=09return valid_user_address(ptr);
>  =09} else {
> -=09=09unsigned long sum =3D size + (__force unsigned long)ptr;
> +=09=09unsigned long end =3D (__force unsigned long)ptr;
>=20
> -=09=09return valid_user_address(sum) && sum >=3D (__force unsigned long)=
ptr;
> +=09=09if (size)
> +=09=09=09end +=3D size - 1;
> +=09=09return valid_user_address(end) && end >=3D (__force unsigned long)=
ptr;

Why not:
=09if (statically_true(size <=3D PAGE_SIZE) || !size)
=09=09return vaid_user_address(ptr);
=09end =3D ptr + size - 1;
=09return ptr <=3D end && valid_user_address(end);

Although it is questionable whether a zero size should be allowed.
Also, if you assume that the actual copies are 'reasonably sequential',
it is valid to just ignore the length completely.

It also ought to be possible to get the 'size =3D=3D 0' check out of the co=
mmon path.
Maybe something like:
=09if (statically_true(size <=3D PAGE_SIZE)
=09=09return vaid_user_address(ptr);
=09end =3D ptr + size - 1;
=09return (ptr <=3D end || (end++, !size)) && valid_user_address(end);
You might want a likely() around the <=3D, but I suspect it makes little
difference on modern x86 (esp. Intel ones).

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


