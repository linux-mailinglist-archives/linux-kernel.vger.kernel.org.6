Return-Path: <linux-kernel+bounces-352480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F05991FD6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739AA1C20977
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D981189BBA;
	Sun,  6 Oct 2024 17:14:24 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED3B155C8C
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728234864; cv=none; b=dLlAPYqD2O4onZW1IE9KrXeedz6/M9I3p+I10yC6gJ8oZyFdFSGAo3x4pZupMG6xsPgv05hAp7akOrofNv6DGs3h2BfjT3Cv9vthdV0vbod2ogG1tz5asJdca8QY85UPp4wCzwejimgXUc3rRZru5i+CEgiJMGNOQJEb96JmqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728234864; c=relaxed/simple;
	bh=VN4Rdd/NF6+1iNc6FWwZ+aTR7FXGvpT46iwVY2pFc50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=aqLLI9Vp267QSWsrvvze3zH8SF/6ld0f9Ov1hGTS3ThfUTvqh/P8z/s7vfu+JIICuNUK7nYeZ9S7Jv3Otu69t9Ls/lr/3oPl/nNbRJNY4cLMKKcE0o3LvyfomPxsKkM3UAVwLX+74Ns+Cgxq8EHWQ1Kz3yGZDc4GoTYIuDE5IFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-160-32qjf7DEPKSBYCRcDkNq4w-1; Sun, 06 Oct 2024 18:14:10 +0100
X-MC-Unique: 32qjf7DEPKSBYCRcDkNq4w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 6 Oct
 2024 18:13:16 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 6 Oct 2024 18:13:16 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Bart Van Assche' <bvanassche@acm.org>, Thomas Gleixner
	<tglx@linutronix.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King
	<linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Clemens Ladisch <clemens@ladisch.de>
Subject: RE: [PATCH 07/21] hpet: Switch to number_of_interrupts()
Thread-Topic: [PATCH 07/21] hpet: Switch to number_of_interrupts()
Thread-Index: AQHbE2TzBkWyNMbR9ESEodEWAH4CWbJ5/e4w
Date: Sun, 6 Oct 2024 17:13:16 +0000
Message-ID: <b315cbe2e1264d98b57ce57fe5f66a23@AcuMS.aculab.com>
References: <20240930181600.1684198-1-bvanassche@acm.org>
 <20240930181600.1684198-8-bvanassche@acm.org>
In-Reply-To: <20240930181600.1684198-8-bvanassche@acm.org>
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

From: Bart Van Assche
> Sent: 30 September 2024 19:16
>=20
> Use the number_of_interrupts() function instead of the global variable
> 'nr_irqs'. This patch prepares for changing 'nr_irqs' from an exported
> global variable into a variable with file scope.
>=20
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/char/hpet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> index e904e476e49a..e618ae66587d 100644
> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -195,7 +195,7 @@ static void hpet_timer_set_irq(struct hpet_dev *devp)
>  =09=09v &=3D ~0xffff;
>=20
>  =09for_each_set_bit(irq, &v, HPET_MAX_IRQ) {
> -=09=09if (irq >=3D nr_irqs) {
> +=09=09if (irq >=3D number_of_interrupts()) {
>  =09=09=09irq =3D HPET_MAX_IRQ;
>  =09=09=09break;
>  =09=09}

This is horrid.
You've replaced the read of a global variable (which, in some cases the
compiler might be able to pull outside the loop) with a real function
call in every loop iteration.

With all the mitigations for cpu speculative execution 'issues' you
pretty much don't want trivial function calls.

If you are worried about locals shadowing globals just change one of the na=
mes.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


