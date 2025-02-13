Return-Path: <linux-kernel+bounces-513819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4678A34EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C983ADA3B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7426E24A079;
	Thu, 13 Feb 2025 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/JH8jfV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BE828A2CB;
	Thu, 13 Feb 2025 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477159; cv=none; b=EvPMgFqxpfcu924/14AWhehCNF7lMU92WmP+HAj/b24INeMUT9foD8v2lhOEiI6vpY0cPc7r3ngVt28urmdyiiNLXEW7/BzviAZDHYnFSlO5mdcCyAlwLxO3nylOit6cRmhK1Ikh2Eams1evc7aQ3j1EvowzqgcCBlUMvqNnz3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477159; c=relaxed/simple;
	bh=NACchtxeonADU5GQJHVdhJAYs1NUCFnsjx8N1JQdRrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYEiKiPTrvgB4Ru8yFRO3PFS10M1GCrSnHzEyOsIFyE7t4lWfbhSHBtQnrnadTehJZ+ELNEzku1ua1gY6mnORFDauTdi+zsd9JXPecl5u4BRT1/y87TgfHQ1Wk9iohJXiNtqjgqmDvYX4RjO2BM3rX8Al5/tn1hVYSKkWrlrpe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/JH8jfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8B6C4CED1;
	Thu, 13 Feb 2025 20:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739477159;
	bh=NACchtxeonADU5GQJHVdhJAYs1NUCFnsjx8N1JQdRrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O/JH8jfV1QVq1uasHTsNeuvpUp+d/jj3Sxg0GxQKCVk7MJyvAD+eV7i506He6qDkk
	 CgczH1mXZqmixuHsk0D/2KtFkSCe/Wmi8P9wl7zCIUczWtl3sD9Vq+H2A5cpdDdnQF
	 qNGJnP9y/5CtGu9vhXYx1B8p7h+0KKFG7NvnxjfzY6NPNfHSqEgpjg6KZXdcGWsLa9
	 aw79CG0LR2+U1fZ2shFOmgWKUurnvnCGkvfOKwv3xXZMFivGXD6G8/TJk9OItg0FuJ
	 zk2HZ3DJcceF9gUMbY0NZul7L33XU3Emvw5VLBcspBPrQFTtCjH/OY7sZFLz2zeqsk
	 MyoYXycWED0Ew==
Date: Thu, 13 Feb 2025 20:05:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, imx@lists.linux.dev,
	loongarch@lists.linux.dev
Subject: Re: (subset) [PATCH v1 0/4] Removal of non-existent DAC nodes
Message-ID: <20250213-calamity-smuggler-5d606993be32@spud>
References: <20240717-anvil-ashy-544e80a1317c@spud>
 <173939339997.59416.11108011581545463665.b4-ty@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t2TI/qcM7Hcs5rgZ"
Content-Disposition: inline
In-Reply-To: <173939339997.59416.11108011581545463665.b4-ty@linaro.org>


--t2TI/qcM7Hcs5rgZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 09:49:59PM +0100, Krzysztof Kozlowski wrote:
>=20
> On Wed, 17 Jul 2024 10:37:52 +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Recently I've been getting triggered by abuse of the Rohm dh2228fv
> > compatible to get the spidev driver probing in Linux on development
> > kits by employees of various silicon vendors (like NXP or my own
> > employer). I had a look around the kernel and all users other than the
> > original Clearfontz board added by Maxime appear to be similar abuse.
> > Drop the non-existent nodes from all of these devices :)
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [3/4] loongarch: dts: remove non-existent DAC from 2k1000-ref
>       https://git.kernel.org/krzk/linux-dt/c/854a080f0b73ff966a813ec2dc53=
891831daa28d

Heh, funny that you picked this up yesterday - I noticed that it was
there while poking at spidev doing some debugging yesterday and was
going to grab the patch myself. Thanks.
Noticed also that there's a user of it in riscv that I hadn't included
in my original patch. No clue why I didn't include that, but I've sent
out a patch for it now.

--t2TI/qcM7Hcs5rgZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ65QoQAKCRB4tDGHoIJi
0hJOAP9qWBg0rjsbzm7opAMArAFEycQu0lJBHYdR+tfeeXkkhAEArfJdGry0AYEf
b8lHjUhG8iocKhPAo6JWSZBlm8Sn4w8=
=cxBE
-----END PGP SIGNATURE-----

--t2TI/qcM7Hcs5rgZ--

