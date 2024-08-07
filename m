Return-Path: <linux-kernel+bounces-277815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 059B894A6D8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2830C1C22C7F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E67F1E3CC1;
	Wed,  7 Aug 2024 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FD6+mn5Z"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683631E2104
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723029694; cv=none; b=pLQtpCrnXCf2PtpcbftBsz5BQ/iMUHon8fEpllPUx0m0o37UoHgVcykLa8RMv13zpYD+gSNmiIsmD7JGiYvTwGWBWuiP+BrYF8vAgVblNx4EYyHokxI+FI9Tcej4xK3tPgdMYZ2IedSSw0TZSIzIe/MCIJq2ds/OFo+c2Yv7aLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723029694; c=relaxed/simple;
	bh=LDuVR8Q8SBltlZ0Y7R0bvpdndZWmNaepum4NflH3uEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzHyOOMVZ1s7+5Qx/jaS2pwMnQsJIOP1auCuV8pW2Y8zGbbnq9wiWSXuZrh5/be026VE3+WkEXvsmqYGzzfRBsQMcP7CN4tmsfLvUe50xm7VRMTN0mWMQ1qJphR/pUvTNQ8Hebr/hmJ7fPyTkEvvMkqr7+uTjvTgXytyYIcE4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FD6+mn5Z; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso2661813a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 04:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1723029690; x=1723634490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O63kDKJnx9fmZjMbiNZsuL2wJTTHJuwzpsSd5JTI0e0=;
        b=FD6+mn5ZHCrD3MxYmmtC0VaBk3LNHgpKvrKG5BG3p7OaFGG7h9rG8czOmjZX4nQImD
         y5ee6jjh5mbznkAxusuMXeZBaBZwGdBSbi90RAx756W3xWr2Tps20+RC416Ig9BMDolB
         AZLU7VeCBkhpciT+ZgCXq7YK7axvCZ0IObzUNM5T2fBIsh3pP6O8GIcfNUdRCmUQvV1s
         KXPMcISCImcynppr/bYpfaysZDx08IXPZnXVMIDkSanxVmvRKgYuoXIrfQlbDYSSIOpV
         uowFo+3ggvY+8kzhhpGbNZnhfxNB7K8Wq/ciJnod3aoPoeXZ6LnEki3cSHhMLFO563zq
         /kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723029690; x=1723634490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O63kDKJnx9fmZjMbiNZsuL2wJTTHJuwzpsSd5JTI0e0=;
        b=jn0HwxgVLK+yGbDe79CezU0B35tJUNQqR53HSU4AhwQ4n7dUwb7VJ2lfAI+1Bvgxie
         nBh6wlM44X2b/42ZoUpr/gSvs68O02ULHErk4G998QeGIld/FqmaeVcWvDtLURoNE8Wk
         u3ceTuvOA4img++1DFaJR/b7SP/KOPhyRjS/nahhmJ0Yv5Vo32Pzw9oDxkDhLc5UsQtj
         LwzbFZYVPYax19/JK1iNGtwITDsPovoMu8NTvdCTEPbWmxW7A6PsNet/bCCK8b5o64Q1
         Ssavf4SxiBe4XzuXHfgnWW3NTy09DLxZ3NSLM41w43lpWsyNE7Kyj+IA3X38goXsByAW
         chzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS838+pNRzqw0K8dCCQHpknyAwuyrU6yp61p+zrAIQAF0VMOux4KvVO8P/EbmQZ2vR2vq1ZbTHF6dWsgIZ4DgZyhxpHZB1OavKMYjR
X-Gm-Message-State: AOJu0YxMNBm27QIZC8yPrYzkhn0Cp10f5RIUNnib38SNnT49iQwZwsZ/
	U/tSv0cUggk23VqKsPZUOEaZkyO6f6UdccmSxY0EgiG0XHWQZRUyeODzL3zL/kw=
X-Google-Smtp-Source: AGHT+IHM3r2bAdSLrg/pmt0OrZB5Bhj5Th6878fNVzaGx5MeOuvAuO1T3w9OQvFHUVXk+68bCP5iCA==
X-Received: by 2002:a17:906:fe41:b0:a7a:a46e:dc3f with SMTP id a640c23a62f3a-a7dc50a345bmr1206383166b.45.1723029689288;
        Wed, 07 Aug 2024 04:21:29 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cc95sm624246766b.85.2024.08.07.04.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 04:21:28 -0700 (PDT)
Message-ID: <201cbbe6-99eb-4622-bc5f-3d298f9e30b4@tuxon.dev>
Date: Wed, 7 Aug 2024 14:21:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] watchdog: rzg2l_wdt: Enable properly the watchdog
 clocks and power domain
Content-Language: en-US
To: ulf.hansson@linaro.org, wim@linux-watchdog.org, linux@roeck-us.net,
 rafael@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org, geert+renesas@glider.be,
 linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240619120920.2703605-1-claudiu.beznea.uj@bp.renesas.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240619120920.2703605-1-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ulf,

Please, do you have any input/suggestions on this?

Thank you,
Claudiu Beznea

On 19.06.2024 15:09, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Watchdog device available on RZ/G3S SoC is part of a software-controlled
> power domain. The watchdog driver implements struct
> watchdog_ops::restart() handler which is called in atomic context via
> this call chain:
> 
> kernel_restart() ->
>   machine_restart() ->
>     do_kernel_restart() ->
>       atomic_notifier_call_chain() ->
>         watchdog_restart_notifier()
> 	  rzg2l_wdt_restart()
> 
> When the rzg2l_wdt_restart() is called it may happen that the watchdog
> clocks to be disabled and the associated power domain to be off.
> Accessing watchdog registers in this state leads to aborts and system
> blocks.
> 
> To solve this issue the series proposes a new API called
> dev_pm_genpd_resume_restart_dev() that is intended to be called in
> scenarios like this. In this RFC series the
> dev_pm_genpd_resume_restart_dev() checks if the system is in
> SYSTEM_RESTART context and call dev_pm_genpd_resume(). I also wanted to
> mark the device as a restart device with a new member in struct dev_pm_info
> (similar to struct dev_pm_info::syscore) and check it in the newly
> introduced API but then I told myself maybe it would be better to keep it
> simpler for the moment.
> 
> Please let me know how do you consider this.
> 
> Along with it, series addresses the usage of clk_prepare_enable() in
> rzg2l_wdt_restart() reported by Ulf Hansson at [1] and use the
> dev_pm_genpd_resume_restart_dev() in rzg2l_wdt driver.
> 
> Please note that series is built on top of [1].
> 
> A similar approach (using directly the dev_pm_genpd_resume() function in
> rzg2l_wdt was proposed at [2]). This series was posted separatelly to
> avoid blocking the initial support for the RZ/G3S SoC.
> 
> Thank you,
> Claudiu Beznea
> 
> [1] https://lore.kernel.org/all/20240531065723.1085423-1-claudiu.beznea.uj@bp.renesas.com/
> [2] https://lore.kernel.org/all/20240410134044.2138310-10-claudiu.beznea.uj@bp.renesas.com/
> 
> Claudiu Beznea (3):
>   pmdomain: core: Add a helper to power on the restart devices
>   watchdog: rzg2l_wdt: Keep the clocks prepared
>   watchdog: rzg2l_wdt: Power on the PM domain in rzg2l_wdt_restart()
> 
>  drivers/pmdomain/core.c      | 18 +++++++++++++++
>  drivers/watchdog/rzg2l_wdt.c | 43 +++++++++++++++++++++++++++++++-----
>  include/linux/pm_domain.h    |  2 ++
>  3 files changed, 58 insertions(+), 5 deletions(-)
> 

