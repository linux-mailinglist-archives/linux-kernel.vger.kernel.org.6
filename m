Return-Path: <linux-kernel+bounces-224526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 447AC912393
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2CF01F27F99
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E971C179972;
	Fri, 21 Jun 2024 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drxdoO3Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F081741DB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969220; cv=none; b=kQzxnHNHLJUV09aKCretGIOAGcW/245C1WJEVHTDdpFYHI5jX04j1DTsvkfplWU68E/iZwtQvksdntaLNr2R9XQIU1UZEzWBQJKz8ozRv0Hyx/ldyn3alzbve3ZSgN5XAvKaSU3HBp147w2XsyeHmN5NAO4jd+6rkNKBVRhVxm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969220; c=relaxed/simple;
	bh=3+K4lmrWw6xEYCPYCUSqXEjwftEByZUL02V6AecRxfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUYKWhnZXtjZtYaoHstfS7NMlbZLf38exUABJSqgTRfD+4/Ee0jj+JmON8KDs4ZVzkXnkAskusmo20K6iw9LF9IXYS573HL0H2pyghP+EGtkU/Hh3JIhmujNAyBMkQLeY4bprzYlvTdKclTxRZJgzvctpZ9y2Qf+xR13T+Sufyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drxdoO3Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718969217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AbWTm7QYhVs521X2AgBsRmkjpYYxf77pV7a0Yxd2xk=;
	b=drxdoO3QXJS+cNv6gnJ4+Uk5Wbel5ipQzW9ZcmuXTjYsfXBImrusoVSidWv5qf0JWII/uf
	AqpVdCj2a8TnAhDDFAlhn9U2wiAGpGfQp1tRyVZ1MV6x1lbqBGp61nSj65Eut9XnDMuKbP
	M4EtrFw079xn080AbU1J9BZsNhqzNw0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-kHLQ7AdZM0uQYmwjJ7ycYw-1; Fri, 21 Jun 2024 07:26:54 -0400
X-MC-Unique: kHLQ7AdZM0uQYmwjJ7ycYw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b50be910afso21500826d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718969213; x=1719574013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+AbWTm7QYhVs521X2AgBsRmkjpYYxf77pV7a0Yxd2xk=;
        b=rdrkcV+jalRcKHXdUE+jEWe33/qNgR+yTM8VCmmwLCRdJtATehgTw5dUtqYogrUH82
         3e3GKCFgbH1JIy1aoy2T4EW5sj3DPjDYiSAtc6RVHPgt1Bhur0nmukH5AjsP21ysZXt4
         JODPkkFBxhY4xU9D8fy+3lSbiA3pT95ZwtqQMePN7tOCJLkH29zdV/i/wvfekoMtkcmf
         6ZpUlhO+X9RWDy5UWcqJ2928IeXkdIWQ4TMnTTR4JiLFZGM2OncgStajsPCSzCa84UQe
         Y3VlqsU5ucZAnixcrstuv/khT1KRkU591VJ8sk166oqJvcHmgn629zyAkwv4iaFWgEV6
         Wxpw==
X-Forwarded-Encrypted: i=1; AJvYcCX/pYxiYR8AKK6yCNk7GG9xRTiMUKEROfmvmmFLrbOuvTdTDWsNfYE4LxF1M7HQlPO9rbc2pOXMNlhrqkhpywfg7rBrz0lhJkFVh32x
X-Gm-Message-State: AOJu0YzMSmvpfE8RSnU/AXz8DZVZpCszEEYM3JUq5OYGms0sTEdsZkNa
	Fc5yToFK46IHdfU2LxlT3ysrhiCjtIwJMuafisFakj6IqEqD9WfwVgqUiVofPsiRGZzCxcVn7kp
	GfUyQEBI2snlAZZR+3/KM7zQYacsBKrTdhhdx0hzeLa3zeAR6duGLaIpsCr9HJA==
X-Received: by 2002:a0c:df93:0:b0:6b4:fece:1322 with SMTP id 6a1803df08f44-6b501ebbe51mr94781236d6.55.1718969213640;
        Fri, 21 Jun 2024 04:26:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtpc/94A17BbeMJBFiG1uB3pSn3hfOV4uhOgztsnw0fPNyMBVvu8SC58FfeqcgOO6s7gUeSg==
X-Received: by 2002:a0c:df93:0:b0:6b4:fece:1322 with SMTP id 6a1803df08f44-6b501ebbe51mr94780956d6.55.1718969213179;
        Fri, 21 Jun 2024 04:26:53 -0700 (PDT)
Received: from [10.26.1.93] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ecfe878sm7912306d6.14.2024.06.21.04.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 04:26:52 -0700 (PDT)
Message-ID: <c3f923f7-05b1-44ec-8cc2-e5dff1cbd2c6@redhat.com>
Date: Fri, 21 Jun 2024 07:26:51 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: Add config to disable ACPI SPCR console by
 default on arm64
To: Liu Wei <liuwei09@cestc.cn>
Cc: catalin.marinas@arm.com, guohanjun@huawei.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, rafael@kernel.org, sudeep.holla@arm.com,
 will@kernel.org
References: <20240530015332.7305-1-liuwei09@cestc.cn>
 <20240621044706.87181-1-liuwei09@cestc.cn>
Content-Language: en-US
From: Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <20240621044706.87181-1-liuwei09@cestc.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/21/24 00:47, Liu Wei wrote:
> For varying privacy and security reasons, sometimes we would like to
> completely silence the serial console output, and only enable it through
> cmdline when needed.
> 
> But there are many existing systems that depend on this console,
> so add CONFIG_ARM_DISABLE_ACPI_SPCR_CONSOLE for this situation.
> 
> Signed-off-by: Liu Wei <liuwei09@cestc.cn>
> Suggested-by: Prarit Bhargava <prarit@redhat.com>
> ---
> 
> v2: Add a config option suggested by Prarit
> ---
>   arch/arm64/kernel/acpi.c   | 12 ++++++++++++
>   drivers/acpi/arm64/Kconfig | 11 +++++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index dba8fcec7f33..3365fabb5cf8 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -227,7 +227,19 @@ void __init acpi_boot_table_init(void)
>   		if (earlycon_acpi_spcr_enable)
>   			early_init_dt_scan_chosen_stdout();
>   	} else {
> +		/*
> +		 * For varying privacy and security reasons, sometimes need
> +		 * to completely silence the serial console output, and only
> +		 * enable it by cmdline when needed.
> +		 * But there are many existing systems that depend on this
> +		 * behavior, so use CONFIG_ARM_DISABLE_ACPI_SPCR_CONSOLE.
> +		 */
> +#ifdef CONFIG_ARM_DISABLE_ACPI_SPCR_CONSOLE
> +		acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
> +#else
>   		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
> +#endif
> +

I don't think you want a config option here after all.  See my previous 
comment about "acpi=nospcr".  I realized that if you do use a config 
then distros will not have the ability to default 'on', and advise users 
to disable it for their use cases.

Try the 'acpi=nospcr' option.  That should keep everyone happy.

P.

>   		if (IS_ENABLED(CONFIG_ACPI_BGRT))
>   			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
>   	}
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index b3ed6212244c..7e4d860d7089 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -21,3 +21,14 @@ config ACPI_AGDI
>   
>   config ACPI_APMT
>   	bool
> +
> +config ARM_DISABLE_ACPI_SPCR_CONSOLE
> +	bool "Disable ACPI SPCR Console by Default on Arm64"
> +	depends on ARM64 && ACPI_SPCR_TABLE
> +	default n
> +	help
> +		For varying privacy and security reasons, sometimes need to
> +		completely silence the serial console output, and only enable
> +		it by kernel cmdline when needed.
> +
> +		Say Y to disable ACPI SPCR console by default.


