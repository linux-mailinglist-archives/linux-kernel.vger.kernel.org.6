Return-Path: <linux-kernel+bounces-400901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA5F9C13D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44C3AB22661
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2191423AD;
	Fri,  8 Nov 2024 02:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="qWJ3RvGV"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7069B17996
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 02:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731031378; cv=none; b=Zf/+bB8vuKvKdXoYz4tFLi2jqf/Y27beCvR1eRV8KXBYSBKlNVtFDamns1fM0Q7/42WlGouT+lJ4GyiVJA/VJnr5gX/ED5VI0iAQri1ApM3hB59mVjMeQvbUHhYaj12/7VsTaDZK1M4PVpkzjkNAhk4utWMElfCb8Vg4p0IcmPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731031378; c=relaxed/simple;
	bh=Eu9qaoP1vVbZCW0QLK30pMCCe+ourbAvovaN0GtitHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1b56MKfkn5lvAPErw4dJvFHQ5XF/CrM8PTQsiXbUiTk+i6Hck4YK3JIs5p+MCp6DfbH6WebCgNzbkDC1Fu92aTXHHfVNFWP6jprTimcPjtRgTCKZ9Gvq3FKVCKHghthcPopu6t0dwdjWjFCeku9gUTzDJU9UDlGquYzm8GLAnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=qWJ3RvGV; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso2044306a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 18:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1731031375; x=1731636175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xjSyc72oUSep1NF0Sw69Z8iUa12VF/EFvvfEAKvZJTI=;
        b=qWJ3RvGVGr5hEV2WIH4bAQDfUNHiVrPlyS4J63h8zUDrzr7AGxC1GL/QNF3k1tLgNj
         7e+7Q2LJM4kq9dWjwW66XG7n8QnqanbkVJBgrjCbTik+oQ+zYvIHFzHEdKmWjI5iH44Z
         BkOciaZGxdwDhywq2/KQwjCknJe3qQVUNxALQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731031375; x=1731636175;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjSyc72oUSep1NF0Sw69Z8iUa12VF/EFvvfEAKvZJTI=;
        b=pO4ZJsdJwQDcd4eRn87Yrx4axL7IjPU4yWsrfliab0XVoWKPtQkirOPv3SIvW963bK
         JImIpdnxyiqlLc087DNejFsyu9+9ZsByL1oBnvcVQzlkI7X0G/iJkvZwHIXCg3AiNby0
         4xkoxqkiJvQZfCsck8nknP7zN1+9iE5Psb5xT5STYrLJpsQWqWyKbdDXyTU+o3DtfWBw
         x0cYLvEW4pUPrzCleAxp+rSo3AJSrIvM/16SKSZ1DExoBcWlFKWL39qTBq8xJJgX/5wG
         RADpRBJ4ay3/uJmkOhMR3l2ayydTzSO2zwliS/wlRoB9/lSqwCcoGFpB6LpErCAIWh4G
         WMxw==
X-Forwarded-Encrypted: i=1; AJvYcCWnaOR7xSqvpkmVxcmzz6CodfLoKU027eCQvXHhA86FagwLz/KzH5nr/gPpx6T6bShjO+P6x1UvRT182rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGZBbz4n2TLfQ0FkcSVo5NDMKU9bHxYYpNovfTANLnTMQPbtKt
	8RM63UItOlWbSFLvAjUOhLl1I5rznHlXOwlcDHluhHhhda0VmiOgONdbtf6D+e8=
X-Google-Smtp-Source: AGHT+IH7uXnu8kbqZL8axb4KQ36L0+w03TzGoQXIcQymKfCp6pF5OU5E8cKcpKJT6Q2gCznMarxDBw==
X-Received: by 2002:a05:6402:34cf:b0:5ce:d4ff:606 with SMTP id 4fb4d7f45d1cf-5cf0a471a69mr602911a12.34.1731031374703;
        Thu, 07 Nov 2024 18:02:54 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b7e91esm1428486a12.25.2024.11.07.18.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 18:02:54 -0800 (PST)
Message-ID: <9feaddd6-f013-468a-b0eb-2dd2896fb88f@citrix.com>
Date: Fri, 8 Nov 2024 02:02:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] x86/fred: Clear WFE in missing-ENDBRANCH #CPs
To: Dave Hansen <dave.hansen@intel.com>, "Xin Li (Intel)" <xin@zytor.com>,
 linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org
References: <20240916181000.416513-1-xin@zytor.com>
 <05745387-d391-4709-8bd8-6d82650e052f@intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <05745387-d391-4709-8bd8-6d82650e052f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/11/2024 8:51 pm, Dave Hansen wrote:
> On 9/16/24 11:10, Xin Li (Intel) wrote:
>> The WFE, i.e., WAIT_FOR_ENDBRANCH, bit in the augmented CS of FRED
>> stack frame is set to 1 in missing-ENDBRANCH #CP exceptions.
>>
>> The CPU will generate another missing-ENDBRANCH #CP if the WFE bit
>> is left set, because the CPU IBT will be set in the WFE state upon
>> completion of the following ERETS instruction and then the CPU will
>> resume from the instruction that just caused the previous #CP.
>>
>> Clear WFE to avoid dead looping in missing-ENDBRANCH #CPs.
>>
>> Describe the IBT story in the comment of ibt_clear_fred_wfe() using
>> Andrew Cooper's write-up.
> I should have responded to this earlier.  I do see why Andrew thought my
> earlier description was off base.  Let me see if I can try for a better
> changelog:
>
> The kernel can enable Indirect Branch Tracking (IBT) for itself.
> Hardware generates a #CP exception if a kernel indirect branch lands
> somewhere other than an ENDBR instruction.  The kernel #CP handler then
> decides if the it should warn or do a fatal BUG().

Perhaps "an appropriate ENDBR"?

You also get #CP[endbr] for encountering the wrong ENDBR{32,64} instruction.

> The BUG() case works fine with or without FRED.  But the warning mode is
> broken with FRED.
>
> In short, the pre-FRED architecture clobbers the kernel IBT state of an
> interrupted context.  That includes clobbering the state of IBT when the
> #CP went off, suppressing future #CP's.  This is bad architecture, but
> handy for a #CP handler that wants to suppress those future #CP's.

There isn't really a warning mode, so much as a singleton selftest to
check that #CP gets generated.



>
> FRED, on the other hand, provides space on the entry stack (in an
> expanded CS area) to save and restore IBT state. Since the hardware
> doesn't clobber the IBT state, software must do it instead.
>
> Aside:
> 	Why does without-FRED case work? There is only one CET WFE bit
> 	per privilege level.  The #CP handler itself has an ENDBR
> 	instruction.  That ENDBR clears WFE on the way to handling the
> 	#CP. Consider what would happen if a kernel indirect call landed
> 	on an XOR instead of an ENDBR:
>
> 	  CALL (*%rax)  // sets WFE
> 	  XOR %rax,%rax // uh oh, not an ENDBR
> 	  #CP
> 	  ENDBR	// first instruction in CP handler, clears WFE
> 	  ... handle #CP here
> 	  IRET
> 	  XOR %rax,%rax // No problem, WFE still clear!
>
> 	See? The handler clears WFE and lets the XOR run.
>
> Is that a more complete (and accurate) story for folks?

More complete, yes.

"The #CP handler itself has an ENDBR instruction." is a consequence, not
a cause.

CALL *ind does indeed set WFE, and WFE stays asserted across the
instruction boundary, but behaves somewhat like the Resume Flag (falls
to zero everywhere else).  It's not "ENDBR clears WFE" because there's
the suppress state too generated by the NOTRK prefix, which causes WFE
to fall to 0 on all instructions.

When decode finds an instruction, and WFE is set, and the instruction is
not the right ENDBR, it raises a #CP fault.

IDT event delivery sets WFE=1 because it delivered an event, because the
spec says so.

If the old context was CPL3, then the interrupted context's WFE is
stashed away in MSR_U_CET.  But, if the old context was CPL<3, the WFE=1
both clobbers the interrupted context, and requires there to be an ENDBR
in the handler.

On the way out, the problem is that IRET doesn't set WFE=? in the
returned-to context.

What FRED does is stash the interrupted context's WFE on the stack, and
ERET{S,U} restores it on the way out.

Is this any clearer?

~Andrew

P.S. for bonus points, consider what happens if a regular interrupt
occurs between CALL *(%rax) and XOR.  If you can generate precise
interrupts, you can escape CET-IBT protections indefinitely.

