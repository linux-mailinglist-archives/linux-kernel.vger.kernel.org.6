Return-Path: <linux-kernel+bounces-239311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C0A925F25
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C69BEB2F039
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3AB17C223;
	Wed,  3 Jul 2024 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kn0Xavx1"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04902172798;
	Wed,  3 Jul 2024 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003372; cv=none; b=aS+yHD59NUrfAw9x5Y88UI7ZHd8BHCTVYz2O7xMLZr51cYV0SlbZNIqmIywgZZoFD2ffd9VTBmB8YkCR0gw11iK0WOg8ThdbVTttqqKNaINgu/8P5tbZj/jIJ8XFk6SWS+w2dqEtC1dmks0lUIEfwtJUPXizo7+G2D4hovxM42Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003372; c=relaxed/simple;
	bh=3cfOFBtgSSaF4cSn4MpRGAygi+1KrqpFeLc5bisuTrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7LJoUtlOD31O0T4P3PO3tZsdBHz4uClDfsFAvrNdSpBl7+Ub+qs7Yl4WMt8sGOcUr6+1TOoLhvRMOI6vpzmCZ4SrdNDv6YXqGHK7z9k7vK48HVkPmRjWPANI4ak4MGZ1JtcYLqjojidS/AG6NkQNAmBiKcUVUNkDAUsABMH4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kn0Xavx1; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0A411C0003;
	Wed,  3 Jul 2024 10:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720003362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JD7lzSbNvDLaEngDHvpQyOlHXKS5REtsvCW8NYDsEt0=;
	b=Kn0Xavx1zSLZ8bgamyqsUbcFuSL5EOFzlejUwiPrFqdzY+YqYx3jZ4VKvVxAeoiAW/ZOur
	IFJNzqbm01fG+4stjXyofsaH7WyZOTpt9qh5/4Udv6jl6o0KG4wVhsUCji76EN5ZgTAjJj
	H/qW9msg5B5nv8sEjz7sFN53f6/JuCF5EziR19UutXQT8OGkcF8yxGfZ6W82JVyNZVRLx8
	gNjGqez4Jb1UNCulg4Z3ymy0PyqKqGth44pfUdHm1UNrAFb2kTp5kbF1RoY/LGTaGXvI2Y
	TBbcsYBYl6tzHiDfY0xeU9zgK8uEC3Fl1vwDJM2zWNe7iqxQuE3lWiKBTX++CA==
Date: Wed, 3 Jul 2024 12:42:36 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Saravana Kannan <saravanak@google.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH 1/2] of: property: add of_property_for_each_u64
Message-ID: <20240703124236.6f505329@booty>
In-Reply-To: <20240628161617.6bc9ca3c@booty>
References: <20240621-clk-u64-v1-0-d28a611b2621@nxp.com>
	<20240621-clk-u64-v1-1-d28a611b2621@nxp.com>
	<20240627214355.GA601888-robh@kernel.org>
	<AM6PR04MB59416E3C8FFC904450F3B02D88D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
	<AM6PR04MB5941D30C26F2CB818FEC082C88D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
	<20240628161617.6bc9ca3c@booty>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Peng,

On Fri, 28 Jun 2024 16:16:17 +0200
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

[...]

> > > > > +#define of_property_for_each_u64(np, propname, prop, p, u)	\
> > > > > +	for (prop = of_find_property(np, propname, NULL),	\
> > > > > +		p = of_prop_next_u64(prop, NULL, &u);		\
> > > > > +		p;						\
> > > > > +		p = of_prop_next_u64(prop, p, &u))    
> > > >
> > > > I think we want to define this differently to avoid exposing struct
> > > > property and the property data directly. Like this:
> > > >
> > > > #define of_property_for_each_u64(np, propname, u) \
> > > >   for (struct property *_prop = of_find_property(np, propname, NULL),
> > > >          const __be32 *_p = of_prop_next_u64(_prop, NULL, &u);
> > > >          _p;
> > > >          _p = of_prop_next_u64(_prop, _p, &u))    
> > 
> > This will trigger a compilation error, because C not allow
> > declare two variables with different types as for loop expression 1.
> > Need to think about other methods.  
> 
> I have a working draft here where I solved it somehow, let me just find
> the proper branch and send it. Perhaps next week, but I'm striving to do
> that by Mon-Tue.

Ok, that slipped to Wednesday, but here it is:
https://lore.kernel.org/all/20240703-of_property_for_each_u32-v1-1-42c1fc0b82aa@bootlin.com/

I think you can reuse the technique I used in that patch to write
of_property_for_each_u64(np, propname, u), taking only 3 parameters.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

