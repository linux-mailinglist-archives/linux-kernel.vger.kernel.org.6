Return-Path: <linux-kernel+bounces-278886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5053E94B617
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089A31F24326
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB896136E0E;
	Thu,  8 Aug 2024 05:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aaNLV7+/"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8CD2F50;
	Thu,  8 Aug 2024 05:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723093764; cv=none; b=kZ08Gx1enOmgGhBd+JHd3X8Wcb12QuYLF9WzuVm1GO0FMjBH5wJ5uO6HSaD5RQH/otGPkxNqXp6HDuvnBLjyNLjvK5817ULa79+QsQZJh4UdD41h+nJrEjb9FlWYqbhu1+A3Thff/U/b/Yocg50RaXwTC+0SMwWTY0VUfp74mow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723093764; c=relaxed/simple;
	bh=KJQaEbevlY43oykHibQ1l1raPYpjZa9lZf00AfRgRlA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Icn2aRFmvmWnmIwf6NJ0b0+t05MRuatiNmf1to9YgykMjBGP6RdCxp0e3m6HqZwZdj75wUbgQhXNtw2MAbrnDyvitd47swEQSrjvgLVUayx5hKMjWsDPEA8dvaY/Hj/cwaJv8bwRbmlVMUoQJwU1BiPtMZIV6pJjHoL5+hP/WGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aaNLV7+/; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47859GAa079671;
	Thu, 8 Aug 2024 00:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723093756;
	bh=7/gsOTPCWRfgvdeoIMUU/2bFHnxANAO642hA1psyhjk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=aaNLV7+/yGi5PIFgDS5rLDb7C22WvCr2ryLeFRHfwibm/5zZO3TKJwl/jqdo016jd
	 xovV1BxzIaVabE8gpKPpO8cOj8cxn3KRybs1oLzSghIrifwMLtZiH7tbXrBIH43LU5
	 djr9wva0smJCpOM7JBLZN4+/7HtADooM4Z+9zMy8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47859G3D008336
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 00:09:16 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 00:09:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 00:09:15 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47859F4S037025;
	Thu, 8 Aug 2024 00:09:15 -0500
Date: Thu, 8 Aug 2024 10:39:14 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Bhavya Kapoor <b-kapoor@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <nm@ti.com>, <sinthu.raja@ti.com>,
        <n-francis@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am68-sk-base-board: Add clklb pin mux
 for mmc1
Message-ID: <20240808050914.4jleprwmlrtv4alb@uda0497581>
References: <20240807101624.2713490-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240807101624.2713490-1-b-kapoor@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Bhavya,

On 15:46-20240807, Bhavya Kapoor wrote:
> mmc1 was not functional since pin mux for clklb was not present.
> Thus, add clklb pin mux to get MMC working.
> 
> Fixes: a266c180b398 ("arm64: dts: ti: k3-am68-sk: Add support for AM68 SK base board")
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
> 
> rebased to next-20240807
> 
>  arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> index 90dbe31c5b81..d5ceab79536c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> @@ -204,6 +204,7 @@ main_mmc1_pins_default: main-mmc1-default-pins {
>  		pinctrl-single,pins = <
>  			J721S2_IOPAD(0x104, PIN_INPUT, 0) /* (P23) MMC1_CLK */
>  			J721S2_IOPAD(0x108, PIN_INPUT, 0) /* (N24) MMC1_CMD */
> +			J721S2_IOPAD(0x100, PIN_INPUT, 0) /* (###) MMC1_CLKLB */
>  			J721S2_IOPAD(0x0fc, PIN_INPUT, 0) /* (M23) MMC1_DAT0 */
>  			J721S2_IOPAD(0x0f8, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
>  			J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit

> -- 
> 2.34.1
> 

