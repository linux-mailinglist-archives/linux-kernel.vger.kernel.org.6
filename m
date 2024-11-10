Return-Path: <linux-kernel+bounces-403377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD489C34BE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0973B20E3A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50723155C9A;
	Sun, 10 Nov 2024 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZBpJIe1"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357A861FE9
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731273357; cv=none; b=ixI5cF70FBhssaavOMUKgQO52d0Qr/8o39H3pqo9aIaOXvmA3Q9hyQ8/Wc4kEW9fggB7uqbuMFH95aJ+vEEBf3mX+fzaoeWyULaqYI9WmAwLLTEusdPlCMijjP6Tz8XgA4DE69KjE3+AGRuMKQQjKpAKlF5SLEnM4eduj/vf4lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731273357; c=relaxed/simple;
	bh=z75w7avnvBb0t7zr8OGTyA4zqWln9jUElk77pQBRSi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Glyre0EKN9O9VHmM6D1KkYESS8su9cY5slT7YzA6zrJuu9uRKiK0ksWCJ5X/ksFOiEReMrSixeSjl/2rOZzWUj3qRuSUVGGC4pDb5xSLn5tb51DUobQ7y1bsBWDUB0p/O7s2qDpz+PHUE2NGkpAWac3WfLKU+iMfzNdNxEj86ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZBpJIe1; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4609d8874b1so32063591cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 13:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731273355; x=1731878155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AG8mReJsrFYSFuqEgfHLQC6MR+XTmmn8w2H1oDxPNbo=;
        b=EZBpJIe1JMeUJ8xt/fNM1Rt38PsnvBp0YQNOhcZR/t5v0Q5HipAQlV0H9UXsjPKA46
         prFWqQRdNGqIvZzrAqxRG1nGoSVYUCk3V6Km1JUlmoTafWYqLWQnjG1Ga7EENoqBcm1U
         NqCRidrorb0dL3wUpcCoNTh8hLnTKwgclzejzOIjdlN8G04/vtHFMj1GFwLZYZi150MP
         HzvFRriCdGPzFYpWJFb8vzgK8ggkxpr51nN/sms2Lk0eZsvUkJQQ09g86LtlWmUUKDXK
         /17PM6qhq8kITwKyOwHG+GOLKMyHMBIdKlci2/wRGpRKFMw7GFG1ug66uuksjJlpOvv9
         j6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731273355; x=1731878155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AG8mReJsrFYSFuqEgfHLQC6MR+XTmmn8w2H1oDxPNbo=;
        b=PfIgD+5vnFiD4wUjF61HvZMkKMDcBVtXlNJrbSqlh2/3Gh1IjeEru7p1phQ+sompsN
         qNe9WkgSoUCO1nRekvp78PATzRQENTb3Fgtlaf6tRs1k9nl738v7X9yAGFYHV2vm/kw/
         lsSQm4ZREy6Q+zgS7sA2a0TI6uCsYe7U6SvgYZk1mifUtGapUK+RDuu7XBsLZFjAqIsk
         lvQWS1cE1tGZd2e+Epw7wWgdDzd+QrjagFNniuak8Sul4m3YX7Iq0zbTIj9Fqmm81ALV
         bK0t2/G6irio+5SPH7eYxwyTanypdj+UOWv9d8w2xcY2LcQUKFuZO27vQYBuZs9044vK
         KJ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCViXNvMLmykqT6Ch0Y1clcoDek1zzYPSz5k+vUWzZGCE9sr/O4PGqafgdnKJvu6IHDEVOAPcBUARYVh0G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwflgKQbgEeWWHd9s4yf3EIB36Zn8u3c/JvFKWstuHAC87sB6cT
	YTobjakZzOw0Z1KKLkgf+fXVKial3mmD9V99pMX/U8Mr3z/IyiO9
X-Google-Smtp-Source: AGHT+IEUA21eJT6RC7BGoCrGQUVP+nm95ovUgv7XydgYTHvq0Jcdo48GbJHMhG6cNEi8Ea0f+JicQQ==
X-Received: by 2002:a05:622a:4d:b0:460:c5b2:58b7 with SMTP id d75a77b69052e-4630942cc70mr139025861cf.51.1731273355031;
        Sun, 10 Nov 2024 13:15:55 -0800 (PST)
Received: from [10.4.10.38] (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff3df534sm51691451cf.10.2024.11.10.13.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 13:15:54 -0800 (PST)
Message-ID: <208f8a06-c176-4377-8255-7800ecd2cf6c@gmail.com>
Date: Sun, 10 Nov 2024 16:15:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2] riscv: Fix default misaligned access trap
To: Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241108-fix_handle_misaligned_load-v2-1-91d547ce64db@rivosinc.com>
Content-Language: en-US
From: Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <20241108-fix_handle_misaligned_load-v2-1-91d547ce64db@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/8/24 18:47, Charlie Jenkins wrote:
> Commit d1703dc7bc8e ("RISC-V: Detect unaligned vector accesses
> supported") removed the default handlers for handle_misaligned_load()
> and handle_misaligned_store(). When the kernel is compiled without
> RISCV_SCALAR_MISALIGNED, these handlers are never defined, causing
> compilation errors.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Jesse Taube <mr.bossman075@gmail.com>

Thanks,
Jesse
> Fixes: d1703dc7bc8e ("RISC-V: Detect unaligned vector accesses supported")
> ---
> Changes in v2:
> - Change CONFIG_RISCV_SCALAR_MISALIGNED to CONFIG_RISCV_MISALIGNED
>    (Jesse)
> - Link to v1: https://lore.kernel.org/r/20241107-fix_handle_misaligned_load-v1-1-07d7852c9991@rivosinc.com
> ---
>   arch/riscv/include/asm/entry-common.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
> index 7b32d2b08bb6..b28ccc6cdeea 100644
> --- a/arch/riscv/include/asm/entry-common.h
> +++ b/arch/riscv/include/asm/entry-common.h
> @@ -25,7 +25,19 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>   void handle_page_fault(struct pt_regs *regs);
>   void handle_break(struct pt_regs *regs);
>   
> +#ifdef CONFIG_RISCV_MISALIGNED
>   int handle_misaligned_load(struct pt_regs *regs);
>   int handle_misaligned_store(struct pt_regs *regs);
> +#else
> +static inline int handle_misaligned_load(struct pt_regs *regs)
> +{
> +	return -1;
> +}
> +
> +static inline int handle_misaligned_store(struct pt_regs *regs)
> +{
> +	return -1;
> +}
> +#endif
>   
>   #endif /* _ASM_RISCV_ENTRY_COMMON_H */
> 
> ---
> base-commit: 74741a050b79d31d8d2eeee12c77736596d0a6b2
> change-id: 20241107-fix_handle_misaligned_load-8be86cb0806e


