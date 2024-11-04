Return-Path: <linux-kernel+bounces-394956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C809BB67B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A738280E6C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963266F06D;
	Mon,  4 Nov 2024 13:39:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D08BEE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727552; cv=none; b=Hnclxv4Yo+ADbo77+bvF0+9jnTHrVs1KxRm7tHSNgyA6puSaXNMMwmKHUhBcHcg2KxHU0pcKWbDUnRJXvjugzly7kTBAKAFP0d1OidXimhB0yQskFDBrIk9GDkYnZ04QupJNg86AlYfhg5i9SRjMusIxyQX90e6YUOxlHQg4ous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727552; c=relaxed/simple;
	bh=WlxLRHsEKt5E0xzrDqmgFT1xoYLbcZ9Baly/pFKaHvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPjihmMzhh0na4Ae5RpA5B5SF0Qx2eEgLwWJfwF3Huj8wmcMCzJBBog1jqDHQyVAC0/ULSa8vO7mUPxRsscxV5v5SvBaWBl5IGDleHGaQFVz2/TT1G8xrjLtPBwnASDrPqe9mCl6gk6wTPE4HO+WsbEewy/UOS/yRJyhMCeZV04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD259C4CED1;
	Mon,  4 Nov 2024 13:39:10 +0000 (UTC)
Message-ID: <c767306e-e248-4395-b4ec-2bdfec56ef49@linux-m68k.org>
Date: Mon, 4 Nov 2024 23:39:08 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] m68k: coldfire/device.c: only build FEC when HW macros
 are defined
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org
References: <20241029214315.26710-1-antonio@mandelbit.com>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20241029214315.26710-1-antonio@mandelbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Antonio,

On 30/10/24 07:43, Antonio Quartulli wrote:
> When CONFIG_FEC is set (due to COMPILE_TEST) along with
> CONFIG_M54xx, coldfire/device.c has compile errors due to
> missing MCFEC_* and MCF_IRQ_FEC_* symbols.
> 
> Make the whole FEC blocks dependent on having the HW macros
> defined, rather than on CONFIG_FEC itself.
> 
> This fix is very similar to commit e6e1e7b19fa1 ("m68k: coldfire/device.c: only build for MCF_EDMA when h/w macros are defined")
> 
> Fixes: b7ce7f0d0efc ("m68knommu: merge common ColdFire FEC platform setup code")
> To: Greg Ungerer <gerg@linux-m68k.org>
> To: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>

Thanks, looks good. Applied to the m68knommu git tree, for-next branch.

Regards
Greg


> ---
>   arch/m68k/coldfire/device.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/device.c
> index 7dab46728aed..b6958ec2a220 100644
> --- a/arch/m68k/coldfire/device.c
> +++ b/arch/m68k/coldfire/device.c
> @@ -93,7 +93,7 @@ static struct platform_device mcf_uart = {
>   	.dev.platform_data	= mcf_uart_platform_data,
>   };
>   
> -#if IS_ENABLED(CONFIG_FEC)
> +#ifdef MCFFEC_BASE0
>   
>   #ifdef CONFIG_M5441x
>   #define FEC_NAME	"enet-fec"
> @@ -145,6 +145,7 @@ static struct platform_device mcf_fec0 = {
>   		.platform_data		= FEC_PDATA,
>   	}
>   };
> +#endif /* MCFFEC_BASE0 */
>   
>   #ifdef MCFFEC_BASE1
>   static struct resource mcf_fec1_resources[] = {
> @@ -182,7 +183,6 @@ static struct platform_device mcf_fec1 = {
>   	}
>   };
>   #endif /* MCFFEC_BASE1 */
> -#endif /* CONFIG_FEC */
>   
>   #if IS_ENABLED(CONFIG_SPI_COLDFIRE_QSPI)
>   /*
> @@ -624,12 +624,12 @@ static struct platform_device mcf_flexcan0 = {
>   
>   static struct platform_device *mcf_devices[] __initdata = {
>   	&mcf_uart,
> -#if IS_ENABLED(CONFIG_FEC)
> +#ifdef MCFFEC_BASE0
>   	&mcf_fec0,
> +#endif
>   #ifdef MCFFEC_BASE1
>   	&mcf_fec1,
>   #endif
> -#endif
>   #if IS_ENABLED(CONFIG_SPI_COLDFIRE_QSPI)
>   	&mcf_qspi,
>   #endif

