Return-Path: <linux-kernel+bounces-200059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FE08FA9EF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB081C21CD2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C37E13D8B1;
	Tue,  4 Jun 2024 05:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fVxnjAi9"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B4113D897;
	Tue,  4 Jun 2024 05:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717478587; cv=none; b=b5AXJ2Rl6+QPKn0dQtrhiS2WGzT0iZmUEge4cHbYXk6tKmpvcI48XdKHOcz3ADlJwB2B5Znirs9xJ5VIruQIdllzJ/xbWpfCciRryoEXtfU+6pImw63WfBYyYyXkxIaJ5nVRLzVYNIjxgk7KPhd+lUxfmZIb6qPz6wXtKAWy5Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717478587; c=relaxed/simple;
	bh=sIcnw1Nz6+sVOmj6zqFe9Zr49SXCPufWzsqugWylHOU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIbxMl7e/tMGb3tWOPh9Kj1HNn5GB0ooVVDEjmjmWj66iwUu/C0QWKal7cx8TO3L+Caq6e9VdMdGtZOGhWKL9yaV7MX4FGCMAJ9lyEJ0lTFJerQrQ7/3xYZbUPW18iB+us4G9VNZcgVpOBWH2/TRwVL3dRfQHuhoKFjdX5z1BxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fVxnjAi9; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4545MwVI028662;
	Tue, 4 Jun 2024 00:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717478578;
	bh=bkiCGbzvhMTeeJpJIuI8oF35TUWmfX/tf/88F1Nw4oA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=fVxnjAi9VilZVWHJbZn9ebcdP5+GQxlH75QxFeXXjkxwmwz+xqXGT50zPr3roDiIG
	 tunsLuNKOgHu53n32Z5SHUTrDo21yk9VDZDNdjIke/AMH5qrGpTkaU0pO+wEcllzJW
	 IZKdduL8m3I0sPGb9to3BorBVRPwE9oiarBYHTBM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4545MwF5110093
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 00:22:58 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 00:22:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 00:22:58 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4545Mvpm121814;
	Tue, 4 Jun 2024 00:22:58 -0500
Date: Tue, 4 Jun 2024 10:52:57 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v4 7/7] arm64: dts: ti: k3-j722s: Enable PCIe and USB
 support on J722S-EVM
Message-ID: <90781872-1933-4026-beb0-627932411187@ti.com>
References: <20240601121554.2860403-1-s-vadapalli@ti.com>
 <20240601121554.2860403-8-s-vadapalli@ti.com>
 <183a9d15-939e-433b-84ba-8a64eb8ef3ec@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <183a9d15-939e-433b-84ba-8a64eb8ef3ec@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mon, Jun 03, 2024 at 09:21:11AM -0500, Andrew Davis wrote:
> On 6/1/24 7:15 AM, Siddharth Vadapalli wrote:
> > Enable PCIe0 instance of PCIe in Root Complex mode of operation with Lane 0
> > of the SERDES1 instance of SERDES. Also enable USB0 instance of USB to
> > interface with the Type-C port via the USB hub, by configuring the pin P05
> > of the GPIO expander on the EVM. Enable USB1 instance of USB in SuperSpeed

[...]

> > +
> > +&serdes0 {
> > +	status = "okay";
> > +	serdes0_usb_link: phy@0 {
> > +		reg = <0>;
> > +		cdns,num-lanes = <1>;
> > +		#phy-cells = <0>;
> > +		cdns,phy-type = <PHY_TYPE_USB3>;
> > +		resets = <&serdes_wiz0 1>;
> > +	};
> > +};
> > +
> > +&serdes1 {
> > +	serdes1_pcie_link: phy@0 {
> > +		reg = <0>;
> > +		cdns,num-lanes = <1>;
> > +		#phy-cells = <0>;
> > +		cdns,phy-type = <PHY_TYPE_PCIE>;
> > +		resets = <&serdes_wiz1 1>;
> > +	};
> > +};
> > +
> > +&pcie0_rc {
> > +	status = "okay";
> 
> As much as I like these at the top, the new format rules seems to
> suggest "status" properties should go at the bottom of the node.

I failed to notice that. Thank you for pointing this out. I will fix
this in the v5 series.

[...]

Regards,
Siddharth.

