Return-Path: <linux-kernel+bounces-209530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB795903780
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7138B2DC16
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0A9178364;
	Tue, 11 Jun 2024 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q586rybk"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5B14D714;
	Tue, 11 Jun 2024 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096107; cv=none; b=KEXvRXDRG5EoP6TBWvDSOBWBSRDTbjs+tRX74u2xhUww70/aWCEMQxBIeQNTAKNN88x1cVc8WCD5OZs9l6qCbCDTteuhqjCfB7mJlUryaEOx5BMaV60FLCIHF7FbRgNR+X+s79WZ7XCAPfT8OK/Dna3sXt/efVzzMZk542KHdS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096107; c=relaxed/simple;
	bh=8NK0TQwjCqvoGf0Llref6rxWjOCcr9C4GZFcGYgSY64=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWeug6diZTY8/nxaOQYmfyfmWG5xydEW0b4ycXivWF0h1dsSGzO/PM/4VWSzmzdNToh8HA6HaWxfCqj330BP3hkeY1BhOTMmhHTrQNiwJdYqCQtU2OkFBHajcIQTVK/NzZ05nGgDULKZ7VGoDCNxITZq76oAcTphBBb/4URdlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=q586rybk; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45B8svMg050579;
	Tue, 11 Jun 2024 03:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718096097;
	bh=O5YjB1BLz0W9hCB2cFwvm5NGx+kjpnWemL+Vm8/hoPg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=q586rybkFbp6OxGX86jrLoqJLlcLniGJjHKABxFlQwTdOlQjuUV1GhOjx3g8j/OQD
	 xCssXrcPnT/7AYHHaQeUCnozpXOHL1xkWKrUVaJhRQKWY56WRk1sVHQpmGUwUSMYZm
	 eeqFUv0MTrskG9JTRbRUN2D+gSI50F63q6tZHJ/g=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45B8svti005144
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Jun 2024 03:54:57 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jun 2024 03:54:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jun 2024 03:54:57 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45B8suuo047297;
	Tue, 11 Jun 2024 03:54:56 -0500
Date: Tue, 11 Jun 2024 14:24:55 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <afd@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v5 1/7] arm64: dts: ti: am62p: Rename am62p-{}.dtsi to
 am62p-j722s-common-{}.dtsi
Message-ID: <975c90b1-6657-40c6-a336-7f1f58acf531@ti.com>
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
 <20240604085252.3686037-2-s-vadapalli@ti.com>
 <92af5f36-0c21-4b6e-adde-fcf21b540291@kernel.org>
 <902f024a-b0a1-4a0a-94e2-7cec064a91c6@ti.com>
 <6959494a-98ba-4ccf-973c-14d079b76f27@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6959494a-98ba-4ccf-973c-14d079b76f27@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mon, Jun 10, 2024 at 10:31:07PM +0300, Roger Quadros wrote:

[...]

> > Based on your suggestion, you seem to propose the following hierarchy:
> > k3-am62p-{main,mcu,thermal,wakeup}.dtsi = AM62P specific data
> > k3-am62p.dtsi = k3-am62p-j722s-common-main.dtsi +
> > 		k3-am62p-j722s-common-mcu.dtsi +
> > 		k3-am62p-j722s-common-wakeup.dtsi +
> > 		k3-am62p-j722s-common-thermal.dtsi +
> > 		k3-am62p-{main,mcu,thermal,wakeup}.dtsi +
> > 		<delta-5>
> > k3-am62p5.dtsi = k3-am62p.dtsi + <delta-2>
> > k3-j722s-{main,mcu,thermal,wakeup}.dtsi = J722S specific data
> > k3-j722s.dtsi = k3-am62p-j722s-common-main.dtsi +
> > 		k3-am62p-j722s-common-mcu.dtsi +
> > 		k3-am62p-j722s-common-wakeup.dtsi +
> > 		k3-am62p-j722s-common-thermal.dtsi +
> > 		k3-j722s-{main,mcu,thermal,wakeup}.dtsi +
> > 		<delta-6>
> 
> What is the equivalent of k3-am62p5.dtsi here?
> That should contain k3-j722s.dtsi + CPU and OPP stuff.
> 
> I suppose it should be named specific to the SoC variant part number?

AM62P (https://www.ti.com/product/AM62P) has two variants:
1. 2 Arm Cortex-A53 => AM62P3
2. 4 Arm Cortex-A53 => AM62P5
Both variants will share the common k3-am62p.dtsi

J722S (https://www.ti.com/product/TDA4VEN-Q1) has only one variant:
4 Arm Cortex-A53 => J722S
Which is currently identical to AM62P5 w.r.t. the number of A53s.

So there isn't an equivalent of AM62P5/k3-am62p5.dtsi for J722S.
k3-j722s.dtsi is a combination of k3-am62p.dtsi and k3-am62p5.dtsi.

Regards,
Siddharth.

