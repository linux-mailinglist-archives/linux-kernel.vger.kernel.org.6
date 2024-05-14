Return-Path: <linux-kernel+bounces-179041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074CB8C5AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD941C2117F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C401802D5;
	Tue, 14 May 2024 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf+h40iI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0D51E487;
	Tue, 14 May 2024 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715710083; cv=none; b=UBUEae/0E0wdjkYVCmondQ3gTMiIFE1DpiJbOsmE85lYbkvmfFzrwRy2CEFXSklKTecE1Vm2C4EErZr3C/5F6Xqj9MbR6VSpupVjotDkkBQafR4rrCMYDiJKdByntsOmVCe8+r6oOYnr1q/Gugdll0lUdgxpsZT+l2E0PIBsJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715710083; c=relaxed/simple;
	bh=cbX8GqhX/BZI3INfM/Qv8VnQNKKluIjMW+Q960sJgIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OV/EDabMtlxVSKVu4WqoIVNxlD54hcjhlZzoPu79JhQasXnh3wSbW3OWe3rzdPmmtdD2G5I0ZS+21wq6aCTacNP5JIT9apcnO5CDgpI6exFuoUjqvakqy/XfurSP7IfmZh1OhZ9FA1WacmmFVzgMDLn/fkfVDZ8P+AymC9rBQqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf+h40iI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A479C2BD10;
	Tue, 14 May 2024 18:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715710083;
	bh=cbX8GqhX/BZI3INfM/Qv8VnQNKKluIjMW+Q960sJgIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bf+h40iITMx+HMtakGjF+9/YfDsjyy3kaM12Pw5oEzoF/GFsHCcnobcK+YEvcmzRu
	 4BAXjZo4SPdALOQA0C9akfuAMtTGrCANEisUMKSQooeQUyZ10O762N/Met+qyYaoPC
	 ZNs1KMvP0iFny8JsH33SrFy7w8lKQVkK0/NJz0xcrVTp2r6hE1323/Ag7GymrxHC0v
	 kKStIuEm386j/r5cVmvaV4pTAxkJydn5sfIctAyIwn1t9NycTBHWSaRimfq9MQF1ib
	 hwGg1IwC8GgcQ68RQiqC58txx+xQaPiRKE1VJU1fGyG6kDsx/lD2FJCs2wxc7THcvg
	 mv4uWYbZjWhEQ==
Date: Tue, 14 May 2024 19:07:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] Add notifier for PLL0 clock and set it 1.5GHz on
Message-ID: <20240514-congenial-smother-1e4b0fc6a5df@spud>
References: <20240507065319.274976-1-xingyu.wu@starfivetech.com>
 <20240510-unfounded-syrup-d1263d57d05a@spud>
 <NTZPR01MB0956D48361098E8AA4B3930A9FE02@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20240511-unbiased-dainty-ccb5ece9b1b9@spud>
 <NTZPR01MB0956A7393097129D3CD048EB9FE32@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ICN+M2oef3F7o4Ka"
Content-Disposition: inline
In-Reply-To: <NTZPR01MB0956A7393097129D3CD048EB9FE32@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>


--ICN+M2oef3F7o4Ka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 07:40:02AM +0000, Xingyu Wu wrote:
> On 11/05/2024 20:19, Conor Dooley wrote:
> >=20
> > On Sat, May 11, 2024 at 03:02:56AM +0000, Xingyu Wu wrote:
> > > On 11/05/2024 05:05, Conor Dooley wrote:
> > > >
> > > > On Tue, May 07, 2024 at 02:53:17PM +0800, Xingyu Wu wrote:
> > > > > This patch is to add the notifier for PLL0 clock and set the PLL0
> > > > > rate to 1.5GHz to fix the lower rate of CPUfreq on the JH7110 SoC.
> > > > >
> > > > > The first patch is to add the notifier for PLL0 clock. Setting the
> > > > > PLL0 rate need the son clock (cpu_root) to switch its parent clock
> > > > > to OSC clock and switch it back after setting PLL0 rate. It need
> > > > > to use the cpu_root clock from SYSCRG and register the notifier in
> > > > > the SYSCRG driver.
> > > > >
> > > > > The second patch is to set cpu_core rate to 500MHz and PLL0 rate
> > > > > to 1.5GHz to fix the problem about the lower rate of CPUfreq on
> > > > > the visionfive board. The cpu_core clock rate is set to 500MHz
> > > > > first to ensure that the cpu frequency will not suddenly become
> > > > > high and the cpu voltage is not enough to cause a crash when the =
PLL0 is set
> > to 1.5GHz.
> > > > > The cpu voltage and frequency are then adjusted together by CPUfr=
eq.
> > > >
> > > > Hmm, how does sequencing work here? If we split the patches between
> > > > trees it sounds like without the dts patch, the clock tree would (or
> > > > could) crash, or mainline if the clock changes there before the dts
> > > > ones do. Am I misunderstanding that?
> > >
> > > Oh, I think you misunderstood it. Patch 1 (clock driver patch) does
> > > not cause the clock tree crash without the patch 2 (dts patch), and it
> > > just provides the correct flow of how to change the PLL0 rate. The
> > > patch 2 is to set the clock rate of cpu_core and PLL0 rate, which
> > > causes the crash without patch 1. Setting cpu_core rate is to avoid c=
rashes by
> > insufficient cpu voltage when setting PLL0 rate.
> >=20
> > So is the problem in the other direction then? My dts tree will crash i=
f I apply the
> > dts change without the clock patch?
>=20
> Sorry, I tested it and it could not crash using only dts patch. It can se=
parate the
> patches and use it individually.
>=20
> > Additionally, what about U-Boot? Will it have problems if the dts is im=
ported
> > there without changes to its clock driver?
> >=20
>=20
> It is not apply to U-Boot. In the U-Boot, the PLL0 rate should be 1GHz to=
 for GMAC
> and PMIC to work. But now the PLL0 rate should be 1.5GHz in the Linux.

There's a push in U-Boot to move devicestrees to use "OF_UPSTREAM",
which means importing devicetrees directly from Linux and using them in
U-Boot. I don't really want to merge a patch that would present U-Boot
with a problem if the VisionFive 2 moved to that model there.

Cheers,
Conor.

--ICN+M2oef3F7o4Ka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkOofgAKCRB4tDGHoIJi
0ufXAP9Uh+ZzbT/spgRCgoklThu+gutedLdqt2wyY4s4A/w6HgD/UbHkgmXSa+SY
yCs4XmyR6wDsGVSfXZlZ8fhpLfp/FAI=
=qwt+
-----END PGP SIGNATURE-----

--ICN+M2oef3F7o4Ka--

