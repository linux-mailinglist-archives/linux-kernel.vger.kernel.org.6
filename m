Return-Path: <linux-kernel+bounces-215065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C520908E09
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7025628BDD9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144DE13C671;
	Fri, 14 Jun 2024 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vYUuU2+n"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85A4107B6;
	Fri, 14 Jun 2024 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377204; cv=none; b=ASQbxXQHc9zhT4WJ4Co6+EULX4rHi0dy+mnGDEu3bF91eRkpftwLl1yCAM26RxWfRLzhC3/5s7bg8uSbKMH6nFrfNyWCk8ALNObVbF+WZtomgNXsqdLf1IdLU+6cT09/+t9xctcJvQ2WlvRDQdztoyW1sMJWM9ZiQv1SkU9rF1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377204; c=relaxed/simple;
	bh=HG7tUk5f2GMVDaroNXwyvAuKKxoNRRjFQOiOSXymybk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBc3F2OECwYNDbtqs448NVzQLFuEgdFISY4XcovT2rky+j1IIqyfTPB6QTkWg3eBqGw9J4i4kdKNBT+YUneF71ixJXi1vASU7e/LvnNMs0fMyETLREFpgMxXZ9WFBB96poRr1GRtSSooKx02JUGyp2ruBNT3vkq3QXNQ1gfieGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vYUuU2+n; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45EExl7U104954;
	Fri, 14 Jun 2024 09:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718377187;
	bh=TomOE3JPf28M6CJ/1WrFKx7BcSJaRCno0blGFncVygY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=vYUuU2+n6BdudYVX7RTomlHZAX6EGcfZo9M/YaXlypw5Pa0q/iGIP8hrGZrkiuRlb
	 JwT+FccvM4hzJHIqQAb6CiCR+MPtuZ/2gOqxrayHCGPpMqP4Kmo+YDdB47b4plEpGv
	 DE04jkPA5ntzRk5r5hbPfZ50KJh0VZcIgPafX4aY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45EExlWj006674
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Jun 2024 09:59:47 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 09:59:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 09:59:47 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45EExkp5009807;
	Fri, 14 Jun 2024 09:59:47 -0500
Date: Fri, 14 Jun 2024 20:29:46 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <afd@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v6 5/8] arm64: dts: ti: k3-j722s: Move MAIN domain
 overrides to k3-j722s-main.dtsi
Message-ID: <8b06ba3e-f4b2-4654-aaaf-2f15816fff07@ti.com>
References: <20240612132409.2477888-1-s-vadapalli@ti.com>
 <20240612132409.2477888-6-s-vadapalli@ti.com>
 <d4c33ee4-1e91-40e5-90c8-bd793bcf34ff@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d4c33ee4-1e91-40e5-90c8-bd793bcf34ff@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Fri, Jun 14, 2024 at 12:53:37PM +0300, Roger Quadros wrote:
> Hi Siddharth,

[...]

> > --- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> > @@ -232,14 +232,3 @@ cbass_wakeup: bus@b00000 {
> >  
> >  /* Include J722S specific peripherals */
> >  #include "k3-j722s-main.dtsi"
> > -
> > -/* Main domain overrides */
> > -
> > -&inta_main_dmss {
> > -	ti,interrupt-ranges = <7 71 21>;
> > -};
> > -
> > -&oc_sram {
> > -	reg = <0x00 0x70000000 0x00 0x40000>;
> > -	ranges = <0x00 0x00 0x70000000 0x40000>;
> > -};
> These are originally set in k3-am62p-j722s-common-main.dtsi
> which cannot be as they are not common to both SoCs.
> 
> Should we be moving the AM62 specific portion into k3-am62p-main.dtsi.
> 
> So they are no longer overrides but SoC specific changes?

Roger,

Thank you for reviewing the patch. I will remove the above properties
within the respective nodes of k3-am62p-j722s-common-main.dtsi and add
them to match the respective SoC in k3-{soc}-main.dtsi.

Regards,
Siddharth.

