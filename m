Return-Path: <linux-kernel+bounces-538899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0B4A49E9C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39893BA6E3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E586027002E;
	Fri, 28 Feb 2025 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGVWLE05"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A3226A1A9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759659; cv=none; b=SP0o/UeEqfDK0MrwQd3Zl63s3ddpgr3yFU0GrmMJvfJm9+rJwgu3Ol2bCSPrJT5tzHuIYJqp/mbi//FoThg7E86LyTX/Jgs0xoCsiHUjTamY2G2TUgO9yolkcXQTsL6nOmt46P+a9O3SDgHO4J4sK1fTh5ytGVtlTyTxYkFujxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759659; c=relaxed/simple;
	bh=DisHIpd3riEUJtQ+q6DzRucAB6idSydPKUi1F9k0wCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9sgOMGzQViXRiy5SVmsP3CJudwukZOgl/D5kCdqRCRy+oyDqkrWIVGMJMhZ1Aq6NUtiiy9IqooIhbysKM0FylQt92hgmLZ6BcZN6/tsQM5Iq8lWskk8GuqutI14p0ttu9O9UBCCPMosbRwjatJpK6jSBF+tuQ6lU5bA43Ce2Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGVWLE05; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abec8c122e4so337993566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740759655; x=1741364455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7M+V9Yl376O4gnMwc9q31099MVdI1Xt7kytD7LSxeY=;
        b=lGVWLE05FKlhiDFNdKq23jx2Kl70oCSTjC5GnorzRunrUAW+zIq7ngcVciCrePX9dW
         ARHhOSY+vJpl6KzPUQmx44FvR7Qq4L/0mINzh/wlJ6elkF6laux+Nq544EEONBCEAJCu
         kVWUCGyIFntGSJFFuAybHIVgFfKzf6qX6olCzB+dgHkLR5krAsPnE4QXP8z6LeuFa6sg
         7zJNTh0vYNnX3Z2LN6MZxjNH9EdgbbYKnR1xp58xQoISpCuk5bPqIT4ycXaQCYfsE5pt
         GoAiDKm8PvhkAQoN9XgJFpybL+5fM6YZq5sizhIWRDvpB34RKNkJvnZjv4RppsyByIYf
         +aLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740759655; x=1741364455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7M+V9Yl376O4gnMwc9q31099MVdI1Xt7kytD7LSxeY=;
        b=vWHhddZ1bWruWMSICg2WqSTyRDKJleHb9vhOwlM+koP4Hw+miisPccCfWStgujW7jm
         pS+iMsb4fv8KTLMchbYn1Mg/tHNAwHaTqfaVIAuQmiU1zD8CVOj2MFz3670KuoKYcSS2
         ZdhVftH6dNK1ENPUjRSHu1agzz9Gt0ou/cm1vi3PKvi1NNMddMSh71Dy48SXKjRS75pr
         f5cIZLoeOw/VfZ5TlMdA0ERn4XcKpKaGeOgDiBw857hoZckHyTuwEDkLwq3wRAdh/un2
         lyaO+jHx07RP+S74uruCr+RoUWj1q0V1YynPc+YoHj6C0ZnNP5gXm/t/Ac3ApjVXBu4Y
         jLjA==
X-Forwarded-Encrypted: i=1; AJvYcCUz/ZrU7hcg4G3nSfVkz9aiQYvnjAmAvat+bBJHIIL1m6dotkKCSrltFfM9pSpS2B2NkZuL3p94aD6te34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd4OI4BmU+7yjWHNofjNwvgKF/b4rjNNbrFH1VyVdX+PmRQN89
	zyTrOLmI7BqJxkj5vqp3EbSiC4Gy9Ha5SAvA0T0iG4PUU9eogCFk
X-Gm-Gg: ASbGncvFApqCPGYxfm0EzynSSxEYxe7QlzWX7vNdUQCrkdGhz6L7aRN/AnkkreS0LLw
	kBfub6ZgcPZAZj/LcdSfYN4u7gpBoNyqDtpFBV1gMv2JMMQz94JJ92Tg5m0Vq7tIKnmzRQxi+WQ
	8/QNPJHcgCcvWwQXIbKPOOib/Jqoy5z4I9zK9sYlkjVEPQ8tWv52pEB7nYqyB5qVk4TiS1Tu5rB
	GUL4eIgot5ez7OoLJgqgpLPVp/zmmitvaY785X8o/lcuiAywhBkI7zVggDg7YNKS74WCOcr5NQp
	MqLK7QJ+QoI/IQUA3axCeAK/bK0jqdHUXsB67Aj//CT6JHuphLZFJBVvd/ZQxAruMCc4gbO0u5D
	B+LA1rh3tZBiP0dQhkxcdXQ89UcnsrHnm6MCyMpS/qlzSjCc=
X-Google-Smtp-Source: AGHT+IE7vjvgr6V/Y5vbrY0YJkiKPt7c7FvPgqVZACyEKsNHd80OZCHihtZaKOCuHVBq0KYagJIXqg==
X-Received: by 2002:a17:906:f597:b0:abe:bfdd:e68c with SMTP id a640c23a62f3a-abf25d94352mr435164066b.4.1740759654346;
        Fri, 28 Feb 2025 08:20:54 -0800 (PST)
Received: from ?IPV6:2a02:a466:68ed:1:901d:839a:eedb:7409? (2a02-a466-68ed-1-901d-839a-eedb-7409.fixed6.kpn.net. [2a02:a466:68ed:1:901d:839a:eedb:7409])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c75c333sm315373966b.145.2025.02.28.08.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 08:20:54 -0800 (PST)
Message-ID: <8c8a5aa5-f434-4006-b36c-02311b94041f@gmail.com>
Date: Fri, 28 Feb 2025 17:20:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] x86: document X86_INTEL_MID as 64-bit-only
To: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>
References: <20250226213714.4040853-1-arnd@kernel.org>
 <20250226213714.4040853-9-arnd@kernel.org>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20250226213714.4040853-9-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 26-02-2025 22:37, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The X86_INTEL_MID code was originally introduced for the 32-bit
> Moorestown/Medfield/Clovertrail platform, later the 64-bit
> Merrifield/Moorefield variants were added, but the final Morganfield
> 14nm platform was canceled before it hit the market.
>
> To help users understand what the option actually refers to, update the
> help text, and add a dependency on 64-bit kernels.
>
> Ferry confirmed that all the hardware can run 64-bit kernels these days,
> but is still testing 32-bit kernels on the Intel Edison board, so this
> remains possible, but is guarded by a CONFIG_EXPERT dependency now,
> to gently push remaining users towards using CONFIG_64BIT.

That is a bit more than I said :-) I only know of Merrifield, as Andy 
removed the SFI bits and got ACPI working. For the other platforms I 
don't know the status. Additionally there are pieces of code where 32b 
runs substantially faster than 64b (I know of at least crc32c).

Maybe Andy can confirm the other platforms?

> Cc: Ferry Toth <fntoth@gmail.com>
> Link: https://lore.kernel.org/lkml/d890eecc-97de-4abf-8e0e-b881d5db5c1d@gmail.com/
> Acked-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/x86/Kconfig | 50 ++++++++++++++++++++++++++++--------------------
>   1 file changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index aba32f88870d..42dd3c58abfb 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -548,12 +548,12 @@ config X86_EXTENDED_PLATFORM
>   		RDC R-321x SoC
>   		SGI 320/540 (Visual Workstation)
>   		STA2X11-based (e.g. Northville)
> -		Moorestown MID devices
>   
>   	  64-bit platforms (CONFIG_64BIT=y):
>   		Numascale NumaChip
>   		ScaleMP vSMP
>   		SGI Ultraviolet
> +		Merrifield/Moorefield MID devices
>   
>   	  If you have one of these systems, or if you want to build a
>   	  generic distribution kernel, say Y here - otherwise say N.
> @@ -598,8 +598,31 @@ config X86_UV
>   	  This option is needed in order to support SGI Ultraviolet systems.
>   	  If you don't have one of these, you should say N here.
>   
> -# Following is an alphabetically sorted list of 32 bit extended platforms
> -# Please maintain the alphabetic order if and when there are additions
> +config X86_INTEL_MID
> +	bool "Intel Z34xx/Z35xx MID platform support"
> +	depends on X86_EXTENDED_PLATFORM
> +	depends on X86_PLATFORM_DEVICES
> +	depends on PCI
> +	depends on X86_64 || (EXPERT && PCI_GOANY)
> +	depends on X86_IO_APIC
> +	select I2C
> +	select DW_APB_TIMER
> +	select INTEL_SCU_PCI
> +	help
> +	  Select to build a kernel capable of supporting 64-bit Intel MID
> +	  (Mobile Internet Device) platform systems which do not have
> +	  the PCI legacy interfaces.
> +
> +	  The only supported devices are the 22nm Merrified (Z34xx)
> +	  and Moorefield (Z35xx) SoC used in the Intel Edison board and
> +	  a small number of Android devices such as the Asus Zenfone 2,
> +	  Asus FonePad 8 and Dell Venue 7.
> +
> +	  If you are building for a PC class system or non-MID tablet
> +	  SoCs like Bay Trail (Z36xx/Z37xx), say N here.
> +
> +	  Intel MID platforms are based on an Intel processor and chipset which
> +	  consume less power than most of the x86 derivatives.
>   
>   config X86_GOLDFISH
>   	bool "Goldfish (Virtual Platform)"
> @@ -609,6 +632,9 @@ config X86_GOLDFISH
>   	  for Android development. Unless you are building for the Android
>   	  Goldfish emulator say N here.
>   
> +# Following is an alphabetically sorted list of 32 bit extended platforms
> +# Please maintain the alphabetic order if and when there are additions
> +
>   config X86_INTEL_CE
>   	bool "CE4100 TV platform"
>   	depends on PCI
> @@ -624,24 +650,6 @@ config X86_INTEL_CE
>   	  This option compiles in support for the CE4100 SOC for settop
>   	  boxes and media devices.
>   
> -config X86_INTEL_MID
> -	bool "Intel MID platform support"
> -	depends on X86_EXTENDED_PLATFORM
> -	depends on X86_PLATFORM_DEVICES
> -	depends on PCI
> -	depends on X86_64 || (PCI_GOANY && X86_32)
> -	depends on X86_IO_APIC
> -	select I2C
> -	select DW_APB_TIMER
> -	select INTEL_SCU_PCI
> -	help
> -	  Select to build a kernel capable of supporting Intel MID (Mobile
> -	  Internet Device) platform systems which do not have the PCI legacy
> -	  interfaces. If you are building for a PC class system say N here.
> -
> -	  Intel MID platforms are based on an Intel processor and chipset which
> -	  consume less power than most of the x86 derivatives.
> -
>   config X86_INTEL_QUARK
>   	bool "Intel Quark platform support"
>   	depends on X86_32

