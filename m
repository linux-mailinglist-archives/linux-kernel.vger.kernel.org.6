Return-Path: <linux-kernel+bounces-264544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C99493E4C4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 13:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FE01F21C4F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 11:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15FB37703;
	Sun, 28 Jul 2024 11:33:43 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6B725622
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722166423; cv=none; b=onaE+6V/s1r0xZiWK+A4qMJUwqWZtyCSftnIQGRsuMMpW/6PYj3rOnTVoVDYYNsPP3hxDsHt2vMQ6U3I60MZypvr/xV5PQMZHc1kzsbgPH/RNVAVahCkd0pJ7KuYfBCHThVOPNV/FPVjUF3QtyFmW0rkRHeXq9ZQCxpwstuFHqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722166423; c=relaxed/simple;
	bh=/Bp9KmN52nnr4L5TVeZW/xkyvstHbVRur/9ZpmuFVrQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=faINPCOfB+xqtDvDVoXhA9abCSKRaUUF8LIYWCTejD1gfc/m6L0XqzGYri7jBeb1x1GKBPj5Vm5WsrmupuuTkD5BcklmcrvIfdlUez4k4E/YLnowwlQ3hrV/Aont0pK24Cc1TC3eg8lnlzHiaBioSsDR5XlLsWxLbAlLzEmeNTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-29-Tl3nD_x7MSSkUJ-BHRYIjA-1; Sun, 28 Jul 2024 12:33:37 +0100
X-MC-Unique: Tl3nD_x7MSSkUJ-BHRYIjA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jul
 2024 12:32:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jul 2024 12:32:52 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Lorenzo Stoakes' <lorenzo.stoakes@oracle.com>, Jens Axboe
	<axboe@kernel.dk>
CC: Linus Torvalds <torvalds@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig
	<hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>,
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com"
	<pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 0/7] minmax: reduce compilation time
Thread-Topic: [PATCH 0/7] minmax: reduce compilation time
Thread-Index: AQHa4EJo4d8H4E3lR3eDOQFKqPNnS7IL/3yg
Date: Sun, 28 Jul 2024 11:32:52 +0000
Message-ID: <0b77025b520f439692e6fc2851977a0d@AcuMS.aculab.com>
References: <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
 <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
 <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
 <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
 <CAHk-=whH6rJeo1WxZWQzTeEXS+8MNV=A2c4qrF-uFYjU-J6U-g@mail.gmail.com>
 <f26b8167-ee81-413e-b48a-0469680fb768@kernel.dk>
 <93243310-22cf-4d44-810c-17629b46a33e@kernel.dk>
 <1d87456d-b565-410f-bf4b-91fe5704617c@lucifer.local>
In-Reply-To: <1d87456d-b565-410f-bf4b-91fe5704617c@lucifer.local>
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
> Sent: 27 July 2024 17:31
>
...
> I tried this patch, doesn't seem to make a huge difference, going from
> 3,958,564 bytes with longest line of 82 kB to 3,943,824 bytes with a
> longest line of 77kB.
>=20
> It seems that the .bv_len =3D ... expansion is what's doing it, so I trie=
d
> patching mp_bvec_iter_len() as well to do a silly ?: thing (sorry), which
> takes us down to 3,880,309 with longest line of 20kB.
>=20
...
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index f41c7f0ef91e..567522aec2f9 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -101,9 +101,14 @@ struct bvec_iter_all {
>  #define mp_bvec_iter_page(bvec, iter)=09=09=09=09\
>  =09(__bvec_iter_bvec((bvec), (iter))->bv_page)
>=20
> -#define mp_bvec_iter_len(bvec, iter)=09=09=09=09\
> -=09min((iter).bi_size,=09=09=09=09=09\
> -=09    __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
> +static inline unsigned mp_bvec_iter_len(const struct bio_vec *bvec,
> +=09=09=09=09=09struct bvec_iter iter)
> +{
> +=09unsigned remains =3D __bvec_iter_bvec(bvec, iter)->bv_len -
> +=09=09iter.bi_bvec_done;
> +
> +=09return remains < iter.bi_size ? remains : iter.bi_size;
> +}

That can still be a #define and still use min().
The important thing is to assign the result of __bvec_iter_bvec() to
a local variable.

So maybe something like:
#define mp_bvec_iter_len(bvec, iter) ({ \
=09__auto_type _remains =3D __bvec_iter_bvec((bvec), \
=09=09(iter))->bv_len - (iter).bi_bvec_done); \
=09min((iter).bi_size, _remains); \
})

Bloat is always going to happen if you pass one complex #define to another.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


