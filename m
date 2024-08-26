Return-Path: <linux-kernel+bounces-301827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DE995F62C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168242828FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6761547E9;
	Mon, 26 Aug 2024 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wLmlNovv"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CF7153812;
	Mon, 26 Aug 2024 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688722; cv=none; b=tcT5oeN+ztq/xSQ9PXcc1Urfe+Fzf4AZI0lXYOrxo+g0d69WlbLvCIbgYk42z2HSHkNYpvJTrmkzXr9NpH3I/NqfyBIi5PXjYDlgfW/H+8G8xQUFX0XsNrtGHgRt2u9F6c+4S75yowHekdht+u4t25VS7EpsIVGnieM9m0kCD+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688722; c=relaxed/simple;
	bh=jUQP68nUlki+cXW8OTLr++soCeGVktbXwYkW06PRrPc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANQ0MNg1l9/xLaRePF5lSg3eQIvKeOBQBmTRRzDYP9gkSr8iwHRMv8CwPZvBKPgbzW66+xaCmPTWItykorHhtklDbbiuDnL9JEKfspYEYJq/uEZBMaYu6Klz7JTDNSGByTA4CN46zntx3mTR8wk9MnOILLQYBreOgDe1KuuLTvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wLmlNovv; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QGBncw056660;
	Mon, 26 Aug 2024 11:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724688709;
	bh=zuc0ZpG16+l9Hej5rugykPnBSFVg7zD0PpDd9bXudNE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=wLmlNovv2yTAuOjIAneQSo29UEulDea1fPFfRECzdvWcLwlmoN2030xeRxgb4vPpy
	 yMZEqs9diND+dxDtPPMG7O+/F2B1EOwgz8MPB8wswXk4q6Ik9e9j8zD3XBuetTRJcp
	 74MeMI5VyG1MoEuB+qdXQ0Vtlim8O9go9z6Hs8Sg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QGBnZ5094345
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 11:11:49 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 11:11:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 11:11:49 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QGBnTM041893;
	Mon, 26 Aug 2024 11:11:49 -0500
Date: Mon, 26 Aug 2024 11:11:49 -0500
From: Bryan Brattlof <bb@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] arm64: dts: ti: k3-am62p: add opp frequencies
Message-ID: <20240826161149.2hnfpjslsdyezn72@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240823-opp-v2-0-e2f67b37c299@ti.com>
 <20240823-opp-v2-3-e2f67b37c299@ti.com>
 <20240826132311.igliqicrydtifp2s@lcpd911>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240826132311.igliqicrydtifp2s@lcpd911>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On August 26, 2024 thus sayeth Dhruva Gole:
> Hi Bryan,
> 
> On Aug 23, 2024 at 16:54:30 -0500, Bryan Brattlof wrote:
> > ONe power management technique available to the Cortex-A53s is their
> 
> s/ONe/One
> 
> > ability to dynamically scale their frequency across the device's
> > Operating Performance Points (OPP)
> > 
> > The OPPs available for the Cortex-A53s on the AM62Px can vary based on
> > the silicon variant used. The SoC variant is encoded into the
> > WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID register which is used to limit
> > the OPP entries the SoC supports. A table of all these variants can be
> > found in its data sheet[0] for the AM62Px processor family.
> 
> Error 404! Not found [0] ;)
> 

Oops. I'll fix these up

> > 
> > Add the OPP table into the SoC's ftdi file along with the syscon node to
> 
> What is ftdi?

FTDI is a chip, what I tried to type out was fdti or Flattened Device 
Tree Includes :)

> 
> > describe the WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID register to detect
> > the SoC variant.
> > 
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> >  .../boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |  5 +++
> >  arch/arm64/boot/dts/ti/k3-am62p5.dtsi              | 47 ++++++++++++++++++++++
> >  2 files changed, 52 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> > index 315d0092e7366..6f32135f00a55 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> > @@ -20,6 +20,11 @@ chipid: chipid@14 {
> >  			bootph-all;
> >  		};
> >  
> > +		opp_efuse_table: syscon@18 {
> > +			compatible = "ti,am62-opp-efuse-table", "syscon";
> 
> Huh, curious why I don't see this particular compatible in am62 itself..
> Also, I am still not clear where this discussion got left off: (If it's
> related)
> https://lore.kernel.org/all/5chxjwybmsxq73pagtlw4zr2asbtxov7ezrpn5j37cr77bmepa@fejdlxomfgae/
> 
> In AM625, I see
> k3-am625.dtsi:111: col 14: syscon = <&wkup_conf>;
> 
> But the approach you've used here seems different. Is there a
> justification given on which one should be used/why somewhere that I can
> refer?

Labeling the entire &wkup_conf as a syscon node is kinda abusing what 
the syscon node is used for. There are a lot of things inside that 
WKUP_CTRL_MMR that do not belong under the miscellaneous registers 
category. For the 62A and 62P we've chosen to label &wkup_conf as a bus 
with little syscon sub-nodes inside of it.  

I don't think the discussion[0] ever finalized but we started going that 
direction with new SoCs, looks like the older SoCs never received the 
cleanup.

~Bryan

[0] https://lore.kernel.org/all/e7114cb4-e24f-4e78-a89f-4e2e2e704b8a@ti.com/


