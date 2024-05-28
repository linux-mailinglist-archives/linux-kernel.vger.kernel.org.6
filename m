Return-Path: <linux-kernel+bounces-192321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102918D1B83
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420BA1C21EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9295F16D9A7;
	Tue, 28 May 2024 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nzEPJwt3"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B829216D311;
	Tue, 28 May 2024 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900063; cv=none; b=Q1igZ7Fy/AyCQMNw4JxAi8m4Y8Cd7v0y1/uHWjZVCAZpep30C5//W0WFF5HCa6PtGOwwPDQDmPxNmSopLE+9AUH05aw8OtJ/aJF5gJqNiWMALCqkV4NtTCSwI21gZ+sD/lMqvxDpBV2w2Bh26zTRJeFSyCUrWi0wZosWfWvgHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900063; c=relaxed/simple;
	bh=ddvn5BfqB7AS4kyd/x4CZy0Goq6dmue0E5AoDVbg56c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M82E6DYIR6ALzy1lYevRbuC4KeawtbRUHjquPAWxOWpcDdf+GogquHyCk8zw2EcWBfpc5Hw+OkG+M0Zn9QGmu5MguPIllEXhWnyKq4FonhKEt/mfqJlOrwHshFLSm0sYvRzTIA4AVBMAfn0/0ZClmwMKPMAmq8STDTj8ihoKy+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nzEPJwt3; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44SCetIg082812;
	Tue, 28 May 2024 07:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716900055;
	bh=TbIaOGrlOhUitfZlsmKEWOd3kbAnPIDikYZLcmoEe1U=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=nzEPJwt3rD4NbOhyRgi/KapC1Z2pJ5a+rd3hOoBTF3K/1RG38MxUnA52hFd47VKRu
	 XYmBDMNXuBV5fqFvmI1l6eJ+5yR1qhwijQDqeDuJX9rIJVVevWo/F6KU8EvuzB33Nu
	 hRUvW+tnXbFDaY4CgLVuJoYaialxfazhmanqZhLM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44SCet5k091023
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 May 2024 07:40:55 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 07:40:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 07:40:55 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44SCes24047610;
	Tue, 28 May 2024 07:40:54 -0500
Date: Tue, 28 May 2024 18:10:53 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <afd@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v3 4/7] arm64: dts: ti: k3-serdes: Add Serdes1
 lane-muxing macros for J722S
Message-ID: <2aaf80f4-2631-4a3c-a4cb-394776764801@ti.com>
References: <20240524090514.152727-1-s-vadapalli@ti.com>
 <20240524090514.152727-5-s-vadapalli@ti.com>
 <def2fd41-371a-4b2a-925d-81b149aaae01@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <def2fd41-371a-4b2a-925d-81b149aaae01@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, May 28, 2024 at 03:19:30PM +0300, Roger Quadros wrote:
> 
> 
> On 24/05/2024 12:05, Siddharth Vadapalli wrote:
> > The Serdes1 instance of the Serdes on J722S SoC is a single lane Serdes
> > that is muxed across PCIe and CPSW. Define the lane-muxing macros to be
> > used as the idle state values.
> > 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> > Current patch is v1. No changelog.
> > 
> >  arch/arm64/boot/dts/ti/k3-serdes.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-serdes.h b/arch/arm64/boot/dts/ti/k3-serdes.h
> > index e6a036a4e70b..ef3606068140 100644
> > --- a/arch/arm64/boot/dts/ti/k3-serdes.h
> > +++ b/arch/arm64/boot/dts/ti/k3-serdes.h
> > @@ -206,4 +206,7 @@
> >  #define J722S_SERDES0_LANE0_USB			0x0
> >  #define J722S_SERDES0_LANE0_QSGMII_LANE2	0x1
> >  
> > +#define J722S_SERDES1_LANE0_PCIE0_LANE0		0x0
> > +#define J722S_SERDES1_LANE0_QSGMII_LANE1	0x1
> > +
> 
> Maybe this one patch can deal with both USB and PCIE0 additions to this file
> and could be moved earlier in the series.

Yes. I will combine this with the SERDES0 changes in the v4 series.

Regards,
Siddharth.

