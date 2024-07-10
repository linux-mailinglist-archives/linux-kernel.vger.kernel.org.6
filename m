Return-Path: <linux-kernel+bounces-247213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EC292CC91
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 346C3B21893
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471D5126F1A;
	Wed, 10 Jul 2024 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LiAqt8Mt"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2169984DFE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599102; cv=none; b=pzMEELw9ZelqCLJalW1e/vZP/K3VCZzeqT0l6vYNdvHDqy+ZscH3j2YkycMTGRT/xfo5xGipkwfOPnqbuwqR2bTDzCu0pRvpVmIdoKkmuzX5oMXvJoEbfDoWO3ABRsSef/lCVoMzv7h7MdYeUg/ZNhgQ48nkdebuxL98gfWTx94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599102; c=relaxed/simple;
	bh=5FU1zzRFbuB4uhsRO4HVLl91TuFNoGlocUKN1UZpmDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUF/Mjxf+yv9pStRr/ti1Qopb58d/sFZ9TDl2BZQOpE8RsUhHo/zFQ/RPK9z6Qx23Z+JOl2Jzvzo6JoVseUcV7lIF32sRTmx2rjOY23gTHlr0TN7wFSum+2YnMthxoeWfhCtlRT/d5BGgwuwIK2FWXEDQnr1xBccsDecCxvQfdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LiAqt8Mt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-426659ff58bso4189675e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720599098; x=1721203898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pP3rsBHrs6LAuVI18mzEk+n0N0LSnWOC/Vuq5a5yPXk=;
        b=LiAqt8MttYegqMf+ySLm4TDI/K67NMC277ExY1lZycNQnNyU/NOPvkNoBSXYeG+EMn
         usOXIJIZSkB44hMr0MvyRo27FfdJvzXFw7LI11+NGDL/p+I0vTW70N0Kj8tZp/qgSqY3
         LwKxBPAk+xyLyOttXm9m4njjJTk8GDuX059oR+GrsuyAYW+gNcd375X1qEaESUkUTObC
         NqGfJpLj77BuIyi4yw4eobvEJTBpFl2BktQd8Yw+D1tj9scOHDp8V/msYD5v/MCAILzE
         G1nKptdbSAXBwfwzt4gt/vDnCZgPlXIV9dcNSHsde0UJoRU6mu4ttRrX9JytaT+/SxB3
         LtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720599098; x=1721203898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pP3rsBHrs6LAuVI18mzEk+n0N0LSnWOC/Vuq5a5yPXk=;
        b=IinQmELMvSJCmyDb6fGGSzWf8AB2dSCDdW3a7i5g0ClmbxuAcpti9Hok/3nOJldfmM
         tp6R/I0L+MvoFmFrdWz5/DxDnrKcSIPpqNHM9e6ZgpMS4le9l9WCA5Q7bfWyW08U2087
         4zroNdDuwB7sHi3URy3/PVTEG4Zng+XSxt0d1QirmCqqZUE+GDJVpl0MqA28frlh6fqy
         Kf2LS0l3u9gmxJbvPhb1uTfnx8JpDAXFtxxocqq44ErUS00GYchPclB7dwOQi0iLuDBA
         txhuQB/OEltTsjyj/fQX3jfiAHKq+/x/YRTx2J/s1iikLV1qmSfM4sNRsa9evhuUbpy7
         iAyg==
X-Forwarded-Encrypted: i=1; AJvYcCV0okcBCCY2ekkGsjzZAfPDGytDwUEQ6cryoXrm9VmsnFMV9KX8xnVI2aPoEXe6knDUz3Ac2/4IhJjoMSyV3LFg8oSejxt43RWgK3+d
X-Gm-Message-State: AOJu0YynxMWNHcjkCHQX/y9KSSEB21PawTl38pjDgnl7BkvvJVYFS2WI
	YB6TVaWrSA2P7zCGbbrlC3n+08VnyuslOjZL81u40SJZa0MKjbLVpRdYwZO9ReQ=
X-Google-Smtp-Source: AGHT+IHiJ1nkZnHNRQCCCBe5FmNUVzq1xa7b8POK+qqL/NKNo3HVmRS2AFa/K/5vF+7jWC2tTjfwew==
X-Received: by 2002:a05:6000:1f8a:b0:367:9614:fdf7 with SMTP id ffacd0b85a97d-367ce5de5admr3310878f8f.0.1720599098343;
        Wed, 10 Jul 2024 01:11:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:9fb4:e15f:31d3:4404? ([2a01:e0a:e17:9700:9fb4:e15f:31d3:4404])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde8467fsm4608471f8f.27.2024.07.10.01.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 01:11:37 -0700 (PDT)
Message-ID: <c053051f-e469-4ec9-a5a3-509fb2232d3f@rivosinc.com>
Date: Wed, 10 Jul 2024 10:11:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] riscv: errata: sifive: Use SYM_*() assembly macros
To: Jisheng Zhang <jszhang@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240709160536.3690-1-jszhang@kernel.org>
 <20240709160536.3690-2-jszhang@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240709160536.3690-2-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09/07/2024 18:05, Jisheng Zhang wrote:
> ENTRY()/END() macros are deprecated and we should make use of the
> new SYM_*() macros [1] for better annotation of symbols. Replace the
> deprecated ones with the new ones.
> 
> [1] https://docs.kernel.org/core-api/asm-annotations.html
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/errata/sifive/errata_cip_453.S | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/errata/sifive/errata_cip_453.S b/arch/riscv/errata/sifive/errata_cip_453.S
> index f1b9623fe1de..b1f7b636fe9a 100644
> --- a/arch/riscv/errata/sifive/errata_cip_453.S
> +++ b/arch/riscv/errata/sifive/errata_cip_453.S
> @@ -21,7 +21,7 @@
>  1:
>  .endm
>  
> -ENTRY(sifive_cip_453_page_fault_trp)
> +SYM_FUNC_START(sifive_cip_453_page_fault_trp)
>  	ADD_SIGN_EXT a0, t0, t1
>  #ifdef CONFIG_MMU
>  	la t0, do_page_fault
> @@ -29,10 +29,10 @@ ENTRY(sifive_cip_453_page_fault_trp)
>  	la t0, do_trap_unknown
>  #endif
>  	jr t0
> -END(sifive_cip_453_page_fault_trp)
> +SYM_FUNC_END(sifive_cip_453_page_fault_trp)
>  
> -ENTRY(sifive_cip_453_insn_fault_trp)
> +SYM_FUNC_START(sifive_cip_453_insn_fault_trp)
>  	ADD_SIGN_EXT a0, t0, t1
>  	la t0, do_trap_insn_fault
>  	jr t0
> -END(sifive_cip_453_insn_fault_trp)
> +SYM_FUNC_END(sifive_cip_453_insn_fault_trp)

Hi Jisheng,

Reviewed-By: Clément Léger <cleger@rivosinc.com>

Thanks !

Clément

