Return-Path: <linux-kernel+bounces-218459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07FD90C024
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834641C20C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD7A17E9;
	Tue, 18 Jun 2024 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cd3Jq+Ao"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C6A3D;
	Tue, 18 Jun 2024 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669408; cv=none; b=lLWvs8aJqDKCFouzEiC6EDryCw5UahLJXVcaSKv3dqAOu2Gy8k0gkhJm9zEISD3EYujFHFEPiHx/Vi6d0+a9PlSrrxG24qrEVGJom+q68j7AlFPZALCY4rP0dmC2dLPtDbpGAHxbH7ufNEyGmCMlhupcNmW3vmrCBGviMRwpj2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669408; c=relaxed/simple;
	bh=JV+ze2DhYby8M3srxTuMb/mFtvtSNrjhrOipVD4W4m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQk89EW+F9AP321k4enzHlO6ZvvIGiv4SlxRxSzy3C6u2BPtDs9t9AmmPcIylBDrZbjZzhmv7RWJ0eIHc4ypMg6rJhDzgQ3x7eqMo3avy9+OuCa9g89dOuxZtEouUWPKKQh3GizauEUsS6oyFuz1gjJV5VWMyL+y1HfyhcyA+h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cd3Jq+Ao; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718669404;
	bh=JV+ze2DhYby8M3srxTuMb/mFtvtSNrjhrOipVD4W4m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cd3Jq+AoMBgSWRqEb2AmeQXtUgz5YyUy/7qn7j/VJ+G7dhFvy3VPd9kJsBwqxgcHv
	 RqmrloEor8MoTbkome2eEaOq9bLSctOjyrZmzfjBNDV1KclgYyO6sMzgYX3OontAHm
	 4h4ZE55u9xO3nXcqdU1GEXWfmd6gCb3rWFmqQGJ8nvX3LDuO5FU52wGHdu/vhJRSGR
	 7RkPhS0wN8e3bN6YebosXYQDsO8ecJdoRoJNa9d4P0S7HcHshuk79ZxNEYmeM5S2r1
	 5z0CiFDsuUhZQJ9ws1HiAzATTdzDkYxfIA+jSnRqcmjqWo/T4jcZmvJEWTCepqX9iq
	 +37t6MNWbsbeg==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9462C378042B;
	Tue, 18 Jun 2024 00:10:04 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 23BA71060734; Tue, 18 Jun 2024 02:10:04 +0200 (CEST)
Date: Tue, 18 Jun 2024 02:10:04 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Alexey Charkov <alchark@gmail.com>
Cc: Jacobe Zang <jacobe.zang@wesion.com>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>, Nick Xie <nick@khadas.com>, 
	"efectn@protonmail.com" <efectn@protonmail.com>, "jagan@edgeble.ai" <jagan@edgeble.ai>, 
	"dsimic@manjaro.org" <dsimic@manjaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] arm64: dts: rockchip: Add AP6275P wireless
 support to Khadas Edge 2
Message-ID: <o5iyg5ha7k3goy65damt3apnyeyfxedbm7mzmu4v2zur32jsyj@x3ge4n52lkfs>
References: <20240617071112.3133101-1-jacobe.zang@wesion.com>
 <20240617071112.3133101-5-jacobe.zang@wesion.com>
 <feeb8dcd-661f-415e-be08-afe175d0102e@gmail.com>
 <TYZPR03MB70012C66B789B09195FCD92580CD2@TYZPR03MB7001.apcprd03.prod.outlook.com>
 <CABjd4YyHUzm4EBPPzia5VRXGvJiXDObDHQYNCjpCMJDs=BqALg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uhnckguykm42725v"
Content-Disposition: inline
In-Reply-To: <CABjd4YyHUzm4EBPPzia5VRXGvJiXDObDHQYNCjpCMJDs=BqALg@mail.gmail.com>


--uhnckguykm42725v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 17, 2024 at 03:17:50PM GMT, Alexey Charkov wrote:
> On Mon, Jun 17, 2024 at 2:58=E2=80=AFPM Jacobe Zang <jacobe.zang@wesion.c=
om> wrote:
> >
> > >I'm also wondering why would adding a DT node for a PCI device be need=
ed
> > >in the first place, given that PCI supports device discovery?
> >
> > In fact, I learn that PCIe bus devices do not need compatible to probe =
just now... Before sending this patch, I committed the code that added "pci=
14e4,449d" to vendor-prefix.yaml and net/wireless/brcm,brcm4329-fmac.yaml. =
Now I know the reason why my addition was rejected. By the way, except for =
the compatible binding, is there any other binding that I should remove??
>=20
> If your PCI bridge is functioning properly and if your WiFi adapter is
> connected and physically enabled (in terms of power and RFKILL) I
> believe it should be automatically discovered and you should see it in
> lspci. No additional DT nodes needed - but check if you need any
> additional DT property somewhere to keep the HYM8563 clock enabled.
> I'm not sure your pcie@0,0 node is needed either.
>=20
> Then it's up to the driver to recognize your adapter by its PCI ID and
> attach. I guess you'd need to extend the hardware IDs table in the
> brcmfmac driver for it to attach - similar to [1]
>=20
> [1] https://github.com/armbian/build/blob/main/patch/kernel/archive/rockc=
hip-rk3588-6.10/0801-wireless-add-bcm43752.patch

RK3588 EVB1 has the same WLAN/BT module and I started looking
into adding support at a low priority. I think this is very
similar to the Qualcomm chip Bartosz Golaszewski worked on and
thus should get a pwrseq driver, which handles the enable GPIOs,
regulators and clocks. If any of them are missing the PCIe device
is not discovered. Note, that this will actually require describing
the PCIe device in DT to reference the pwrseq device.

Additionally the brcmfmac need to be extended to actually have
working wlan.

I put some links and notes about this here:

https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/issu=
es/1

Greetings,

-- Sebastian

--uhnckguykm42725v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZw0FUACgkQ2O7X88g7
+prrpw//UYYL9Rg1H9dHWyJgdcc/4LeH3dB3tQX3tEs0eUL5NthX28Uunb+LpqC/
9CsIQqGCYjptZP1dzJ4HUeFIPYOnGw63Y7WZaeWqqd/Wob1PsADOPlNFtXQ5th5U
9Z87Uji/Wfm7h0oG/+1YVGK4TKuUqkkzSoSuvmb0VqtZjVdV4MS90nwtHGxD/jhI
UTSwuAXa+E7nJg/p0USVW5vIegrJQyFOaTTXpmagiOiOFm2TR59LWURsw3n8+Xmb
wYR88jc64on4zLqqtVkiqY624Q2f3lLHVAgswx7juZG+obFUputTZshah0bHTRE5
jiiG8KcAHCNflRZGtS6pDHZmJ+/shcPvE8aoYbiMfMO1+5HDLhjKkM61HeLH1XJc
JR1u0bH9azquf8LurJd4qEpVcg40drVq7FDvHbSyM5BTvhCIBNGRVNKxIb5klGEb
WMbEtJKfS/XDtm6zSR4pxcFcvHH9ukRGxogYgKuHuS33QMQ7f0Wa80aIskcPZovT
m8Nbn4EcleD6c0PVXXyX2s0vy094TohtoDBwHyMI9GWLqdU2LiNsc0bpjkaxdChN
8mu9ajXgt3+fSpCvvQ8HJ5EAEyba59rhsdE7/cUJXQT8B4rD7KzoU94Rc1YJ6v+j
0/Y+vb5mk/TkL+zaXT5wvopW0gPhXEpxfdhPMM8PiMqu3Y+gz1k=
=6zaE
-----END PGP SIGNATURE-----

--uhnckguykm42725v--

