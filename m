Return-Path: <linux-kernel+bounces-577490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF91A71DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA457A356B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E390423FC48;
	Wed, 26 Mar 2025 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGuYJ0Oj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE311F95C;
	Wed, 26 Mar 2025 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011750; cv=none; b=VLrkXz9rHjyV8NV0PYaKKBc/6HQyBqPGdt1mKJtidmVqhjuhmRNm0oHKuLb3E6FXlJEG7X7d5fnenQON3x1X0Xd1W8DWmq3gnHpWgVqJt4PRn9BRE3HuFj3tW0vko8DOR4vrOAlcnKVJ/EVjivP57weebbLmQhsEJXDhpvMH4GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011750; c=relaxed/simple;
	bh=Pfbg4v0DebGjPxxWA2H3tagASlPqCzzk/T3jUMFOpVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hd2r+lXGQukws3L/oajudeMO2j/JxXUl1OKmZ6HP0D+OIJaj6/WpcC27MbUaJruFcT7DuggBQBzJUWA8muz857MmRrfWapkVhe3uKJywPNpGz/iJOB0aEFVe2Nh9+W5dPyHWU6bNC40Ije8eveICXiCvk6vNlrp5EKkZKj7Ropk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGuYJ0Oj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB1FC4CEE2;
	Wed, 26 Mar 2025 17:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743011749;
	bh=Pfbg4v0DebGjPxxWA2H3tagASlPqCzzk/T3jUMFOpVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YGuYJ0Oja57q8CSfcJRR1aqMWPnV4WDD3RQN+SO/EuxjLrVzIclJJOK8tXWg6KXwo
	 vHzFZqaHbHuMu1mbOI4l6/TgHn5Q2SyCkpOtgHFKjPIZSfwYBpFBLIVQLKLaTaoO78
	 4bP5mIxYIQX7jPgVkkPyKW2M250m6VIMMTUYgBpgUCYGg4tk/FlCcBmwPeKybgJ3X+
	 OoM+TJFlsMjafJDuNp2o7HYF9nh3W7sq3EFFjFiQyrvRwuOeWXOr1Xuj9fSS91cY1q
	 e7FM04/3zdaREWyXE+sadvpG+Bjr8HM2O59t1owPdMsHXFl4ne3ofs9uEsoV6oR8J8
	 3WK0dAFTkq6Ow==
Date: Wed, 26 Mar 2025 17:55:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia <a-bhatia1@ti.com>,
	"rafal@milecki.pl" <rafal@milecki.pl>,
	Anup Patel <anup@brainfault.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/10] riscv: dts: add initial support for EIC7700 SoC
Message-ID: <20250326-headpiece-muskiness-dc167183018e@spud>
References: <20250320105449.2094192-1-pinkesh.vaghela@einfochips.com>
 <20250320105449.2094192-10-pinkesh.vaghela@einfochips.com>
 <CAJM55Z-LUoeh0pSDnPKpduub_UBOPeg4g3t20JA0GBosJKuiAQ@mail.gmail.com>
 <CH3PR04MB89282DDB25C289C34581DC0083A62@CH3PR04MB8928.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rTLsjSiGtjGVhaqj"
Content-Disposition: inline
In-Reply-To: <CH3PR04MB89282DDB25C289C34581DC0083A62@CH3PR04MB8928.namprd04.prod.outlook.com>


--rTLsjSiGtjGVhaqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 02:20:55PM +0000, Pinkesh Vaghela wrote:
> On Tue, Mar 25, 2025 at 7:06 PM, Emil Renner Berthing wrote:
> > Pinkesh Vaghela wrote:
> > > +     soc {
> > > +             compatible =3D "simple-bus";
> > > +             ranges;
> > > +             interrupt-parent =3D <&plic>;
> > > +             #address-cells =3D <2>;
> > > +             #size-cells =3D <2>;
> >=20
> > Hi Pinkesh,
> >=20
> > Thank your for the patches!
> >=20
> > Should this not be marked dma-noncoherent to avoid having to mark each
> > peripheral as such?
>=20
> Thanks for your feedback.
>=20
> We have not added "dma-noncoherent" because there are no DMA-capable
> peripherals in the devicetree yet.
> We planned to add this later when we add any DMA capable devices
> i.e. sdhci, gmac, sata, pcie, spi.
>=20
> Do you recommend to add this property in current version?

If the bus is not cache coherent, then it should be marked as such now.

--rTLsjSiGtjGVhaqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ+Q/ngAKCRB4tDGHoIJi
0n7aAP4jVxpp0wr2qb1fmfC7vFhxjp/hYUFQHIsYJhgPw/AWWAD8C8fH2G1sWMmf
o5lcIaBpmpHNe5dwLWy9UJh331OzZQM=
=xhbb
-----END PGP SIGNATURE-----

--rTLsjSiGtjGVhaqj--

