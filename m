Return-Path: <linux-kernel+bounces-510699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0059FA320B6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD283A5D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13752204C23;
	Wed, 12 Feb 2025 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="i4xVd5f1"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E4C1EE013
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348136; cv=none; b=pDENPqnwHnwk7M7/IAass8Qfr3iKGjq02ibTJbKZLveBSNI5YbYyM8nCi5xmsxG72Oh/0hE7mst/z6MrEt6KkuOElVjoydgPH8UcKgKaOZ3X897j/8cUUB0PpUwJoqYj5dRFItA8Ch2eDmQhJ3yS7+1d/1be3B95e950E2ZGcW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348136; c=relaxed/simple;
	bh=pqSWrSKDZu2W3AsjSYgllmcKNDjNEXWE7Ff4oLEDdIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOEmgpKjrTcUkbpsI5PTDw0xtrL35BHJ8ROA5LRuKZnhD8ScMMhNj9AvSha3YAbmVFR6fbN1ICecmMlGs03ZC7cAQ6fjUg26BRDg9VBwzO27Ien97ghE2PHOXTHISoMbgWby20HuX4ZY/EmZKbeqj72Z1d8qOdv0PktG6ToGrmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=i4xVd5f1; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5deae16ab51so942188a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739348133; x=1739952933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OqxADw0mM/35GjV5ECvP4wRGY3fCb1JBuXcZqTu8EFw=;
        b=i4xVd5f14CB9wxl+nAc9EGUXVxVSLuYwoNivnE6JYceGuyzJJhV6W80E4pp1eVyWWG
         bnt//ZhMCzLSUWHE8URMFc29y/CGuSgi21m4hIkrrFp4httbU82kcs9alwJfutWGqv7m
         HbWrb8rMhF9r6+Ngu6WtSPhQr7xLMsBEe5OaKAFMv2CLkhKzZV56GWb8tRYYptMqBniF
         B/sPPRJTPBR7aceeiqsscu810IebLyQGyjtrlwDZF1TC/sqyfklom+sd0XVotsthwAzf
         5P0Ez7IzQycjzZbtJldoAyQ6xzW2fg7W7NjE3/xkoEkJt2W5M/GMUHBgY3xn7IIgL0k2
         x4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739348133; x=1739952933;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqxADw0mM/35GjV5ECvP4wRGY3fCb1JBuXcZqTu8EFw=;
        b=j/PECKZOivCo8pEDRWS21z4d8IgaI/RDTqScp3NNBukx9FKDPk2QkNcs1aZLs9miia
         2RRZt9g/JBEhOGvDruLFIalxS7FIoqhTkoXHfohcD/suhizeqhskzZiLlFkG24FSxMX2
         t1qsl5UaSDNL4c10INBSqyfOYAob5EMLqFYmLpOt00/obebNd5cO5yi5z73UfsDSyWKD
         h+s6krry3S6IcS/KK+1sUcQbB9WQBNy+H/mWl77zJ3x/AFQiOQqQw75+R3gtb7lGGexZ
         9ii5g21/fMKZVnLNDWiHoXJufn35R2c4jqCEP/YfgVMAoEzlqdEJ6fLD/T1WVPy8j+sQ
         RkSg==
X-Forwarded-Encrypted: i=1; AJvYcCU/2OXIRYLHLkYjJGba+Td/fnkYB0dz17ZrrRwaUjClgSvTLzHhvEn/B3epZwf3vzphDrjX2+F2yKZE5x0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh/m2GqGSj3IBMENPjq1J11fKc8V9HgCro6vnFTfrk94DZza6m
	o71CQfXl7cKe2ELFFNJO7AuJg7qoHsPhXHpQIcoVBpquCmejE54DEgQSP8lS3gY=
X-Gm-Gg: ASbGncv+FJ3C21KOSW6RfMnv0lOogywte6bO3dQGH+h9XWGa2wYNV3b3xkVpfTz1/ic
	WqIVy4nEGx2qgkIFHc2XV1q0FEMFdgOt0+q8vCnBWAW3pHNmNVOtJY5038SUoowW4CA8mpc9wa1
	Fo8G318CTLM2uz7hQ4LMiqwriwWK0gazCFR6474Zw2yGXRMebjoaJIvwxxVw7hfBsQ7fweVX4v3
	jc/vNVEKssJcOK4zO77Hsc6RkUwN3+ND9OZhJIvY2GzHCUixXXFzGXVJgC0HSr2d22l0w0NqIZB
	lGXO2phkzcaFCCLcuUVTkxhS
X-Google-Smtp-Source: AGHT+IEbwR6Lyd/Au1yiix8z7N9e//5C4qN6OPaROOH+JFMvGJ7S7t8yx7MVhrpHdvoBh0/u2cudOA==
X-Received: by 2002:a05:6402:13cc:b0:5dc:caab:9447 with SMTP id 4fb4d7f45d1cf-5deadd9d336mr5364745a12.18.1739348132467;
        Wed, 12 Feb 2025 00:15:32 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.173])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de44e4bc17sm9802856a12.70.2025.02.12.00.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 00:15:31 -0800 (PST)
Message-ID: <833f642e-a4f5-46ad-8854-0e85598d1be7@tuxon.dev>
Date: Wed, 12 Feb 2025 10:15:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] ARM: at91: PM: Add Backup mode for SAMA7D65
To: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 p.zabel@pengutronix.de
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
 <76a89f1ae5e9c4d337c2a28e4b1d0e5cef63e5fe.1739221064.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <76a89f1ae5e9c4d337c2a28e4b1d0e5cef63e5fe.1739221064.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 10.02.2025 23:13, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add config check that enables Backup mode for SAMA7D65 SoC.
> 
> Add SHDWC_SR read to clear the status bits once finished exiting low
> power modes.

Can you please also explain why? From [1]:

"The text should be written in such detail so that when read weeks, months
or even years later, it can give the reader the needed details to grasp the
reasoning for **why** the patch was created."


[1] https://www.kernel.org/doc/html/v6.13/process/submitting-patches.html


> This is only for SAMA7D65 SoCs.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  arch/arm/mach-at91/pm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 1eec68e92f8d8..55cab31ce1ecb 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -707,6 +707,9 @@ static int at91_pm_enter(suspend_state_t state)
>  static void at91_pm_end(void)
>  {
>  	at91_pm_config_ws(soc_pm.data.mode, false);
> +
> +	if (IS_ENABLED(CONFIG_SOC_SAMA7D65))
> +		readl(soc_pm.data.shdwc + 0x08);

Can you please add a comment near explaining what 0x08 offset means (search
for "SHDWC.MR" in this file for an example)?

Is this cleanup needed only for backup mode or for all of them. If only for
backup you can move it in at91_pm_suspend() after fncpy().

Thank you,
Claudiu

>  }
>  
>  
> @@ -1065,7 +1068,8 @@ static int __init at91_pm_backup_init(void)
>  	int ret = -ENODEV, located = 0;
>  
>  	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2) &&
> -	    !IS_ENABLED(CONFIG_SOC_SAMA7G5))
> +	    !IS_ENABLED(CONFIG_SOC_SAMA7G5) &&
> +	    !IS_ENABLED(CONFIG_SOC_SAMA7D65))
>  		return -EPERM;
>  
>  	if (!at91_is_pm_mode_active(AT91_PM_BACKUP))


