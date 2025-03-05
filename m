Return-Path: <linux-kernel+bounces-547608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFD5A50B90
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C5F3AF78C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C11523027C;
	Wed,  5 Mar 2025 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVhMDqwI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB9D78F3A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203349; cv=none; b=kjsctSO564vJv/ijXr9B9qlNABrEUczUhyqtoxOlATiOWunMGVwOUT4xNOCxGfb9DHWmdl5EePPYivWn9gVAJ4Ir9SC5rxF5DIRrZr3+zAcAXJNXzDVa1RhTZP6OsP0k0MQO7SPlPch2ZXhGjZsllbV80MVnLZXpo8Oo4Z3lVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203349; c=relaxed/simple;
	bh=IC3+U9JNhJyiVBTHk5QNHp8oY/Ss/nsta9eRXdQVChI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0y04RY4Kqh5e1pEd+u+FiaWPKa4DEGKCqdvdSfVXKgj9e69i8T6qCH7saP8XeQVuqt4Om9yvCLneVZSt5mIRyZ6xErTJi0hZPamHVyIWxWVe/ehHbOmbg5INuwNLCbzHdwzOnIAiI1L6sOASNmkCfQ/E76Mr8BaTvPtT/lk2Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVhMDqwI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741203346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Z30FTZj7gdsdVzcf6GlPnvMHkjnOzwx2rv8igST/6co=;
	b=CVhMDqwIGkzhGuE86+421C9ptVmV2OJm9iMkGVMWTPiouSfH5PVauXyAd88nttJcUmfiQt
	D6AlbuIBuP3awvW9mTUZIg/6l1nxaboDbdSdeH5HHS09VPoU69wyHloAm2b620ZGxuFbG7
	WvZwlt/pi3tL7ohoVJRCu88elgyZLlE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-4W0FJTDTMJKO20dhJ0R7-w-1; Wed, 05 Mar 2025 14:35:40 -0500
X-MC-Unique: 4W0FJTDTMJKO20dhJ0R7-w-1
X-Mimecast-MFC-AGG-ID: 4W0FJTDTMJKO20dhJ0R7-w_1741203339
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39123912ff0so416016f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203339; x=1741808139;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z30FTZj7gdsdVzcf6GlPnvMHkjnOzwx2rv8igST/6co=;
        b=BzjAvfzK7wzHRMXrgqm5BjXz1CSWZZuQA/R6c0LI7FDb1EXx5FsYz5GAH+9emgN++N
         EpYRCE8ZUh/IcSjjT5kWyRvBK0trnHRPEshk+hjsBAXurTWMESwHY6mTcIOULow3G8b8
         m/zfyudy3osGoifC0WGeO5OUROwvsMlGE8UQE+HbnEXpcC3RTB+D+T1BpYVfm+nOtUsJ
         wKKVwFYBWKaVm7toJB0yR0y5GV9FHRp2dqfc1dV2M0CvSqLwYU09S/Uv3o+kSE2av/+v
         czmbn+nowsGqJ1Y7YEvVAs2UJKj9TIrY72I17FVRf1s8jGYQJeALy5/pQKpuWJm8nE3q
         +IvA==
X-Forwarded-Encrypted: i=1; AJvYcCWv+DZDVsu/K6cI/rY5TSlvkkwBGjbOTsnNhpTuTxPn+UJpNHrQvL3YNVouX3chpcB8FGr6enw54BRhPyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNl2VsCGMzFkxT1Cd51Xc6qqiD8HO3cuJ8uZRF6Nyy96sO2A3u
	qOxauClCag6kZB8o6Nk5VuEbz262L8H/0Ir4jx0sOiJBeV/U0v5a4g1cPZToMmOTXcdxAx7dkxA
	QMWhBypRRIhwJKDgEmkZb9BCQtr2Y5YGsb8Y2Ywvs9W+mzOllz5enXAxmu4URhA==
X-Gm-Gg: ASbGncsZKzLsDyLWCXqLcsyk92joAw1dNJABT0PoJ0Haz4dOToIKJR70yHuUi7jFY0/
	6n88lfmHyMt3KMXpJn419mqFE0fDEYsqrXY4hhf8Ju9/ojP9C1g5mFkVLkAs2QB1gXpKjS0C8z4
	u87ujkC106aa88wtWLQoS0MZ/6qVBG/XpKA29ufrbYR2cqOXP7o6Cvxk8GphRfjEun/3GgqXVIN
	Z/WAiAdGYozLXiHdN6p2yQuQg/BvFU6QIIrAbg9J+SBELXVa2/ro9rQOcJ6xPIdr2bzPkG65jvL
	1F3yfn6ixWryZjhjz3+kzANyYU+Rh/y5Hvvbtr9g5nnXd2Z46Pp/4s2/v+Vub05Il2x4n+gobpX
	tsYUjdgiJLIu1RbeyjG+db1Zm485+Nw/3rqYQUzKQqto=
X-Received: by 2002:a5d:64e3:0:b0:391:1806:e25c with SMTP id ffacd0b85a97d-3911f740541mr3524724f8f.17.1741203339109;
        Wed, 05 Mar 2025 11:35:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGD4SRn/gcrJ/xOZzRBjI1bFcRUWMd15cXXSg1hQ+M/Y9rvTLesfg4q3lBfUNCJnDO8Xd1+Bw==
X-Received: by 2002:a5d:64e3:0:b0:391:1806:e25c with SMTP id ffacd0b85a97d-3911f740541mr3524709f8f.17.1741203338777;
        Wed, 05 Mar 2025 11:35:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:5b00:84f2:50f3:bdc8:d500? (p200300cbc7395b0084f250f3bdc8d500.dip0.t-ipconnect.de. [2003:cb:c739:5b00:84f2:50f3:bdc8:d500])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6a78sm21534902f8f.23.2025.03.05.11.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 11:35:37 -0800 (PST)
Message-ID: <f63146c0-0316-4182-9a62-48dfc39f27b7@redhat.com>
Date: Wed, 5 Mar 2025 20:35:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/16] mm/madvise: batch tlb flushes for MADV_DONTNEED
 and MADV_FREE
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, SeongJae Park <sj@kernel.org>,
 "Liam R. Howlett" <howlett@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250305181611.54484-1-sj@kernel.org>
 <Z8ieZVFEa6vAouvu@casper.infradead.org>
 <46960f37-0d12-4cfd-a214-1ddae2495665@redhat.com>
 <8c7714ca-a766-4a07-bfdc-f1d91aee379d@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8c7714ca-a766-4a07-bfdc-f1d91aee379d@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.03.25 20:26, Lorenzo Stoakes wrote:
> On Wed, Mar 05, 2025 at 08:19:41PM +0100, David Hildenbrand wrote:
>> On 05.03.25 19:56, Matthew Wilcox wrote:
>>> On Wed, Mar 05, 2025 at 10:15:55AM -0800, SeongJae Park wrote:
>>>> For MADV_DONTNEED[_LOCKED] or MADV_FREE madvise requests, tlb flushes
>>>> can happen for each vma of the given address ranges.  Because such tlb
>>>> flushes are for address ranges of same process, doing those in a batch
>>>> is more efficient while still being safe.  Modify madvise() and
>>>> process_madvise() entry level code path to do such batched tlb flushes,
>>>> while the internal unmap logics do only gathering of the tlb entries to
>>>> flush.
>>>
>>> Do real applications actually do madvise requests that span multiple
>>> VMAs?  It just seems weird to me.  Like, each vma comes from a separate
>>> call to mmap [1], so why would it make sense for an application to
>>> call madvise() across a VMA boundary?
>>
>> I had the same question. If this happens in an app, I would assume that a
>> single MADV_DONTNEED call would usually not span multiples VMAs, and if it
>> does, not that many (and that often) that we would really care about it.
>>
>> OTOH, optimizing tlb flushing when using a vectored MADV_DONTNEED version
>> would make more sense to me. I don't recall if process_madvise() allows for
>> that already, and if it does, is this series primarily tackling optimizing
>> that?
> 
> Yeah it's weird, but people can get caught out by unexpected failures to merge
> if they do fun stuff with mremap().
> 
> Then again mremap() itself _mandates_ that you only span a single VMA (or part
> of one) :)

Maybe some garbage collection use cases that shuffle individual pages, 
and later free larger chunks using MADV_DONTNEED. Doesn't sound unlikely.

> 
> Can we talk about the _true_ horror show that - you can span multiple VMAs _with
> gaps_ and it'll allow you, only it'll return -ENOMEM at the end?
> 
> In madvise_walk_vmas():
> 
> 	for (;;) {
> 		...
> 
> 		if (start < vma->vm_start) {
> 			unmapped_error = -ENOMEM;
> 			start = vma->vm_start;
> 			...
> 		}
> 
> 		...
> 
> 		error = visit(vma, &prev, start, tmp, arg);
> 		if (error)
> 			return error;
> 
> 		...
> 	}
> 
> 	return unmapped_error;
> 
> So, you have no idea if that -ENOMEM is due to a gap, or do to the
> operation returning an -ENOMEM?
 > > I mean can we just drop this? Does anybody in their right mind rely on
> this? Or is it intentional to deal with somehow a racing unmap?
 > > But, no, we hold an mmap lock so that's not it.

Races could still happen if user space would do it from separate 
threads. But then, who would prevent user space from doing another 
mmap() and getting pages zapped ... so that sounds unlikely.

> 
> Yeah OK so can we drop this madness? :) or am I missing some very important
> detail about why we allow this?

I stumbled over that myself a while ago. It's well documented behavior 
in the man page :(

At that point I stopped caring, because apparently somebody else cared 
enough to document that clearly in the man page :)

> 
> I guess spanning multiple VMAs we _have_ to leave in because plausibly
> there are users of that out there?

Spanning multiple VMAs can probably easily happen. At least in QEMU I 
know some sane ways to trigger it on guest memory. But, all corner 
cases, so nothing relevant for performance.


-- 
Cheers,

David / dhildenb


