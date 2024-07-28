Return-Path: <linux-kernel+bounces-264543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C121193E4BA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 13:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFA71C21315
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 11:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BA0374CC;
	Sun, 28 Jul 2024 11:18:20 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6C929CEC
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722165499; cv=none; b=UZBsm8XyViFhMrdhNrgiLBqKlLWN22VVkabTmQU1v629LHiS9Jyfz97iPksPpcr+w6V6fS5EqriztQoyEJbGad2ERF5mKVtAcYqMQka8fYNbFZZuuttan85vdo0Aa3kU6pYSNe/iIqfYaqZO8BEyWyq+JPDgw0BzkjlkOc7/lPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722165499; c=relaxed/simple;
	bh=eQ7HWzpAcXqhhm63Y2QACV2RaOElIBpgN2Uw31O/Vkc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=mk/rN2PgNJqHYPH2AEtIE3xDbr7GzP/TKfo0zs1hygpoJCR4kBMDOtE1wI7wX1ywZoPD0LrGsh9+QHlb36LPSK9vK7pq2978+G+q5UuVWA9gk0/VIsUkI/2l9ybB993XKbUyk67E7qSjsB4RlzB32wYcgO0wmZlc5TEsMRUtKBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-237-t68vUNQdNHix3gc58OU02A-1; Sun, 28 Jul 2024 12:18:03 +0100
X-MC-Unique: t68vUNQdNHix3gc58OU02A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jul
 2024 12:17:19 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jul 2024 12:17:19 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Lorenzo Stoakes' <lorenzo.stoakes@oracle.com>
CC: 'Linus Torvalds' <torvalds@linuxfoundation.org>, Jens Axboe
	<axboe@kernel.dk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>,
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com"
	<pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 0/7] minmax: reduce compilation time
Thread-Topic: [PATCH 0/7] minmax: reduce compilation time
Thread-Index: Adrd1UnD4d8H4E3lR3eDOQFKqPNnSwCBfkcCAAdYOfAAFX/+AAAkPNng
Date: Sun, 28 Jul 2024 11:17:19 +0000
Message-ID: <7a5cf18b6141453988247cfa4d4dcd49@AcuMS.aculab.com>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
 <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
 <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
 <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
 <CAHk-=wgVZwBrCXyphH+HcY9X56EK0KNQrnWZ+Qb0Bz79POLSUw@mail.gmail.com>
 <40369e153bd447e5b597c31e7bc9a2b1@AcuMS.aculab.com>
 <eea5d9a4-fcb4-4076-8222-fcff668a2bfa@lucifer.local>
In-Reply-To: <eea5d9a4-fcb4-4076-8222-fcff668a2bfa@lucifer.local>
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
> Sent: 27 July 2024 19:59
>=20
> On Sat, Jul 27, 2024 at 08:08:39AM GMT, David Laight wrote:
> > ...
> > > and it will spit out
> > >
> > >   Longest line is drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:113=
6 (2346kB)
> > >      '   ((((((pkt_size) + __builtin_choose_expr((sizeof(int) =3D=3D
> > > sizeof(*(8 ? ((void *)((long)((__builtin_...'
> > >
> > > to tell me that we have that insane 2.2 *megabyte* line due to the
> > > MVPP2_SKB_HEADROOM thing, and I should apply this patch:
> > >
> > > -#define MVPP2_SKB_HEADROOM     min(max(XDP_PACKET_HEADROOM, NET_SKB_=
PAD), 224)
> > > +#define MVPP2_SKB_HEADROOM
> > > MIN_T(int,MAX_T(int,XDP_PACKET_HEADROOM, NET_SKB_PAD), 224)
> > >
> > > to fix it.
>=20
> Yeah sorry just saw you had already addresed this Linus... I just went wi=
th a
> clamp()_t in my patch.
>=20
> >
> > Or (if I've got is right):
> > #define MVPP2_SKB_HEADROOM clamp(XDP_PACKET_HEADROOM, NET_SKB_PAD, 224)
> >
>=20
> I'm pretty sure you can clamp_t(int, ...) here safely based on usage.

Why doesn't a plain clamp() work?
The xxx_t() variants really shouldn't be used very often.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


