Return-Path: <linux-kernel+bounces-311474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2699689A1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783111F235F2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4B919F125;
	Mon,  2 Sep 2024 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NaBkOlsx"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C7619F12B;
	Mon,  2 Sep 2024 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286556; cv=none; b=HDNGGBQWU06mWiYRqf+wX+TMCYme/V/VGOY1za9dBb1GcGHPgK5R3Oj2ddB30MO/GuF0NpR5L/Nn1Lbc7m5gN6W0Jsq3jpffxI6JyZAPdkRlC8tVQaTMR+LLRuKsipDA7cs6vhzVcheyEMMcWPkl48Orl42eXscWnvL9+scOj5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286556; c=relaxed/simple;
	bh=5jwDa3PRkmciPQ3iVY3JqQxUmt5O5yF50ztP2V2MNPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVfgfAOMtoIOK4dHnaCi/VGBS9X8uQ/jxxIsOPA6lkFHrEkLHyrTh8NYCkPCa0k3INmk6MVCBUMMzXhSOnLKWXQHb+mRvpiJLPXdRVT+o31WLdc0sxTeJu1PBJNFu0YFPnIn9rVZykO88q0lAzA74ykJlmRqJWvqDqgFHXuTyzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NaBkOlsx; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F11F024000B;
	Mon,  2 Sep 2024 14:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725286547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOSscpEkGa8ztu4bWIy6JMXncsbMSioQscFLJZpRFy8=;
	b=NaBkOlsx82b0muYAnPtFPlQxzwMuxdw+Y5othV1AQKOuVoi2GnSwP2mDoOnGfl9VjutxoC
	LRsmTfXcAwnCJ6zZUZpNi7V7oSFhZ/5A5IAkPBskcTKUAGjfpGUzqqC398EbnOwTnOt0B8
	1z9ZGmBDqdWh42aT1Le0X9SNqKH26owrm38dUuWb/pnku2H7V3X44A36+aT2CJy7roPgXA
	7kmX/9nyClohjwTSHmSLbSnIlr9NToq56GpjaIEiHlSNwE5uYNAwiZ6ZgOWxptCgrrXWLu
	IHkju4Y/yVxRygvQBrPYkODCG42uYG8jY4/b5Gt0jqd/biPjaCr5XrwMBbLQ7w==
Date: Mon, 2 Sep 2024 16:15:45 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Roger Quadros <rogerq@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Nishanth Menon <nm@ti.com>, srk@ti.com,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: ti, gpmc-nand: support partitions
 node
Message-ID: <20240902161545.3ca266de@xps-13>
In-Reply-To: <20240830174302.GA551760-robh@kernel.org>
References: <20240830-gpmc-dtb-v1-1-792cac1ef3cc@kernel.org>
	<20240830174302.GA551760-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi,

> > +  partitions:
> > +    type: object
> > +    description:
> > +      Node containing description of fixed partitions.
> > +
> >  patternProperties:
> >    "@[0-9a-f]+$":
> >      $ref: /schemas/mtd/partitions/partition.yaml =20
>=20
> This and the addition should be replaced with a mtd.yaml reference.

Yes, indeed.

Thanks,
Miqu=C3=A8l

