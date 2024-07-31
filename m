Return-Path: <linux-kernel+bounces-269238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B99942FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1134128B3ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84881B29D4;
	Wed, 31 Jul 2024 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X3h0ljJe"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA9A1B143B;
	Wed, 31 Jul 2024 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430925; cv=none; b=QzMBTSwYjMnvzGQJzTObOZNILlDTc5TnLArhOL1cv27PI3qNR2BRJkORYIsd6GhcyexBeOle6SDyOJdHFSaqjpfGVSxKk58w0AmGuMkfBxYioiPXr3d3AJ+k1Zic/U21RhD+2+aJVR6G9KyQbnFluJCz+gTM9JMgPnL6B0aSoTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430925; c=relaxed/simple;
	bh=tGIJJu34wSvwiryl9xfZ5w6IhLF6zWo9jU0Gnv5BzE4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgsIj1agPtEC/rZySZPw1/ItRfgjXzfDExb8kpj81ROIT4Mrue0912Z8EzSp10NBg2F7l8dZEqPHQKCjyaUi6sJZZCdIDzfsVLmOzaM9YnrVq17gf0ciCFyO5QcSMxx907IiZ44MsHTWa2ts4Fge3/U8H3EmdMYGPwC5Py6ULjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X3h0ljJe; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46VD1e8Q027098;
	Wed, 31 Jul 2024 08:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722430900;
	bh=UDS+aa+QwNSeYii0yfuqT44tg2CNmJwH2uPktIxU9Ro=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=X3h0ljJe11O8bz9jp9iwUB+4vhq1nldc+HxnbOv0c7+mTNRari7BJbcoDsr7ltLj6
	 dZBveB6+5DI4XreP1nbC8oyP7HO2+lvJQgnQo0KQWmzfdnBSTRiQ5FFDPUVlvyduXQ
	 ucQrEKRwRdbcRFxlUvSnNssACaMx4XNWTyzeDhQg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46VD1ew6023948
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jul 2024 08:01:40 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 08:01:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 08:01:40 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46VD1dLB115545;
	Wed, 31 Jul 2024 08:01:39 -0500
Date: Wed, 31 Jul 2024 08:01:39 -0500
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
Message-ID: <20240731130139.ysmaa4h5istdnpdj@sedate>
References: <20240729080101.3859701-1-msp@baylibre.com>
 <20240729080101.3859701-3-msp@baylibre.com>
 <20240730122801.jzo5ahkurxaexwcm@ambiance>
 <x4y44ajcdi2y2dieaa6oohrptpzyiono3fruvwcdelmtzsh4ne@cgqxsz45ohcy>
 <20240730150722.bzls2qrfqwlmh6mn@clergyman>
 <dskdxir6375ap47lm2ptp7ttnaaxhczsf6bwk73xl5pajfqhnk@4324gihbq43u>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dskdxir6375ap47lm2ptp7ttnaaxhczsf6bwk73xl5pajfqhnk@4324gihbq43u>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 14:36-20240731, Markus Schneider-Pargmann wrote:
> > > > > +		for (i = 0; i != info->nr_wakeup_sources; ++i) {
> > > > > +			struct device_node *devnode =
> > > > > +				of_parse_phandle(dev->of_node,
> > > > > +						 "ti,partial-io-wakeup-sources",
> > > > > +						 i);
> > > > > +			info->wakeup_source_nodes[i] = devnode;
> > > > 
> > > > Curious: Don't we need to maintain reference counting for the devnode
> > > > if CONFIG_OF_DYNAMIC?
> > > 
> > > In case you mean I missed of_node_put(), yes, I did, thank you. I added
> > > it in a ti_sci_remove().
> > 
> > And unless I am mistaken, of_node_get as required as you are
> > retaining the reference of the node till shutdown / remove is invoked.
> 
> The function documentation says the refcount is already incremented:
> 
>  * Return: The device_node pointer with refcount incremented.  Use
>  * of_node_put() on it when done.
> 

Yes indeed. I missed it. Thanks for looking it up.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

