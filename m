Return-Path: <linux-kernel+bounces-272166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135C4945801
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99FCDB23DA1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CE747A76;
	Fri,  2 Aug 2024 06:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iiXbEsaz"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301F720B28;
	Fri,  2 Aug 2024 06:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722579346; cv=none; b=Lw4sYR2saQeXXdSnwEZUWqFQA+414AM2V6Fred1LRb1VGRdCAjCEji6dE90ZB+ICKCasIHIQYomHKg7XbvZSpg+fmxyhsODH9DLDPPe1FNc2vu34mYz6VY31wNZGyH76sQNO4gm85ugvRX8jm9mKeTaubKVF6FoC8xmVItxFF+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722579346; c=relaxed/simple;
	bh=JZb/Or9qpURnR9gRJrOJ8FvoSO3hApEfbk6TU2ea5sc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIYnWW22D4WyfE/hGOaIWwzStY3/9eskXmIRDGl/6OilIp5BaVMA02uhpMuxeDrEdaEDz84QngyDBuIGlwU9Zb80u3z7IUSNArGT/iuNbCFKV5bKO9zP0JE44J02JDzolFa4zuOleEAav0P2VkDhV5LQh5Zizpyk4sqrAAVhAqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iiXbEsaz; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4726FRXv004096;
	Fri, 2 Aug 2024 01:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722579327;
	bh=roj1YKJRrCZRIfw1JLvtG05h+2KyDfE2v87x1/5J5W0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=iiXbEsaziWznFe6bZ70/xxcJ49RURZuYwsvLAf3coivxxmHkj30nkj5WY8tFOR1Rd
	 RK68XRiITdFyojWp5mJ6QCqXEcmWQxkJy9AYWzLBy19SW+k07o+Ncv8J2JdY8/+vxL
	 sSfNmxGiMtKfmKEQHMInlKmEDkYdo6kTerUYKykk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4726FRh3024074
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 Aug 2024 01:15:27 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Aug 2024 01:15:27 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Aug 2024 01:15:27 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4726FQVr078650;
	Fri, 2 Aug 2024 01:15:27 -0500
Date: Fri, 2 Aug 2024 11:45:26 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Peng Fan <peng.fan@nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>,
        "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>,
        "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>,
        "mturquette@baylibre.com"
	<mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
Subject: Re: [PATCH V2] clk: scmi: add is_prepared hook
Message-ID: <20240802061234.njlviydzmjbsyteb@lcpd911>
References: <20240726131007.1651996-1-peng.fan@oss.nxp.com>
 <20240726135231.hhzp3dqgx64e6kiw@dhruva>
 <ZqO2Nn7Wofs_wfkQ@bogus>
 <PAXPR04MB845938597DBD50DE1D1C0A1088B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845938597DBD50DE1D1C0A1088B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Peng,

On Aug 01, 2024 at 03:35:37 +0000, Peng Fan wrote:
> Hi Sudeep, Dhruva,
> 
> > Subject: Re: [PATCH V2] clk: scmi: add is_prepared hook
> > 
> > On Fri, Jul 26, 2024 at 07:22:31PM +0530, Dhruva Gole wrote:
> > > On Jul 26, 2024 at 21:10:07 +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Some clks maybe default enabled by hardware, so add is_prepared
> > hook
> > > > for non-atomic clk_ops to get the status of the clk. Then when
> > > > disabling unused clks, those unused clks but default hardware on
> > > > clks could be in off state to save power.
> > >
> > > Just a nit - reword the commit message as:
> > > Then when disabling the unused clocks, they can be simply turned
> > OFF
> > > to save power.
> > >
> > 
> > Ah this was what it meant. I couldn't parse the original text and was
> > about to ask.
> > 
> > > Also if you can make it still verbose, explain when you expect this
> > > disabling of unused clks to take place exactly? During boot?  Driver
> > probe sequence?
> > > or By some user commands?
> > >
> > 
> > Agreed. Being little more verbose here would be beneficial IMO.
> > 
> 
> I will use below in V3:
> "
> Some clocks maybe default enabled by hardwar. For clocks that not 

s/not/don't

> have users, they will be left in hardware default state, because prepare

s/they/that, will be left in default hardware state.

> count and enable count is zero,if there is no is_prepared hook to get
> the hardware state. So add is_prepared hook to detect the hardware
> state. Then when disabling the unused clocks, they can be simply
> turned OFF to save power during kernel boot.
> "

Thanks, rest looks better.

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

