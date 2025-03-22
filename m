Return-Path: <linux-kernel+bounces-572569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E244A6CB8B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 17:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BBA3B1754
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 16:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CA123315A;
	Sat, 22 Mar 2025 16:48:41 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DCF70809;
	Sat, 22 Mar 2025 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742662121; cv=none; b=Y837ZfKu6biRqAeZv2+9m8JGU+cmQCYDsBa5iImmEyL8BZl6PEbwJWAnjIRWXG1BuKeqBZQB0ac+7RHes4uI5WPO19thG2bjbVcE2SS/Votnw6Xn+l9uDGCQ21M2xG1KeAeV4Dp2rLH3ARXN9hXdA6LY/ecuGban4t5UJOkPXtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742662121; c=relaxed/simple;
	bh=6ETw4qwX/qIQhMwwsyK/PUtjq5P6Z1W9B4nv6FX3Yfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8errcoplgxItnSLNm9eKIlDaFIBoC4nesDKXlG9SwgrEAgzzn8FXzZ+0FHP9cdyNBFnhVSxN+Rz9at9aG6TGB8VNOW3+eLHFYc1YKcPY+zAqg5/R291bVDsQ6y0yRDeQZmcYX2mz6ZeQbkVsvYtwi93vrNxUdPi3u7nUFbQOBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 14C40343212;
	Sat, 22 Mar 2025 16:48:37 +0000 (UTC)
Date: Sat, 22 Mar 2025 16:48:30 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heylenay@4d2.org, guodong@riscstar.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, spacemit@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 7/7] riscv: dts: spacemit: add reset support for
 the K1 SoC
Message-ID: <20250322164830-GYE11633@gentoo>
References: <20250321151831.623575-1-elder@riscstar.com>
 <20250321151831.623575-8-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321151831.623575-8-elder@riscstar.com>

On 10:18 Fri 21 Mar     , Alex Elder wrote:
> Define syscon nodes for the RCPU, RCPU2, and APBC2 SpacemiT CCUS, which
> currently support resets but not clocks in the SpacemiT K1.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  arch/riscv/boot/dts/spacemit/k1.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> index 09a9100986b19..f86d1b58c6d35 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -350,6 +350,18 @@ soc {
>  		dma-noncoherent;
>  		ranges;
>  
> +		syscon_rcpu: system-controller@c0880000 {
I'm not sure if syscon_rcpu is good name to go, it's AUDIO Peripherals
in docs, see

7.2 Main CPU Domain Address Mapping
https://developer.spacemit.com/documentation?token=LzJyw97BCipK1dkUygrcbT0NnMg
> +			compatible = "spacemit,k1-syscon-rcpu";
> +			reg = <0x0 0xc0880000 0x0 0x2048>;
> +			#reset-cells = <1>;
> +		};
> +
> +		syscon_rcpu2: system-controller@c0888000 {
not found this address mapping in above docs link
> +			compatible = "spacemit,k1-syscon-rcpu2";
> +			reg = <0x0 0xc0888000 0x0 0x28>;
> +			#reset-cells = <1>;
> +		};
> +
>  		syscon_apbc: system-control@d4015000 {
>  			compatible = "spacemit,k1-syscon-apbc";
>  			reg = <0x0 0xd4015000 0x0 0x1000>;
> @@ -518,6 +530,12 @@ clint: timer@e4000000 {
>  					      <&cpu7_intc 3>, <&cpu7_intc 7>;
>  		};
>  
> +		syscon_apbc2: system-controller@f0610000 {
> +			compatible = "spacemit,k1-syscon-apbc2";
> +			reg = <0x0 0xf0610000 0x0 0x20>;
> +			#reset-cells = <1>;
> +		};
> +
>  		sec_uart1: serial@f0612000 {
>  			compatible = "spacemit,k1-uart", "intel,xscale-uart";
>  			reg = <0x0 0xf0612000 0x0 0x100>;
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

