Return-Path: <linux-kernel+bounces-405530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBA99C52DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D6BEB23397
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038CE20E021;
	Tue, 12 Nov 2024 09:53:12 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B811AB535
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405191; cv=none; b=aPLk4hudzNTDleTf9ldUfTuZkxQ5aIa0lbNIm3lGDAY82xSMTrjDuD1zDufvaTfbhGveeVmeYH8L/O0oBm2zANq0S2vNrazcaaNKrac2eeAZusy0aqpspm9O2evtSRGUZzllEbLuh5GhXWDUF7l6FHWlgu8PXSy+nYXs0vvooZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405191; c=relaxed/simple;
	bh=WsZ8LcEWNbDDgjK5KwWMgvnnkvhbKcNw9V6HRRfXyG0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=LeT5VjmBPVmrlP66PUPJq/R+TatEop5I76F6J9kNE5QGZiim6zzE635+p2v3QjLoyVu1bM+qwm/Wv41/Z9M65e7P4Fi3SCyWaj21UFSvhgqM9nJBuJijOrFMhr21mfE5tMvUF0ETr+fLh+9FOUGEtEm7tpKIz4FtDYUsNlfFGGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-103-vk1W0v29MPuncJV1L6TE2A-1; Tue, 12 Nov 2024 09:53:00 +0000
X-MC-Unique: vk1W0v29MPuncJV1L6TE2A-1
X-Mimecast-MFC-AGG-ID: vk1W0v29MPuncJV1L6TE2A
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 12 Nov
 2024 09:52:59 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 12 Nov 2024 09:52:59 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mikel Rychliski' <mikel@mikelr.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86: Fix off-by-one error in __access_ok
Thread-Topic: [PATCH] x86: Fix off-by-one error in __access_ok
Thread-Index: AQHbMuurJ3dP3nIEdEmbtgzS5bNbELKw4lyggAGIHQCAAPqCgA==
Date: Tue, 12 Nov 2024 09:52:59 +0000
Message-ID: <b718357a6f9441428e771f1a4b60d710@AcuMS.aculab.com>
References: <20241109210313.440495-1-mikel@mikelr.com>
 <382372a83d1644f8b3a701ff7e14d5f1@AcuMS.aculab.com>
 <2987600.vYhyI6sBWr@basin>
In-Reply-To: <2987600.vYhyI6sBWr@basin>
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
X-Mimecast-MFC-PROC-ID: XYgyGCDfAtmSASbyQhKWFzIZNBPjumjY8leriUyQozU_1731405179
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Mikel Rychliski
> Sent: 11 November 2024 18:33
>=20
> Hi David,
>=20
> Thanks for the review:
>=20
> On Sunday, November 10, 2024 2:36:49 P.M. EST David Laight wrote:
> > From: Mikel Rychliski
> >
> > > Sent: 09 November 2024 21:03
> > >
> > > We were checking one byte beyond the actual range that would be acces=
sed.
> > > Originally, valid_user_address would consider the user guard page to =
be
> > > valid, so checks including the final accessible byte would still succ=
eed.
> >
> > Did it allow the entire page or just the first byte?
> > The test for ignoring small constant sizes rather assumes that accesses
> > to the guard page are errored (or transfers start with the first byte).
> >
>=20
> valid_user_address() allowed the whole guard page. __access_ok() was
> inconsistent about ranges including the guard page (and, as you mention, =
would
> continue to be with this change).
>=20
> The problem is before 86e6b1547b3d, the off-by-one calculation just lead =
to
> another harmless inconsistency in checks including the guard page. Now it
> prohibits reads of the last mapped userspace byte.

So if you could find code that didn't read the first byte of a short buffer
first you could access the first page of kernel memory.
(Ignoring the STAC/CLAC instructions.)
So that has always been wrong!

OTOH I suspect that all user accesses start with the first byte
and are either 'reasonably sequential' or recheck an updated pointer.
So an architecture with a guard page (not all do) need only check
the base address of a user buffer for being below/equal to the
guard page.

...
> > Why not:
> > =09if (statically_true(size <=3D PAGE_SIZE) || !size)
> > =09=09return vaid_user_address(ptr);
> > =09end =3D ptr + size - 1;
> > =09return ptr <=3D end && valid_user_address(end);
>=20
> Sure, agree this works as well.

But is likely to replicate the valid_user_address() code.

> > Although it is questionable whether a zero size should be allowed.
> > Also, if you assume that the actual copies are 'reasonably sequential',
> > it is valid to just ignore the length completely.
> >
> > It also ought to be possible to get the 'size =3D=3D 0' check out of th=
e common
> > path. Maybe something like:
> > =09if (statically_true(size <=3D PAGE_SIZE)
> > =09=09return vaid_user_address(ptr);
> > =09end =3D ptr + size - 1;
> > =09return (ptr <=3D end || (end++, !size)) && valid_user_address(end);
>=20
> The first issue I ran into with the size=3D=3D0 is that __import_iovec() =
is
> checking access for vectors with io_len=3D=3D0 (and the check needs to su=
cceed,
> otherwise userspace will get a -EFAULT). Not sure if there are others.

I've looked at __import_iovec() in the past.
The API is horrid! and the 32bit compat version is actually faster.
It doesn't need to call access_ok() either the check is done later.

> Similarly, the iovec case is depending on access_ok(0, 0) succeeding. So =
with
> the example here, end underflows and gets rejected.

I've even wondered what the actual issue is with speculative kernel
reads from get_user().
The read itself can't be an issue (a valid user address will also displace
any cache lines), so I think the value read must be used to form an
address in order for any kernel data to be leaked.
You might find a compare (eg the length in import_iovec() but that can
only expose high bits of a byte - and probably requires i-cache timing.
But I'm not expert - and the experts hide the fine details.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


