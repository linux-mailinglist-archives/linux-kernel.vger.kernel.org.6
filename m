Return-Path: <linux-kernel+bounces-231643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A6B919B36
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 550A2B23CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C821194143;
	Wed, 26 Jun 2024 23:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="E8XP5vsF"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D1C18FC9D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 23:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719445122; cv=none; b=Kzlt7bSuVA0BmKIrpWj97K3XOo35yyjSNQsDP+2aDzPjOa4gz0wE1i1i1UHo+TrMS6mlfQ/6aa2oRdkWAs9qXflc9mrfu7dfpLeatn4olrlqZiYaGxQjgNLkkd3bc4F/1WxcQufitKMkVTBHzCKuNuZXKLOqJEd9W46EgmpWUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719445122; c=relaxed/simple;
	bh=yMhUcD6XA5r3olQqJIjnjtAAM+yoRZbxb3Sw6OiqKzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0EH0TKgQlZD09bIDZQTa/X/NXtQL8NAOw7BBLrfitd/6knEzf46ppLP5QwDJqqCvshbHr8YkWJ8kH5EWqpGh8Blg9Coyqz8JT3kaJTYrmZmtgDgG57GVUaORrqlbr8Kt3qFI/mqh7T4bTFLVAMriwdgTwNbwm1pPuy/4J3ca0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=E8XP5vsF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c7cfba36f8so1270918a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1719445119; x=1720049919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5l2iQ8Un/MYJ+DJGhn22FpNWybdeze/D551Fw/5heU=;
        b=E8XP5vsF3iA2lFi+EVpaqegJPo5ordt52TawI+z8w1oE37kIc4e4DxpWlAIyfycbUm
         Lgx5IrMcVTSviEAt6NuYF9tzltZ/VomlVXYeF5Fl+BgRlnav1NGg7lyP0fR8BJUUHo0J
         RMsdFY+ZGdDXq9c+G7IPPtUR6enM3ySKWuQtzvIRGtgtmcA3X8g4gSRoQQpccWEQRcJ/
         vjtFESfuWSlVzA39C/1JtTaocQZ0EKgUU8apAEIneN4I/UUy92sjo1Pe3nMAzHpTXfMf
         HqjTTiMWcFHOZsv1w3rg2Oau8RmD+CN8xCHiJ7Vq3cWLzuY5TdD+03hAJd34tldWP5lO
         LSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719445119; x=1720049919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5l2iQ8Un/MYJ+DJGhn22FpNWybdeze/D551Fw/5heU=;
        b=lbgcSpouMQ5O97Xi4gHbKkag4Llz6jjKC3aVllGeZXt5hmZT1uao1NSRGGdawvRYvJ
         mJBJr2QvLB44kjxoJtHNn52iSFir3HQpKPXZq1A9L7xuDeXvusjRGJMBhtD/UT0f2Vbi
         uNyfRB+AUgrJQfwSZQrkMu7vj1/2v0Kmgn279wquBDXG5wqboBJTJ0CCnpE2qy86N+Zy
         nDWJcCqZ93LTd85JuKZEUBfhUb+s7ClVpEyeZwC9X9vCv58HNE3uFCGSw6CLVuJxkOCr
         H6+4Sgqqf6thGoDeHLCW8jpA8KW0maTcU+JwB/z+RgUMeEPvCfRXj9X7tOyEYS6GYt7H
         tq3g==
X-Forwarded-Encrypted: i=1; AJvYcCUu+44ldRSMEnZx7MCf/L6Cm8JRKG04+8iE+PnH46jRIpUHuy8htUR4EMmIes96+0xXGJef1gzbYPBolbKGvCYBFfr/ZiZoV2F825ZN
X-Gm-Message-State: AOJu0YwJZDR3tvcR6BH0sbSVzYQViz1Rpc9JFbpLKnPFNtjCptmb7n4d
	MFtswWZUWthbfCUzkf/kAzgYskMVId5ikPn4WVo5KA6+mc9spdAunD0AedlXBQ==
X-Google-Smtp-Source: AGHT+IEIxwlFob/uR3zR47IhM4aRFVDuY3BEZzYIiR7DjwWFH88aC1QjMj212v19rbPR+O7dL4RCqQ==
X-Received: by 2002:a17:90a:6286:b0:2c8:af45:adb9 with SMTP id 98e67ed59e1d1-2c8af45af82mr6393441a91.0.1719445119379;
        Wed, 26 Jun 2024 16:38:39 -0700 (PDT)
Received: from [192.168.50.113] ([27.96.222.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8fe9f210esm91677a91.31.2024.06.26.16.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 16:38:38 -0700 (PDT)
Message-ID: <c6609d59-8bfc-462c-98cf-db9b5373a497@tenstorrent.com>
Date: Thu, 27 Jun 2024 09:38:33 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] riscv: implement user_access_begin and families
To: Jisheng Zhang <jszhang@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240625040500.1788-1-jszhang@kernel.org>
 <20240625040500.1788-2-jszhang@kernel.org>
Content-Language: en-US
From: Cyril Bur <cyrilbur@tenstorrent.com>
In-Reply-To: <20240625040500.1788-2-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/6/2024 2:04 pm, Jisheng Zhang wrote:
> Currently, when a function like strncpy_from_user() is called,
> the userspace access protection is disabled and enabled
> for every word read.
> 
> By implementing user_access_begin and families, the protection
> is disabled at the beginning of the copy and enabled at the end.
> 
> The __inttype macro is borrowed from x86 implementation.
> 

Beat me to it, I've written an almost identical patch. The performance 
improvement where the unsafe_ variants are used is very good even 
without the rest of the series.

Reviewed-by: Cyril Bur <cyrilbur@tenstorrent.com>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   arch/riscv/include/asm/uaccess.h | 63 ++++++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 72ec1d9bd3f3..09d4ca37522c 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -28,6 +28,19 @@
>   #define __disable_user_access()							\
>   	__asm__ __volatile__ ("csrc sstatus, %0" : : "r" (SR_SUM) : "memory")
>   
> +/*
> + * This is the smallest unsigned integer type that can fit a value
> + * (up to 'long long')
> + */
> +#define __inttype(x) __typeof__(		\
> +	__typefits(x,char,			\
> +	  __typefits(x,short,			\
> +	    __typefits(x,int,			\
> +	      __typefits(x,long,0ULL)))))
> +
> +#define __typefits(x,type,not) \
> +	__builtin_choose_expr(sizeof(x)<=sizeof(type),(unsigned type)0,not)
> +
>   /*
>    * The exception table consists of pairs of addresses: the first is the
>    * address of an instruction that is allowed to fault, and the second is
> @@ -335,6 +348,56 @@ do {									\
>   		goto err_label;						\
>   } while (0)
>   
> +static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
> +{
> +	if (unlikely(!access_ok(ptr,len)))
> +		return 0;
> +	__enable_user_access();
> +	return 1;
> +}
> +#define user_access_begin(a,b)	user_access_begin(a,b)
> +#define user_access_end()	__disable_user_access();
> +
> +static inline unsigned long user_access_save(void) { return 0UL; }
> +static inline void user_access_restore(unsigned long enabled) { }
> +
> +#define unsafe_put_user(x, ptr, label)	do {				\
> +	long __kr_err = 0;						\
> +	__put_user_nocheck(x, (ptr), __kr_err);				\
> +	if (__kr_err) goto label;					\
> +} while (0)
> +
> +#define unsafe_get_user(x, ptr, label)	do {				\
> +	long __kr_err = 0;						\
> +	__inttype(*(ptr)) __gu_val;					\
> +	__get_user_nocheck(__gu_val, (ptr), __kr_err);			\
> +	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
> +	if (__kr_err) goto label;					\
> +} while (0)
> +
> +/*
> + * We want the unsafe accessors to always be inlined and use
> + * the error labels - thus the macro games.
> + */
> +#define unsafe_copy_loop(dst, src, len, type, label)				\
> +	while (len >= sizeof(type)) {						\
> +		unsafe_put_user(*(type *)(src),(type __user *)(dst),label);	\
> +		dst += sizeof(type);						\
> +		src += sizeof(type);						\
> +		len -= sizeof(type);						\
> +	}
> +
> +#define unsafe_copy_to_user(_dst,_src,_len,label)			\
> +do {									\
> +	char __user *__ucu_dst = (_dst);				\
> +	const char *__ucu_src = (_src);					\
> +	size_t __ucu_len = (_len);					\
> +	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
> +	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
> +	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
> +	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
> +} while (0)
> +
>   #else /* CONFIG_MMU */
>   #include <asm-generic/uaccess.h>
>   #endif /* CONFIG_MMU */

