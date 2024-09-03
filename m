Return-Path: <linux-kernel+bounces-312382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4A89695D4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014D11F2462E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B2C1DAC4D;
	Tue,  3 Sep 2024 07:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ai0OzXBZ"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD211A265F;
	Tue,  3 Sep 2024 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349253; cv=none; b=EO78w/1HAlv8h3vGLjhoC7bBEk9FsfSM6vyMbEYlDKhUuTonnn8bGASbVZX+sZNnBdCcYfNmL7X0++JF2+nYd2iuy4+vnmoGo+i9NBTylyUX+tDP0U5HeLZwyXZK+S48ohS84Gey+Mtz4xb/0BkGR/IlDizj1uQifX2xikcrK4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349253; c=relaxed/simple;
	bh=ABju+G8oJcVFP5Bx0teI15nb6ayKqOQ1KPnlmaykFF0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpkc09ps4bNj9K1nxpVZPUKmFxklTda9l1p/9uSqULX7/VEbTeJnjF1cs5i+xVd+F58voQcZWrVmwHFlZqS4obTcCR1nNDBdPGPGFocrJMyBMDu897rhKFgHm3vMSl8Vvd2TFF8lxla85aOhE7i1APsEKH5LepirdRN9kYdRatw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ai0OzXBZ; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4837ecfG125831;
	Tue, 3 Sep 2024 02:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725349238;
	bh=ShMOuKgW3MQjXcAOYLpp85nuqNGLp7jxKD/ZyYactVc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=ai0OzXBZa+BpvWWvQriNdwgne8qdz85F+TR+TSGPNkCT6JX+vu2Lj7QlvEWWyoytB
	 rStF+O/+bDNd4s/T+8QrUHJyPad73wZ79+mR6G4rV0BilKH5cVqDLE9igXO8xR7Jb3
	 4YU51Ezt1uCl29ABO+PMwtsmNHnDO319jB+Z1S9Q=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4837echE119205
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Sep 2024 02:40:38 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 02:40:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 02:40:37 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4837ea7t018442;
	Tue, 3 Sep 2024 02:40:36 -0500
Date: Tue, 3 Sep 2024 13:10:35 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi
	<b-padhi@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 3/5] dt-bindings: arm: ti: Add bindings for J742S2
 SoCs and Boards
Message-ID: <20240903074035.6bfo4ztxjdumirzo@uda0497581>
References: <20240902-b4-upstream-j742s2-v6-0-6a7aa2736797@ti.com>
 <20240902-b4-upstream-j742s2-v6-3-6a7aa2736797@ti.com>
 <da17b246-13de-4473-8f73-a29c20467082@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <da17b246-13de-4473-8f73-a29c20467082@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Siddharth,

On 12:28-20240903, Siddharth Vadapalli wrote:
> On Mon, Sep 02, 2024 at 05:56:51PM +0530, Manorit Chawdhry wrote:
> > Add devicetree bindings for J742S2 family of devices.
> > 
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Beleswar Padhi <b-padhi@ti.com>
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> > 
> > Notes:
> >     v6: No change
> > 
> >  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > index 5df99e361c21..b0be02f9d125 100644
> > --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > @@ -144,6 +144,12 @@ properties:
> >                - ti,j722s-evm
> >            - const: ti,j722s
> >  
> > +      - description: K3 J742S2 SoC
> 
> Is it J742S2 or J742s2? The naming seems to be inconsistent considering
> that it is a lowercase 's' for J784s4 below.

Even am not sure... I see the above one using J722S and there are
examples like AM62A7 as well, can see the majority being capitalized.
The delta's are AM62x, J784s4 and J721s2. I believe they should be
capitalized correctly if we need to go for any change.

Regards,
Manorit

