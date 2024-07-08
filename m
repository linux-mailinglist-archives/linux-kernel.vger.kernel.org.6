Return-Path: <linux-kernel+bounces-244084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AFF929EFA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDA9284E37
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEE053E22;
	Mon,  8 Jul 2024 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="d9LfoMKp"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A626855E58
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430469; cv=none; b=m23LKqSyCLCWCKXv76UE6oYuKlzDbp5sHqU6U9HimUMkIbVn9vAIeg9WiAUZ8X37k04Mwa7KAb+eFOMMZChKNonh/s/xWjoLnCu6aJmE4Fn2aJhMMdXhdIXTICw7ZlNpkaMvqYUNvgPb8uk25+3H6FMrFpyNHc+0mn9qN4WkA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430469; c=relaxed/simple;
	bh=I8QhZEOkkuFPKbGbEt5Gnqo9X1ZigVSRpSXa/floQDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOSn7R5W4ut1UexMJoQH/jY01bUTF2bk66iyxfTb+6+vLAU9DkLFn+BCHlod3I8wKCJZEt8iE2yKpFAKr39Rmt/AoeLTUo30X9cLGg84ZpE/+leeP8cnb/bFQEyqclfZbIzhiwS+9DxrRdQijJy7KWHGz3GNMlzG5XAVlL1nDN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=d9LfoMKp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b00f3216bso161947b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 02:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720430467; x=1721035267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yONsKyON4CTbcJqehjyTd+ofNBjy0v+0whVPKelNE4U=;
        b=d9LfoMKpoXGLtT0YJGi+LSBbmJGjCx346TpOSjgZRPfBzLbIqPNk4ZUa2BH95ER6La
         NmGt+OaBla/Pg2CxQxVf6JTUcRrugEgC1eyk7wEBE4fL6YrGF3heSTM3LErB6yvZZ4Qq
         uepypOYmSexq3Qfvyemnh/9OLpbTOT2v49eFrpFTv3IIzMtK5ILj06RVdEHPfwbefpSN
         lO10eSPbq8JjrizH5ROcSkUomvQ7zNzjXbvFCQVmDfg2ov3HoFzqAm7nz1T1G7zrj+pg
         XulNGnsOS1y4mQt74UAkszEu9PfzHlRpq0TgZHs8Cy/JV8bl+OMcTjqm5zkHf/D4aMKK
         ntJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720430467; x=1721035267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yONsKyON4CTbcJqehjyTd+ofNBjy0v+0whVPKelNE4U=;
        b=wDewJbRwCuIqlv3eocEsWoZuoZzh/4BVrI2p22WP+kjrdz/cgrQCc69K0NA4I2nfYx
         6yIFfuEN4kWjf3nOJ/KWp0uPxeRkSpsF0KLKPbZMO2USQ2EgDped1GMsOu+XzHP166/l
         vp5TkDpajVam40aIniseOtIxlJu1nrXLhHfjvFWJ01yCxNkEqLcsX+uLF6pEcMG9L1Sh
         7dQ8/UUAVOXgXmiX4R08qkHiWMnJVgt3pb1Zn7ouvMNmLSWIpI9lqTGYweD8IdJOPNoX
         O+B/t7CjpU33XDj4T41qo6MSlrKVZ1Kp9vHi181Cfc+toEUf687fEc+LK3uQSDCX3xV7
         N9Hg==
X-Forwarded-Encrypted: i=1; AJvYcCV91n1xBKSvDlHkVDtxGf+uu8hJ6Df8J7tXGoiaFA2Csyr0/RlztLSSA28gAb1l57xpj0ZxGWb+bitKKPG1dEJN1i9ql0+FX/dHJQtM
X-Gm-Message-State: AOJu0YxWUWMoCAX0XCh8nJETbfcw5624KcuJqD888cLIs8tLVOfD4XeG
	07Km+9ktKbPOo7FTEtWwFlNglFVd+yZetlRPxXFYVjy6+RlDMSMne3Ba9/3MBs1PobVnp3vV/0a
	5358=
X-Google-Smtp-Source: AGHT+IE6l+fF5Oib8luYdfU/tlpPhpXd/IrKtwSiDAdNpn8c69VDxJXQmjGu+WqyNfzAosOJpvap2g==
X-Received: by 2002:a62:e402:0:b0:706:aadc:b0a7 with SMTP id d2e1a72fcca58-70b00918545mr11587876b3a.1.1720430466875;
        Mon, 08 Jul 2024 02:21:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b1086d32dsm5681597b3a.46.2024.07.08.02.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 02:21:06 -0700 (PDT)
Message-ID: <beb8a766-8143-40ad-912b-b04f7937d4a4@rivosinc.com>
Date: Mon, 8 Jul 2024 11:20:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: select ARCH_USE_SYM_ANNOTATIONS
To: Jisheng Zhang <jszhang@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240705132308.1469-1-jszhang@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240705132308.1469-1-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/07/2024 15:23, Jisheng Zhang wrote:
> After commit 76329c693924 ("riscv: Use SYM_*() assembly macros instead
> of deprecated ones"), riscv has been to the new style SYM_ assembler
> annotations. So select ARCH_USE_SYM_ANNOTATIONS to ensure the
> deprecated macros such as ENTRY(), END(), WEAK() and so on are not
> available and we don't regress.

Hi Jisheng,

On which branch/series is it based ? I tried it and it fails on
errata_cip-435.s which still contains some uses of ENTRY():

ENTRY(sifive_cip_453_page_fault_trp)

Thanks,

Clément

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

