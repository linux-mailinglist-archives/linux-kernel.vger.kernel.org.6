Return-Path: <linux-kernel+bounces-312919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FC3969DB6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7723AB20C68
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB8B1C9875;
	Tue,  3 Sep 2024 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLPOZLf2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6B41A0BCB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367060; cv=none; b=aIWXuR3t42sGkdDVub1qYbzt3tBM/Np6Is1ZUOzuxiWFFTMod0lUvJJ7qyHeSFQMiNWApteucf7fkKO73LmlXfYHEVy5kIqbU1pIpXdufaazatvUsY8Sg44zOqDHbe6mgJA6IGLalDtgknOQdSI4iZ0mLTUrZ/HXnRMcFmNB9P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367060; c=relaxed/simple;
	bh=tmv03h92ijIwyRhoiFtKQXiRllr1tIv4quj94CTJpfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sNdisZZYkczR/5m0mJmu2FuOk6tP3cIFHB/bcVN2WLq9bomnn7bQrILekxSf49VcL1ZsjKfOKdGxO4FFvPsKjsRlXtGakQcqvsy8mDZtej0sBdPygvRA8Zm8dJB9PzZrUu1VJC0HZGe596fIJMj5NOFmZfZLxhnQeSmSX0xpt/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XLPOZLf2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725367057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lUAYXkxnOQXG3S0lZgSKk2z1/MrhZFXha6f6lbot9Jk=;
	b=XLPOZLf2uBhcqtlViq7Jeqk68OSTBVdI+ZgJiokCAzsKmfKkPaQH2XJGpc8XCm5lXQU3ZG
	2Sz7X1K9Fax/4W2linPmXfBCsHFJJ7xq46IgoET/665c5ZYhRewXubdJccllZgoGgs3WLc
	2EmU+kXDXKer9zmlvDrVm7EJCb6G5gI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-D3z7vbumN1yxRBz7cZO2tQ-1; Tue, 03 Sep 2024 08:37:34 -0400
X-MC-Unique: D3z7vbumN1yxRBz7cZO2tQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42c82d3c7e5so20274005e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 05:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367053; x=1725971853;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lUAYXkxnOQXG3S0lZgSKk2z1/MrhZFXha6f6lbot9Jk=;
        b=gV9a6CWH5P2uZ00Ub4Azi7m8pC6Z0rZ/6V86gTkvAd4Z5026GVD344rZQX8/0yM0zY
         TjMdPPx2YuwykYp5lXJbiWBgNl49vha0VHy3a1oXlqsvqL5jWeQS7akrnrcwRQSgDp5G
         W4EeUg+meI64mnYvgprQ2BykaQkdt8K3cji2KGl5xY+keq3zjPa1JkRRgyW83vj7fFa8
         MS80FgDIG6ftHsgVkWj8+vs41RgHsp5rVv4rbJd5vU939Kzp2KAk8oFFMzpP0rvt4jHi
         y56NYrWG8L7kw3JOPxcBzJJaLGLSu0WW3N5t593VoXFTHiMUVao690D5d/l/smMykEv9
         MLOw==
X-Forwarded-Encrypted: i=1; AJvYcCXpqjqaHFt+Tr8YglMRP/I8dJMQtWg88aU9w5dWiC2srT16ki6cF2aJr4xwM8vMWBoY5qDT5AclV63ArsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhcvAoPjq+nuhT8LQBN9CZjFxXOa4JOuzWAhC1mQcI6h3aU6Ot
	MpQu0ohyXn/9JSdlbSP4oTJ5TbTO1FfsfHx+owxv6uJbvNay86B76pGLf0tTcPt0gQY6LvLIKqs
	J+EDJwAWtLYCkH9wQzY1tZx4hr9gKP+am7Y70Txl3nr8QSlDbRI4aUtdFEwceOQ==
X-Received: by 2002:a5d:4109:0:b0:374:bad2:6a5e with SMTP id ffacd0b85a97d-374bf168f0emr6440608f8f.28.1725367052685;
        Tue, 03 Sep 2024 05:37:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHuRJ+1yqABJ5FrHa3p+lGeJ1p45MR/DdKqV6ngyOOFhN2OzNIXX5ayxl/sPEgLoWsBoMxwg==
X-Received: by 2002:a5d:4109:0:b0:374:bad2:6a5e with SMTP id ffacd0b85a97d-374bf168f0emr6440568f8f.28.1725367051754;
        Tue, 03 Sep 2024 05:37:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:7f00:8a04:4c6f:a761:af60? (p200300cbc7097f008a044c6fa761af60.dip0.t-ipconnect.de. [2003:cb:c709:7f00:8a04:4c6f:a761:af60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c07eed5dsm8960138f8f.116.2024.09.03.05.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 05:37:31 -0700 (PDT)
Message-ID: <f3fe6be4-723e-45b8-baa6-5c285cc5c150@redhat.com>
Date: Tue, 3 Sep 2024 14:37:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Potential Regression in futex Performance from v6.9 to v6.10-rc1
 and v6.11-rc4
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>
References: <CADYN=9JBw6kq4E9aA=Pr1rFy-6tY-j-XOthQVYVw6ptmj11=HA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CADYN=9JBw6kq4E9aA=Pr1rFy-6tY-j-XOthQVYVw6ptmj11=HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.09.24 14:21, Anders Roxell wrote:
> Hi,
> 
> I've noticed that the futex01-thread-* tests in will-it-scale-sys-threads
> are running about 2% slower on v6.10-rc1 compared to v6.9, and this
> slowdown continues with v6.11-rc4. I am focused on identifying any
> performance regressions greater than 2% that occur in automated
> testing on arm64 HW.
> 
> Using git bisect, I traced the issue to commit
> f002882ca369 ("mm: merge folio_is_secretmem() and
> folio_fast_pin_allowed() into gup_fast_folio_allowed()").

Thanks for analyzing the (slight) regression!

> 
> My tests were performed on m7g.large and m7g.metal instances:
> 
> * The slowdown is consistent regardless of the number of threads;
>     futex1-threads-128 performs similarly to futex1-threads-2, indicating
>     there is no scalability issue, just a minor performance overhead.
> * The test doesn’t involve actual futex operations, just dummy wake/wait
>     on a variable that isn’t accessed by other threads, so the results might
>     not be very significant.
> 
> Given that this seems to be a minor increase in code path length rather
> than a scalability issue, would this be considered a genuine regression?

Likely not, I've seen these kinds of regressions (for example in my fork
micro-benchmarks) simply because the compiler slightly changes the code
layout, or suddenly decides to not inline a functions.

Still it is rather unexpected, so let's find out what's happening.

My first intuition would have been that the compiler now decides to not
inline gup_fast_folio_allowed() anymore, adding a function call.

LLVM seems to inline it for me. GCC not.

Would this return the original behavior for you?

diff --git a/mm/gup.c b/mm/gup.c
index 69c483e2cc32d..6642f09c95881 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2726,7 +2726,8 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
   * in the fast path, so instead we whitelist known good cases and if in doubt,
   * fall back to the slow path.
   */
-static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
+static __always_inline bool gup_fast_folio_allowed(struct folio *folio,
+               unsigned int flags)
  {
         bool reject_file_backed = false;
         struct address_space *mapping;


-- 
Cheers,

David / dhildenb


