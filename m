Return-Path: <linux-kernel+bounces-553878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7921A59012
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4BA3A9381
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A6E22576A;
	Mon, 10 Mar 2025 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnr9V7B6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED0225415;
	Mon, 10 Mar 2025 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599842; cv=none; b=hXaZxa18c+1Tz0NFl5peiZX4cKZT1eJROH2vVa7KlmhX0an5gT/ieenHhJFUWp2UGdqvBuwBvdBavEAzA3IgiWxooAhpKRAI5QrUfpGofsxFlBGRMq3qRgjY73XHfXS6pZ62N089XfufJCcGNjD52bQ/LYCoPrH5mWJXtPIk/Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599842; c=relaxed/simple;
	bh=Y2XjENUbyeWUEbpemhn/4RvYZYeG10dijoarzvG3LHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slAUzL9AjTqnR5QXGhtHKQ1+D5hyCh8TEOMIp1uV1oI5596yYaS6OF4uAAQqtKxh/gOeAIsLjJRDlnMlJ3Nr2f61ImquIXSpMhelwi33ie90Sa8HtVWh6czOz2YgghhEMlZ0KX7uxkxY1rgW/ejn9Q+GszXl9nC+9/vKfcDHSQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnr9V7B6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2CDC4CEE5;
	Mon, 10 Mar 2025 09:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741599841;
	bh=Y2XjENUbyeWUEbpemhn/4RvYZYeG10dijoarzvG3LHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nnr9V7B6SzGa3hlxQmNqe3ju15Hy8L0jxILZAlNE19926aPKDaOLd/t8NpjldEdS7
	 UKbwrDgSKTk5uTIXkfUPrhf+BcmowjP/rgmByGQjgAM11p/X7Gew33KOxzJnOqJSdk
	 bMN5wdc8DDEh8v1N+HpAJQ+2YAhficDSTcJQd6GGtQRlpu8RWDCCLHIgbb3aoHtCrS
	 DIWDNtiHQTX5G8jzyXfuLyl2jB7YtW65U+kyDvRHDFKm1hwY/PTPobBU1n7gFeothp
	 ueCxo7hwSpkkotzNF9d7W00Z7DCLbRjcVp8EKYN+FMyw6xUz2APGuQ788cJfGw5Ipk
	 sYL38nnLrZmuQ==
Date: Mon, 10 Mar 2025 10:43:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alex Elder <elder@kernel.org>, Stanislav Jakubek <stano.jakubek@gmail.com>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 4/9] dt-bindings: clock: brcm,kona-ccu: Add BCM281xx
 bus clocks
Message-ID: <20250310-orange-frog-of-abundance-af80f3@krzk-bin>
References: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
 <20250308-kona-bus-clock-v3-4-d6fb5bfc3b67@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250308-kona-bus-clock-v3-4-d6fb5bfc3b67@gmail.com>

On Sat, Mar 08, 2025 at 08:50:42AM +0100, Artur Weber wrote:
> Add bus clocks corresponding to peripheral clocks currently supported
> by the BCM281xx clock driver and add the relevant clock IDs to the
> clock/bcm281xx.h dt-bindings header.

Please squash the patch so we see complete change.

> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v3:
> - Add more clock output names to example
> - Drop CLOCK_COUNT defines from the DT binding header
> 
> Changes in v2:
> - Add this commit (BCM281xx bus clocks)
> ---
>  .../devicetree/bindings/clock/brcm,kona-ccu.yaml   | 33 ++++++++++++++++++++--
>  include/dt-bindings/clock/bcm281xx.h               | 19 +++++++++++++
>  2 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
> index dff04e24e92829b890bf7cd336f0e083bdb30fa6..d00dcf916b45904177614c6f19a5df02abdf42f7 100644
> --- a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
> +++ b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
> @@ -40,7 +40,7 @@ properties:
>  
>    clock-output-names:
>      minItems: 1
> -    maxItems: 14
> +    maxItems: 20
>  
>  required:
>    - compatible
> @@ -61,6 +61,8 @@ allOf:
>              - const: hub_timer
>              - const: pmu_bsc
>              - const: pmu_bsc_var
> +            - const: hub_timer_apb
> +            - const: pmu_bsc_apb
>    - if:
>        properties:
>          compatible:
> @@ -86,6 +88,13 @@ allOf:
>              - const: usb_ic
>              - const: hsic2_48m
>              - const: hsic2_12m
> +            - const: sdio1_ahb
> +            - const: sdio2_ahb
> +            - const: sdio3_ahb
> +            - const: sdio4_ahb
> +            - const: usb_ic_ahb
> +            - const: hsic2_ahb
> +            - const: usb_otg_ahb
>    - if:
>        properties:
>          compatible:
> @@ -116,6 +125,16 @@ allOf:
>              - const: bsc2
>              - const: bsc3
>              - const: pwm
> +            - const: uartb_apb
> +            - const: uartb2_apb
> +            - const: uartb3_apb
> +            - const: uartb4_apb
> +            - const: ssp0_apb
> +            - const: ssp2_apb
> +            - const: bsc1_apb
> +            - const: bsc2_apb
> +            - const: bsc3_apb
> +            - const: pwm_apb

Why pwm_apb cannot be after pwm? Any idea for sorting here?

Best regards,
Krzysztof


