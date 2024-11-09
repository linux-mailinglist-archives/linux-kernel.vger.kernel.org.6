Return-Path: <linux-kernel+bounces-402743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2059C2B64
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 10:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F051C20FE5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 09:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21278143725;
	Sat,  9 Nov 2024 09:31:26 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA758C07
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731144685; cv=none; b=gVYhaW1H1waPemGwxYzZJDDQxZOhdFIFXx5d/VfpArLTgbDVpUvZ4KOofwkMyCU+RsGVtTzojpDWccrfHjkQGvLfwmo01FlvCBvqx0FI7FbMYMFsiyfSf4aRCRS4GsLvxXYxfeen6y3N/Yyj0DuWGhM6ivfnku539j0gQqf261g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731144685; c=relaxed/simple;
	bh=nmCUDuNHLDcX19FSP2qXhpwfBSMY/hg6oqSATWgbUj4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=If8a/QvisMlyfXWlxXqDD8pYjEIQOeJxjE4DP1sSviVDja0CTtBZAEjp/u0jmD12L4PTmIZ6qZ0xiv5xAcwxg2kAvCHjgMEpPRjSufZPrbWphf1ErpnfEAx0V7U03kvX4nCWBoZ/+MPCaP7M0cJhmw4JD1jDEH40YS/o/a04CyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-183-0HvqiLG0OyW2ngknhoJgsg-1; Sat, 09 Nov 2024 09:31:20 +0000
X-MC-Unique: 0HvqiLG0OyW2ngknhoJgsg-1
X-Mimecast-MFC-AGG-ID: 0HvqiLG0OyW2ngknhoJgsg
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 9 Nov
 2024 09:31:19 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 9 Nov 2024 09:31:19 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Brian Gerst' <brgerst@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Ard
 Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>
Subject: RE: [PATCH v5 00/16] x86-64: Stack protector and percpu improvements
Thread-Topic: [PATCH v5 00/16] x86-64: Stack protector and percpu improvements
Thread-Index: AQHbL5uNGPLMH1qOlUeFNPNYyx1uvLKusr0g
Date: Sat, 9 Nov 2024 09:31:19 +0000
Message-ID: <5b42962e05754c15977a102ccd5cc7aa@AcuMS.aculab.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
In-Reply-To: <20241105155801.1779119-1-brgerst@gmail.com>
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
X-Mimecast-MFC-PROC-ID: PRW4KXY7WjWPqYKTQ4hMYAZ9Q8WquqsFnrjOqNGFnOA_1731144679
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Brian Gerst
> Sent: 05 November 2024 15:58
>=20
> Currently, x86-64 uses an unusual percpu layout, where the percpu section
> is linked at absolute address 0.  The reason behind this is that older GC=
C
> versions placed the stack protector (if enabled) at a fixed offset from t=
he
> GS segment base.  Since the GS segement is also used for percpu variables=
,
> this forced the current layout.
>=20
> GCC since version 8.1 supports a configurable location for the stack
> protector value, which allows removal of the restriction on how the percp=
u
> section is linked.  This allows the percpu section to be linked normally,
> like other architectures.  In turn, this allows removal of code that was
> needed to support the zero-based percpu section.
>=20
> v5:
> - Added two patches from Ard Biesheuvel to make stack protector work
>   properly when compiling with clang.
> - Raise minimum GCC version to 8.1 for x86.
> - Drop objtool conversion code.

Is there any actual need to raise the GCC level?
Isn't it enough just to disable stack protection with older compilers?
The percpu layout can then always be the new (sane) one.

Is there even a selectable CONFIG_STACK_PROTECTOR?
Can than depend on gcc >=3D 8.1 for x86-64?

I've a slight vested interest in that the system I test kernels on
has gcc 7.5.0 installed :-)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


