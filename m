Return-Path: <linux-kernel+bounces-336751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E083E98404A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A346B283CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064CB14BF8D;
	Tue, 24 Sep 2024 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpjNFQn+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B0622315;
	Tue, 24 Sep 2024 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727166021; cv=none; b=o82BKv3e1PF2KYCeG6LvvGl6Hw3N2spAF7FGXgZBqHCNS4CxnQ4MPSDStkNUixvRxEKkiEPyRa1Z+RA+kDcyt2u/0YLy67gz4UKB6M6FOOvghJeJ8pv61Rpe97bDUzCKT4nRd0vSd9vC6i4wauBqYs4lfvBoYXpgLblcMlZeSfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727166021; c=relaxed/simple;
	bh=/o4tq8GeAOgaegwo22vFwkM2pGqReKxFBgBPuAuwIho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0wH68GDiHjmR0quNeYLZhIwflY2+FB3P8ZZn7I/TFpqDntQjxfhphFRvyOvnQA4MpPxrUzHbVc8bai9EQmCkcI+3l7NPoa94AHTPQpVJ0RouThVL9erZ/DqF/MjNlYi1D7v4JFaRT2rkigzdF1I12w9XlRL6cB5s4Zry0ZDGCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpjNFQn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5357BC4CEC4;
	Tue, 24 Sep 2024 08:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727166020;
	bh=/o4tq8GeAOgaegwo22vFwkM2pGqReKxFBgBPuAuwIho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DpjNFQn+uUzAjAh4nIFRsrG+uZe4M8K2GVNT4q56yCaGhQPbSeN2chrsAfRLJijD5
	 TB+NxUN6cQ4j3rgQUaqO/bewcgu5S7aNhSgGYAYBSoeuR9h4ImQTVtzJAONPabzvmP
	 a+qLw15wrQUdw0X+aAB7nqLiWaHLtnObUdfvn8CRkN6NUu7dOjomhdeRcMlRs7tr0m
	 Lm4Q6KHhxI1oqDcPWSpoOwtgKG6xZi81mL5LaLARuS16ZeAn9jP4mhlhNMRK6drqLO
	 RzAGiI9TuFAr/OL6QqEmIBHWAuBpcuScurI4+ph/oVEkEQ04qeNXsWy63hfqQAJBFL
	 Jowgqc2KuFZJg==
Date: Tue, 24 Sep 2024 09:20:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Noah Wang <noahwang.wang@outlook.com>, Marek Vasut <marex@denx.de>,
	Fabio Estevam <festevam@gmail.com>, Lukas Wunner <lukas@wunner.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Khanh Pham <khpham@amperecomputing.com>,
	Open Source Submission <patches@amperecomputing.com>
Subject: Re: [PATCH v2] dt-bindings: trivial-devices: add onnn,adt7462
Message-ID: <20240924-cringe-puma-67798ccadc66@spud>
References: <20240923093800.892949-1-chanh@os.amperecomputing.com>
 <20240923-private-grower-af6a7c1fca09@spud>
 <c536f43a-56f8-4cbf-99a0-fe3b54a42886@amperemail.onmicrosoft.com>
 <56b7aec6-bf8c-4547-bec2-e0df25489f77@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kbruAPx8FvGXJzyx"
Content-Disposition: inline
In-Reply-To: <56b7aec6-bf8c-4547-bec2-e0df25489f77@roeck-us.net>


--kbruAPx8FvGXJzyx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 10:39:20PM -0700, Guenter Roeck wrote:
> On 9/23/24 21:17, Chanh Nguyen wrote:
> > On 24/09/2024 04:23, Conor Dooley wrote:
> > > On Mon, Sep 23, 2024 at 09:38:00AM +0000, Chanh Nguyen wrote:
> > > > The adt7462 supports monitoring and controlling up to
> > > > four PWM Fan drive outputs and eight TACH inputs measures.
> > > > The adt7462 supports reading a single on chip temperature
> > > > sensor and three remote temperature sensors. There are up
> > > > to 13 voltage monitoring inputs.
> > > >=20
> > > > Add device tree bindings for the adt7462 device.
> > > >=20
> > > > Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> > > > ---
> > > > Change in v2:
> > > > =A0=A0=A0 - Add onnn,adt7462 to the list of trivial devices=A0=A0=
=A0=A0=A0=A0 [Guenter]
> > >=20
> > > Is this really a trivial device? If it monitors and controls fans, how
> > > come those do not need to be represented in the devicetree? How is it
> > > possible to tell the difference between monitoring 1 and 4 fans witho=
ut
> > > the extra detail?
> > >=20
> >=20
> > Hi Conor, Thank you for your comments!
> >=20
> > The chip is old. The driver was added back in 2008.
> >=20
> > Really, this is such an old chip that it would make more sense to just =
leave its driver alone unless there is a problem with it; this is viewpoint=
 from Guenter.
> >=20
> > I'm using the driver and the device tree with only the "compatible" and=
 "reg" properties; now it's being good for me without any extra detail.
> >=20
> > Guenter, Rob, Krzysztof, and I discussed making the decision to add thi=
s device to the list of trivial devices. You can get more information at th=
read https://lore.kernel.org/lkml/20240918220553.GA2216504-robh@kernel.org/=
T/ (Because the commit title changed between v1 and v2, it's so hard for ev=
eryone to find it. Sorry! I missed mentioning the link to pacth v1).
> >=20
> > Guenter, who supported the driver development before, he suggested me a=
dd this device to the list of trivial devices.
> >=20
>=20
> Historically it was ok to add an entry into trivial devices and extending
> it later if/when needed. That was still widely done at least until very
> recently. Maybe that changed recently. If so, sorry for bringing up the i=
dea.
> I did not envision that this might be a problem.
>=20
> Can you live with no devicetree entry at all for the chip ? That is of
> course less than perfect, but it seems better than trying to design a
> devicetree description for the chip only to never implement it.

Since it sounds like Krzysztof assented to it, I'll just leave it for
him to ack.

--kbruAPx8FvGXJzyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvJ2PwAKCRB4tDGHoIJi
0qlDAP9+P62X1kDzM9QPlANL1YF/JSXwpvKvPEsHZwVg9ZeJzwEAsWev7egfyb/C
zr3uxdKQgJZ/Okt35MKmzZM+eHBk2QY=
=4L8j
-----END PGP SIGNATURE-----

--kbruAPx8FvGXJzyx--

