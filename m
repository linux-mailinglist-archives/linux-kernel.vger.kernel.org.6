Return-Path: <linux-kernel+bounces-308691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6960896607E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB91285EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD7E18F2D5;
	Fri, 30 Aug 2024 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HVs1GaTj"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E111D1312;
	Fri, 30 Aug 2024 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016883; cv=none; b=a1Sta/X0uzlbo3xWpWWVYJ9DPg+eI+H0hzjJhv9hKnCO7KFnbAAHPICC+WSm50KHQ6YgXrjKRh7wBcZMX+5/LSrWfN6FHbvrDfV6W6Kehb/BQ2exJvXyBNz55IxzdolYL69a8zUbjjb25y9DdhNsY6RD3DTMGFmFSJO7if16Gik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016883; c=relaxed/simple;
	bh=5k+CvSpHGNgUVRo7xeMaA/JoPXsvB00fIb0OLQ1ySso=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvByTMnh7nl0PVhDM0yAunZAu7qwyHzukryNbz13g/ETLHGJA7rbmMS8/kbfizYJBmX7RqsqpBdfRLQhgbEX3veheMcS+taaVdCS+//+T+q/XSu/BPevehE43xFbR6yHChdelEUctDUaHdVP0PX3YJHIcBJ4kEOJrB29LKU4lh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HVs1GaTj; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UBL8cP110032;
	Fri, 30 Aug 2024 06:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725016868;
	bh=jXwV1Hez2oUWWGiohE0jAsPPYVAFjS8TyhkGsm9S3Hw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=HVs1GaTjoZahjDLnUD6MklDLgtSpRe/W28TKY6Cx0ygQ9gj49mTUzcMoS8aqOW6MM
	 6ffD8WrqXj/KecWqXqhbMCbEDNxIQRqJ2nJhvwNlvBlM3XzVn7N1xmO+foc/BnIkma
	 83ZislBhSRSxfZqlhqcn0D3vqgtHt5Xf9caKjHOY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47UBL8lT041289
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Aug 2024 06:21:08 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 06:21:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 06:21:08 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UBL7Oq037881;
	Fri, 30 Aug 2024 06:21:07 -0500
Date: Fri, 30 Aug 2024 16:51:07 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-evm-nand: Rename pinctrl node
 and gpio-hog names
Message-ID: <20240830112107.z2lxw3hqq627h3pz@lcpd911>
References: <20240830102709.3970209-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240830102709.3970209-1-nm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Aug 30, 2024 at 05:27:09 -0500, Nishanth Menon wrote:
> Rename the pin mux and gpio-hog node names to match up with binding
> rules. This fixes dtbs_check warnings:
> 'gpmc0-pins-default' does not match any of the regexes: '-pins(-[0-9]+)?$|-pin$', 'pinctrl-[0-9]+'
> 'gpio0-36' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Cc: Roger Quadros <rogerq@kernel.org>
> 
> This is a trivial fix, so applying Fixes seemed over-board.
> 
>  arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
> index f08c0e272b53..f91589818e32 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
> @@ -12,7 +12,7 @@
>  #include "k3-pinctrl.h"
>  
>  &main_pmx0 {
> -	gpmc0_pins_default: gpmc0-pins-default {
> +	gpmc0_pins_default: gpmc0-default-pins {

I mean, if you are anyway renaming,
s/gpmc0_pins_default/gpmc0_default_pins

>  		bootph-all;
>  		pinctrl-single,pins = <
>  			AM64X_IOPAD(0x0094, PIN_INPUT, 7) /* (T19) GPMC0_BE1n.GPIO0_36 */
> @@ -50,7 +50,7 @@ AM64X_IOPAD(0x00a4, PIN_OUTPUT, 0) /* (N17) GPMC0_DIR */
>  };
>  
>  &main_gpio0 {
> -	gpio0-36 {
> +	gpmc0-hog {
>  		bootph-all;
>  		gpio-hog;
>  		gpios = <36 0>;

With the change,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

