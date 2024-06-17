Return-Path: <linux-kernel+bounces-216886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE04390A813
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9B91F24238
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F1A18FC6E;
	Mon, 17 Jun 2024 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sVwN4ibG"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C898A48;
	Mon, 17 Jun 2024 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611462; cv=none; b=Nw02/3QrGr0cbUfdQd4qPV5YTsAKhgU5ypaStP8mnLKBVFIi6Wyij4mQV1+iJyRNnfmM74TxjVY28m6DWT94jIj6563wJ7/HKlJ7kVdkti7a6qZ4L35AD78XU9ZEBJelBOyWpkEae8Izb9a0w83EnumuMAMMOrUkZrH6hHQ4sm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611462; c=relaxed/simple;
	bh=46hqN2x9tCodtz4f+p9bKlz4DoolUlXsc2EoKqB+GqY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1NxztqtOKe6C9KTqMJf4k27DXt34IKcMkZu5SnShNBpowNqD/wqrw8qCfQtszUeEOf+6YZDqoyF8Z0CbCCMF25ghRoXaeCVPruP0EqOJrjk8CtYo0dn0boqGEQrU9n4t4OdT/2ahZQ1V6jCwtKwhrxWcF1znox3+yo5W0kC58s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sVwN4ibG; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718611460; x=1750147460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=46hqN2x9tCodtz4f+p9bKlz4DoolUlXsc2EoKqB+GqY=;
  b=sVwN4ibG+F1u1t1Uacrcn7GZGnQgYvkBEvrrVHQQ/Iys7dTJUoVoN8o6
   B1p4yoSOjpntuNFmRjzX+Qs1ktmmb138+wupRBhoFDbu7CAXe4BCwcD6d
   j1iaXjk0C+oXM6hWWMV4aIz2kYgzeecAkM0rEi7gRzciUTJIKYxtw6+f8
   1lwCy0XwzJ5McvkYWJrrbgpXj6oWtPem0Zg8+a0JAqVjfMyfnOdbQpBzq
   4LL72EunivFZ/HOqn93G7xwHRFW9LJ8enUG7D+FuO50HxzdoNPvnLQ/xa
   S16OtktpHPU0uyWhvqa5/harVN5GheRov/o+FoORaGAK8esjBRWWtgbNQ
   Q==;
X-CSE-ConnectionGUID: KTYX6uPmSP2Ap7j89zTe6w==
X-CSE-MsgGUID: LwMaza2HTh6HKQMtkrNe5A==
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="asc'?scan'208";a="27844232"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2024 01:04:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 17 Jun 2024 01:04:00 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 17 Jun 2024 01:03:57 -0700
Date: Mon, 17 Jun 2024 09:03:39 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Inochi Amaoto <inochiama@outlook.com>
CC: Yixun Lan <dlan@gentoo.org>, Thomas Bonnefille
	<thomas.bonnefille@bootlin.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Chen Wang <unicorn_wang@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>, Albert Ou <aou@eecs.berkeley.edu>, Palmer
 Dabbelt <palmer@dabbelt.com>, Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/5] dt-bindings: interrupt-controller: Add SOPHGO SG2002
 plic
Message-ID: <20240617-arrival-settling-3a98e5939808@wendy>
References: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
 <20240527-sg2002-v1-1-1b6cb38ce8f4@bootlin.com>
 <20240617003627.GA4008871@ofsar>
 <IA1PR20MB4953B2253043C304760A2D12BBCD2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYXOfHOY/pRglM2C"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953B2253043C304760A2D12BBCD2@IA1PR20MB4953.namprd20.prod.outlook.com>

--zYXOfHOY/pRglM2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 11:33:00AM +0800, Inochi Amaoto wrote:
> On Mon, Jun 17, 2024 at 12:36:27AM GMT, Yixun Lan wrote:
> > hi Thomas:
> >=20
> > On 12:28 Mon 27 May     , Thomas Bonnefille wrote:
> > > Add compatible string for SOPHGO SG2002 Platform-Level Interruter
> > > Controller.
> > >=20
> > > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > > ---
> > >  .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml =
     | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/s=
ifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-control=
ler/sifive,plic-1.0.0.yaml
> > > index 709b2211276b..7e1451f9786a 100644
> > > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,p=
lic-1.0.0.yaml
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,p=
lic-1.0.0.yaml
> > > @@ -67,6 +67,7 @@ properties:
> > >                - allwinner,sun20i-d1-plic
> > >                - sophgo,cv1800b-plic
> > >                - sophgo,cv1812h-plic
> > > +              - sophgo,sg2002-plic
> >=20
> > it's not necessary to introduce a new compatible name, as sg2002 use sa=
me plic IP as cv1800b
> > I feel it's wrong to introduce sophgo,cv1812h-plic at first place, but =
that we can't revert?
> >=20
> > same reason also apply to clint in patch 2/5 ..
> >=20
>=20
> You are right, it is historical reasons. For hardware, they have the same=
 risc-v cores
> across the whole series.
>=20
> It could be better to use something just like "cv1800-plic".

Different integrations of the same IP could result in bugs present in
one device and not another. Unless these SoCs are the same die, but with
bits fused off, I'd appreciate soc-specific compatibles.

Thanks,
Conor.

--zYXOfHOY/pRglM2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZm/t0AAKCRB4tDGHoIJi
0rQZAP4sMNITKIgW0yhdH6QXLJeHlppfCx4teG80f1lrA0Oj4wEA096L9PT3PcMi
4tAca6zqH76nsuJnituv/7lYSa32vg8=
=K7NA
-----END PGP SIGNATURE-----

--zYXOfHOY/pRglM2C--

