Return-Path: <linux-kernel+bounces-564564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DA1A65775
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90D1883E20
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD2F18A95A;
	Mon, 17 Mar 2025 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYQ7aey9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F151537CB;
	Mon, 17 Mar 2025 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227400; cv=none; b=M8xNKFkn4IK1Acn79uNJH9NeWvqgJap12x61uYXR1/VJLwZYQWZ6+Hl8gk7sgMBYqQYahRT4cRHB7AoE46dJFGLxGi3uOZKlUsW1NaKBt3X7k6o7Vsqciy993gmTyBp9eTImoWc8aQAlW2kkGnNHef0WhhBML04UsSdNugGd6z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227400; c=relaxed/simple;
	bh=brfa3n5BnjS4QD+/ZuK3dFdFOzMD+7usaWnYZwDB2vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT9TQVcI/tV0QuDhA+iC53+gM0nm5KmI7ulSGya39BxtbMttaOvRCZQeO7DIh2SYQFZpqYhg4MMHdTqxbt2dhKTEe7BsFr4+Vd6MsM9G/AtD3hyc72O0nK0M4FR4i9fI9b1lJtfZ4td2JBJ7h6pe2foK/O4IHpkEZ8i7nEb2o+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYQ7aey9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57ABAC4CEE3;
	Mon, 17 Mar 2025 16:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742227399;
	bh=brfa3n5BnjS4QD+/ZuK3dFdFOzMD+7usaWnYZwDB2vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NYQ7aey92vZohAV9PzPID7FcSshuLxYwtcSMAt3Qsi2z/KUDrwrLsi2Z7ZyYtOZAw
	 WlORpRoNPbTBQQan3TDe66NlKIqoduy0euUa9OMQuaqawTlynpwHEL4+BkHk4Qf9Gg
	 pE7T0MI9uu4KBOn9BqWLQ+iaXf8FgdXbhfCcNn8sefUMLFvvQC3QgARJA14Sa+WuFH
	 IH6k1g7PBmvraSOMzcMEgWVJuv4JyGDHxbIGC6oX7MLxAt+kWHfIKFasqDewCf0TLk
	 klAuTpvU0zitUzBE1XQbkFE0cnYY41IYWeMEX76TSVzuTTR73RON+qBcKrOmiXYHRi
	 njNPNMv8iNm8Q==
Date: Mon, 17 Mar 2025 11:03:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Naveen N Rao <naveen@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Richard Weinberger <richard@nod.at>,
	Crystal Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 3/4] dt-bindings: nand: Add fsl,elbc-fcm-nand
Message-ID: <174222739794.60508.9641557469920880307.robh@kernel.org>
References: <20250313-ppcyaml-elbc-v4-0-55903722d9ea@posteo.net>
 <20250313-ppcyaml-elbc-v4-3-55903722d9ea@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313-ppcyaml-elbc-v4-3-55903722d9ea@posteo.net>


On Thu, 13 Mar 2025 22:35:46 +0100, J. Neuschäfer wrote:
> Formalize the binding already supported by the fsl_elbc_nand.c driver
> and used in several device trees in arch/powerpc/boot/dts/.
> 
> raw-nand-chip.yaml is referenced in order to accommodate situations in
> which the ECC parameters settings are set in the device tree. One such
> example is in arch/powerpc/boot/dts/turris1x.dts:
> 
> 	/* MT29F2G08ABAEAWP:E NAND */
> 	nand@1,0 {
> 		compatible = "fsl,p2020-fcm-nand", "fsl,elbc-fcm-nand";
> 		reg = <0x1 0x0 0x00040000>;
> 		nand-ecc-mode = "soft";
> 		nand-ecc-algo = "bch";
> 
> 		partitions { ... };
> 	};
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> 
> V4:
> - no changes
> 
> V3:
> - remove unnecessary #address/size-cells from nand node in example
> - add Frank Li's review tag
> - add missing end of document marker (...)
> - explain choice to reference raw-nand-chip.yaml
> 
> V2:
> - split out from fsl,elbc binding patch
> - constrain #address-cells and #size-cells
> - add a general description
> - use unevaluatedProperties=false instead of additionalProperties=false
> - fix property order to comply with dts coding style
> - include raw-nand-chip.yaml instead of nand-chip.yaml
> ---
>  .../devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


