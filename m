Return-Path: <linux-kernel+bounces-211824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9202F905778
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948F51C21D40
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5FF180A83;
	Wed, 12 Jun 2024 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTy8Jw/j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE381182AF;
	Wed, 12 Jun 2024 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207637; cv=none; b=GHONXi35E385xMMDTZFEZr1fwKiDd1UDpkDmsKSE/ZiSPE0KWuFgG24zN9PSiCphXYYuagomXRxsmrqx/sOGGECmEUhw7ReZ1ZXGCd4weIN+PgClZpf2o5Athigh1f0Pk8RDmU2q401V6tw1utFTDKZc36dncgSfvxdGntFTSCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207637; c=relaxed/simple;
	bh=A/q6m45sA8KG3xWSmANGingFfUIcNjjpTnH7bMJgRmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMJCmrPc6i2kZ3Iu8Mn+huZkRpCzDjeVP5AA2zIcoF70l7MMHl7/XzRdC0ceYwyh42ibm62OzPq1RdipdE115nwwZcN0/AusFvnIwWPx3JGFud9cJSrTXDRjj55uvVMHCAlj2XTqQoVpEQ0BkoBw64ZMV/bTl8z9h9yVuTBm0Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTy8Jw/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E8CC116B1;
	Wed, 12 Jun 2024 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207637;
	bh=A/q6m45sA8KG3xWSmANGingFfUIcNjjpTnH7bMJgRmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mTy8Jw/jTcDpAnDYssZPlt8vz3bcbolI+P475PfDuR+fHaR5a09wgg6QBVQmg+owo
	 PFKNFpynkSRKrTtBXBPy0ysbUUlHxeVjIjUdtXs96LdZ1ufRoZNg9rgwCa5eJvUXvB
	 rCgM8wwfi+tDUSoLG4g6iuFsIYolucywbFU0XQtmCtG7Y9FvraSaYABDJTo0mMeKWw
	 m9+vnDFnA0M5HoTXzHh49/T8BwrUh8ZGmJTUA4odCXPkzzhHrFgKwlHX+CGKglQIAV
	 BhAfgE5r6q2Je+Tb9DPxuDgUdayvTqG0MbCQoqOnv0PXv3JsExXn/4BjdcAMmn8aTl
	 yIYArnfRGivpg==
Date: Wed, 12 Jun 2024 16:53:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
	Rob Herring <robh+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1] riscv: dts: starfive: add PCIe dts configuration for
 JH7110
Message-ID: <20240612-circling-hungry-29a993ca5fc5@spud>
References: <20240611015200.40996-1-minda.chen@starfivetech.com>
 <98031697-93AE-43AC-B192-44B12CB43EC5@jrtc27.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o24WclyZlx9mMuRS"
Content-Disposition: inline
In-Reply-To: <98031697-93AE-43AC-B192-44B12CB43EC5@jrtc27.com>


--o24WclyZlx9mMuRS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 04:24:44PM +0100, Jessica Clarke wrote:
> On 11 Jun 2024, at 02:52, Minda Chen <minda.chen@starfivetech.com> wrote:
> >=20
> > Add PCIe dts configuraion for JH7110 SoC platform.
> >=20
> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> > .../boot/dts/starfive/jh7110-common.dtsi      | 64 ++++++++++++++
> > arch/riscv/boot/dts/starfive/jh7110.dtsi      | 86 +++++++++++++++++++
> > 2 files changed, 150 insertions(+)
>=20
> Is there a corresponding YAML schema?

Yeah, it's in linux-next via the PCI tree:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Do=
cumentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml

--o24WclyZlx9mMuRS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmnEkAAKCRB4tDGHoIJi
0tEhAQDKDsuAnifw9l4RMxkk9gttAErd01F5deCxrozjvbw68gD/f4YR4jwR+HWo
guuAKaN4L1wy1l8OHja7SG8tgk4Wsgo=
=DpyI
-----END PGP SIGNATURE-----

--o24WclyZlx9mMuRS--

