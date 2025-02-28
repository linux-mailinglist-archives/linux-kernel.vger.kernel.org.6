Return-Path: <linux-kernel+bounces-537558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B55A48D79
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 01:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B80188DBB2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6477D748F;
	Fri, 28 Feb 2025 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="XVXaSk3b"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87758276D0A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740703007; cv=none; b=ifbYgc+/X9JfR9Y5Fb3YRbeu9jt8oq6EMfkiaVpgd4YcIFKt1WCxj5J7w+2tGd/Ake7qzLDysbFkh1iltJOjjlIBGBUL1xvqONiX2OsBIC4IBRZPwlPBeql9zT6yYX3hxmxW4LvHCUkkAnb0VxVyHOlEnbcRlgvEw51BIQkdpJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740703007; c=relaxed/simple;
	bh=Y5va2ctqkZ5TyNd2LX4kw17tghRvNfF2zL55mD9r5qQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNy77gq36xfeHWf8VJ6rJ0uB+qTedMOGtqX7lKPi0H3zrUYE1cVXcDHuChaKGUaQXd+t2ZBEu3WFwhpgTTmACzfy0TVjXmZ+ZLzIjDrkBHlWlzRFwD5xFQZ2eB/n7q2DOy18a60tprUxiWZvFT0XKTbA/YnHCQfK7fG/f7TLRO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=XVXaSk3b; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43690d4605dso10211755e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1740703003; x=1741307803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CoekjaMb27iY+95NRrZm2ltxTJS8wwkI0dNK66PwhfM=;
        b=XVXaSk3bua7AxzqeB1qcGK0IkRjIxXwe71FXrfx1rtvPE4I3kV5nPGNPGDG/tPu996
         8QEYnm9E8/IBzhts6VZxuDm8WlgxBi8AM6ZzqPU/SNWB7mRqEHinpo6ZutEdEHNPPq8Y
         AXd920rcjy3bKthJxD6Qi2tTEbqYbbHeP+xdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740703003; x=1741307803;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoekjaMb27iY+95NRrZm2ltxTJS8wwkI0dNK66PwhfM=;
        b=rmjAwQjZnm42E4EkCOSYqpi2LNALsxeNBXl5vo2W7AliybxOIzmxqTRKEVuhh/9m+0
         sarFs33HCdYOUlWBEmuJvDeZASQ82W2T01JrdV64m7H8G44NaiKPnskAy/4vCCUUU7Dk
         hk63G6hkrCkcdaKbDJdSZa+RUkyJQjuSQxQWPwZK2mjLXQPmjD6WZGBoHRkHSGYeix+S
         xyblzvJGO6IWgK4WcX3o9RmCctlW8ePoQZr+DbgwnnsWqbukQlds448g3KDUAexWiRrr
         IBmD/HqCSRGwmeRthvxt54rmAxmBp4JKw2Z2XbAdKPGZyPiD3lGWmQ2bSFpLHL0rLCVD
         TBIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX52Vz1qKeTTfKnplMymrdJMWfWixx1IvUC71qSytmbSAu/xEm+S8CO4gSHc3uIu3zXuRNGEculP63Zi5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YynczdEguf+pwXN1ucYj8SRIrkvl0otiRuxAOJ9w7GqYCu2WwnR
	2Re4iKnrKurV6hXvMR+ub5K9q9whSFCzVZPb/2MCYW4TBkiJuWq6r1eNxUve3pI=
X-Gm-Gg: ASbGncuKf8i6ackuryv9wr77f8ugcbTbPIZ7fAGvNENdU4jItZfRx/mO0oGbeuMnczv
	BwK6Jx0mYBL7Zg7Dv6eEEd4nF6hGrEK+Zh2GsbesCSyXZ6xWx3FbcXoz26e96P6eGVYKvw16OOT
	oKBRxd4P5Pgkq+t3PR8AvzZTYdB+9L89IkY5Se3TWNEHQv2hRSCbQPS3+Q83SjtBjS+GK6JFOdg
	I5khxOlN0AJFIXmmTU1+CinkUhx/JrMPV56LFdQwBrt+YHbAdMysvxNQY0hebaG4ucapCk5bD5U
	ja1yb/aK2/NlRNfV9m74eKwLDTPnvF//xQdoTEmEF3gINRcdypj1L/qR8t2glCp2Kw==
X-Google-Smtp-Source: AGHT+IGgeYQ181c/BYtpl9XgQBVgTFsdW/wTJ59of2JikxdLLsKxJfP3Aach616mx33ZzmYvJjHiYA==
X-Received: by 2002:a05:6000:2a4:b0:38f:2990:c074 with SMTP id ffacd0b85a97d-390ec7cfe62mr1291921f8f.16.1740703002767;
        Thu, 27 Feb 2025 16:36:42 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47965e8sm3445879f8f.1.2025.02.27.16.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 16:36:41 -0800 (PST)
Message-ID: <bf053035-6ead-4f3f-b53e-d265824199c3@citrix.com>
Date: Fri, 28 Feb 2025 00:36:40 +0000
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
 <15253834-fb89-408f-8269-65413ad29f7a@citrix.com>
 <20250227231342.jh67quujcd3tgmft@desk> <20250228003117.q6f2f5a7ndt2o226@desk>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 xsFNBFLhNn8BEADVhE+Hb8i0GV6mihnnr/uiQQdPF8kUoFzCOPXkf7jQ5sLYeJa0cQi6Penp
 VtiFYznTairnVsN5J+ujSTIb+OlMSJUWV4opS7WVNnxHbFTPYZVQ3erv7NKc2iVizCRZ2Kxn
 srM1oPXWRic8BIAdYOKOloF2300SL/bIpeD+x7h3w9B/qez7nOin5NzkxgFoaUeIal12pXSR
 Q354FKFoy6Vh96gc4VRqte3jw8mPuJQpfws+Pb+swvSf/i1q1+1I4jsRQQh2m6OTADHIqg2E
 ofTYAEh7R5HfPx0EXoEDMdRjOeKn8+vvkAwhviWXTHlG3R1QkbE5M/oywnZ83udJmi+lxjJ5
 YhQ5IzomvJ16H0Bq+TLyVLO/VRksp1VR9HxCzItLNCS8PdpYYz5TC204ViycobYU65WMpzWe
 LFAGn8jSS25XIpqv0Y9k87dLbctKKA14Ifw2kq5OIVu2FuX+3i446JOa2vpCI9GcjCzi3oHV
 e00bzYiHMIl0FICrNJU0Kjho8pdo0m2uxkn6SYEpogAy9pnatUlO+erL4LqFUO7GXSdBRbw5
 gNt25XTLdSFuZtMxkY3tq8MFss5QnjhehCVPEpE6y9ZjI4XB8ad1G4oBHVGK5LMsvg22PfMJ
 ISWFSHoF/B5+lHkCKWkFxZ0gZn33ju5n6/FOdEx4B8cMJt+cWwARAQABzSlBbmRyZXcgQ29v
 cGVyIDxhbmRyZXcuY29vcGVyM0BjaXRyaXguY29tPsLBegQTAQgAJAIbAwULCQgHAwUVCgkI
 CwUWAgMBAAIeAQIXgAUCWKD95wIZAQAKCRBlw/kGpdefoHbdD/9AIoR3k6fKl+RFiFpyAhvO
 59ttDFI7nIAnlYngev2XUR3acFElJATHSDO0ju+hqWqAb8kVijXLops0gOfqt3VPZq9cuHlh
 IMDquatGLzAadfFx2eQYIYT+FYuMoPZy/aTUazmJIDVxP7L383grjIkn+7tAv+qeDfE+txL4
 SAm1UHNvmdfgL2/lcmL3xRh7sub3nJilM93RWX1Pe5LBSDXO45uzCGEdst6uSlzYR/MEr+5Z
 JQQ32JV64zwvf/aKaagSQSQMYNX9JFgfZ3TKWC1KJQbX5ssoX/5hNLqxMcZV3TN7kU8I3kjK
 mPec9+1nECOjjJSO/h4P0sBZyIUGfguwzhEeGf4sMCuSEM4xjCnwiBwftR17sr0spYcOpqET
 ZGcAmyYcNjy6CYadNCnfR40vhhWuCfNCBzWnUW0lFoo12wb0YnzoOLjvfD6OL3JjIUJNOmJy
 RCsJ5IA/Iz33RhSVRmROu+TztwuThClw63g7+hoyewv7BemKyuU6FTVhjjW+XUWmS/FzknSi
 dAG+insr0746cTPpSkGl3KAXeWDGJzve7/SBBfyznWCMGaf8E2P1oOdIZRxHgWj0zNr1+ooF
 /PzgLPiCI4OMUttTlEKChgbUTQ+5o0P080JojqfXwbPAyumbaYcQNiH1/xYbJdOFSiBv9rpt
 TQTBLzDKXok86M7BTQRS4TZ/ARAAkgqudHsp+hd82UVkvgnlqZjzz2vyrYfz7bkPtXaGb9H4
 Rfo7mQsEQavEBdWWjbga6eMnDqtu+FC+qeTGYebToxEyp2lKDSoAsvt8w82tIlP/EbmRbDVn
 7bhjBlfRcFjVYw8uVDPptT0TV47vpoCVkTwcyb6OltJrvg/QzV9f07DJswuda1JH3/qvYu0p
 vjPnYvCq4NsqY2XSdAJ02HrdYPFtNyPEntu1n1KK+gJrstjtw7KsZ4ygXYrsm/oCBiVW/OgU
 g/XIlGErkrxe4vQvJyVwg6YH653YTX5hLLUEL1NS4TCo47RP+wi6y+TnuAL36UtK/uFyEuPy
 wwrDVcC4cIFhYSfsO0BumEI65yu7a8aHbGfq2lW251UcoU48Z27ZUUZd2Dr6O/n8poQHbaTd
 6bJJSjzGGHZVbRP9UQ3lkmkmc0+XCHmj5WhwNNYjgbbmML7y0fsJT5RgvefAIFfHBg7fTY/i
 kBEimoUsTEQz+N4hbKwo1hULfVxDJStE4sbPhjbsPCrlXf6W9CxSyQ0qmZ2bXsLQYRj2xqd1
 bpA+1o1j2N4/au1R/uSiUFjewJdT/LX1EklKDcQwpk06Af/N7VZtSfEJeRV04unbsKVXWZAk
 uAJyDDKN99ziC0Wz5kcPyVD1HNf8bgaqGDzrv3TfYjwqayRFcMf7xJaL9xXedMcAEQEAAcLB
 XwQYAQgACQUCUuE2fwIbDAAKCRBlw/kGpdefoG4XEACD1Qf/er8EA7g23HMxYWd3FXHThrVQ
 HgiGdk5Yh632vjOm9L4sd/GCEACVQKjsu98e8o3ysitFlznEns5EAAXEbITrgKWXDDUWGYxd
 pnjj2u+GkVdsOAGk0kxczX6s+VRBhpbBI2PWnOsRJgU2n10PZ3mZD4Xu9kU2IXYmuW+e5KCA
 vTArRUdCrAtIa1k01sPipPPw6dfxx2e5asy21YOytzxuWFfJTGnVxZZSCyLUO83sh6OZhJkk
 b9rxL9wPmpN/t2IPaEKoAc0FTQZS36wAMOXkBh24PQ9gaLJvfPKpNzGD8XWR5HHF0NLIJhgg
 4ZlEXQ2fVp3XrtocHqhu4UZR4koCijgB8sB7Tb0GCpwK+C4UePdFLfhKyRdSXuvY3AHJd4CP
 4JzW0Bzq/WXY3XMOzUTYApGQpnUpdOmuQSfpV9MQO+/jo7r6yPbxT7CwRS5dcQPzUiuHLK9i
 nvjREdh84qycnx0/6dDroYhp0DFv4udxuAvt1h4wGwTPRQZerSm4xaYegEFusyhbZrI0U9tJ
 B8WrhBLXDiYlyJT6zOV2yZFuW47VrLsjYnHwn27hmxTC/7tvG3euCklmkn9Sl9IAKFu29RSo
 d5bD8kMSCYsTqtTfT6W4A3qHGvIDta3ptLYpIAOD2sY3GYq2nf3Bbzx81wZK14JdDDHUX2Rs
 6+ahAA==
In-Reply-To: <20250228003117.q6f2f5a7ndt2o226@desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/02/2025 12:31 am, Pawan Gupta wrote:
> On Thu, Feb 27, 2025 at 03:13:48PM -0800, Pawan Gupta wrote:
>> On Thu, Feb 27, 2025 at 06:57:37PM +0000, Andrew Cooper wrote:
>>> On 27/02/2025 6:41 pm, Pawan Gupta wrote:
>>>> On Thu, Feb 27, 2025 at 12:49:48AM +0000, Andrew Cooper wrote:
>>>>> On 26/02/2025 9:03 pm, Pawan Gupta wrote:
>>>>>> @@ -420,20 +420,28 @@ static inline void call_depth_return_thunk(void) {}
>>>>>>  
>>>>>>  #ifdef CONFIG_X86_64
>>>>>>  
>>>>>> +/*
>>>>>> + * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
>>>>>> + * to the retpoline thunk with a CS prefix when the register requires
>>>>>> + * a REX prefix byte to encode. Also see apply_retpolines().
>>>>>> + */
>>>>> Technically, both comments aren't quite accurate.  __CS_PREFIX() emits a
>>>>> conditional CS prefix in a manner compatible with
>>>>> -mindirect-branch-cs-prefix, not the full 5/6 byte jmp/call.
>>>> You are right, I will update the comment, and also the ASSEMBLY version
>>>> where this comment came from:
>>>>
>>>>   /*
>>>>    * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
>>>>    * to the retpoline thunk with a CS prefix when the register requires
>>>>    * a REX prefix byte to encode. Also see apply_retpolines().
>>>>    */
>>>>   .macro __CS_PREFIX reg:req
>>>>           .irp rs,r8,r9,r10,r11,r12,r13,r14,r15
>>>>           .ifc \reg,\rs
>>>>           .byte 0x2e
>>>>           .endif
>>>>           .endr
>>>>   .endm
>>>>
>>>>>> +#define __CS_PREFIX(reg)				\
>>>>>> +	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15;		\
>>>>>> +	.ifc \\rs, \reg;				\
>>>>> Why are these escaped differently?  Given they're all \r of some form or
>>>>> another, I guess something is going wonky with __stringify(), but its
>>>>> still weird for them to be different.
>>>>>
>>>>> Do you have a fully pre-processed source to hand to see how CALL_NOSPEC
>>>>> ends up?
>>>> Below is the pre-processed source for test_cc() generated with "make arch/x86/kvm/emulate.i".
>>>>
>>>> - This is with double backslash in ".ifc \\rs, \reg":
>>>>
>>>> 	asm("push %[flags]; popf; " ".irp rs,r8,r9,r10,r11,r12,r13,r14,r15; .ifc \\rs, \%V[thunk_target]; .byte 0x2e; .endif; .endr;" "call __x86_indirect_thunk_%V[thunk_target]\n"
>>>>                                                                                   ^
>>>> 	This ends up emitting the CS prefix byte correctly:
>>>>
>>>> 	2e e8 51 c9 32 01       cs call ffffffff824289e0
>>>>
>>>> - This is with single backslash in ".ifc \\rs, \reg":
>>>>
>>>> 	asm("push %[flags]; popf; " ".irp rs,r8,r9,r10,r11,r12,r13,r14,r15; .ifc \rs, \%V[thunk_target]; .byte 0x2e; .endif; .endr;" "c      all __x86_indirect_thunk_%V[thunk_target]\n"
>>>>                                                                                   ^
>>>> 	This version does not emit the CS prefix byte:
>>>>
>>>> 	e8 52 c9 32 01          call   ffffffff824289e0
>>>>
>>>> I tried looking in gcc inline assembly documentation but could not find
>>>> anything that would explain this. :(
>>> It's because it's about plain C strings.
>>>
>>> \r (from \rs) is Carriage Return (ASCII 0x0d).
>> Ah, right.
>>
>>> After AS's macro expansion, \reg becomes \% which is not a valid escape
>>> character, so the \ gets left intact.
>>>
>>> \reg should become \\reg or you'll probably get a compiler complaining
>>> eventually.
>> Using \\ for reg like this:
>>
>>  .ifc \\rs, \\reg
>>
>> is not emitting the CS prefix. I am trying to wrap my head around the
>> magic.
> Getting rid of one layer of macro makes it less magical:
>
> #define __CS_PREFIX(reg)				\
>             ".irp rs,r8,r9,r10,r11,r12,r13,r14,r15\n"	\
>             ".ifc \\rs," reg "\n"                       \
>             ".byte 0x2e\n"                              \
>             ".endif\n"                                  \
>             ".endr\n"
>
> #define CALL_NOSPEC    __CS_PREFIX("%V[thunk_target]")  \
>                         "call __x86_indirect_thunk_%V[thunk_target]\n"
> #else
> #define CALL_NOSPEC    "call *%[thunk_target]\n"
> #endif
>
> Preprocessor output is as expected, and this emits the CS prefix correctly:
>
> 	".ifc \\rs, %V[thunk_target]"
>
> Full version:
>
> 	asm("push %[flags]; popf; " ".irp rs,r8,r9,r10,r11,r12,r13,r14,r15\n" ".ifc \\rs," "%V[thunk_target]" "\n" ".byte 0x2e\n" ".endif\n" ".endr\n" "call __x86_indirect_thunk_%V[thunk_target]\n"
> 	: "=a"(rc), "+r" (current_stack_pointer) : [thunk_target]"r"(fop), [flags]"r"(flags));

Yeah, I think that's a lot better.

I still cant spot precisely what's wrong with the prior \\reg.

~Andrew

