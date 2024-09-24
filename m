Return-Path: <linux-kernel+bounces-336752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B6E984052
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F5C1C2212A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8062F14D2BD;
	Tue, 24 Sep 2024 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEu0yoNQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FE722315;
	Tue, 24 Sep 2024 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727166074; cv=none; b=qd/xR4kk36RBue+xhbgxuG3PPIlOimR1JmMpUoCwqwUC6IlEu4MqrDZPHeC5KvdWolNm9wQU7m1yI1jdlOzzoPkg0haFC1FzTb4fcE/Jb3XVQtx89eILzyPkTbU/WwFx9xUh4J6DN4LuFkN4OrhpJkuAuJUYi70CMo4Se5iVHD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727166074; c=relaxed/simple;
	bh=JQjvqoJf883IdrKR/BHOby0lgQEkNGqZuxt3j5rHrMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhykrCnpC11Vb/xyiP6Fh3HzfXgFaUgmx263EdvPvsCfiooYNmlRR68aoiS5PCEeB2+BB7Iz2Qi4b2cIdwMaRjYV4GcmOCUQds8fe1a80hp1OZis6RM7p1EGCQ/MX525pABYbUVDWNrq69Nsw6OSb8tvdJwh5jM6t89L94BsZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEu0yoNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FD3C4CEC4;
	Tue, 24 Sep 2024 08:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727166073;
	bh=JQjvqoJf883IdrKR/BHOby0lgQEkNGqZuxt3j5rHrMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEu0yoNQEtnu12CV5Jxf2HXFewCRoTBXeKrxlTyr68xmwuQq4ziZVx/gxve4imrFn
	 7aWlCUdxfk2H6L45dxE4/9saGfhvmKwngY2BPwJNc3xuOuDct3IEHzv8HffL/ePFSs
	 3C4oCtOlOm/CMNP6sfVA6uVyv10bSbe/bHMjnU9jO1jkNZrJSi9R0EWZinBwykg1bA
	 O2P4tnUt9eCnTKK2ov6Lzm8PEWdZpPJR3l16Ikz8AfiM7a88BRjNROBh6ELu0lwcGb
	 L/fvcZYgzEv3wnIfI2f+OXiJF2QyYKtyeDSvIXF4XpHOcgLbA0605TTPaPNq+ZOCyY
	 jF994HRBmQ77g==
Date: Tue, 24 Sep 2024 10:21:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shawn Guo <shawnguo@kernel.org>, Petr Benes <petr.benes@ysoft.com>, devicetree@vger.kernel.org, 
	linux-usb@vger.kernel.org, Michael Walle <mwalle@kernel.org>, imx@lists.linux.dev, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Mathieu Othacehe <m.othacehe@gmail.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	linux-kernel@vger.kernel.org, Hiago De Franco <hiago.franco@toradex.com>, 
	Herburger <gregor.herburger@ew.tq-group.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Joao Paulo Goncalves <joao.goncalves@toradex.com>, Fabio Estevam <festevam@gmail.com>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] dt-bindings: usb: Add Diodes Incorporated
 PI5USB30213A Type-C Controller
Message-ID: <6hy6sl53ducvdjuppzg3xebh6oyxvs75vz4ua2qe2jhuuoowhp@h5jbfu2wqysc>
References: <20240923151417.1665431-1-michal.vokac@ysoft.com>
 <20240923151417.1665431-4-michal.vokac@ysoft.com>
 <20240924072436.gya7hvmlpb7fk5ou@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240924072436.gya7hvmlpb7fk5ou@pengutronix.de>

On Tue, Sep 24, 2024 at 09:24:36AM +0200, Marco Felsch wrote:
> On 24-09-23, Michal Vok=C3=A1=C4=8D wrote:
> > From: Petr Benes <petr.benes@ysoft.com>
> >=20
> > Diodes Incorporated PI5USB30213A Type-C Controller supports host,
> > device, and dual-role mode based on voltage levels detected on CC
> > pin. Supports dual differential channel, 2:1 USB 3.0 Mux/Demux,
> > USB Type-C specification 1.1.
> >=20
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Signed-off-by: Petr Benes <petr.benes@ysoft.com>
> > Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> > ---
> > v3:
> > - Collected R-b tag from Krzysztof.
> > v2:
> > - Moved maintainers before description: block.
> > - Used full paths for references.
> > - Removed unneeded items form connector property.
> > - Fixed example.
> >=20
> >  .../bindings/usb/diodes,pi5usb30213a.yaml     | 88 +++++++++++++++++++
>=20
> I suppose the driver is part of an other patchset?

Hm, indeed, where is the driver?

This patch should not be here.

Best regards,
Krzysztof


