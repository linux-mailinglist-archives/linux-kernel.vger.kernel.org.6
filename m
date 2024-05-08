Return-Path: <linux-kernel+bounces-173103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C3F8BFB91
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8FF5B222F4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71C181ABB;
	Wed,  8 May 2024 11:05:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE807EF1E;
	Wed,  8 May 2024 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166319; cv=none; b=fJVeE86CSyaBhM6wSuhBJ4WSxPivoN7Tk4QjAm1/vzgAKQ+c/6j4Qacmp4qDlwr5KqJ8lJ4dCsADzmFbJnMwsvyIbgTHebE8k1V8Wc1wp0Aqxk5B9wJBeg+iaQVuoozNHLql/oEcrJ/RjOloYoeDF5qUp+IqXyU04cSCnrX37F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166319; c=relaxed/simple;
	bh=UQo+Hj9JgjUWs8sd3ImyWNrJ18BHLbb16ETY4TN0ab8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0nFih0+SBPGLSrOn8e38Wc4Gm6nw9BjzMsIJWq7d8MWAqPY65TzyiJyh85a05LzHlCxQIA60wRhG5Loy296JRbP56RP2hfSSqvyjbmjlcbXaZJFcObvdh4/STFanH3jgt4sGdaOUXlfmJdC9v7DnKpprFqiSnQca3CfiweoTfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 461411063;
	Wed,  8 May 2024 04:05:41 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 392733F587;
	Wed,  8 May 2024 04:05:14 -0700 (PDT)
Date: Wed, 8 May 2024 12:05:11 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-sunxi@lists.linux.dev, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: Add cache information to the SoC
 dtsi for H616
Message-ID: <20240508120511.53bbac31@donnerap.manchester.arm.com>
In-Reply-To: <9d52e6d338a059618d894abb0764015043330c2b.1714727227.git.dsimic@manjaro.org>
References: <9d52e6d338a059618d894abb0764015043330c2b.1714727227.git.dsimic@manjaro.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 May 2024 11:09:41 +0200
Dragan Simic <dsimic@manjaro.org> wrote:

> Add missing cache information to the Allwinner H616 SoC dtsi, to allow
> the userspace, which includes lscpu(1) that uses the virtual files provided
> by the kernel under the /sys/devices/system/cpu directory, to display the
> proper H616 cache information.
> 
> Adding the cache information to the H616 SoC dtsi also makes the following
> warning message in the kernel log go away:
> 
>   cacheinfo: Unable to detect cache hierarchy for CPU 0
> 
> Rather conspicuously, almost no cache-related information is available in
> the publicly available Allwinner H616 datasheet (version 1.0) and H616 user
> manual (version 1.0).  Thus, the cache parameters for the H616 SoC dtsi were
> obtained and derived by hand from the cache size and layout specifications
> found in the following technical reference manual, and from the cache size
> and die revision hints available from the following community-provided data
> and memory subsystem benchmarks:
> 
>   - ARM Cortex-A53 revision r0p4 TRM, version J
>   - Summary of the two available H616 die revisions and their differences
>     in cache sizes observed from the CSSIDR_EL1 register readouts, provided
>     by Andre Przywara [1][2]
>   - Tinymembench benchmark results of the H616-based OrangePi Zero 2 SBC,
>     provided by Thomas Kaiser [3]
> 
> For future reference, here's a brief summary of the available documentation
> and the community-provided data and memory subsystem benchmarks:
> 
>   - All caches employ the 64-byte cache line length
>   - Each Cortex-A53 core has 32 KB of L1 2-way, set-associative instruction
>     cache and 32 KB of L1 4-way, set-associative data cache
>   - The size of the L2 cache depends on the actual H616 die revision (there
>     are two die revisions), so the entire SoC can have either 256 KB or 1 MB
>     of unified L2 16-way, set-associative cache [1]
> 
> Also for future reference, here's the relevant excerpt from the community-
> provided H616 memory subsystem benchmark, [3] which confirms that 32 KB and
> 256 KB are the L1 data and L2 cache sizes, respectively:
> 
>     block size : single random read / dual random read
>           1024 :    0.0 ns          /     0.0 ns
>           2048 :    0.0 ns          /     0.0 ns
>           4096 :    0.0 ns          /     0.0 ns
>           8192 :    0.0 ns          /     0.0 ns
>          16384 :    0.0 ns          /     0.0 ns
>          32768 :    0.0 ns          /     0.0 ns
>          65536 :    4.3 ns          /     7.3 ns
>         131072 :    6.6 ns          /    10.5 ns
>         262144 :    9.8 ns          /    15.2 ns
>         524288 :   91.8 ns          /   142.9 ns
>        1048576 :  138.6 ns          /   188.3 ns
>        2097152 :  163.0 ns          /   204.8 ns
>        4194304 :  178.8 ns          /   213.5 ns
>        8388608 :  187.1 ns          /   217.9 ns
>       16777216 :  192.2 ns          /   220.9 ns
>       33554432 :  196.5 ns          /   224.0 ns
>       67108864 :  215.7 ns          /   259.5 ns

Thanks for dumping the elaborate information here!

> The changes introduced to the H616 SoC dtsi by this patch specify 256 KB as
> the L2 cache size.  As outlined by Andre Przywara, [2] a follow-up TF-A patch
> will perform runtime adjustment of the device tree data, making the correct
> L2 cache size of 1 MB present in the device tree for the boards based on the
> revision of H616 that actually provides 1 MB of L2 cache.

I pushed that TF-A patch for review now: 
https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/28694/1
On my OrangePi Zero3 (with an 1MB H618 SoC) the size and number of sets
get adjusted to describe 1MB:
=> fdt list /cpus/l2-cache
l2-cache {
        compatible = "cache";
        cache-level = <0x00000002>;
        cache-unified;
        cache-size = <0x00100000>;
        cache-line-size = <0x00000040>;
        cache-sets = <0x00000400>;
        phandle = <0x00000003>;
};

> [1] https://lore.kernel.org/linux-sunxi/20240430114627.0cfcd14a@donnerap.manchester.arm.com/
> [2] https://lore.kernel.org/linux-sunxi/20240501103059.10a8f7de@donnerap.manchester.arm.com/
> [3] https://raw.githubusercontent.com/ThomasKaiser/sbc-bench/master/results/4knM.txt
> 
> Suggested-by: Andre Przywara <andre.przywara@arm.com>
> Helped-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

So I can confirm that the information above is correct, and also matches
the DT properties added below.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks!
Andre

> ---
>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> index b2e85e52d1a1..4faed88d8909 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> @@ -26,30 +26,67 @@ cpu0: cpu@0 {
>  			reg = <0>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache>;
>  		};
>  
>  		cpu1: cpu@1 {
>  			compatible = "arm,cortex-a53";
>  			device_type = "cpu";
>  			reg = <1>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache>;
>  		};
>  
>  		cpu2: cpu@2 {
>  			compatible = "arm,cortex-a53";
>  			device_type = "cpu";
>  			reg = <2>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache>;
>  		};
>  
>  		cpu3: cpu@3 {
>  			compatible = "arm,cortex-a53";
>  			device_type = "cpu";
>  			reg = <3>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache>;
> +		};
> +
> +		l2_cache: l2-cache {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-unified;
> +			cache-size = <0x40000>;
> +			cache-line-size = <64>;
> +			cache-sets = <256>;
>  		};
>  	};
>  


