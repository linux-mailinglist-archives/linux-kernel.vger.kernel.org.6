Return-Path: <linux-kernel+bounces-172039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30CE8BEC51
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 21:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8581F25FEB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EF116DEAA;
	Tue,  7 May 2024 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJTeUt+v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8785D14D2BE;
	Tue,  7 May 2024 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108911; cv=none; b=j4kThj/xl61MqXor5Ksf2IjuouQzIhhUDiB9i91rvoz6ENeV56Sn3Ffu6FvKzcXeZ29GwAkYnXopVQGPmIJ8pjJHh8jd5daP/ghIhe3tlNkVCo4bViFTskk8RJmOoIVCLqhicSEmI18bnfWDJtJnuGjTdrxJypVTCVfMIzzve3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108911; c=relaxed/simple;
	bh=Z+Gs4K1iFlTKEsI/ZJ2cPV1zHuwnpGQ6xDGnZ/DD6bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKVxmhzs6Of9YrbRAJ2CZe4fV3OU2IrtBvDy/sJ9854W1i6vJeN44wDQZmqO4e8cf4atAiO6tpYoo+c9jPNXCYbOGxWq3ivxCV+DNQP6z6wT/uaGrKk/LIS4GMwo/PcOAAvhC+QQGj3pWuWdOc8r5QSiXYcMiTo3DlWkoHLrEA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJTeUt+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C717BC2BBFC;
	Tue,  7 May 2024 19:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715108911;
	bh=Z+Gs4K1iFlTKEsI/ZJ2cPV1zHuwnpGQ6xDGnZ/DD6bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJTeUt+vJycbfnEVNS1ZdMopYgv8iosNhuG2fz/gb1xJymTpq+6OzvzQZrTsYtAOK
	 LVn7kECHrDAeg6B0+vBuyuXqdw2diKiI+yQyLsqflS8Oj0EdjeLM//yoH+n4LahIWX
	 ZCOf33/p5o5gYo4sqmlu+KWU+6t7ihgu7/ttIGAEUnUp3O+/U92f29lpdQ3OhF9jtt
	 RaB4IYnzF3RYyKv5UrBjJOd4tN8u//NTAdiYXLDw4CiJKUxKOGsClT+QIa99BGdle1
	 k9SIwsUGxBEoAcqpoy97EZqTZFbqhh8iHvIeVZyJhy1ltRPZBUWZnnnoWVE+6Oc96g
	 PiOjnKd4xIGLw==
Date: Tue, 7 May 2024 14:08:29 -0500
From: Rob Herring <robh@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: Add Sophgo CV1800 USB phy
Message-ID: <20240507190829.GA880949-robh@kernel.org>
References: <IA1PR20MB4953C1876484E149AA390DD5BB1D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953612130BFC78A8E92F6C5BB1D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <595f76bf-5e89-4027-87e5-ff316c699669@kernel.org>
 <IA1PR20MB4953FC99B680A3040D4CB611BB1C2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953FC99B680A3040D4CB611BB1C2@IA1PR20MB4953.namprd20.prod.outlook.com>

On Mon, May 06, 2024 at 08:17:30PM +0800, Inochi Amaoto wrote:
> On Mon, May 06, 2024 at 08:51:59AM GMT, Krzysztof Kozlowski wrote:
> > On 05/05/2024 03:52, Inochi Amaoto wrote:
> > > The USB phy of Sophgo CV18XX series SoC needs to sense a pin called
> > > "VBUS_DET" to get the right operation mode. If this pin is not
> > > connected, it only supports setting the mode manually.
> > > 
> > > Add USB phy bindings for Sophgo CV18XX/SG200X series SoC.
> > 
> > ...
> > 
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: phy
> > > +      - const: app
> > > +      - const: stb
> > > +      - const: lpm
> > > +
> > > +  vbus_det-gpios:
> > 
> > No underscores.
> > 
> 
> Thanks.
> 
> > > +    description: GPIO to the USB OTG VBUS detect pin. This should not be
> > > +      defined if vbus_det pin and switch pin are connected, which may
> > > +      break the VBUS detection.
> > 
> > Why is this property of the PHY? VBUS pin goes to the connector, doesn't
> > it? It looks like you combined two or three (!!!) bindings into one.
> > 
> 
> Yes, but I am not sure which is the best to write this bindings.
> The topology of USB likes this:
> 
> controller -- phy -- switch --> (host) port/hub
>                             --> (device) port
> 
> The vbus-detect connect to the device port, but it will change the mode for
> both phy and switch. And the switch is just a switching circuit.
> I am pretty confused on how to split this binding. I think it may like the 
> following:
> 
> phy {
> 	switch {
> 		/* This is the switch in the follows */
> 		connector1 {
> 			/* host port */
> 		};
> 		connector2 {
> 			/* device port*/
> 			/* the vbus pin is here */
> 		};
> 	};
> };
> 
> Could you share some suggestion on this?

Something like the above assuming 2 physical connectors, but probably 
should be a child of the USB controller or on its own. PHYs usually 
aren't put into a parent/child hierarchy, but are out of band.

Is this switch implemented on the board level? If so, you should create 
something that would work on any platform with a GPIO controlled USB 
switch like this. 

Rob

