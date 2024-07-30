Return-Path: <linux-kernel+bounces-267782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A769941564
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E416286732
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523691A2C3D;
	Tue, 30 Jul 2024 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A8x9nh7c"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB74E29A2;
	Tue, 30 Jul 2024 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352947; cv=none; b=kOCEIR+Cx6h6U1B2OZCOQ8y/VGJsikvngYUX64GEgGa3W0Vk2CATorS4uN2jF0QuEDL7sxUgD+te9DAFkismphxylq/keDIoySLUSyDajzW09j2jh7cep6ycCK6rMcy9/vNo9GwdNOAh1/59r6jMipRHD2KGcpVPOs4Z2df5gUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352947; c=relaxed/simple;
	bh=vQPjcjMpAoIVH1Gcb5XIot2c4Xn8zOEZCDpD537IFMA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pbvd9eiL98nnKLG5fTUAD6ZHOnrPFaNrixSm3SCbeQyTcPM6QuKLmCMVCPDS24wt86+AUrhmIMwKUfe7iXHzAExtp8ykI48dQZE4oG037VP2Wm7dA9fJ+6SooUpd1Yg5GspTdRHJ+qAvK/DSOWnAp2yokz33I+2B0qbZZmL1flE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A8x9nh7c; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UFMIas097577;
	Tue, 30 Jul 2024 10:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722352938;
	bh=uA8WAbDT3MgC22dNiVHn9hnelyg/kG8ABn/6h66j+f0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=A8x9nh7cs2zxoT+l5vFw+NTVxTB+2dQgoGlI8vSho9uiOwXDmbPPbi87kIjcLR4/o
	 R8DUf7ymxDTB1hf0DgA6tYlSOEk5bhnZsVXLJv+D6/ulmfmUKHmVvIio3lY5tGoK6r
	 MnepCz99qMHa1uMLeQ7AGMZzTaoQO863XdmW8uLs=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UFMIh0031254
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 10:22:18 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 10:22:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 10:22:17 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46UFMHeo055910;
	Tue, 30 Jul 2024 10:22:17 -0500
Date: Tue, 30 Jul 2024 10:22:17 -0500
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>,
        Tero Kristo
	<kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vibhore Vardhan
	<vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Dhruva Gole
	<d-gole@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] firmware: ti_sci: Partial-IO support
Message-ID: <20240730152217.ko4eoiwwfckmnmkh@grumpily>
References: <20240729080101.3859701-1-msp@baylibre.com>
 <20240729080101.3859701-3-msp@baylibre.com>
 <825ad211-e1c2-44e6-bfe9-c32273799f0d@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <825ad211-e1c2-44e6-bfe9-c32273799f0d@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:12-20240730, Andrew Davis wrote:
[...]

> > +	if (response_expected) {
> 
> If a response is not expected why not simply return above and not add even more
> indention here? Also, in that case, is the call to mbox_client_txdone() needed?

Unless I am mistaken, if you ignore the actual shutdown usage, the
mbox_client_txdone will need to be invoked for the tx_tick to be
invoked for the next message in the queue to be submitted


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

