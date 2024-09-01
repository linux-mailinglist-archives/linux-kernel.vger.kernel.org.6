Return-Path: <linux-kernel+bounces-310399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D11E967C36
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C261F215A5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D836F2FD;
	Sun,  1 Sep 2024 20:54:10 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA73E4CE05
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725224049; cv=none; b=AiINZHcDvbKgjTPW5/05zVdaNVjIBFaC4kPMt2fnmr8csJBGm5V07It80N6/oGGwI0xi3B4cg+utZ6h4eey/5hg5ovSj9ucyAFtCE8yaKYvHXJ+eonugdZIwfwieQc2al9tdWnLlJeCFii/L0AeKceE7ohhsu1JIFUGXQIkmobQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725224049; c=relaxed/simple;
	bh=y1ZdfCcI7KsN6Fcy/zwWfpagv4xyjNTDkcYo+rseoQM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=bG6/3i9XmYDx5X1ZSx1St0jijuLgujS+LajVzCUUjTM9ahSUkVuXJ8vfZVPxrmy0QTW1LUHKgHxJZgOGuzSEys/a2FalRaH/7o9LbldosIn70J4BMx2/qqSrjiZ5qrh5MGALuJUUVXxpG3i98fMAR5tUJHEEHR/ZjgZg7lBN8E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-143-DaDaQP20OJ2k4OkvWLoolA-1; Sun, 01 Sep 2024 21:53:59 +0100
X-MC-Unique: DaDaQP20OJ2k4OkvWLoolA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 1 Sep
 2024 21:53:09 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 1 Sep 2024 21:53:09 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jinjie Ruan' <ruanjinjie@huawei.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] genirq/timings: Use min_t() to simplify the code
Thread-Topic: [PATCH -next] genirq/timings: Use min_t() to simplify the code
Thread-Index: AQHa+4gfmYDZ66sauk2kXgIKz/Ql+bJDarZA
Date: Sun, 1 Sep 2024 20:53:09 +0000
Message-ID: <b7cc4af3df4c41b3975ac990532e4ba0@AcuMS.aculab.com>
References: <20240831093654.4139823-1-ruanjinjie@huawei.com>
In-Reply-To: <20240831093654.4139823-1-ruanjinjie@huawei.com>
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

From: Jinjie Ruan
> Sent: 31 August 2024 10:37
>=20
> The irq count can not exceed circular buffer IRQ_TIMINGS_SIZE, use
> min_t() to simplify it.
>=20
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  kernel/irq/timings.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
> index c43e2ac2f8de..69f103b4c7a6 100644
> --- a/kernel/irq/timings.c
> +++ b/kernel/irq/timings.c
> @@ -406,8 +406,7 @@ static u64 __irq_timings_next_event(struct irqt_stat =
*irqs, int irq, u64 now)
>  =09/*
>  =09 * 'count' will depends if the circular buffer wrapped or not
>  =09 */
> -=09count =3D irqs->count < IRQ_TIMINGS_SIZE ?
> -=09=09irqs->count : IRQ_TIMINGS_SIZE;
> +=09count =3D min_t(int, irqs->count, IRQ_TIMINGS_SIZE);

Why min_t() ?

=09David

>=20
>  =09start =3D irqs->count < IRQ_TIMINGS_SIZE ?
>  =09=090 : (irqs->count & IRQ_TIMINGS_MASK);
> --
> 2.34.1
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


