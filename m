Return-Path: <linux-kernel+bounces-371829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2375A9A40F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F351F2481F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41691F4267;
	Fri, 18 Oct 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="lVIzDg8I"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C7D6BFCA;
	Fri, 18 Oct 2024 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261141; cv=none; b=fNthKOBW/Ze+QCVbdgeOpiTcE+y2vGZJFE1thjkx3Z+iHDr6dLtlyzyvDZY7o3IqS65hsWMa5axODTXDiJDJtSKdW6hGsr6TQWL0gNUb/XU/eSdpWg480GoR4AQeOB0Oy2Chbwylp3KdZetlXLMvpowfwHU/ilgpyMHd6C+BwwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261141; c=relaxed/simple;
	bh=8Ay7Hj5OZgQ7MGqy5i7LUi6fdznUG66vs92kGE3WWYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOYRiisZPma4zQELGQ3AuIM34WWL6R6Q8tfiumNysd8fSUsxw/WIMOXB1YSlhJUsumcb6F8Hcd6sr2IyUtoekLTAhBAiohjtNn4tbqoDtojkXr+/soOq1tyCBbXo5A7wFTKH8NkrPICWU5ns5GXuKa5ILGxCTyA7kDPv/8WLsMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=lVIzDg8I; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id C43E222909;
	Fri, 18 Oct 2024 16:18:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1729261127;
	bh=kMMaRKGZ6ngPRcX/Zv1+XoEwbVnv1U3vYYkh/ZUsUq0=; h=From:To:Subject;
	b=lVIzDg8IpqceAxis4t3wHm1bshLDCxgQPc5pmoqr2JPPeiSaNw5L3Ve46BZy8+3ke
	 ycfUJ4U0U3vp/ixn38OEX4uH0d+Eb0cTYaaoNBo2O0vzMuw+TrSJ4x5ntoxZLx0Hqu
	 tZBh1RDZHy4lTk0IojP80p/RhJroVtAf2LNBVV7TWyZhmeRIojL88qEvN30KJXHxj8
	 ggUhurQe5IzDObqOKt03yl+2ScczfA0HJ/sK81tskGwUXbyGTtMDQ9ozjhxRUJNrqi
	 zM3kVl1i/LtLg5sFN3S3IastDgMx5QZAntIw5jvsmQ0y0NyzXheTWBpcOCNk4SMAB5
	 SOrF8qidLj9Lw==
Date: Fri, 18 Oct 2024 16:18:42 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: add TUSB73x0 PCIe
Message-ID: <20241018141825.GA46391@francesco-nb>
References: <20241018105505.28005-1-francesco@dolcini.it>
 <20241018105505.28005-2-francesco@dolcini.it>
 <20241018140743.GA98324-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018140743.GA98324-robh@kernel.org>

Hello Rob,
thanks for the review.

On Fri, Oct 18, 2024 at 09:07:43AM -0500, Rob Herring wrote:
> On Fri, Oct 18, 2024 at 12:55:04PM +0200, Francesco Dolcini wrote:
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
> > v3: use lowercase hex in compatible
> > v2: rename property to ti,tusb7320-pwron-active-high and change type to flag
> > ---
> >  .../bindings/usb/ti,tusb73x0-pci.yaml         | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml b/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> > new file mode 100644
> > index 000000000000..7083e24d279c
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
> 
> XHCI controller, should be referencing usb-xhci.yaml.
> 
> > +
> > +properties:
> > +  compatible:
> > +    const: pci104c,8241
> 
> 2 parts mentioned above, but only 1 PCI ID?

Exactly. Let me know if there is something we should do in this regard
(something in the commit message? or in the description?).

From the datasheet:
  This 16-bit read only register contains the value 8241h,
  which is the device ID assigned by TI to the TUSB73X0

And one more confirmation, in the Linux code you have quirks for this
device that just check for a single device id:

drivers/usb/host/xhci-pci.c:459
  if (pdev->vendor == PCI_VENDOR_ID_TI && pdev->device == 0x8241)         
    xhci->quirks |= XHCI_LIMIT_ENDPOINT_INTERVAL_7;                 

Francesco


