Return-Path: <linux-kernel+bounces-332048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC7F97B4CC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB0D1F21D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 20:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D3618DF78;
	Tue, 17 Sep 2024 20:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUxDeaUj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09F918A956;
	Tue, 17 Sep 2024 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726605574; cv=none; b=N2yCe0NeaXaBBUH61gU/h043DDjE3w7bpx2OpotswA17TDdzE5SWYjPn/y/C5+JJvbJIN1jHP3oSDcenygTGi+9URy9wzBwWqQuEfD39wJRrFIkmYdqzTsj/5HVpGDb4pwHJCKM7vfI/SI+4Ss4SLPBhh2opjaLmI2WIBs9EMDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726605574; c=relaxed/simple;
	bh=0HicAuQ7P4k7rB6kUC65cuuL9SsgwfK6nMrWRe6yy8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i49EKq31yVn3+oxgJZGbf3NFwL7QFsZ34yvKgLAIOH+2kX8ZSyTDSAKgtmI8IKbe9Pjp0cfgLCDHktjfy84bwMKMxvxDSwFp7vF1rEoIUszfnXrD1c+Bbt1w1GjeIVvQ81EtgcHv9NGnCZ7ejCuGTzeao5O8FPc7rtti172/IeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUxDeaUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EE8C4CED6;
	Tue, 17 Sep 2024 20:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726605574;
	bh=0HicAuQ7P4k7rB6kUC65cuuL9SsgwfK6nMrWRe6yy8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DUxDeaUjr1AiI4x22SIwLPRU8w/fw+DEbzDo/m1zcyKg1Z7RjLQ3mNGT8CFF6uC3j
	 ssfi86AozeA8a6rrKVMdrfDL842Ct0o1hxBuLPPpi1iYdbelHJM33uSIFG7HwKJb4X
	 GGWzVyA7b7PkPQgRKAw8H1Au3DQGQL43w4WPbmQ7UMsZEtzeXoj4cNNeyIjlKP8bDm
	 U5B9BDHuZaULvZXZYrTfX72DO2KBW6Yyub8yT3A6iZ66hIci2ncFk3vv6GNtfRu+qD
	 bI05uEp6crFil6rckWh8XR3YpJeLozYNcIZszErdbmFKi+rYAe1FfgqG0nOnX0yHWV
	 VC7XzJmFa84ag==
Date: Tue, 17 Sep 2024 21:39:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Erez <erezgeva2@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Erez Geva <erezgeva@nwtime.org>,
	linux-mtd@lists.infradead.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: mtd: spi-nor: add OTP parameters
Message-ID: <20240917-taps-applied-6c0d411bbe08@squawk>
References: <20240917094956.437078-1-erezgeva@nwtime.org>
 <20240917094956.437078-4-erezgeva@nwtime.org>
 <9c273945-5a70-408e-a9da-a0797aa6d935@kernel.org>
 <CANeKEMN+ZUAGKGsqnaToDB3AxX9NN_JeCBWHwd-wwnTWLU3R+g@mail.gmail.com>
 <64ef46b1-7908-4b15-866d-9cabe2e5dc9e@kernel.org>
 <CANeKEMPwgtECfksgz6jXkR+bjVFwCB9DOh1q7t_3WeojReqxbA@mail.gmail.com>
 <e0db2f62-b2fd-4b61-932c-cc2caf5dd647@kernel.org>
 <CANeKEMNCFKX2thq+Ws0vy9ovbQ7dve3YPh_FbRaoOEgL+7c_Mw@mail.gmail.com>
 <fe98e49d-96d1-462f-99ac-93d8a53e55fd@kernel.org>
 <CANeKEMNg_hPcVHVo2c9u1Vdzaso0ODT+2uLmip6sd26uK8d_FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nUwItat6u78HzFGR"
Content-Disposition: inline
In-Reply-To: <CANeKEMNg_hPcVHVo2c9u1Vdzaso0ODT+2uLmip6sd26uK8d_FQ@mail.gmail.com>


--nUwItat6u78HzFGR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 08:39:48PM +0200, Erez wrote:
> On Tue, 17 Sept 2024 at 19:32, Krzysztof Kozlowski <krzk@kernel.org> wrot=
e:
> >
> > On 17/09/2024 19:24, Erez wrote:
> > >>>>>>
> > >>>>>> It does not look like you tested the bindings, at least after qu=
ick
> > >>>>>> look. Please run `make dt_binding_check` (see
> > >>>>>
> > >>>>> I run "make dt_binding_check" on kernel 6.6.
> > >>>>
> > >>>> Yeah, we are no on kernel 6.6. You can run it also on kernel v4.1 -
> > >>>> still does not matter.
> > >>>>
> > >>>> Don't develop on ancient code because then you ask us to review sa=
me
> > >>>> broken stuff we already fixed.
> > >>>
> > >>> I test with Beaglebone black for testing, it is difficult to run the
> > >>> last vanille version.
> > >>> I did backport the spi-nor driver.
> > >>> As for "make dt_binding_check" on last kernel, it need to upgrade t=
he tools,
> > >>>  and I did not think it could change that much.
> > >>>
> > >>
> > >> Well, it is possible to build kernel on small embedded board, but th=
at's
> > >> quite cumbersone, slow and inefficient, considering that it's just
> > >> easier to cross compile. But anyway, binding check does not even need
> > >> cross compilation.
> > >>
> > >> Sorry, the code is obviously wrong, there is no such thing as u32, so
> > >> you did not test it. I provided link which explains how to test it. =
You
> > >> must do it on latest mainline kernel. Just like you must develop and
> > >> generate patches on latest mainline kernel, because this is where we
> > >> apply the patches. We do not apply them to v6.6.
> > >
> > > The patches are based on the lastest  mainline kernel.
> > > I do not understand why you think otherwise.
> >
> > Because you wrote:
> > "I run "make dt_binding_check" on kernel 6.6."
> >
> > The command is either part of build process or final check process
> > (static analyzers etc). If you say you did this on v6.6, you got such
> > response.
>=20
> I know you are NOT a service.
> The device tree is not the focus of my work.
> It should not be broken like that.
>=20
> I install dt-schema_2023.11-3_all.deb
> with Debian trixie
> I get:
>=20
> l
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> Traceback (most recent call last):
>   File "/usr/bin/dt-mk-schema", line 8, in <module>
>     sys.exit(main())
>              ^^^^^^
>   File "/usr/lib/python3/dist-packages/dtschema/mk_schema.py", line 28, i=
n main
>     schemas =3D dtschema.DTValidator(args.schemas).schemas
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3/dist-packages/dtschema/validator.py", line
> 363, in __init__
>     self.make_property_type_cache()
>   File "/usr/lib/python3/dist-packages/dtschema/validator.py", line
> 420, in make_property_type_cache
>     self.props, self.pat_props =3D get_prop_types(self.schemas)
>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3/dist-packages/dtschema/validator.py", line
> 187, in get_prop_types
>     del props[r'^[a-z][a-z0-9\-]*$']
>         ~~~~~^^^^^^^^^^^^^^^^^^^^^^^
> KeyError: '^[a-z][a-z0-9\\-]*$'
> make[2]: *** [Documentation/devicetree/bindings/Makefile:64:
> Documentation/devicetree/bindings/processed-schema.json] Error 1
> make[2]: *** Deleting file
> 'Documentation/devicetree/bindings/processed-schema.json'
> make[1]: *** [/home/builder/kernel/Makefile:1435: dt_binding_schemas] Err=
or 2

Have you considered that this might be because of the invalid types you
used?

--nUwItat6u78HzFGR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZunpBQAKCRB4tDGHoIJi
0tCaAQDTQkSgmgXWm5P+FDYxt/IgLEP6DuRS/KvfNoab8J93PAD/SGFDgPtP7E6b
XUuBR5CG2lxio6kd505+CpQsDLjghQ0=
=2n4F
-----END PGP SIGNATURE-----

--nUwItat6u78HzFGR--

