Return-Path: <linux-kernel+bounces-426593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348DD9DF562
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 12:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B45CBB20E8B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 11:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5F014F9FD;
	Sun,  1 Dec 2024 11:25:59 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF6978685
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733052358; cv=none; b=RWOdETk6FyZBTeFKRgDHHOMlvDXp2gHT9m4NL35eSkLc4aBskbCoH+aVDOQF0V4dHm2BnaYOKjAeFOTCb8XD8unk2ujfGCrzPDF1CyEcdgYFFUXgjVnfPMHRCtZGGvjL8HfC/Sogxo2KtyiQF9QWqZURXCvUc9/9EsSkxZNr7go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733052358; c=relaxed/simple;
	bh=SBBkky98OJjXMZ9CqvROJRdwHQZkTXRrd32mPKVLjQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=OtJMh2DwemgoTfwXezQImw6kGigsMfrApY07Ck61JaNiPwGUDpr3n9Zoctr4lJAeeH+3H0hCwHnKzMIYTe9mykdBt5INZdL8mUY+WWsm/jIpuXZekWkUPBI2rZbSM1wMZEzSCBQv2ZAkmRuUPJkRFuaBZ4Hga20kp5aA2NY5bsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-225-NV_Q34KzMfa5COxNqpu3nw-1; Sun, 01 Dec 2024 11:25:54 +0000
X-MC-Unique: NV_Q34KzMfa5COxNqpu3nw-1
X-Mimecast-MFC-AGG-ID: NV_Q34KzMfa5COxNqpu3nw
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 1 Dec
 2024 11:25:28 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 1 Dec 2024 11:25:28 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, 'Andrew Cooper'
	<andrew.cooper3@citrix.com>, "'bp@alien8.de'" <bp@alien8.de>, "'Josh
 Poimboeuf'" <jpoimboe@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "'x86@kernel.org'" <x86@kernel.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, 'Arnd Bergmann' <arnd@kernel.org>, "'Mikel
 Rychliski'" <mikel@mikelr.com>, 'Thomas Gleixner' <tglx@linutronix.de>,
	"'Ingo Molnar'" <mingo@redhat.com>, 'Borislav Petkov' <bp@alien8.de>, 'Dave
 Hansen' <dave.hansen@linux.intel.com>, "'H. Peter Anvin'" <hpa@zytor.com>
Subject: RE: [PATCH v2] x86: Allow user accesses to the base of the guard page
Thread-Topic: [PATCH v2] x86: Allow user accesses to the base of the guard
 page
Thread-Index: Ads+hc9sKIgnrLHqRG2ra9Mk31sA5wFXVK1g
Date: Sun, 1 Dec 2024 11:25:28 +0000
Message-ID: <f8d7c27c16994cabb053762b3906673c@AcuMS.aculab.com>
References: <0edca3e5d2194cdf9812a8ccb42216e9@AcuMS.aculab.com>
In-Reply-To: <0edca3e5d2194cdf9812a8ccb42216e9@AcuMS.aculab.com>
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
X-Mimecast-MFC-PROC-ID: Y7PwMQFL-sQahUDDkjTPOxaELhqkx5sybuDzyaJDyBI_1733052353
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

CC stable.

This needs picking up for 6.12

Head commit 573f45a9f9a47 applied by Linus with a modified commit message.

=09David

> -----Original Message-----
> From: David Laight
> Sent: 24 November 2024 15:39
> To: 'Linus Torvalds' <torvalds@linux-foundation.org>; 'Andrew Cooper' <an=
drew.cooper3@citrix.com>;
> 'bp@alien8.de' <bp@alien8.de>; 'Josh Poimboeuf' <jpoimboe@kernel.org>
> Cc: 'x86@kernel.org' <x86@kernel.org>; 'linux-kernel@vger.kernel.org' <li=
nux-kernel@vger.kernel.org>;
> 'Arnd Bergmann' <arnd@kernel.org>; 'Mikel Rychliski' <mikel@mikelr.com>; =
'Thomas Gleixner'
> <tglx@linutronix.de>; 'Ingo Molnar' <mingo@redhat.com>; 'Borislav Petkov'=
 <bp@alien8.de>; 'Dave
> Hansen' <dave.hansen@linux.intel.com>; 'H. Peter Anvin' <hpa@zytor.com>
> Subject: [PATCH v2] x86: Allow user accesses to the base of the guard pag=
e
>=20
> __access_ok() calls valid_user_address() with the address after
> the last byte of the user buffer.
> It is valid for a buffer to end with the last valid user address
> so valid_user_address() must allow accesses to the base of the
> guard page.
>=20
> Fixes: 86e6b1547b3d0 ("x86: fix user address masking non-canonical specul=
ation issue")
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>=20
> v2: Rewritten commit message.
>=20
>  arch/x86/kernel/cpu/common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 06a516f6795b..ca327cfa42ae 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2389,12 +2389,12 @@ void __init arch_cpu_finalize_init(void)
>  =09alternative_instructions();
>=20
>  =09if (IS_ENABLED(CONFIG_X86_64)) {
> -=09=09unsigned long USER_PTR_MAX =3D TASK_SIZE_MAX-1;
> +=09=09unsigned long USER_PTR_MAX =3D TASK_SIZE_MAX;
>=20
>  =09=09/*
>  =09=09 * Enable this when LAM is gated on LASS support
>  =09=09if (cpu_feature_enabled(X86_FEATURE_LAM))
> -=09=09=09USER_PTR_MAX =3D (1ul << 63) - PAGE_SIZE - 1;
> +=09=09=09USER_PTR_MAX =3D (1ul << 63) - PAGE_SIZE;
>  =09=09 */
>  =09=09runtime_const_init(ptr, USER_PTR_MAX);
>=20
> --
> 2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


