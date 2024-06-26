Return-Path: <linux-kernel+bounces-230274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6850917AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72AFB1F21A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A901D699;
	Wed, 26 Jun 2024 08:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="iidUtYwe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="KP2opQ4d"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD7E161311;
	Wed, 26 Jun 2024 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719389901; cv=none; b=PC022QGzQhcFMn1dLlAyQZVvqVC6rLzqB9+cqgFipj33KdGJCiSjCcoXLyrZyC0hwsrm05owx1eZXaBTMThZ27YwzhR2T4mmxLfL2i1Tx0/ip4vYXpfCnZzH8uiEaPSfUqFvfhY5IqGer6bP2NJTP5kPXZ3ivk9esk45sGHGVIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719389901; c=relaxed/simple;
	bh=PK1WnVjNANttZNlxbEZ0iGraUTJX3Qd/linTeJq922s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W2VOsxjPFE7urbeQu7LPrUY9nfGgmfOx5TIsP5AMxS7Pk/DaQnX6Yu1rv4+Y3uRTqiQvF3lE551ysRYBx5BVUWOP7k1XWxJv8XYp/dJQhXXIfse6IRpReIzMc8NWoh9SdlG7VZnpZvGAA9/olcSiCHB+luRdCkdA8S3MRETxHrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=iidUtYwe; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=KP2opQ4d reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1719389897; x=1750925897;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=PK1WnVjNANttZNlxbEZ0iGraUTJX3Qd/linTeJq922s=;
  b=iidUtYwephrbmlFrL5beKdH5AJQtSJ67ZAJ44FI2BbMl+KSx7OVmn2dL
   tlTub8a3f8qHzP63S4FjfeeptjmSY4/d5uGGlagdrYEZDt3l5IRPCqAzD
   gfk5iYoqbz7WdbhzCaZdJHUn0HTYhDnRci5MKFxCCSFaRsEzrVdCCo/dC
   YelB7WXknI0MxOVnp7DAOKEfZrkEzjCZPli730s+0vpXjGaD+XIh2/oOv
   YLsosyNimZmV0IVxshiapsSv4J4PkQMou83CL5B34RUDNCqq7jKXxXw3h
   coEvFC8L7tgwZxMJT+MxFQVwahT4vTKMj4Dg2hfSvSysA1HSOr140HM7w
   A==;
X-CSE-ConnectionGUID: Brw7EgUVQeuB4OL8ap5cDw==
X-CSE-MsgGUID: z48TzsmSR7axC/5Xzi+iEQ==
X-IronPort-AV: E=Sophos;i="6.08,266,1712613600"; 
   d="scan'208";a="37592941"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 26 Jun 2024 10:18:14 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF931163835;
	Wed, 26 Jun 2024 10:18:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1719389890;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PK1WnVjNANttZNlxbEZ0iGraUTJX3Qd/linTeJq922s=;
	b=KP2opQ4duk63H/gCnMEWtD8CuDNmjlyXFPmObV4wOiq6NNtgUJbBFmQl8R85o1qA6R8+Qg
	BOE9jcDkwlWxUQPPAbVDhZjtC1MHUltafj+5huVCBIGTmmH0lI9GV9fAYt9wIhvfm5z0CQ
	fx+piiT5Z1CjNcqu6OEuNNHzJBcM07sEbMzsl6EVZFFhLVV1FMjY89ha2PWuktfL8ElttT
	r0+0gDfwsp7qKTO8GxhQF5ZDvaESTG7A1R0fR6M3rPTcYHO3T1gMshK2kqUM1I1zx9DB6l
	bEftb+tVtLXmeodNJLQB+GVXEvSVnCiX5ePm0YZTqNeyl8CXqvx9EYSpUaMVoQ==
Message-ID: <958090771f1b301f00b96d55aac312704866f1bb.camel@ew.tq-group.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: pruss: allow ethernet
 controller in ICSSG node
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Suman Anna
 <s-anna@ti.com>
Date: Wed, 26 Jun 2024 10:18:08 +0200
In-Reply-To: <643ad6b3-3bbc-4a5d-ac47-6368f2171e87@kernel.org>
References: <20240619112406.106223-1-matthias.schiffer@ew.tq-group.com>
	 <89880cda-1140-4ed5-a67f-2201c2825447@kernel.org>
	 <99cc7afbb891de890ff051606f7a120f796e0fbc.camel@ew.tq-group.com>
	 <14bebdc5-3239-47fe-b8cc-68daba278d73@kernel.org>
	 <7adcd6789fb33fef10b7349934374e2cfb5ad164.camel@ew.tq-group.com>
	 <643ad6b3-3bbc-4a5d-ac47-6368f2171e87@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 2024-06-26 at 09:33 +0200, Krzysztof Kozlowski wrote:
>=20
> On 20/06/2024 10:48, Matthias Schiffer wrote:
> > On Thu, 2024-06-20 at 10:29 +0200, Krzysztof Kozlowski wrote:
> > >=20
> > >=20
> > > On 20/06/2024 10:26, Matthias Schiffer wrote:
> > > > On Thu, 2024-06-20 at 09:24 +0200, Krzysztof Kozlowski wrote:
> > > > > On 19/06/2024 13:24, Matthias Schiffer wrote:
> > > > > > While the current Device Trees for TI EVMs configure the PRUSS =
Ethernet
> > > > > > controller as a toplevel node with names like "icssg1-eth", all=
owing to
> > > > > > make it a subnode of the ICSSG has a number of advantages:
> > > > >=20
> > > > > What is ICSSG? The sram or ti,prus from the ethernet schema?
> > > >=20
> > > > ICSSG (Industrial Communication Subsystem (Group?)) is the main dev=
ice described by the
> > > > ti,pruss.yaml binding (ICSS and PRUSS are different variants of sim=
ilar IP cores); it is the
> > > > container for the individual PRU, TXPRU and RTU cores which are ref=
erenced by the ti,prus
> > > > node of the Ethernet schema.
> > > >=20
> > > > The entirety of PRU, TXPRU and RTU cores of one ICSSG, each with it=
s own firmware, forms one
> > > > Ethernet controller, which is not quite a hardware device, but also=
 not a fully virtual software
> > > > device.
> > >=20
> > > So it is not really child of ICSSG.
> > >=20
> > > >=20
> > > > The Ethernet controller only exists through the various ICSS subcor=
es, so it doesn't have an MMIO
> > > > address of its own. As described, the existing Device Trees define =
it as a toplevel non-MMIO node;
> > > > we propose to allow it as a non-MMIO child node of the ICSSG contai=
ner instead.
> > > >=20
> > > > If you consider moving the ethernet node into the ICSSG node a bad =
approach, we will drop this patch
> > > > and try to find a different solution to our issue (the Ethernet dev=
ice staying in deferred state
> > > > forever when the ICSSG node is disabled on Linux).
> > >=20
> > > Just disable the ethernet. That's the expected behavior, I don't get
> > > what is the problem here.
> >=20
> > If the disabling happens as a fixup in the bootloader, it needs to know=
 the name of the Ethernet
> > controller node (or iterate through the DTB to find references to the d=
isabled ICSSG node).
>=20
> Which is already solved for several such cases, including ethernet
> devices? Aliases?
>=20
> >=20
> > The name is currently not used for anything, and not specified in the b=
inding doc; the example uses
> > "ethernet", which is too unspecific, as there can be multiple ICSSG/PRU=
s, with each running a
> > separate Ethernet controller.
>=20
> Use existing solutions - aliases.

Understood.

I'm not entirely happy that the bootloader needs to know that it is an Ethe=
rnet controller that is
provided by the ICSSG, and there isn't a simple way to say "whatever kind o=
f device that Linux's DTB
loads into the ICSSG should be disabled".

But I guess for most boards there is only a single kind of ICSSG firmware t=
hat is used anyways. So
I'm going with the solution you propose for now.

Best regards,
Matthias


>=20
> >=20
> > Existing Device trees use "icssgX-eth" for an Ethernet controller runni=
ng on the ICSSG with label
> > "&icssgX", but labels are a source concept and don't exist in the compi=
led DTB by default.
> >=20
> > I do have an idea for an alternative approach that does not need change=
s to the DT bindings: The PRU
> > Ethernet driver could detect that the referenced ti,prus are disabled a=
nd not just waiting to be
> > probed and then fail with ENODEV instead of EPROBE_DEFER.
>=20
> Sorry, but re-shuffling nodes into incorrect hardware description is not
> the workaround for your problem.
>=20
> Best regards,
> Krzysztof
>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

