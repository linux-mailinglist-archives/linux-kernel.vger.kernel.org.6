Return-Path: <linux-kernel+bounces-398624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D2A9BF3C8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB621F2220D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DB7205E38;
	Wed,  6 Nov 2024 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3yxVTiB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFBC201115;
	Wed,  6 Nov 2024 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912268; cv=none; b=ik+ZhHWzkQyIKmucqXOhC4saX3k/so6mE1+a7Njxrt6e7x2hLTpzO0Vjsb2gg6q07OOhSpi8uG59l5J/sxyCgRdOvYhsqjLrW9AphW1zHnv4W9cn+k6N1yJX18QIepC2+ytGWNIs0z/kSx/iAUWsG1cAN8vjY7/jjs/+uHK13o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912268; c=relaxed/simple;
	bh=kFDRCa0XKMHFYOR3uG48ep5LCFtGy7INevzQqLdyhe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRpJoTtRYhMiM7lp4RiwkaMYKoHumvyEX6O4HbSDaqrqN4OjwhNmI2Zwcekmqyf05h8JrtHhN8/aEFTlTLaw1kSU7Pmi8D7R0wf1QL2cEauj1ZC7NlfNvITJf5PEfdWXs3WwJ0Pwl+PXTNOH+tLz3n8DzZ7PCKkD09zGTA5AaGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3yxVTiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9119CC4CEC6;
	Wed,  6 Nov 2024 16:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730912267;
	bh=kFDRCa0XKMHFYOR3uG48ep5LCFtGy7INevzQqLdyhe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3yxVTiBm47hSjot2DdT1qMfPqitnfZ1ftMpEVbNszJEhXknaWzfPwufHIOB9g9hK
	 m7hMugw2ooCnuVEOFYWW3nMazspNkD/Q2GhHm+uDCZTPb0wQd7L7R3G1q6S3z8mdye
	 8UJvWwrSxOqCq1P3bSBFad2iRMkbwXzjG/ySfkt8wMpm99V3euPdc4YDNncU3sB8gM
	 pNRerVg25YNkCWuBJ25s99UHUBADlbgvA0nJFF1yGP+WfYECnFNiWxcqanNqk5J5Kv
	 t4+2g/l2/U4pgnlbF1L8mmkY6hi8+J73TSwopd+NvcaT2yC8ccxHT14CfNS5heyo6P
	 UWQEjZHCE5b2A==
Date: Wed, 6 Nov 2024 16:57:41 +0000
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
Subject: Re: [PATCH 01/21] dt-bindings: gpu: img: More explicit compatible
 strings
Message-ID: <20241106-flagstone-mandarin-8caf9da78f19@spud>
References: <20241105-sets-bxs-4-64-patch-v1-v1-0-4ed30e865892@imgtec.com>
 <20241105-sets-bxs-4-64-patch-v1-v1-1-4ed30e865892@imgtec.com>
 <20241105-matron-gangway-64e78576ec47@spud>
 <d70a01d3-24d5-4e31-92ab-7f6626452852@imgtec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tUKQCQPIgKD2Ml6c"
Content-Disposition: inline
In-Reply-To: <d70a01d3-24d5-4e31-92ab-7f6626452852@imgtec.com>


--tUKQCQPIgKD2Ml6c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2024 at 10:17:47AM +0000, Matt Coster wrote:
> On 05/11/2024 18:13, Conor Dooley wrote:
> > On Tue, Nov 05, 2024 at 03:58:07PM +0000, Matt Coster wrote:
> >> The current compatible strings are not specific enough to constrain the
> >> hardware in devicetree. For example, the current "img,img-axe" string
> >> refers to the entire family of Series AXE GPUs. The more specific
> >> "img,img-axe-1-16m" string refers to the AXE-1-16M GPU which, unlike t=
he
> >> rest of its family, only uses a single power domain.
> >=20
> > That's not true, you could apply the rules using the ti,am62-gpu
> > compatible, no?
>=20
> The intent here is to draw a line between properties inherent to the IP
> core and choices made by the silicon vendor at integration time. The
> number of power domains is a property of the IP core, whereas the
> decision to use one or three clocks (next patch) is a vendor choice.

That's a different argument than the one in your commit message, but I
will accept it.

> >> Work is currently underway to add support for volcanic-based Imaginati=
on
> >> GPUs; also add a generic top-level "img,img-rogue" compatible string to
> >> allow for simpler differentiation in devicetrees.
> >=20
> > This makes no sense, how does adding another fallback compatible make
> > it simpler? I have to assume that this means there will be geothermally
> > powered axes in the future and you want to tell the difference between
> > them and those pesky rogue axes that chop the heads off of naughty
> > children?
>=20
> The intent is to add Volcanic bindings in img,powervr-volcanic.yaml, but
> the split between Rogue and Volcanic is... a bit weird. The BXS-4-64
> we're adding support for here is Rogue but, for example, the BXS-32-1024
> is Volcanic. I figured it would be nice to be able to grok from the
> devicetree which architecture a core is using without having to refer
> back to the bindings.

So not geothermally powered axes, but it was the rationale.

> The primary differentiator from a dt perspective is power topology. In
> Rogue, there are few (poorly named) power domains. Volcanic has (a)
> better domain names and (b) typically more granularity in domains,
> leading to actual dependency trees we need to care about besides the
> trivial A->B->... in Rogue.

Please add that detail to the commit message. Not all of it, but the
bits in the first paragraph.

Cheers,
Conor.

--tUKQCQPIgKD2Ml6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyugBQAKCRB4tDGHoIJi
0o5WAP9qdPoidxf7Wb9XEMajnxOl7aWPCFarHIxFdXJMcNDRsAD/SjbnAVWJB8zS
+/+GsnqRLs/GRLCfNIKRr1NjFUN4uw4=
=QMO4
-----END PGP SIGNATURE-----

--tUKQCQPIgKD2Ml6c--

