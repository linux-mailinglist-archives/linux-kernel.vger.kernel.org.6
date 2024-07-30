Return-Path: <linux-kernel+bounces-267755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA2E94151C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE983285350
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3E71A2C21;
	Tue, 30 Jul 2024 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jsUNR+aA"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A451A2C1F;
	Tue, 30 Jul 2024 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352051; cv=none; b=V35+gQ40PndaQNEwSb5WuCtZIn+UkMiE0YfhpsdnP3An3UsRviuB1oV2Pm68Q1OLhYnRj+n2GlwYnZe8hl0W9C++bLEqNWULZtU0VT4oxpG8fUir8cu5WHQkMeZdH37A3JSaZdAUhlqCBrN5w/qZKRvKg522IJkLka80WZWKoDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352051; c=relaxed/simple;
	bh=Xk9Qgd1nc/VFJGyVzkDKyYiDQdgbuSQ/ZFpxiVvTA44=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SL7w6SkLbEW9ZeYtAed0ZBZ/8ZyuPLMgGyaCKNhnr6xScU07ywwdKp5KvYEg1Q7nNfrxrtbp3S92a1z1ONxhsIBKSJbSOOo0lt/Xa+lQz7SlogPOFOO3wlrN3717d6WRGXco87u7xCgdSVKxhmMqj6rCG3qf3MuoCkpzbmmID04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jsUNR+aA; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UF7N97079068;
	Tue, 30 Jul 2024 10:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722352043;
	bh=r3KnbH5N6/qZ5lerZkWzlpj9PgXBhac2810ctACOVts=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jsUNR+aAXwlmv2dkSjcj7qAA9O3mNkUuEHUJJdcVKRw+oyru3lepq+xzMpbcZWR5w
	 Fi+Er9hdVD4l7VL+gtnvnsMT40hLUSiP02Q9HSDquzgxUD57kHLPsuO7PFa7WXvme7
	 MBTDKNrLM5oUjYNEbhB1WtO1258444XNt2YKqadU=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UF7NSO003416
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 10:07:23 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 10:07:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 10:07:22 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46UF7Mke032437;
	Tue, 30 Jul 2024 10:07:22 -0500
Date: Tue, 30 Jul 2024 10:07:22 -0500
From: Nishanth Menon <nm@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Dhruva
 Gole <d-gole@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] firmware: ti_sci: Partial-IO support
Message-ID: <20240730150722.bzls2qrfqwlmh6mn@clergyman>
References: <20240729080101.3859701-1-msp@baylibre.com>
 <20240729080101.3859701-3-msp@baylibre.com>
 <20240730122801.jzo5ahkurxaexwcm@ambiance>
 <x4y44ajcdi2y2dieaa6oohrptpzyiono3fruvwcdelmtzsh4ne@cgqxsz45ohcy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <x4y44ajcdi2y2dieaa6oohrptpzyiono3fruvwcdelmtzsh4ne@cgqxsz45ohcy>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 15:01-20240730, Markus Schneider-Pargmann wrote:
> > > +
> > > +	return NOTIFY_DONE;
> > > +}
> > > +
> > >  /* Description for K2G */
> > >  static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
> > >  	.default_host_id = 2,
> > > @@ -3398,6 +3485,35 @@ static int ti_sci_probe(struct platform_device *pdev)
> > >  		goto out;
> > >  	}
> > >  
> > > +	if (of_property_read_bool(dev->of_node, "ti,partial-io-wakeup-sources")) {
> > 
> > You should probably check on TISCI_MSG_QUERY_FW_CAPS[1] if
> > Partial IO on low power mode is supported as well? if there is a
> > mismatch, report so?
> 
> I actually have another series in my queue that introduces this check. I
> just implemented this check for Partial-IO yesterday in the patch that
> introduces fw capabilities. If you like I can switch these series
> around.

Yes, please introduce it part of the series.

> 
> > 
> > > +		info->nr_wakeup_sources =
> > > +			of_count_phandle_with_args(dev->of_node,
> > > +						   "ti,partial-io-wakeup-sources",
> > > +						   NULL);
> > > +		info->wakeup_source_nodes =
> > > +			devm_kzalloc(dev, sizeof(*info->wakeup_source_nodes),
> > > +				     GFP_KERNEL);
> > > +
> > > +		for (i = 0; i != info->nr_wakeup_sources; ++i) {
> > > +			struct device_node *devnode =
> > > +				of_parse_phandle(dev->of_node,
> > > +						 "ti,partial-io-wakeup-sources",
> > > +						 i);
> > > +			info->wakeup_source_nodes[i] = devnode;
> > 
> > Curious: Don't we need to maintain reference counting for the devnode
> > if CONFIG_OF_DYNAMIC?
> 
> In case you mean I missed of_node_put(), yes, I did, thank you. I added
> it in a ti_sci_remove().

And unless I am mistaken, of_node_get as required as you are
retaining the reference of the node till shutdown / remove is invoked.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

