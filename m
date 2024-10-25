Return-Path: <linux-kernel+bounces-382298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0712C9B0C02
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398471C22F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4410A20BB44;
	Fri, 25 Oct 2024 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VE6wSRv7"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9C718452E;
	Fri, 25 Oct 2024 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878138; cv=none; b=JhTkGwOgj2hRYkU0PhR2YukVXmKrhiuOkCqXQPC6Gfd7u6ty1GblN1+7igTygx2ayAoTffKTlTvI58mYG4nyaFjGDUYtmrNnhZAL0Q6jswWLE/iq4BT3tGX8T6HQBPJlby67L4fRsy5IbAcThS7txcX+kpyhT+NvkS6q8rqNQcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878138; c=relaxed/simple;
	bh=PwyeLzwC8ipsRtMBNOMt7RMlZVMwSI+R8kgLXOHJxdE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1iBEzXRqbDWNZaGnDczhRlQ9MSzzptRVNatDYwp4ljQau+zK5sQ74dlUFMK14GKwM3bTTkPpmoNQ+bTp7BArXHDLdC6YUYOGB8HOd69DdpwTApfWSdv5v0iuCr76AeKeWAALSs2ulftqVNsNvPI8b8kI5iVY7x7zCJZEMXzfEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VE6wSRv7; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49PHg5wc021530;
	Fri, 25 Oct 2024 12:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729878125;
	bh=pwKM75sCFnfctTtbj/opwnkqiPuhZWuGKbKWcmwTyIY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=VE6wSRv7zxAis0MClAfx62Vw8upuraUz6En61GTY3JhXbfzImFcpblBr1W0a+nASO
	 NaGFszhOPgI7MhmNVnGjjPHRtsUqfYjyKZpfr3mxRzE0NYwYstYXKDrbNjfJh8youM
	 QbMHDDQhPNlGCe36910F7UUSlTKEBAWwgP/RrnZI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49PHg5UT068344
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Oct 2024 12:42:05 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Oct 2024 12:42:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Oct 2024 12:42:04 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49PHg4lt109361;
	Fri, 25 Oct 2024 12:42:04 -0500
Date: Fri, 25 Oct 2024 12:42:04 -0500
From: Nishanth Menon <nm@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Vishal Mahaveer
	<vishalm@ti.com>,
        Kevin Hilman <khilman@baylibre.com>, Dhruva Gole
	<d-gole@ti.com>
Subject: Re: [PATCH v3 2/6] firmware: ti_sci: Partial-IO support
Message-ID: <20241025174204.xwmsn2arcy4q63xu@reaction>
References: <20241012-topic-am62-partialio-v6-12-b4-v3-0-f7c6c2739681@baylibre.com>
 <20241012-topic-am62-partialio-v6-12-b4-v3-2-f7c6c2739681@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241012-topic-am62-partialio-v6-12-b4-v3-2-f7c6c2739681@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 16:39-20241012, Markus Schneider-Pargmann wrote:
[...]
> 
> The possible wakeup devices are found by checking which devices are
> powered by the regulator supplying the "vddshv_canuart" line. These are
> considered possible wakeup sources. Only wakeup sources that are
> actually enabled by the user will be considered as a an active wakeup
> source. If none of the wakeup sources are enabled the system will do a
> normal poweroff. If at least one wakeup source is enabled it will
> instead send a TI_SCI_MSG_PREPARE_SLEEP message from the sys_off
> handler. Sending this message will result in an immediate shutdown of
> the system. No execution is expected after this point. The code will
> wait for 5s and do an emergency_restart afterwards if Partial-IO wasn't
> entered at that point.
> 
[...]

> +static bool tisci_canuart_wakeup_enabled(struct ti_sci_info *info)
> +{
> +	static const char canuart_name[] = "vddshv_canuart";
> +	struct device_node *wakeup_node = NULL;
> +
> +	for (wakeup_node = of_find_node_with_property(NULL, "vio-supply");
> +	     wakeup_node;
> +	     wakeup_node = of_find_node_with_property(wakeup_node, "vio-supply")) {
> +		struct device_node *supply_node;
> +		const char *supply_name;
> +		struct platform_device *pdev;
> +		int ret;
> +
> +		supply_node = of_parse_phandle(wakeup_node, "vio-supply", 0);
> +		if (!supply_node)
> +			continue;
> +
> +		ret = of_property_read_string(supply_node, "regulator-name", &supply_name);
> +		of_node_put(supply_node);
> +		if (ret) {
> +			dev_warn(info->dev, "Failed to parse vio-supply phandle at %pOF %d\n",
> +				 wakeup_node, ret);
> +			continue;
> +		}
> +
> +		if (strncmp(canuart_name, supply_name, strlen(canuart_name)))
> +			continue;
> +
> +		pdev = of_find_device_by_node(wakeup_node);
> +		if (!pdev)
> +			continue;
> +
> +		if (device_may_wakeup(&pdev->dev)) {
> +			dev_dbg(info->dev, "%pOF identified as wakeup source for Partial-IO\n",
> +				wakeup_node);
> +			put_device(&pdev->dev);
> +			of_node_put(wakeup_node);
> +			return true;
> +		}
> +		put_device(&pdev->dev);
> +	}
> +
> +	return false;
> +}
> +

What is the binding that supports this? I just do not think that
scanning the entire tree for vio-supply implies you will get thr right
property here.

Just giving an example to illustrate this point:
Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt says it
needs vio-supply -> so i have a node with the wireless supply as
vio-supply -> Since we are scanning from NULL for vio-supply, we hit
that, that is a bad choice for enabling io-retention.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

