Return-Path: <linux-kernel+bounces-211234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D96904ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB867281479
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E3E16D9A4;
	Wed, 12 Jun 2024 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gYKIzj0t"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0144816C440;
	Wed, 12 Jun 2024 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183498; cv=none; b=gm3/phiMoR4e4DjjhDAiokIzPHn6mlIfYRJVsVABJBJypudqvdqtTeRrOEcoJcIoW6d8vHopsfQ7v++uHYDqheLzOhrw5Sbr7BbezvJvbY+WHdmaqK/tvA32LXkvLQNU/qrift58G34RW+ZybMApHITtAvFnC/13LAWwUnTRPuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183498; c=relaxed/simple;
	bh=NrQbjJLU21e6GXf/NiG18RADNv5NRWSmGn1C1T60kto=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TC3G0UubjDTdH7qLbtNthpEuBkKuHomEBs8VW/Uom1Utb2078B9kaH9q31yI4fXXAhhkCq9nM7UB5+XjE1qYSSV3SJ3Ywx+MYnSryQr0L247WlU2HkFg/AmUCrfgPGXSlRB6mL1t3zsWMrrL48UMekw85/P+AmX1SR57IxscTfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gYKIzj0t; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45C9BTKl125620;
	Wed, 12 Jun 2024 04:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718183489;
	bh=bq4wdMSaN4e+DblCXL5gIeFx8/S7d1V58QJzFk+BJGA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=gYKIzj0tmQ+xJPNwJ/xbmwyIcBvrGWrkugvvsp16f2EDDsL02v56Dhk9hp5V9BSWF
	 by+xgdTZUBh1VZaB8tqHAAZ5eVK40OsNWWxi+G3pdrWlSrF52cmzqjrkKVMo756XXo
	 G176ClMsVCw7oLp69QwCzBfH1BhLuY7G/25mKlWc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45C9BTxb054174
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 04:11:29 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 04:11:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 04:11:28 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45C9BSUl048466;
	Wed, 12 Jun 2024 04:11:28 -0500
Date: Wed, 12 Jun 2024 14:41:27 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>, <nm@ti.com>, <afd@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <u-kumar1@ti.com>, <danishanwar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v5 1/7] arm64: dts: ti: am62p: Rename am62p-{}.dtsi to
 am62p-j722s-common-{}.dtsi
Message-ID: <2f1aa07a-5a51-49aa-8829-c616cb9431bc@ti.com>
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
 <20240604085252.3686037-2-s-vadapalli@ti.com>
 <92af5f36-0c21-4b6e-adde-fcf21b540291@kernel.org>
 <902f024a-b0a1-4a0a-94e2-7cec064a91c6@ti.com>
 <6959494a-98ba-4ccf-973c-14d079b76f27@kernel.org>
 <975c90b1-6657-40c6-a336-7f1f58acf531@ti.com>
 <9e7d3f9b-c762-40cd-9d0d-2f071aa3c371@ti.com>
 <efcb16cd-83de-403c-885d-cf9d819e5da7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <efcb16cd-83de-403c-885d-cf9d819e5da7@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, Jun 11, 2024 at 08:18:34PM +0300, Roger Quadros wrote:
> 
> 
> On 11/06/2024 12:10, Vignesh Raghavendra wrote:
> > 
> > 
> > On 11/06/24 14:24, Siddharth Vadapalli wrote:
> >> On Mon, Jun 10, 2024 at 10:31:07PM +0300, Roger Quadros wrote:

[...]

> >>>
> >>> What is the equivalent of k3-am62p5.dtsi here?
> >>> That should contain k3-j722s.dtsi + CPU and OPP stuff.
> >>>
> >>> I suppose it should be named specific to the SoC variant part number?
> >>
> >> AM62P (https://www.ti.com/product/AM62P) has two variants:
> >> 1. 2 Arm Cortex-A53 => AM62P3
> >> 2. 4 Arm Cortex-A53 => AM62P5
> >> Both variants will share the common k3-am62p.dtsi
> >>
> >> J722S (https://www.ti.com/product/TDA4VEN-Q1) has only one variant:
> >> 4 Arm Cortex-A53 => J722S
> >> Which is currently identical to AM62P5 w.r.t. the number of A53s.
> >>
> >> So there isn't an equivalent of AM62P5/k3-am62p5.dtsi for J722S.
> >> k3-j722s.dtsi is a combination of k3-am62p.dtsi and k3-am62p5.dtsi.
> >>
> > 
> > 
> > Historically AM6xx devices have had CPUs in separte file as there are OPNs with different number of CPU cores Hence, how about
> > k3-am62p5.dtsi => k3-am62p.dtsi + k3-am62p-j722s-common-{main,mcu,wakeup}.dtsi + k3-am62p-main.dtsi (USB2 and other deltas specific to AM62P)
> > 
> > and since J722s has no variants with less than 4 cores (and along the lines of rest of J7xx devices):
> > 
> > k3-j722s.dtsi => k3-am62p-j722s-common-{main,mcu,wakeup}.dtsi + k3-j722s-main.dtsi (USB3, C7x and other deltas specific to J722s;
> > 
> > 
> 
> Seems OK to me.

Vignesh, Roger,

I will implement the above in the v6 series.

Regards,
Siddharth.

