Return-Path: <linux-kernel+bounces-291064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E39955CCC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 15:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DAED1C20A59
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 13:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BD561FFE;
	Sun, 18 Aug 2024 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMYu/4hc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01147947A;
	Sun, 18 Aug 2024 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723988664; cv=none; b=uIPAn6bblgKDbVDMx6FAmeO7mVkH6eLbJww/qlHC9YeBwz+dK3To+D5HKbAMBhbs/cLdU5lJY0aDj3Mg1GpedyUCtRy2mCgZxIp2brwvD9/NNnu460CuLFucXMHfbaIQLFEg6C8cGa4d5Mmc1NyCtAOeFScTsqBbZECFfsqcMpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723988664; c=relaxed/simple;
	bh=/5/W03eo1g8tWi0dolJMkucBe4vEpLEA2eeIEG7MMA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcAjGs7h7XpEwNLacd4BZ5qyj5swsmFCbJ1VOSbBqySFCbIMVbYMoQKYkEg/VsKm7Q+2j7VfIWu0LuDkwUEA/7PRs5LujW6oTKHHzFOHGSOBtKbSsrOY2eYG7a5AVWjXpWLbHPuqaCKOddbeXMtNH6MIDZyfCR2rSNla4+R/cRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMYu/4hc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFECC32786;
	Sun, 18 Aug 2024 13:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723988663;
	bh=/5/W03eo1g8tWi0dolJMkucBe4vEpLEA2eeIEG7MMA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jMYu/4hcouPIAY/LMexriy0jkFmkwXtusNvVDCpc6howzGm78699OjDbbpzyzyQwl
	 bZYGWvaOeO7+V635i2qEd2kylJ27PiKuDPbrtwEj951vpCjmuascN801P9KKLJlSny
	 SWG6/x+QC2XXzpvFAsz1CucHQuDjZxnPwqhDevVVwzrQlXP0wirmCBegjxrG9R1R/J
	 6ONhr8/dFd2tVfKgdon3yjxSH0zCAhhH6TbvKSabxNTQkQhtfATBqCUQRQCX+NWdxu
	 g/AU1gIN3oFXeMZ6u8lRZL3/8OsUBOsJL1NhgLXWVrtU3bHMR+MPyDBW8vwIskb3pb
	 asr4XyXOpxYDg==
Date: Sun, 18 Aug 2024 14:44:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v6] clk: starfive: jh7110-sys: Fix lower rate of CPUfreq
 by setting PLL0 rate to 1.5GHz
Message-ID: <20240818-flip-excusably-c89021683d20@spud>
References: <20240603020607.25122-1-xingyu.wu@starfivetech.com>
 <CAJM55Z-_sOvRnaa8BuGcupsUksaK=tuTbTmF=AtzmzkCo7y5jA@mail.gmail.com>
 <NTZPR01MB09563DBA6F76281EB06914859FB92@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/bpG2YUXXyZEgE2i"
Content-Disposition: inline
In-Reply-To: <NTZPR01MB09563DBA6F76281EB06914859FB92@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>


--/bpG2YUXXyZEgE2i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 03:44:49AM +0000, Xingyu Wu wrote:
> On 06/08/2024 17:58, Emil Renner Berthing wrote:
> >=20
> > Xingyu Wu wrote:
> > > CPUfreq supports 4 cpu frequency loads on 375/500/750/1500MHz. But now
> > > PLL0 rate is 1GHz and the cpu frequency loads become
> > > 250/333/500/1000MHz in fact. The PLL0 rate should be default set to
> > > 1.5GHz and set the divider of cpu_core clock to 2 in safe.
> > >
> > > To keeo the cpu frequency stable when setting PLL0, the parent clock
> > > of the cpu_root clock needs to be switched from PLL0 to another parent
> > > clock and add notifier function to do this for PLL0 clock. In the
> > > function, the cpu_root clock should be operated by saving its current
> > > parent and setting a new safe parent (osc clock) before setting the
> > > PLL0 clock rate. After setting PLL0 rate, it should be switched back
> > > to the original parent clock.
> > >
> > > To keep the DTS same in Linux and U-Boot and the PLL0 rate is 1GHz in
> > > U-Boot, the PLL0 rate should be set to 1.5GHz in the driver instead of
> > > DTS.
> > >
> > > Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110
> > > SoC")
> > > Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> > > ---
> > >
> > > Hi Stephen and Emil,
> > >
> > > This patch is to fix the lower rate of CPUfreq by adding the notifier
> > > for PLL0 clock and changing the PLL0 rate to 1.5GHz.
> > >
> > > To keep the DTS same in Linux and U-Boot as Conor wants[1] and the
> > > PLL0 rate is 1GHz in U-Boot, the PLL0 rate should be set to 1.5GHz in
> > > the driver instead of DTS.
> > >
> > > [1]:
> > > https://lore.kernel.org/all/20240515-reorder-even-8b9eebd91b45@spud/
> > >
> > > Thanks,
> > > Xingyu Wu
> > >
> > > ---
> > >  .../clk/starfive/clk-starfive-jh7110-sys.c    | 54 +++++++++++++++++=
+-
> > >  drivers/clk/starfive/clk-starfive-jh71x0.h    |  2 +
> > >  2 files changed, 54 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> > > b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> > > index 8f5e5abfa178..7469981fb405 100644
> > > --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> > > +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> > > @@ -385,6 +385,32 @@ int jh7110_reset_controller_register(struct
> > > jh71x0_clk_priv *priv,  }
> > > EXPORT_SYMBOL_GPL(jh7110_reset_controller_register);
> > >
> > > +/*
> > > + * This clock notifier is called when the rate of PLL0 clock is to b=
e changed.
> > > + * The cpu_root clock should save the curent parent clock and swicth
> > > +its parent
> > > + * clock to osc before PLL0 rate will be changed. Then swicth its
> > > +parent clock
> > > + * back after the PLL0 rate is completed.
> > > + */
> > > +static int jh7110_pll0_clk_notifier_cb(struct notifier_block *nb,
> > > +				       unsigned long action, void *data) {
> > > +	struct jh71x0_clk_priv *priv =3D container_of(nb, struct jh71x0_clk=
_priv,
> > pll_clk_nb);
> > > +	struct clk *cpu_root =3D priv->reg[JH7110_SYSCLK_CPU_ROOT].hw.clk;
> > > +	int ret =3D 0;
> > > +
> > > +	if (action =3D=3D PRE_RATE_CHANGE) {
> > > +		struct clk *osc =3D clk_get(priv->dev, "osc");
> > > +
> > > +		priv->original_clk =3D clk_get_parent(cpu_root);
> > > +		ret =3D clk_set_parent(cpu_root, osc);
> > > +		clk_put(osc);
> > > +	} else if (action =3D=3D POST_RATE_CHANGE) {
> > > +		ret =3D clk_set_parent(cpu_root, priv->original_clk);
> > > +	}
> > > +
> > > +	return notifier_from_errno(ret);
> > > +}
> > > +
> > >  static int __init jh7110_syscrg_probe(struct platform_device *pdev)
> > > {
> > >  	struct jh71x0_clk_priv *priv;
> > > @@ -413,7 +439,11 @@ static int __init jh7110_syscrg_probe(struct
> > platform_device *pdev)
> > >  		if (IS_ERR(priv->pll[0]))
> > >  			return PTR_ERR(priv->pll[0]);
> > >  	} else {
> > > -		clk_put(pllclk);
> > > +		priv->pll_clk_nb.notifier_call =3D jh7110_pll0_clk_notifier_cb;
> > > +		ret =3D clk_notifier_register(pllclk, &priv->pll_clk_nb);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > >  		priv->pll[0] =3D NULL;
> > >  	}
> > >
> > > @@ -501,7 +531,27 @@ static int __init jh7110_syscrg_probe(struct
> > platform_device *pdev)
> > >  	if (ret)
> > >  		return ret;
> > >
> > > -	return jh7110_reset_controller_register(priv, "rst-sys", 0);
> > > +	ret =3D jh7110_reset_controller_register(priv, "rst-sys", 0);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Set the divider cpu_core to 2 and set the PLL0 rate to 1.5G. */
> > > +	pllclk =3D clk_get(priv->dev, "pll0_out");
> > > +	if (!IS_ERR(pllclk)) {
> > > +		struct clk *cpu_core =3D priv-
> > >reg[JH7110_SYSCLK_CPU_CORE].hw.clk;
> > > +
> > > +		ret =3D clk_set_rate(cpu_core, clk_get_rate(cpu_core) / 2);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		ret =3D clk_set_rate(pllclk, 1500000000);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		clk_put(pllclk);
> > > +	}
> > > +
> > > +	return 0;
> >=20
> > I'm still not a fan of hardcoding cpu frequencies in the driver. You've=
 added the
> > notifiers exactly so that we can use the standard device tree settings =
for this.
> >=20
> > In other words I much prefer v5 of this patchset.
> >=20
> > /Emil
> >=20
>=20
> Thanks, Emil.
>=20
> Hi Conor, what do you think about this issue?

Apologies for the delay replying, I didn't realise there was a question
here directed at me. My only real thought on the patchset is that what
is done should not cause problems when the same devicetree is used for
both U-Boot and for the kernel. As long as that's satisfied, I don't
mind how you choose to implement it.

Thanks,
Conor.

--/bpG2YUXXyZEgE2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsH6sAAKCRB4tDGHoIJi
0npvAQC4WDtyVbKcEfhBfUHLStOHYmzIkbPMB5JUnMrBqE33lwD8C6p4mP6XXQ6h
zT/6hO/+V90M10dzetOibhlI0W8NaQ8=
=a3KW
-----END PGP SIGNATURE-----

--/bpG2YUXXyZEgE2i--

