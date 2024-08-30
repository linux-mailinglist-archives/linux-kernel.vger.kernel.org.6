Return-Path: <linux-kernel+bounces-308412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A296965CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A071F24723
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B348116F910;
	Fri, 30 Aug 2024 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vCShmVvC"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE64170A0A;
	Fri, 30 Aug 2024 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009777; cv=none; b=QIpPBQb+rw0MtZAh9VVXdvH61AecNFwIm/aupQl8VWI6g9OY9uMINUI69E4BqebxYOJCF53yRmEHOSD3NUyatfCQceX+zfVQ+exN7yX78a/hh71C8/rHzmuDE7Tgx+5R6/EGUf1S37QywZKUCnwJJ7snpYQi98r8lSaKWVHchO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009777; c=relaxed/simple;
	bh=hWVichCFb4//lsUtCk/pXGdF7ONLFMuLV87yk9v6tXE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txHfD182p11+zkdEeyatxjKCS5s5O9u7Rcis0IKukSWn2Xkk7wT8BzNucqAz5Qr+YShBvT7ruLsob5k+c7F0Sx/AQ/LuBVJjdtYQxskB7Km1q2sNqC0dbn3jFxOxVvFLBFkEgS986rdBjEhwPVpO1RnYODbrwvwDG5ZMxWxneKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vCShmVvC; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47U9MZmX088209;
	Fri, 30 Aug 2024 04:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725009755;
	bh=VttVYtwTVNwYW4XO+dnpQXqxlbZocIVFmvoOhBcDkC8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=vCShmVvCjnitnZAVtUFHLDyWagRTAa3dJ40WNcVI7Nikm46e9XPoTuSXhKWQVNnhn
	 m1+co56AaMDKb0ydpJrDrMjEouDSa/saO6ftdhivQxdLZ78Pku0711/v9CDp59BUBH
	 kMZqJ2LGeWyb93MldGlnMu4zSSG1KKXeaY0DXv/M=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47U9MZor044001
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Aug 2024 04:22:35 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 04:22:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 04:22:34 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47U9MYIV038397;
	Fri, 30 Aug 2024 04:22:34 -0500
Date: Fri, 30 Aug 2024 04:22:34 -0500
From: Nishanth Menon <nm@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <u-kumar1@ti.com>,
        <p-mantena@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am69-sk: Update OSPI partitions
 offsets
Message-ID: <20240830092234.veog3e22te7qi3ao@dugout>
References: <20240830090702.220402-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240830090702.220402-1-b-padhi@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 14:37-20240830, Beleswar Padhi wrote:
> OSPI NOR flash was partitioned with a size of 1 MB for the initial
> bootloader ("ospi.tiboot3"). On the AM69-SK board, boot failures were
> sometimes observed when the initial bootloader size exceeded 512 KB. To

Why does the boot fail when > 512MB?

> address this, the initial bootloader image has been optimized to be
> smaller than 512 KB.
> 
> Therefore, limit the first OSPI partition size to 512 KB and adjust the
> remaining size across the subsequent partitions.

I am NOT a fan of redoing flash partition organization of platforms that
are already in production - all kinds of ecosystem messes happen as a
result. Alternatively - give the 512K to u-boot tispl partition and
leave all others as is - this will at least allow people's current env
to be retained.

> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am69-sk.dts | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> index 1e36965a1403..641236918379 100644
> --- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> @@ -1241,27 +1241,27 @@ partitions {
>  
>  			partition@0 {
>  				label = "ospi.tiboot3";
> -				reg = <0x0 0x100000>;
> +				reg = <0x0 0x80000>;
>  			};
>  
> -			partition@100000 {
> +			partition@80000 {
>  				label = "ospi.tispl";
> -				reg = <0x100000 0x200000>;
> +				reg = <0x80000 0x200000>;
>  			};
>  
> -			partition@300000 {
> +			partition@280000 {
>  				label = "ospi.u-boot";
> -				reg = <0x300000 0x400000>;
> +				reg = <0x280000 0x400000>;
>  			};
>  
> -			partition@700000 {
> +			partition@680000 {
>  				label = "ospi.env";
> -				reg = <0x700000 0x40000>;
> +				reg = <0x680000 0x40000>;
>  			};
>  
> -			partition@740000 {
> +			partition@6c0000 {
>  				label = "ospi.env.backup";
> -				reg = <0x740000 0x40000>;
> +				reg = <0x6c0000 0x40000>;
>  			};
>  
>  			partition@800000 {
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

