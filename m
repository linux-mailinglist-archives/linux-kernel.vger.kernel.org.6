Return-Path: <linux-kernel+bounces-299206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE5E95D17F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067841F239EB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FAC188A3E;
	Fri, 23 Aug 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnA3+tSe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0251188920;
	Fri, 23 Aug 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427276; cv=none; b=Wb0Z+WsjbCfBx71bXSyllbqqdQUAViO9iSzxrQG2lkS/SeCvDVNh0NVrKtryUJOceol+3453+DmQ/Er1m//Yi4XcFzcfZYzcyFZlAnqc7+9rKXTyUi3RDGQhcj4If86LM/AVVQzyjjILQBTL/1eXuUMlR21aNE0h5NBnmzQtW0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427276; c=relaxed/simple;
	bh=7Vr6P3VkT/qk39oMWJkJ0VkShl1bY6v2wyuJA+/bppk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdtZXz6upCORljKVw+ZaSvhajVDAAkC8xN2umfVeVoWtAPNK8YOfV7uETfxDrjpPyPr/CX+ZKkIrERfbtakgB32mjkza75xFur+Lf5CcdgMKTD5qAKZrim80u7bjayde+GY4X/9lZcmyzi66F3pecU8j3NTvE2c4eUpBcMRmzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnA3+tSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B63C4AF0B;
	Fri, 23 Aug 2024 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724427276;
	bh=7Vr6P3VkT/qk39oMWJkJ0VkShl1bY6v2wyuJA+/bppk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gnA3+tSeMJ2IqGzesp7ePQLpRBg9Li+oDYImoDYiPhNTA+eVILkWR+4jGhLlHTRts
	 /0+XSmqDpvj0cwITX0AkaeIxQYak7NOMMZnLHz91QvjXkl7G5r0ceFAVPJO2YH2n4N
	 GMfEM8HfwCHkJSrxZic9Mmju9hFEQinWKEmR0Mfy4YuYitLgcPgMrC7TCz4U6qnZph
	 a1bU5Vw1trjyxoxW6umQRnt9YelvTjbpdNtpT9KmeHM5+Jf2E2BpwSsiznwUfN2IzM
	 UHreZyuuwaq81y8OAYIuoKRuEcfxs/OEzmL+cX7IP8vpc1bTGayBRft9AO7GiW/ajB
	 dFTIwLEJwgrWw==
Date: Fri, 23 Aug 2024 16:34:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v6] clk: starfive: jh7110-sys: Fix lower rate of CPUfreq
 by setting PLL0 rate to 1.5GHz
Message-ID: <20240823-able-subtype-4e9a2049c114@spud>
References: <20240603020607.25122-1-xingyu.wu@starfivetech.com>
 <CAJM55Z-_sOvRnaa8BuGcupsUksaK=tuTbTmF=AtzmzkCo7y5jA@mail.gmail.com>
 <NTZPR01MB09563DBA6F76281EB06914859FB92@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20240818-flip-excusably-c89021683d20@spud>
 <ZQ2PR01MB13073EF3BD7A64F2C098AA8FE6882@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <NTZPR01MB0956ABB5D9B0D087E085EF8B9F882@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gaJrXFVHKEWAo6Pd"
Content-Disposition: inline
In-Reply-To: <NTZPR01MB0956ABB5D9B0D087E085EF8B9F882@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>


--gaJrXFVHKEWAo6Pd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 08:34:55AM +0000, Xingyu Wu wrote:
> On 23.08.24 11:42, Hal Feng wrote:
> > > > >
> > > > > I'm still not a fan of hardcoding cpu frequencies in the driver.
> > > > > You've added the notifiers exactly so that we can use the standard
> > > > > device
> > > tree settings for this.
> > > > >
> > > > > In other words I much prefer v5 of this patchset.
> > > > >
> > > > > /Emil
> > > > >
> > > >
> > > > Thanks, Emil.
> > > >
> > > > Hi Conor, what do you think about this issue?
> > >
> > > Apologies for the delay replying, I didn't realise there was a
> > > question here directed at me. My only real thought on the patchset is
> > > that what is done should not cause problems when the same devicetree
> > > is used for both U-Boot and for the kernel. As long as that's
> > > satisfied, I don't mind how you choose to implement it.
> >=20
> > Actually VF2 U-Boot can run at 1.5GHz. It will work if the PMIC sets th=
e CPU
> > power supply voltage to 1.04V. The reason why we run VF2 U-Boot at 1.0G=
Hz is
> > that the default voltage supplied by the PMIC is 0.9V which only suppor=
ts JH7110
> > cores running at 1.0GHz.
> >=20
> > So v5 of this patchset won't cause problems if the VF2 U-Boot makes some
> > changes to support running at 1.5GHz. And I will make these changes whe=
n I
> > implement OF_UPSTREAM for VF2 U-Boot.
> >=20
> > BTW, if v5 is applied, the patch 2 of v5 should be rebased on the new m=
ainline
> > since jh7110-common.dtsi has been created.
> >=20
>=20
> Good news. Thanks Hal.
>=20
> Hi Conor,=20
>=20
> According to Hal, U-Boot can also run 1.5G so that the dts from kernel
> can be used on the U-Boot and could not cause any problems. So the way of
> Patch v5[1] works which Emil agreed.
> [1]: https://lore.kernel.org/all/20240507065319.274976-1-xingyu.wu@starfi=
vetech.com/
>=20
> If you agree, I will submit a new patchset soon and modify it for the new=
 jh7110-common.dtsi.

That's great, thanks for working on it guys.

Cheers,
Conor.

--gaJrXFVHKEWAo6Pd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsisCAAKCRB4tDGHoIJi
0pjsAQDeAipeLg6CA9GMChrk2MgvUa9f281/mf0Gu4TZozoPBAEA/ryiJbJMX/OO
Tw8+CwZ5FG5D+MBqZstxClLUoqYD5Qk=
=4qCZ
-----END PGP SIGNATURE-----

--gaJrXFVHKEWAo6Pd--

