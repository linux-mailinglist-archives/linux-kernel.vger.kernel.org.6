Return-Path: <linux-kernel+bounces-360851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C1C99A07B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9EBDB2541E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E342C212623;
	Fri, 11 Oct 2024 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HKqgf+Bk"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA39210C01;
	Fri, 11 Oct 2024 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640466; cv=none; b=L6EVjcjJEYgEiplt9A+N4bLW+5sxhKcZS217o636TG5pUR4fDn2Uduicm57pbMmt8q3JZy1tPEscKOBlktR9Ga8w3ZRHQ+WM+SJRTx5ZUSySAqIm/tW/xgGn76UINpqzsa/7jzYJyCPfsrQsnPoVpH4PXn2/d0Pii124bJC913A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640466; c=relaxed/simple;
	bh=zjc/xE1gF/ahy55fvUubLE/TcJQ1uuUmJmUTVcGnPu0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0pbkgWlMuj7cvYJ6S3/r0Ue5rOBkyUTcGFnhgfhA0f8zuXIy1IbZe6KgiL2MOMktyAdNvBrkKB0pX2mmEXEgBLPOC/80K39kNQTiXiQQWt9J/q45Zq6NerolGUjiR+77VfYTF91fW6M9IMMa3bI4Qx5Lqt3DfBx7Y9xys7odJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HKqgf+Bk; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49B9sAmm058382;
	Fri, 11 Oct 2024 04:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728640450;
	bh=3JrfZw4qA1G5nvmuE+klJlyZ8u0JCYflyP0Is0x2k5M=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=HKqgf+BkAi/V2I/fDDrPNKpuJhtZ4F+IWtpPX4w4av19U+xKhdDthtaOp0auDItNh
	 VsANXCXP4qu63axhlK7HgVQ0feOeaUXmAqB/+6XwsGgj0TONZ1QZj+VIgss5cgXeTl
	 9dqVnWfSIlSG7KpXtu6XzL5T43LEzqQFlPITUCnQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49B9sAbA021426
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Oct 2024 04:54:10 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Oct 2024 04:54:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Oct 2024 04:54:09 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49B9s8q7089632;
	Fri, 11 Oct 2024 04:54:09 -0500
Date: Fri, 11 Oct 2024 15:24:08 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <s-vadapalli@ti.com>, <srk@ti.com>, <danishanwar@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62x-sk-common: Add bootph-all
 property in cpsw_mac_syscon node
Message-ID: <7fead0bc-de77-43f1-83c8-ef0a5318cfec@ti.com>
References: <20241011094814.64447-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241011094814.64447-1-c-vankar@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Fri, Oct 11, 2024 at 03:18:14PM +0530, Chintan Vankar wrote:
> Add bootph-all property in CPSW MAC's eFuse node cpsw_mac_syscon.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 
> This patch is based on linux-next tagged next-20241011.
> 
>  arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> index 44ff67b6bf1e..912425f28052 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> @@ -303,6 +303,10 @@ AM62X_MCU_IOPAD(0x028, PIN_OUTPUT, 0) /* (C5/C6) WKUP_UART0_TXD */
>  	};
>  };
>  
> +&cpsw_mac_syscon {
> +	bootph-all;
> +}

Semicolon is missing. Please fix this.

Regards,
Siddharth.

