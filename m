Return-Path: <linux-kernel+bounces-220658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC01190E516
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8481C21FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A368178297;
	Wed, 19 Jun 2024 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XInfMRyl"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334AB5FBB1;
	Wed, 19 Jun 2024 08:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784039; cv=none; b=Fqr4lvWqLcLmloJN0VXJw/NlFJ5u6rcqz+NmHobSl3d2/SJih31il3leCS5BV3WDw4/WgMjDMxmo8WT2fAErC6HJfVNn53wGfXC1ptXUy2Xp7h0VZgLnEYn3f/H786jo+QG8cMn+ecnYbxmdOQRUjbvADpPo5vWiLqiEmcK3DTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784039; c=relaxed/simple;
	bh=thpUAkhJsltf/HsaqagS513WhlqKytmyO9LxeeKBG+Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diqNGW+LKzW4ZV0CjjR1ozQ/ysVlfGNxbTtVs60aDWCx8uzKdee9J1fh0pElD6AuVScVBzHIxk4Q7KtFtSxyxijXyMlHYQpeaXTYjtxXulbJLlbaOtxBWp482S5hoXAVH7RbnMyN/6eqb1ShxaHT61D59RIAF3giPIZC7W5eQ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XInfMRyl; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45J80OG8042903;
	Wed, 19 Jun 2024 03:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718784024;
	bh=EyMR6PM9DXM8j7BksUHKq1zTFh3m/RdnU97LrP5+NNU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=XInfMRyl8/mWEmjGrisMMLOmO7+ssnkzZQgUYL4uN3MIqjs8VKdvB/HDZeQjlUeF0
	 08zFOWBp8ObPwJtNyPPwFmaB44I/23tHXbxnL4lumKgsQhXc7XtluW4V21U2B4t3Q2
	 eXU7mDwojYQ3gn1mD0TCVXuiY5sRG2qb0l2a0ZPU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45J80O9v128966
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Jun 2024 03:00:24 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Jun 2024 03:00:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Jun 2024 03:00:24 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45J80N6E054421;
	Wed, 19 Jun 2024 03:00:24 -0500
Date: Wed, 19 Jun 2024 13:30:22 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Jared McArthur <j-mcarthur@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-am62p: Add gpio-ranges properties
Message-ID: <20240619080022.jdbufuc4w6fk77ju@dhruva>
References: <20240618173123.2592074-1-nm@ti.com>
 <20240618173123.2592074-3-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618173123.2592074-3-nm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Jun 18, 2024 at 12:31:22 -0500, Nishanth Menon wrote:
> On the AM62P platform we have no single 1:1 relation regarding index
> of GPIO and pin controller. The GPIOs and pin controller registers
> have mapping and holes in the map. These have been extracted from the
> AM62P data sheet.
> 
> Mux mode input is selected as it is bi-directional. In case a specific
> pull type or a specific pin level drive setting is desired, the board
> device tree files will have to explicitly mux those pins for the GPIO
> with the desired setting.
> 
> Ref: AM62P Data sheet https://www.ti.com/lit/gpn/am62p
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Note: this generates a 'too large' warning for
> pinctrl-single,gpio-ranges -
> https://lore.kernel.org/r/20240618165102.2380159-1-nm@ti.com/ for more
> details
> 
>  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 14 ++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi  | 10 ++++++++++
>  2 files changed, 24 insertions(+)


Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva

