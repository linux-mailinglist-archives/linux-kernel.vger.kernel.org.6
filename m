Return-Path: <linux-kernel+bounces-387429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A919B5118
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314F81F2372B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CED1DCB31;
	Tue, 29 Oct 2024 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hUjxJgKv"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9F92107
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730223523; cv=none; b=oQ/iYtGPaG8ykksuqkPyFVGQZaQSEvS78egR2dcLJRsvldgF+MyAX96rMQSME8LZid+RI60hwRszdZ6xfrF9Ws9un8l4dFtoXwbzCX4v1JP5/SpUMhTL5PftQqS0n8f0iYz95X/4n4LSzkr1o8/CpblzvlycO6wNOwoE51tO5S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730223523; c=relaxed/simple;
	bh=4hBwtnFU0qAi8YGRKbcNCKRHUnrB/+rP1zHxyIDHDIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ot+5Vm9nCMhIa6S6pgRRzEdLaGSyZgC/PZM9IZkzZueo5wPRuoL98SPxBZ0KJyRSvZvUQa2KvlndZ6akNWjq2wGn1GRBUjojhYrcA+0tkbJBux04KJ4JttGTSxPRJSgaxke9QttOf+4+yljdT6hKyLJ7oAISgmanMMN3Tho2Ntk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hUjxJgKv; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4608dddaa35so29241cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730223521; x=1730828321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4NzyGHFNG2VmMmlShndRLXedmken+2X5Xff0mPyjqlA=;
        b=hUjxJgKvHxAOY5hISm4fq/HeoWH2gj4mCsB0pkCG5Z7KJ1VTYeEmDkP0zGN2swHyLA
         7mGJnvUloXhk+Rk8ZLBl4j44+mzOjwQCzCZfY5Sli9sVthBuX/PC771c1Uz/r9Zp5pdW
         JIITbUX54UK+WpZbNgN4NGs4oXwhq5AknU39ekoVXGvNq9jERaWj/hukhNschvs4KPSc
         hyaBkLFul987AhIbGiN5J0ZFxr1oV9TlVufDCIEquAQdwdoRNezmz7/uq+azeQsdv74o
         sDMUiaiN52avjw2RNVRPL3aLuk5ABUN0i9v8csEinYvtPXHDWUx95hGGw0d+EJofR2aK
         fTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730223521; x=1730828321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NzyGHFNG2VmMmlShndRLXedmken+2X5Xff0mPyjqlA=;
        b=ZOqAS+/4GciPrHQbIh3000F6jImP05yQa1tEa8Qozk+QJ1s+V9ywvqjw8Vg2JhSHWO
         giSVNShnov6CMpiLLDYK94WMFs9vH5Nv64YaGGfWbykG8iBIlnzJHArmPVDefpbPUkSB
         y/2+hfgrsEg3mlso+TUYKTZj77NCtcXgBSYYBiQSvgKrnf/zyQTXRuZNhjUhcHNoch48
         ZbUZMxPLL9IVVsuoy6+PDWd7Vdga9ND5APpwDIXTG1I03xDZ8PC3wEcf90Gp6Qn5WUIS
         v4xjLLwDzLM2G2Qusu8jaD6BWXinIoO/t8VaDa7rdSs2xrPSSri63dx7hzXW8gfmPUbq
         eheA==
X-Forwarded-Encrypted: i=1; AJvYcCXZiXsrz7r0NQUs/fS+K35mIAhrKcaBCs+JZWDlr2OtjF1crFZzhAZGd3bieUkLkHGE1nW68eDkhooAqpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt/BACfcObXcFNVbSIsis7AD0km4pWOMrh25I2lJC9RYikI/3Q
	mdtHUGFifGRcNBLKqaSP/NHBd+IXFqZl8zNaOCxBsP/C+EpUippQ8M7oyDTdxA==
X-Gm-Gg: ASbGnctIYzhc2nShKuUxg3rBhYIprpaqqD4sbg2zq+zwxSC7E71yqxiqsLjC3Q8ULi4
	6LMPSvWIcDu+L1rXDEQAxwn2E0mucmV84UvGiXDVRk4THXdkLWbKtQ+7bEuSBAXHt8eH7+YsZLj
	vPAl2rHFyYvZjb1CQXt7gv/fFXexRLo+Dt04Q8W6epfQoWHEHqvOa1xceRgC55+k5ol2lA+2HPB
	OmvspUveEdxvb/yX0vQZk3VyXhw02HMilIfhRuEok4Z9P5KMLNYBC9FzNdgWoiz1VMkiLjEOwb5
	jXj1ZojZpxKbYo56/UiF
X-Google-Smtp-Source: AGHT+IH+aatp5vvOT3MLmDgG/8NEz2ktnGYsU3OGGl2E+dYdZKM2fvH7N/zzBC7qLEmuQMllIaaB+w==
X-Received: by 2002:a05:622a:1a9d:b0:460:f093:f259 with SMTP id d75a77b69052e-46164fcec8fmr4325821cf.22.1730223520365;
        Tue, 29 Oct 2024 10:38:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:38d4:55d0:4aae:c9af:39c8:58b? ([2600:1700:38d4:55d0:4aae:c9af:39c8:58b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec187389a0sm2417435eaf.42.2024.10.29.10.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 10:38:38 -0700 (PDT)
Message-ID: <ab8ef5ef-f51c-4940-9094-28fbaa926d37@google.com>
Date: Tue, 29 Oct 2024 10:38:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/26] mm: asi: Make some utility functions noinstr
 compatible
To: Brendan Jackman <jackmanb@google.com>, Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Chartre <alexandre.chartre@oracle.com>,
 Liran Alon <liran.alon@oracle.com>,
 Jan Setje-Eilers <jan.setjeeilers@oracle.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Lorenzo Stoakes <lstoakes@gmail.com>, David Hildenbrand <david@redhat.com>,
 Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
 Khalid Aziz <khalid.aziz@oracle.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>, Paul Turner <pjt@google.com>,
 Reiji Watanabe <reijiw@google.com>, Ofir Weisse <oweisse@google.com>,
 Yosry Ahmed <yosryahmed@google.com>, Patrick Bellasi <derkling@google.com>,
 KP Singh <kpsingh@google.com>, Alexandra Sandulescu <aesa@google.com>,
 Matteo Rizzo <matteorizzo@google.com>, Jann Horn <jannh@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kvm@vger.kernel.org
References: <20240712-asi-rfc-24-v1-0-144b319a40d8@google.com>
 <20240712-asi-rfc-24-v1-1-144b319a40d8@google.com>
 <20241025113455.GMZxuCX2Tzu8ulwN3o@fat_crate.local>
 <CA+i-1C3SZ4FEPJyvbrDfE-0nQtB_8L_H_i67dQb5yQ2t8KJF9Q@mail.gmail.com>
Content-Language: en-US
From: Junaid Shahid <junaids@google.com>
In-Reply-To: <CA+i-1C3SZ4FEPJyvbrDfE-0nQtB_8L_H_i67dQb5yQ2t8KJF9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/24 6:21 AM, Brendan Jackman wrote:
> Hey Boris,
> 
> On Fri, 25 Oct 2024 at 13:41, Borislav Petkov <bp@alien8.de> wrote:
>>
>> On Fri, Jul 12, 2024 at 05:00:19PM +0000, Brendan Jackman wrote:
>>> +/*
>>> + * Can be used for functions which themselves are not strictly noinstr, but
>>> + * may be called from noinstr code.
>>> + */
>>> +#define inline_or_noinstr                                            \
>>
>> Hmm, this is confusing. So is it noinstr or is it getting inlined?
> 
> We don't care if it's getting inlined, which is kinda the point. This
> annotation means "you may call this function from noinstr code". My
> current understanding is that the normal noinstr annotation means
> "this function fundamentally mustn't be instrumented".
> 
> So with inline_or_noinstr you get:
> 
> 1. "Documentation" that the function itself doesn't have any problem
> with getting traced etc.
> 2. Freedom for the compiler to inline or not.
> 
>> I'd expect you either always inline the small functions - as you do for some
>> aleady - or mark the others noinstr. But not something in between.
>>
>> Why this?
> 
> Overall it's pretty likely I'm wrong about the subtlety of noinstr's
> meaning. And the benefits I listed above are pretty minor. I should
> have looked into this as it would have been an opportunity to reduce
> the patch count of this RFC!
> 
> Maybe I'm also forgetting something more important, perhaps Junaid
> will weigh in...

Yes, IIRC the idea was that there is no need to prohibit inlining for this class 
of functions.


