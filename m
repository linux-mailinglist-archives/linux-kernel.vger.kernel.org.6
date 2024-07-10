Return-Path: <linux-kernel+bounces-247215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CBB92CC99
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D2428169B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4F584D29;
	Wed, 10 Jul 2024 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="EobwZ/Q/"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED725757
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599222; cv=none; b=Uv1iYDZDtHVGvZgq8hnSkWvYeR2jdX+d8g9SyfNnsqxYKlK0pCo0xNTpv25oIxvl3pecVidgGB+LX4GuVGhlH4koauiK8S2rp4IfTOXQjTaVPs39/NMg3JjR/ED1rZGESP6zX6kCaNRaTXnziDYRPot/+pjjOlOvDQ0Q4E093rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599222; c=relaxed/simple;
	bh=i5TtDYHg3eKGtsjVT3dZaJXu5Tx7kxeCi9pGUsRuLcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIBnOr24w+tm9EctPdfRYln1ltsT1XyAPAeVh0F0cVBJW2Vs8TXI/HdM6Di7/mFXt7PTWCvhjG+G3IkI/r5iaIldBtrVaqiE8nFBFgmcpRbgfFqoYgLcSjqWfsICaoJDIsHOlnPpOYzFZR4ZLGFzmXyMyiWAE4WV2FYnUEf4fkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=EobwZ/Q/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42673554402so2114665e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720599219; x=1721204019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljKsUTZvZVP6wXh4lGuG/G1a2SNPwlawfzj7RkjMJM0=;
        b=EobwZ/Q/BRPD8HWJkvQ4IMX/oNYaXX+PcRZJkI4WMjlvd8Df0J/6flzQJKmP4gUtkZ
         YJfje+/sr2KvSv4QL9La0lyAo+/wI6gODNJkjocdbi1k6i/VQczISFTAlK4tjWbd+Otx
         1ejWgJKZHLwl94cpgn9Q1o9xRR3jAxW3QnWxwzw6mVkLjhfA59lpxuXJtrLMFFvQSGP8
         ZA3+uKzEqnwdJWO/zHrBOVJMwKCZv2pvJfaqrw122QNcQs/f/4B68K34KiSra+yJMR/+
         3hFTDCKffWHv8ZM/GSHCvsGFKtKDiNWK+dmBgjVvex0gCVivnE03W++oNDow0Qp/nsZm
         uK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720599219; x=1721204019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljKsUTZvZVP6wXh4lGuG/G1a2SNPwlawfzj7RkjMJM0=;
        b=Ar6KNYE2h+VxXBWbsoJDVRTby+aKmCX5WV7o5NwYPAJV1QzuBlai2Cn3GtfJU+N6p1
         f7sicvAfq5hcUx0KhTQiHqop3SqlIxL9I4MNAGcKeAwoSQuWI1AizHiw/9udV4xQX4zA
         MhT08LOgMfzx8ssVoKqxnvdDKQfypGxDNrEX2GWuQXRUVBiGe5HxLffSCzObwR4BhpnH
         lNtQyxiru5IXDp7m1xsEk/TwdkFkjhgg4Sio9pd3G3Ysm5Pki96RpNTjiPZeiFUdkDVv
         AwRpyBxzRklAiPICURG14rPDwOXbFI1njyjSUHoEq/mgeeuBPLdtUEUjPhmvgRtknkXa
         4Ltg==
X-Forwarded-Encrypted: i=1; AJvYcCXd8o0E//7bjaSABdRBIkEL4n/GSZk485qzyH8a6N6laKtsUKMdGT5Fb9KBayiZeb0dqbRptB0SHgb7j4L0b6N6Njo16pcUoYFwbHRI
X-Gm-Message-State: AOJu0Yzppm7PBYjWGsQUp9CdP6Gu/b2q3m+BazunBqtngJGt6GxOTMcA
	kOzHaJq7+n6Ok2O+1Ha12wPb855T6tTzVnvjjpvRwJMMZ6NeEnkeNQet1F6IjsI=
X-Google-Smtp-Source: AGHT+IHMHSxoqd+xgXgy0bOLqdNFMIpV82LR87YS4YDu/bmyWzgaPs82YtW9EUoqmZ7uEZvtEBsJIw==
X-Received: by 2002:a05:600c:1d1a:b0:426:6a0d:1ae5 with SMTP id 5b1f17b1804b1-4266ff87d7cmr33227115e9.0.1720599219289;
        Wed, 10 Jul 2024 01:13:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:9fb4:e15f:31d3:4404? ([2a01:e0a:e17:9700:9fb4:e15f:31d3:4404])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-426740d88bcsm39416755e9.1.2024.07.10.01.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 01:13:38 -0700 (PDT)
Message-ID: <11053a90-08c5-426c-ae15-ed61e7286980@rivosinc.com>
Date: Wed, 10 Jul 2024 10:13:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] riscv: select ARCH_USE_SYM_ANNOTATIONS
To: Jisheng Zhang <jszhang@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240709160536.3690-1-jszhang@kernel.org>
 <20240709160536.3690-3-jszhang@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240709160536.3690-3-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09/07/2024 18:05, Jisheng Zhang wrote:
> Now, riscv has been converted to the new style SYM_ assembler
> annotations. So select ARCH_USE_SYM_ANNOTATIONS to ensure the
> deprecated macros such as ENTRY(), END(), WEAK() and so on are not
> available and we don't regress.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0525ee2d63c7..c51b32a8ddff 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -62,6 +62,7 @@ config RISCV
>  	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
>  	select ARCH_USE_MEMTEST
>  	select ARCH_USE_QUEUED_RWLOCKS
> +	select ARCH_USE_SYM_ANNOTATIONS
>  	select ARCH_USES_CFI_TRAPS if CFI_CLANG
>  	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if MMU
>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU

Hi Jisheng,

It now compiles with the previous patch (using the defconfig).

Reviewed-By: Clément Léger <cleger@rivosinc.com>

Thanks !

Clément



