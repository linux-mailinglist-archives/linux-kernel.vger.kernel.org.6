Return-Path: <linux-kernel+bounces-312279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D12E596946C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A811C23055
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7511D6DC0;
	Tue,  3 Sep 2024 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MIP+ydZr"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA101D61B8;
	Tue,  3 Sep 2024 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346719; cv=none; b=KTPzf5O22QWpMQIYA3vkz6NN+ekH1Iqq/d8NPxeaKnd+ng4aQQPzfpYbvhfa0MHAnymWE24tZwKp5ybgRbiByCOGfwiPLxvUxOR7iuEH5rDByqIN+lVMqwfLxME/ftjbKFXsgNhWE6HjDi96k8LoFYb8RPOPDIF/UBGzHLlhA9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346719; c=relaxed/simple;
	bh=bIS19lMtHeOrnpD3tHXVlWbdXhU7EUk6GpOiiPc4fkE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpz9JpTRo8hfw/OLK+nDDsfe6ox/gGUWCM+0FIxfh5ZG/2dELnAMQocdn7rGHPYbDLKdjsBs1NW4g3VULA1NATlLOAMk7n9Ga0V2tcoTFVCjrXCBhnKWBO/pLbuCLXyAp14HC77QTjF+1bbvxSoFvyA+LNv7GUQPCpCbUcCIvms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MIP+ydZr; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4836wNS9111883;
	Tue, 3 Sep 2024 01:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725346703;
	bh=7QS/PP+dEulS9kB1nTQtMHUpd4L7Wp9gyX90/Aocf1g=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=MIP+ydZrrFcs8UKfYRRA6Nz3BE9U90yHy8kbCQ/q2zDzupQDDQF9pLCLMP5i7mYhj
	 OcidhjH++y2pHn6NxUjdKVrO3PqXG2ZqO4gCWDhoxl4XUj4h06ncMZ0sKQ3zlgC/7E
	 W5Ug//OuQzlKJkTHTdrOm1Cz6QTrbIgC+CSMtOYY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4836wNpQ096024
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Sep 2024 01:58:23 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 01:58:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 01:58:23 -0500
Received: from localhost (dhcp-10-24-72-81.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4836wLtP119241;
	Tue, 3 Sep 2024 01:58:22 -0500
Date: Tue, 3 Sep 2024 12:28:21 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
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
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 3/5] dt-bindings: arm: ti: Add bindings for J742S2
 SoCs and Boards
Message-ID: <da17b246-13de-4473-8f73-a29c20467082@ti.com>
References: <20240902-b4-upstream-j742s2-v6-0-6a7aa2736797@ti.com>
 <20240902-b4-upstream-j742s2-v6-3-6a7aa2736797@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240902-b4-upstream-j742s2-v6-3-6a7aa2736797@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mon, Sep 02, 2024 at 05:56:51PM +0530, Manorit Chawdhry wrote:
> Add devicetree bindings for J742S2 family of devices.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Beleswar Padhi <b-padhi@ti.com>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
> 
> Notes:
>     v6: No change
> 
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> index 5df99e361c21..b0be02f9d125 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -144,6 +144,12 @@ properties:
>                - ti,j722s-evm
>            - const: ti,j722s
>  
> +      - description: K3 J742S2 SoC

Is it J742S2 or J742s2? The naming seems to be inconsistent considering
that it is a lowercase 's' for J784s4 below.

> +        items:
> +          - enum:
> +              - ti,j742s2-evm
> +          - const: ti,j742s2
> +
>        - description: K3 J784s4 SoC
>          items:
>            - enum:
> 
> -- 
> 2.46.0
> 

