Return-Path: <linux-kernel+bounces-196583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD48D5E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46DE21F21F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787F081ACB;
	Fri, 31 May 2024 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="hOWHqTxx"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF681724
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147924; cv=none; b=nntb3lIKU57b9MeVqqv3EIXeReYGo8yIJrJLU6lZGGB5LfQ/BnuznyLup2HSfIG+/+z9WXKatTY0Sf95LFR6j71rL+vJ1DqnJ3TmXuFMNtdiMAPETQ/cSF2mvIwCVHAjTbe2L1kGabUVG/v6QCYNpnDK/GUkARxu3GMCrmOab84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147924; c=relaxed/simple;
	bh=5U7FyklsEaq5Z77Xh71GF62p+k3mhNStH7+QJ6d8CG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4gK0uuEJuybxrDWxSZ045rEAu3INc7pZDFpwon1nK6dORTEJRAK7UMXJd88BfZ+my5uK0JkqbbIRqTtD8Uw13fIqZDDhflYbFpWI3CNiCBAMY8t0LkRZq0SPNET2vmkfLPZBl6uRVmSBF+uZI7I64T3r/s8L/oCJBv1c2Ra3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=hOWHqTxx; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=duxs
	2uujR9NRLXhAk81tC9D0XnsOzJhWFLu0vA/jvfo=; b=hOWHqTxxNcqGINU4ZS5V
	8MKGNRQ1ywH86zYBzxlq9zwDNbGRiiSw5RvoUrm48F2QpF0DCXRMrgO1kjOrvHzs
	4czC037sbomdEVd9YlqOIwXxeyhEw9stc5w2H33Wdz1y61ck7YCnA6DUZG3Nahtb
	XNQWWa/d8HSv7t8HZv5J9/+MT9/VFmZfwwa48cmWDpIkg7TvIGzISVhjTr1XaOWz
	27CkblNe7VFsPOMdAPFv1s9oy9EfYIKgHFXApaatbxu3BnLUYeHxS8ruz8//uZMM
	IFXNJ4LCDGR66sMqy3QBipWsNdt2fB4qCdn/V6OfG2cnFhbkSCA45K4eYexWXN0g
	6A==
Received: (qmail 1124244 invoked from network); 31 May 2024 11:31:55 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 31 May 2024 11:31:55 +0200
X-UD-Smtp-Session: l3s3148p1@C1GEp7wZ4rFehhtB
Date: Fri, 31 May 2024 11:31:54 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	linux-hwmon@vger.kernel.org, Hristo Venev <hristo@venev.name>,
	=?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature
 sensors
Message-ID: <20240531093154.rna2vwbfx7csu2sj@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	linux-hwmon@vger.kernel.org, Hristo Venev <hristo@venev.name>,
	=?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
 <34a4292e-c4db-4b40-822e-b892e1444045@t-8ch.de>
 <16e448f1-cfc9-4e88-b3f1-55e1856d1405@roeck-us.net>
 <0a2ed64d-06d9-45e8-a054-4ded4429f952@t-8ch.de>
 <ffd72953-ecd2-405a-ad6d-236143b26946@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xeb7swmh4n3lar4t"
Content-Disposition: inline
In-Reply-To: <ffd72953-ecd2-405a-ad6d-236143b26946@roeck-us.net>


--xeb7swmh4n3lar4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

> > Wolfgang seems to think it's important:

Wolfram, please.

> > https://lore.kernel.org/lkml/tdia472d4pow2osabef24y2ujkkquplfajxmmtk5pn=
xllsdxsz@wxzynz7llasr/
> >=20
>=20
> Ok, but that doesn't explain the reason. Wolfram, Paul, why do you
> think this is needed ? Note that I am not opposed to adding spd
> eeprom support, but I'd like to know why I am doing it before
> I spend time on it.

A working eeprom driver is needed to get 'decode-dimms' from the
i2c-tools package working. Jean reported that EEPROM access for DDR5 is
different from DDR4, so it needs a separate driver. And
i2c_register_spd() then needs to be updated to use the new driver for
DDR5.

Happy hacking,

   Wolfram

--xeb7swmh4n3lar4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZZmQcACgkQFA3kzBSg
KbYuTg/6A5ij4YXV/CfauyFRASldgEnInfw2WdYkuXzCtfXvsZCRvP15BLSBEH9K
VKEnsN6sysLVyMnIJnfH8/hQ+6eOniAio8fcPIcxHQyWZOOZeqEa5pOyBuGoXZYS
/5DTYEjeII6iOILpNCQa2s6gbK3IPZioCheK8WliLIiTYO5vpjg4QVjHO7R6MK6o
u/Fp8goQNofhZRqijddVMVc1m3r8EAgfU5tb+DLgM3x9WWzl0IFWKAPbtkcyuTPs
kVwaJj35pWJG6zAQKmu+6213QIlmFVZM8ODPtTvYD1lc9Msrnq366u+SCrWuu5vF
zxmZkp8+C1uHq/jXroOEQaYZQJ9ncMDtZ/aDhwV7nZz0RfhPTGSq7PdTg/q5S1gW
bQMt3uGdDaTGD70IAHoXZjKMBO6J2mDAmjvLX89krNCNpj9r3rqekJU8Rr6g7Bji
XFpPaCvZHEC7QswW07/TIDhCF5dgTaUIQxtQvYcb1ioROTFFenqMk4LNkJ1zLGtb
+lr4D6Fyqv2Is2ZEVSQi9Y6Xh9Q5zS4tYcbhiItsnxjOqGQfQF3aPRvreeauFEyk
DdGuiSZWrub8Gg2EsOUAgrL6gJ55uu9s14Ke2UsxcS7/GWfDyK/tJACWzpW2Swdc
8j5H3E1hxJFiXVloKf040i9jT0odS0H2fSXHyaWpjhJTJbc9e28=
=gjGP
-----END PGP SIGNATURE-----

--xeb7swmh4n3lar4t--

