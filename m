Return-Path: <linux-kernel+bounces-386680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380E49B46D6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAA91C221D1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85337204F80;
	Tue, 29 Oct 2024 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QrTtYg3K"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3920495C;
	Tue, 29 Oct 2024 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197719; cv=none; b=n3nxv3UdmN2PXwUkTYYe2ExS+scq7jGRSQoGUHTqBWk2Ojb7uX6+ChML4xh3EA82Yu8jXTHEDKw/sCqfmntOSdWAMdKG4VHgsb9GzzM6qYiKINyqn0gvQu505SR/vOMpdXhb07G6jECzQhdU3Ed9DiCiEIxIbb8F05CUX6btZcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197719; c=relaxed/simple;
	bh=1TC7htUT37EbsEzqzjfbayZWwxcj3FrgfGFtHN64S5U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddgdIJGFNxnIp2kx+Kp/JIOQyJOYapABSoQPobfY9DXtalrYk90DsczKLociT50BvlRuRRDMM1XNKc6T55gEYTP4aWMDIK8cybqGKea5skEo41ODNacIoWHHtSRYt41PA/FJEFLyDJbrLP+P7V/6x7+QgmYqHe0ZvJOAIw5SZc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QrTtYg3K; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49TASRji005328;
	Tue, 29 Oct 2024 05:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730197707;
	bh=OkmyWd+WEFnErbPoKlztVMnzbLGAaFnM1My2qYl8+jw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=QrTtYg3KN1nyWkN/J7RMszFEcK82Ad9TORSrBHrCa9xBobCmGofUPDJoAAfJz8HLO
	 FvQxxMr5h19x4dpzMqqBv6Po68iorEN1tk9X4qpPJUfwrQ2xlqRFR5A6bZbfRBHu1x
	 bjGAYnMwLkorSCr0IeWirhYkYslwn82qssAwELE0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49TASRdZ005531
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Oct 2024 05:28:27 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 05:28:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 05:28:26 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49TASQLY015477;
	Tue, 29 Oct 2024 05:28:26 -0500
Date: Tue, 29 Oct 2024 15:58:25 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Andrew Halaney <ahalaney@redhat.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Keerthy
	<j-keerthy@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Eric Chanudet
	<echanude@redhat.com>,
        Enric Balletbo <eballetb@redhat.com>, Udit Kumar
	<u-kumar1@ti.com>,
        Beleswar Prasad Padhi <b-padhi@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] arm64: dts: ti: k3-j784s4: Mark tps659413
 regulators as bootph-all
Message-ID: <20241029102825.fhyuk2rrjusysy7i@uda0497581>
References: <20240916-j784s4-tps6594-bootph-v3-0-ab70da0de7bd@redhat.com>
 <wl6ri2djky2rkfuaj6hhotzgie6el7leno2qupze6geshp6j4i@g7q5a2rt2cmr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <wl6ri2djky2rkfuaj6hhotzgie6el7leno2qupze6geshp6j4i@g7q5a2rt2cmr>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andrew,

On 09:56-20241010, Andrew Halaney wrote:
> On Mon, Sep 16, 2024 at 12:14:50PM GMT, Andrew Halaney wrote:
> > This series marks tps659413's regulators as bootph-all in order for
> > the nodes (and parent nodes) to be accessible during MCU's u-boot SPL.
> > 
> > This in turn is desired since the tps659413 needs its MCU ESM
> > state machine setup in order for the watchdog to reset the board.
> > 
> > This took me a little while to track down, as enabling the ESM, TPS6594,
> > etc in u-boot would result in the below boot failure:
> > 
> >     U-Boot SPL 2024.10-rc4-00007-g44b12cbcd1b3-dirty (Sep 06 2024 - 14:25:52 -0500)
> >     SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.4--v09.02.04 (Kool Koala)')
> >     Initialized 4 DRAM controllers
> >     SPL initial stack usage: 13408 bytes
> >     ### ERROR ### Please RESET the board ###
> > 
> > Which turns out to actually have failed far earlier in spl_early_init(),
> > due to these nodes not being accessible in u-boot. That's hard to tell
> > though since console isn't setup until later (and for that reason I
> > think spl_early_init()'s return value in j784s4_init.c isn't
> > evaluated since a panic() at that point would leave a user with *no*
> > information at all).
> > 
> > I've tested this in conjunction with a u-boot series which I'll link in
> > a follow-up response on the k3-j784s4-evm. I'd appreciate someone testing
> > on the k3-am69-sk at a minimum, as it should suffer the same fate if things
> > aren't setup appropriately.
> > 
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > ---
> > Changes in v3:
> > - Added Udit's Tested-by tags
> > - Reordered bootph-all to align with dts-coding-style (Beleswar)
> > - Link to v2: https://lore.kernel.org/r/20240911-j784s4-tps6594-bootph-v2-0-a83526264ab1@redhat.com
> 
> This applies fine still on linux-next, any chance this could be picked
> up?

You might've to re-spin the series, I saw that [0] got merged and you
might've to put j784s4 related changes in k3-j784s4-j742s2-evm-common.dtsi
now instead.

Regards,
Manorit

[0]: https://lore.kernel.org/linux-arm-kernel/20240902-b4-upstream-j742s2-v6-0-6a7aa2736797@ti.com/
> 
> The associated[0] u-boot change is dependent on this and it would be
> nice to get the wdog working on mainline u-boot + linux.
> 
> [0] https://lore.kernel.org/all/3bf2177d-178f-46bf-abfe-6f00a52c623b@ti.com/
> 
> 

