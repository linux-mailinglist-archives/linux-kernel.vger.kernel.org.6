Return-Path: <linux-kernel+bounces-350645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727DC9907FD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39321B2AA28
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFB31DF84B;
	Fri,  4 Oct 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="iD5JhKCo"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637DF1DEC04;
	Fri,  4 Oct 2024 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055867; cv=none; b=FSEVcS9jPoV9ehCuOojIb3TZYK2kk7FKCv+L6AaAYSp4oOd1f2TPt2CwL15KG56shZuQqClpcVAtUnETp83JTtecFUyTVL0Kv+2seLIzZOqWTcDXBfpDFcXTI9CYrIcKRXJpZZNdOmLLKUxmYU4waRE/8OfXQ2paQGOc/tbR9jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055867; c=relaxed/simple;
	bh=hRUT7x36WL1tH8NnlxWOKwKJUK8woiG3Vticu4lEW14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umGxTt1E74B8mu34QBRmJWxRollu4xcQEU8ayTb+1NzJEe5wFyWKriB6SWoC4M22BAYgahuY+Ntqg+a2QH0LWrRCePXaLKb+jXwYMeOVUwVK95SNmzYkKti+4wEZw+uoALsVXdDSFY7z/+Eas29OZxXZ3ScZAy/TD2bSpBxYNRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=iD5JhKCo; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 95F5720B47;
	Fri,  4 Oct 2024 17:31:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1728055864;
	bh=ccGcztWl7U3odd6O5dl9JTlXWZfdzQE/tBihuERy8RE=;
	h=Received:From:To:Subject;
	b=iD5JhKCoqsX41ju9bSHYiWRvUxeinPJ53MZus4UK5Oo9fC2WvLR/J8BK3GCyW9mTJ
	 8JWa2knjTQ/xd6Fy06CW9kDQIgurEXQw5cpeRKCyfgOQFEkHGNfQ0P37alocBDPGef
	 0l5CdSG0IBAU7+YwbztYpTi12H6HtQE1kunh1svSG7mcN+vwIJjSfFoY/ya7ELsIsu
	 egcTR20emIcfx1Ht5NlHk4js4jyIyBcEmgaS/tYbJiCIe+qELO/MYLUdGR4pFl/Ykr
	 PP7Z0EGXo9ufFfU7Wh4E1eox7DqiB+jAcX8UasLzkBD/cTGAFCntT7Ul+QBpA/4oQJ
	 fT5gX5HPJNGoA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 389837F96B; Fri,  4 Oct 2024 17:31:04 +0200 (CEST)
Date: Fri, 4 Oct 2024 17:31:04 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Conor Dooley <conor@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: usb: add TUSB73x0 PCIe
Message-ID: <ZwAKOKQ96sCoxsMN@gaggiata.pivistrello.it>
References: <20241004124521.53442-1-francesco@dolcini.it>
 <20241004124521.53442-2-francesco@dolcini.it>
 <20241004-calzone-sitcom-0f755e244497@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004-calzone-sitcom-0f755e244497@spud>

Hello Conor,

On Fri, Oct 04, 2024 at 04:23:18PM +0100, Conor Dooley wrote:
> On Fri, Oct 04, 2024 at 02:45:20PM +0200, Francesco Dolcini wrote:
> > From: Parth Pancholi <parth.pancholi@toradex.com>
> > 
> > Add device tree bindings for TI's TUSB73x0 PCIe-to-USB 3.0 xHCI
> > host controller. The controller supports software configuration
> > through PCIe registers, such as controlling the PWRONx polarity
> > via the USB control register (E0h).
> > 
> > Similar generic PCIe-based bindings can be found as qcom,ath11k-pci.yaml
> > as an example.
> > 
> > Datasheet: https://www.ti.com/lit/ds/symlink/tusb7320.pdf
> > Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >  .../bindings/usb/ti,tusb73x0-pci.yaml         | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml b/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> > new file mode 100644
> > index 000000000000..bcb619b08ad3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> > @@ -0,0 +1,60 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/ti,tusb73x0-pci.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TUSB73x0 USB 3.0 xHCI Host Controller (PCIe)
> > +
> > +maintainers:
> > +  - Francesco Dolcini <francesco.dolcini@toradex.com>
> > +
> > +description:
> > +  TUSB73x0 USB 3.0 xHCI Host Controller via PCIe x1 Gen2 interface.
> > +  The TUSB7320 supports up to two downstream ports, the TUSB7340 supports up
> > +  to four downstream ports.
> > +
> > +properties:
> > +  compatible:
> > +    const: pci104C,8241
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  ti,tusb7320-pwron-polarity-invert:
> 
> To me, "polarity-invert" makes less sense than calling this "active-high"
> making the property a flag. active-low would then be the case where the
> property is not provided. Given you don't make the property required,
> what you've got here is effectively a flag anyway.

We had the same doubt when deciding which property name to propose, looking
at the existing bindings it seemed that "polarity-invert" was more common.

FTR the datasheet explicetly name the signals with a # suffix (PWRON1#,
PWRON2#, ...), they are defined as active-low by default.

With that said, if we prefer to have `ti,tusb7320-pwron-active-high`, I am 100%
good with it.

Francesco


