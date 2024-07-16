Return-Path: <linux-kernel+bounces-253326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 669A9931F85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A25C1C20D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE8F13FF9;
	Tue, 16 Jul 2024 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A2f2+Dso"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBDC33C5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 04:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721102662; cv=none; b=swPgyXsm2U974ISJfjZvDzFhlXQKwv7zNgCKxhIM0QFGbtKM60MJ4fHb+PJR2qSf7o73/dO05QkOzzZ7M3i+W41Yx63c1wH1UsTzNsRmUqcbc3VpLd3EID4Gg2WBmOCZDL7Cp+pkOeHSIzKoSvo1gX3JgKQcceS55/rX26H4k5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721102662; c=relaxed/simple;
	bh=hld6iq+ojhXPdG48NJFxUY6ACAxx33QvXkLN+12ceaQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzPJGqATSqdUB+Wf9i0/TwYRFLamxQfmofKCmRob/f2xtQOWg5IGnGZmsZXroU1HT0QI6uVYZxruIaWmw260skQuU3V3r69Clslw1xvM+iSr921jGJPxnJ5vbz1AZAq0tnrtuOlBIxRLoJMIgHwwOUY2Mub+fEkUsozK5p4/YD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A2f2+Dso; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46G444dJ119126;
	Mon, 15 Jul 2024 23:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721102644;
	bh=1d79WYKf1M0avjCQpPvE4gEYXICeLVGDCbwUPcm6h5k=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=A2f2+Dsol/8YlH7fmjIgFo3nQjpeTUwZqNNXCuWoVlVHtvZUmUOmku8J5t8DRqUSS
	 hD6pPMzPaBOKV1KaOYZUYsqKyX9FJ5OSkuC2UrcUM9g6ckie9C/AmL3R8Dl0e9DZB4
	 QTsVSidg62nmTo3y1MCc0DJg39lhstmDZ0R6DgRo=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46G444TV111778
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jul 2024 23:04:04 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Jul 2024 23:04:03 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Jul 2024 23:04:03 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46G442cK086362;
	Mon, 15 Jul 2024 23:04:03 -0500
Date: Tue, 16 Jul 2024 09:34:02 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>,
        Swapnil Kashinath Jakhade
	<sjakhade@cadence.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>,
        "thomas.richard@bootlin.com"
	<thomas.richard@bootlin.com>,
        "theo.lebrun@bootlin.com"
	<theo.lebrun@bootlin.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "srk@ti.com" <srk@ti.com>, Milind
 Parab <mparab@cadence.com>
Subject: Re: [PATCH v2] phy: cadence-torrent: add support for three or more
 links using 2 protocols
Message-ID: <cf060fa7-f4e5-4740-8102-f9403cbfcafd@ti.com>
References: <20240710115624.3232925-1-s-vadapalli@ti.com>
 <LV3PR07MB1036463AB8AB5D38D003175E6C5A52@LV3PR07MB10364.namprd07.prod.outlook.com>
 <7504ea5a-335b-4152-a0f4-5be68f048903@ti.com>
 <0dc54057-d7a0-4123-badc-8f7f07f2d930@kernel.org>
 <c60a1e83-c2ad-4a04-9deb-073c69a4a06d@ti.com>
 <d4538952-add4-4210-ae0a-574cd825b18d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d4538952-add4-4210-ae0a-574cd825b18d@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mon, Jul 15, 2024 at 07:08:30PM +0300, Roger Quadros wrote:
> Hi Siddhath,
> 
> On 12/07/2024 13:38, Siddharth Vadapalli wrote:
> > Roger, Swapnil,
> > 

[...]

> > So assuming the above, we can enforce the constraint that there should
> > be only 2 Protocols when 3 or more Links are present in the device-tree.
> > This also handles the cases of
> > PCIe Multi-Link + USB, PCIe Multi-Link + Q/SGMII
> > which Swapnil has pointed to at [1], since PCIe Multi-Link is now a new
> > protocol in itself (PHY_TYPE_PCIE_ML) and shall be represented in that
> > manner in the device-tree when it is expected to be combined with a second
> > protocol.
> > 
> > After grouping the links by protocol, we can check for the entry in
> > "link_cmn_vals_entries" and proceed to configure it identical to the
> > 2 Link case.
> > 
> > [1] https://github.com/t-c-collab/linux/commits/ti-linux-6.1.y-torrent-multi-pcie-sgmii-v1
> 
> This proposal looks good to me. Thanks!

Thank you for the confirmation. I will implement the above in the v3
patch.

Regards,
Siddharth.

