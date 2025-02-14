Return-Path: <linux-kernel+bounces-514556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4612AA3586E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC5F3A7FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E86B221D96;
	Fri, 14 Feb 2025 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x8of1uYH"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9974221700;
	Fri, 14 Feb 2025 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520338; cv=none; b=iCAQjY2co1PmTzMHivuER24GS9x/+3b4iZ9iRwyke1RtFYzQSuFruT6WclteAJW5qO6OE1GNZKOrCLTaoFAwJ1HOJg8EoQBkJ8qwxAJIvP9J5d+C36Jo+V6t8wNQacGlySVxoPceRGgcNxIQZeMzDGrzXaCcH2QjCpDwThVBBDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520338; c=relaxed/simple;
	bh=G9gkqx1h6EoYI9yTILB7n/U5mzUoHnvZQaFcNodFcK8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3HxBBOU1hvjHkZQq1D/MPGaziYxRQZnqXAq7WcGzBr3ZUI1tgQbuf1Dk4S/uE3RbTTQaRPbpvGm/R0nmhkm9WY6DSnnOb5U8uk/K5QhLzynxhP15Xz+6ndcbAGhOWZvE1LQv7UVr7whBOQlxdmRMAD0pZD/fMNFq4+IPT6yedY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=x8of1uYH; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51E85PWT096861
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 02:05:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739520325;
	bh=XnbZ8VsXODkmtfXWh1DBqFmOEWEsXMo+zmBXg0OmqXs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=x8of1uYHIIXhMySQrFtiWf6aGMA1bCXQ3CkgVJzOeDXooLdP4R698ExB+edfSTXgl
	 wGH2ItytTZxfZMDI6aaSqxF4WVKql9BXnYwgumrff3tjjgiiO+jd7L8lx0H2gACVNC
	 CnxGvO1sxsxEAzoN0YePpEQCyWA8dhyow5YnAYck=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51E85ObG013406
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Feb 2025 02:05:25 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Feb 2025 02:05:24 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Feb 2025 02:05:24 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51E85NMZ117734;
	Fri, 14 Feb 2025 02:05:24 -0600
Date: Fri, 14 Feb 2025 13:35:23 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Kendall Willis <k-willis@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <tony@atomide.com>,
        <msp@baylibre.com>, <khilman@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62p-j722s-common-wakeup: Configure
 ti-sysc for wkup_uart0
Message-ID: <20250214080523.efqvheeso5xoai6p@lcpd911>
References: <20250212215248.746838-1-k-willis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250212215248.746838-1-k-willis@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Feb 12, 2025 at 15:52:48 -0600, Kendall Willis wrote:
> From: Vibhore Vardhan <vibhore@ti.com>
> 
> Similar to the TI K3-AM62x Soc commit ce27f7f9e328c8582a169f97f1466976561f1
> ("arm64: dts: ti: k3-am62-wakeup: Configure ti-sysc for wkup_uart0")
> The devices in the wkup domain are capable of waking up the system from
> suspend. We can configure the wkup domain devices in a generic way using
> the ti-sysc interconnect target module driver like we have done with the
> earlier TI SoCs.
> 
> As ti-sysc manages the SYSCONFIG related registers independent of the
> child hardware device, the wake-up configuration is also set even if
> wkup_uart0 is reserved by sysfw.
> 
> The wkup_uart0 device has interconnect target module register mapping like
> dra7 wkup uart. There is a 1 MB interconnect target range with one uart IP
> block in the target module. The power domain and clock affects the whole
> interconnect target module.
> 
> Note we change the functional clock name to follow the ti-sysc binding
> and use "fck" instead of "fclk".
> 
> Also note that we need to disable the target module reset as noted by
> Markus. Otherwise the sysfw using wkup_uart0 can get confused on some
> devices leading to boot time issues such as mbox timeouts.
> 
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
> Tested by suspend/resume with WKUP UART wakeup source on AM62P.
> 
> Similar patch was sent for AM62x by Tony,
> https://lore.kernel.org/all/20231219072503.12427-1-tony@atomide.com/
> 
> Similar patch was sent for AM62a by Dhruva,
> https://lore.kernel.org/all/20241231-am62a-dt-ti-sysc-wkup-v1-1-a9b0d18a2649@ti.com/
> 
> Original patch for AM62p existed in the TI Vendor tree with Vibhore's
> authorship:
> https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=ti-linux-6.6.y&id=efab3fb636673837886599a49cddf1e862c8aeb6
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

