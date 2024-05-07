Return-Path: <linux-kernel+bounces-171864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933FD8BE99F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B109D1C20D98
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB4814D2A5;
	Tue,  7 May 2024 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8NqGAHw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FBC1170D
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100202; cv=none; b=l3MYAcaOa+59c9yv8KQ1gfYiyura/lb7n2awxp0qidD6LbMx5bKfoW4Z0tRilD+j6wBVgREpE5Ks+ck2Ka/zmyMT61eNgjBi27gRq6F8TK9eNbOVOMXJ71ZyUqTiNtGjv4aKwbUYqGybTl1ZwylrRyOLCO3UZWe3fB0wN7DkzY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100202; c=relaxed/simple;
	bh=mjx4YuwQT5RG33y3PpbwfqnKZfaAWeAsTEj9n21RRe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kO5uITNI9myIQ0k3f07eFtE8ndCG7ElRLR/v8T5HVL5cYKU87jz1XIRKW8GEZFY/Dik/F8Oa/2WceATMtJGibc78J3UJnZJW5UGlnLRrbni4vTSO+FTd09gUDDhwyofOGmiM5koFXhrmL6V/2DsiKBqMP7rkZwxS5/lqvgv1LwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8NqGAHw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715100190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xZJS0dW3Vcgvju5+MtDkJV4kAwVzi3ExzNdfh26vvLg=;
	b=R8NqGAHwRb42b9wCwbDWyqM6aMZ3a3hyTtgy4JSbqb3sBm1nSG3jaiwoH7R+rDAPELUWd9
	0q5vLvaPi18/p5ri32J+g88LFL1GhVO3ZAkuRMVM4JWxvagGkNqe1EQH6yhfu4Q/8B1Ksj
	f0sCGOo8ZHQNbkW9xhP4LZhbxrcFn/8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-1nIKhEetMvKFbqHLkah8IQ-1; Tue, 07 May 2024 12:43:09 -0400
X-MC-Unique: 1nIKhEetMvKFbqHLkah8IQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2e30840a08bso15084511fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715100187; x=1715704987;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xZJS0dW3Vcgvju5+MtDkJV4kAwVzi3ExzNdfh26vvLg=;
        b=BzXgFW4nl+gRQtt/l1B6z0JS1SmpTdEoNUI0aNXDzNGTxWCPeIYyJHg4+xM5p4CnY1
         lDMKbVf/7M0aAIZj9BzzAwVRIs5QZubxz87u6YeJy+SmGEQ9x6wLQBwqyRVfOMhjtfzD
         Nh+siMg16ZBv7wipNbocti6t3elmlvyqc1nje54T5yGcv7KBhFZLfgHsO7+/N0sf02Xg
         rwXcr/Yq+uXBy5FjSDt9b7qUmha04hRA7mnpRGhqWxTmOlTsW3bh2ibI3Gz+exzg6F+4
         NWdB1/VGpsKbzlPgVoZFfAWBl9gspqKuGrjLxwaYwdK67teG6DSArYrAT59g8Yr6uaJ4
         DVzg==
X-Forwarded-Encrypted: i=1; AJvYcCWFgbqSDfoRtGbMjE2lZOYusIzNJFd2oEM/S/4Ht8+2MsnJchA1mZFPE6c9tPhwpTO1aYGJCB7vaj52SVKVxClMNWsyq20z2txJVwIT
X-Gm-Message-State: AOJu0YwShsutnCybaXImfcnoJjBWBbcbrdMUYDdQAKHE3FXcNh9xsjRf
	IrrX+RRsS26NZjktLvdWYE4vP/2um2ssFLK54QfSeLr+3e9s2NlzSBQV14al7lIJGr8rcL2gzfy
	QBjVmyh7GtPyrViq+e6ZdEE7IOl/1V4FeWGbpB1HDOBKpdc/UbbVeXvXqKaHJTA==
X-Received: by 2002:a2e:8049:0:b0:2d4:3d86:54e2 with SMTP id 38308e7fff4ca-2e44759fac7mr829861fa.27.1715100187502;
        Tue, 07 May 2024 09:43:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBACWDOBhJ4Ida3FQAnllpXrAgCNg9QdxIMNm5rkzQSOHZXnDwSakbnVctVOBT3xkftZBMQw==
X-Received: by 2002:a2e:8049:0:b0:2d4:3d86:54e2 with SMTP id 38308e7fff4ca-2e44759fac7mr829601fa.27.1715100186975;
        Tue, 07 May 2024 09:43:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:b500:3f9d:130d:ea00:afc7? (p200300cbc744b5003f9d130dea00afc7.dip0.t-ipconnect.de. [2003:cb:c744:b500:3f9d:130d:ea00:afc7])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b0041563096e15sm24206317wms.5.2024.05.07.09.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 09:43:06 -0700 (PDT)
Message-ID: <21d88422-7378-4a63-8fbf-f70889f309c1@redhat.com>
Date: Tue, 7 May 2024 18:43:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fault: speed up uffd-unit-test by 10x: rate-limit
 "MCE: Killing" logs
To: John Hubbard <jhubbard@nvidia.com>, Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>
References: <20240507022939.236896-1-jhubbard@nvidia.com>
 <016d8cff-efc3-4ef1-9aff-7c21c48f2d69@redhat.com>
 <302d50ac-45ff-470e-90a0-b349821706a6@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <302d50ac-45ff-470e-90a0-b349821706a6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.05.24 18:28, John Hubbard wrote:
> On 5/7/24 1:13 AM, David Hildenbrand wrote:
>> The patch subject is misleading. This should be "don't flood the system
> 
> I went back and forth on that subject line. :)
> 
>> log". Nobody cares about the speed of a unittest ;)
> 
> Yes they do. People should actually run the selftests, which in turn have
> enshrined their guidelines in kernel doc. See dev-tools/kselftest.rst,
> "Contributing new tests", which says, as you would hope, "Don't take
> too long".
> 
> It's important. Tests need to be quick, and having one out of 50 that
> blows it up is worth fixing.

I'm pretty sure you got my point: it's much more important to not let 
unprivileged users flood the log (possibly harming the system?) than 
making a test run faster :)

> 
>>
>> On 07.05.24 04:29, John Hubbard wrote:
>>> If a system experiences a lot of memory failures, then any associated
>>> printk() output really needs to be rate-limited. I noticed this while
>>> running selftests/mm/uffd-unit-tests, which logs 12,305 lines of output,
>>> adding (on my system) an extra 97 seconds of runtime due to printk time.
>>
>> Recently discussed:
>>
>> https://lkml.kernel.org/r/a9e3120d-8b79-4435-b113-ceb20aa45ee2@alu.unizg.hr
>>
>> See the pros/cons of using ratelimiting, and what an alternative for
>> uffd is that Axel is working on.
>>
>> (CCing Peter and Axel)
>>
> 
> That thread seems to have stalled.

Yes, there was no follow-up.

> I *do* have MCE experience (writing a
> handler,
> dealing with MCEs and related bugs), and what they wrote so far is exactly
> correct: if you were going to flood the log, then no, we don't need to see
> every single line printed. The first 10 or so, plus the fact that rate
> limiting
> kicked in, is sufficient to proceed with debugging and/or hardware
> replacement.
> 
> I'd like to just do this patch almost as-is, just with a fixed up subject,
> perhaps:
> 
>       x86/fault: rate-limit to avoid flooding dmesg with "MCE: Killing"
> reports
> 
> Yes?


Makes sense to me (and thanks for confirming that we don't need 
complexity elsewhere).

I think we at least need "Fixes:" (not sure if stable is warranted as 
well, 1b0a151c10a6d823f033023b9fdd9af72a89591b didn't CC stable).

Consider adding a link to the report in that thread.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


