Return-Path: <linux-kernel+bounces-182432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 940D48C8B46
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36331C20A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460CF13DDD5;
	Fri, 17 May 2024 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgKkClbJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFA513DDBA;
	Fri, 17 May 2024 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967561; cv=none; b=oreC4Lh5U28y1CCugDjwRAVx2yQedye3dA3fQalD5NT6CPgXWPCTA5jLybhQBi6ayzMq4snzWLTsL/AFvaCyARSqvHCazyYAsrlwWrCOtEC8zwG5lapIHsXVh+wM80BB/DiiOdvmzVWdD79DauBd1xEaELujDQz9ZIpb9PBTxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967561; c=relaxed/simple;
	bh=tQOjsUD1QNNPdmrsBIqeqqeA294m5b+0eJ2vo742SP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9xqvbC5EBpD8xzDoavmZ9EPTdEkQ3O+t0Tcpeo5oicDBU8ot5kEnPF8tzfg99ikBwqD7U8pQIbqFMZBD6Tk0EyT0MEFocQKew3H/45PRYm3Qs0A5MohX3G1gGnwGW4SjcgD2LwouvZluSoAHo7yMUQwAXsaqmdT/GRBstIN+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgKkClbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD9DC2BD10;
	Fri, 17 May 2024 17:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715967560;
	bh=tQOjsUD1QNNPdmrsBIqeqqeA294m5b+0eJ2vo742SP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgKkClbJGWKrWh9OKsOPKK3kboH6boQ1WyzS99x6s6Ag1ExaUi5cTlR1KsA/SJRX7
	 RkQgHw7E5mxTui9FG/Q3Air3GRYzVuAl29hahZXYsFfI0mczO++A2577yDqZp+HTv2
	 qwGaPLfTJKijYjZpbNzZDykfJS0e/ZgwX/3tvDbIBPC/W6tTRd/b1lwdMVb7/FgIGx
	 tL5AMkdOCVgatLR1QIl3EAe4BuV/XypFXfPVKRP5fFt/xd+yRWyU1iggVdLZ2oI8nY
	 EMeOKBkIodjzVvhD4Lmqp+HqpI/Mj8yACd63tppRo5aFiMqhon7uSWu4biZviK1LE1
	 KItkRwvJXMqeQ==
Date: Fri, 17 May 2024 18:39:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Document adt7475 PWM initial
 duty cycle
Message-ID: <20240517-recognize-broaden-43ba03c9f78c@spud>
References: <20240508215504.300580-1-chris.packham@alliedtelesis.co.nz>
 <20240508215504.300580-2-chris.packham@alliedtelesis.co.nz>
 <fe5b3af9-b307-45e1-b190-ba2b3327a8df@kernel.org>
 <d11093bb-230b-4918-a8cd-4f4eb760ccf3@alliedtelesis.co.nz>
 <94c843e2-4415-4786-bfd4-a77fdbbfab07@roeck-us.net>
 <35361786-ef5f-4d81-83e8-e347f47c83ed@alliedtelesis.co.nz>
 <df40a387-37db-4a4d-b43f-ae22905789b5@roeck-us.net>
 <58fb36f5-4d4b-495b-a7cd-6129ab1ed454@alliedtelesis.co.nz>
 <20240517-pointer-cloning-3889f3d6f744@spud>
 <20240517-pellet-visa-a2d469dc5f34@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fU8lYHpRVmPB+Kfl"
Content-Disposition: inline
In-Reply-To: <20240517-pellet-visa-a2d469dc5f34@spud>


--fU8lYHpRVmPB+Kfl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 06:02:33PM +0100, Conor Dooley wrote:
> On Fri, May 17, 2024 at 06:00:06PM +0100, Conor Dooley wrote:
> > > On that point. How would I explain in the bindings that cell 2 is the=
=20
> > > duty cycle, cell 3 is the frequency and cell 4 is the flags?
> >=20
> > In the pwm-cells property in the pwm provider binding . You might want =
to
> > order it as <index freq flags duty> as usually that's the ordering done
> > in most (all?) pwm provider bindings that I have seen.
> > The pwm bindings I think are really unhelpful though - they all say "see
> > pwm.yaml for info on the cells in #pwm-cells, but then pwm.yaml has no
> > information. The information is actually in pwm.text, but the binding
> > conversion did s/pwm.text/pwm.yaml/ in pwm controller bindings.
> > I'll send a patch that fixes up pwm.yaml.
>=20
> Possibly cell 4 should be standardised as the period for all pwm
> providers and then all you'd have to do for your provider is set
> #pwm-cells:
>   minItems: 4

`const: 4`, d'oh.



--fU8lYHpRVmPB+Kfl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkeWRAAKCRB4tDGHoIJi
0s0VAQDSqIpwkV+XgvuoKwnRFDEwmwN4obNBWez9Gf8X0VfxpQD/cNJjz8iKe1Cx
EBjxNXyPjLRZyHdRPUETZZRnFhkObg4=
=GLZn
-----END PGP SIGNATURE-----

--fU8lYHpRVmPB+Kfl--

