Return-Path: <linux-kernel+bounces-554371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2F3A596EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0457E1889847
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5226122B586;
	Mon, 10 Mar 2025 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DuK80jpk"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F167F1BC3F;
	Mon, 10 Mar 2025 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615259; cv=none; b=WUdUlcv4+AhiAMASMHUSIMacz1QFeZFCMQVknMfDwGFwM2iz2++Ost9XKwaL9OpgeBIbX9sF9nDQYavSKRDgYbw07snpogYiYwJVnL6FuTyRmmUkZlgObxq/1r2H2yRUs1Re+Iyhc8dBRIeauv7TaXydt/gRTphYsAztzK1Dr7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615259; c=relaxed/simple;
	bh=IhYu9da6QFSDDsbPqHxYIft82wSywXeglIjGNyg4cBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a4R7Z2sfAL8YM4meITnU208UTavNrmjVbVFIApj02TCGZpiiZUTcrqAM9F+LSVsBCuEt5xdYSHQPiyaQ4WmKN7dEsXbPy1wwFSNX5wK6t09hjUN+AWMj12NZCMVCXZFekDpJn8RvxPFBTdDB8Jg7r/+Rf4RS0NLseWwzYc2uNsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DuK80jpk; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8F6344287;
	Mon, 10 Mar 2025 14:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741615255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ic1Dx7Jc0GBQUrs269FgO1VmANg/4PfSayG+I8hDFAw=;
	b=DuK80jpkLcFQYmRVTQyZYRzbWd5veudVS7lStznyElUVSl4NgOQMEwoub8NqVmncBWeIN3
	rITac9+BaOxeX/0oMlHZZXVKP7XhTSkVc2X7R58j4qlUD3T8n7y3YwjdfgYMyc56g5RlGI
	V7uO9XmSG9G15dT+Ui3SJkI2Yw/0sFxzLTCoAmwC9MJHGpzvsut4sPo39pr1ftGDdzHHLk
	becCl4cOkHPGy6BeoqQBEYVbRb7Kw6YFX5tZxHHfGSylO7zH/oLvhhiKDWuNWm/6HccR8z
	7dZk2DzQqcMZ52w0chHlB5oo610DZbP6n+4Udifr4zHSrJoaEk3PEhTFUIq1UA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: J. =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: Rob Herring <robh@kernel.org>,  Richard Weinberger <richard@nod.at>,
  Michael Ellerman <mpe@ellerman.id.au>,  Nicholas Piggin
 <npiggin@gmail.com>,  Conor Dooley <conor+dt@kernel.org>,
  linux-kernel@vger.kernel.org,  Crystal Wood <oss@buserror.net>,
  Christophe Leroy <christophe.leroy@csgroup.eu>,
  devicetree@vger.kernel.org,  Frank Li <Frank.Li@nxp.com>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  Madhavan Srinivasan <maddy@linux.ibm.com>,
  linux-mtd@lists.infradead.org,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Krzysztof Kozlowski <krzk@kernel.org>,  Naveen N Rao <naveen@kernel.org>,
  linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/3] dt-bindings: nand: Add fsl,elbc-fcm-nand
In-Reply-To: <Z8yPKx1U-sT1OGeb@probook> ("J. =?utf-8?Q?Neusch=C3=A4fer=22'?=
 =?utf-8?Q?s?= message of "Sat, 8
	Mar 2025 18:40:43 +0000")
References: <20250226-ppcyaml-elbc-v3-0-a90ed71da838@posteo.net>
	<20250226-ppcyaml-elbc-v3-2-a90ed71da838@posteo.net>
	<174059551678.3319332.12055848852503108874.robh@kernel.org>
	<20250303140021.GA1732495-robh@kernel.org> <Z8yPKx1U-sT1OGeb@probook>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 10 Mar 2025 15:00:53 +0100
Message-ID: <87o6y97zoq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffuddvueeigeegkeffveeuledtvdefteeiuddthffhtdefhfffledtleeuteejvdenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgpdihrghmlhdrshhonecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepjhdrnhgvsehpohhsthgvohdrnhgvthdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtohepnhhpihhgghhinhesghhmrghilhdrtghom
 hdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhsshessghushgvrhhrohhrrdhnvght
X-GND-Sasl: miquel.raynal@bootlin.com

On 08/03/2025 at 18:40:43 GMT, J. Neusch=C3=A4fer <j.ne@posteo.net> wrote:

> Miquel, what do you think about Rob's suggestion below?
>
> On Mon, Mar 03, 2025 at 08:00:21AM -0600, Rob Herring wrote:
>> On Wed, Feb 26, 2025 at 12:45:17PM -0600, Rob Herring (Arm) wrote:
>> >=20
>> > On Wed, 26 Feb 2025 18:01:41 +0100, J. Neusch=C3=A4fer wrote:
>> > > Formalize the binding already supported by the fsl_elbc_nand.c driver
>> > > and used in several device trees in arch/powerpc/boot/dts/.
>> > >=20
>> > > raw-nand-chip.yaml is referenced in order to accommodate situations =
in
>> > > which the ECC parameters settings are set in the device tree. One su=
ch
>> > > example is in arch/powerpc/boot/dts/turris1x.dts:
>> > >=20
>> > > 	/* MT29F2G08ABAEAWP:E NAND */
>> > > 	nand@1,0 {
>> > > 		compatible =3D "fsl,p2020-fcm-nand", "fsl,elbc-fcm-nand";
>> > > 		reg =3D <0x1 0x0 0x00040000>;
>> > > 		nand-ecc-mode =3D "soft";
>> > > 		nand-ecc-algo =3D "bch";
>> > >=20
>> > > 		partitions { ... };
>> > > 	};
>> > >=20
>> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
>> > > Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>
>> > > ---
>> > >=20
>> > > V3:
>> > > - remove unnecessary #address/size-cells from nand node in example
>> > > - add Frank Li's review tag
>> > > - add missing end of document marker (...)
>> > > - explain choice to reference raw-nand-chip.yaml
>> > >=20
>> > > V2:
>> > > - split out from fsl,elbc binding patch
>> > > - constrain #address-cells and #size-cells
>> > > - add a general description
>> > > - use unevaluatedProperties=3Dfalse instead of additionalProperties=
=3Dfalse
>> > > - fix property order to comply with dts coding style
>> > > - include raw-nand-chip.yaml instead of nand-chip.yaml
>> > > ---
>> > >  .../devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml | 68 +++++++++++=
+++++++++++
>> > >  1 file changed, 68 insertions(+)
>> > >=20
>> >=20
>> > My bot found errors running 'make dt_binding_check' on your patch:
>> >=20
>> > yamllint warnings/errors:
>> >=20
>> > dtschema/dtc warnings/errors:
>> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/binding=
s/mtd/fsl,elbc-fcm-nand.example.dtb: nand@1,0: $nodename:0: 'nand@1,0' does=
 not match '^nand@[a-f0-9]$'
>> > 	from schema $id: http://devicetree.org/schemas/mtd/fsl,elbc-fcm-nand.=
yaml#
>>=20
>> Drop the unit address in raw-nand-chip.yaml. So:=20
>>=20
>> properties:
>>   $nodename:
>>     pattern: "^nand@"

I am not a big fan of lowering the constraint, but if our current schema
doesn't allow to express this need differently, we may need to do that.
I obviously trust Rob on this regard.

Thanks,
Miqu=C3=A8l

