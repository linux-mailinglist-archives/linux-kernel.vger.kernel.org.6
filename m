Return-Path: <linux-kernel+bounces-526284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A17A3FCAC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3A11891EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FC122A4F1;
	Fri, 21 Feb 2025 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjnfJHw4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21E522A4C4;
	Fri, 21 Feb 2025 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157038; cv=none; b=RTrGAul2mm0hASX6W5ArnYrGY4PBq6snPR+Y8mRfPqNzpmVWn9CgIV/ykXTXBHskImf4er1yTfzDIybF3LV0czqFcrwSeB2tMa2GOlX1NUC8jeDQjWmhrThHvCI/wjLx5fOP1amVTJNKpZeDzo5ov07tRBSLXtY2d/obROrBmQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157038; c=relaxed/simple;
	bh=Zermek77njNBefiJAHShs4Pi/BmVFoEIkevP8SsNO7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2WWqTeGfq2AFTSUkg/rPsAx+U9qL4OXZKZ8pwbBWjvij3ksKSDmd69+NK1AdkeEunMAFW/ewHz9juxgEMryKklem6hs/5pqjD7G4D85UnkytVu8M4XyDiDggpRafltwEcdhTqqjoqtWz9aYYMOVCMxS683zTjog96IBG12F7l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjnfJHw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB91BC4CEE2;
	Fri, 21 Feb 2025 16:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740157037;
	bh=Zermek77njNBefiJAHShs4Pi/BmVFoEIkevP8SsNO7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KjnfJHw4iEGxUc/9qW1y7MXbhibKG8rh7AogVr9UljZJegm57+LQQHRNYxKckJ7CF
	 FWayh52wKAV7sxOYBy2yRP1kIBucfaUT//Oz6Smay5wM4rX3aDy1XWtHwWW7TEQmw3
	 SptwbeiWbL/fTdM1HOAih5VwfFervTEScmXCZsx8pEdHzYHE8WrTynaqiBwG4OZ6Ke
	 vDGpq5FRy5051igtlr0CdoKc2Eih2iIJKMOuJP390ZByyLDQ2pj0Fwqyp9YV6FQXND
	 O04FwzPPaYC+BJYhF3zEGDLtqIbpBXVRvhPU3jEGlY5r9nvEPOEH4m0Pu+KdL2FdgE
	 +dM9ARU52UE5A==
Date: Fri, 21 Feb 2025 16:57:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Friday Yang <friday.yang@mediatek.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Garmin Chang <garmin.chang@mediatek.com>,
	Yong Wu <yong.wu@mediatek.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: mediatek: Add SMI LARBs reset
 for MT8188
Message-ID: <20250221-cavalier-property-7e7eceba7bc6@spud>
References: <20250221075058.14180-1-friday.yang@mediatek.com>
 <20250221075058.14180-2-friday.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+dgGrOCgl0PEyxI6"
Content-Disposition: inline
In-Reply-To: <20250221075058.14180-2-friday.yang@mediatek.com>


--+dgGrOCgl0PEyxI6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 03:50:53PM +0800, Friday Yang wrote:
> On the MediaTek platform, some SMI LARBs are directly connected to
> the SMI Common, while others are connected to the SMI Sub-Common,
> which in turn is connected to the SMI Common. The hardware block
> diagram can be described as follows.
>=20
>              SMI-Common(Smart Multimedia Interface Common)
>                  |
>          +----------------+------------------+
>          |                |                  |
>          |                |                  |
>          |                |                  |
>          |                |                  |
>          |                |                  |
>        larb0       SMI-Sub-Common0     SMI-Sub-Common1
>                    |      |     |      |             |
>                   larb1  larb2 larb3  larb7       larb9
>=20
> For previous discussion on the direction of the code modifications,
> please refer to:
> https://lore.kernel.org/all/CAFGrd9qZhObQXvm2_abqaX83xMLqxjQETB2=3D
> wXpobDWU1CnvkA@mail.gmail.com/
> https://lore.kernel.org/all/CAPDyKFpokXV2gJDgowbixTvOH_5VL3B5H8ey
> hP+KJ5Fasm2rFg@mail.gmail.com/
>=20
> On the MediaTek MT8188 SoC platform, we encountered power-off failures
> and SMI bus hang issues during camera stress tests. The issue arises
> because bus glitches are sometimes produced when MTCMOS powers on or
> off. While this is fairly normal, the software must handle these
> glitches to avoid mistaking them for transaction signals. What's
> more, this issue emerged only after the initial upstreaming of this
> binding. Without these patches, the SMI becomes unstable during camera
> stress tests.
>=20
> The software solutions can be summarized as follows:
>=20
> 1. Use CLAMP to disable the SMI sub-common port after turning off the
>    LARB CG and before turning off the LARB MTCMOS.
> 2. Use CLAMP to disable/enable the SMI sub-common port.
> 3. Implement an AXI reset for SMI LARBs.
>=20
> This patch add '#reset-cells' for the clock controller located in image,
> camera and IPE subsystems.
>=20
> Signed-off-by: Friday Yang <friday.yang@mediatek.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--+dgGrOCgl0PEyxI6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7iwaAAKCRB4tDGHoIJi
0uzgAP4v0yoFN7BfxFWWiitccUXoshHXQp4HLPtHW7d1YoN4TAD+IQ2jThGJf4Pc
L5rsRAnTiFrghIbu/VG+WOs0atI7nAI=
=soR+
-----END PGP SIGNATURE-----

--+dgGrOCgl0PEyxI6--

