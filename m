Return-Path: <linux-kernel+bounces-200057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818478FA9E9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985E5B211BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC48313D897;
	Tue,  4 Jun 2024 05:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fK+6aR5s"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E7DECC;
	Tue,  4 Jun 2024 05:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717478505; cv=none; b=t56urVUZ+Ldgi1NDaxk2OdCEmt9rWpFy65YzQxU0RotX07+pgtOI5PHHGj52ZrTq42kG69xtqRNTqdBcjhNI8ZbcTZJcUhpODO3ngzuwBTNhWRz/MELmZUd90tpkwzbqi4G+CCMrsdiYp4qYZ7V8jRKRC5gVtkxeCkF3ts1E7qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717478505; c=relaxed/simple;
	bh=PPwDM+cK0jYX6KH3xFAyAG/oiI4Uuqd/jPhJuFNlBk4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sr8POOgt9QgWFguVUHBofAvcFhr7jxjkmACBE8ynOnFTmGC44X+TNlnaHNoQtYRKPR/HPzCpwaiL405suc95Efi3nB5WTNYmgjc13SxujT4anv1AZOiNTMUBgrf8j5f0mihoHSffLmj8olPtKk1Urh6mY7KGMNU58TNRw/dcTJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fK+6aR5s; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4545LcL7043608;
	Tue, 4 Jun 2024 00:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717478498;
	bh=8EkoY6CLjXFYXkNHVxfUYjPBu/x3JAPfwtGw2dOQtKU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=fK+6aR5sRroAzJZtUZ1VOf+uO7mqchdzWceLiECWmQ7x5xCeKTAbhjaPM0bMSyN3x
	 jVT1/4I4c6woRXduMncGOLHu2prYnPgBvORjIBCgBG64hbamGpkMULynnXiOP+f10x
	 paYZ/by+ab4JQwQC84T15UNHqQH53ChxlBnw5HLY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4545Lc8k034022
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 00:21:38 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 00:21:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 00:21:37 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4545LbjF074455;
	Tue, 4 Jun 2024 00:21:37 -0500
Date: Tue, 4 Jun 2024 10:51:36 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v4 6/7] arm64: dts: ti: k3-j722s-main: Add SERDES and
 PCIe support
Message-ID: <4c29a5d9-d7ec-4175-b726-c41e2711ac0f@ti.com>
References: <20240601121554.2860403-1-s-vadapalli@ti.com>
 <20240601121554.2860403-7-s-vadapalli@ti.com>
 <147d58a6-0cad-47b6-a069-755f835a77e9@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <147d58a6-0cad-47b6-a069-755f835a77e9@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mon, Jun 03, 2024 at 09:17:43AM -0500, Andrew Davis wrote:
> On 6/1/24 7:15 AM, Siddharth Vadapalli wrote:
> > J722S SoC has two instances of SERDES namely SERDES0 and SERDES1 and one
> > instance of PCIe namely PCIe0. Both SERDES0 and SERDES1 are single lane
> > SERDES. The PCIe0 instance of PCIe is a Gen3 single lane PCIe controller.
> > 

[...]

> > +
> > +		serdes0: serdes@f000000 {
> > +			compatible = "ti,j721e-serdes-10g";
> > +			reg = <0x0f000000 0x00010000>;
> > +			reg-names = "torrent_phy";
> > +			resets = <&serdes_wiz0 0>;
> > +			reset-names = "torrent_reset";
> > +			clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
> > +				 <&serdes_wiz0 TI_WIZ_PHY_EN_REFCLK>;
> > +			clock-names = "refclk", "phy_en_refclk";
> > +			assigned-clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
> > +					  <&serdes_wiz0 TI_WIZ_PLL1_REFCLK>,
> > +					  <&serdes_wiz0 TI_WIZ_REFCLK_DIG>;
> > +			assigned-clock-parents = <&k3_clks 279 1>,
> > +						 <&k3_clks 279 1>,
> > +						 <&k3_clks 279 1>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			#clock-cells = <1>;
> > +
> > +			status = "disabled"; /* Needs lane config */
> 
> Does the other SERDES (serdes1) not need this config? It looks like
> it does in the board file.. If so disable it too.

The "lane config" being referred to here is set by the "serdes_ln_ctrl"
mux. The idle-states being set in the board file match the reset values
of the mux, so it is not technically necessary to disable it. However, I
will go ahead and disable SERDES1 as well and enable it in the board file
in the v5 series. Thank you for the review.

[...]

Regards,
Siddharth.

