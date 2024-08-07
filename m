Return-Path: <linux-kernel+bounces-277266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E220949E88
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A75128A468
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C514019066D;
	Wed,  7 Aug 2024 03:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="h1GTrNP0"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28242174EF0;
	Wed,  7 Aug 2024 03:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723002273; cv=none; b=ZNVcED6ZRihAeq31+pixEoP5Zuwbiyf8ZxtyPobkoNrab4Ue4KAyHl4NHV1t8ie7ob9mhiH7K97SJVGEUfIQLPy4Mnkji/I9h426z88LB+p6n+wXFnCi6Vst7AJ82MALBELd69KmG54E+g00ASm4e1txXe1W/WraUdOT3rDMPWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723002273; c=relaxed/simple;
	bh=PVAobyXrvp9LF0/pK1bI2TtfhYZ+TqZO86fi+suMTag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=q8nkWI2ZSHpWwXFquO0SSTVQCw9E9zJdf/Rxo8YAzcEP17JRCoFodoPTV5grY/kIaNNlPVlFMX+QNTNKSdQPeeubts25iF3K0htoK85Y+n3zUOjYEq2/uTj3XZtcYdulsOIcDMb2/WsYb8+aUxHhxZcHsca9XYsU8birEE/DpvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=h1GTrNP0; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1723002267;
	bh=zb1Hy9YQpMfNBWHUVMuu2Bw37SJm6+NUPrJkrSX83ZE=;
	h=Date:From:To:Cc:Subject:From;
	b=h1GTrNP0rODZSvThULqVbSfKwWLQ2WtcgOgfxo4jfwAHsKmTn1jl4H6Un1kUpF7Nx
	 dzj7DwV1RrIvuEvXtnzSQlVrNlYsgrsHu2RVBpKY8QiqEmCr5m+1VBgaJi8UJY7bbs
	 EXqKkA++dFZmDuETJmCq7UCP/67X5/hAP8DuF7GxJV7JDw2jfmaojj06y2vVdL8EhA
	 Q8SnQRmmGrmiCm4vXb1QUTB8mcF6VY1q/JRu5u3sTD2iLEQnJ50TFoo/VncRO93s7t
	 yxo6pS13JrIavxFVEyonnI1/TH6VG0w9iYbZQuV3vAbLouDyh2sfFz782mg7Ptk2Sa
	 ofulEudstGBXA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wdwyy3mdxz4w2J;
	Wed,  7 Aug 2024 13:44:26 +1000 (AEST)
Date: Wed, 7 Aug 2024 13:44:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sunil V L
 <sunilvl@ventanamicro.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the tty tree
Message-ID: <20240807134425.29473f46@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Q3qh1R+PsAYCVQIZ6HXrAkd";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Q3qh1R+PsAYCVQIZ6HXrAkd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tty tree, today's linux-next build (powerpc
ppc44x_defconfig) produced this warning:

drivers/tty/serial/8250/8250_platform.c: In function 'serial8250_platform_p=
robe':
drivers/tty/serial/8250/8250_platform.c:111:40: warning: excess elements in=
 struct initializer
  111 |         struct uart_8250_port uart =3D { 0 };
      |                                        ^
drivers/tty/serial/8250/8250_platform.c:111:40: note: (near initialization =
for 'uart.port.lock.<anonymous>.rlock.raw_lock')

Introduced by commit

  d9e5a0ce2f16 ("serial: 8250_platform: Enable generic 16550A platform devi=
ces")

--=20
Cheers,
Stephen Rothwell

--Sig_/Q3qh1R+PsAYCVQIZ6HXrAkd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmay7ZkACgkQAVBC80lX
0Gw9eAf6A8maoBA5c5iylkcSCuE1fG0TNbZKpkL8VKpQqYZKKe8RQpd9JNzcclJ7
HS3Fu6SiX1q6esGeWD0j4Jo3r+Sbu8iwD1w7ePX3mw7FmVBby9s4ymJGfkkg6Tsy
sAOCcbqrfFD+YrC7b6HGSIU1luNWqhek5xHp7cCJ9FoXb4cf5yl3hNsCpKj0G1N7
ZZ39SgpJsu4ndYKTgFK7aB20qBgOKWh5DkfwXdLICWpCdWyShGV0EiTzXwIE6lT8
k2zmBj5hi1n05rh9UTs80N765PJ0MdUyRpjR6hyOlj68fSe69Ko23waZgjfp6hyd
ouLGGEWPeLcgCJz7DfsM33oVjt8Ynw==
=xoRx
-----END PGP SIGNATURE-----

--Sig_/Q3qh1R+PsAYCVQIZ6HXrAkd--

