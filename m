Return-Path: <linux-kernel+bounces-254511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD348933418
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6931C229D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330C913E05F;
	Tue, 16 Jul 2024 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="iU+bp4R/"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C7A1860;
	Tue, 16 Jul 2024 22:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721167687; cv=none; b=KKpbdwseFbkNgWWa/NjLAKHXTVBPn/HmrXvns+o5OovWGZv54S5BTFP6mwDtfNPZOh/os+7A1IeV094uTaAnmJSqSMXsUL2LQds8+JxAXVMF9bTIJYZqvl0rMruFIXFmtwlwA/LL8lXaBTRftZHmORs4CGvVFoD2VI23NTBM+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721167687; c=relaxed/simple;
	bh=hODSREfRDluFgbXGQMEBbBidDKy7iLs2XRiYyPGpxHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEoaVr9oEpAvOPjbmcZmaar3liVCbN6cfWB/Sl0WY5ypCSJ5Dloa/9kpqaggyXZcS0PW3KGLwgpEVXKA746jqh3K9Xxf+VlzeMUfcDz+fWnGEhnuYpHrqHuv0Y32kynVyM0qWvBAHih1RnQkG8wi/RO6Njhq7ZWa7DN1fnAXDSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=iU+bp4R/; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1721167627; x=1721772427; i=christian@heusel.eu;
	bh=hODSREfRDluFgbXGQMEBbBidDKy7iLs2XRiYyPGpxHA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iU+bp4R/3uq8qrUx7L3cJGptOYgpGMXJDsh8WOg6Fc8NGHyXN1q/9l++OQw2eGQD
	 4/ikIM7F5FvwX+c0JNovykqUWpDOy7giczX0ZWqJk+ND8NeGP69lP4ILu5cGH7crH
	 qbiqlcuxwCgCtC9tlBEYnmnBBElu1h9rA6f9a4Ir7NYnKmQkQRNAQr423/6+X4sIB
	 gfYD3k0Qr/G3zqrFXDM8eOzKE7zU6ehgL6xg2myQ3vEpUaD1NMVpRqUSCfC8A7M5l
	 cCpSNNlnaoLuW8thNrWM/rpMa/invJlyCVGpF+PM+w3vBEKKmIZMV84aK+TJM2N/I
	 UpD6e671JSXCP9ubbQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MD9Gh-1scskV3Nr7-00CJhY; Wed, 17
 Jul 2024 00:07:07 +0200
Date: Wed, 17 Jul 2024 00:07:00 +0200
From: Christian Heusel <christian@heusel.eu>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, x86@kernel.org, 
	kernel-janitors@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/resctrl: Use seq_putc() in two functions
Message-ID: <bceb7649-f2fe-4418-99c3-e054f0b0e778@heusel.eu>
References: <d4be0dc8-f6db-4bf1-bb6d-ccff161dfde9@web.de>
 <cb908d7f-db6a-4b04-8867-bf36fb2dd45f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y6ltalkzb4vv3rwo"
Content-Disposition: inline
In-Reply-To: <cb908d7f-db6a-4b04-8867-bf36fb2dd45f@intel.com>
X-Provags-ID: V03:K1:vSWOgwE688DyyMWeMZOUDeewhkqFtPN3dPGlelZTOOp9f0gZLTJ
 8rRTIif4iJ2xR2xgj3k8o3OKiqK9gNCVTZxFVggPKdm9YlOkcyOiYalK28wc6QNghKeT0V6
 MaGX0aH8ygqgDOZLKLFeaVjAIc4jJrAhqi/XxsKKpw4lY1K05T+t0BBiWghPPZihUAybJy1
 3gsag1e0tEqCvUltX3UqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U/gjzIwGd5U=;5FjqhMsideAE5NN49nKHu72j/pM
 4JahZ82Q6ffcI5XZCyOHfK03gbQaRP3kq1ryIBKlh+sUExF0e6LEvQcRe1dtlbE0nvGyYOo0U
 WG9MJNBvCll73hTkrNvbVM4kNeCfhwY/VEzMDcxSfX17qjihtyvmqMMK4EUapUzCH1xiWtg3s
 0YQ9TOhOqnBQIxRiK1xXcfeiXygfu3vWB83k82uhIoklyt5ruKAqzeh4XGyZKrw4OwmPsOONU
 7ZlKTvqaFtYaeSTtPu2td+K62nU1daVda3c9kY4wcQZCnPNbK542vTs7NoX7/jxOGtpjMEW52
 hMZ5lfgS6iUFdN2qT+KaFrfS7JkEgYkTtjQCDWPVrsrON572ijbVOkQpGK3tC35BnhApvYI7X
 GSMWWKRh2n/Y8Ux3Cr1DmAVzLW1kNBooUJUQoX0FVRnWGumQcEBZ0fi62RbfdGNj+25qspVd4
 wVNV5jg6jpZYhS44OUw46mb+RAD+fB8/Uh3a0qE/GpEpCYpDZuvIyqfrDFu27ingi3vi+sXBM
 /iky68ivAoBY5vnrJ9+QoyfU8QCkKe9GTX/ig7HPI9I5ctPhPH5MqiCE4h+a+d40sqqJXjDS3
 xgyzzUsucIs7doZTbCARxM0zpKWE9WezKkpVUg3lAyvgaPf2qi80Nen0+AaOvMpu6k5cxs+Z4
 sNhSpPvM/vyhXARjSbbyo0TLMoP639EfZAzaF62deIy2q+v/qdIaKLWev18mjEbx0UeZOC2sW
 4H6iYNl7mVAx1Pc1Tr/6sNxnKX8LTaQtQ==


--y6ltalkzb4vv3rwo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/07/16 02:43PM, Reinette Chatre wrote:
> Hi Markus,
>=20
> On 7/13/24 2:00 AM, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sat, 13 Jul 2024 10:43:14 +0200
> >=20
> > Single characters should be put into a sequence.
> > Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.
> >=20
> > This issue was transformed by using the Coccinelle software.
>=20
> Could you please point me to how you accomplished this? I tried
> on the latest upstream as well as the latest resctrl staged
> changes in tip's x86/cache but the needed coccinelle scripts do
> not seem to be available. I tried by running the commands below. It appea=
red
> to run many coccinelle scripts but there was not one related to this chan=
ge.
> Is this a new coccinelle script outside of the kernel or still
> on its way upstream?
>=20
> make C=3D2 CHECK=3Dscripts/coccicheck MODE=3Dreport arch/x86/kernel/cpu/r=
esctrl/rdtgroup.o
> make C=3D2 CHECK=3Dscripts/coccicheck MODE=3Dreport arch/x86/kernel/cpu/r=
esctrl/ctrlmondata.o

Just to give some context to this: Markus usually uses extra
(out-of-tree) coccinelle scripts to change code to his liking, sometimes
these are good changes, sometimes they are meaningless.

See for example this:

https://lore.kernel.org/all/50978c86-cf4a-991d-54ab-50d8d977f946@inria.fr/

Some well known kernel contributors also have auto-replies (although in
a different context) specially for this contributor:

https://lore.kernel.org/all/2024071537-schematic-envoy-4272@gregkh/

Cheers,
Chris

--y6ltalkzb4vv3rwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmaW7wQACgkQwEfU8yi1
JYW1tA/8DRCccUwrl+46G4j1tGXoqdQDdaIvbZkH5hNWzdiInuXbUmBxyh/bXBH0
Wl52Cy5rpxaEvruE6ePzueWweMDhZehmXL/SYVSjUuoVG/2tKw9u7QyCi/3XbZ4S
8tL+/LgYMeEQitnTOq6bGmQI8gC+3GCLMXgT2VLediPpe8kkXGV/iO5NRTRn7csK
jQ9Tg/6XQFs6gcMApo0O8pY4nmZJSVRc+7PMvRw/5Osn+cwXujU1JOZrHD6ADm/w
zY53BQgZHnfovxFcJDo3uqNzosAdxKjRu1WRAms3UrQQPBTb7J3HjqkUJYkHIelA
3zZy/ifI4D3QnarQfCeEHLl6VdghEHLd/uJRqtihiHP2XXiUA25hvVXGyTVSS7UG
aT7L9VxivhyQeYVSDhLN22fkh/fxvTXNqYnCcMCeHivt/TmqY1biz8+U5rlevQZr
Y2n1PA36lhE5LSFGYDT9ijrEYmFdWwTH0kWRWAKanRYnIG5I2ih921QncK0V4nDB
6Hvpbe8o2mWEM4m8yY/CA4/YYqSoHsNEgLqQ/QzEm0PB8wXeyZ0h1uzYnatzroFg
w4tnlQcxkwO4ON5XFzR279/0S8bLUNwRoXZj4dhmzO8nfOc7w0+UQ86nzXXYSKql
dVuj9oRJqEE9EGJLwe3ut1KaN7Gu1Q1VMhOF68v/qy6O1IjXq08=
=PUtT
-----END PGP SIGNATURE-----

--y6ltalkzb4vv3rwo--

