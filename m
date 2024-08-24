Return-Path: <linux-kernel+bounces-300145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 682D195DF5C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 20:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03D5BB21AD1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 18:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009174F8A0;
	Sat, 24 Aug 2024 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TYMDSaXO"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85939AEB;
	Sat, 24 Aug 2024 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522652; cv=none; b=Nl/vuLAVsVt5aWmYwmm5l0NsBkpGwhkcHErEPPq1yLOxrhQLB1a3QPAML8/2BdGTBnPjmbfTWRCRExdhxgolgQNWxQRV6YuqQh+EcWQWdRGGCb7mrN3GNTx4+nTzZ8q7+D1LSXiSmocNGPNXBHzz4QOlu9eCNWNhlairMvCjSBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522652; c=relaxed/simple;
	bh=+28aoh4ZzTqJl9ikxd5brxUzQf4Atb3eY22cNPgEwUI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxXs9Gna+Hqd5+57iTCbdN4sK/mFiCFJAzoG1HHyM2EmsWsPo2Dv1q0Sn5zKjsvtlz8tbX3v+pTJR87PyhZA3MGHn53SBrgYfmX+8fBI6HgfXUEW2YGRhOrDfIR2bElpgltFMlu6/Pt7oI7SPaNNWMAVqOCT+SQeVGF/16YqetU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TYMDSaXO; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47OI3ubC009837;
	Sat, 24 Aug 2024 13:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724522636;
	bh=30d4/S9XTwZnjC/2bYEyUwkSz8qqTCxy1PXz887ihFo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=TYMDSaXOe2sXNzJ0zour+kO16MX3bnOirzMkoobr42zrpKHlI086+5I5XcOqWQoQc
	 8L/rKnLUWhaDiyZSxu8yFurGO4+vSYEnQQi8Y5YP15/+vh+2lO8T0/BXxBOUEvWW4n
	 9PshSZZpi2X5j11CXUfKjBnUL75QNMzqYLCUhzF4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47OI3uI0112961
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 13:03:56 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 13:03:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 13:03:56 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47OI3ueb049700;
	Sat, 24 Aug 2024 13:03:56 -0500
Date: Sat, 24 Aug 2024 13:03:56 -0500
From: Nishanth Menon <nm@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <u-kumar1@ti.com>,
        <tony@atomide.com>, <bb@ti.com>, <d-gole@ti.com>, <afd@ti.com>,
        <hnagalla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] Reserve Timer Nodes to avoid clash with
 Remoteproc firmware
Message-ID: <20240824180356.quv4zdrtnskrnuo5@diagram>
References: <20240816073908.2343650-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240816073908.2343650-1-b-padhi@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 13:09-20240816, Beleswar Padhi wrote:
> The remoteproc firmware like of R5F and DSPs in the MAIN voltage domain
> use timers. At the same time, if Linux probes the timers, some
> instability is observed while booting remote cores. Therefore, change
> the status of the timer nodes to "reserved" to avoid any clash. 
> 
> v3: Changelog:
> * Udit
> 1) j7200: Updated commit message description to remove DSPs as the SoC does not
> have one.
> 2) j722s: Updated the correct commit for "Fixes:" tag which introduced the bug.
> 3) For entire series, removed comment about timer usage by R5fs in the MCU
> voltage domain as those are used by Device Manager firmware to get SoC
> functional.
> 
> Link to v2:
> https://lore.kernel.org/all/20240814104151.2038457-1-b-padhi@ti.com/
> 
> v2: Changelog:
> - Split the changes into individual patches for each SoC to tag the
>   correct offending commit for "Fixes:" tag.
> 
> * Udit
> 1) Add the correct clashing timer nodes for J7200 SoC.
> 2) Port these changes to board level dts files instead of SoC level dtsi files.
> 
> Link to v1:
> https://lore.kernel.org/all/20240607105559.771080-1-b-padhi@ti.com/
> 
> Beleswar Padhi (5):
>   arm64: dts: ti: k3-j7200: Change timer nodes status to reserved
>   arm64: dts: ti: k3-j721e: Change timer nodes status to reserved
>   arm64: dts: ti: k3-j721s2: Change timer nodes status to reserved
>   arm64: dts: ti: k3-j784s4: Change timer nodes status to reserved
>   arm64: dts: ti: k3-j722s: Change timer nodes status to reserved

All patches: please fix your $subject. it looked initially like
you were fixing the default SoC behavior, but later I realized
you are fixing the evm solution.

Also while at this make sure the corresponding SK behaviors are in sync
correctly as well. if you think they do not need to be fixed, address
that comment in the cover-letter.

> 
>  .../dts/ti/k3-j7200-common-proc-board.dts     | 13 ++++++
>  .../dts/ti/k3-j721e-common-proc-board.dts     | 29 +++++++++++++
>  .../dts/ti/k3-j721s2-common-proc-board.dts    | 25 +++++++++++
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts       | 13 ++++++
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 41 +++++++++++++++++++
>  5 files changed, 121 insertions(+)
> 
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

