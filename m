Return-Path: <linux-kernel+bounces-565233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1BDA66436
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A237189510D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF6A7E105;
	Tue, 18 Mar 2025 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yyrlscdI"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA463209
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259023; cv=none; b=d8UOVyYgT9M1jKSscFlX4hfcoZxFwuvqD51wTkRk9B1CKqnodhkx12KEE8ma7z+9xr51FBAnzLvIzkzM/5/QO0UOEA7VB5G+ucV+23XGSO30mumB5LkdJc6dewyRssqBPCfdBPFkS9jOivszeyeMwD9pzh8g5+o3hfPCimbnid0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259023; c=relaxed/simple;
	bh=1bC4AZNde0+5vTIjrxOxW8rZtXb6vrr9ApjJTDktajw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJAMv5qoRUVjXadzpQCqVi+an94BRlRuCaWb3/nQgH+z/CxjZzI5zf4ahpH78C+kOwt/K+UZ8arZ2l1Jdf0ssNqq1rvA2ee2yY7HUmsO2Nkhr5bc1JoZoJwdQk4a/mFTJ5rlyQLQrigfRjMutYab+s0xgxmfCa/Ui7fy5goeK2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yyrlscdI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2242ac37caeso34365ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742259021; x=1742863821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jyS5rCxr8EQqFWu2KoBKo/0nF0NkexL7fmn9bWW5ufc=;
        b=yyrlscdIWiZSKMq3QXS409sQMBjsz84n9zwd6+4u1CBlg/RQZfK8Ur4vnCb3ijGnBg
         sAAapMVQ3FLztb5XLx4Lql6Goz5tjlsshZHJJQUHSKOQkPuPN+K6++GCOzXMbt6RhyEs
         e6yiPmSKAs7NNifhwqiaq36nTm1/3WPBcGijBWpeGh3qM12YucOw2MsBlHj+roGUTX4H
         URsisSADh89YBCagz+ttJ+jT5U7sXCjMOw/AXHu34540k6xf5PcIyvc9K1ROGIsHXpGM
         cKDHthiT5Q8dEV153aGc8opkA5A0mB3LZYp812GtTNgGwFW1IlVDPVvOKZnw1oXxidWO
         Ah3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742259021; x=1742863821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jyS5rCxr8EQqFWu2KoBKo/0nF0NkexL7fmn9bWW5ufc=;
        b=ZekwmD+xHd1Ck/Xyl4n4HMRg+udIQxWpXBAKU4vgFKojkZCy1YdHHHc8HlerGhN0Mg
         hjELcgoa/3da3cIwniEmtEVoWZPV6/2JX6UbaHfSqyixVmtuGYGJCR5WMhyyu+BBN/oU
         cj7dZ/Glf/v1vj0RBWkcB27m2qBKJOppj+0yKfCyHt3S+6QS6ZJ7HiwEM4vPCMGAI+Nh
         zYbL/SOHWCntd/J7+KR9xSJxgmO1cNgD2sNU1VkneT2zAXFPruRdxarpYfzW8D+0Prm2
         DgNqeDwMY9261tpHD8RXbO+/hQpV6AMfHc5wdAIgcPwOvlBp9H8cJe7cca4Y+aKDS2wP
         yRQg==
X-Forwarded-Encrypted: i=1; AJvYcCV2+g5EGp6GRhWtGC0ikgqG4klfpuDn0ejKDWobEwgplwWUmJxQtzj60murcJtwVULthkybrhwCLNVhouU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPQWISUoGuo+krUmnoUJmsEETWkhSWZHTuzvqp8x5yKg16UCPp
	c9YlcmGenzKD/dDf4nXODg5dt3HmD1cLZwezstoNyHbU1BcmpsSO0GC0k/wSdMP6DfPWycKFrXN
	mc5/6
X-Gm-Gg: ASbGncsj+UYf8QPQR+IE3u0tXIVTkJP+1g/KZBiohzmiLbQW+s0dlTiv6YD0XqrbIm3
	0oHHKaA8oZhjpWMJX076penH58Vx/UUCNGsf8b5mUAsnjsW5DGetdv5PYoeOAmj30XjZUH2ftJa
	Tc31+LXQClav8Y7JB65EcwD9c6NSX65VENlV/fGuuKGrVgIRNzv1t84M1MsIu9KPU0SPr4cyLde
	u7eCTEHjJPXG38Me5sYfKApBxw3242lIwOmG7JUQzIPSJ8CimjNWqLd++WhuQLej0tqOKL7wvTk
	sppFcVsHt2pwvSniQaIJcetiZhQc23wL/NC4uTbVwKPkWGuimES/CWfiVyXmVUfXHnXi1zFTI0m
	S/eS0bDHAfvBzLmYjaA==
X-Google-Smtp-Source: AGHT+IHphGAwUXfXr7Mrrbm3vJ5pDrNsyjOLR/aaUMGpU3EUMn5PRxeescEk16cYhxEl8m70XssWNA==
X-Received: by 2002:a17:903:8c4:b0:216:21cb:2e14 with SMTP id d9443c01a7336-226357e0c41mr127135ad.21.1742259021211;
        Mon, 17 Mar 2025 17:50:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:38d4:55d0:4268:be3e:41c6:d4b4? ([2600:1700:38d4:55d0:4268:be3e:41c6:d4b4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301539d3f4bsm6814559a91.5.2025.03.17.17.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 17:50:20 -0700 (PDT)
Message-ID: <4ce0b11c-d2fd-4dff-b9db-30e50500ee83@google.com>
Date: Mon, 17 Mar 2025 17:50:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 03/29] mm: asi: Introduce ASI core API
To: Brendan Jackman <jackmanb@google.com>, Borislav Petkov <bp@alien8.de>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com,
 yosryahmed@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, peterz@infradead.org, seanjc@google.com,
 tglx@linutronix.de, x86@kernel.org
References: <20250227120607.GPZ8BVL2762we1j3uE@fat_crate.local>
 <20250228084355.2061899-1-jackmanb@google.com>
 <20250314131419.GJZ9Qrq8scAtDyBUcg@fat_crate.local>
 <5aa114f7-3efb-4dab-8579-cb9af4abd3c0@google.com>
 <20250315123621.GCZ9V0RWGFapbQNL1w@fat_crate.local>
 <Z9gKLdNm9p6qGACS@google.com>
Content-Language: en-US
From: Junaid Shahid <junaids@google.com>
In-Reply-To: <Z9gKLdNm9p6qGACS@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/25 4:40 AM, Brendan Jackman wrote:
> 
> I don't understand having both asi_[un]lock() _and_
> asi_{start,enter}_critical_region(). The only reason we need the
> critical section concept is for the purposes of the NMI glue code you
> mentioned in part 1, and that setup must happen before the switch into
> the restricted address space.
> 
> Also, I don't think we want part 5 inside the asi_lock()->asi_unlock()
> region. That seems like the region betwen part 5 and 6, we are in the
> unrestricted address space, but the NMI entry code is still set up to
> return to the restricted address space on exception return. I think
> that would actually be harmless, but it doesn't achieve anything.
> 
> The more I talk about it, the more convinced I am that the proper API
> should only have two elements, one that says "I'm about to run
> untrusted code" and one that says "I've finished running untrusted
> code". But...
> 
>> 1. you can do empty calls to keep the interface balanced and easy to use
>>
>> 2. once you can remove asi_exit(), you should be able to replace all in-tree
>>     users in one atomic change so that they're all switched to the new,
>>     simplified interface
> 
> Then what about if we did this:
> 
> /*
>   * Begin a region where ASI restricted address spaces _may_ be used.
>   *
>   * Preemption must be off throughout this region.
>   */
> static inline void asi_start(void)
> {
> 	/*
> 	 * Cannot currently context switch in the restricted adddress
> 	 * space.
> 	 */
> 	lockdep_assert_preemption_disabled();

I assume that this limitation is just for the initial version in this RFC, 
right? But even in that case, I think this should be in asi_start_critical() 
below, not asi_start(), since IIRC the KVM run loop does contain preemptible 
code as well. And we would need an explicit asi_exit() in the context switch 
code like we had in an earlier RFC.

> 
> 	/*
> 	 * (Actually, this doesn't do anything besides assert, it's
> 	 * just to help the API make sense).
> 	 */
> }
> 
> /*
>   * End a region begun by asi_start(). After this, the CPU cannot be in
>   * the restricted address space until the next asi_start().
>   */
> static inline void asi_end(void)
> {
> 	/* Leave the restricted address space if we're in it. */
> 	...
> }
> 
> /*
>   * About to run untrusted code, begin a region that _must_ run in the
>   * restricted address space.
>   */
> void asi_start_critical(void);
> 
> /* End a region begun by asi_start_critical(). */
> void asi_end_critical(void);
> 
> ioctl(KVM_RUN) {
>      enter_from_user_mode()
>      asi_start()
>      while !need_userspace_handling()
>          asi_start_critical();
>          vmenter();
>          asi_end_critical();
>      }
>      asi_end()
>      exit_to_user_mode()
> }
> 
> Then the API is balanced, and we have a clear migration path towards
> the two-element API, i.e. we need to just remove asi_start() and
> asi_end(). It also better captures the point about the temporary
> simplification: basically the reason why the API is currently
> overcomplicated is: if totally arbitrary parts of the kernel can find
> themselves in the restricted address space, we have more work to do.
> (It's totally possible, but we don't wanna block initial submission on
> that work). The simplification is about demarcating what code is and
> isn't affected by ASI, so having this "region" kinda helps with that.
> Although, because NMIs can also be affected it's a bit of a fuzzy
> demarcation...

Not just NMIs, but other IRQs can also be in the restricted address space even 
in this initial version. But that is of course still significantly less in scope 
than the general case, so the demarcation of process-context code via 
asi_start()/asi_end() does indeed seem useful.

Thanks,
Junaid


