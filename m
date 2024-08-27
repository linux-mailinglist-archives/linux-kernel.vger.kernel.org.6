Return-Path: <linux-kernel+bounces-303400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27E6960B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE952867C6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A1A1BF33A;
	Tue, 27 Aug 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Gtp+w5y0"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806E11BE234
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764429; cv=none; b=GHXsyjp79L+Naj6Y1UHXGSah1VepoDrn7rJuF8KoXgmDcVvmL9kvUPEmd2FUdJeq9nRNWUUims6NzjsEW86FijfoVJcGBa1BWN8ALPok7GVvi7ElbTs17UP/DhHyvAlQqlXg6AIMVIldUMzMRtvjjoCbUiIvsz4XfT6b1XN7R4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764429; c=relaxed/simple;
	bh=ni9G1S4E/Zcoya3p7dd4iVfMl5d5cjwBAZW7p+cjrHY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/vybURalWSc9HUnI8IHK/Jc4rNOhNq4ECQxAjgr/RgpndV1iqf8FoABqcWgvi+ENFIn7MRRl4DneqOfO8q7q1Wex38c65jrJ71t5L2h7mHBlILgllwEJOTQV/pNF/q4EDxSMZ6kJwcnmO+EvUgCCUJ7szfOAr8wi14wUMV2JUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Gtp+w5y0; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47RDDg8q048627;
	Tue, 27 Aug 2024 08:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724764422;
	bh=HdPtO5uCCrARzRd5hu48H8CTluw1dxlNvgyjhkO3yqU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Gtp+w5y0dbzmST35cTi0VobRiNHLytSttIoBB+sfY10nxvPA8uvHUqeYz6nR69FgB
	 EZ8i3uwmn5d+p7lYmdpQOtJ2GFQvZB3VR59wBXuNF3atXFV95bJx1DAN4oV6v/OjDB
	 nGImRv33NtgnopPGMOvcvBPtiVzpS5Fz1KgsOXR0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47RDDgMa026117
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Aug 2024 08:13:42 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Aug 2024 08:13:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Aug 2024 08:13:42 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47RDDgZ0064263;
	Tue, 27 Aug 2024 08:13:42 -0500
Date: Tue, 27 Aug 2024 08:13:42 -0500
From: Bryan Brattlof <bb@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62: use opp_efuse_table for
 opp-table syscon
Message-ID: <20240827131342.6wrielete3yeoinl@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240827080007.2097276-1-d-gole@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240827080007.2097276-1-d-gole@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On August 27, 2024 thus sayeth Dhruva Gole:
> Add another entry in the wkup_conf for the syscon node, and then use
> that for the syscon in opp-table.
> 
> Marking entire wkup_conf as "syscon", "simple-mfd" is wrong and needs to
> be addressed similar to how other child-nodes in wkup_conf are implemented
> in the same file.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> 
> Based on the discussion we had on [0] for AM62P/A devices setting OPP,
> Here we fix the AM625's opp-table using the syscon region in wkup_conf.
> 
> Build tested on top of linux-next.
> 
> Cc: Bryan Brattlof <bb@ti.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Vibhore Vardhan <vibhore@ti.com>
> 
> ---
> 
>  arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 5 +++++
>  arch/arm64/boot/dts/ti/k3-am625.dtsi       | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> index e0afafd532a5..3aff8af549a5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> @@ -22,6 +22,11 @@ chipid: chipid@14 {
>  			reg = <0x14 0x4>;
>  		};
>  
> +		opp_efuse_table: syscon@18 {
> +			compatible = "ti,am62-opp-efuse-table", "syscon";
> +			reg = <0x18 0x4>;
> +		};
> +
>  		cpsw_mac_syscon: ethernet-mac-syscon@200 {
>  			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
>  			reg = <0x200 0x8>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am625.dtsi b/arch/arm64/boot/dts/ti/k3-am625.dtsi
> index c3d1db47dc9f..c249883a8a8d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am625.dtsi
> @@ -108,7 +108,7 @@ cpu3: cpu@3 {
>  	a53_opp_table: opp-table {
>  		compatible = "operating-points-v2-ti-cpu";
>  		opp-shared;
> -		syscon = <&wkup_conf>;
> +		syscon = <&opp_efuse_table>;

Ah I wish it was as easy as this. Unfortunately ti-cpufreq.c embeds the 
0x18 offset from the start of the WKUP_CRTL_MMR to get to the 
JTAG_USER_ID[0] for the AM62x. For the AM62Ax and AM62Px I used a 0x0 
offset which is why this works for them. (Essentially hacking around the 
issue until I could find a way to fix this)

I think we may need some coordination between the different maintainers 
to get this fixed without breaking DFS for the AM62x for a release. That 
or we could add some logic in the driver to check for an offset in this 
property eg: 'syscon = <&opp_efuse_table 0x18>;' and use that. The end 
goal is to not need the offset at all so this is a lot of noise 
generation just to keep things working while we clean it up.

All of the solutions I can think of are super messy unfortunately.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/cpufreq/ti-cpufreq.c#n302

~Bryan

