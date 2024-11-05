Return-Path: <linux-kernel+bounces-397182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E749BD7C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27BBBB22098
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7FE21620C;
	Tue,  5 Nov 2024 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AHWidm6J"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA57215C6A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842862; cv=none; b=m5SxbFxfcbIweMA5lLnSA3M8yetQNTVAcdAphv1A0Ev5P1WkVHrgOYR6B1AfNLUW2dSPmiG+NkayOlij2AE2+VRmiV3qR5T9PuKS51kL56dVUShqYOF63T+USEOcO0fMOB7HjxtpAUX/YGmHtSnzhBDizeJMdNFYWyLEiQ55tqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842862; c=relaxed/simple;
	bh=YKBC8DY8B41QUwdJRBR9bp8Vu29QQwdnXrb/rsgwEnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/qYz8toKOR3AErkVrmH5n7eZaOS8OhEHCccNQQWxJDcG0Ir0Ba0gFo5ZZjRCWlFcdeYuUb+o/qATzOeVSE2yWVF78Frw7AE7WJw5SAXNPAKFCdtRX1aed12vP0aDk5WFGPjtLPdgv+ybkjvrAkV6HVKYoL8QTaHC1TrVvef7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AHWidm6J; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a6c3bdbebcso18715ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 13:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730842860; x=1731447660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hL8EITZo6I/AiPynwnm2n5FcSgJroBdOZruUGFjhJmw=;
        b=AHWidm6JI/SODv2kXxWLJgxQq8W1fh1RCvpC1aQq5kwiJ+tECGIU7+jMAfhLXiLFWc
         IdeRViWBPW8U3u4ncMf85xC0TWV/mQ7qM4wdQRLmKW2WhH2Dyl/laZBVZb4bo0ktxsm/
         kXPg2sKVxwFcaBzJ8bQhY+9FHTWNyvPY8mIi4mMePwgHZ2lYRpTT2dyJfNcz1TZdv38r
         91jh5899H41X8Mdxh9kt2K8+JpT/J0evmG+GApqZTHeRaw1qkpNj+tLrxFV4/f34k5RV
         AQkLGAxpFZXb+KsKrLFxSSnYjorzPX1YxqGvZDYBKM8GaQAYx9oCRIu5X8830smzvvjW
         Pgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730842860; x=1731447660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hL8EITZo6I/AiPynwnm2n5FcSgJroBdOZruUGFjhJmw=;
        b=c2DOx31b7pIFuykQnY6PladqlCDCHf81oAB8sLuOR0Z9AqepHZYYJ3TUJeXF0MqIaG
         HH74d/tYz2pgJnDFs2eMfpZxxJhg8Kz/aX7jqCiJFc9b+wYhVvPHJDdfYmKEt2/ZCFN7
         xVlCvmKBGKPyMw7dbxF7G4k6dp58KFz/dY00CfpvBkPvBqfwtEI8Wz4lcxKx2ffyvgkZ
         eBcR51ccwCV96lU9MEw/sNWsPBas4jbCcbwjlsetKhBXhYIjS/obxIde1/qSs4tciftn
         I11oO8sXUh6bHtx3PGXdYI8vtKQAElEc3Cy+3ZkS7qeXoRRZ4WFZRTKwf8xweC5h8O04
         vjwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW31XQqkDm5GdljHkindsY2OQJvKzndYyuc71wROUfta//7/EnonCVQwpTELqenYpePKcNVQXhzBNzTh70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPa+qMoZg+R+liqXS4md/l2fB0q7qrtkC0mBie98j8noMsBGtD
	L42Ni5xzyKiaxC0ypoOPGS4bnnE3LAUBNVga4DCeuuYecpsoU1xKDXIJONpG1A==
X-Gm-Gg: ASbGncvQaf9XTubhJQUoPkHNfYKUZ1s8ds8z9PMbz5sHP6VUFizAuG5LYhBJPmeE8lQ
	rXvXgk3M03v5SsK0CM9wdwoZDhoXjGMeheVWC2yJ7RMDqL1ab465VpIEJZSAubioJZMRZgsGLm7
	oFStdh4Kh4kuW4zCfIaZZgYMdApGsIU8xNyNxQnCeg7rTZxcZytCePtanKJw3A5yoQi0LkONDNX
	UDK/Xv7+QZMhAeZErLTFXYLP2KFN4EKfCKo/SRjDcR0slbUw96JlWM7TUktmryCMdmxe5G6lI2f
	bUeayHcWFFmjFhPwiVKVrOE=
X-Google-Smtp-Source: AGHT+IGmANzVafynGPn7y3CUjTZDSguWeG3E41SMXmTjXgMdPadVUWssKfcT4rwhnGO1iM34wKqGmg==
X-Received: by 2002:a05:6e02:180d:b0:3a4:d2ba:2011 with SMTP id e9e14a558f8ab-3a6e2087f5emr825655ab.0.1730842860289;
        Tue, 05 Nov 2024 13:41:00 -0800 (PST)
Received: from ?IPV6:2600:1700:38d4:55d0:94a2:3cbe:9578:8cdb? ([2600:1700:38d4:55d0:94a2:3cbe:9578:8cdb])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e6611c2b12sm2686780b6e.25.2024.11.05.13.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 13:40:58 -0800 (PST)
Message-ID: <12f4bd0e-07ea-4c2d-9c3c-85f0edf9c4d5@google.com>
Date: Tue, 5 Nov 2024 13:40:49 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/26] mm: asi: Make some utility functions noinstr
 compatible
To: Thomas Gleixner <tglx@linutronix.de>,
 Brendan Jackman <jackmanb@google.com>, Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Chartre <alexandre.chartre@oracle.com>,
 Jan Setje-Eilers <jan.setjeeilers@oracle.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Lorenzo Stoakes <lstoakes@gmail.com>, David Hildenbrand <david@redhat.com>,
 Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>, Paul Turner <pjt@google.com>,
 Reiji Watanabe <reijiw@google.com>, Ofir Weisse <oweisse@google.com>,
 Yosry Ahmed <yosryahmed@google.com>, Patrick Bellasi <derkling@google.com>,
 KP Singh <kpsingh@google.com>, Alexandra Sandulescu <aesa@google.com>,
 Matteo Rizzo <matteorizzo@google.com>, Jann Horn <jannh@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kvm@vger.kernel.org, linux-toolchains@vger.kernel.org
References: <20240712-asi-rfc-24-v1-0-144b319a40d8@google.com>
 <20240712-asi-rfc-24-v1-1-144b319a40d8@google.com>
 <20241025113455.GMZxuCX2Tzu8ulwN3o@fat_crate.local>
 <CA+i-1C3SZ4FEPJyvbrDfE-0nQtB_8L_H_i67dQb5yQ2t8KJF9Q@mail.gmail.com>
 <ab8ef5ef-f51c-4940-9094-28fbaa926d37@google.com> <878qu6205g.ffs@tglx>
 <d0a38982-b811-4429-8b89-81e5da3aaf72@google.com> <87cyjevgx4.ffs@tglx>
Content-Language: en-US
From: Junaid Shahid <junaids@google.com>
In-Reply-To: <87cyjevgx4.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/24 1:27 PM, Thomas Gleixner wrote:
> On Thu, Oct 31 2024 at 18:44, Junaid Shahid wrote:
>> On 10/29/24 12:12 PM, Thomas Gleixner wrote:
>>>
>>> I doubt that it works as you want it to work.
>>>
>>> +	inline notrace __attribute((__section__(".noinstr.text")))	\
>>>
>>> So this explicitely puts the inline into the .noinstr.text section,
>>> which means when it is used in .text the compiler will generate an out-of
>>> line function in the .noinstr.text section and insert a call into the
>>> usage site. That's independent of the size of the inline.
>>>
>>
>> Oh, that's interesting. IIRC I had seen regular (.text) inline functions get
>> inlined into .noinstr.text callers. I assume the difference is that here the
>> section is marked explicitly rather than being implicit?
> 
> Correct. Inlines without any section attribute are free to be inlined in
> any section, but if the compiler decides to uninline them, then it
> sticks the uninlined version into the default section ".text".
> 
> The other problem there is that an out of line version can be
> instrumented if not explicitely forbidden.
> 
> That's why we mark them __always_inline, which forces the compiler to
> inline it into the usage site unconditionally.
> 
>> In any case, I guess we could just mark these functions as plain
>> noinstr.
> 
> No. Some of them are used in hotpath '.text'. 'noinstr' prevents them to
> be actually inlined then as I explained to you before.
> 
>> (Unless there happens to be some other way to indicate to the compiler to place
>> any non-inlined copy of the function in .noinstr.text but still allow inlining
>> into .text if it makes sense optimization-wise.)
> 
> Ideally the compilers would provide
> 
>          __attribute__(force_caller_section)
> 
> which makes them place an out of line inline into the section of the
> function from which it is called. But we can't have useful things or
> they are so badly documented that I can't find them ...
> 
> What actually works by some definition of "works" is:
> 
>         static __always_inline void __foo(void) { }
> 
>         static inline void foo(void)
>         {
>                  __(foo);
>         }
> 
>         static inline noinstr void foo_noinstr(void)
>         {
>                  __(foo);
>         }
> 
> The problem is that both GCC and clang optimize foo[_noinstr]() away and
> then follow the __always_inline directive of __foo() even if I make
> __foo() insanely large and have a gazillion of different functions
> marked noinline invoking foo() or foo_noinstr(), unless I add -fno-inline
> to the command line.
> 
> Which means it's not much different from just having '__always_inline
> foo()' without the wrappers....
> 
> Compilers clearly lack a --do-what-I-mean command line option.
> 
> Now if I'm truly nasty then both compilers do what I mean even without a
> magic command line option:
> 
>         static __always_inline void __foo(void) { }
> 
>         static __maybe_unused void foo(void)
>         {
>                  __(foo);
>         }
> 
>         static __maybe_unused noinstr void foo_noinstr(void)
>         {
>                  __(foo);
>         }
> 
> If there is a single invocation of either foo() or foo_noinstr() and
> they are small enough then the compiler inlines them, unless -fno-inline
> is on the command line. If there are multiple invocations and/or foo
> gets big enough then both compilers out of line them. The out of line
> wrappers with __foo() inlined in them end always up in the correct
> section.
> 
> I actually really like the programming model as it is very clear about
> the intention of usage and it allows static checkers to validate.
> 
> Thoughts?
> 

Thank you for the details. Yes, I think the last scheme that you described with 
separate wrappers for regular and noinst usage makes sense. IIRC the existing 
static validation wouldn't catch it if someone mistakenly called the .text 
version of the function from noinstr code and it just happened to get inlined. 
Perhaps we should add the -fno-inline compiler option with 
CONFIG_NOINSTR_VALIDATION?

Thanks,
Junaid



