Return-Path: <linux-kernel+bounces-552719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A22CA57D4D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 19:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA808188D313
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC1F212D6B;
	Sat,  8 Mar 2025 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="mTBtVL1T"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182611F5827
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459252; cv=none; b=XI5ZC7uQQj/tHlv19fPEr1wE35wncHog2oqlvkE/gaDkB/qqdWSPdjzPhb/UcLaef7k0g0dwcVSlsmpSJYRTVZgLaivk02/MMCWoaiIv+2mE9hZKWiNfRJ6B+QDOxAToKrlh0c90Jfg3A007sNAEml7H8Y+ocDFsDj9fdNkqhBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459252; c=relaxed/simple;
	bh=otfbaXRx0KCNwf5peLoJ1CCs5/Kof2zck2m5p70R2NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtJK0odJYITPDjSvUvlfwyhwq2pII3cjgnB70yq8WHKvO7/DY72GQXheixT/UqR1S2pqvycGv2CRDXJydaWUgRjItISwNgouJvWOtAwj7b5qBAl+E5b0M4xGpppWM140AJwZGuigl16xSMoMjmibugHtvAtKD9+KPjce8iyLnyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=mTBtVL1T; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 1F721240101
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 19:40:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1741459248; bh=otfbaXRx0KCNwf5peLoJ1CCs5/Kof2zck2m5p70R2NE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=mTBtVL1TWiC8G4clZSZq+BE6ABeCrUGM7K0jQBhRzIPo7NmAjPNhD0py6m7frpeLp
	 PItpcLoQIg2hinHO/Z9QW3ARnQo/UIFRTVRWX/C3JZHSHrnskoLf1yJs7C1NsBwCbw
	 KIABpO4Bgm7f/bVPvVjIDroJpUqd+3b4zHezCF6jBqKikmVHITZPVRwxdsBEkFl2gc
	 wLX1gAz2/2B5ARv4uXa3Z30MEQ4dtIkh9cw7Va9JQcrBkoSzIzCgzdU61YitpynTM9
	 grmeKFm6j45bnS4EMu5MPE0gDS4RAOHTxZS8x4ljAG9tlQuqEi3n393+TGJ+6flnsR
	 eJ1XtRhmsfOtg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Z9Bmr3JbPz9rxB;
	Sat,  8 Mar 2025 19:40:43 +0100 (CET)
Date: Sat,  8 Mar 2025 18:40:43 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Rob Herring <robh@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Richard Weinberger <richard@nod.at>,
	Michael Ellerman <mpe@ellerman.id.au>,
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
Message-ID: <Z8yPKx1U-sT1OGeb@probook>
References: <20250226-ppcyaml-elbc-v3-0-a90ed71da838@posteo.net>
 <20250226-ppcyaml-elbc-v3-2-a90ed71da838@posteo.net>
 <174059551678.3319332.12055848852503108874.robh@kernel.org>
 <20250303140021.GA1732495-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303140021.GA1732495-robh@kernel.org>

Miquel, what do you think about Rob's suggestion below?

On Mon, Mar 03, 2025 at 08:00:21AM -0600, Rob Herring wrote:
> On Wed, Feb 26, 2025 at 12:45:17PM -0600, Rob Herring (Arm) wrote:
> > 
> > On Wed, 26 Feb 2025 18:01:41 +0100, J. Neuschäfer wrote:
> > > Formalize the binding already supported by the fsl_elbc_nand.c driver
> > > and used in several device trees in arch/powerpc/boot/dts/.
> > > 
> > > raw-nand-chip.yaml is referenced in order to accommodate situations in
> > > which the ECC parameters settings are set in the device tree. One such
> > > example is in arch/powerpc/boot/dts/turris1x.dts:
> > > 
> > > 	/* MT29F2G08ABAEAWP:E NAND */
> > > 	nand@1,0 {
> > > 		compatible = "fsl,p2020-fcm-nand", "fsl,elbc-fcm-nand";
> > > 		reg = <0x1 0x0 0x00040000>;
> > > 		nand-ecc-mode = "soft";
> > > 		nand-ecc-algo = "bch";
> > > 
> > > 		partitions { ... };
> > > 	};
> > > 
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > > ---
> > > 
> > > V3:
> > > - remove unnecessary #address/size-cells from nand node in example
> > > - add Frank Li's review tag
> > > - add missing end of document marker (...)
> > > - explain choice to reference raw-nand-chip.yaml
> > > 
> > > V2:
> > > - split out from fsl,elbc binding patch
> > > - constrain #address-cells and #size-cells
> > > - add a general description
> > > - use unevaluatedProperties=false instead of additionalProperties=false
> > > - fix property order to comply with dts coding style
> > > - include raw-nand-chip.yaml instead of nand-chip.yaml
> > > ---
> > >  .../devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml | 68 ++++++++++++++++++++++
> > >  1 file changed, 68 insertions(+)
> > > 
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/fsl,elbc-fcm-nand.example.dtb: nand@1,0: $nodename:0: 'nand@1,0' does not match '^nand@[a-f0-9]$'
> > 	from schema $id: http://devicetree.org/schemas/mtd/fsl,elbc-fcm-nand.yaml#
> 
> Drop the unit address in raw-nand-chip.yaml. So: 
> 
> properties:
>   $nodename:
>     pattern: "^nand@"
> 

^^^



Best Regards,
J. Neuschäfer

