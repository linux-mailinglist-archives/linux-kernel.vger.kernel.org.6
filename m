Return-Path: <linux-kernel+bounces-386874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F309B48EC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361B6282E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47447206048;
	Tue, 29 Oct 2024 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BzmFzRRZ"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12D3205E0B;
	Tue, 29 Oct 2024 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203406; cv=none; b=S+0odphbdiMEijqTDmX4gC3x2ddAasvUDEp5HegDe3cyheOU5nAvJo6mRgc/zMKQkQi9ODD9eL4AWM8epPhWcg7wku4UvSCruzIYLNS3Gi6Tim+JYnA9VT182lmmYIuMC8nB5ksBTiZLs5Gvo5qOZiJEzVDDuhG0FAN2GZ4zXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203406; c=relaxed/simple;
	bh=SWx1corgWtFur7oJJLiz8Jr77EEohngVXxqWbvx+oDs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVLYXObyxwUdsx+u7Hdo+Kp44Grkt1227dUgOPs2o8DqOAeW8SAQc98KPWxmlW3z/cpOq9TDi6vhk1znyNEdLzxiRFSoexgTqFlN4S8ud/+zP4KEUhFvE94njaoyp+f1ll43LUEwJFuitnSCt5pGcTWnKHBibRLVyaavpUDZLJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BzmFzRRZ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49TC34TI030901;
	Tue, 29 Oct 2024 07:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730203384;
	bh=hicrTkVtQs2t7bpDq9lM+vtUFPXqZg58LQfBivaXaRI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=BzmFzRRZD7a5aewcirj2Iju6Iug22YxIZRB99C0wnwBNuYEiajDkuO8zEMuAbVoIy
	 2z8V+FqX6kq/UMNqkLrm+sL2hkdMpkCE1HTHK46meiEKElduAQmb01sJsDzVq2gj1i
	 sWM72v25TUis5ifXg40YgcBIRAgj+0ematoSJhs4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49TC343c129935
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Oct 2024 07:03:04 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 07:03:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 07:03:02 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49TC32U5125998;
	Tue, 29 Oct 2024 07:03:02 -0500
Date: Tue, 29 Oct 2024 07:03:02 -0500
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
Message-ID: <20241029120302.3twkliytrn5hjufi@sleek>
References: <20241012-topic-am62-partialio-v6-12-b4-v3-0-f7c6c2739681@baylibre.com>
 <20241012-topic-am62-partialio-v6-12-b4-v3-2-f7c6c2739681@baylibre.com>
 <20241025174204.xwmsn2arcy4q63xu@reaction>
 <7l5ok4bufvewoimrecm5pajlqqmqg75rjthivdufoqhphfgiy5@xo7f3rrdr3zs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7l5ok4bufvewoimrecm5pajlqqmqg75rjthivdufoqhphfgiy5@xo7f3rrdr3zs>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 15:49-20241028, Markus Schneider-Pargmann wrote:
> Hi Nishanth,
> 
> On Fri, Oct 25, 2024 at 12:42:04PM GMT, Nishanth Menon wrote:
> > On 16:39-20241012, Markus Schneider-Pargmann wrote:
> > [...]
> > > 
> > > The possible wakeup devices are found by checking which devices are
> > > powered by the regulator supplying the "vddshv_canuart" line. These are
> > > considered possible wakeup sources. Only wakeup sources that are
> > > actually enabled by the user will be considered as a an active wakeup
> > > source. If none of the wakeup sources are enabled the system will do a
> > > normal poweroff. If at least one wakeup source is enabled it will
> > > instead send a TI_SCI_MSG_PREPARE_SLEEP message from the sys_off
> > > handler. Sending this message will result in an immediate shutdown of
> > > the system. No execution is expected after this point. The code will
> > > wait for 5s and do an emergency_restart afterwards if Partial-IO wasn't
> > > entered at that point.
> > > 
> > [...]
> > 
> > > +static bool tisci_canuart_wakeup_enabled(struct ti_sci_info *info)
> > > +{
> > > +	static const char canuart_name[] = "vddshv_canuart";
> > > +	struct device_node *wakeup_node = NULL;
> > > +
> > > +	for (wakeup_node = of_find_node_with_property(NULL, "vio-supply");
> > > +	     wakeup_node;
> > > +	     wakeup_node = of_find_node_with_property(wakeup_node, "vio-supply")) {
> > > +		struct device_node *supply_node;
> > > +		const char *supply_name;
> > > +		struct platform_device *pdev;
> > > +		int ret;
> > > +
> > > +		supply_node = of_parse_phandle(wakeup_node, "vio-supply", 0);
> > > +		if (!supply_node)
> > > +			continue;
> > > +
> > > +		ret = of_property_read_string(supply_node, "regulator-name", &supply_name);
> > > +		of_node_put(supply_node);
> > > +		if (ret) {
> > > +			dev_warn(info->dev, "Failed to parse vio-supply phandle at %pOF %d\n",
> > > +				 wakeup_node, ret);
> > > +			continue;
> > > +		}
> > > +
> > > +		if (strncmp(canuart_name, supply_name, strlen(canuart_name)))
> > > +			continue;
> > > +
> > > +		pdev = of_find_device_by_node(wakeup_node);
> > > +		if (!pdev)
> > > +			continue;
> > > +
> > > +		if (device_may_wakeup(&pdev->dev)) {
> > > +			dev_dbg(info->dev, "%pOF identified as wakeup source for Partial-IO\n",
> > > +				wakeup_node);
> > > +			put_device(&pdev->dev);
> > > +			of_node_put(wakeup_node);
> > > +			return true;
> > > +		}
> > > +		put_device(&pdev->dev);
> > > +	}
> > > +
> > > +	return false;
> > > +}
> > > +
> > 
> > What is the binding that supports this? I just do not think that
> > scanning the entire tree for vio-supply implies you will get thr right
> > property here.
> > 
> > Just giving an example to illustrate this point:
> > Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt says it
> > needs vio-supply -> so i have a node with the wireless supply as
> > vio-supply -> Since we are scanning from NULL for vio-supply, we hit
> > that, that is a bad choice for enabling io-retention.
> 
> There is no bining that specifically supports this as I think it is not
> needed. The devices that are capable to wakeup the system from
> Partial-IO are all powered through one supply line that is always-on. It
> is called 'vddshv_canuart' and the name of this supply is checked
> in the above code as well. Yes I am using 'vio-supply', but only to

In effect, you are looking for nodes that have vio-supply pointing to
a regulator called vddshv_canuart. Not only is it too specific to a
device, but a board as well. Without documentation in binding, users
who don't have sufficient information is bound to mess this up. Further,
vddshv_canuart may not even be a regulator - there will need to be
checks for that on top of just a strncmp.


> search for the potential consumers of this supply.
> So wl1251 will be skipped in above code at
> 
>   if (strncmp(canuart_name, supply_name, strlen(canuart_name)))

Aah, thanks, but sorry, but I would prefer the drivers handle the
specifics. If a new peripheral comes on to the list for a different
device, or a different regulator name appears for can, we would be
dealing with name mapping etc.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

