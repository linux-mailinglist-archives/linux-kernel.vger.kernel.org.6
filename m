Return-Path: <linux-kernel+bounces-398727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A691C9BF53C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABE6283523
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1062208217;
	Wed,  6 Nov 2024 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6AvlHU8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007D8201104;
	Wed,  6 Nov 2024 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730917738; cv=none; b=GQwTVdmF32MUQrzDn2HcNiJlW2x36w9TopQwITS8B+EEuRO/rdEZ5g6ch6c7Cy+Vkof/z0Z5eNyA1edeMQ4xTi3lzxCoTywuch8ihQh4FD48Rlq6ftpyNlvusyCyqSrLoDBFAVmHPgVbhB6Tn8vL1s+9EhA3HThYdZLEpGy0Z38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730917738; c=relaxed/simple;
	bh=rnISvQGTFbwR9aak+S3ATcpy7QlMOi9c5mamzVrM4jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWtwsjivxl/7AVRqJlktDvM8pyxY3VePCbtJ7VrX1SBCHyL2KJCr90HG+sJlNzFUKLG0xjPiN+v19Payoo1wD3R1wD9qujf3EdRfRK373qIcU6tUxHnmws8X4X9tG8bgTfEnQSBUHu9dt07wAZ1J2LLc24dLFsdpY9UFYddZkQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6AvlHU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31605C4CEC6;
	Wed,  6 Nov 2024 18:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730917737;
	bh=rnISvQGTFbwR9aak+S3ATcpy7QlMOi9c5mamzVrM4jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6AvlHU8Jr/uvOmEKqWezuwCz3WFyXNWnlCUFv5qC1UE6+mJ9eJG81Tom3ryiMhXa
	 PDP//ewUgQSg7cQem7x+DdjGyBBZgtmEh26ML74eL8F/hInN2PSdLVNYWTb1xXNNsR
	 FwKpwU/cSYcxiw90GVHn+sC658Eeie3iu4fdOhKjnHXrzjU8DLlUkJvh2/0A1LjiNR
	 HB5CqKsE8oxQuxnI4W8nnkXcjsjO/FS7AQaCAzGT4QBgiRFERaJsp0i85upjREt/Oh
	 frox1EK+O2AP8KnGqR7S2zSFNUARu2I98ILWugMqLb4pl4X0g1d0L4kxbTl76VClHm
	 gyN/GTXYbFiTQ==
Date: Wed, 6 Nov 2024 18:28:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Matt Coster <Matt.Coster@imgtec.com>
Cc: Frank Binns <Frank.Binns@imgtec.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH 03/21] dt-bindings: gpu: img: Power domain details
Message-ID: <20241106-embassy-busload-2093b80d012a@spud>
References: <20241105-sets-bxs-4-64-patch-v1-v1-0-4ed30e865892@imgtec.com>
 <20241105-sets-bxs-4-64-patch-v1-v1-3-4ed30e865892@imgtec.com>
 <20241105-disarm-baggie-e2563299a24f@spud>
 <20241105-endearing-huddling-30728a002321@spud>
 <ff4e96e4-ebc2-4c50-9715-82ba3d7b8612@imgtec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XVGm5v5rYcHdZP+b"
Content-Disposition: inline
In-Reply-To: <ff4e96e4-ebc2-4c50-9715-82ba3d7b8612@imgtec.com>


--XVGm5v5rYcHdZP+b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2024 at 10:18:01AM +0000, Matt Coster wrote:
> On 05/11/2024 18:13, Conor Dooley wrote:
> > On Tue, Nov 05, 2024 at 06:05:54PM +0000, Conor Dooley wrote:
> >> On Tue, Nov 05, 2024 at 03:58:09PM +0000, Matt Coster wrote:
> >>> The single existing GPU (AXE-1-16M) only requires a single power doma=
in.
> >>> Subsequent patches will add support for BXS-4-64 MC1, which has two p=
ower
> >>> domains. Add infrastructure now to allow for this.
> >>>
> >>> Signed-off-by: Matt Coster <matt.coster@imgtec.com>
> >>> ---
> >>>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 29 ++++++++++++=
+++++++++-
> >>>  1 file changed, 28 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.=
yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> >>> index 6924831d3e9dd9b2b052ca8f9d7228ff25526532..55f422be1bc5b7564e3e8=
1f24c4b93857f3e12fe 100644
> >>> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> >>> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> >>> @@ -49,7 +49,16 @@ properties:
> >>>      maxItems: 1
> >>> =20
> >>>    power-domains:
> >>> -    maxItems: 1
> >>> +    minItems: 1
> >>> +    maxItems: 2
> >>> +
> >>> +  power-domain-names:
> >>> +    oneOf:
> >>> +      - items:
> >>> +          - const: a
> >>> +      - items:
> >>> +          - const: a
> >>> +          - const: b
> >=20
> > Additionally, a & b? Are those actually the names for the power domains?
>=20
> Sadly yes, Rogue has power domains that are literally just A, B, etc. I
> wouldn't believe me either; the attached image is taken directly from
> the documentation for BXS-4-64.

heh, nice... Also - if you have the oneOf stuff here for the same reason
as the locks, the same logic with min/maxItems applies here.

>=20
> >>> =20
> >>>  required:
> >>>    - compatible
> >>> @@ -57,10 +66,27 @@ required:
> >>>    - clocks
> >>>    - clock-names
> >>>    - interrupts
> >>> +  - power-domains
> >>> +  - power-domain-names
> >>
> >> A new required property is an ABI break. Please explain why this is
> >> acceptable in your commit message.
>=20
> Strictly it's only necessary for multi-domain GPUs, or perhaps in
> instances where the SoC power controller already enforces the
> dependencies between power domains. In reality, I think it was simply an
> oversight not to enfore this requirement in the first place. We have
> very, very few cores that require <2 power domains so names are always
> required if domains are enumerated in dt.
>=20
> Would you prefer we drop the requirement for "power-domains" and gate
> the requirement for "power-domain-names" behind >2 domains, or just
> explain the change properly and make the ABI break now while only one
> core is supported?

I dunno, depends really on whether or not it is possible to have power
domain "a" and domain "c" in a rogue gpu. If "a" and "b" is all it will
ever be, the order is fixed by the binding and you can do
genpd_dev_pm_attach_by_id() instead of genpd_dev_pm_attach_by_name().

--XVGm5v5rYcHdZP+b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyu1YwAKCRB4tDGHoIJi
0rU1AP9SIaKB4ki5Bfa4HQ/kdGBer+AJ//0v2m1Gst9PRFBsbQEApyGAsUh+3/nX
giX0gYSSUx43R/EwLhcy4CoJrg7evQI=
=tGw0
-----END PGP SIGNATURE-----

--XVGm5v5rYcHdZP+b--

