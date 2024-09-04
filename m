Return-Path: <linux-kernel+bounces-312569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBBC969849
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC03284789
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1851A19CC37;
	Tue,  3 Sep 2024 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="QVEdgcSL"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451F1C767C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354408; cv=none; b=mIbhDI2Wv76k5D8KdP1dXehgTSMUhfaE46826dYCftKicOd6p37pJlMXMPOaaOTKy2JR4U5qkvzrSQrClfQgkU/su6qtVTmF1qvn8QQ96YU0zpyS/ohGO96J4VNGgf95Nkyex7y/9initJsLkrfP3yE5hUl8vVwtuibzoK2fdeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354408; c=relaxed/simple;
	bh=IzUkASmVBhhkR7/E3ib+lRjd7Ufd9l79gZR4ON52Xbk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHgpHmiR4ocoM4IrdeqDe3a033vZEaIKjholYJZYS079z/LnOJdrzRXhTuY0gXckz/+/bXgmpOckzjRpWBZJrEydLCW7ET4QUeq7SudJb00ADRML0D0oIfP3LJZ+iH1evy7KqRHl/TqNJhOynFZ1POQno5iHRxePLswJR/iUbWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=QVEdgcSL; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=0l60
	mDZWha78z4BMXkRc5lA9s8OUd89h/gv5gzHAiJU=; b=QVEdgcSLKXRTqAa8Qks4
	vm3jdgscH9e0ru5e8OBfLGy1FOwGYBbDVcJhwgTKuIvPvUj+kELHP3tvDLuNcc4L
	tkoMcaiP2eUb0K7RaNpbeDYc5ZxwElL+aFvN4VgIAQCIqhlz0136ATaVzzhM9a5K
	8ve/FMIxSIRbU1PVQb67+TIxycn6yK/7lI6kTVamu7VJSXDTDEpCLUSFk/98s7EC
	LkMrdeW+XBAaDHXFV2CFcHiy+plyZQ43mbWGqiXVQV7G7z1DmPWARIsJHfoo0HeM
	fEaw4nag2jZapzXmiGHLrspUckzJEhO/5RyaxHS9gbb5H+GrvB5yTbQltb6a0qql
	Yg==
Received: (qmail 193677 invoked from network); 3 Sep 2024 11:06:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Sep 2024 11:06:44 +0200
X-UD-Smtp-Session: l3s3148p1@pCJfYDMhZJIgAwDPXwdRANgvu6DX4+2c
Date: Tue, 3 Sep 2024 11:06:44 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Wolfram Sang <wsa@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] driver core: class: warn if a compatibility class is
 registered
Message-ID: <ZtbRpMbX6g6vLUzO@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Wolfram Sang <wsa@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4660a46b-9128-4407-8baa-f257245784a3@gmail.com>
 <7bc5fa50-59f6-4455-8f77-1c89f1e17d0b@gmail.com>
 <2024090242-smother-preview-a1d2@gregkh>
 <ZtbRLOUO48PzOKmC@shikoro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v0fjQjetsp/SB+j4"
Content-Disposition: inline
In-Reply-To: <ZtbRLOUO48PzOKmC@shikoro>


--v0fjQjetsp/SB+j4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2024 at 11:04:44AM +0200, Wolfram Sang wrote:
>=20
> > > +	pr_warn("Compatibility class %s will go away soon, please migrate u=
serspace tools to use bus devices\n",
> > > +		name);
> >=20
> > That's not going to do anything except annoy users who have no control
> > over this, sorry.  Please just fix up all of the kernel and then delete
> > this function.
>=20
> So, we deprecated this sysfs-class 15 years ago and hid it with a
> Kconfig symbol. However, we never pursued this further, so e.g. Debian
> has the Kconfig symbol still enabled. Can we really remove this from one
> release to the next without another transition period? I am not afraid
> of tools like lm-sensors which were converted long ago. But custom code
> might rely on sysfs-paths created by this class. It was even advertised
> in IPMI docs until last week (fixed now).

I missed that Heiner was changing the driver core, not I2C core. So, to
give more details, I am talking about I2C_COMPAT and the "i2c-adapter"
class. The main question from above still stands.


--v0fjQjetsp/SB+j4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmbW0aMACgkQFA3kzBSg
KbZwhg//YMrhB2flK/cBpsgH+QMCftJcyuWkZDEwQJM9Gz7QAJLZ9alFR/lcKS5Q
VM/3T7Oa2NlEEfjKDN92E9ovqD+OLQ021CKGHHcnJS8Jo1dxU/TjPr0kL376gGNz
amKjjxLb8C+LqNitbef8i4vp97Y8k2OApB1GlHLpQV09MCKR3RIepuywrZy07kFY
yW9uZ7mRykNET/a7VWvJnsGk8mn4BTmPYTle+d81cyUmsVt2XbtQKTva+GYsXHwl
Ebe7M7VWju0rVWsvwnMpqGsBqUBZ1dU3NPxw3DEq6MFmsmo4nOaFrXwU3x8Q+ipH
+8moX+j6Qy3Pr4RHr48Xw7DEn9V/jtM0N/DPrp8AY2mImXD9pccUk1q5FGYoQCRp
9560TEhkfavV2pCt+er0bM7X9GRBNfyXjx94R9eOHD2xmh28MxUEihFRiyP70rP0
1Md76cx/l3mGccdS2KWqNCgK012ZpJiWoEAVTM3WhWML+NwccqJ8XYi+WcOQMnSS
2T33yprPFBfN1bB2uMXe3qfWHb+mu3U2Q+lhUTkqJTOL/a1LWH+ZSryCatp/2yBJ
AECjL+CsFpYJNq5kA5c4SBYikQPEJREqdaGKosFDGhmRcjzoMcmztu/8dJP6FVEF
uefE2ZBHiOWOaB2dGikYx6GY1IHi+KDCTMIthYaaw+QIVSNabcY=
=n4/e
-----END PGP SIGNATURE-----

--v0fjQjetsp/SB+j4--

