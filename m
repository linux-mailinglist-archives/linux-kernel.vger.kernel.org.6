Return-Path: <linux-kernel+bounces-424509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 806AD9DB526
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A38168620
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C2E158527;
	Thu, 28 Nov 2024 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="subYZv/q"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C648152E0C;
	Thu, 28 Nov 2024 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787906; cv=none; b=qeqfbgJJNeIVVAbSrnr9tqiruBcSMHgU5piOFHFYV6Nw7/mchhfWPnFs540tegNPFHG8VNEeAu1itotZDoiLoQl49G19r2cQK2WvdWDVgKekv4w6B1qvLJ7lQmLEuAkYmoNKgLb3ngo807iZWobxi/Ftexmn9N/jHX8chy88tJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787906; c=relaxed/simple;
	bh=0UnuoR0sx0jhOSSR0WO8rJAQUivimvP18NgQ33LMlb8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ak+5i11fGfGwK6hHZn2kB/q8Q3r4PSDtDYQfYtXWlblUlam2cOE3gKEjoJMhkTALdIlrUM1bVuYDZypblHyTvFcIJ1aPh6Fx7rzprDRuGnDS3TxJvk3jmg3FEJIRu6nu/MRmZ38+WtD/+F6do9x6QXzSNtAUrhLmQgU66zGpx3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=subYZv/q; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AS9wFd1733194
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 28 Nov 2024 03:58:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732787895;
	bh=lzEelM7jIbS2O9RdoknMU1gIWK7OayEz8i4ohIB16uQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=subYZv/qrk2LUGil3IpxfTnfzEpgw5bG3kX+ZLh8QbiA9EsKKfSdnhYZ66yXkdHqL
	 4A9j0ukm0FN82koccm6XExL2PUyg+8DbR2yXp2eI92sy1lUUqNfIfE30Qz8yDMlMhl
	 mAildoxYj/KpL4hajhTajmYrdXF+2T4Sl3+5hJ7Y=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AS9wFFW030473;
	Thu, 28 Nov 2024 03:58:15 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Nov 2024 03:58:15 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Nov 2024 03:58:14 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AS9wDAi126610;
	Thu, 28 Nov 2024 03:58:14 -0600
Date: Thu, 28 Nov 2024 15:28:13 +0530
From: s-vadapalli <s-vadapalli@ti.com>
To: Enric Balletbo i Serra <eballetb@redhat.com>
CC: s-vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dasnavis Sabiya
	<sabiya.d@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am69-sk: Add USB SuperSpeed support
Message-ID: <wbsg3fmco6rwjj7vtiqtqv7trfjor73j7rjx7efnlafo4pz4bc@awixm2iygd55>
References: <20241126-am69sk-dt-usb-v1-1-aa55aed7b89e@redhat.com>
 <2nuncc5rscu6h74ylaiu6yozg34aoigaj5d4uzvdtolt5q7bmv@6hacpxyb2532>
 <CALE0LRtUN2N_Z05jH_BMSg7yvirSRob0pSErmQxTu8AatmODgw@mail.gmail.com>
 <CALE0LRu-Sx5oTVNY3hm+Msu-zb04a7_ZD+r3xF1eRfR_WtK0VA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALE0LRu-Sx5oTVNY3hm+Msu-zb04a7_ZD+r3xF1eRfR_WtK0VA@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Thu, Nov 28, 2024 at 10:47:42AM +0100, Enric Balletbo i Serra wrote:
> Hi,

[...]

> So I changed the dr_mode to otg instead of host and tried to configure
> a usb mass storage gadget but unfortunately didn't work, but this
> could be a driver problem, I got the following error
> 
>   UDC core: g1: couldn't find an available UDC
> 
> As the devicetree should describe the hardware, and as far as I can
> see it should support the type-c port act as a gadget, I'm fine with
> changing the dr_mode, unless anyone have more information about this,
> the thing that makes me think a bit more is that, in the TI kernel
> this is set to host, so I'm wondering if I'm missing something or is
> just that was never tested.

Are all interfaces (Type-A and Type-C) functional as Host when the
dr_mode is set to "otg"? (Do USB devices connected to the interfaces
enumerate on AM69-SK?) If yes, then it could be a DIP Switch setting
that is related to OTG mode of operation or a USB-C Mux that needs to be
configured.

Regards,
Siddharth.

