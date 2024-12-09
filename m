Return-Path: <linux-kernel+bounces-438460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF3B9EA192
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E3D165DEF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1B119ADBF;
	Mon,  9 Dec 2024 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eol+A4Zc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E37078C9C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733781762; cv=none; b=LdTI4GP5m5YVP6v7aOHYkCi3IeT4nUhBSJdBmGP5RBDc1WKNJ1naQspB993KLIQ6rF0z2YWti0Fb/CjV1uh0hLa2FqaqrPAdpweBGXn3jmEdSX0ztCP9/kzFuCJhyGdPk77/cxjCOUB3G+6BLIJPijwvseVeVHMvx73oxEHDbpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733781762; c=relaxed/simple;
	bh=fljz3MwqXpTynEhbSsHTKbi9YAZSqAHGEhWh4gLRezU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORAs9LmOhBbrenloMqhKpQd9R02UhttSqicah7+3RfYMPuA4QwVMz9mhGZfvn+x2SQ5oDtPR8fixdH2Wgw5yP/tpV6pCQP3KQLYV8Es7UfRPsqE+EL8MQCPjfNQRchn2qO2M9xoPrhqlTYYLVQqREFOklGspjLumJL8wet+3JkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eol+A4Zc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733781759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TsS2265vrDbv04CtThatjQzm5h66DPxvB4Adkrjyppw=;
	b=Eol+A4Zc96txXDyAUCrQXkrfpU2mvb80tlC9gr6Pdk5U50IwLrIhJxcRDqHQekgAWLFOff
	12akYr9XczGTCl2vMU0ItMxCbBB2jJO2Lywiy4ulMV6LpW+Ngqn2SaSxFIsCBuHyo6c04E
	QIMJpXHKIpSXWcsWtAXee9i/UC1L254=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-7zgQbjcTPHWfSkB5QkZQIw-1; Mon, 09 Dec 2024 17:02:37 -0500
X-MC-Unique: 7zgQbjcTPHWfSkB5QkZQIw-1
X-Mimecast-MFC-AGG-ID: 7zgQbjcTPHWfSkB5QkZQIw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434f1084293so17608885e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 14:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733781756; x=1734386556;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TsS2265vrDbv04CtThatjQzm5h66DPxvB4Adkrjyppw=;
        b=nT/nqhB0ahbhLBoq3BP+fh7YyrlJsCbhlreyaa2xqslTMyvOUmBmzXiamny5djdfuB
         5H4NC8O5lBufxjHzE5hMkmD5wMc8GLf/alKzY9De3JYKeYYJs65dpkxNHMDgw1Jih5Fy
         NGjm3ZDYG5uBYwZPTzA8VyVP9OopKVQFHZLYfL6Fni6S5CiP7kQBjJJctZshzVIVxwJL
         /YsYKyn6KZU0jY1HqBkkZipIVZ77xcP6UsMGFhwou8k2gnFzM8hU7rz0Qwx188KuIC+x
         SpMWvaIkwcHWg4KovdAU/pZZ4x41jsABZY4gsjEtiP61A/e+va9hX9IycrH18BfV54Xj
         SsyA==
X-Forwarded-Encrypted: i=1; AJvYcCWlNMaBE5mqDRtnhPy6zx1+lfmvQS5Vj+68m9t5KMCO335QNSziqT6QuZvxuBKzcmJfPd5KaXIa8OS/gpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw071xIpuSgiAedHPLWbHOtXIKv7NZqzTObk8aYDQDOK7dVApCK
	AK0vR6N1N1zAlSxRJVGkhJgQFYAh3R8Zvhzfx22Xg4IiLE/fy8H59LeXVvA9aXdHQIyNrIpT0HM
	C8onMNfAUye7FQ7ApMtouRFxQY4UF99x1eRbF62sD2K34gyU4f4eRTBcMxCPe6w==
X-Gm-Gg: ASbGncu538McOOVzrnHM36PoFvU9mBeF7FbY+ooTHJ01/PSdwwWLrn5Im75bY6ED9Ps
	KR2HQvxWfFon+KzS4OxKUk7ydB5jo/7GV0S9GEWWZNXbLZ3PjJedn1hxcF1MbyLRyro+25SnehH
	tNWuGXhhVPQCpRcJNZqaa9DmUYX0+KDRMh/Im0ANKFdIB1Vy4jPaB15Q/kqUMR7u/e53L4ub13J
	/2Jtp1i2x5PqcUQKfT/GQmWq18+eNjfnYztOX5xel8V5udxFAnIbkGbggQB5q7dF7E5LV9XmUag
	BLgx5wUuIesjdE+r0I+kdoWU66dvOwUi103r/BM+eyHyF5izbfa9dw0Ihib4fErjrWPlGVTl9gJ
	Mfw==
X-Received: by 2002:a05:6000:1846:b0:385:f44a:a53 with SMTP id ffacd0b85a97d-3862b3337c2mr10359341f8f.4.1733781756686;
        Mon, 09 Dec 2024 14:02:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjehxbaHxG6nz35OIEd7nFaR7DU5XJeVrn2mnast93UGFteO7nY4RCDlTpCuD7j1BMBqr0mg==
X-Received: by 2002:a05:6000:1846:b0:385:f44a:a53 with SMTP id ffacd0b85a97d-3862b3337c2mr10359328f8f.4.1733781756292;
        Mon, 09 Dec 2024 14:02:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:2c00:7bfb:29fe:9e6f:2e65? (p200300cbc71b2c007bfb29fe9e6f2e65.dip0.t-ipconnect.de. [2003:cb:c71b:2c00:7bfb:29fe:9e6f:2e65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf42desm13954990f8f.15.2024.12.09.14.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 14:02:35 -0800 (PST)
Message-ID: <a3cacdde-8dab-4dcb-a720-9e00833ee9c1@redhat.com>
Date: Mon, 9 Dec 2024 23:02:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
 <23d3d7f6-d6d1-430e-8ea0-ccae76b253fd@redhat.com>
 <41a14051-75ee-4de3-863c-d0532aa7e3aa@suse.cz>
 <1e4c3e31-ea9a-4af4-83f9-15a882732e69@redhat.com>
 <71beb3d1-21ac-4037-8363-6484c0c333b8@lucifer.local>
 <CAG48ez2s2mY83uce9mGUgc61_50nOp9VPJKLHMtyRYTTeKpo=A@mail.gmail.com>
 <81fc4cd1-55f4-4569-aef7-0b0da9684fdf@lucifer.local>
 <af887f35-0831-4c7d-9f1d-bc857b52975b@redhat.com>
 <67ae2a5f-0c86-446f-a122-f14decdb84d3@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <67ae2a5f-0c86-446f-a122-f14decdb84d3@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> To me I politely disagree with the assessment made here, but if a senior
>>> member of the kernel objects of course I'll withdraw it.
>>>
>>> But yeah I don't think that's workable. We will just have to hope that we
>>> notice mremap changes that might be problematic going forward, I might
>>> therefore update my lei settings accordingly...
>>>
>>
>> I have the feeling you take this personally; please don't.
> 

Hi Lorenzo,

> Sure sorry it's text being a bad medium and this sort of thing _inevitably_
> being a fraught subject :)
> 
> I have a great deal of respect for you so my imagining that you might think
> I couldn't do things in this area was slightly shocking, but I suspect this
> is, in fact, on reflection, not at all what you meant.

Not at all. The key problem here is that we have MM systemcalls, that 
will involve multiple complex things. And the VMA handling is only one 
of these things IMHO.

For example, I suck at VMA handling and wouldn't ever put my name on the 
VMA section (vma.c). In contrast, I might consider myself a bit familiar 
with mprotect() and madvise() handling besides the struct vm_struct 
modifications.

And that was my point: the majority of the complex code in these files 
is not the VMA handling (as in vma.c). Whereby in vma.c and mmap.c it 
absolutely is.

VMA maintainers reviewing (and people expecting them to ack/nack!) 
madvise() changes like MADV_COLD that really do nothing relevant with 
VMAs is not particularly helpful.

I am also not a big fan of having too many maintainers listed, because a 
file ends up falling into multiple sections -- how should a submitter in 
the end know which ack actually counts, and which are required etc.

Maybe we can find a better way to structure things (either in the 
MAINTAINER file or code-wise).

Or maybe I am just wrong.

(many of our files are currently structured around syscalls, and then as 
explained, there is mm/huge_memory.c where we dumped some other parts)

> 
> So sorry, I don't intend for this to be anything other than a functional
> converastion to determine how best for us to manage workload and avoid
> issues in future.

Sorry for misleading you.

> 
> If you see my other mail with suggested ways forward, hopefully one of
> those will help ensure appropriate separation and distribution of
> workload/responsibility (am of course also open to whatever you might
> suggest!)
> 

Yes, I'll try taking a look tomorrow.

>>
>> Maybe my other mail with "VMA users" vs. "basic VMA functionality" makes it
>> clearer what I mean.
>>
>> For example, mm/userfaultfd.c also performs VMA modifications. kernel/fork.c
>> does a bunch of that. I neither think these should go under VMA nor that it
>> should be split up.
> 
> Yeah and I _hate_ that. I mean talk to me about fs/userfaultfd.c, but maybe
> only after a few pints :) Or bits of mm that live in fs, but vma-related
> and not...
> 

:)

> But these are areas to fix.
> 
>>
>> Maybe there is a better way to split up things or rework the code; likely
>> we'd want this code that works on VMAs to have a clean interface with the
>> core vma logic in vma.c, if the current way of handling it is a problem for
>> you.
> 
> I think we probably need a compromise for the time being, and as I was
> saying to Jann I don't think it makes sense really to separate the VMA and
> page table bits from these files _except_ when we finally have a shared
> page table interface that we've spoken about before and perhaps we will
> collaborate on in future :)

In fork.c we split out the page table bits (into mm/memory.c), but left 
the VMA bits in there ... :)

> 
> The key point is so we avoid stepping on landmines when we discover
> something was merged in file X which we weren't cc'd on that breaks core
> feature Y we have been working on in the VMA part of the code.

In my experience, tracking files is not particularly helpful. People 
will still not CC you, or do nasty stuff in files you are not tracking.

What I do is (well, besides screening most of linux-mm), is have a list 
of magic names/keywords, and tag the mails.

This way, when someone uses the magic "COW" keyword, for example, or 
calls mapcount functions, I get them put into a separate folder where I 
can just briefly sanity check them.

-- 
Cheers,

David / dhildenb


