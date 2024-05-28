Return-Path: <linux-kernel+bounces-192319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EDD8D1B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796021F226E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D6E16D9A7;
	Tue, 28 May 2024 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WxOEBSRX"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1CE1EB3F;
	Tue, 28 May 2024 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900014; cv=none; b=aFhKw8aEcdy/C4GxLQn6zY42sfqnvf+sjV+HbcF71V2VNh4E1GswBfWqUAFAAnPLOkImYguNK45SV3QCclfsD6m5r7YnI4qm3E99iCLYzQGgCXClFEtk7OUleX7Yc6w9DBmtUED63amK5zcpnvHoa0u2IgQOBmLzSPgHIq1D4FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900014; c=relaxed/simple;
	bh=4SZb5316HoMm9LNOOZ3NjsmNjeuq0xc25cnVq+4jA4U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ym93MMwmjGQ2ETGmIeZD1hfz8HzBDN5P3XkFpTzHLrSvIkRTKrQqdqRUEG1s0aW6qSKzCQ/NxNJut0bw3UWLC7h8T+vEDi/xdAfW4yFGW/qoa5UJJh3UgONPY6GQJ5ftxaC0EVpba/M593fRzqSUvv3Ntotyym71ayeG2cpyh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WxOEBSRX; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44SCe6xM070292;
	Tue, 28 May 2024 07:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716900006;
	bh=jTsHTaofRi+cGKXVUS/i5zj6YDkm9QSUpwme8f7QUag=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=WxOEBSRXU79o/dP1pm+GaCR+mYfXR53bhePfBk9EXpHzvorekjxTIm9wXZ31jDvNu
	 gmT4DAjNrVNUeRxy4zPDOfGMJV3a5oW1cyRy5ds4DqK9opRbExy50psWvYsp274rLC
	 cPTheQnxXm5Tc42SsJMYBeRzVnsvQXvV0L6q7RgQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44SCe68O024318
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 May 2024 07:40:06 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 07:40:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 07:40:05 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44SCe4oi080379;
	Tue, 28 May 2024 07:40:05 -0500
Date: Tue, 28 May 2024 18:10:04 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <afd@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v3 3/7] arm64: dts: ti: k3-j722s-evm: Update USB0 and USB1
Message-ID: <17d2bcb8-084d-4b44-871a-28e5750f2636@ti.com>
References: <20240524090514.152727-1-s-vadapalli@ti.com>
 <20240524090514.152727-4-s-vadapalli@ti.com>
 <db1a0b2d-1bf9-4bd4-98f5-8a38f46d6749@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <db1a0b2d-1bf9-4bd4-98f5-8a38f46d6749@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, May 28, 2024 at 03:18:25PM +0300, Roger Quadros wrote:

[...]

> > +	dr_mode = "host";
> > +	maximum-speed = "super-speed";
> > +	phys = <&serdes0_usb_link>;
> > +	phy-names = "cdns3,usb3-phy";
> > +};
> > diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> > index c75744edb143..61b64fae1bf4 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> > @@ -87,3 +87,8 @@ &oc_sram {
> >  	reg = <0x00 0x70000000 0x00 0x40000>;
> >  	ranges = <0x00 0x00 0x70000000 0x40000>;
> >  };
> > +
> > +/* Include bus peripherals that are additionally
> > + * present in J722S
> > + */
> > + #include "k3-j722s-main.dtsi"
> > diff --git a/arch/arm64/boot/dts/ti/k3-serdes.h b/arch/arm64/boot/dts/ti/k3-serdes.h
> 
> The k3-serdes.h changes should be in a separate independent patch.

Ok. Will create a new patch in v4 addressing your comments on patch 5 of
this series to combine Serdes1 changes as well into the same patch.

Regards,
Siddharth.

