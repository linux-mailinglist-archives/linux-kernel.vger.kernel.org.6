Return-Path: <linux-kernel+bounces-402735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862849C2B4E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 10:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9819E2829EB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 09:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938C913B297;
	Sat,  9 Nov 2024 09:14:39 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421D3233D67
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731143679; cv=none; b=XH/oR4xVk0I0oJ+4SH6BFshnMxByC9PQhUfkhfI/+ZZW7ftrUXhG0qNx09Ccf1alQm1EknlkZHD38lBUsuNAeRfCLDjer8X5tN8PFpSp/FJp93VDQ/DldJ/Xo78yyzyGUsoPLkXL2n/U0lfMpfYqAQZ+xUwg7hYvq63fbLleuac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731143679; c=relaxed/simple;
	bh=2v5n8Q3Q7Vt8rGxdIYiFCkF6notCRu0dxY8+3Lqhk9Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=BdB8W9ySooGaTDTyh9bmBp08YlGKCh512SR18c8w85Iol15vDUPkwV5K2lxBlaJoN3Fpg1kI5btbUZUny5SO1oiY69B9Ud9LxcuTEYqTALPe9QaMeOkoOgsQ14XS950hid/SPYq4Dxh3/f62wwhyplqErJLY+Do5uKk9zhWZBH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-24-FDxcS7DIPNSX7BxhqKiFLA-1; Sat, 09 Nov 2024 09:14:33 +0000
X-MC-Unique: FDxcS7DIPNSX7BxhqKiFLA-1
X-Mimecast-MFC-AGG-ID: FDxcS7DIPNSX7BxhqKiFLA
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 9 Nov
 2024 09:14:32 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 9 Nov 2024 09:14:32 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Peter Zijlstra' <peterz@infradead.org>, Christoph Hellwig
	<hch@infradead.org>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "alyssa.milburn@intel.com"
	<alyssa.milburn@intel.com>, "scott.d.constable@intel.com"
	<scott.d.constable@intel.com>, "joao@overdrivepizza.com"
	<joao@overdrivepizza.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
	"ebiggers@kernel.org" <ebiggers@kernel.org>, "samitolvanen@google.com"
	<samitolvanen@google.com>, "kees@kernel.org" <kees@kernel.org>
Subject: RE: [PATCH 1/8] x86,kcfi: Fix EXPORT_SYMBOL vs kCFI
Thread-Topic: [PATCH 1/8] x86,kcfi: Fix EXPORT_SYMBOL vs kCFI
Thread-Index: AQHbL5NB3iR6AEe14EiCtN5H8dkea7KurmRg
Date: Sat, 9 Nov 2024 09:14:32 +0000
Message-ID: <c8d6b89093bc4d82bda15aa9d9fe6f88@AcuMS.aculab.com>
References: <20241105113901.348320374@infradead.org>
 <20241105114521.852053765@infradead.org> <Zyoood0ooSbpultV@infradead.org>
 <20241105142720.GG10375@noisy.programming.kicks-ass.net>
 <ZyosbEMNzMU6fOe_@infradead.org>
 <20241105145842.GH10375@noisy.programming.kicks-ass.net>
In-Reply-To: <20241105145842.GH10375@noisy.programming.kicks-ass.net>
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
X-Mimecast-MFC-PROC-ID: 8aNowxmjqoSTTUtuGeFcT2GWIE4sCoTH9Hp82focjbI_1731143673
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Peter Zijlstra
> Sent: 05 November 2024 14:59
>=20
> On Tue, Nov 05, 2024 at 06:32:12AM -0800, Christoph Hellwig wrote:
> > On Tue, Nov 05, 2024 at 03:27:20PM +0100, Peter Zijlstra wrote:
> > > > I don't think that is the case at all.  The is a relatively small n=
umber
> > > > of exported symbols that are called indirectly.  I'd much rather ma=
rk
> > > > those explicitly.
> > >
> > > I'm not claiming they have their address taken -- just saying that
> > > traditionally this has always been a valid thing to do.
> > >
> > > Anyway, I raised this point last time, and I think back then the
> > > consensus was to explicitly mark those you should not be able to call=
.
> >
> > Who came to that consensus?  There really is just a relatively well
>=20
> The people who found that thread.
>=20
> > bounded number of functions that are used as either default methods
> > or as ready made callbacks.  Everything else has no business being
> > called indirectly.  While disallowing this might be a bit of work,
> > I think it would be a great security improvement.
>=20
> Well, we don't disagree. But since most of the EXPORT'ed functions are
> done in C, we need something that works there too.
>=20
> I think the idea was that we add EXPORT_SYMBOL{,_GPL}_SEALED() and go
> convert everything over to that.

Don't you really need a compiler attribute that makes a function
indirectly callable?
(Instead of the compiler trying to sort it out itself?)
With the default being 'not indirectly callable' unless the function
address is taken in the same compilation unit as its definition.

If added to the declaration (in the .h file) the compiler would be
able to error code that takes the address of such functions.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


