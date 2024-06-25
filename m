Return-Path: <linux-kernel+bounces-228907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F29191687A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81632B245D2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B86E169AE6;
	Tue, 25 Jun 2024 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVYFw7EL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32BA157A6C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320314; cv=none; b=pRQaii3IH6XQ9Kv1q/FcS8hbZcGe1M6tCGmASvvXYLYjFpGPncAk6EaJL5jj1pwYwt9l3cG2arqzF67YPfJwg2sy0bRSxk22nff0DMw4pW+ZRl9YtyjVMntk3oPTpw6PUgbkbtYngd1nfRC7O6mLXuX62B4gASz+ohA7m3yIR8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320314; c=relaxed/simple;
	bh=3i19Htl894X0g3aHQcPL0Iim0MmgZty9Fc1FrWM9jxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atNSlQrh/enps9vkHM2DhcBKGTsS+WVFxtAMr9cvcK07ybA0Zs/4l4LwhvpwvQW6fEJt+vBjAgwFDOKtYST453qY75hnrtTGwxk4CeN70n6rE93BnrcjNAGcO5ewq+ZaJNkotk5Q8GRt/eXS4SpSO8tYdI9gh4hTWb8p4aJ6EGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVYFw7EL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719320311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahyjuN1IQMhs449YcyfZMjZr4BNWq0ro7neYjEknzhc=;
	b=jVYFw7ELmLJlnaYaB+6mi5TD/FRTUmxfi8085+KrLjersILZL+8QCDXbZkXYP0P//jzIWY
	DMePan2jrnmw6xP+CykQkwZCnBl+CrIgozYqyT08bd4SLt4ZgaKKWyc1TEZwmF28H8t9Od
	Wtbv7uDGJZbLsLkbkbs+aKTw4hNsqnU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-A61z3wKMM9GLAHkQ9mCvSw-1; Tue, 25 Jun 2024 08:58:30 -0400
X-MC-Unique: A61z3wKMM9GLAHkQ9mCvSw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-700c25cbdf6so2687967a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 05:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719320309; x=1719925109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahyjuN1IQMhs449YcyfZMjZr4BNWq0ro7neYjEknzhc=;
        b=ljNp2qWnhN8Kf0XlH9MHwgwf0AzST6slRyB484rT71hahLnhl60tzNCwUHf7dBjJ7h
         H09eQkcGr274pJp5gNx79g0Ggb1r5Rmsi79C+P/KtIlXYtGA7AWscgmUui9TRE9dlpvi
         nAdBL0brTHs47LwUy86Sc6Yj+oSCu8Kf3qYbdM6utfSYpNvFOjEpixAfcOj2t3JdLYEA
         Mko2c1S7MpPa2jbEQjPxlnrYnZZ0bF/dxf2e5j/tse1bJZoCelmR8hTaYMIcxRK9pVOU
         Gsly8yn5toLLlkGHmGXP9NQ6YU/zbGISEVW7pTKqvXwi5Qn+Y2xyU/WpQL1QSWHj/u/a
         PtOw==
X-Forwarded-Encrypted: i=1; AJvYcCVTnhwNYPCQIM5TEJNC3GC8paIYi/sYWVJmg5DoWC4Bn8lWoVWrtVIcMYsDwV/7QluZ3sIllzX/oJSVO2PSDjg5XfW2emrgRGjGkGg6
X-Gm-Message-State: AOJu0Yy75Drh8JLe/oiCHqjBVHPYgReHLnuU4YbDAgYXOttvCLBByW2s
	AGa6IooggS2tRMWmFOFDU0qNsUScflYi2lhJeQycfWQ8dcqKbJqchryv8budzDxHnPl1Ou08pDw
	P1Bs/zGGQLFiQHZIFjtcBFFsKZpDVt5ECnT2D9DwqkjP76LM5fgxl5syrmuCh4Q==
X-Received: by 2002:a05:6359:4ca8:b0:1a5:2f55:c47d with SMTP id e5c5f4694b2df-1a52f55c703mr24126655d.9.1719320309412;
        Tue, 25 Jun 2024 05:58:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf0Y8yXMMcTnoJ4gMZxd9FhbT0x90EgSLxa/KXAi5ylWcugcCgfKHkt+lHyy3s5RUdEw8tnQ==
X-Received: by 2002:a05:6359:4ca8:b0:1a5:2f55:c47d with SMTP id e5c5f4694b2df-1a52f55c703mr24124555d.9.1719320308883;
        Tue, 25 Jun 2024 05:58:28 -0700 (PDT)
Received: from [10.26.1.93] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b534b6fb20sm30330456d6.58.2024.06.25.05.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 05:58:28 -0700 (PDT)
Message-ID: <021b66fa-07ad-4ab4-8be9-94985f412d54@redhat.com>
Date: Tue, 25 Jun 2024 08:58:27 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ACPI: Add acpi=nospcr to disable ACPI SPCR as default
 console on ARM64
To: Liu Wei <liuwei09@cestc.cn>, will@kernel.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
References: <20240530015332.7305-1-liuwei09@cestc.cn>
 <20240625030504.58025-1-liuwei09@cestc.cn>
Content-Language: en-US
From: Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <20240625030504.58025-1-liuwei09@cestc.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/24 23:05, Liu Wei wrote:
> For varying privacy and security reasons, sometimes we would like to
> completely silence the _serial_ console, and only enable it when needed.
> 
> But there are many existing systems that depend on this _serial_ console,
> so add acpi=nospcr to disable console in ACPI SPCR table as default
> _serial_ console.
> 
> Signed-off-by: Liu Wei <liuwei09@cestc.cn>
> Suggested-by: Prarit Bhargava <prarit@redhat.com>
> Suggested-by: Will Deacon <will@kernel.org>
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> v2: Add a config option suggested by Prarit
> 
> v3: Use cmdline acpi=nospcr instead of config
> 
> v4: Some description in comment or document
> ---
>   .../admin-guide/kernel-parameters.txt          | 10 +++++++---
>   arch/arm64/kernel/acpi.c                       | 18 +++++++++++++++++-
>   2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 11e57ba2985c..6814ff7ae446 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -12,7 +12,7 @@
>   	acpi=		[HW,ACPI,X86,ARM64,RISCV64,EARLY]
>   			Advanced Configuration and Power Interface
>   			Format: { force | on | off | strict | noirq | rsdt |
> -				  copy_dsdt }
> +				  copy_dsdt | nospcr }
>   			force -- enable ACPI if default was off
>   			on -- enable ACPI but allow fallback to DT [arm64,riscv64]
>   			off -- disable ACPI if default was on
> @@ -21,8 +21,12 @@
>   				strictly ACPI specification compliant.
>   			rsdt -- prefer RSDT over (default) XSDT
>   			copy_dsdt -- copy DSDT to memory
> -			For ARM64 and RISCV64, ONLY "acpi=off", "acpi=on" or
> -			"acpi=force" are available
> +			nospcr -- disable console in ACPI SPCR table as
> +				default _serial_ console on ARM64
> +			For ARM64, ONLY "acpi=off", "acpi=on", "acpi=force" or
> +			"acpi=nospcr" are available
> +			For RISCV64, ONLY "acpi=off", "acpi=on" or "acpi=force"
> +			are available
>   
>   			See also Documentation/power/runtime_pm.rst, pci=noacpi
>   
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index e0e7b93c16cc..55757d8884d4 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -45,6 +45,7 @@ EXPORT_SYMBOL(acpi_pci_disabled);
>   static bool param_acpi_off __initdata;
>   static bool param_acpi_on __initdata;
>   static bool param_acpi_force __initdata;
> +static bool param_acpi_nospcr __initdata;
>   
>   static int __init parse_acpi(char *arg)
>   {
> @@ -58,6 +59,8 @@ static int __init parse_acpi(char *arg)
>   		param_acpi_on = true;
>   	else if (strcmp(arg, "force") == 0) /* force ACPI to be enabled */
>   		param_acpi_force = true;
> +	else if (strcmp(arg, "nospcr") == 0) /* disable SPCR as default console */
> +		param_acpi_nospcr = true;
>   	else
>   		return -EINVAL;	/* Core will print when we return error */
>   
> @@ -237,7 +240,20 @@ void __init acpi_boot_table_init(void)
>   			acpi_put_table(facs);
>   		}
>   #endif
> -		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
> +
> +		/*
> +		 * For varying privacy and security reasons, sometimes need
> +		 * to completely silence the serial console output, and only
> +		 * enable it when needed.
> +		 * But there are many existing systems that depend on this
> +		 * behavior, use acpi=nospcr to disable console in ACPI SPCR
> +		 * table as default serial console.
> +		 */
> +		acpi_parse_spcr(earlycon_acpi_spcr_enable,
> +			!param_acpi_nospcr);
> +		pr_info("Use ACPI SPCR as default console: %s\n",
> +				param_acpi_nospcr ? "No" : "Yes");
> +
>   		if (IS_ENABLED(CONFIG_ACPI_BGRT))
>   			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
>   	}

This looks good to me.  Sorry that this took so long Liu.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>

P.


