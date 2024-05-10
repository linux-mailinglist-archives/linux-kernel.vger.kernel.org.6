Return-Path: <linux-kernel+bounces-176192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC13C8C2B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090C71C224CF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F3E13B597;
	Fri, 10 May 2024 21:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWfoDi2u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCAC13848A;
	Fri, 10 May 2024 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375119; cv=none; b=uQeuB1W+R+p65jhwKw712dRz4g2yol8kWSGrOWtzX3uhwpWlqG5Ny6Q3aCURZR84DM8Jb30u31P/e2m96JJ+14I2kUebnCAHBufDFm/ouOyLs3PbMbxomsvVZWfs6WreJ/5iHctSubz+gJovTkP2DIdNje/ySs3cs9QKF7piK/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375119; c=relaxed/simple;
	bh=AA5sZgLLBpbhXbSQdOIXGjRAYnAtflIceR2L/vwR200=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6HuBN1RG1Y4D+VpvRb5VdtMps5x/y+z0EanL0fIkVbHOvs9ELyfck7so9cLl7UVMfvKJNJhMyXRdiLodrxd/h3oPyb0qvI0jwfMr0Cf5yCBX7zvd3zF4b4aGVS4Y5iQI5kRF48GrM1ajjK64Jxnlcjovxy0B3kIrYdN3kwhNWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWfoDi2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED90EC113CC;
	Fri, 10 May 2024 21:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715375118;
	bh=AA5sZgLLBpbhXbSQdOIXGjRAYnAtflIceR2L/vwR200=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWfoDi2uPXg023vkQwgViAKGfY1xzzMj6NRlJRbpEXW/TQBbwCDdfqCc1piRvQTOH
	 kguCo+Ojyt1KnMw95xYDPvcEEGBmX18xgfdnjLbs7vPeW2xY5crY50yrm8YK5t3RtI
	 A6RO5oPqVOIyKegimao9krXf2cxje61/bwB7NBYc1b+u/b/2tW1nH3B4LsDvUKJ0g2
	 An7CWbl3YBrqea9ONfAeDwhQ4eUSWWm83TmCC+fyGrxi3+My2zUAy8+Y+WfyaCcdkI
	 /TE879aZOB5jozx/Zjb5xpLqgkmdUSjnyIe/H3p9swlmuHyzR1Z3B+DL8GESfVFzro
	 JjertKIY8aokg==
Date: Fri, 10 May 2024 22:05:13 +0100
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
	Hal Feng <hal.feng@starfivetech.com>, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Add notifier for PLL0 clock and set it 1.5GHz on
Message-ID: <20240510-unfounded-syrup-d1263d57d05a@spud>
References: <20240507065319.274976-1-xingyu.wu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fcmvmWId/wrDz6pC"
Content-Disposition: inline
In-Reply-To: <20240507065319.274976-1-xingyu.wu@starfivetech.com>


--fcmvmWId/wrDz6pC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 02:53:17PM +0800, Xingyu Wu wrote:
> This patch is to add the notifier for PLL0 clock and set the PLL0 rate
> to 1.5GHz to fix the lower rate of CPUfreq on the JH7110 SoC.
>=20
> The first patch is to add the notifier for PLL0 clock. Setting the PLL0
> rate need the son clock (cpu_root) to switch its parent clock to OSC=20
> clock and switch it back after setting PLL0 rate. It need to use the=20
> cpu_root clock from SYSCRG and register the notifier in the SYSCRG
> driver.
>=20
> The second patch is to set cpu_core rate to 500MHz and PLL0 rate to
> 1.5GHz to fix the problem about the lower rate of CPUfreq on the=20
> visionfive board. The cpu_core clock rate is set to 500MHz first to
> ensure that the cpu frequency will not suddenly become high and the cpu=
=20
> voltage is not enough to cause a crash when the PLL0 is set to 1.5GHz.
> The cpu voltage and frequency are then adjusted together by CPUfreq.

Hmm, how does sequencing work here? If we split the patches between
trees it sounds like without the dts patch, the clock tree would (or
could) crash, or mainline if the clock changes there before the dts ones
do. Am I misunderstanding that?

--fcmvmWId/wrDz6pC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj6MCQAKCRB4tDGHoIJi
0n2KAP99FsOM8mLfQPX2XNtPhcooLIejFE//SoGuOehQcOqDMgD+PYpcuATbGArP
k5ayP3fNqZAlAgpi0kidIcGvTxc1HAA=
=5dvt
-----END PGP SIGNATURE-----

--fcmvmWId/wrDz6pC--

