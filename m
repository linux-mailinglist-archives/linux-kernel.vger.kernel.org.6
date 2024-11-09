Return-Path: <linux-kernel+bounces-402747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5029C2B6C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 10:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA3F1F21F60
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 09:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC1A146580;
	Sat,  9 Nov 2024 09:36:40 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA49288D1
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731145000; cv=none; b=gLohSncZLNEQh22bglnbe8Qt19bMM1vu4b2qIDnjkUjQW4yaSiz0gmGD60A2dvffnPiUbvDkFRk2JqTpD5BLUkg26e8qGJI4Blo741/XFmR77KqzfZO0vivocgaFZBJ2YlXpW9hbiVEn1ku41LXLIJjYLQRV3JWn45f0A41dCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731145000; c=relaxed/simple;
	bh=HNdvGZj+fBydYr0bzIM/gBC2pmUEUEe4oUVOIkavGAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=pjMvuX/SJSkja+C2nmoNpBFqAesG8b++nwr6OBiWptoA503k1D9GAMFnM5u4E/DP0ie2iAa1+RxMAY3ox3S7iO6msejkzEVw70PrusPzE/tIWIwWHA3QGAb6eOYEXyg3u2LCFtr89iE/tOc+VZT4wCSgEHhUikKh8tadjfGYLX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-272-7NK4yx_rN4yQrrQ5gWFeOw-1; Sat, 09 Nov 2024 09:36:34 +0000
X-MC-Unique: 7NK4yx_rN4yQrrQ5gWFeOw-1
X-Mimecast-MFC-AGG-ID: 7NK4yx_rN4yQrrQ5gWFeOw
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 9 Nov
 2024 09:36:33 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 9 Nov 2024 09:36:33 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Brian Gerst' <brgerst@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Ard
 Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>
Subject: RE: [PATCH v5 07/16] x86/module: Deal with GOT based stack cookie
 load on Clang < 17
Thread-Topic: [PATCH v5 07/16] x86/module: Deal with GOT based stack cookie
 load on Clang < 17
Thread-Index: AQHbL5u+1+kE21smwUqJwnP284QU6bKutXlA
Date: Sat, 9 Nov 2024 09:36:33 +0000
Message-ID: <9b4d09cd65804714815698b14c77df9e@AcuMS.aculab.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
 <20241105155801.1779119-8-brgerst@gmail.com>
In-Reply-To: <20241105155801.1779119-8-brgerst@gmail.com>
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
X-Mimecast-MFC-PROC-ID: 3UjL6I5ko6VhW1QAqhFCsdSze2WYrmXzLNO8QJgPIBc_1731144993
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Brian Gerst
> Sent: 05 November 2024 15:58
>=20
> From: Ard Biesheuvel <ardb@kernel.org>
>=20
> Clang versions before 17 will not honour -fdirect-access-external-data
> for the load of the stack cookie emitted into each function's prologue
> and epilogue.
>=20
> This is not an issue for the core kernel, as the linker will relax these
> loads into LEA instructions that take the address of __stack_chk_guard
> directly. For modules, however, we need to work around this, by dealing
> with R_X86_64_REX_GOTPCRELX relocations that refer to __stack_chk_guard.
>=20
> In this case, given that this is a GOT load, the reference should not
> refer to __stack_chk_guard directly, but to a memory location that holds
> its address. So take the address of __stack_chk_guard into a static
> variable, and fix up the relocations to refer to that.
>=20
...
> +#if defined(CONFIG_STACKPROTECTOR) && \
> +    defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 170000
> +=09=09case R_X86_64_REX_GOTPCRELX: {
> +=09=09=09static unsigned long __percpu *const addr =3D &__stack_chk_guar=
d;
> +
> +=09=09=09if (sym->st_value !=3D (u64)addr) {
> +=09=09=09=09pr_err("%s: Unsupported GOTPCREL relocation\n", me->name);
> +=09=09=09=09return -ENOEXEC;
> +=09=09=09}
> +
> +=09=09=09val =3D (u64)&addr + rel[i].r_addend;
> +=09=09=09fallthrough;
> +=09=09}
> +#endif

Doesn't this depend on the compiler used to compile the module not that
used to compile this code?
(In principle external modules should be able to use a different compiler.)

So the CLANG tests should be replaced by a comment.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


