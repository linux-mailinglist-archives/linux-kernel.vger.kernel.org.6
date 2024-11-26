Return-Path: <linux-kernel+bounces-422724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A780D9D9D78
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CC9EB22A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB191DE3C6;
	Tue, 26 Nov 2024 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="nNKsGBwJ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84981DDC2E;
	Tue, 26 Nov 2024 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646329; cv=none; b=cu0Wwru812loD228kVx1WxFt+iFqM7le+l5KmMynBuayIGyhK1Ebm1y4ONnmvrUA+8a906f5Aj9pRiaF8FFUuXveod4yz2owqRh4Hk11XfjfL9iKSePKoNtC8goYiRoMLdsroJad9csRpiNE7xw4aepm7TsM7X5+VWyZ3zczTU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646329; c=relaxed/simple;
	bh=WF2kD0uauhNnv+LJVMUjayi5hLvlleH3s9M/QWdlbpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWJYZ6IurzkntsV5TktGuKwrxPKYjjy04182YTE3N5IlA3eouZCLc/0DQa/WR6WGzahJPaj+41LAESlKmxRDitvN0/gb+yKww2+mJl0UCtOYqVuFKVxl/5pgv+8HCAIo9ypKwJQrNUMIx5zsh1Z7J9SwdSX5Qdc4Pn6c2mY0JBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=nNKsGBwJ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VgLIPHtecoQLiuBn73bXhufyb7gzXXwP1OGjk0QrpHs=; b=nNKsGBwJu/r9fx0Q1fY7RHGlJQ
	ZyI9VvC/R5Gkb8aMPEx13u13Fs8ckw6GAgDxy/S8x4t9639CVWQXtitJcWcDHQH1LGrj7KVsb3pdR
	1Hscx1ec575QUNz+CwYGpw1qqe5pzip9UELNmSQSCTg3JvXSuG5EQXh7jvgB4UaFoM18buaOrSXEV
	B8FzjeUx+JQ6ifAQbDqMezIY3fv3t0pMWHYKGDhee02CXqjE/o86nKVxLLZlpRF2FFTbitNFpLapQ
	/k5h7o96sWC7f9stU9VGk96E0Cn/oMJsQ5InA/anUd1NrFPn+FuXkhzVS4hZanQroJxynfjsi1/Et
	7ClTyF6g==;
Received: from i5e86190f.versanet.de ([94.134.25.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tG0SK-0002U1-1g; Tue, 26 Nov 2024 19:38:36 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Conor Dooley <conor@kernel.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, quentin.schulz@cherry.de,
 sebastian.reichel@collabora.com, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 dse@thaumatec.com, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH v4 1/2] dt-bindings: phy: Add Rockchip MIPI C-/D-PHY schema
Date: Tue, 26 Nov 2024 19:38:35 +0100
Message-ID: <2213231.Mh6RI2rZIc@diego>
In-Reply-To: <20241126-pastrami-gusty-8b9df32ae00c@spud>
References:
 <20241126131736.465111-1-heiko@sntech.de>
 <20241126131736.465111-2-heiko@sntech.de>
 <20241126-pastrami-gusty-8b9df32ae00c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hey Conor,

Am Dienstag, 26. November 2024, 18:44:14 CET schrieb Conor Dooley:
> On Tue, Nov 26, 2024 at 02:17:34PM +0100, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> > 
> > Add dt-binding schema for the MIPI C-/D-PHY found on
> > Rockchip RK3588 SoCs.
> > 
> > Tested-by: Daniel Semkowicz <dse@thaumatec.com>
> > Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> > ---
> >  .../phy/rockchip,rk3588-mipi-dcphy.yaml       | 87 +++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
> > new file mode 100644
> > index 000000000000..c8ff5ba22a86
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
> > @@ -0,0 +1,87 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/rockchip,rk3588-mipi-dcphy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip MIPI D-/C-PHY with Samsung IP block
> > +
> > +maintainers:
> > +  - Guochun Huang <hero.huang@rock-chips.com>
> > +  - Heiko Stuebner <heiko@sntech.de>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - rockchip,rk3576-mipi-dcphy
> > +      - rockchip,rk3588-mipi-dcphy
> 
> How many phys do each of these SoCs have?

- rk3588 has two - each with a separate GRF for additional settings [0]
- rk3576 has one


Heiko

[0] https://lore.kernel.org/lkml/D5F5C1RWVHG5.TSHPO29TXYEF@cknow.org/T/
The register layout in each GRF area is identical, but each DC-PHY gets
its own separate GRF io-mem block.



