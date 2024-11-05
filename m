Return-Path: <linux-kernel+bounces-396664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75229BD040
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7583F2835A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860311D27B1;
	Tue,  5 Nov 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="OhlMF6/O"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0161C3BB21
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819968; cv=none; b=ZreeQ26AzTaPweR1Js854fwEu11LvEZSa+gXkMmnXBUnVUNEqtx44K3piA+1jdAmhIIO8tXS69SsDkyg8KJWFqCsfWSx3v3/1I8QxXEu6mkxlZpqf/sfK0NflT5W1ziwzCYFm+KKg/n2CyEChodcXVUR0cOKykBciDYgC/voSqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819968; c=relaxed/simple;
	bh=b2oiIwfG8NP0Yfzt1TlTAIYmJEoTNS8ZQpQCPPVGu4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfQtaNm+06q7LHivW4W20geQDegQ1ZQ1A0w6nQrj4LP+LoeB6OPqt/R85Of3Bc2N+NWDCr5H4jcEmEBVY2CtEncJHJvXfE3+7OrVbVlt4sjRZLGWy6M9QsUD8qkGQH1qvfQOruo3mOPo7OkJWhaH9L5Nfr3Go6hGPMu1Tk1Z45k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=OhlMF6/O; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cb615671acso3323518a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1730819965; x=1731424765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SIxEK75x/go35G1NjXNPJ93+dyIRrfy/YekIQ/KzVl8=;
        b=OhlMF6/OgXgrPlMe0w9ZHiqXr7F+ChjkzUBd2mnjWP5Og7vxR869XmU5O6/PO8sHNX
         WjMCDI5pccOkv693k8ZpTYdqMG+kGcOvm59puEiLL+uuIWb5S/RHaZ+VT7zFNcHzZNcA
         4ClXqYOc2iIy4f3BPNnRQT0esrSab6AEPIbpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730819965; x=1731424765;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIxEK75x/go35G1NjXNPJ93+dyIRrfy/YekIQ/KzVl8=;
        b=Wg3QkneaXTlCoIJXxkYgKmhV095w1A+U1kkrY6eWhdDcDsDRwCvHck99RswoFDRE4Q
         p037dt4Zy3pkpC+ebsx3qbidk6mcbVJqMzU8nd9LomTNjJdXtC1p8iukJ4B2pybTfgss
         /17fVFAUXmcyvm+EZl5iiNRHTxZg+4XCiWVwvuKVVoepRTtrRv7Y9XAbPC4LXETeNT51
         D8INrw3jTh/rxBwH/0qa/1H33yA79gm+x9VgmZ9H3qkkHL3n4WuoGwOlCX2cxxRz0ulE
         H4SWgNdhFoRIgNw6AQEyJfz31uEy/t4g2S1LiPstPObS2lZYMiarGeLqVlw8hyPsGoxY
         MZBQ==
X-Gm-Message-State: AOJu0YyFN1lGnO9qGyti2VBxSNPN3B8oxTLt1wLWYM9nvMGUE57PVaP7
	+20oD6OC7fwxVbtCnZKnVY0rgcBqxuP3JbiJOQZ6XhPts/zIg68GdH6P1LNb0xU=
X-Google-Smtp-Source: AGHT+IEcF2TIoWYjfUVPIUikHiw7tct5aNYFMeMK0t16cmEB1Pa1/c2tAh5ftTAF/YJTrH50uwHs4A==
X-Received: by 2002:a05:6402:d0b:b0:5ce:b733:2ac7 with SMTP id 4fb4d7f45d1cf-5ceb937e6dfmr14893489a12.29.1730819965236;
        Tue, 05 Nov 2024 07:19:25 -0800 (PST)
Received: from [10.125.226.166] ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6b0fc4dsm1427225a12.84.2024.11.05.07.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 07:19:24 -0800 (PST)
Message-ID: <ea88e0d2-2ada-40e6-9bca-06a598dba70d@citrix.com>
Date: Tue, 5 Nov 2024 15:19:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] x86/traps: Cleanup and robustify decode_bug()
To: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
 scott.d.constable@intel.com, joao@overdrivepizza.com, jpoimboe@kernel.org,
 alexei.starovoitov@gmail.com, ebiggers@kernel.org, samitolvanen@google.com,
 kees@kernel.org
References: <20241105113901.348320374@infradead.org>
 <20241105114522.285032152@infradead.org>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20241105114522.285032152@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/11/2024 11:39 am, Peter Zijlstra wrote:
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -110,24 +117,37 @@ __always_inline int decode_bug(unsigned
>  		return BUG_NONE;
>  
>  	v = *(u8 *)(addr++);
> -	if (v == SECOND_BYTE_OPCODE_UD2)
> +	if (v == SECOND_BYTE_OPCODE_UD2) {
> +		*len = addr - start;
>  		return BUG_UD2;
> +	}
>  
> -	if (!IS_ENABLED(CONFIG_UBSAN_TRAP) || v != SECOND_BYTE_OPCODE_UD1)
> +	if (v != SECOND_BYTE_OPCODE_UD1)
>  		return BUG_NONE;
>  
> -	/* Retrieve the immediate (type value) for the UBSAN UD1 */
> -	v = *(u8 *)(addr++);
> -	if (X86_MODRM_RM(v) == 4)
> -		addr++;
> -
>  	*imm = 0;
> -	if (X86_MODRM_MOD(v) == 1)
> -		*imm = *(u8 *)addr;
> -	else if (X86_MODRM_MOD(v) == 2)
> -		*imm = *(u32 *)addr;
> -	else
> -		WARN_ONCE(1, "Unexpected MODRM_MOD: %u\n", X86_MODRM_MOD(v));
> +	v = *(u8 *)(addr++);		/* ModRM */
> +
> +	/* Decode immediate, if present */
> +	if (X86_MODRM_MOD(v) != 3) {
> +		if (X86_MODRM_RM(v) == 4)
> +			addr++;		/* Skip SIB byte */
> +
> +		if (X86_MODRM_MOD(v) == 1) {
> +			*imm = *(s8 *)addr;
> +			addr += 1;
> +
> +		} else if (X86_MODRM_MOD(v) == 2) {
> +			*imm = *(s32 *)addr;
> +			addr += 4;
> +		}
> +	}
> +
> +	/* record instruction length */
> +	*len = addr - start;

`ud1 0(%rip),%eax` has something to say about this length calculation[1].

You need the Mod = 0, RM = 5 case wired into addr += 4 without filling
in imm.

~Andrew

[1] or maybe you've got something rude to say about those of us who
encode instructions like that...[2]
[2] It's perhaps fortunate that decode_bug() doesn't know what a REX
prefix is.

