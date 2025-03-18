Return-Path: <linux-kernel+bounces-566127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83360A67387
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0842189C6A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD0F20B804;
	Tue, 18 Mar 2025 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="SFsPLfOm"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108B42557A;
	Tue, 18 Mar 2025 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299984; cv=none; b=JHnMB/r7d4a04htQGmkPEnrHnmTXSYez0pHy0bnkoU2zPBeD2fWKZzS4n+1lps0ZloWbdQlv1dILI7AJMeaPedwjOiNcP+a32pXS8DeOF3TEgR1d56q2YoHMBEUhMJ8RGvD8QzX8MB8bt8HKs3wcJzzx/5RDevJCoiw/Ak7461U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299984; c=relaxed/simple;
	bh=X7IPSY0ipoBbhtXtRwGSvqy5uwDoi8Tgu1K6QKtrhvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceNAojBdYoli7sXBOO4n+M3gFjLNttqh9a/kLSnvmrimD831FWAh7HtQGaho2pEmqxXeoNxSmCCCkLSge8Ac1GfUMvz3EHZKb9BRAf0q3VxW1stnsS2dAwuDN6sirqtk+QaoKhF8k9PG5PuDihvPJUwDrTHmh+V4grNiip5qWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=SFsPLfOm; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2756025B9B;
	Tue, 18 Mar 2025 13:12:58 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mODv3-V5KX9r; Tue, 18 Mar 2025 13:12:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1742299965; bh=X7IPSY0ipoBbhtXtRwGSvqy5uwDoi8Tgu1K6QKtrhvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SFsPLfOmeIxPs7LyMzZAEch62HIUaKUL8ttPrcN5ekM4MygMKLqJgO3B3QgxcWL50
	 CgM1nhfma+XOKNZ/c/foG3pcz1IkfrxsbQOGDuFE1M9VoK4tTlzszl+Hn6/MqmoKjX
	 zILe/jfV9gjVbpFsDeoHkFlqP7FUh1HgsA+Wr08CjLK1BNaXwkDG+yu5Npkiq7xBRM
	 ITDd6v8qvWZ5oxwLs0SKm72OYZ1vq3BRVx/ePO3xjqrP/7I08/zRo0OahwZwSb4l7N
	 FcEAKIOBhIsRz1fZFUlsHECwM05utQdXwdpPaR6altO8ObWjl9BhiQYs0aVTU7RlLb
	 ySKERRKUfGJQg==
Date: Tue, 18 Mar 2025 12:12:33 +0000
From: Yao Zi <ziyao@disroot.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Rob Herring <robh@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: Add missing uart3 interrupt
 for RK3528
Message-ID: <Z9ljMc96QoCNzzq3@pie>
References: <20250318100010.2253408-1-amadeus@jmu.edu.cn>
 <20250318100010.2253408-2-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318100010.2253408-2-amadeus@jmu.edu.cn>

On Tue, Mar 18, 2025 at 06:00:08PM +0800, Chukun Pan wrote:
> The interrupt of uart3 node on rk3528 is missing, fix it.
> 
> Fixes: 7983e6c379a9 ("arm64: dts: rockchip: Add base DT for rk3528 SoC")
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

Reviewed-by: Yao Zi <ziyao@disroot.org>

Thanks for catching this, seems I messed uart3 up when cleaning the
devicetree.

> ---
>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> index 26c3559d6a6d..7f1ffd6003f5 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> @@ -404,9 +404,10 @@ uart2: serial@ffa00000 {
>  
>  		uart3: serial@ffa08000 {
>  			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
> +			reg = <0x0 0xffa08000 0x0 0x100>;
>  			clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
>  			clock-names = "baudclk", "apb_pclk";
> -			reg = <0x0 0xffa08000 0x0 0x100>;
> +			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-io-width = <4>;
>  			reg-shift = <2>;
>  			status = "disabled";
> -- 
> 2.25.1
> 

