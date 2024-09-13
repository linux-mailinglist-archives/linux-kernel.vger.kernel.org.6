Return-Path: <linux-kernel+bounces-328183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB04097802C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E151283F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F121DA107;
	Fri, 13 Sep 2024 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="KQzqHbC2"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9311DA0E4;
	Fri, 13 Sep 2024 12:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230981; cv=none; b=bM/glgsrs7JONm6QvUBiLYpLEisEvSVdxOpMMYI68+sytVjsJEm1RCkbR+dtT+LET+/Zkjpol/Ng0HIyfCPAwRZrOeQx469/BXlHk5OTUVprXqi+Ltji6g5h3PcvDMSAGqYs+uX7HfgitUFW0JcDUnY9hK0TuUCynCfVEidHHkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230981; c=relaxed/simple;
	bh=FPnXhBvv8SJqnwWBBZGVCJfOSElinUIJlwKe2pd3eik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=neqknkG9oB3cNFVTgfgFRlmFO1FnkwkKESmdJMT9VaPAI3XQS5ttudcG0pzqNaUhuvE6HE5ivNv01evN1LRU8+Th1VVqK0i2fiH9wU1AoDB8gkzO7L1xlYg5JSZ5t8aDoVDYU6JFXilBSueVEe1dPKpEUgE6e55/XkbYLBY2XQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=KQzqHbC2; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id BF818888CC;
	Fri, 13 Sep 2024 14:36:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726230971;
	bh=vge2v2fYRNsvPa07QRpGfI2z7WoCeEvbiScvHQo1aVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KQzqHbC29Ch167mhsb8CkitLAX1YS7Sr+2uOkE8VWfXxsmEsQIvNe/hPTdUbrLuaT
	 5vZYEQ/jzpvOFy7TSPqP7r7PV+vrafJ2y1PQ0yPPLZdQS2pgg/0jgHapamzZbS/wFp
	 SXcwBH/Ta4f86Z/l/O7Ps6BZ27UMXSBfSpOy2G7KcJIUG6N6YOLyHcPvPSKi7O5WL1
	 WBGXy5oN4L+irn+0zZykXmuTOTPwVD8G3jkMOBLg0o2LSyWstZT1vm9fH0VKyqbflG
	 S5apztUS+CaDpYo/eXOYzWzeCCapAhf0F/4coU/355RD9b/qLNacewPcErMPssn1wt
	 zXR9XRDDAPyxA==
Date: Fri, 13 Sep 2024 14:36:09 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Nikita Shubin
 <nikita.shubin@maquefel.me>, Hartley Sweeten
 <hsweeten@visionengravers.com>, Alexander Sverdlin
 <alexander.sverdlin@gmail.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: move BK3 machine support to CREDITS
Message-ID: <20240913143609.0efc5431@wsk>
In-Reply-To: <CAOc5a3NEJkHfmWymRsXa1AGLK1K6XOtT5yEsuaaqr9EarOArQg@mail.gmail.com>
References: <20240913115021.58405-1-lukas.bulwahn@redhat.com>
	<d125b5a5-8118-48ec-8af4-243a217170df@app.fastmail.com>
	<CAOc5a3NEJkHfmWymRsXa1AGLK1K6XOtT5yEsuaaqr9EarOArQg@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/n/YtxMImIDV_dl5yR=JwCdB";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/n/YtxMImIDV_dl5yR=JwCdB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Sep 2024 14:28:01 +0200
Lukas Bulwahn <lbulwahn@redhat.com> wrote:

> On Fri, Sep 13, 2024 at 2:25=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wro=
te:
> >
> > On Fri, Sep 13, 2024, at 11:50, Lukas Bulwahn wrote: =20
> > > From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> > >
> > > Commit 3e0bae7f35c9 ("ARM: ep93xx: delete all boardfiles") removes
> > > ts72xx.c, but misses to adjust the ARM/CIRRUS LOGIC BK3 MACHINE
> > > SUPPORT section, which is referring to this file. Hence,
> > > ./scripts/get_maintainer.pl --self-test=3Dpatterns complains about
> > > a broken reference.
> > >
> > > As the corresponding file of this section is gone, remove the
> > > whole section and note this previous contribution in the CREDITS
> > > instead.
> > >
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> > > ---
> > > Arnd, please pick this quick administration fix on top of the
> > > commit above. Thanks. =20
> >
> > The machine should still work as before, I think we should
> > instead adapt the path to point to
> >
> > F: arch/arm/boot/dts/cirrus/ep93xx-bk3.dts
> > F: arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts
> > =20
>=20
> Okay, I will do that and send a v2.
>=20
> Lukas
>=20

Reviewed-by: Lukasz Majewski <lukma@denx.de>


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/n/YtxMImIDV_dl5yR=JwCdB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbkMbkACgkQAR8vZIA0
zr1WZAf/Z3JptwHfnb18PQTtsf9hYja7le2+kZK6Cd5d0c4o5c3nhiwMd7xwLczi
rG/2aLZNEkaNZdsA5bB9H2pGgl1fEE2gx3dD4ncqxhRMi3RsEV2kqVmBE7+SR28J
I0DNM8D3CWCH4ixnWcms/8UvYKIzxqJZUtS3XTizzKjO1sLBHe3UMLd7dzXSFhtN
Z4/qmpdDeU+HZwdR+NzfyHC576DanaoI8Mlmu9IMRLT8Fy9n2TQgky87P0k8iAq/
O6hfLxDp9tz/FbM5JQMd5ZQZx53cDw14Z5Ixtdn9g0v5WXUO/ZZZDWj4WbhqLHFj
QByWMOIkH50JDKefEE6756ty5sn+OA==
=0zAK
-----END PGP SIGNATURE-----

--Sig_/n/YtxMImIDV_dl5yR=JwCdB--

