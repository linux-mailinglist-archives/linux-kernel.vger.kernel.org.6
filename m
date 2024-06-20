Return-Path: <linux-kernel+bounces-222301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBDC90FF74
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAC71C2133A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B17F1AAE0B;
	Thu, 20 Jun 2024 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Rzrybw1f";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="WMgubCCb"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7646F2582;
	Thu, 20 Jun 2024 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873350; cv=none; b=b3ao7TPHo98qviIJ/Dgm+0Bu+C2oWeXhR0osDsHouFB2CZfVswxMiAmSzzgyvrR3LG50OJSLIQ/NUUmkpGpAjx0ldvDgQqgr5uS17mwOGt2VhOFfnz1nlY/hBHpmy+S8bfRc2YF7rWaP2iTgTux8a/GhtIWGVjFzuL+O//NpDKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873350; c=relaxed/simple;
	bh=kSLxkWTBi+7p1x6D2l+GqdxuiwvhFd858T/X56MUp54=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HnTCkpR0oyaNBXWpy8ma+EJMdTmvmESKIGSe6bE4Cki4CuLde0ikkaNyJz9TYbipRjgbCtaf5GT+mv++CUJrpQRchrvxhVY5263gtDJqc0oPnS+cwV+4RDDfOaiV618Gk9+icuI3fpLxzNXl70j5MN5yIRce7ty6uspe/0sks8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Rzrybw1f; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=WMgubCCb reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718873347; x=1750409347;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kSLxkWTBi+7p1x6D2l+GqdxuiwvhFd858T/X56MUp54=;
  b=Rzrybw1fCFpjD88tfgJZ6zfGARhOwGLj6fa2jKUXmYTHO8/zDLT9BEAb
   fHhAZLv+G9899zmPWLmZGdabSHVOh9+TEhZCU4W5t2aUxEQZTMPJgZhLz
   QLl1MZ+tVC8HjY6QbGwhQDvbtSbJBEWnvGWtlwNIF0bx+04WyCx4Pz1Ia
   4sFj7IoXkDGUve1LPfVpaMKGaeCyeSbMQZGU9Cnhni4LrP4Cn9X5haS0i
   WgVEmt8OFymoByguguWISDE4ZPEI0jGk3OZ4S8mk759KD9pqMBNWFtFdn
   87fDX/5EXQV1mCxzOOoDf53g1ws+rUuE6LHsFu6zhPO8yuDMxuKowMdkp
   A==;
X-CSE-ConnectionGUID: dJCJucXNRfiB1+9RADoZhw==
X-CSE-MsgGUID: zVz13cV6QeSxXfhCK+cVKw==
X-IronPort-AV: E=Sophos;i="6.08,251,1712613600"; 
   d="scan'208";a="37493611"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 20 Jun 2024 10:49:04 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8134B160F46;
	Thu, 20 Jun 2024 10:48:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718873340;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kSLxkWTBi+7p1x6D2l+GqdxuiwvhFd858T/X56MUp54=;
	b=WMgubCCbkT2bV4NGe0ZxAgqPvP52bL1LgN+51fY5mRVepiyGhAN4vOE5T45HrGJhfXqWRS
	GXav3uf0CiRtaduYaKn+a0CCD9lrWdOsA4eBfzkpEla1tpYcpYUIHffsMATiAIN2X2csWq
	ZlhXaNarYE/qT3hbX5HT2hjaec3vz1IBZ9OEqk+4hOVEpuHNc/KrrSdvkM49D6SqpbGvVI
	9knB9l72sstJ8zcyi5YYp0u6pYQpS9GqmU8daMMxHpqZDN6yCGSeDinDj4r3YFcueHymz7
	FhiPybmpqddAgOLNCYwIT/OhWaCwo0Maabrvlmm4jYJdj0I5YhxWLmpcVIOHtw==
Message-ID: <7adcd6789fb33fef10b7349934374e2cfb5ad164.camel@ew.tq-group.com>
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
Date: Thu, 20 Jun 2024 10:48:59 +0200
In-Reply-To: <14bebdc5-3239-47fe-b8cc-68daba278d73@kernel.org>
References: <20240619112406.106223-1-matthias.schiffer@ew.tq-group.com>
	 <89880cda-1140-4ed5-a67f-2201c2825447@kernel.org>
	 <99cc7afbb891de890ff051606f7a120f796e0fbc.camel@ew.tq-group.com>
	 <14bebdc5-3239-47fe-b8cc-68daba278d73@kernel.org>
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

On Thu, 2024-06-20 at 10:29 +0200, Krzysztof Kozlowski wrote:
>=20
>=20
> On 20/06/2024 10:26, Matthias Schiffer wrote:
> > On Thu, 2024-06-20 at 09:24 +0200, Krzysztof Kozlowski wrote:
> > > On 19/06/2024 13:24, Matthias Schiffer wrote:
> > > > While the current Device Trees for TI EVMs configure the PRUSS Ethe=
rnet
> > > > controller as a toplevel node with names like "icssg1-eth", allowin=
g to
> > > > make it a subnode of the ICSSG has a number of advantages:
> > >=20
> > > What is ICSSG? The sram or ti,prus from the ethernet schema?
> >=20
> > ICSSG (Industrial Communication Subsystem (Group?)) is the main device =
described by the
> > ti,pruss.yaml binding (ICSS and PRUSS are different variants of similar=
 IP cores); it is the
> > container for the individual PRU, TXPRU and RTU cores which are referen=
ced by the ti,prus
> > node of the Ethernet schema.
> >=20
> > The entirety of PRU, TXPRU and RTU cores of one ICSSG, each with its ow=
n firmware, forms one
> > Ethernet controller, which is not quite a hardware device, but also not=
 a fully virtual software
> > device.
>=20
> So it is not really child of ICSSG.
>=20
> >=20
> > The Ethernet controller only exists through the various ICSS subcores, =
so it doesn't have an MMIO
> > address of its own. As described, the existing Device Trees define it a=
s a toplevel non-MMIO node;
> > we propose to allow it as a non-MMIO child node of the ICSSG container =
instead.
> >=20
> > If you consider moving the ethernet node into the ICSSG node a bad appr=
oach, we will drop this patch
> > and try to find a different solution to our issue (the Ethernet device =
staying in deferred state
> > forever when the ICSSG node is disabled on Linux).
>=20
> Just disable the ethernet. That's the expected behavior, I don't get
> what is the problem here.

If the disabling happens as a fixup in the bootloader, it needs to know the=
 name of the Ethernet
controller node (or iterate through the DTB to find references to the disab=
led ICSSG node).

The name is currently not used for anything, and not specified in the bindi=
ng doc; the example uses
"ethernet", which is too unspecific, as there can be multiple ICSSG/PRUs, w=
ith each running a
separate Ethernet controller.

Existing Device trees use "icssgX-eth" for an Ethernet controller running o=
n the ICSSG with label
"&icssgX", but labels are a source concept and don't exist in the compiled =
DTB by default.

I do have an idea for an alternative approach that does not need changes to=
 the DT bindings: The PRU
Ethernet driver could detect that the referenced ti,prus are disabled and n=
ot just waiting to be
probed and then fail with ENODEV instead of EPROBE_DEFER.

Best regards,
Matthias


>=20
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

