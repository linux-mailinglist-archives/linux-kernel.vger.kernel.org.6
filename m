Return-Path: <linux-kernel+bounces-556765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCA5A5CE38
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2E217D023
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED134263F30;
	Tue, 11 Mar 2025 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSbP39JH"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741222627F7;
	Tue, 11 Mar 2025 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719092; cv=none; b=u/nsiz2/mFJXgJI1hCDUmjcCza2tMjUDoEvOwvcVqV+3KNSRDfq37ZFcdn5xCoBApC9jji8HCwiEELjBnkSsLD8hOzfoSFEKn+x2xWfnxMvDG99gP9qBN0sUn49IcF9NNUxENxcPelLdAWGXyB4tRoNSm25K9eaY6tWkj04zC4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719092; c=relaxed/simple;
	bh=Utjp1B9+j6G8YDnPqWFBWiRTRpIIJhgx2N/0heoDXcA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HD3xMFiE8qN4s18VcMbQIuqcJYwx1qKH1rrEdNXlf5iT1Uq4gbAeOnttHWCKSWfn45zEIJygovue+hbxoRZl5iPb21OelASlhd6oR2C/aduTtXdfhx00x7qm2LZQyXaKKLyuR9UAefPiamnDoVaowYdNAXTQs4wj3pA5NKr2jNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSbP39JH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso35524385e9.0;
        Tue, 11 Mar 2025 11:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741719089; x=1742323889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A+odMspnKCTRijFn9P3g8Rcr1t0EreI5zprwmnUHlKY=;
        b=GSbP39JH5voL/3+2iojR+nTqBbv9t7L2HhvmlcjtBRrrHc4WLSXG+ktkj7v0esO5p4
         zFeKlSq6K8yrGP+K7lFABcJuMfTx+sDFZ7uxc8383mB2ada7ChaOeKfN2SlXMFffyD1j
         H1cUlJMzeLcoHOX2SbIbb8HZ6YAXf1R8kqOf6mCoRqlEUwov3gY+pudRzrrn10phNb+g
         e/Q9WUQg/5r/5PdhijppE43PiWSwYk+1XCVSGY7rNINJA/EPGl4O+HtmkSnwquYAljVf
         s7YfypF6LL6xV36lRTjmYaAS7mKCUyiWuHZrafLuRVMG2pxlSG8eNyx3hgWFd2eNHC+9
         JIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719089; x=1742323889;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+odMspnKCTRijFn9P3g8Rcr1t0EreI5zprwmnUHlKY=;
        b=d4APWreboZaBfRR75JsyJMWZzb/kgzbRvpozNpaHa9paMSk+r1NakcPrfjYWGH4xlt
         eoprZ+LtKSHiXajzoqkaZtmpp6BXmPuyzTl8X4qDWo9Afw6/lRlyUB9aAJhJZSHdpXiS
         H4DSSuXGZ6DgEaMI+j+CVqDdEsbV5G7xZf5KbEOmdbhcONA0rVR9BHgHwK0e7qqFa8bZ
         IhmmUd6IUmJOaFZqxPlTlZea2oH1+b38QbPeaam+p0CxK+RJO873tlvVOQdrYAkTM3Iw
         4yyFdslZ2W/QwOZzEgVB2VGzT4JsVQn7xedF8V4rNgz6FVQykmkxFCw7RuD2rHbCpXZT
         K0CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm18xx5T2yszLnOSHGqAKPwv5LixsVaUyS7hZBX1ttgB50l+eCYs/lIcJzEdwhmarCI+79D3TJZjjg@vger.kernel.org, AJvYcCWGvjYadHNJmGXY4Imzvz+bvTbvGqHuJXYfzF+5534RpDc/P8B3Djyrpmfika9Ei+hmBJwDCrxDP1EC@vger.kernel.org, AJvYcCWQLiZoX9TuL8I6M4vpwGFN4GIVyqwGH9oITEkxrPFGAnrKhkrK80DsIe27Eo96CBZnzXx6VtXAkQqPSynh@vger.kernel.org, AJvYcCXG/SwPhi+ynVX9dDupWDpO/LEnODVJzGAG/M9ZKNuebl4KesdIIn+fvePpLO67EC8RH7NElC9n2gfW@vger.kernel.org
X-Gm-Message-State: AOJu0YxMsCK6tNUEB41T4cS98+/WoKvWR75PfsrA4CMNZmoLxVq8xdkZ
	uoS0NqBOxrF1D2je4iQxSZDbEey/AhaJZLLOC8LwbiG64btZg3mx
X-Gm-Gg: ASbGncvc4VpZRb83T/kRVO/mpT8wwzzdLqt8a9vwmfwYr+nmrEWqtmYIqmnPD3YARDL
	+lUJQYgwu81X5CmvK/IeAGPkYeu7N/BsL+H44vPtuhK2RPscGRst5hn2VqdbsJPbDGrOvhxyzIK
	T4R6+eQ09bMnvkX6weDpGK3c0WF69JGR15ttx4Fk/DGlI0JFXTjzhF4614zIIj78HgDW5mOqOda
	6mwepps/mKIJ4esowfqf0R5X8VR1qh8LKaCgJNi4Qu30ylPZSWd5tsZbmPhsoJxUWVlVLJc7KiC
	cZDZVhLniLcyTEXFtJveu6hPTI925j/WijRK+jhGnbYthfYzDkQ7Ve52gSBI9HrFC4iS84llRsS
	Ff4MzxIN/xR09
X-Google-Smtp-Source: AGHT+IHJ/p0rUk7K02/5PSbIuVcXhRWrqa5T/F5SFDgcDHsDiUclOdluiyUTfuiGgPWpQC5GN31lBQ==
X-Received: by 2002:a05:600c:4710:b0:43c:f47a:ab5f with SMTP id 5b1f17b1804b1-43cf47aac65mr90360605e9.20.1741719088409;
        Tue, 11 Mar 2025 11:51:28 -0700 (PDT)
Received: from Ansuel-XPS. (58.43.196.178.dynamic.cust.swisscom.net. [178.196.43.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfe0004sm18406539f8f.40.2025.03.11.11.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 11:51:27 -0700 (PDT)
Message-ID: <67d0862f.df0a0220.375bd.6b15@mx.google.com>
X-Google-Original-Message-ID: <Z9CGLcR4ZRwYcWKW@Ansuel-XPS.>
Date: Tue, 11 Mar 2025 19:51:25 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>, Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>, Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH 09/13] dt-bindings: phy: Add documentation for Airoha
 AN7581 USB PHY
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
 <20250309132959.19045-10-ansuelsmth@gmail.com>
 <4f16d239-f540-45d5-b67a-767b09f1c70c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f16d239-f540-45d5-b67a-767b09f1c70c@kernel.org>

On Mon, Mar 10, 2025 at 05:34:56PM +0100, Krzysztof Kozlowski wrote:
> On 09/03/2025 14:29, Christian Marangi wrote:
> > Add documentation for Airoha AN7581 USB PHY that describe the USB PHY
> > for the USB controller.
> > 
> > Airoha AN7581 SoC support a maximum of 2 USB port. The USB 2.0 mode is
> > always supported. The USB 3.0 mode is optional and depends on the Serdes
> > mode currently configured on the system for the USB port. If USB 3.0 node
> > is defined, then airoha,scu-ssr property is required for Serdes mode
> > validation.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/phy/airoha,an7581-usb-phy.yaml   | 106 ++++++++++++++++++
> >  MAINTAINERS                                   |   6 +
> >  2 files changed, 112 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
> > new file mode 100644
> > index 000000000000..39127cfb63a7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
> > @@ -0,0 +1,106 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/airoha,an7581-usb-phy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Airoha AN7581 SoC USB PHY
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +
> > +description: >
> > +  The Airoha AN7581 SoC USB PHY describes the USB PHY for the USB controller.
> > +
> > +  Airoha AN7581 SoC support a maximum of 2 USB port. The USB 2.0 mode is
> > +  always supported. The USB 3.0 mode is optional and depends on the Serdes
> > +  mode currently configured on the system for the USB port. If USB 3.0 node
> > +  is defined, then airoha,scu-ssr property is required for Serdes mode
> > +  validation.
> > +
> > +properties:
> > +  compatible:
> > +    const: airoha,an7581-usb-phy
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  airoha,port-id:
> > +    description: Describe the physical port this USB PHY refer to. A dedicated
> > +      osciallator is used for each port for the USB 2.0 Slew Rate calibration.
> 
> typo
> 
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1]
> 
> I don't understand why do you need index property here (which are
> usually not allowed).
>

Eh... As said in the description this is really to differentiate the 2
different physical port...

Each port have a dedicated oscillator for calibration and these
calibration are identified by an offset (all placed one after another in
a separate register space).

Oscillator 0 for physical port 0
Oscillator 1 for physcial port 1

And model this is a bit problematic without an additional property, any
hint for this?

> > +
> > +  airoha,scu-ssr:
> > +    description: Phandle to the SCU SSR node for USB 3.0 Serdes mode validation.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +  usb2-phy:
> > +    type: object
> > +
> > +    properties:
> > +      '#phy-cells':
> > +        const: 1
> > +
> > +    required:
> > +      - '#phy-cells'
> > +
> > +    additionalProperties: false
> 
> Also no resources in usb[23]-phy, so this goes to the parent level and
> you have phy-cells=2. Your DTS gives some hint that devices actually
> differ but the commit msg contradicts it, so I don't get. Do you have
> same IP block here or two different?
> 

SoC have 2 physical USB port.

Physical port 0 on address: 0x1fab0000
Physcial port 1 on address: 0x1fad0000

In those space there are registers to configure USB 2.0 mode and USB 3.0
mode for each physical port.

So yes no child node, phy-cells 2 and reference with phys = <&usb_phy 0
PHY_TYPE_USB2>, <&usb_phy 1 PHY_TYPE_USB3>; that totally works and hope
now the HW is more clear.

The real problematic part is the one above with identify the 2 physical
port.

> > +
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fe34c80b8d52..c2dd385e9165 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -753,6 +753,12 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
> >  F:	drivers/spi/spi-airoha-snfi.c
> >  
> > +AIROHA USB PHY DRIVER
> > +M:	Christian Marangi <ansuelsmth@gmail.com>
> > +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yam
> 
> Typo in extension/missing l.
> 
> 
> 
> Best regards,
> Krzysztof

-- 
	Ansuel

