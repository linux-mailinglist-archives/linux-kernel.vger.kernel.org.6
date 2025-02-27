Return-Path: <linux-kernel+bounces-537138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB18BA48861
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689243B8F70
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE14E26E653;
	Thu, 27 Feb 2025 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="PtjhLhrO"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3AD26E152
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682663; cv=none; b=HfOAxJF8F4tlla4NxBnTX6k3jE795jb4HdA0T/QhGwM+VwddDwdmrQHzhPX9usmNIWwh0vR2eokpTb6w5s+apBZanzIWIqtfII32vnDzaBK9YjttJFGzvFPMmi9HJvGyEWSTmKUjIj0ZIFO70pkhrveyGF6MaEqiiUW4ffaLEN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682663; c=relaxed/simple;
	bh=aqlUYqQFO0WiVM+HE9BfnxX9AV+PYDtS/WqY3R6HL4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bhz8CRodRoPrbMwh0HLVsKxd2o0huOvB5sxosLnc1NOvti+vedWf0pICOtWP09Lg+aA7bGBs6OwmPfrbtuETbZn3t2f3+lv04nnbrYx8kFmL/IwEX0Fg4C59DcavMbxYh3BaleoEZR14UCCZwJk1vqUXmpGLk/4WaeaRhff5TtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=PtjhLhrO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so9647355e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1740682659; x=1741287459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GdS04PpKeU7zg1t4iBTxl5qGH5rRifO/DD2Xb6F4WkI=;
        b=PtjhLhrOZFNVLPI5P+vnNP69wOCGdfVQ1wDmTeplJU3Ni7ZtjtZWqzhlsUlky0gXLH
         OqcRdQXSvW5WWx5FGfQjHzI6sq2XP3AcgFYTIdPK8PT6tgHMCuH7GDFMR+StjbbnwLay
         cZ0QoqX8iqc73D+CQwMFF82Otan+/3RmkQaec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740682659; x=1741287459;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdS04PpKeU7zg1t4iBTxl5qGH5rRifO/DD2Xb6F4WkI=;
        b=H4cjqM0vKG3UNgTvBngE1JKbyf2IIT4miyX0KFXxVZaS30EZGv+CgsP6pm79Sq1gaZ
         nUSNEM/jHMQAPzk0hOfHKZ3ZQKTMDnISJ4TYboU2Du3SyoEIqKi2SBApt7k/QtHCwJQl
         7HLXJ4eH9So9gxGnO4BT7WGpBIwd+keKBx1Dfj/lylbQcAM+bExnGFTULkZ97s9seYTd
         xAFN8rXxfz1XTxknVermyX1m3ktlBllAxshZWqp8SfZt/FalOeUN1rVarVPud0YIlyMD
         VSn6KzaWNF3rqqBHkiS2tECnl0PhW+A1/DP4n2Un9yvVWG1ppb86qawICxoxbF35d+Cg
         hMsw==
X-Forwarded-Encrypted: i=1; AJvYcCViOzJtGafbiE4kq7Wd8z0GiZAN4xT3Fg1pDoIyYmtD9J987tRd+wvQ00jQLwmLF0p0Eyv0pbNxEWLqHO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYkvIz80Qorn1LE9CyDDbxgFnW6q7+1rA/zcdv185SONhevG28
	1UZBM2xSOJWXLAEL0EoM+1XC6LFacJRz6VRMe19DO83lTHrsVh8uYChaBOiU6N91ygdmJqZDdQw
	A
X-Gm-Gg: ASbGncuPMiL8TJImjqG3vvHCWVQAJtddg48cAAVVLAOnnGb6l51aZm9lotJQR4mC/bt
	6XdaLZuac73UMy22z4Ylvx25VE6/lD/E4wOKebYZkcYj1FilzysJ3eeXYAikvwOkHWO93JFvCU6
	eEG9QZLpFk3oTUNcQ4xdcsRRUNy9020SMYCFH+IoFs9sSzNU76HZH1wahmV94gJHmLigM2MK4dz
	0PCE6KSXuiPuPpGHqh8NkzWm0fDw86JzimsmRsiD2PXuQz8uZPWIdtbFC+uZR0NT5+Vl9/t2SZx
	norMSRFdeHdWUhBeTQtdCNjdrWVmUdaEz2LC7KYvIwFccax5YU/u62/an+cK6ZQijQ==
X-Google-Smtp-Source: AGHT+IFojfssGhwDq8JmP73bUocxfgQKUG/b5kGk48FXHSDhUgTYsUlnXpixmg7n1vLb87lthp6jWQ==
X-Received: by 2002:a5d:59a5:0:b0:38f:4f07:fabf with SMTP id ffacd0b85a97d-390eca26c17mr236298f8f.53.1740682659265;
        Thu, 27 Feb 2025 10:57:39 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba532ba6sm63487185e9.12.2025.02.27.10.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 10:57:38 -0800 (PST)
Message-ID: <15253834-fb89-408f-8269-65413ad29f7a@citrix.com>
Date: Thu, 27 Feb 2025 18:57:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/speculation: Simplify and make CALL_NOSPEC consistent
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250226-call-nospec-v1-1-4dde04a5c7a7@linux.intel.com>
 <497a3694-cb0d-4678-9622-d9443bf8a40d@citrix.com>
 <20250227184133.lxm43awa2jgdpl4q@desk>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250227184133.lxm43awa2jgdpl4q@desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/02/2025 6:41 pm, Pawan Gupta wrote:
> On Thu, Feb 27, 2025 at 12:49:48AM +0000, Andrew Cooper wrote:
>> On 26/02/2025 9:03 pm, Pawan Gupta wrote:
>>> @@ -420,20 +420,28 @@ static inline void call_depth_return_thunk(void) {}
>>>  
>>>  #ifdef CONFIG_X86_64
>>>  
>>> +/*
>>> + * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
>>> + * to the retpoline thunk with a CS prefix when the register requires
>>> + * a REX prefix byte to encode. Also see apply_retpolines().
>>> + */
>> Technically, both comments aren't quite accurate.  __CS_PREFIX() emits a
>> conditional CS prefix in a manner compatible with
>> -mindirect-branch-cs-prefix, not the full 5/6 byte jmp/call.
> You are right, I will update the comment, and also the ASSEMBLY version
> where this comment came from:
>
>   /*
>    * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
>    * to the retpoline thunk with a CS prefix when the register requires
>    * a REX prefix byte to encode. Also see apply_retpolines().
>    */
>   .macro __CS_PREFIX reg:req
>           .irp rs,r8,r9,r10,r11,r12,r13,r14,r15
>           .ifc \reg,\rs
>           .byte 0x2e
>           .endif
>           .endr
>   .endm
>
>>> +#define __CS_PREFIX(reg)				\
>>> +	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15;		\
>>> +	.ifc \\rs, \reg;				\
>> Why are these escaped differently?  Given they're all \r of some form or
>> another, I guess something is going wonky with __stringify(), but its
>> still weird for them to be different.
>>
>> Do you have a fully pre-processed source to hand to see how CALL_NOSPEC
>> ends up?
> Below is the pre-processed source for test_cc() generated with "make arch/x86/kvm/emulate.i".
>
> - This is with double backslash in ".ifc \\rs, \reg":
>
> 	asm("push %[flags]; popf; " ".irp rs,r8,r9,r10,r11,r12,r13,r14,r15; .ifc \\rs, \%V[thunk_target]; .byte 0x2e; .endif; .endr;" "call __x86_indirect_thunk_%V[thunk_target]\n"
>                                                                                   ^
> 	This ends up emitting the CS prefix byte correctly:
>
> 	2e e8 51 c9 32 01       cs call ffffffff824289e0
>
> - This is with single backslash in ".ifc \\rs, \reg":
>
> 	asm("push %[flags]; popf; " ".irp rs,r8,r9,r10,r11,r12,r13,r14,r15; .ifc \rs, \%V[thunk_target]; .byte 0x2e; .endif; .endr;" "c      all __x86_indirect_thunk_%V[thunk_target]\n"
>                                                                                   ^
> 	This version does not emit the CS prefix byte:
>
> 	e8 52 c9 32 01          call   ffffffff824289e0
>
> I tried looking in gcc inline assembly documentation but could not find
> anything that would explain this. :(

It's because it's about plain C strings.

\r (from \rs) is Carriage Return (ASCII 0x0d).

After AS's macro expansion, \reg becomes \% which is not a valid escape
character, so the \ gets left intact.

\reg should become \\reg or you'll probably get a compiler complaining
eventually.

~Andrew

