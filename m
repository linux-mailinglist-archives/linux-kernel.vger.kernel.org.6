Return-Path: <linux-kernel+bounces-417942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AF89D5B14
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0451F22B14
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CE318C033;
	Fri, 22 Nov 2024 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBgAOS1V"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3763156F3F;
	Fri, 22 Nov 2024 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732264605; cv=none; b=CyyoCnGDCd2Y+0lUM4pNjBWneOk3TXeVn4oDjDQghGWthuRtqSR/UAWBw+3aqZehJV8hD4CJeuUT24HRIpz2zxetgTKVyIs7eiR4JOt9jKZ8zbwMPwJU+FxGrY6BTfsvlEpAtStTs3uF3b5E8dajEhzZIi3W9NJRW8FHm/sYa7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732264605; c=relaxed/simple;
	bh=vFW0IJ0LFbR2xrz/HIKuVD0t8pgr0vzXqGnWzS7nRwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGA5xwNKu7eVwK9Xh4ZVCkT4lurv6yqKjos3+DyipDcAuqixzP+51/eHPha04x/7MUxBg10X0sH3Qm+IAerp7WPpcWQhsHf4XNgA/EyQKF12JDgyYiQgaeMk+WJLi/tVBnXtbGTUkNFiSssdGmBEnD/cruHYPacwbrjCtpQwNAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBgAOS1V; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53d9ff92ee9so2069170e87.1;
        Fri, 22 Nov 2024 00:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732264602; x=1732869402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MBEAvvG9TOvTtZsp475mYKKe/GTMGyWrpHVozBadszo=;
        b=DBgAOS1VQPg3W1HatePsVFYaR0sUJl7e5uDd7DPw80dQYE0UppCUHCFrsAojKgW50D
         Bdu1gPEHD7PU00vyDvTAZeEH5XI/6OODr9kEqp6csQClfBLCVzC1dzh3VcO8/GO7QV9J
         gr+fjRzV+j8KR+TCpiq5phmnfUJmC50dqL9JtilMuose62epnKQVRjWN0t1lzYLRJB2q
         TAx/Qnvc5/mc3pU/5PeaDoEfYAHZe+3RTPC9s9wCjW2msziKm0YuSjU0HwOt/PUXwhue
         i/6wnx51m+yq4jSl7MCYe6a05qS0Btt62Oi5xX6LPCFGPi3pdGB7uG5YRBtikAGUmEV+
         ubtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732264602; x=1732869402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBEAvvG9TOvTtZsp475mYKKe/GTMGyWrpHVozBadszo=;
        b=cATa28w66EZwKaKQCe/isjNiZPaPLiQ7vKP3Ww9Q1gLHQlneiMf+oPh3mKXfRYy6Mr
         w+aOFJAKvlXsxD8x0IgaKVLe/CZcoy4NvGPbxQgGFUYuPx69f5G12Z9qPyAwn4Qg7l7o
         rWaDbcY600cVHBjXzKTsevKCDrGAXQQJwi09TCjrXXpZjDaKuufwAF+hQSDJO6PA/Xco
         cpxoe+DQNcUKd7dAbcz9a7nfg8CFfnLwbsgY6HwJhSrYuWrVYGmA0OYtU4rZI29+x6a8
         YvWuGhtBjWRI1e+CBb5G3/OVsfgJ4Cd8Koq6SVlS8IWWSOX3k5iHUQmV/clflYsq9Ust
         vx/w==
X-Forwarded-Encrypted: i=1; AJvYcCXGsUrhbq9YHymPlfVfE+yhx3yBx7yEByJ7CADux5ynHlFzCcqG9QHowxJ+3DFQB66EieQMescg6aHVUHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzb+viayfwYNqyFmi0gWCgn4b78gxHG1B+qL/LSOzgTxFVUgA2
	RoDJXRm214mbLPNyOniiF7maf0DkguJ5B+CfJpRFdRpM/1kyRtoF
X-Gm-Gg: ASbGnctteahKp0WzFa5UdM30mEwxCiM0WqVsalwHaQG6DJMVCAQFHxODELbdCKj8TGi
	BCoKgp+ItM1MWSv7h7SUNCNlTO7zhgCMc21X5iaGuXYni6u1CQlVsk5wKtvJobzYKVTve3tfc8Y
	5lHz+Wxlyvz1nB6RFJPaOI0MHz9rmJK6srBhS1SYbt+YKyxCRXsGaeaIChHWRE61Fao8deI0zLS
	PJ/N83CFRPW2Ui2/WrGMD13fzSJnc4gxzKEmt6FSIW0P9lfGNw87qJTU6X8RuyRIQ9g04ScXZJF
	7QCQyiAPJOwfYjrytjxQ
X-Google-Smtp-Source: AGHT+IGdwiR49anO91g2/YPv1iIkpUxFpZJxQBmEsHcwqIfap5HF3A+oVH1AnEJU7mnuAizghBvzdg==
X-Received: by 2002:a05:6512:1cc:b0:53d:cd25:4a61 with SMTP id 2adb3069b0e04-53dd39b15e0mr811640e87.42.1732264601474;
        Fri, 22 Nov 2024 00:36:41 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24811b0sm289272e87.162.2024.11.22.00.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 00:36:40 -0800 (PST)
Message-ID: <f0052c1d-ce36-447c-af1f-db12940f6cc1@gmail.com>
Date: Fri, 22 Nov 2024 10:36:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] rust: page: Extend support to existing struct page
 mappings
To: Alice Ryhl <aliceryhl@google.com>, Jann Horn <jannh@google.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, airlied@redhat.com
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
 <20241119112408.779243-3-abdiel.janulgue@gmail.com>
 <CAG48ez3fjXG1Zi=V8yte9ZgSkDVeJiQV6xau7FHocTiTMw0d=w@mail.gmail.com>
 <43a07c04-2985-4999-b6d6-732794906a36@gmail.com>
 <CAG48ez1uzoEcsFG7Tsfj2WCXor9-mhffoWO8VFoit3j_mUC7-A@mail.gmail.com>
 <CAH5fLghUb8dEV9GVtJj497cJ5sp4Gg7=qeijfnV_w4BNd70qxg@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CAH5fLghUb8dEV9GVtJj497cJ5sp4Gg7=qeijfnV_w4BNd70qxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/11/2024 09:55, Alice Ryhl wrote:
> On Thu, Nov 21, 2024 at 9:18 PM Jann Horn <jannh@google.com> wrote:
>>
>> On Wed, Nov 20, 2024 at 11:56 PM Abdiel Janulgue
>> <abdiel.janulgue@gmail.com> wrote:
>>> On 19/11/2024 19:07, Jann Horn wrote:
>>>>> +    pub fn page_slice_to_page<'a>(page: &PageSlice) -> Result<&'a Self>
>>>>
>>>> Sorry, can you explain to me what the semantics of this are? Does this
>>>> create a Page reference that is not lifetime-bound to the PageSlice?
>>>
>>> This creates a Page reference that is tied to the lifetime of the `C
>>> struct page` behind the PageSlice buffer. Basically, it's just a cast
>>> from the struct page pointer and does not own that resource.
>>
>> How is the Page reference tied to the lifetime of the C "struct page"?
>>
>> I asked some Rust experts to explain to me what this method signature
>> expands to, and they added the following to the Rust docs:
>>
>> https://github.com/rust-lang/reference/blob/master/src/lifetime-elision.md
>> ```
>> fn other_args1<'a>(arg: &str) -> &'a str;             // elided
>> fn other_args2<'a, 'b>(arg: &'b str) -> &'a str;      // expanded
>> ```
>>
>> Basically, my understanding is that since you are explicitly
>> specifying that the result should have lifetime 'a, but you are not
>> specifying the lifetime of the parameter, the parameter is given a
>> separate, unrelated lifetime by the compiler? Am I misunderstanding
>> how this works, or is that a typo in the method signature?
> 
> No, you are correct. The signature is wrong and lets the caller pick
> any lifetime they want, with no relation to the lifetime of the
> underlying `struct page`.

But that could be put in the invariant that the PageSlice buffer must 
last at least the lifetime `'a`?

> 
>  From a C perspective, what are the lifetime requirements of vmalloc_to_page?
> 

If I'm not mistaken, that should be the lifetime of the vmalloc'd buffer 
right?


