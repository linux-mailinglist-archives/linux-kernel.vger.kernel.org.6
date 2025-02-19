Return-Path: <linux-kernel+bounces-522084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4356CA3C5A8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40211176852
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED23A2144A6;
	Wed, 19 Feb 2025 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqAzD7MU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E26D211707;
	Wed, 19 Feb 2025 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984847; cv=none; b=PfW7SgtsbgXBwbQObcS6sGcDpnAXoFWI0nFvQNVxOuv/gbPhGjWej1uUSVRjW+4eEL6n1qAz4Q5jCpmbSFxxmbrmb5Yw5qDdT3hWv/26axkcHTnJwx3kI+uR69jyix7oMA8ICalZK9OwfpvXerWnSIP/6CwBdpEmxC69qcn28wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984847; c=relaxed/simple;
	bh=hAryitJnIAa30axFWXeMrq2DsntcJ0u5SXN3znJATEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwboHBnfuqE5ddAhK/JYnQXgftFe00Za1OHL37PHF3jWr6Z8I3fhTPsl2hijD0b6fdPaUsV0BoJ3oxw3E6+9qyW+0pujGPnJg2LEWnySI35pixcHO0T56cj/7ajh8Dx68/zARGGcuHi+xTQ+S8BrnGeCNN2avj4ERJCEWch3YBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqAzD7MU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16B5C4CEDD;
	Wed, 19 Feb 2025 17:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739984846;
	bh=hAryitJnIAa30axFWXeMrq2DsntcJ0u5SXN3znJATEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UqAzD7MUx6yyPo+t4ef6DxLjEy3DwHPL5S7aE9JoiSSDv6BF/bawG5Xu+Hkyc/T+w
	 XsBGqGRG3fRWPF+hUxgphbEqPNtjPcY5GvEDbKocI7U1RoSWa2VdG4/g3ZMj3Taz8m
	 +3mHcE21BxcBuVjYwTOIrle1MTK1Razb0/kp2q+xYVqFpkKF4iWIxgtuVJ6OdNv4Rv
	 /bfI0oyFZAjCyJ21xxoJeVg83TX9n4RZt/Hdq2g4PZGUcgyBB4uvtpUz5a6RxNC1Qs
	 V+tzt64/xyMbNzS5bAj3haUmAykY9ZLkHLIcp8eGMH3NQ3KHgDWzPpXXpFdP1bSyF2
	 rdDTRFIQU3jFw==
Date: Wed, 19 Feb 2025 17:07:21 +0000
From: Conor Dooley <conor@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Xukai Wang <kingxukai@zohomail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Troy Mitchell <TroyMitchell988@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/3] riscv: canaan: Add support for K230-Canmv clock
Message-ID: <20250219-provided-disregard-948f2988871f@spud>
References: <20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com>
 <20250218-poplar-iron-c894fe8deca6@spud>
 <b2b9216c7c28e5eed267b9a39c8dcfb1.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DRM8MpnQrs8Rzg6i"
Content-Disposition: inline
In-Reply-To: <b2b9216c7c28e5eed267b9a39c8dcfb1.sboyd@kernel.org>


--DRM8MpnQrs8Rzg6i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 01:51:38PM -0800, Stephen Boyd wrote:
> Quoting Conor Dooley (2025-02-18 09:02:32)
> > Stephen,
> >=20
> > Is the driver in this series satisfactory to you? If it is, can I send
> > you a PR containing it and the binding so that I can apply the final
> > patch in the series (and merge the basic support for the k230 soc)?
> >=20
>=20
> Sorry, the driver is not ready.

That's cool, was just basing off the v4 changelog being minimal, no
worries.

--DRM8MpnQrs8Rzg6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7YPsgAKCRB4tDGHoIJi
0m+pAP9zRwxRDmSEDI0bpcXZF3kIzUKuyLOHvSrhwH7btn+hvwD/WSTeoZC7nplx
fom2EPgk7xMN4Tlkm8WQwu9xQCe8Fww=
=DYtV
-----END PGP SIGNATURE-----

--DRM8MpnQrs8Rzg6i--

