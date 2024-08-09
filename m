Return-Path: <linux-kernel+bounces-281628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C3594D8FF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 01:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1332831A6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 23:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE0216CD13;
	Fri,  9 Aug 2024 23:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="vlPOrv+X"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C81317557
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723244862; cv=none; b=SwjgAMIMVc2vrGAeOB4sTU0msAZKG5Rru68H3MUGLYAcb1G7pTDb9sbOjaArmnCH2h/6JFUDCb734kXBuqP9AwJ6O3BBvQlhOpifqKgU3yKgj69obqQr9WMsgCffg46kx/R7aKbJ6i6h/TZLmvOtFB5abcFcytWyzTYg5foKB8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723244862; c=relaxed/simple;
	bh=m02sB9/i6q4HkiX2nN6zh1LoMvAQgF7/4B6lR6Xjg9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnC2dhS8v9SYqNa7qmJQ3+YpUl18RvL0b+x2BnxapIhhGknmBIFb7T3JxIod6ql+3OHZAktyC9WGD8pAeXbhOXlJpQI8CnOQ+ab8bR/4Ah0d9xYiaF30kKO9BZx0BiP0mmQ5PdfMl3De/ZW3FaTV9DkXEz3Y4gwI//x7sANcjaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=vlPOrv+X; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3686b285969so1325963f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 16:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1723244859; x=1723849659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y0eivMhgT/16iODWZuyqbzSljY+8jVTkdgoKaNN6wIA=;
        b=vlPOrv+XX1DniVHp6Vi+KQofbqDDgDlMhsQZfpySnW7i+ltnuv1eElTqzWMzvsKGO9
         1ty8W6f62gBobYM9iTc+3A8HreITybefc8oPVx5GG/+OwYefnumyhunIjkqUgAunbChv
         6WOcmPqH1/rp24+hVUeKxat5KilLsHS7wuZXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723244859; x=1723849659;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0eivMhgT/16iODWZuyqbzSljY+8jVTkdgoKaNN6wIA=;
        b=it/1Vd6FC41NWrD+yZTkVXcEzWYcaeHwTkC2Wp3QJrKkg8oD0Kf1eiuNxYONtjG1MX
         4j9MewmZGkgNQXQYK6Ky4XcapRoY8zl/YRfTUjXcYlXVTxVRAsMxiNhTQPIo2oazPtg8
         Lf9Ru51zpz2k/i16UemZ4f1OMGhhgBjC70W/C4CFUTrUa2g6rin/Ofel4a8NEcq5D047
         nW4BM7CDW/+8bO9BB9pdSSIAaeIp5pyKav6dLBGTSNH2jmbVmLzPg0I5HcqS/sFIdWKo
         XL8Gx2wTCSV+ko5Qw/e9hsFgrrvEkPSSvHiejA8RQkT1EuEG4KzANiPR8O/WLMT2H94x
         RRzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpzXP5rN/BlSWhmY7rIknlHqqm5SIcImkHC6guCNewZoji32p1kz/QetR4k52sm6YhUzyN6wvijyoJS6h4VOfqfMKDulYOl7kfwBG1
X-Gm-Message-State: AOJu0YxVAJmXwKw3Df0+/IAcxlXV+TC1cD7D0UdFFYQyHySwQDNLc6i/
	84LAEuIH6ayO/5dj3qWMMi08u3tWIgBbROTw8mn9kREvfeP2+hUde1/eLX3fThI=
X-Google-Smtp-Source: AGHT+IE8ACVGbGcWpC/B9siOpXw/z0FWpse3sa0j1h3k5gNlMDlxELp3E/Jxw1C8Y1PMZnq5rqI5Gw==
X-Received: by 2002:a5d:5910:0:b0:36b:bcef:b393 with SMTP id ffacd0b85a97d-36d6035553amr1912323f8f.57.1723244858825;
        Fri, 09 Aug 2024 16:07:38 -0700 (PDT)
Received: from [192.168.101.107] (ip-185-104-136-31.ptr.icomera.net. [185.104.136.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c9381b4sm642151f8f.37.2024.08.09.16.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 16:07:38 -0700 (PDT)
Message-ID: <e18cd005-24ef-497d-b39c-74a54d89a969@citrix.com>
Date: Sat, 10 Aug 2024 00:07:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] x86/msr: Switch between WRMSRNS and WRMSR with the
 alternatives mechanism
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, seanjc@google.com
References: <20240807054722.682375-1-xin@zytor.com>
 <20240807054722.682375-3-xin@zytor.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20240807054722.682375-3-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/2024 6:47 am, Xin Li (Intel) wrote:
> From: Andrew Cooper <andrew.cooper3@citrix.com>
>
> Per the discussion about FRED MSR writes with WRMSRNS instruction [1],
> use the alternatives mechanism to choose WRMSRNS when it's available,
> otherwise fallback to WRMSR.
>
> [1] https://lore.kernel.org/lkml/15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com/
>
> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>  arch/x86/include/asm/msr.h | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
> index d642037f9ed5..3e402d717815 100644
> --- a/arch/x86/include/asm/msr.h
> +++ b/arch/x86/include/asm/msr.h
> @@ -99,19 +99,6 @@ static __always_inline void __wrmsr(unsigned int msr, u32 low, u32 high)
>  		     : : "c" (msr), "a"(low), "d" (high) : "memory");
>  }
>  
> -/*
> - * WRMSRNS behaves exactly like WRMSR with the only difference being
> - * that it is not a serializing instruction by default.
> - */
> -static __always_inline void __wrmsrns(u32 msr, u32 low, u32 high)
> -{
> -	/* Instruction opcode for WRMSRNS; supported in binutils >= 2.40. */
> -	asm volatile("1: .byte 0x0f,0x01,0xc6\n"
> -		     "2:\n"
> -		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
> -		     : : "c" (msr), "a"(low), "d" (high));
> -}
> -
>  #define native_rdmsr(msr, val1, val2)			\
>  do {							\
>  	u64 __val = __rdmsr((msr));			\
> @@ -312,9 +299,22 @@ do {							\
>  
>  #endif	/* !CONFIG_PARAVIRT_XXL */
>  
> +/* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
> +#define WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
> +
> +/* Non-serializing WRMSR, when available.  Falls back to a serializing WRMSR. */
>  static __always_inline void wrmsrns(u32 msr, u64 val)
>  {
> -	__wrmsrns(msr, val, val >> 32);
> +	/*
> +	 * WRMSR is 2 bytes.  WRMSRNS is 3 bytes.  Pad WRMSR with a redundant
> +	 * DS prefix to avoid a trailing NOP.
> +	 */
> +	asm volatile("1: "
> +		     ALTERNATIVE("ds wrmsr",

This isn't the version I presented, and there's no discussion of the
alteration.

The choice of CS over DS was deliberate, and came from Intel:

https://www.intel.com/content/dam/support/us/en/documents/processors/mitigations-jump-conditional-code-erratum.pdf

So unless Intel want to retract that whitepaper, and all the binutils
work with it, I'd suggest keeping it as CS like we use elsewhere, and as
explicitly instructed by Intel.

~Andrew

