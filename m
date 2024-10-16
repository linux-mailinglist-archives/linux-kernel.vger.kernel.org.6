Return-Path: <linux-kernel+bounces-368084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 666FA9A0AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F521280D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA29208D85;
	Wed, 16 Oct 2024 13:05:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E1D206E66
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083953; cv=none; b=rDLe1lvQww9XsTv44T8t3Zj6uH/rZrbezA5TcY7w/JR2GObyVxPeKSIA2RK/F07fDKChfIiBDUHbizX1RQQSulJ0LBhIIXFOkNbiAooke2dn76jEqy1+RKsiUmwXuX+cQyqeD7nWpN+lF0Er3jNAXvKz4LAkDJOSk++W++jUFFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083953; c=relaxed/simple;
	bh=FbR3gg6JVCrfH92imBLO6smtkMM1oMDMyVjwGG9rvgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FadCrcHkcg1J48OzBHaQYSmVuu/OvysAYcBrFm/0UM1EFh2RX1LVVh1ZVzuSNvgmtiLM/slI5DqKjBw+nCSfihkEnap9meV9UL6RrEvvKcvP3gqWxXcVjZCGJnOafqSGnWxLyhi2Im8xZJEXvtEqsjVTCf3LANGX32o0OFXQj3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B75C4CEC5;
	Wed, 16 Oct 2024 13:05:51 +0000 (UTC)
Message-ID: <5f56441c-6ba4-4ef4-9f4b-84496c3414de@linux-m68k.org>
Date: Wed, 16 Oct 2024 23:05:48 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] m68k: mcfgpio: Fix incorrect register offset for
 CONFIG_M5441x
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20241016-fix-m5441x-gpio-v2-1-f419777bc90d@yoseli.org>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20241016-fix-m5441x-gpio-v2-1-f419777bc90d@yoseli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi JM,

On 16/10/24 17:24, Jean-Michel Hautbois wrote:
> Fix a typo in the CONFIG_M5441x preprocessor condition, where the GPIO
> register offset was incorrectly set to 8 instead of 0. This prevented
> proper GPIO configuration for m5441x targets.
> 
> Fixes: bea8bcb12da0 ("m68knommu: Add support for the Coldfire m5441x.")
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

Looks good, thanks for the v2.
Applied to the m68knommu git tree, for-next branch.

Regards
Greg


> ---
> Changes in v2:
> - The commit fixed is not the one in v1
> - Link to v1: https://lore.kernel.org/r/20241016-fix-m5441x-gpio-v1-1-0a29befd4b8d@yoseli.org
> ---
>   arch/m68k/include/asm/mcfgpio.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/include/asm/mcfgpio.h b/arch/m68k/include/asm/mcfgpio.h
> index 019f24439546..9c91ecdafc45 100644
> --- a/arch/m68k/include/asm/mcfgpio.h
> +++ b/arch/m68k/include/asm/mcfgpio.h
> @@ -136,7 +136,7 @@ static inline void gpio_free(unsigned gpio)
>    * read-modify-write as well as those controlled by the EPORT and GPIO modules.
>    */
>   #define MCFGPIO_SCR_START		40
> -#elif defined(CONFIGM5441x)
> +#elif defined(CONFIG_M5441x)
>   /* The m5441x EPORT doesn't have its own GPIO port, uses PORT C */
>   #define MCFGPIO_SCR_START		0
>   #else
> 
> ---
> base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
> change-id: 20241016-fix-m5441x-gpio-e671833569b4
> 
> Best regards,

