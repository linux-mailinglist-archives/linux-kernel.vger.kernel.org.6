Return-Path: <linux-kernel+bounces-248604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 040B692DFA2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0DA1F21F82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6E676F17;
	Thu, 11 Jul 2024 05:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RjyXmIx6"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C712C861;
	Thu, 11 Jul 2024 05:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675955; cv=none; b=Cc11ZDkxtG4cfYnOQZdlYKlsnhHchEdJyZmn0q9But4ZEBddQCsYp2tQ/F9lNiteyQGskFA+2sAGSb0OxtIa+KpLL0HagCZsv9n7uIROn6bC/NzT6Lf7T7+4qqzlSeyJtGrRPOPzdTb/OzmuFloMVqCILmYsN6IBp8xvC/buRe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675955; c=relaxed/simple;
	bh=F23pTQsQE8UiGQ1Y0uqxPdc6Tu9NnVDU0wM1IawzlaA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ActKMCJC5da2+S1EVg2/t+CTblXy8WUUugM9KoErYAvoMcuH9MHAl9fvt7U+zODCNq40B8VXR+pEO4XQ73aX8/N9Tj7yTNIGwKwBwR7T5cUXqBIW3G0twQ8M0kDevh+zVsLyBA5gnEKVZfy0gSV/tFAEsnxteYsit5TpgTlCG68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RjyXmIx6; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46B5WNPu130488;
	Thu, 11 Jul 2024 00:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720675943;
	bh=X3L5Zd8G8duBSfnEniP7p77LQI8FUIr3lTUe03NehCg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=RjyXmIx64A7CTeG1ijTKrrB8ItO+7zwV5FWBqSsHSoSPtvHSCro+r2lmaTC5/BVdN
	 O3uIcwzOGHmW2S5frQ9m1f+s1jWEPkemfI/RFfMMKoi5xCFy/slC5Fl1ofYbT0magy
	 aqbKugzpXA8Pd1qqKRGd2MbDC17Sw5/QjEFxqvUA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46B5WNAL111144
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jul 2024 00:32:23 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Jul 2024 00:32:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Jul 2024 00:32:22 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46B5WLub101320;
	Thu, 11 Jul 2024 00:32:22 -0500
Date: Thu, 11 Jul 2024 11:02:21 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Andrew Halaney <ahalaney@redhat.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        "Tero
 Kristo" <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, <mranostay@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-j784s4-evm: Assign only lanes 0
 and 1 to PCIe1
Message-ID: <4b13252c-31ed-4122-89e4-3fdae95077e5@ti.com>
References: <20240710-k3-j784s4-evm-serdes0-cleanup-v1-0-03850fe33922@redhat.com>
 <20240710-k3-j784s4-evm-serdes0-cleanup-v1-1-03850fe33922@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240710-k3-j784s4-evm-serdes0-cleanup-v1-1-03850fe33922@redhat.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Wed, Jul 10, 2024 at 10:36:13AM -0500, Andrew Halaney wrote:
> Currently PCIe1 is setup to use SERDES0 lanes 0 thru 3, and USB0 is
> setup to use SERDES0 lane 3 as well.
> 
> This overlap in lanes causes the following reset related lane splat:
> 
>     [    4.846266] WARNING: CPU: 4 PID: 308 at drivers/reset/core.c:792 __reset_control_get_internal+0x128/0x160
>     ...
>     [    4.846405] Call trace:
>     [    4.846407]  __reset_control_get_internal+0x128/0x160
>     [    4.846413]  __of_reset_control_get+0x4e0/0x528
>     [    4.846418]  of_reset_control_array_get+0xa4/0x1f8
>     [    4.846423]  cdns_torrent_phy_probe+0xbc8/0x1068 [phy_cadence_torrent]
>     [    4.846445]  platform_probe+0xb4/0xe8
>     ...
>     [    4.846577] cdns-torrent-phy 5060000.serdes: phy@0: failed to get reset
> 
> Let's limit the PCIe1 SERDES0 lanes to 0 and 1 to avoid overlap here.
> This works since PCIe1 operates in x2 mode and doesn't need 4 SERDES0
> lanes.
> 
> Fixes: 27ce26fe52d4 ("arm64: dts: ti: k3-j784s4-evm: Enable PCIe0 and PCIe1 in RC Mode")
> Suggested-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Thank you for posting this patch.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

