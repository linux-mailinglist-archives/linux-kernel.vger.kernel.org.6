Return-Path: <linux-kernel+bounces-553696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148C2A58DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4AB3ABAE4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D726E22331B;
	Mon, 10 Mar 2025 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck14BSUW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C7284E1C;
	Mon, 10 Mar 2025 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594014; cv=none; b=CLojg5WAHe2DIJ3KMYRikb8lSVU72E06wqJiiM042RAg+Re7S5t5+JDiBUaZ0pA8xZqxTFMcS0NwqFsu9q0khsf806C/F6gFocNUDGMdySIX3AUw6aiNN/ThNZ/zxZA2ixKzjuspRviTq8yG41TLjbFdFCxzuyHLdRvHD76LvWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594014; c=relaxed/simple;
	bh=NbJSs1wNLVvIHE9BQRAI0LXly/YzkdCvZRSwk1tZ3DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixjNjNy09j/dPsBxFZL5dXW0mqbiSD9FVtfLn7R58FQWjOf0KL5Qf+tRqVHxgyIwtAvg/4HciESLtSNE60Fvx6eA5lwa1Wv+Q8iGe63Hv7Ga4GiKPDUisjTurFHG2u4nr6vq56dn72YFm0T36urT51uD4G1Zpm7ogSZtJoyhutM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck14BSUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8548C4CEE5;
	Mon, 10 Mar 2025 08:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741594013;
	bh=NbJSs1wNLVvIHE9BQRAI0LXly/YzkdCvZRSwk1tZ3DI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ck14BSUW2DHr8FXn/UT60rQvCUmrcGuywDn0oo17f9h2KOHukhIcaLSLzIgJWWMRU
	 XUZx46fKlfwRYmbpVuqLg2mO6fTyCKMiclucXknt6CdKZthpPkeiohzN4ig+MwOU4/
	 6aEXrr5+NJtnTLcPMjaIPK7j562ZpAjYko0o6VfuxsMbN4jZmGLqmbR1uc2Kt1rkUg
	 1XHZHpFiLSDHfsA36SNrwDK0aI6JTSGqnN6c3gMRWCo+O8rAxwZF4hxU1U2UgOtCL3
	 dhvi8BmZfyLDTUf/1qYOOiI5m4r0mbm+NEIWaQ/7n4f56X2LCftJC5pmmFyJ0jlBoC
	 pFbRHuuovmwcg==
Date: Mon, 10 Mar 2025 09:06:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Danzberger <dd@embedd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Nikita Shubin <nikita.shubin@maquefel.me>, 
	Guo Ren <guoren@kernel.org>, Yangyu Chen <cyy@cyyself.name>, 
	Ben Hutchings <ben@decadent.org.uk>, Felix Fietkau <nbd@nbd.name>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH 12/13] arm64: dts: airoha: en7581: convert SCU clock node
 to MFD implementation
Message-ID: <20250310-independent-melodic-hedgehog-d3010a@krzk-bin>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
 <20250309132959.19045-13-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309132959.19045-13-ansuelsmth@gmail.com>

On Sun, Mar 09, 2025 at 02:29:43PM +0100, Christian Marangi wrote:
> Convert SCU clock node for Airoha EN7581 to MFD implementation in
> preparation for USB support.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  arch/arm64/boot/dts/airoha/en7581.dtsi | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/airoha/en7581.dtsi b/arch/arm64/boot/dts/airoha/en7581.dtsi
> index 26b136940917..dfc12fa99748 100644
> --- a/arch/arm64/boot/dts/airoha/en7581.dtsi
> +++ b/arch/arm64/boot/dts/airoha/en7581.dtsi
> @@ -173,11 +173,16 @@ spi_nand: nand@0 {
>  			};
>  		};
>  
> -		scuclk: clock-controller@1fb00000 {
> -			compatible = "airoha,en7581-scu";
> +		system-controller@1fb00000 {
> +			compatible = "airoha,en7581-scu-sysctl", "syscon", "simple-mfd";
>  			reg = <0x0 0x1fb00000 0x0 0x970>;

Hardware did not change and you do not explain why any conversion
affecting users is justified.

Best regards,
Krzysztof


