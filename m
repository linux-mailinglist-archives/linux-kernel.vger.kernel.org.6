Return-Path: <linux-kernel+bounces-277876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A70894A790
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37736B2258F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6821E4F08;
	Wed,  7 Aug 2024 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pQLsIIhl"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690371DF666;
	Wed,  7 Aug 2024 12:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032807; cv=none; b=L5CwwVBZsvHTGWl98UM5BEwADPCsoGQRV6CakIc61+5/y5pzTD9VjlSyDqPGJxusUamNIByRXqyTnlEFUlfPCnpayibY8Vulm/6vowO7oYq6Rm8s8Ys8iZvCsJkERVfKlc0vgY67zpoDjtKB/F/y4r4/ZiQ44HlYed/XlrfBJgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032807; c=relaxed/simple;
	bh=3kfpJo+wMpggXMSS5agrf0k25FR9X/p3GXtFP3xVQNI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghTO6WjO7edUQ/bELi3HRaF0EYuvEvVp4IzbXGPSDRg5Iq8ZQXkLm2TscPDK6IId3jo2om/xRvFtMAc4Br7sMt1+5cHTrMNPfxrBqxplQHjAmHIGLMUXIPgI7WyFiMkjEw9WHeZTPKjXCj5A44eXF1xLXCfMKVsln+KZLOXXCCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pQLsIIhl; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477CD0TB052920;
	Wed, 7 Aug 2024 07:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723032780;
	bh=76GhB039/pkZ+5h3Gud0EPB+m3ow6AVmf3vw1wZnOoA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=pQLsIIhlsoEBaII3mLcMPvKOOntQjWJCdQoTJg3/GbYeWpnAaAcucfXpv4fdf5rR+
	 7a/ZBu4OtAhqwob+lB765siBIHSK5vPdKPtfxEkHU5lI/xl2TWtpzR8k1yssyqCO7K
	 mbxud8V2F/GGjGsuHcSrY695JOnP++1LSCKK9K5Y=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477CCx6S094952
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 07:12:59 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 07:12:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 07:12:59 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477CCxd4004855;
	Wed, 7 Aug 2024 07:12:59 -0500
Date: Wed, 7 Aug 2024 07:12:59 -0500
From: Nishanth Menon <nm@ti.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@ew.tq-group.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am642-tqma64xxl-mbax4xxl: add PRU
 Ethernet support
Message-ID: <20240807121259.fdu5eigadsanz43v@headpiece>
References: <20240624134235.202243-1-matthias.schiffer@ew.tq-group.com>
 <3bce26bc327b4d1c63bf0ef32caae854893969a0.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3bce26bc327b4d1c63bf0ef32caae854893969a0.camel@ew.tq-group.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 14:02-20240807, Matthias Schiffer wrote:
> On Mon, 2024-06-24 at 15:42 +0200, Matthias Schiffer wrote:
> > Add PRU Ethernet controller and PHY nodes, as it was previously done for
> > the AM64x EVM Device Trees.
> > 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> > 
> > v2:
> > - Dropped binding change patch
> > - Moved prueth device node to DTS toplevel, matching the AM64x EVM
> > - Update firmware filenames to match EVM
> 
> Hi, are there any issues remaining with this patch?

I think it just fell through the cracks with the last tag being applied
around the same time. Can you rebase to v6.11-rc1 and resend? apologies
on the troubles.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

