Return-Path: <linux-kernel+bounces-173565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2B68C0241
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7793D1F24563
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C86379F6;
	Wed,  8 May 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cehDNeeg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B76563E;
	Wed,  8 May 2024 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715186862; cv=none; b=BWLpGWtXHcAKJuAc/7Q3uvz6HHcSABDovaIpxPfmpMRDZzwDGV/SHLjfILFPz/1fpNxrkJkBo/+A77NRQcIfGTgJ7gwONb1OM3MoOuDllxv46zbZcqqqbukSAsmcWv7gi9VFJQJ+4p8XpWAXjh6pXmrCC8rIGMdbQml64PvGav8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715186862; c=relaxed/simple;
	bh=G/+RUT2k7UJ/l1fi7XiRqiYTHntagvnq92yu5KTJVrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PicPJ1pqrfU+VoXwFKFuYuXMSDxFhwxcpI1rI/7HMOTrmf4t1f5LbXyyiRO00mmLbbawaTrvOsBXT2J8q1Lzq8u7uyPKFsBG2fwIewpCrbfjLJnBDcTwVEJC40aaHPtybO/qn76s1QEysEHU3lM0LljKdjCVFvf8OP6lgo2+KLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cehDNeeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD03C113CC;
	Wed,  8 May 2024 16:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715186860;
	bh=G/+RUT2k7UJ/l1fi7XiRqiYTHntagvnq92yu5KTJVrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cehDNeeg9X/ZTdTbSBR2lwvZ51WhdQzmbG5tw2STpkKdvSRc0cJrhgHjXhP6Xu060
	 /E2t9dKjv2tBkWBjNtDsIUT+WjC7ykSUYl54ZQc3+AGVxBbIl5vzxqv9Dk9Z8Au1DI
	 oJY6j8P988d0B6O3L2gP12PLJL3CnJchiJAwI/fmNQS31azgiG4duHjizX/UJcB1Hk
	 w8IKewoDNEzDtJTDrjFekF6Q56SSetQ0MDubEkVXLGg0NugYL0T5b269EzZdWkHcHs
	 hb0X6bDn+F0SGTPHT2vPn1siHxsKToJruw+/9aX1vUdS2E0J44doEbIvRFUBDr/tKr
	 6i7UqI8IHNWGg==
Date: Wed, 8 May 2024 17:47:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chanh Nguyen <chanh@os.amperecomputing.com>,
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Justin Ledford <justinledford@google.com>,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>,
	Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: hwmon: max31790: Add
 maxim,pwmout-pin-as-tach-input property
Message-ID: <20240508-onward-sedation-621cc48fa83f@spud>
References: <20240414042246.8681-4-chanh@os.amperecomputing.com>
 <13b195e6-cbbd-4f74-a6fa-d874cb4aaa45@linaro.org>
 <065243cc-09cf-4087-8842-bd4394fb324f@amperemail.onmicrosoft.com>
 <d549cf2b-a7fa-4644-8fcb-3c420503ee01@amperemail.onmicrosoft.com>
 <20240423-gallantly-slurp-24adbfbd6f09@spud>
 <ab5cfd8c-0e88-4194-a77e-5ffbb6890319@amperemail.onmicrosoft.com>
 <396b47f5-9604-44ab-881f-94d0664bcab8@roeck-us.net>
 <0dcc8788-604a-49c1-8c6b-fdbfa9192039@amperemail.onmicrosoft.com>
 <da94fde6-3286-44eb-a543-c2ac4d11cd32@roeck-us.net>
 <8fb38eb3-bb94-49cc-b5bc-80989d7876b9@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UUlXLBmKvVSmrjpp"
Content-Disposition: inline
In-Reply-To: <8fb38eb3-bb94-49cc-b5bc-80989d7876b9@amperemail.onmicrosoft.com>


--UUlXLBmKvVSmrjpp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 10:44:34AM +0700, Chanh Nguyen wrote:
> On 05/05/2024 22:40, Guenter Roeck wrote:
> > On 5/5/24 03:08, Chanh Nguyen wrote:
> > > On 25/04/2024 21:05, Guenter Roeck wrote:
> > > > On 4/25/24 03:33, Chanh Nguyen wrote:
> > > >=20
> > > > pwm outputs on MAX31790 are always tied to the matching
> > > > tachometer inputs
> > > > (pwm1 <--> tach1 etc) and can not be reconfigured, meaning tach-ch =
for
> > > > channel X would always be X.
> > > >=20
> > > > > I would like to open a discussion about whether we should
> > > > > use the tach-ch property on the fan-common.yaml
> > > > >=20
> > > > > I'm looking forward to hearing comments from everyone. For
> > > > > me, both tach-ch and vendor property are good.
> > > > >=20
> > > >=20
> > > > I am not even sure how to define tach-ch to mean "use the pwm outpu=
t pin
> > > > associated with this tachometer input channel not as pwm output
> > > > but as tachometer input". That would be a boolean, not a number.
> > > >=20
> > >=20
> > > Thank Guenter,
> > >=20
> > > I reviewed again the "tach-ch" property, which is used in the https:/=
/elixir.bootlin.com/linux/v6.9-rc6/source/Documentation/devicetree/bindings=
/hwmon/aspeed,g6-pwm-tach.yaml#L68
> > > and https://elixir.bootlin.com/linux/v6.9-rc6/source/drivers/hwmon/as=
peed-g6-pwm-tach.c#L434
> > >=20
> > > That is something completely different from my purpose.
> > >=20
> >=20
> > Based on its definition, tach-ch is associated with fans, and it looks
> > like the .yaml file groups multiple sets of fans into a single
> > fan node.
> >=20
> > In the simple case that would be
> >  =A0=A0=A0=A0tach-ch =3D <1>
> > ...
> >  =A0=A0=A0=A0tach-ch =3D <12>
> >=20
> > or, if all fans are controlled by a single pwm
> >  =A0=A0=A0=A0tach-ch =3D <1 2 3 4 5 6 8 9 10 11 12>
> >=20
> > The existence of tachometer channel 7..12 implies that pwm channel
> > (tachometer
> > channel - 6) is used as tachometer channel. That should be sufficient to
> > program
> > the chip for that channel. All you'd have to do is to ensure that pwm
> > channel
> > "X" is not listed as tachometer channel "X + 6", and program pwm channel
> > "X - 6"
> > for tachometer channels 7..12 as tachometer channels.
> >=20
>=20
> Hi Guenter,
>=20
> I applied the patch [2/3] in my patch series (https://lore.kernel.org/lkm=
l/20240414042246.8681-3-chanh@os.amperecomputing.com/)
>=20
> My device tree is configured as below, I would like to configure PWMOUT p=
ins
> 5 and 6 to become the tachometer input pins.
>=20
>        fan-controller@20 {
>          compatible =3D "maxim,max31790";
>          reg =3D <0x20>;
>          maxim,pwmout-pin-as-tach-input =3D /bits/ 8 <0 0 0 0 1 1>;
>        };

Why are you still operating off a binding that looks like this? I
thought that both I and Krzysztof told you to go and take a look at how
the aspeed,g6-pwm-tach.yaml binding looped and do something similar
here. You'd end up with something like:

        fan-controller@20 {
          compatible =3D "maxim,max31790";
          reg =3D <0x20>;

          fan-0 {
            pwms =3D <&pwm-provider ...>;
            tach-ch =3D 6;
        };

          fan-1 {
            pwms =3D <&pwm-provider ...>;
            tach-ch =3D 7;
        };
};

You can, as tach-ch or pwms do not need to be unique, set multiple
channels up as using the same tachs and/or pwms.
In the case of this particular fan controller, I think that the max31790
is actually the pwm provider so you'd modify it something like:

        pwm-provider: fan-controller@20 {
          compatible =3D "maxim,max31790";
          reg =3D <0x20>;
	  #pwm-cells =3D <N>;

          fan-0 {
            pwms =3D <&pwm-provider ...>;
            tach-ch =3D <6>;
        };

          fan-1 {
            pwms =3D <&pwm-provider ...>;
            tach-ch =3D <7>;
        };
};

I just wrote this in my mail client's editor, so it may not be not
valid, but it is how the fan bindings expect you to represent this kind
of scenario.

Cheers,
Conor.

>=20
> The sysfs is generated by the max31790 driver are shown below. We can see
> the PWM5 and PWM6 are not visible, and the fan11 and fan12 are visible. A=
nd
> all FAN devices are on my system, which worked as expected.
>=20
> root@my-platform:/sys/class/hwmon/hwmon14# ls
> device       fan12_input  fan1_target  fan2_target  fan3_target fan4_targ=
et
> fan6_enable  of_node      pwm2         pwm4
> fan11_fault  fan1_enable  fan2_enable  fan3_enable  fan4_enable fan5_enab=
le
> fan6_fault   power        pwm2_enable  pwm4_enable
> fan11_input  fan1_fault   fan2_fault   fan3_fault   fan4_fault fan5_fault
> fan6_input   pwm1         pwm3         subsystem
> fan12_fault  fan1_input   fan2_input   fan3_input   fan4_input fan5_input
> name         pwm1_enable  pwm3_enable  uevent
>=20
> Please share your comments!
>=20
> > Hope this helps,
> > Guenter
> >=20

--UUlXLBmKvVSmrjpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjuspwAKCRB4tDGHoIJi
0tPqAP98wTeQweynaGBZg9YPawUPkDkuuI83sV+oyQj48YYoIwEA5FJvt12KWF00
iVizwm+RfmufPUV1B5XMz/CFaVou7wU=
=wzZY
-----END PGP SIGNATURE-----

--UUlXLBmKvVSmrjpp--

