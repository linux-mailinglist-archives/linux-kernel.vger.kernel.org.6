Return-Path: <linux-kernel+bounces-558018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54701A5E078
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8EA189C614
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B4424FC0D;
	Wed, 12 Mar 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwjUCvGr"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C3D2505C6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793756; cv=none; b=kptsxuVssmRWDilBOLw1zW5MGMKvpdWEaaLgdi5sRfCdPxCFnOJvZGoS6QTq9we+GhiyrCOc0znE/VsoIjWGxZAlibv+8Q77yMuRj2E7JgkY1zGOU9DdhApn4EVGoie6/mnRRWn9ikBuHtmgqqhA1Qm7hGnstRJ9PS7p+9wL0iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793756; c=relaxed/simple;
	bh=/57whBCc1TMWNm6F13Zc2Y/83EGWz3KHC34aJZ6KkRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKzB1Grh1uvxDOUhcaau84nIP8mTT7/8OVX5vHIwopr1JR/KC85ZkLl+B086UptDlvTZ8CJm5ZAox92jyHdxkTLhJk7eyXxCcFmxbzl+GgTrJJfYICTt6emtO4vZmnuKfIs6/HCP6qCJl/tFUwc7gvRBW6j3SKS0La49ArVzbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZwjUCvGr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so28291835e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741793753; x=1742398553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rnL31mkQuGEMzXApku8enoUMG0mMg3FNo50wKx3UviU=;
        b=ZwjUCvGrJ7J6NlTCV1bIUbmG6bTpDg0fq4cuGI4WrTGkwrhMRwXp9kHgcDyRjiTIKY
         IwNi5K3KsxDpDOngkFBDcE7gmXZN77fxxvw/qZs947R3I3BY2WZIYqy+OHrUCmSmv8G/
         2HyPOs7ZHjqASGLET7iuds3GoVwfDIyULDzN27re9WmWdnBEEA0OhpTiEa8ahJGR6Oqh
         B/q23TZiQX6zRRMpkzVJrAELtTGGcCbwbLTUMUVnF4x3K8Dk0Rs9R+vl7xyrYdGZSh+N
         KZQW8zQKinZJLMSoMLMpX6iOc7tBnOBwgEKWtH+JpIscejchsL1ePvVg4tHDmsfvLsDa
         3RVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741793753; x=1742398553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnL31mkQuGEMzXApku8enoUMG0mMg3FNo50wKx3UviU=;
        b=PqR1ICAfL2TTu+aVhWoqopG+N+1nndGHv1ecv2DP0g5SVlJHJUMv6jIcvqJ08nJ4hf
         kY7X8PKcWCd8SFY0pT09SBLP+WYOsKpbj85DNVHuaADGbbqN8cAymUgcQImuwDtWslw5
         dyKtxbqfxZPPE7BwQge7yvf3LtJDZsphXv5O6Rv+/v3xkThxGbJDS0hzm8N7ZHNCcgjQ
         SAxT/627olhbWdy7JWt0a3fy3aBcCEBZZZLoCqfDzwBr/WbOAbGCP6JPVskcef7KSFxW
         iHWjO9xOHOb/eE3Uq3nij3kTooQGfJKK5rlZizhodykZU/AoVsk01EcbkA5hewi4bndO
         85tg==
X-Forwarded-Encrypted: i=1; AJvYcCVVJvCsRzTpR53Ca0leXI3Cm4S51PFi2jndFakHioW8dqYIXurro6dG62miY+Q4M3sbDpsll+11hXDIFcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv6VTSRWCegYjC9B2dYEYVsV7f9p82BwurYl1xfnPsZBVtnHTC
	zrxLTmmNzoeaIu6RJzoibbQNYv391ubflHQdUJe6XT9Y87b7E0Go/AOX0Jft0Cw=
X-Gm-Gg: ASbGncsmjhmysF39Ydh4WyxbnPrxghiA75nQkEQBPdtIadIVSqb402G94e5WmCFKy5d
	IJIy3jNO6ZdMlyoHBbfH2k7ShhffjGCAcfOXQXDI4t2vzYLC2PjhR+eU8ReMZSpJNJAuudhnxt9
	+rxKrJgrl5DJxCNwIdvPH2128TwjDKWpvoVDE+0CnWmYpW40tBehGswK0gc/K4gn5sxAGZEQK/s
	mqhVy3p6BEaMhXlO6EfzHxzOyfKiZvhxa95zzOikaLjp4i/u1tDSeEZXHTseCnYZ/EpkgJZ+oQx
	/NxkmnayPkaLk2XzfqUQQxC+U718HzJL/gFWqN6G63ZDkn5AWd/uftSA7BknomfGxhN2PmrtWfg
	v6fNTOcTf
X-Google-Smtp-Source: AGHT+IEhJyMWRzmyiYAwxtuXbWMP2QdrKwRFqW4RDJ6sKRc80DOvjzEsLA11vX8fG8O17D8k3CHECg==
X-Received: by 2002:a05:600c:524c:b0:43d:b32:40aa with SMTP id 5b1f17b1804b1-43d0b32419amr22373515e9.3.1741793752820;
        Wed, 12 Mar 2025 08:35:52 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d0a78f1bbsm24227265e9.31.2025.03.12.08.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 08:35:52 -0700 (PDT)
Message-ID: <726c6ffc-a8d4-4328-a849-2d59f3a0a1c9@linaro.org>
Date: Wed, 12 Mar 2025 16:35:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] thermal: core: Record PSCR before
 hw_protection_shutdown()
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
References: <20250306093900.2199442-1-o.rempel@pengutronix.de>
 <20250306093900.2199442-8-o.rempel@pengutronix.de>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250306093900.2199442-8-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Oleksij,


On 06/03/2025 10:38, Oleksij Rempel wrote:
> Enhance the thermal core to record the Power State Change Reason (PSCR)
> prior to invoking hw_protection_shutdown(). This change integrates the
> PSCR framework with the thermal subsystem, ensuring that reasons for
> power state changes, such as overtemperature events, are stored in a
> dedicated non-volatile memory (NVMEM) cell.
> 
> This 'black box' recording is crucial for post-mortem analysis, enabling
> a deeper understanding of system failures and abrupt shutdowns,
> especially in scenarios where PMICs or watchdog timers are incapable of
> logging such events.  The recorded data can be utilized during system
> recovery routines in the bootloader or early kernel stages of subsequent
> boots, significantly enhancing system diagnostics, reliability, and
> debugging capabilities.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   drivers/thermal/thermal_core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 2328ac0d8561..af4e9cf22bf6 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -16,6 +16,7 @@
>   #include <linux/kdev_t.h>
>   #include <linux/idr.h>
>   #include <linux/thermal.h>
> +#include <linux/pscrr.h>
>   #include <linux/reboot.h>
>   #include <linux/string.h>
>   #include <linux/of.h>
> @@ -380,6 +381,8 @@ static void thermal_zone_device_halt(struct thermal_zone_device *tz, bool shutdo
>   
>   	dev_emerg(&tz->device, "%s: critical temperature reached\n", tz->type);
>   
> +	set_power_state_change_reason(PSCR_OVERTEMPERATURE);
> +
>   	if (shutdown)
>   		hw_protection_shutdown(msg, poweroff_delay_ms);
>   	else

In the future could you add me as recipient to the series instead of 
this one ? so I can get more context.

Given there are no so much hw_protection_shutdown() users in the kernel, 
it could be more interesting to change the function to receive a enum 
pscr_reason and then in the hw_protection_shutdown() call 
pscrr_reason_to_str().



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

