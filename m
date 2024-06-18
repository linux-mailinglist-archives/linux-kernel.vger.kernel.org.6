Return-Path: <linux-kernel+bounces-220162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEE590DDB3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D5A283E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB661779B1;
	Tue, 18 Jun 2024 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3xsyea+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF5C1741EE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743579; cv=none; b=YMNG6VSmXMxN3jyrmvD3DWnYhkEeqbrtUBFeAb9Z7qOlk1pUiXFwJYIcHxYNkf10FzxClqdowmkciGyrax688thHzH02rX6qsQ092hMlPMgudJGh2C4ye2YkG61Qnz2eFklLqp5Ux9yR2zhWF/jwdtu3Q7p0OWhPV85SQGsj1Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743579; c=relaxed/simple;
	bh=W/5eL0cTkD5re/fpvMfVw7UyxGfBbAwxLzn/LzfjLmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnk+1pYsKB3vCt+VvJykjs6C5rHXcAbXVyQslqJ32vudnGwzvzVIpBHsWuKb6cy8D7wfJNEGLDcG165s5NIwzPT/E5wFT3VLfEN5H/IKcQhDfbQQuHr3yzqFLXE2Yhv6CztItDp3VTyDxgYYtzobePI2tv0chigPk0xb9eObwPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3xsyea+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC60CC3277B;
	Tue, 18 Jun 2024 20:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718743579;
	bh=W/5eL0cTkD5re/fpvMfVw7UyxGfBbAwxLzn/LzfjLmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3xsyea+SwCFJmJvw+sUIjpQkUTQKXqtkhyFkzIUFZRUnQdmy+r1DLfu7k0cd10ZD
	 cWWlKsgnsqVecYvI/3PblxillQY0fYZfI/NrhC+p+bGsZfMjLCjlpmn8EWA6RqwWEC
	 ZDtUisJw6tgrZWMANY4192Y8KX0Ubm8VAQY08rNmjVIUKNn2D7LcFHAh3zVWEzlW7z
	 A0Uvbm5IwV9qQJUlJg4mYn7axj8N0SMuUNsmx864OzHJZkpCY/RgNp9ZF9dQfBEbIO
	 +tRUdQIkJy+vDmNUWzbQuqqOqlQF97n0phkRhSY0t4f4ldJsI1+1vIfK7IcGYxxijy
	 Pn9kdIiO3Hnew==
Date: Tue, 18 Jun 2024 21:46:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
Subject: Re: Page select register restrictions in regmap core
Message-ID: <17890e6b-cf00-43cd-9d99-2383b5fbef64@sirena.org.uk>
References: <4b22e04f-3142-4a5a-a8d1-366c4b8bbb73@sirena.org.uk>
 <78c93d6b-af0e-4d96-b213-e1e402524361@roeck-us.net>
 <adcd5997-84ee-4c72-aa37-2940afdc83bd@sirena.org.uk>
 <c4a5fb5c-90b4-488b-8875-a0b819e24bcd@roeck-us.net>
 <19893519-20a6-47cf-bb3b-c61dada627bc@sirena.org.uk>
 <e6733f56-014e-4ea0-aaf8-059334f2b27f@roeck-us.net>
 <1a62fc39-355c-4885-b5f6-b66f01a1328a@sirena.org.uk>
 <0287c32d-0b63-4873-9f71-0094a912f8bb@roeck-us.net>
 <44d4fce5-2ec9-4f62-b7ac-a317c7d843db@sirena.org.uk>
 <3b47b5e3-4eb2-43f9-8f4f-c021d203305e@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z955Ry/T/YDp1VmR"
Content-Disposition: inline
In-Reply-To: <3b47b5e3-4eb2-43f9-8f4f-c021d203305e@roeck-us.net>
X-Cookie: If you can read this, you're too close.


--z955Ry/T/YDp1VmR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 12:33:40PM -0700, Guenter Roeck wrote:
> On 6/18/24 10:45, Mark Brown wrote:
> > On Tue, Jun 18, 2024 at 09:14:56AM -0700, Guenter Roeck wrote:

> > > It turns out that at least some i801 controllers don't work with the
> > > access mechanism used by regmap, or maybe the spd5118 chips don't sup=
port
> > > I2C_FUNC_SMBUS_I2C_BLOCK. I already found that those chips don't supp=
ort
> > > auto-incrementing the register address and actually reset the address=
 on byte
> > > reads (i.e., subsequent calls to i2c_smbus_read_byte() always return =
the data
> > > from the first register). Since regmap doesn't have a means for me to=
 say
> > > "don't use I2C_FUNC_SMBUS_I2C_BLOCK even if the controller supports i=
t",
> > > I may have to drop regmap support entirely anyway. That would be anno=
ying,
> > > but right now I have no idea how to work around that problem.

> > You can set the use_single_read and use_single_write flags in the config
> > to ensure registers are accessed one at a time, that restriction is
> > moderately common.

> That doesn't help, unfortunately. Thinking about it, that is not really
> surprising. The failing write is to the page register, and that was
> a single write anyway.

Oh, that's interesting - I'm kind of surprised the wire protocols differ
but it's been a while since I looked.  We should probably add this to
the quirking in regmap-i2c.c, have it select one the 8 bit only smbus
versions for devices that need register at a time operation.  I'd not be
surprised if other devices have issues, and anyway if it makes a
difference to the wire protocol we should try to select something as
close as possible to what we're actually doing.

Something like the below perhaps (this probably needs to be converted to
a match table type thing at this point, there's the SMBUS_WORD_DATA case
too):

diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-=
i2c.c
index a905e955bbfc..499fcec00f2d 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -313,6 +313,11 @@ static const struct regmap_bus *regmap_get_i2c_bus(str=
uct i2c_client *i2c,
=20
 	if (i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C))
 		bus =3D &regmap_i2c;
+	else if (config->val_bits =3D=3D 8 && config->reg_bits =3D=3D 8 &&
+		 config->use_single_read && config->use_single_write &&
+		 i2c_check_functionality(i2c->adapter,
+					 I2C_FUNC_SMBUS_BYTE_DATA))
+		bus =3D &regmap_smbus_byte;
 	else if (config->val_bits =3D=3D 8 && config->reg_bits =3D=3D 8 &&
 		 i2c_check_functionality(i2c->adapter,
 					 I2C_FUNC_SMBUS_I2C_BLOCK))
@@ -334,10 +339,6 @@ static const struct regmap_bus *regmap_get_i2c_bus(str=
uct i2c_client *i2c,
 		default:		/* everything else is not supported */
 			break;
 		}
-	else if (config->val_bits =3D=3D 8 && config->reg_bits =3D=3D 8 &&
-		 i2c_check_functionality(i2c->adapter,
-					 I2C_FUNC_SMBUS_BYTE_DATA))
-		bus =3D &regmap_smbus_byte;
=20
 	if (!bus)
 		return ERR_PTR(-ENOTSUPP);

--z955Ry/T/YDp1VmR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZx8hYACgkQJNaLcl1U
h9Cnrgf/QjznT49jDb/DWooOM/acXIOewQfAQkUVwNHqQFrUKzspCZ77zqKBWtmc
y2wDLj1vH/tG1lWKqerf3dG0hMPSwlIbxjvFbdSW3swO92n4mzEwvUI5b5//wObF
mOw5e0NCgldbfGSUxMyRxxhufWVDeGvfK8WfhZ/iARtUbVubI40urDMfN2tfv+jD
irKn0nzLANfl6CXwyh6ZavUU5uCTgM87/jc5bmtmvk+5pug1FKFe10wj0pBvj/o2
F7LVowF1yvmA3iJYA5INvVFK2rloq0kmjOgDMAqX6vrD8hN5OWv/nuyiAYIFBald
em7GT5dIr6NXHnn7ePZUcNMP2R3EcQ==
=8VbC
-----END PGP SIGNATURE-----

--z955Ry/T/YDp1VmR--

