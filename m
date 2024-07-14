Return-Path: <linux-kernel+bounces-251688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C965093083B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 03:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF2DB218F1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 01:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9A133EE;
	Sun, 14 Jul 2024 01:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rC2q7hYF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="CH+rQnWv"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032D93D6A
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 01:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720921767; cv=none; b=jxxaFGYbxdtF7pd2UrLnR3TGZjW42PkLcoQw/yZbf/QqgdmwmAxWA5mZFKa6tcMEfFy++GkLvEPthVzlM6LRD/SQZq9q3pNEUUeq1tqmvOD4/VON9hZKlJ+Oz4Lbn9AEdl9eSI1xmtOcTFRiKaUxnHYQyQ9VZxffjvJSOK84hcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720921767; c=relaxed/simple;
	bh=gtwc0REQRTq7DgPPkkfuU0Z8AhwUOksS1U2qh6yqfp8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ihw5eHpw7vIjsn0YDFn6ix5X1FLCt6zfnQkEZbh3bTY8di3EvnLYiElu5xBVg4FOLp4aQmbm+1eNqsltHJdQaX40N3lPoKMrmc04k6kMLUMv0lVpZUtxv52NtqC3tb9b5W/Aroqez/WhT2VVWuCcU7riz6HxBsr92Rlg9cciZVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rC2q7hYF; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=CH+rQnWv reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A4BFF2E9B3;
	Sat, 13 Jul 2024 21:49:17 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=gtwc0REQRTq7DgPPkkfuU0Z8AhwUOksS1U2qh6
	yqfp8=; b=rC2q7hYFQyT6/jJv2y5ZPSLI9QKsyRZ+D3C/mNqcoXncOEbhjbORLE
	nQ4p6CwqS6s1vdgB7MS9lP3EkNUQjSVFwZmWKuNZNsElSl+hHYzkgFFXc8KIRrBP
	slNe0llxZwMRE/VsQBht5UwzyIW/8dIZhshNdZQIKgIVyWslVLycA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C88A2E9B2;
	Sat, 13 Jul 2024 21:49:17 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=NvYzKOTHCvdjMLZBsYH6yZq4KFHRq/f72FeA5ZIqhXY=; b=CH+rQnWvJNB+lddPXXmxeO8er3kN3DwkQTkkEFZPSjT6UiI0ERHy9RphrUXCp5IoYo+YaUjrc8M5/DI8fiU+r5BrCGUW72tcgbrPF8ZUx4Fx+zAYu5cwY5B1FH47rgQadJxJ21rWgsqb+vn54ub2g1jfWbvadjcB1OvPYUXt3MI=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1FDA42E9B1;
	Sat, 13 Jul 2024 21:49:17 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 037ACD4FE0B;
	Sat, 13 Jul 2024 21:49:15 -0400 (EDT)
Date: Sat, 13 Jul 2024 21:49:15 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mul_u64_u64_div_u64: avoid undefined shift value
In-Reply-To: <cel6yaebrspena42tv7mewvd7vvnnzycr2pgg4zkh737uwokro@kzxoxatbdodv>
Message-ID: <950n497s-1933-5s8q-2138-52oq50npr4s4@syhkavp.arg>
References: <7rrs9pn1-n266-3013-9q6n-1osp8r8s0rrn@syhkavp.arg> <cel6yaebrspena42tv7mewvd7vvnnzycr2pgg4zkh737uwokro@kzxoxatbdodv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463781375-2099254216-1720921756=:2627780"
X-Pobox-Relay-ID:
 47B6F542-4183-11EF-9A60-965B910A682E-78420484!pb-smtp2.pobox.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463781375-2099254216-1720921756=:2627780
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jul 2024, Uwe Kleine-K=F6nig wrote:

> Hello Nicolas,
>=20
> On Fri, Jul 12, 2024 at 01:41:46PM -0400, Nicolas Pitre wrote:
> > From: Nicolas Pitre <npitre@baylibre.com>
> >=20
> > Shifting a value to its type's size or beyond is undefined. This may=20
> > happen if the product of a * b is not more than 64 bits despite
> > ilog2(a) + ilog2(b) being 63 and c having no trailing 0 bits.
> > We end up with shift=3D0 and n_lo >> shift | (n_hi << (64 - shift).
> > Take care of that case and add such case to the test module.
> >=20
> > Using __builtin_ctzll() with 0 is also undefined so take care of that
> > case too.
> >=20
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202407121652.69e657c5-oliver.s=
ang@intel.com
> > ---
> >=20
> > Andrew: up to you to fold this in the original or queue it as is.
> >=20
> > diff --git a/lib/math/div64.c b/lib/math/div64.c
> > index b7fc752463..5faa29208b 100644
> > --- a/lib/math/div64.c
> > +++ b/lib/math/div64.c
> > @@ -212,11 +212,18 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
> > =20
> >  #endif
> > =20
> > +	/* make sure c is not zero, trigger exception otherwise */
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wdiv-by-zero"
> > +	if (unlikely(c =3D=3D 0))
> > +		return 1/0;
> > +#pragma GCC diagnostic pop
> > +
>=20
> I wonder if that does the right thing for clang, too.>=20

Yes, I tested it, and inspected assembly output of both gcc and clang.

> >  	int shift =3D __builtin_ctzll(c);
> > =20
> >  	/* try reducing the fraction in case the dividend becomes <=3D 64 b=
its */
> >  	if ((n_hi >> shift) =3D=3D 0) {
> > -		u64 n =3D (n_lo >> shift) | (n_hi << (64 - shift));
> > +		u64 n =3D shift ? (n_lo >> shift) | (n_hi << (64 - shift)) : n_lo;
>=20
> Maybe it's just me, but I'd better understand the following equivalent
> assignment:
>=20
> 	u64 n =3D (n_lo >> shift) | (shift ? n_hi << (64 - shift) : 0)
>=20
> or maybe even a bit more verbose:
>=20
> 	u64 n =3D n_lo >> shift;
> 	/* Shifting by 64 bit is undefined, so only do this operation for shif=
t > 0 */
> 	if (shift)
> 		n |=3D n_hi << (64 - shift);

Well... admitedly my version comes from how I think the compiler would=20
generate the assembly. Given that a conditional is unavoidable, better=20
skip the useless shift by 0 as well.

Admitedly I try to be reasonable and not go on a whim rewriting it all=20
in assembly like I did in the past:
https://github.com/gcc-mirror/gcc/blob/master/libgcc/config/arm/ieee754-d=
f.S

> With or without these suggestions incorporated:
>=20
> Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
>=20
> Best regards
> Uwe
>=20
---1463781375-2099254216-1720921756=:2627780--

