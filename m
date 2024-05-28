Return-Path: <linux-kernel+bounces-192313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB648D1B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4471F22413
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F44502B9;
	Tue, 28 May 2024 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xvT/UzH7"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B537816D9B2;
	Tue, 28 May 2024 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899874; cv=none; b=l31O/Fxp4jciGmuAKlOQAvbgZSOXaDLYPoz+mjalBw+VIsm0OZHsBUkVJaTITYhLHcKum89oukpfXCP0KQ6Mx3dSZGsJjcbYVUWqfDwFT/2E3zIZCQ/bPOBs+PDuyPjd/l890OlzIe0KhdgjTlzDcMfoN9UJc7/LfMt+H2o8V+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899874; c=relaxed/simple;
	bh=jjXOSZzea0dJ/w6k/SihOsVeOimaoaFLh2JwNccdFJo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbwCWsmcsxQT9QrcMjnh4YF5cBMIaTDcwIIQzWpxtN2vDQk93/mqhlVTnDI4w3N/mOeJ33qIOuBaCBRRCnRCNAsK2R8rEyBBB6w3wJ6KRlpQVTH+eIN6R5XjXUuCcx5UfiBl9f+0b/ESuNzhxJn5yS00NykQthm9oNoxRWaKVHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xvT/UzH7; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44SCbj75082033;
	Tue, 28 May 2024 07:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716899865;
	bh=xB4oHCBXlCixPnhQKwd1AgKNVCDeboxcnPDhFRE5cxg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=xvT/UzH7ybH1j4jrRLqvFF+Q3yi2ykOaiscLtPbqMAFYDmQyHS3rSFIHrp4d5Oj11
	 6r7wBbF9OAxC36owvIkfOiewrvvwB9xMVwK1cykRZDyz7u8NEmoDaDC6BuC2IgD+GD
	 1y0yefsUB716dTIip/qUwHl0g8JuNXqykyzP+jGY=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44SCbjxn073938
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 May 2024 07:37:45 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 07:37:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 07:37:45 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44SCbiHe076753;
	Tue, 28 May 2024 07:37:45 -0500
Date: Tue, 28 May 2024 18:07:43 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <afd@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v3 2/7] arm64: dts: ti: k3-j722s-main: Redefine USB1 node
 description
Message-ID: <ae766f18-3b56-4667-837b-eb51694106a4@ti.com>
References: <20240524090514.152727-1-s-vadapalli@ti.com>
 <20240524090514.152727-3-s-vadapalli@ti.com>
 <f52d9569-a399-422f-9cf0-b0bf69b64d18@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f52d9569-a399-422f-9cf0-b0bf69b64d18@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, May 28, 2024 at 03:15:53PM +0300, Roger Quadros wrote:
> 
> 
> On 24/05/2024 12:05, Siddharth Vadapalli wrote:
> > From: Ravi Gunasekaran <r-gunasekaran@ti.com>
> > 
> > USB1 controller on J722S and AM62P are from different vendors.
> > Redefine the USB1 node description for J722S by deleting the
> > node inherited from AM62P dtsi.
> > 
> > Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> > v2:
> > https://lore.kernel.org/r/20240513114443.16350-3-r-gunasekaran@ti.com/
> > No changes since v2.
> > 
> > v1:
> > https://lore.kernel.org/r/20240429120932.11456-3-r-gunasekaran@ti.com/
> > Changes since v1:
> > - The entire node which was added in k3-j722s.dtsi in v1 in now moved to
> >   k3-j722s-main.dtsi as USB is a main domain peripheral.
> > - Used generic node names - renamed "cdns-usb@f920000" to "usb@f920000".
> > 
> >  arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 39 +++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> > index 0dac8f1e1291..b069cecebfd9 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> > @@ -6,6 +6,13 @@
> >  
> >  #include <dt-bindings/phy/phy-ti.h>
> >  
> > +/*
> > + * USB1 controller on AM62P and J722S are of different IP.
> > + * Delete AM62P's USBSS1 node definition and redefine it for J722S.
> > + */
> > +
> > +/delete-node/ &usbss1;
> > +
> 
> This is odd and indicates issues with current DT file inclusion.
> We need to split out the non common IPs (e.g. USB) out of the common k3-am62p-main.dtsi file Maybe call it k3-am62-main-common.dtsi.
> Only keep am62p specific stuff in k3-am62p-main.dtsi.
> 
> Include k3-am62-main-common.dtsi and k3-am62p-main.dtsi for AM62P
> Include k3-am62-main-common.dtsi and k3-j722s-main.dtsi for J722S
> 
> This way you don't need to call /delete-node/

Ok. I will move the common nodes between k3-am62p-main.dtsi and
k3-j722s-main.dtsi to "k3-am62p-j722s-common.dtsi".

Regards,
Siddharth.

