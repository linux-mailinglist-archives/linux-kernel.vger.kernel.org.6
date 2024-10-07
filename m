Return-Path: <linux-kernel+bounces-352993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D1E992702
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E931C222BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1AF18B49B;
	Mon,  7 Oct 2024 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pXM8LD5c"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA033FE;
	Mon,  7 Oct 2024 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289886; cv=none; b=I5EIqekmhSPsCSXd9FS/As8BPScIHLvhN0yFTCdrsfXmXPHOjrLlFVYSnIHvQ6EfhzRdzTIPL6CHknR94nfo3uVmYbGV5L5qTOuSZdM1tDPArxzOK0UO72ATxSGeHkqyXwZMYS3cmNuWU1/uYM789HKky7tPMnEjQhCfJ75vpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289886; c=relaxed/simple;
	bh=u9xn5NKrPvn154tL338s4FqczjJox5o62NGI+xcQ0FY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTUBgfuUq1B1pdI6X0BucFui06/9CH2tqaEhLVIu6Oa4SUDNdoc/8hiLEvYrzDYBtfkfm9WuuOiJQ7vNBf4kGcNC+PGViWXnyNEfCUw1knGbhDzREQ1FrGkgih9WXQLI+/raj9bdB7rCU8ZvrOkYNAC7HHRugSNraVeHt1izB8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pXM8LD5c; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D0B75C0005;
	Mon,  7 Oct 2024 08:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728289876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rb0qAok+4nN5Eq9733pEqebLsnhZLk/VLDHYW7fziQ=;
	b=pXM8LD5c8H8QrgcQFgWuGAYamfTYSxpx9XiiylWBubTJHJUwAwR20s8mt/z1bc1JF5EzM5
	uR6wBGGMd7TSNPCj0tZqBak9clIj7VtJH/1YITcLVYuse0S5EJCZnUeKGdGfTizl01jh/y
	cfGR6Rq6+bN0scEzcsP8IMeruuNUQHwiO4LzV2MQAmbzHqx3kNgDgG9yxnwdh6SACJ3ZkQ
	b52yTTfKCb5E5+plVm8utctGG7arqN7EnTzXh/4zsyTvfo0+OGqH1L5fqn7iWUbCqkpmk7
	GFuDit5+EuJltoNgT5ty/1fEA50Mxtp/v1ldkbUFTlTPGk2Mm7m8myrOHwIj2Q==
Date: Mon, 7 Oct 2024 10:31:14 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Richard Weinberger
 <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: mtd: davinci: convert to yaml
Message-ID: <20241007103114.1a63e3e2@xps-13>
In-Reply-To: <ZwN_2LsLep_mXUgy@gmail.com>
References: <20241006-ondie-v4-0-ff9b9fd9a81d@gmail.com>
	<20241006-ondie-v4-2-ff9b9fd9a81d@gmail.com>
	<deeflg5wd756tkfr6zdta4imuc7ijwl56yclfwiqexlqdq6jsk@5za5g6i7wj6k>
	<ZwN_2LsLep_mXUgy@gmail.com>
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

Hi Marcus,

marcus.folkesson@gmail.com wrote on Mon, 7 Oct 2024 08:29:44 +0200:

> On Mon, Oct 07, 2024 at 08:07:27AM +0200, Krzysztof Kozlowski wrote:
> > On Sun, Oct 06, 2024 at 03:05:47PM +0200, Marcus Folkesson wrote: =20
> > > +  ti,davinci-nand-use-bbt:
> > > +    type: boolean
> > > +    description:
> > > +      Use flash based bad block table support. OOB identifier is sav=
ed in OOB
> > > +      area.
> > > +    deprecated: true
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - ti,davinci-chipselect
> > > +
> > > +additionalProperties: true =20
> >=20
> > That's a final device schema, this cannot be true. Why you are doing
> > this entirely different than all other bindings? =20
>=20
> From my understanding, additionalProperties is to indicate that the
> schema could contain properties that were not explicit listed here but
> inherited from e.g. nand-controller.yaml.

additionalProperties: true means there is no control over the
properties allowed, so we generally don't want that (unless you're
writing specific "generic" bindings, which is not the case here).

You are describing a controller so here you should reference to
nand-controller.yaml, but then prevent any property not defined in
nand-controller.yaml from being used. In this case you probably want to
try unevaluatedProperties: false, which means that any property not
listed here or in the referenced schemas will be prohibited.

Thanks,
Miqu=C3=A8l

