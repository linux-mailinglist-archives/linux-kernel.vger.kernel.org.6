Return-Path: <linux-kernel+bounces-562304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087CCA62261
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 714EC7ADE73
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C645B1F460B;
	Fri, 14 Mar 2025 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="PiRfEdAl"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4416C190676
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 23:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741996614; cv=none; b=NKXuyvMuUg7NeIS+ogpHZlD65711iglH8h9q9xUKdBXILdXFuD8+BBHRs8i+Fo22m+2TySXKVtvce56+bIPfsEHQESUbqBzTirS2mPaNgXTiPH4IaKUuV7v1aE0zd+FPL+P6NtQJ2ITP4nvviBB3wOdxkAlaGyKoXcMDCu8lLU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741996614; c=relaxed/simple;
	bh=IsBNb6NyCFgZipZv7Je1xxI6K60y7i8EQRx5iBo/QOQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=N+lxKCCrfG6pUHfX6lrt2vOOtGI3KbwiPkQ3drxaKYBTkt/EhtsHup/tUlNk0jJ/rQJYqITd0jZd0g/lDwJapULHYi0jRMc63w6B23nru1f186H2LHophd3G8ta4aE36TWqNouguIT9T+6BynLYJV0TT/nBtn4020zZho2DuOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=PiRfEdAl; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso6697284a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1741996610; x=1742601410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tDkyn4Bs+Fnz/fkKTOn+QQeYVDmhkUSDU665Subk/N0=;
        b=PiRfEdAlrB6J7547WUltf/hs/t+WRmRM1eL0XFazG1jfjJgqLczrn+690eWOjTB37d
         eBO4mTjuz9OIMxnrQ29WTQLwhiIxlZztAEEYAR+jEMnEu52WP82cc8j9KnJm6D9L8qYZ
         nTqIBfHZWskv5xHCGX7qdpDIK3cX+r3XP+xj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741996610; x=1742601410;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDkyn4Bs+Fnz/fkKTOn+QQeYVDmhkUSDU665Subk/N0=;
        b=pMqpFs8wBagVXlz17eDj6KLWhyiBugDvOkK82OQMYMMSoR51VLI3ywVF8Pst2ieJyi
         dG7EGYQzrDFTaAvPViMrw52BeoShWm3Y/8AdpvghIw3NGu9s2HfIuXlX5MWwBcP1OhZT
         YHNA/BGm3MKlVlpzp/FtzGYNTcwP4yr4a/FRlTzuvoZEZi/R53zqefI1azAmZAs9Vowd
         KUlAXkK2c5PECblyrhencjLkQfvxLhcMQ/O/AnkCrs4ZOx6V6OSxe8QKTHkAVGbObVx2
         maE6SjS3RS5bDn89wRoDdAQWQzPfYPGAxNbWHjRP4H870DB44K2Aq3IJbd4twcPAMUCj
         Dltg==
X-Gm-Message-State: AOJu0Yz6WRuryzArCNheeu7s20MSnw/r7neJGuPaof8fUpnNATXDIdkz
	WA5dt+BjvAoKHrBnFkYmxXwQ3QtODSRThK8TsD28slzRTAms2n2Hi3rUr4dKitM=
X-Gm-Gg: ASbGnctj4iMSrt4uUKCGq7zBteONJm+8J5uDNk18TApg869OvMva7JFxPjoncEU/dmy
	Pk/6/Xlciy3JLvSoYzoSBOoM8yIiIfZPi3TBn7z8arhNlfNh2VoPilIy82zeMTgDUFWQPI+riy5
	m5eOUN5Dwl+s/Syr12OUs0LFo2yZG7ubIP/1CIfDqEPIWBHJNU2AS7kP9LPOHmuYlDHfe2fh1rW
	U/s9sSQ1XUWqPPr/6bnGi5P+jB1HgPSUcHbk1So5SOz6LNB0w1lizh9j373LvEdcetdtf28hDLe
	FMUAwDRxAe6ZAWHivNiB5EQnkJMokX1rDcXeS2KZ5HA+QwhaMSmdFk8tbPHHrJnqPLOeZnffGyo
	/5Y7Q6v7W
X-Google-Smtp-Source: AGHT+IH4mbpfCK0SIzMN31CjTxQ5qB+y4ffSLhqjLjhRQc3cmniORnS5e0Rb3oGkMVCr+VUVmtreEg==
X-Received: by 2002:a05:6402:350f:b0:5e0:8a34:3b5c with SMTP id 4fb4d7f45d1cf-5e8aebe639cmr4912138a12.0.1741996610379;
        Fri, 14 Mar 2025 16:56:50 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad3909sm2502809a12.56.2025.03.14.16.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 16:56:49 -0700 (PDT)
Message-ID: <812bab88-81eb-485c-8b32-fb4a07784e12@citrix.com>
Date: Fri, 14 Mar 2025 23:56:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/20] x86/smap: Use named asm operands in
 smap_{save,restore}()
From: Andrew Cooper <andrew.cooper3@citrix.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Uros Bizjak <ubizjak@gmail.com>,
 Ingo Molnar <mingo@kernel.org>
References: <cover.1741988314.git.jpoimboe@kernel.org>
 <4631b5fb3e33af925f4bd82ecb56a5facff354cf.1741988314.git.jpoimboe@kernel.org>
 <313e0c9d-9733-4216-980a-cb473fbb5475@citrix.com>
Content-Language: en-GB
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
In-Reply-To: <313e0c9d-9733-4216-980a-cb473fbb5475@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/03/2025 10:51 pm, Andrew Cooper wrote:
> On 14/03/2025 9:41 pm, Josh Poimboeuf wrote:
>> @@ -50,9 +50,9 @@ static __always_inline unsigned long smap_save(void)
>>  static __always_inline void smap_restore(unsigned long flags)
>>  {
>>  	asm volatile ("# smap_restore\n\t"
>> -		      ALTERNATIVE("", "push %0; popf\n\t",
>> -				  X86_FEATURE_SMAP)
>> -		      : : "g" (flags) : "memory", "cc");
>> +		      ALTERNATIVE("",
>> +				  "push %[flags]; popf\n\t", X86_FEATURE_SMAP)
>> +		      : : [flags] "g" (flags) : "memory", "cc");
>>  }
>>  
>>  /* These macros can be used in asm() statements */
> The problem with ASM_CALL_CONSTRAINT and asm_call() is that it's not
> just call instructions.  It's any transient stack adjustment.
>
> Peeking forwards the other half of the series, you convert IRET to
> asm_call(), but leave these alone.
>
> These need converting, and hopefully someone can think of a better name
> than "call" to be used for the wrapper.

After chatting with Josh, the CALL aspect really is for unwinding
reasons.  This will be fine, until the need for "redzone" arrives.

That said, through both series, there are definitely places which have
ASM_CALL_CONSTRAINT and oughtn't to.

~Andrew

