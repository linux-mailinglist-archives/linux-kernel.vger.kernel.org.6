Return-Path: <linux-kernel+bounces-525051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8154A3EA34
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CBC07AC36C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A7B78F4E;
	Fri, 21 Feb 2025 01:39:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2A2225D6;
	Fri, 21 Feb 2025 01:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101972; cv=none; b=o20V15RnnQ3jiFRSWxdfdpbAejK9L1+jSsVLmUfMhI1r/Ha7q1pCSQnmo/U6FnEaqW8iMdTMhJelv2Er+BCFbUT8PupOvUK31wAQmaRbtdQFlsGU2wO2io8PKurE0HOZuZXs+v9WdqUrXt54tDuyJbUgJ1YLNDASJ+gOqVRm6IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101972; c=relaxed/simple;
	bh=XidwWYprxvvp9LVHmJrQKB7BF7kwB4sqxfHp3Zc1fQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FH7Eh99xXXEG/pVqq4h9vzTKO0J6DMd15n+d+CejceVypHOgWeY8v7408QqQceFrBqdHs1mMpQ07NCH1c15A7jf2TJ4yQz5TNXkN1vfIpzaxkVM4j20RICqS9JaXm8lJUehbH2J1fXZ8SGkVCFUcTMGQ1W4cAPWH16zkzvHuwHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E0241BA8;
	Thu, 20 Feb 2025 17:39:47 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BEF83F59E;
	Thu, 20 Feb 2025 17:39:27 -0800 (PST)
Date: Fri, 21 Feb 2025 01:37:21 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Anastasia Belova <abelova@astralinux.ru>
Cc: Emilio =?UTF-8?B?TMOzcGV6?= <emilio@elopez.com.ar>, David Laight
 <david.laight.linux@gmail.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, Hans de Goede
 <hdegoede@redhat.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] clk: sunxi: clean up rate counting
Message-ID: <20250221013721.32468f6c@minigeek.lan>
In-Reply-To: <20250203112930.650813-1-abelova@astralinux.ru>
References: <20250203112930.650813-1-abelova@astralinux.ru>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Feb 2025 14:29:28 +0300
Anastasia Belova <abelova@astralinux.ru> wrote:

Hi,

> If n = 255, the result of multiplication of n and 24000000
> may not fit int type. Swap division and shift with multiplication.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

I guess this is effectively a v2 of this patch?
https://lore.kernel.org/linux-sunxi/20250120084719.63116-1-abelova@astralinux.ru/T/#u

In this case, and for the records, I'd like to repeat some comments of
mine from this former patch, about this being mostly irrelevant:
- PLL4 is PLL_PERIPH0, which is meant to be fixed to 960MHz. Linux
  would not change this frequency.
- the Allwinner A80 is both old and quite rare/obscure: the most
  prominent board (Cubieboard4) was broken for a while and nobody
  noticed
- this "allwinner,sun9i-a80-pll4-clk" clock is not used by any DT
  in the kernel, so it's effectively dead code

So do we really need this change? Or asked another way: What does this
patch fix, exactly?

Some comments still, regardless:

> Fixes: 6424e0aeebc4 ("clk: sunxi: rewrite sun9i_a80_get_pll4_factors()")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  drivers/clk/sunxi/clk-sun9i-core.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/sunxi/clk-sun9i-core.c b/drivers/clk/sunxi/clk-sun9i-core.c
> index d93c7a53c6c0..639c83ed63b8 100644
> --- a/drivers/clk/sunxi/clk-sun9i-core.c
> +++ b/drivers/clk/sunxi/clk-sun9i-core.c
> @@ -25,12 +25,12 @@
>  
>  static void sun9i_a80_get_pll4_factors(struct factors_request *req)
>  {
> -	int n;
> -	int m = 1;
> -	int p = 1;
> +	unsigned int n;
> +	unsigned int m = 1;
> +	unsigned int p = 1;
>  
>  	/* Normalize value to a 6 MHz multiple (24 MHz / 4) */
> -	n = DIV_ROUND_UP(req->rate, 6000000);
> +	n = DIV_ROUND_UP(req->rate, 6000000ul);

What would the "unsigned long" change here? This is 32-bit code, so int
and long are the same size. And regardless, how does changing the
divisor type help anyway?

>  
>  	/* If n is too large switch to steps of 12 MHz */
>  	if (n > 255) {
> @@ -50,7 +50,11 @@ static void sun9i_a80_get_pll4_factors(struct factors_request *req)
>  	else if (n < 12)
>  		n = 12;
>  
> -	req->rate = ((24000000 * n) >> p) / (m + 1);
> +	/* Division and shift should be done before multiplication to
> +	 * avoid overflow. The result will be correct because '>> p' and
> +	 * '/ (m + 1)' are both just conditional 'divide by 2'
> +	 */
> +	req->rate = ((24000000ul >> p) / (m + 1)) * n;

This looks OKish, since indeed the divisors are just 1 or 2, so we
don't lose any precision here. But again: what is "ul" supposed to fix?

Also the comment reads slightly wrong to me: Normally division
and shift _should_ be done *after* multiplication to avoid loss of
precision. The comment here should state that we _can_ do it the other
way around here, since the divisors are small and divide the dividend
"cleanly".

Cheers,
Andre


>  	req->n = n;
>  	req->m = m;
>  	req->p = p;


