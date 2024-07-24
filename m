Return-Path: <linux-kernel+bounces-260909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE6E93B015
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D56B23777
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C183156C69;
	Wed, 24 Jul 2024 11:06:11 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D67156967
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721819170; cv=none; b=oMpVEBXcelO6EiG/EyUmlgUlU4mhLN/jrlR+AqHmEPXmQ+hpBr0hQhUwvNnxCU3+x+4mHo4OOxPIbm1A51UeEZ+KvehygwLtDnTznSE9baGBhSAYTycC4fk8B+iRd8lQMrvAf8qJuqvBEcBctA7Of6ynC2nAGhgXrSB3UaKyMXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721819170; c=relaxed/simple;
	bh=X/nuKImDGFXCeIa6IMgFZHGLK+4Klev21WBlhI8fKT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=iG9tuBooxpbIfL91XY3B+4cOfHrkWCkho7ciGGRc2LH9F2N8elfO177UFtCW7HNPPcFTG72anhKGZSuuhj082Mn7iYZaEHPqSmbicdhXqlaTH/WhVujan/RXl6ACU2iIMtzVy3UxHCzg9S6wxghgelczRmr3t6mHKdXdVr4L7m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-185-fyRQhjFhOVKCzMXiToP7WA-1; Wed, 24 Jul 2024 12:05:56 +0100
X-MC-Unique: fyRQhjFhOVKCzMXiToP7WA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 Jul
 2024 12:05:17 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 24 Jul 2024 12:05:17 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Lorenzo Stoakes' <lorenzo.stoakes@oracle.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Arnd Bergmann <arnd@kernel.org>, "willy@infradead.org"
	<willy@infradead.org>, "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>, "Jason@zx2c4.com" <Jason@zx2c4.com>,
	"hch@infradead.org" <hch@infradead.org>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "pedro.falcato@gmail.com"
	<pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: Build performance regressions originating from min()/max() macros
Thread-Topic: Build performance regressions originating from min()/max()
 macros
Thread-Index: AQHa3aXBhf3rusWJtUWi2ZkpzzdkQbIFtZeQ
Date: Wed, 24 Jul 2024 11:05:17 +0000
Message-ID: <1877ab0f14cf4f7d9da2a53e211cfdc1@AcuMS.aculab.com>
References: <c83c17bb-be75-4c67-979d-54eee38774c6@lucifer.local>
 <3ad33eb6-49d7-4e67-8fa5-1beec8d4af4f@lucifer.local>
In-Reply-To: <3ad33eb6-49d7-4e67-8fa5-1beec8d4af4f@lucifer.local>
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

From: Lorenzo Stoakes
> Sent: 24 July 2024 09:45
..
> It seems that (again, all credit to Arnd for his thorough analysis here) =
a
> lot of the underyling issue revolves around the macros need to function
> both in scenarios where we absolutely must have a constant value (for
> instance, array size) as well as in scenarios where this is not the case.
>=20
> Arnd also discovered [0] there _relatively_ few call sites that require
> this, so maybe a way forward might be to create specific min()/max() macr=
os
> for the strictly const case and to fix up the core ones to reduce expansi=
on
> at the cost of not being able to use these in these scenarios?
>=20
> Does this seem viable? Perhaps David you might have thoughts on this?

Indeed.
MIN() and MAX() could be used for compile-time constants (and require const=
ants).
They would then be usable for static initialisers.

Before that can be done all the places that locally define MIN() and MAX()
need changing to either use min()/max() or surround the local definition
with an #ifdef until the global definition is added.

But there are some optimisations that can be done first.
The significant one is implement min3() directly (and probably without
the 'can be constant' logic.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


