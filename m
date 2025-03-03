Return-Path: <linux-kernel+bounces-541866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB517A4C2AB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAC1169670
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC063212B2B;
	Mon,  3 Mar 2025 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDE7Vziq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443818489;
	Mon,  3 Mar 2025 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010423; cv=none; b=TLl5Nx3N/EGjJzLzX8AgfxnYh/Z9hNoRhHBdZK2TMf1cBBVwV33jsSeLlJyiP8SYEqQYc03i3Z4MhCk+NyD+d7QnrKUorfu84+aeOK68IPdsPgFawkMHItUmg90fTSi40gmPw00GZcsxTAZN+2pm+dMU8SbKACaGJrE6J+lKSM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010423; c=relaxed/simple;
	bh=Kp+dH75fRkj4Yg2B/u14qSdnyXfV1851mjVlG/eyDkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4dOf+svt5Ia4GXZkAt6JeWK79X8QOvHg8GDDFjuXwyrES1W64+mvRpS/BM3+78wbuuZtZG1o2vrb4nAs/tm3mHy2KZa4CpZMhZTa/X2iLoWZFlTPC1GWPg3NOVUOQYssiTDrws1+bWKtzOl+88EuVLi7c92jzCGlbB6Qa26cgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDE7Vziq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C4AC4CED6;
	Mon,  3 Mar 2025 14:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741010422;
	bh=Kp+dH75fRkj4Yg2B/u14qSdnyXfV1851mjVlG/eyDkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LDE7VziqE8Z5eAcLy1ADJtkYPvmnQ1FWgShTdhPsi0Jp00/5H4ih7eFkudyTpV6Ey
	 vzUekJexEEcxmdtofMzZn68/GabGTmMLoyDmPxm2kdElEPPLV3qZha5Aib/AxkKR7v
	 m/mOgM3NliygKNSm4cdkNZYbDU4CUHy7o2nUsiBNydIculfOZE9XJX6vA2Cx8O7TEs
	 nqGWAiDj2LY2VHmrB5jeTqSMkAWpR8/oVe9f3U39KoH0vSV+sGksApEvY4YbqOUYgD
	 MEbgvDOyAHF9gVrkOu+yiC5BM/+QxMgNexT3mwUVWIsR0RWjNldR9e1Z2gFqBmOcaC
	 wYe+elLtbMKhQ==
Date: Mon, 3 Mar 2025 08:00:21 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: Richard Weinberger <richard@nod.at>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Crystal Wood <oss@buserror.net>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linux-mtd@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/3] dt-bindings: nand: Add fsl,elbc-fcm-nand
Message-ID: <20250303140021.GA1732495-robh@kernel.org>
References: <20250226-ppcyaml-elbc-v3-0-a90ed71da838@posteo.net>
 <20250226-ppcyaml-elbc-v3-2-a90ed71da838@posteo.net>
 <174059551678.3319332.12055848852503108874.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174059551678.3319332.12055848852503108874.robh@kernel.org>

On Wed, Feb 26, 2025 at 12:45:17PM -0600, Rob Herring (Arm) wrote:
> 
> On Wed, 26 Feb 2025 18:01:41 +0100, J. Neuschäfer wrote:
> > Formalize the binding already supported by the fsl_elbc_nand.c driver
> > and used in several device trees in arch/powerpc/boot/dts/.
> > 
> > raw-nand-chip.yaml is referenced in order to accommodate situations in
> > which the ECC parameters settings are set in the device tree. One such
> > example is in arch/powerpc/boot/dts/turris1x.dts:
> > 
> > 	/* MT29F2G08ABAEAWP:E NAND */
> > 	nand@1,0 {
> > 		compatible = "fsl,p2020-fcm-nand", "fsl,elbc-fcm-nand";
> > 		reg = <0x1 0x0 0x00040000>;
> > 		nand-ecc-mode = "soft";
> > 		nand-ecc-algo = "bch";
> > 
> > 		partitions { ... };
> > 	};
> > 
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > ---
> > 
> > V3:
> > - remove unnecessary #address/size-cells from nand node in example
> > - add Frank Li's review tag
> > - add missing end of document marker (...)
> > - explain choice to reference raw-nand-chip.yaml
> > 
> > V2:
> > - split out from fsl,elbc binding patch
> > - constrain #address-cells and #size-cells
> > - add a general description
> > - use unevaluatedProperties=false instead of additionalProperties=false
> > - fix property order to comply with dts coding style
> > - include raw-nand-chip.yaml instead of nand-chip.yaml
> > ---
> >  .../devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml | 68 ++++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/fsl,elbc-fcm-nand.example.dtb: nand@1,0: $nodename:0: 'nand@1,0' does not match '^nand@[a-f0-9]$'
> 	from schema $id: http://devicetree.org/schemas/mtd/fsl,elbc-fcm-nand.yaml#

Drop the unit address in raw-nand-chip.yaml. So: 

properties:
  $nodename:
    pattern: "^nand@"


