Return-Path: <linux-kernel+bounces-336670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB26C983F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63560B21DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37A1145B27;
	Tue, 24 Sep 2024 07:24:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC77D146017
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727162689; cv=none; b=TwtRUdi+D4xDGY0xZbuO8ibZ29m9iHIeiGveqYM4GX7t5ywvTG2lAHPqjVQSEH8X4Y/eIYgXWoNkUGHtz7/1mDgwGD/uItBQXaUg3lWpxob2fBrS0lL4Wxfy55WrSID5hW45eatQKYCPmnXG6MDAKmv836sC6NBv78XC594lhxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727162689; c=relaxed/simple;
	bh=d15sbK686HNNoIYxHbjwubLOhx1YnkTojjBqukM43D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfwKRYatfL500hN6oGYBO0wqlTWPeN4RJA0Nq76baQqrm7QXLpo19PnbIlmwrZBfmLsmd0KIfFdv1Lyl8vtpdNd59DejymAgPMy7EAu8pz7zqBe/M7405RIdpaHX8ivzm86jck58kKZPY+aF309gYa9MaFwHfEC0bxjpVr2wEvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1sszuX-0001bn-U3; Tue, 24 Sep 2024 09:24:37 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1sszuW-0018ph-Vd; Tue, 24 Sep 2024 09:24:36 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1sszuW-009Mh0-2n;
	Tue, 24 Sep 2024 09:24:36 +0200
Date: Tue, 24 Sep 2024 09:24:36 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>, Petr Benes <petr.benes@ysoft.com>,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>, imx@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Herburger <gregor.herburger@ew.tq-group.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] dt-bindings: usb: Add Diodes Incorporated
 PI5USB30213A Type-C Controller
Message-ID: <20240924072436.gya7hvmlpb7fk5ou@pengutronix.de>
References: <20240923151417.1665431-1-michal.vokac@ysoft.com>
 <20240923151417.1665431-4-michal.vokac@ysoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240923151417.1665431-4-michal.vokac@ysoft.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-09-23, Michal Vokáč wrote:
> From: Petr Benes <petr.benes@ysoft.com>
> 
> Diodes Incorporated PI5USB30213A Type-C Controller supports host,
> device, and dual-role mode based on voltage levels detected on CC
> pin. Supports dual differential channel, 2:1 USB 3.0 Mux/Demux,
> USB Type-C specification 1.1.
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Petr Benes <petr.benes@ysoft.com>
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
> v3:
> - Collected R-b tag from Krzysztof.
> v2:
> - Moved maintainers before description: block.
> - Used full paths for references.
> - Removed unneeded items form connector property.
> - Fixed example.
> 
>  .../bindings/usb/diodes,pi5usb30213a.yaml     | 88 +++++++++++++++++++

I suppose the driver is part of an other patchset?

Regards,
  Marco

>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml b/Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml
> new file mode 100644
> index 000000000000..054a5409bd15
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/diodes,pi5usb30213a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PI5USB30213A Type-C port controller
> +
> +maintainers:
> +  - Petr Benes <petr.benes@ysoft.com>
> +
> +description:
> +  Diodes Incorporated PI5USB30213A Type-C Controller supports host,
> +  device, and dual-role mode based on voltage levels detected on CC
> +  pin. Dual differential channel, 2:1 USB 3.0 Mux/Demux, USB Type-C
> +  specification 1.1 compliant.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - diodes,pi5usb30213a
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  connector:
> +    type: object
> +    $ref: /schemas/connector/usb-connector.yaml#
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - connector
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      typec@d {
> +        compatible = "diodes,pi5usb30213a";
> +        reg = <0xd>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_typec>;
> +        interrupts-extended = <&gpio1 5 IRQ_TYPE_LEVEL_LOW>;
> +
> +        connector {
> +          compatible = "usb-c-connector";
> +          label = "USB-C";
> +          vbus-supply = <&reg_typec>;
> +          power-role = "source";
> +          data-role = "dual";
> +          typec-power-opmode = "default";
> +          pd-disable;
> +
> +          ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +              reg = <0>;
> +
> +              usb_con_hs: endpoint {
> +                remote-endpoint = <&typec_hs>;
> +              };
> +            };
> +
> +            port@1 {
> +              reg = <1>;
> +
> +              usb_con_ss: endpoint {
> +                remote-endpoint = <&typec_ss>;
> +              };
> +            };
> +          };
> +        };
> +      };
> +    };
> -- 
> 2.43.0
> 
> 
> 

