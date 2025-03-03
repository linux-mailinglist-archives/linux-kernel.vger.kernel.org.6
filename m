Return-Path: <linux-kernel+bounces-545177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60414A4E9FB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BFE17CDD7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F812C2CD7;
	Tue,  4 Mar 2025 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDE7Vziq"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AAF2C2CB1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109128; cv=fail; b=Br4fcCsaobLoPryWJ+3iJtxlyzbEjMvYnLy2QmmaO1icVhuCtUeiquOAXD3ppoaQImrjQ8zsaDLb02C2XaZANTpE6EKfn2Bu+YpzuKWoTiG4Zl4aBRwr1VtJkBoDkNnRSZBzyE+8MvDGfgfA+Ja00NjpAKx86r6vZ9XNw2eR/VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109128; c=relaxed/simple;
	bh=ZV0hyenL1Gr6zkBxI10zjtT9BOF6hJs4mewvNXd8do4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O04GvsCic1Csa6miWCmmSPGGTm18B0ehdNxxdpg1iqF8JcXBfu/1qxKDJ+E0o1OHt2m7VSipByBYSsQPR16nZoeuzvhnvXkmZf9rE3Q5BAX6Lwz6pTZUvOJdR7GdX+Ssu7AyEW/A3EVAQfISSPG3VX2O77jQNStgAai5yvRqnao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDE7Vziq reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id D843C40D977D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:25:24 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dtM2pmbzFxLw
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:51:39 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id A5A894273A; Tue,  4 Mar 2025 17:51:25 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDE7Vziq
X-Envelope-From: <linux-kernel+bounces-541866-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDE7Vziq
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 3A16641CC5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 17:00:40 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id CA0B62DCE4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 17:00:39 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654EF3A89E9
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E163F2135B9;
	Mon,  3 Mar 2025 14:00:25 +0000 (UTC)
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <174059551678.3319332.12055848852503108874.robh@kernel.org>
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dtM2pmbzFxLw
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741713789.19946@jy/o0WCPBk9Ugzx6Nj1Zbg
X-ITU-MailScanner-SpamCheck: not spam

On Wed, Feb 26, 2025 at 12:45:17PM -0600, Rob Herring (Arm) wrote:
>=20
> On Wed, 26 Feb 2025 18:01:41 +0100, J. Neusch=E4fer wrote:
> > Formalize the binding already supported by the fsl_elbc_nand.c driver
> > and used in several device trees in arch/powerpc/boot/dts/.
> >=20
> > raw-nand-chip.yaml is referenced in order to accommodate situations i=
n
> > which the ECC parameters settings are set in the device tree. One suc=
h
> > example is in arch/powerpc/boot/dts/turris1x.dts:
> >=20
> > 	/* MT29F2G08ABAEAWP:E NAND */
> > 	nand@1,0 {
> > 		compatible =3D "fsl,p2020-fcm-nand", "fsl,elbc-fcm-nand";
> > 		reg =3D <0x1 0x0 0x00040000>;
> > 		nand-ecc-mode =3D "soft";
> > 		nand-ecc-algo =3D "bch";
> >=20
> > 		partitions { ... };
> > 	};
> >=20
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: J. Neusch=E4fer <j.ne@posteo.net>
> > ---
> >=20
> > V3:
> > - remove unnecessary #address/size-cells from nand node in example
> > - add Frank Li's review tag
> > - add missing end of document marker (...)
> > - explain choice to reference raw-nand-chip.yaml
> >=20
> > V2:
> > - split out from fsl,elbc binding patch
> > - constrain #address-cells and #size-cells
> > - add a general description
> > - use unevaluatedProperties=3Dfalse instead of additionalProperties=3D=
false
> > - fix property order to comply with dts coding style
> > - include raw-nand-chip.yaml instead of nand-chip.yaml
> > ---
> >  .../devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml | 68 ++++++++++++=
++++++++++
> >  1 file changed, 68 insertions(+)
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/mtd/fsl,elbc-fcm-nand.example.dtb: nand@1,0: $nodename:0: 'nand@1,0' doe=
s not match '^nand@[a-f0-9]$'
> 	from schema $id: http://devicetree.org/schemas/mtd/fsl,elbc-fcm-nand.y=
aml#

Drop the unit address in raw-nand-chip.yaml. So:=20

properties:
  $nodename:
    pattern: "^nand@"



