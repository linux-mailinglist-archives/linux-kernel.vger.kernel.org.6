Return-Path: <linux-kernel+bounces-529550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2BBA427CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B430F3B78FC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56CE263C7B;
	Mon, 24 Feb 2025 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="NeOqKsVk"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B095262D01
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414021; cv=none; b=naiwywH32pR5OLVWKpE4UROAbr6Kw9fH5PW9Lu2Z3NCuxN5YFdRO2XgLc2luP6VJ6/ZGA7sq7eLywOu8ENcQ/acT8sG4lcmIfZQvBao7pEErJDi6Xp7cDhwnITAK3N/vEO/J7ckczZJbXryKrtuCHnhFV2MSQ/LmRVGiEExLwEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414021; c=relaxed/simple;
	bh=dAW+lzcUjuJCx8nm83/VRlBOfNihmJ24Sk7c4Z4Sop0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CV9gVXUOlnxd+r+Chd6zr1I0bl1LWf0kqGZFiIJ3H1mW4tjJHcKN/Tiy41ZILZ18SiF1bu2Rl/4Qu3bjAZ0Oe7HzV9HVB3KY9PcYqNJamkNRwAkY9fEjOnjTAHEXmCYzplpzQpXXN3H+ZU4CanEL6NVPRr0jWYo3EhgkOwFNRQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=NeOqKsVk; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2bcc0c6c149so3747055fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1740414019; x=1741018819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oN+NkoXvqTUOJseNMh1dgmtXYVy7v/pj+PDG1pRPS5Y=;
        b=NeOqKsVkoyN4r8OJBMOST+hkLvZcv040eKGr2S9M/vTc4IZDw5crwblDyi7fslwm9y
         E4hkgSlY7Dci0I6+XbPv06s1MYv4AOzpkFtxCV0tn7y8WcY4kuKOkhuPGtK57maelahR
         V5lTki54nuON5hU8C2pmE8AhvOWLHlRBvvoVQ/7Dl9YNk8Z6RBfUbzaPKfhXYeIOSaYz
         VQDQYMLx3DUiiTc7xC1IWIV9ROMX5yMz3jDpPiSD5FZRb+5TowGmR8l1KQ6+8hXV9dSB
         XAND92it5o5AIwktLzJmidrRQ7HjhgkGAqGZNzaz2wE8I+EiKwk6cX7AKl8IjptinQSS
         tUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740414019; x=1741018819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oN+NkoXvqTUOJseNMh1dgmtXYVy7v/pj+PDG1pRPS5Y=;
        b=nOevnjjJifEf+IKmYeg44XJHRvgG2u1A40m1NuwKQjJGEZmP7sdVcDixmh4dDgQP+Z
         euRxTEfNAMqs6c05j0/V8V5671gXcTwqzT++8yJj01bLl1BogqHbbjT6ECtJzXUdoTJw
         HPktd3TJjHtunTochssma/krlrracVB6V15bZDEdLOiLf82itAHXwAkNYlljfdwc38v4
         w6wah9qich4mYg13wXncPhQuaAvvw7nBlX5FU/GaLlV78A/M4+jOd/UCOv0CfnaYF0Sk
         /hYq40ZfFYuDfJaV0z0kTcE2i0YMoJvTlZmdgZsvAiL3C1gJSbW2b71LCiNS3QV23okc
         Ndow==
X-Forwarded-Encrypted: i=1; AJvYcCXmpokUcwNVrHCFZ5gBvwjVh/tLADJDe0Eg8c+bzPrAC0MgS3+tUpNOiLw5f81doXXhu0/7fNu7HLcM1kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwEHEuPhc7QQUtn5AogxXiphvL+aye9qZzqRHDOdCEYWbKDQYb
	lFwy7am1Wom4gmUVKm6LjpPOTHK6IhQn8TU2O+bE470+NX0aKS/fCeJ0H5wmFuQ=
X-Gm-Gg: ASbGncsHRuv33RypMNoEHMl59ni6NFBwAhVwkD5T6hkwVIopFf4jdg9xEF4n+odooDG
	NV6J3xVq8iQIJ2XQTghBwZ8Y/I8yJhpmSdKcgHRBZZPfRAcuwQ6aDbeI7F6fid1sLcGk/HGpvNB
	tWN2CFZa1HCO6C4QLl+hx4xonyo9LsyrN+Nd1Dhjw/yKyo3ChgwdcfftRj9In9WpJzUtqjCTlNU
	KWO3IMlgHZeudyxFpMcA5+webbgX3ZD8yAyc6n2m+eBxYXSbh2OqQ+Cf/VnnVfYOz3ZdDpXAXDx
	tbZlrUi/Gd0UgZEzeNuYFU28hxkLjkgCWLh6mt9ucMoloLknv6MlNBSm4jdhZvjRoA==
X-Google-Smtp-Source: AGHT+IH4G1AKZYt4/JksdoFqV5iQH7Vqegqn4nXSddj5cZmthp+oSDAc+cn7bYDo2zy+ODi3qb8gww==
X-Received: by 2002:a05:6870:40c5:b0:2bc:918c:ee04 with SMTP id 586e51a60fabf-2bd50cfbeb9mr10707249fac.14.1740414018536;
        Mon, 24 Feb 2025 08:20:18 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727378237e4sm2656892a34.47.2025.02.24.08.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:20:18 -0800 (PST)
Message-ID: <d4aa25fb-2cc0-4b1a-a376-936e7e83233a@riscstar.com>
Date: Mon, 24 Feb 2025 10:20:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/5] clk: bcm281xx: implement prerequisite clocks
To: Artur Weber <aweber.kernel@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, Stanislav Jakubek
 <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com>
 <20250216-kona-bus-clock-v1-3-e8779d77a6f2@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250216-kona-bus-clock-v1-3-e8779d77a6f2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/25 10:12 AM, Artur Weber wrote:
> From: Alex Elder <elder@kernel.org>
> 
> Allow a clock to specify a "prerequisite" clock, identified by its
> name.  The prerequisite clock must be prepared and enabled before a
> clock that depends on it is used.  In order to simplify locking, we
> require a clock and its prerequisite to be associated with the same
> CCU.  (We'll just trust--but not verify--that nobody defines a cycle
> of prerequisite clocks.)
> 
> Rework the KONA_CLK() macro, and define a new KONA_CLK_PREREQ()
> variant that allows a prerequisite clock to be specified.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> --- Artur: rebase on v6.13, move prereq prepare/unprepare to main
>      prepare/unprepare functions, use locking versions of clk_prepare
>      and clk_enable since the non-locking versions are no longer
>      public ---
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

I'm surprised there is no prepare function for the peripheral
clocks.

The prequisite clock should separate the prepare and the
enable functionality.  Right now you have kona_clk_prepare()
doing both.  Instead, a clock's prepare function should
prepare its prerequisite (if any).  Then its enable function
should enable its parent.

Should all the users of peripheral clocks just also be required
to specify the bus clocks as well?  I suppose that doesn't
encode the prerequisite property (bus comes before peripheral);
is that truly a requirement?

					-Alex

> ---
>   drivers/clk/bcm/clk-kona.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/clk/bcm/clk-kona.h | 20 ++++++++++++---
>   2 files changed, 79 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
> index e92d57f3bbb147e72221802175a80502897d7504..21f925683d0da05ebc97f92236dfb207b1f9c741 100644
> --- a/drivers/clk/bcm/clk-kona.c
> +++ b/drivers/clk/bcm/clk-kona.c
> @@ -9,6 +9,7 @@
>   #include <linux/delay.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
> +#include <linux/clk.h>
>   #include <linux/clk-provider.h>
>   
>   /*
> @@ -961,6 +962,63 @@ static int selector_write(struct ccu_data *ccu, struct bcm_clk_gate *gate,
>   	return ret;
>   }
>   
> +/*
> + * Common clock prepare/unprepare functions. These implement a "prerequisite"
> + * mechanism; the prerequisite clock is prepared and enabled before the main
> + * clock is prepared.
> + */
> +
> +static int kona_clk_prepare(struct clk_hw *hw)
> +{
> +	struct kona_clk *bcm_clk = to_kona_clk(hw);
> +	const char *clk_name = bcm_clk->init_data.name;
> +	const char *prereq_name = bcm_clk->prereq.name;
> +	struct clk *prereq_clk = bcm_clk->prereq.clk;
> +	int ret;
> +
> +	/* If there's no prerequisite clock, there's nothing to do */
> +	if (!prereq_name)
> +		return 0;
> +
> +	/* Look up the prerequisite clock if we haven't already */
> +	if (!prereq_clk) {
> +		prereq_clk = __clk_lookup(prereq_name);
> +		if (WARN_ON_ONCE(!prereq_clk))
> +			return -ENOENT;
> +		bcm_clk->prereq.clk = prereq_clk;
> +	}
> +
> +	ret = clk_prepare(prereq_clk);
> +	if (ret) {
> +		pr_err("%s: unable to prepare prereq clock %s for %s\n",
> +			__func__, prereq_name, clk_name);
> +		return ret;
> +	}
> +
> +	ret = clk_enable(prereq_clk);
> +	if (ret) {
> +		clk_unprepare(prereq_clk);
> +		pr_err("%s: unable to enable prereq clock %s for %s\n",
> +			__func__, prereq_name, clk_name);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void kona_clk_unprepare(struct clk_hw *hw)
> +{
> +	struct kona_clk *bcm_clk = to_kona_clk(hw);
> +	struct clk *prereq_clk = bcm_clk->prereq.clk;
> +
> +	/* If there's no prerequisite clock, there's nothing to do */
> +	if (!bcm_clk->prereq.name)
> +		return;
> +
> +	clk_disable(prereq_clk);
> +	clk_unprepare(prereq_clk);
> +}
> +
>   /* Peripheral clock operations */
>   
>   static int kona_peri_clk_enable(struct clk_hw *hw)
> @@ -1172,6 +1230,8 @@ static int kona_peri_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>   }
>   
>   struct clk_ops kona_peri_clk_ops = {
> +	.prepare = kona_clk_prepare,
> +	.unprepare = kona_clk_unprepare,
>   	.enable = kona_peri_clk_enable,
>   	.disable = kona_peri_clk_disable,
>   	.is_enabled = kona_peri_clk_is_enabled,
> @@ -1260,6 +1320,8 @@ static int kona_bus_clk_is_enabled(struct clk_hw *hw)
>   }
>   
>   struct clk_ops kona_bus_clk_ops = {
> +	.prepare = kona_clk_prepare,
> +	.unprepare = kona_clk_unprepare,
>   	.enable = kona_bus_clk_enable,
>   	.disable = kona_bus_clk_disable,
>   	.is_enabled = kona_bus_clk_is_enabled,
> diff --git a/drivers/clk/bcm/clk-kona.h b/drivers/clk/bcm/clk-kona.h
> index a5b3d8bdb54eaee9fad80c28796170207b817dfd..c32c621282ec6dd40fff3f7598ee8aa007fed524 100644
> --- a/drivers/clk/bcm/clk-kona.h
> +++ b/drivers/clk/bcm/clk-kona.h
> @@ -406,6 +406,10 @@ struct kona_clk {
>   	struct clk_init_data init_data;	/* includes name of this clock */
>   	struct ccu_data *ccu;	/* ccu this clock is associated with */
>   	enum bcm_clk_type type;
> +	struct {
> +		const char *name;
> +		struct clk *clk;
> +	} prereq;
>   	union {
>   		void *data;
>   		struct peri_clk_data *peri;
> @@ -416,16 +420,26 @@ struct kona_clk {
>   	container_of(_hw, struct kona_clk, hw)
>   
>   /* Initialization macro for an entry in a CCU's kona_clks[] array. */
> -#define KONA_CLK(_ccu_name, _clk_name, _type)				\
> -	{								\
> +#define __KONA_CLK_COMMON(_ccu_name, _clk_name, _type)			\
>   		.init_data	= {					\
>   			.name = #_clk_name,				\
>   			.ops = &kona_ ## _type ## _clk_ops,		\
>   		},							\
>   		.ccu		= &_ccu_name ## _ccu_data,		\
>   		.type		= bcm_clk_ ## _type,			\
> -		.u.data		= &_clk_name ## _data,			\
> +		.u.data		= &_clk_name ## _data
> +
> +#define KONA_CLK(_ccu_name, _clk_name, _type)				\
> +	{								\
> +		__KONA_CLK_COMMON(_ccu_name, _clk_name, _type),	\
>   	}
> +
> +#define KONA_CLK_PREREQ(_ccu_name, _clk_name, _type, _prereq)		\
> +	{								\
> +		.prereq.name	= #_prereq,				\
> +		__KONA_CLK_COMMON(_ccu_name, _clk_name, _type),	\
> +	}
> +
>   #define LAST_KONA_CLK	{ .type = bcm_clk_none }
>   
>   /*
> 


