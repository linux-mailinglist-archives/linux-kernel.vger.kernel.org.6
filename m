Return-Path: <linux-kernel+bounces-328494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F709784F2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5875E1F290D5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D894D3B782;
	Fri, 13 Sep 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSvoymjV"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7265339E;
	Fri, 13 Sep 2024 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241592; cv=none; b=b3yAATMcA+1u92DxDThoMBXe96sQIi2o8pIyuF3ePHfMYjZmkUnYtGpyKtdSwM1iiL0wFq4dk2FqYpgkT1ZpgUlSIO8Tw9f6q3l/aKUZ6K76q9f1zLyd/X9QPxucNZCiGn6KkFocbPL8n2V66/0V3swbyniAZ/0blY8hj9wn+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241592; c=relaxed/simple;
	bh=VOxwlOrBRs2MiQMDRx5LIE0TRBF2uGV36Nbl1/REfbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0heAekULdd0s2PeKUpZFYsv7IwbBsBHSX1ADSCr51SuT2O/DpbVZY0XruaVWYFCwhxwqEFmamR5rthkwc8Ylny0KBoPZX6E8LXPO4roc5aeO4O5kAC/tmmbnG6mHK50T9U3BjcFjGQmntNwbgbIQP4ilyBY1Rl+0ZMqexUHYkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSvoymjV; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5e1c65eb68aso1401325eaf.2;
        Fri, 13 Sep 2024 08:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726241588; x=1726846388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VaW8M5A1YWozTkKnBSpFpfu8qXKVIGE0iY3JYgtjnHs=;
        b=RSvoymjVk21MzXDj8MfSRmZLF0PZfPM6Fo3DUPnI4k67Wi5WMC1N95mnPHTAWBUDqE
         56C/3+//IYpUjnE9pxL0pJPw466+LaDfSSk0geckjGHQf4DvPACYBcK746pL1mNfhoXe
         IYc0nV3+u/WHIja8kS6r5LpKimH9wYHR63AL3cfY+/TPK6GjKpQ8b5d8oYGjMactOGM9
         bB3WkqdZjiod57aSVIY6ai9dTIKKR4EmPTysF+c6/fp+8056vkSUVGYN12XCxCPALjQH
         /IyL7XI3hlZ+YtSYvYDzJerbz0tzubHggDm0eYDPRZSlkoRlEqkPs6LfsLwzK1c/tPti
         L3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726241588; x=1726846388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VaW8M5A1YWozTkKnBSpFpfu8qXKVIGE0iY3JYgtjnHs=;
        b=iTfDlS5XO432DOJ9VeY+xV//zumHQx2c4Rn58xtmhSfzfX+CqO8go+SLwF7RR7ibwz
         9u/8LF02ABe9pa7DNGKwv7H1D+klTqSXzr2sITjcwNRnh2e174fjN6nlw7jdNq8AzwbX
         D2tT05ZCeeI9S8rUeb9nsi8thxffn1RnjpfKT3q+vOGzx9k1oIPf4p/cKppSd4c7Ci35
         AdDgE1E2GAFLX5yTu1/04PiU7psCR+9ygiHN9CJXFk1hEdTVWw3dPZge++STDCQ80zu/
         0CEuFYuQCmrCXOLMnRou29JpLqFJak4pNCtLe3DAOG5AHJO2+sCqbWrC9WNjzUJg0s2H
         4dcg==
X-Forwarded-Encrypted: i=1; AJvYcCUdSjKznFij3Lt+/aTe1SLHicyO22IdpUBMz3K17UQbD3wXs3n9qS/3FkpP1+Uy9vKVjMUuyxWlwt70DjId@vger.kernel.org, AJvYcCV70ntTMJyXJYugjmFu5rXjsF44IjCRSDrTfho50r0bJOnwcrt9WbPeCcs1hi+Z0BvJEUaLOkfWWOTu@vger.kernel.org, AJvYcCV8b2317JEpd7iOpBAurqQlyqjEuUtgWDD4sQ5Cy45qDMioddOFfvnI/wk2HsPwqHcPkD29xSL1U0Y=@vger.kernel.org, AJvYcCXfMkHM7g5wheDP9pahPmtCh1iJ7J+It7ELO+wKKsHfn8YjZW9rU3juQWONeDUuXn5J7sgETna0hgOgFzBMyww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNU/d+lJi9IvOxbuvaOcof7GOgRzb68V+8+AVes2pXUtILEjYs
	4F2ouV118Q6WOwQUxo/GSar8x9PMm0RYEscwGt9WoVd9hREDxfyU
X-Google-Smtp-Source: AGHT+IEAYqx4rmwyHhiieFyGlawopjw+sv9h5r3NZJOoHTFiwESvWjySMoGbIvSh6iOL8YvZ+9nplA==
X-Received: by 2002:a05:6870:d114:b0:255:2e14:3d9d with SMTP id 586e51a60fabf-27c3f0da8f9mr4701969fac.5.1726241587761;
        Fri, 13 Sep 2024 08:33:07 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:dff5:4180:2562:4c1e? ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-710f42079b5sm1800354a34.62.2024.09.13.08.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 08:33:07 -0700 (PDT)
Message-ID: <cf7d10a0-57c1-4225-a91b-bf8d37576c17@gmail.com>
Date: Fri, 13 Sep 2024 10:33:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel-docs: Add new section for Rust learning materials
To: Dirk Behme <dirk.behme@de.bosch.com>, corbet@lwn.net, ojeda@kernel.org
Cc: alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, bilbao@vt.edu
References: <20240911185931.16971-1-carlos.bilbao.osdev@gmail.com>
 <a47252d8-2833-49e3-9e8c-588a4979cbd3@de.bosch.com>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <a47252d8-2833-49e3-9e8c-588a4979cbd3@de.bosch.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/12/24 00:01, Dirk Behme wrote:

> On 11.09.2024 20:59, Carlos Bilbao wrote:
>> Include a new section in the Index of Further Kernel Documentation with
>> resources to learn Rust. Reference it in the Rust index.
> Many thanks for creating the patch! Looks nice :)
>
> Whats about adding
>
> https://google.github.io/comprehensive-rust/
>
> https://docs.rust-embedded.org/book/
>
> additionally?


You got it! I’ll send v2 in a few mins.


>
> Best regards
>
> Dirk
>
>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
>> ---
>>   Documentation/process/kernel-docs.rst | 111 +++++++++++++++++++++++---
>>   Documentation/rust/index.rst          |   3 +
>>   2 files changed, 103 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
>> index 55552ec4b043..d917accd7fc3 100644
>> --- a/Documentation/process/kernel-docs.rst
>> +++ b/Documentation/process/kernel-docs.rst
>> @@ -72,17 +72,6 @@ On-line docs
>>           programming. Lots of examples. Currently the new version is being
>>           actively maintained at https://github.com/sysprog21/lkmpg.
>>   
>> -    * Title: **Rust for Linux**
>> -
>> -      :Author: various
>> -      :URL: https://rust-for-linux.com/
>> -      :Date: rolling version
>> -      :Keywords: glossary, terms, linux-kernel.
>> -      :Description: From the website: "Rust for Linux is the project adding
>> -        support for the Rust language to the Linux kernel. This website is
>> -        intended as a hub of links, documentation and resources related to
>> -        the project".
>> -
>>   Published books
>>   ---------------
>>   
>> @@ -220,6 +209,106 @@ Miscellaneous
>>           other original research and content related to Linux and software
>>           development.
>>   
>> +Rust
>> +----
>> +
>> +    * Title: **Rust for Linux**
>> +
>> +      :Author: various
>> +      :URL: https://rust-for-linux.com/
>> +      :Date: rolling version
>> +      :Keywords: glossary, terms, linux-kernel, rust.
>> +      :Description: From the website: "Rust for Linux is the project adding
>> +        support for the Rust language to the Linux kernel. This website is
>> +        intended as a hub of links, documentation and resources related to
>> +        the project".
>> +
>> +    * Title: **Learning Rust the Dangerous Way**
>> +
>> +      :Author: Cliff L. Biffle
>> +      :URL: https://cliffle.com/p/dangerust/
>> +      :Date: Accessed Sep 11 2024
>> +      :Keywords: rust, blog.
>> +      :Description: From the website: "LRtDW is a series of articles
>> +        putting Rust features in context for low-level C programmers who
>> +        maybe don’t have a formal CS background — the sort of people who
>> +        work on firmware, game engines, OS kernels, and the like.
>> +        Basically, people like me.". It illustrates line-by-line
>> +        conversions from C to Rust.
>> +
>> +    * Title: **The Rust Book**
>> +
>> +      :Author: Steve Klabnik and Carol Nichols, with contributions from the
>> +        Rust community
>> +      :URL: https://doc.rust-lang.org/book/
>> +      :Date: Accessed Sep 11 2024
>> +      :Keywords: rust, book.
>> +      :Description: From the website: "This book fully embraces the
>> +        potential of Rust to empower its users. It’s a friendly and
>> +        approachable text intended to help you level up not just your
>> +        knowledge of Rust, but also your reach and confidence as a
>> +        programmer in general. So dive in, get ready to learn—and welcome
>> +        to the Rust community!".
>> +
>> +    * Title: **Rust for the Polyglot Programmer**
>> +
>> +      :Author: Ian Jackson
>> +      :URL: https://www.chiark.greenend.org.uk/~ianmdlvl/rust-polyglot/index.html
>> +      :Date: December 2022
>> +      :Keywords: rust, blog, tooling.
>> +      :Description: From the website: "There are many guides and
>> +        introductions to Rust. This one is something different: it is
>> +        intended for the experienced programmer who already knows many
>> +        other programming languages. I try to be comprehensive enough to be
>> +        a starting point for any area of Rust, but to avoid going into too
>> +        much detail except where things are not as you might expect. Also
>> +        this guide is not entirely free of opinion, including
>> +        recommendations of libraries (crates), tooling, etc.".
>> +
>> +    * Title: **Fasterthanli.me**
>> +
>> +      :Author: Amos Wenger
>> +      :URL: https://fasterthanli.me/
>> +      :Date: Accessed Sep 11 2024
>> +      :Keywords: rust, blog, news.
>> +      :Description: From the website: "I make articles and videos about how
>> +        computers work. My content is long-form, didactic and exploratory
>> +        — and often an excuse to teach Rust!".
>> +
>> +    * Title: **You Can't Spell Trust Without Rust**
>> +
>> +      :Author: Alexis Beingessner
>> +      :URL: https://repository.library.carleton.ca/downloads/1j92g820w?locale=en
>> +      :Date: 2015
>> +      :Keywords: rust, master, thesis.
>> +      :Description: This thesis focuses on Rust's ownership system, which
>> +        ensures memory safety by controlling data manipulation and
>> +        lifetime, while also highlighting its limitations and comparing it
>> +        to similar systems in Cyclone and C++.
>> +
>> +    * Name: **Linux Plumbers (LPC) Rust presentations**
>> +
>> +      :Title: Rust microconference
>> +      :URL: https://lpc.events/event/18/sessions/186/#20240918
>> +      :Title: Rust for Linux
>> +      :URL: https://lpc.events/event/18/contributions/1912/
>> +      :Title: Journey of a C kernel engineer starting a Rust driver project
>> +      :URL: https://lpc.events/event/18/contributions/1911/
>> +      :Title: Crafting a Linux kernel scheduler that runs in user-space
>> +        using Rust
>> +      :URL: https://lpc.events/event/18/contributions/1723/
>> +      :Title: openHCL: A Linux and Rust based paravisor
>> +      :URL: https://lpc.events/event/18/contributions/1956/
>> +      :Keywords: rust, lpc, presentations.
>> +      :Description: A number of LPC talks related to Rust.
>> +
>> +    * Name: **The Rustacean Station Podcast**
>> +
>> +      :URL: https://rustacean-station.org/
>> +      :Keywords: rust, podcasts.
>> +      :Description: A community project for creating podcast content for
>> +        the Rust programming language.
>> +
>>   -------
>>   
>>   This document was originally based on:
>> diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
>> index 46d35bd395cf..01f09216c229 100644
>> --- a/Documentation/rust/index.rst
>> +++ b/Documentation/rust/index.rst
>> @@ -42,6 +42,9 @@ configurations.
>>       arch-support
>>       testing
>>   
>> +You can also find learning materials for Rust in its section in
>> +:doc:`../process/kernel-docs`.
>> +
>>   .. only::  subproject and html
>>   
>>      Indices


Thanks, Carlos


