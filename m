Return-Path: <linux-kernel+bounces-186048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA29F8CBF2E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8BD1C220E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C1882497;
	Wed, 22 May 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YO9TXAIL"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC874823BC;
	Wed, 22 May 2024 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716373326; cv=none; b=sFxhKW2BP0IcXQLOW4R18bWLAkwzH/ZM54LMP0u2hlON8Yvj/4ilf6tNbhpTxhVe0UBIEEEux/SFjb7GQBZAOvG3nji+W71/VRyLTpUhKomzazD88O9vf7ji/CTz9od7oWKZNN3s+HUHa2iB0IzD6uhZRxgBtg68SXac6enIA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716373326; c=relaxed/simple;
	bh=oswQw80SOVI7XFRanmCJKZ2zDU69jrRoyfhZPJHeVes=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApR+99TtM5TrVHjBcjbz1k1+j54dB9BdGjfr0wTWI1K7sI+r+0w4oNZlCB3LKugXf2QD8ILXnIND+P3k9h5Hm04xkqS0vvZ04oMYQdGLpUsM4/NPPL4NC2CjuFviN6T3lo//c7S3GxpmbgU37v3bLTYs2crVp/3+rBHZNhjckYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YO9TXAIL; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44MALjGB068239;
	Wed, 22 May 2024 05:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716373305;
	bh=h9TicpCuN89t+Mm5F9Q8A4vmSV0MDw9f3fI0WXx6qy0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YO9TXAILD479LkY6rz8VPpBZAoOmlGmFTk1CxX1cakrZiPb3TKqb96TMmzeijDhpJ
	 7O3sMWEvUhKEWGgFqm5Vnx5bplYfNR/VdStUpWQjctwvWOhodL0Wct5YFsNRs4eMMk
	 x3Y1FuNFsHBSPQIf/Yn5Xy1UL4dVtZYLsWauxEYc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44MALje7021537
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 May 2024 05:21:45 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 May 2024 05:21:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 May 2024 05:21:45 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44MALiMI093511;
	Wed, 22 May 2024 05:21:44 -0500
Date: Wed, 22 May 2024 15:51:43 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <danishanwar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: ti: k3-j784s4-main: Add PCIe nodes
Message-ID: <47146d6c-bab3-4089-8dd5-4d71762bba2c@ti.com>
References: <20240520101149.3243151-1-s-vadapalli@ti.com>
 <20240520101149.3243151-2-s-vadapalli@ti.com>
 <20240521200909.GA3707@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240521200909.GA3707@francesco-nb>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, May 21, 2024 at 10:09:09PM +0200, Francesco Dolcini wrote:
> On Mon, May 20, 2024 at 03:41:47PM +0530, Siddharth Vadapalli wrote:
> > TI's J784S4 has two instances of Gen3 x4 Lane PCIe Controllers namely
> > PCIE0 and PCIE1. Add support for the Root Complex Mode of operation of
> > these PCIe instances.
> 
> What about PCIE2? J784S4 has 3 PCIe instances, it would be beneficial to
> add all 3, not just the first twos.

Thank you for reviewing the patch. I agree that it was incorrect for me
to mention that J784S4 has two instances of PCIe. It actually has 4
instances as mentioned in the Excel Sheet provided along with the
Technical Reference Manual at:
https://www.ti.com/lit/zip/spruj52
namely PCIe0, PCIe1, PCIe2 and PCIe3.

Since the J784S4 EVM has only PCIe0 and PCIe1 instances of PCIe brought
out, I was able to test them and therefore added support for only those
two instances in this series. However I do agree that all 4 should be
added to the SoC file (k3-j784s4-main.dtsi) for the sake of completeness
in terms of describing the SoC, while the Board file (k3-j784s4-evm.dts)
can still contain just PCIe0 and PCIe1 as those are the ones brought out
on the board. I will implement your suggestion in the v3 series.

Regards,
Siddharth.

