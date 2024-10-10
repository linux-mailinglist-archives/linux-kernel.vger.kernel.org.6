Return-Path: <linux-kernel+bounces-360171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04057999574
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC93A1C22DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A3C1E6310;
	Thu, 10 Oct 2024 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KJNYst0q"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040C61CF282
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728600528; cv=none; b=bg88ZFTbi5weRl2W/Plj63z2Zx+mCklPLhmk/mIZZIo3lLsdwtzFUy6it/PDCmAGeOyVTea2kUoVvi7BO4+LX0pbYQK4WjrXHtdl51HHxoD/6e7NM+wklQXV0ApiHJt+FSAmNS1c6tIVtqcHmcd09IWBSt94D0UOhqfnmuPZPZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728600528; c=relaxed/simple;
	bh=OLt/2umhAcpvlyLrP1uxANxysvLJlvtYUMmDDPZMf2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToDjc6gEvZJzJj8+QEid0sdkMbn+DTYJ0s9Q6S3MMPe4Kk1U5H4dNiSmO3IOsN58tDfc/fzZfmeRXfLRHyFWd3FcG9RpRG0MoC86YHG1KmrSQfS/WMpGYassFC3n8/h/4pYHnhPrCQzX15sQxdIEdOD0SD/vosbDFdOn0fFsSQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KJNYst0q; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2bb1efe78so1045398a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728600526; x=1729205326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RuruuTQI1F7bOhPE7bvI0TF9px8hdoFHJ//CLc8t2q0=;
        b=KJNYst0qvQ2BpIKvJYFxgOBICTvPC4YsOUP9DswrumIYWw/ngx5ro25N9JI/F2aAnd
         QC7m9hNnUpECDupxgfTnQ5n0gccV4kmY7wF9POcv3oOd+MckIKgGm9C/uZRbRvmB7q5U
         lEsRFrl3cBCg1RAqnHu/eTQ0Lk0A3kggv3NQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728600526; x=1729205326;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuruuTQI1F7bOhPE7bvI0TF9px8hdoFHJ//CLc8t2q0=;
        b=gFAYIHA2gxH0utEicottjUf02JHRMWWRxDcCAB0Qg6JF1tF8y9SmT5Av5yRjesAIak
         6xgjpG0pwg4zjwvD+rwLfOBNeKPKwdjOqdC1XRiZfoyvot7zGaL7gO3a3o5VxztMmcWV
         AZrG+2PLd/QkJxBGPyOJchaG3ja+xieYkPJ2uq/vE0EIT7Y1mkO7COkli0o5OLR7eYpT
         Bad37KUMtp4fyfvvP+BFUcVCTB1k33GxGHj72kHHKbtyI1Ko9pmzJamKCCZO9Raxf+OE
         8mDQNsCYRXqhGdwxLRQ5MIO+wlet5hfRjObfpUB1EHxdu0zNqFcK5y74sYD5jf/+QklB
         esNg==
X-Forwarded-Encrypted: i=1; AJvYcCXVnomN5wOrDFDjCaprJlHszs9S2YLtOlmZP0LJ3JLy7+fqzldyjRUIttpOSvVMijkMrE5uw1naMOSn4Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp6nDWSQJYClF1gMtIMfx+eSu8bwuqR4yWGt+s3rFIK/ghNS5k
	heoEa4OM+GAy3adkDcRMPnlxD7H0fHq3SLxR49eqhPTONnDtLtFng7NPBVky2Q==
X-Google-Smtp-Source: AGHT+IGxfFKl6tVNrR6gv+C1ojd8hIpYWRfnnZDa3NdhdrRS8hR0SH4cd+6Zv/Ljodr+6GjIjv+Whw==
X-Received: by 2002:a17:90a:e982:b0:2e2:c744:2eea with SMTP id 98e67ed59e1d1-2e2f0d7b469mr1144000a91.13.1728600526264;
        Thu, 10 Oct 2024 15:48:46 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5fa58easm1901116a91.38.2024.10.10.15.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 15:48:45 -0700 (PDT)
Message-ID: <7fad6060-2466-4af4-b737-b3851d795023@broadcom.com>
Date: Thu, 10 Oct 2024 15:48:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: Refresh bcm2835_defconfig
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Russell King <linux@armlinux.org.uk>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240707-raspi-config-v1-0-3e122f2122e9@gmx.net>
 <20240707-raspi-config-v1-1-3e122f2122e9@gmx.net>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20240707-raspi-config-v1-1-3e122f2122e9@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/7/24 14:48, Jonathan Neuschäfer wrote:
> Regenerate bcm2835_defconfig with "make savedefconfig" in order to pick
> up Kconfig changes that happened since the last refresh.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Stefan, any objections to taking this change in isolation?

> ---
>   arch/arm/configs/bcm2835_defconfig | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
> index b5f0bd8dd53699..da49dcfd359050 100644
> --- a/arch/arm/configs/bcm2835_defconfig
> +++ b/arch/arm/configs/bcm2835_defconfig
> @@ -9,7 +9,6 @@ CONFIG_LOG_BUF_SHIFT=18
>   CONFIG_CFS_BANDWIDTH=y
>   CONFIG_RT_GROUP_SCHED=y
>   CONFIG_CGROUP_FREEZER=y
> -CONFIG_CPUSETS=y
>   CONFIG_CGROUP_DEVICE=y
>   CONFIG_CGROUP_CPUACCT=y
>   CONFIG_CGROUP_PERF=y
> @@ -21,14 +20,10 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>   CONFIG_EXPERT=y
>   CONFIG_KALLSYMS_ALL=y
>   CONFIG_PROFILING=y
> -CONFIG_CC_STACKPROTECTOR_REGULAR=y
> -CONFIG_CRASH_DUMP=y
> +CONFIG_KEXEC=y
>   CONFIG_ARCH_MULTI_V6=y
>   CONFIG_ARCH_BCM=y
>   CONFIG_ARCH_BCM2835=y
> -CONFIG_AEABI=y
> -CONFIG_SECCOMP=y
> -CONFIG_KEXEC=y
>   CONFIG_CPU_FREQ=y
>   CONFIG_CPU_FREQ_STAT=y
>   CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
> @@ -103,13 +98,11 @@ CONFIG_REGULATOR=y
>   CONFIG_REGULATOR_FIXED_VOLTAGE=y
>   CONFIG_REGULATOR_GPIO=y
>   CONFIG_MEDIA_SUPPORT=y
> -CONFIG_MEDIA_CAMERA_SUPPORT=y
>   CONFIG_DRM=y
>   CONFIG_DRM_V3D=y
>   CONFIG_DRM_VC4=y
>   CONFIG_DRM_SIMPLEDRM=y
>   CONFIG_FB=y
> -CONFIG_FRAMEBUFFER_CONSOLE=y
>   CONFIG_SOUND=y
>   CONFIG_SND=y
>   CONFIG_SND_SOC=y
> @@ -178,8 +171,6 @@ CONFIG_PRINTK_TIME=y
>   CONFIG_BOOT_PRINTK_DELAY=y
>   CONFIG_DYNAMIC_DEBUG=y
>   CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> -# CONFIG_ENABLE_MUST_CHECK is not set
> -CONFIG_LOCKUP_DETECTOR=y
>   CONFIG_DEBUG_FS=y
>   CONFIG_KGDB=y
>   CONFIG_KGDB_KDB=y
> 
> --
> 2.43.0
> 


-- 
Florian

