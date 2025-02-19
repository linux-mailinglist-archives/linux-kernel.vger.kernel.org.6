Return-Path: <linux-kernel+bounces-522117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1293AA3C642
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337DE7A803B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED391AF0DB;
	Wed, 19 Feb 2025 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="CqmtwNHr"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A28190072
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986304; cv=none; b=e2wbf9UTaDOqLE4xnAw/6ZviP/T6rIH+go8ZyCweVCotjCLUDrA2AMPL+OMyEt0wCuMO6glPFLIeHLXDN2QPi5gRf8dFsgvGywR0M7D+M2Dps5NxIASfnFr8iVQGPHqrP3xf+frTuJrOf12Zk4PDr0MTn8yXLF6L1QbeopInlMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986304; c=relaxed/simple;
	bh=mxjrGgWYQXCElRAHlCHXHhgJqg3yuYMxdLj+lKgQsPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjeMV8Uq7uCHPJyqCt/TfBN/bfHTtcJZTHRYceqpxgMxKBYBJB0RbR36g9hji0PJi2WlVabt3v+FcpZpJkXDiXqigak2wz/q8fn6Xoj5iTJmAg1x3C0a1aos6aMAQA67LlUT4Iv/lFfl52QBRt41oEFty2vQKU7ZAd2T5X3ZETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=CqmtwNHr; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab744d5e567so12472366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739986301; x=1740591101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ghIHrzGh2hoH8gE4+quYuZvFZYMdxRqdrdqhuSHCdUs=;
        b=CqmtwNHrV+yrJY9OwmZY6c5RgcNnEzWGEBEZQdjvATr3G9gm8umol5U/o22a2o/We1
         K0Z5hD425ZJhEACa7Gg8H4lYhidprQMDchxx6ybik4S5lWrFyOAVINop4OTp9Z/gEdQY
         GpaLAJr1sjrGgdmMSZ4byH1N4XH5EhJJHVH0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739986301; x=1740591101;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghIHrzGh2hoH8gE4+quYuZvFZYMdxRqdrdqhuSHCdUs=;
        b=u1ZQ+W01WlAlZ4QuChNMqW1gf7DGSCydtLh9RgYwU8QCs19R5w9lRIP2cKNbYnyKpx
         TiZAK/bCrzsNO9ipy0CavHgIAS6zmlyaML+I5jlHRmJcQbkdLBH2zRPfNAcLwudZN19P
         eNjbyx+aAI1rjz10hvEsJxAy1JmtpR+dPkS8vgnu2jX9K9VhaqZkq9EShiYA2VszbpKQ
         6+KR595O8+tOEgCIPegYTTbKp4GJcwU3iOpGQZdL/ZPTDCkgbDiJEyytoxF86qizmVP0
         qpqwJ8zOF4GLHf71PiADSCsT+BA2Ob9dkATQYt0H11pgAv3+fRev7i2sA5mQEadaCg8g
         NHHA==
X-Gm-Message-State: AOJu0Yxnalx+mJtBN3Dy9wflfQaaOugemEcaVEQ3gca5bK3JGntVovKG
	QzEWiiqICr2mE8YobeAZxGuaLBSG8JGXQixN0rUtLYjA0XG6cbSMKEg4oPd6O4o=
X-Gm-Gg: ASbGncsiIOeFVuojry3wnXGLn01JM/89rfEbPsS6ibiNGYKrcx+Owh4AunN5HBg64xw
	9k//ekl9IxIAizFse01o0a9xrj08OkRh0X6YJP/ImfFJAf3rVLx1ZRPTyVtV2vfcZbo80FhvlV1
	ag96lzhLFo+ydi3K5S838oH3OfY+BDdRwmZuABrOnAskTbWeTAba+/pH8Jm6ybjsn+fndN3xuOJ
	TnnJrxYidCtvTeuNuBlC/R1x5IwF6cglLuOG/GWXxK+iXihmY0FHSu8WOeQte7r9gponZoqhOOL
	HTGd7dTskH3GAti0xtcpV/JlorvW/lZln+sE5tu6qjoxnBpGV1QEoo8=
X-Google-Smtp-Source: AGHT+IGlgWboM5H9JtKTJEUQ/6FPRJEWoofVk6WnUgmL8IQ/qk3Z/LVVgt9/QB/tynQpns/bShUnQw==
X-Received: by 2002:a17:906:6209:b0:abb:e048:4f5e with SMTP id a640c23a62f3a-abbedf3c7e0mr5785366b.29.1739986300744;
        Wed, 19 Feb 2025 09:31:40 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbe4e29b4fsm73044966b.170.2025.02.19.09.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 09:31:40 -0800 (PST)
Message-ID: <dc7c570e-153e-4e46-ae40-d1590682d50c@citrix.com>
Date: Wed, 19 Feb 2025 17:31:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] x86/ibt: Add paranoid FineIBT mode
To: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
 scott.d.constable@intel.com, joao@overdrivepizza.com, jpoimboe@kernel.org,
 jose.marchesi@oracle.com, hjl.tools@gmail.com, ndesaulniers@google.com,
 samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
 kees@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
 jmill@asu.edu
References: <20250219162107.880673196@infradead.org>
 <20250219163515.040300905@infradead.org>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250219163515.040300905@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/02/2025 4:21 pm, Peter Zijlstra wrote:
> --- a/arch/x86/include/asm/cfi.h
> +++ b/arch/x86/include/asm/cfi.h
> @@ -1116,6 +1129,52 @@ extern u8 fineibt_caller_end[];
>  
>  #define fineibt_caller_jmp (fineibt_caller_size - 2)
>  
> +/*
> + * Since FineIBT does hash validation on the callee side it is prone to
> + * circumvention attacks where a 'naked' ENDBR instruction exists that
> + * is not part of the fineibt_preamble sequence.
> + *
> + * Notably the x86 entry points must be ENDBR and equally cannot be
> + * fineibt_preamble.
> + *
> + * The fineibt_paranoid caller sequence adds additional caller side
> + * hash validation. This stops such circumvetion attacks dead, but at the cost
> + * of adding a load.
> + *
> + * <fineibt_paranoid_start>:
> + *  0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
> + *  6:   45 3b 53 f7             cmp    -0x9(%r11), %r10d
> + *  a:   4d 8d 5b <f0>           lea    -0x10(%r11), %r11
> + *  e:   75 fd                   jne    d <fineibt_paranoid_start+0xd>
> + * 10:   41 ff d3                call   *%r11
> + * 13:   90                      nop
> + *
> + * Notably LEA does not modify flags and can be reordered with the CMP,
> + * avoiding a dependency. Again, using a non-taken (backwards) branch
> + * for the failure case, abusing LEA's immediate 0xf0 as LOCK prefix for the
> + * JCC.d8, causing #UD.
> + */

I don't know what to say.  This is equal parts horrifying and beautiful.

> +asm(	".pushsection .rodata				\n"
> +	"fineibt_paranoid_start:			\n"
> +	"	movl	$0x12345678, %r10d		\n"
> +	"	cmpl	-9(%r11), %r10d			\n"
> +	"	lea	-0x10(%r11), %r11		\n"
> +	"	jne	fineibt_paranoid_start+0xd	\n"

Maybe `jne . - 3` ?

Or perhaps `1: jne 1b - 1` ?

Both seem marginally less fragile than tying the reference to
fineibt_paranoid_start.

~Andrew

