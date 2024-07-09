Return-Path: <linux-kernel+bounces-245299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E5492B0D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0A628120E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B463F13EFF3;
	Tue,  9 Jul 2024 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="CDQMapIH"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2E513A27D;
	Tue,  9 Jul 2024 07:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720508863; cv=none; b=QazgWae7xODBTALBX1ozlbg4dpk1Z0+JZva22638fC5+qPashrYTMulR5TV5tnMxKRuYJLaqg9bj3J5dmWuYP2BMABrEK3D5mhrFpTSRoLvZ/poFbMHqZUemtEmyaXAJnGfvFxHCLxTOYqjuX0AMAPOhrKbxjoxgSw5yuHSS3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720508863; c=relaxed/simple;
	bh=T3HvSrDk2qteJMR5w2c8GDjk4fhaQNkajCHCo/XfIXs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaAX9urcCoIQPOOQ3cySUcEzPQxp1vWE6QYPv1p1TxMk6yH4PgjIGiu1K+UvkFxPJkfMWJe9keT5BW1aEem6Mpowyrl96t8af/VneOWL3DyrlGYP0ATXW1PmJAYnbn+ap43GlmYhJEL+O2JKfR5Emdw61l4zGQdTpwwpDQ+Qp6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=CDQMapIH; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id ABEC8415AA;
	Tue,  9 Jul 2024 09:07:37 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cUT17D5U45te; Tue,  9 Jul 2024 09:07:33 +0200 (CEST)
Date: Tue, 9 Jul 2024 15:07:04 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1720508853; bh=T3HvSrDk2qteJMR5w2c8GDjk4fhaQNkajCHCo/XfIXs=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=CDQMapIH2nysRPRLimL50CU32n5WdAN+AUDcY2ZL6nSlakMPRxqMbPmcjhDomyyyD
	 RFqXGs7UfWQKf17pe5MaukCJZUJcWvB6NSbcrQRzfNpye4+jHKbeYHY/q9KZQQRZEg
	 vkm45H5WJonkkUwOHbGpBLnsgqD9YfZ8VLW+aKCnzhu+M9vONG0rQih0CHk6c8YO24
	 Gl6XcFoQfU+eJlU0RUzk2VyYttS0+9DiO2Qv8TWlATCEe0+9UHifclyT2Y2hNE66kY
	 nja/fJWotyoUkKXe69kH35FmYF97mmEzSl4+zVz1aoeJhvxYtJrmgAzHjN1kUJvQEg
	 /H4B/aobgFt8w==
From: Yao Zi <ziyao@disroot.org>
To: Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: phy: add YAML schema for cv1800-usb-phy
 driver bindings
Message-ID: <ZozhanjnG2jbB5lN@ziyaolaptop.my.domain>
References: <20240708120830.5785-1-ziyao@disroot.org>
 <20240708120830.5785-2-ziyao@disroot.org>
 <IA1PR20MB495304D471AE08F75D97C25FBBDA2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB495304D471AE08F75D97C25FBBDA2@IA1PR20MB4953.namprd20.prod.outlook.com>

On Tue, Jul 09, 2024 at 06:23:58AM +0800, Inochi Amaoto wrote:
> On Mon, Jul 08, 2024 at 12:08:28PM GMT, Yao Zi wrote:
> > cv1800-usb-phy driver supports USB 2.0 phys integrated in Sophgo
> > Cv1800/SG200x SoCs. Add YAML schema for its binding.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  .../bindings/phy/sophgo,cv1800-usb-phy.yaml   | 67 +++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > new file mode 100644
> > index 000000000000..0403d899e23b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > @@ -0,0 +1,67 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2019 BayLibre, SAS
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/sophgo,cv1800-usb-phy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo CV1800 USB PHY
> > +
> > +maintainers:
> > +  - Yao Zi <ziyao@disroot.org>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sophgo,cv1800-usb-phy
> > +
> > +  reg:
> > +    maxItems: 2
> > +
> > +  reg-names:
> > +    items:
> > +      - const: phy
> > +      - const: pin
> 
> drop pin, cv1800 series does not support this.
> 
> > +
> > +  clocks:
> > +    maxItems: 4
> > +
> > +  clock-names:
> > +    items:
> > +      - const: apb
> > +      - const: 125m
> > +      - const: 33k
> > +      - const: 12m
> > +
> > +  "#phy-cells":
> > +    const: 0
> > +
> > +  dr_role:
> > +    enum:
> > +      - host
> > +      - device
> 
> cv181x series have otg support. For board with OTG,
> it should be properly handled.
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - clocks
> > +  - clock-names
> > +  - "#phy-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/sophgo,cv1800.h>
> > +    usb_phy: usb-phy@3006000 {
> > +        compatible = "sophgo,cv1800-usb-phy";
> > +        reg = <0x300600 0x60>, <0x3000048 0x4>;
> > +        reg-names = "phy", "pin";
> > +        clocks = <&clk CLK_APB_USB>,
> > +                 <&clk CLK_USB_125M>,
> > +                 <&clk CLK_USB_33K>,
> > +                 <&clk CLK_USB_12M>;
> > +        clock-names = "apb", "125m", "33k", "12m";
> > +        #phy-cells = <0>;
> > +    };
> > -- 
> > 2.45.2
> > 
> 
> You patch is duplicated, I have sumbitted patches 
> month ago and still needs some time to figure out 
> the best topology. Phy driver belongs to syscon,
> which make things kind of complex.
> 
> https://lore.kernel.org/all/IA1PR20MB4953C1876484E149AA390DD5BB1D2@IA1PR20MB4953.namprd20.prod.outlook.com/#t

I didn't check that, sorry for the noise.

Best regards,
Yao Zi

