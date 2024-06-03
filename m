Return-Path: <linux-kernel+bounces-199714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621CF8D8B35
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1793428AB42
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323DE13BAE9;
	Mon,  3 Jun 2024 21:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0/M/ZQ6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2D913B2AF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 21:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717448503; cv=none; b=GzztsMk74xsn/c60HlAE/2vst7EAcIMwzLr+mchgNgj1iAFd2QO9oaoLK8CNvSCVlgmqHKVHra2C6cQ6PlIunQ49FKEzW95Y79Twhnx/yYBvaHubo9LEDT+B8ExLt74QyOeWDyzUyYtpKRF827Co8AhWWmDVjgdyE4UxNzQyhbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717448503; c=relaxed/simple;
	bh=IPLvG6GtiKpTbZhPiJC7QQD3cAHBms096wQ1qnicmjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e681LFjZTXQcrjwBU3bB5E+kJNztJDzmB+H5HLmBezrpmTrimEkpEHnlWIzBg9kJl7QvBdKmo8S7PNSLvTtzt9Bq7ksQFRaNPawwK050EWZETB7/LGN7y/VCYEM5JdvAH/CwtwIu6R593UdWYqJUB5yEG2R+hX6VYWzPcLPZ9iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C0/M/ZQ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717448500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TYMniZYAAwg3Cq0jpKihfOPhv7/EgsD1OzY4yWwvPQ4=;
	b=C0/M/ZQ6Vc5X9vCcLxu8LP4XF+1mvGfNMex85wnPEBwqQ7ElP9OpLfm2T53O5GLA6CQlTj
	Gy/tOfSC4ek0OlTqoKTNUGQhb6wYs9oQBh02Rfzy62KirIicwhZK1grWGLRl/1Z7/zccB9
	NfPl8to/U76nTMwxapEoNLRYILphSnE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-GpGlaDJZNHiwJUE3zZpQxw-1; Mon, 03 Jun 2024 17:01:38 -0400
X-MC-Unique: GpGlaDJZNHiwJUE3zZpQxw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52b88765386so245301e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 14:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717448497; x=1718053297;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TYMniZYAAwg3Cq0jpKihfOPhv7/EgsD1OzY4yWwvPQ4=;
        b=A9VdKGeEmfIXtkx+Ck0/lPkwmweDR6uLcpdBbg+/6t2IptBBc12cqmdBWieDmmMthR
         yS7/JiLsUT5K8m0W3UwBKZLe1ekWeoVsLN2ebu1autNaq/9+WomebBexYInzt4/TskFm
         pAbezXWdDP9L3DDTjYs+d+Hh6TTCMb6+jIYsjFT6Uryg3/4Op/cCF9IhLPG11hggm7dP
         g5+lFtWjpo1z/ELff5mNzlMEu5N0ycBU42Fsh84CbTSOGlH0zuFMtrI4JTgHWCJGK/0h
         Mknk5N/2mlucV6Ai0LzMZIkryiNG2KbPHKxsCnx3K540LMLDFzoReYtA3vpqgEod8Ze9
         XU8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRqAGdAr0AsBm9wvTb36fZZskNdpDch7zWlp7Gmc2XUEPSEf3oJAODa0QER+0I9bsVUqgN42iiMSsC7Cx7kPPSiFoYSKzzHZZ10yy1
X-Gm-Message-State: AOJu0YwXX3dWSOOcbKzWT11wf+rZolU+VW+uqHJKfQhawT/YtJ0VkJ2H
	ebZ2uGndxr7qPIdJTQLLljYlfSu6Xy//H7dnpnPT3kAeIJ6AbHQaCfbsA2RS5kaI16QxgP60tUQ
	PT0Zjb4GNYLL8UvIPtO8jop+sjxNrp0KXUiY+lIi0e4cSr5g0ox6kBMNeXQY0qKh0kFYk3w==
X-Received: by 2002:a05:6512:32a8:b0:520:9df8:f245 with SMTP id 2adb3069b0e04-52b89569473mr6802032e87.1.1717448497259;
        Mon, 03 Jun 2024 14:01:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0XsEA9zCnAtPum6WJJeT/Gc4XcwY5PnR4W9Geq7R9qt1d6PbddMfGbPh58U3kDaMsrdvVEQ==
X-Received: by 2002:a05:6512:32a8:b0:520:9df8:f245 with SMTP id 2adb3069b0e04-52b89569473mr6802015e87.1.1717448496664;
        Mon, 03 Jun 2024 14:01:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c731:3d00:918f:ce94:4280:80f0? (p200300cbc7313d00918fce94428080f0.dip0.t-ipconnect.de. [2003:cb:c731:3d00:918f:ce94:4280:80f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04ca981sm9693509f8f.33.2024.06.03.14.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 14:01:36 -0700 (PDT)
Message-ID: <b7397644-1e02-4ed3-935b-0daeef7faa31@redhat.com>
Date: Mon, 3 Jun 2024 23:01:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] efa7df3e3b:
 kernel_BUG_at_include/linux/page_ref.h
To: Yang Shi <shy828301@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, kernel test robot <oliver.sang@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Rik van Riel <riel@surriel.com>,
 oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Christopher Lameter <cl@linux.com>,
 linux-mm@kvack.org
References: <202405311534.86cd4043-lkp@intel.com>
 <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
 <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com> <ZlpcRnuZUEYJJ0JA@x1n>
 <CAHbLzkrRw-xf819gYJwRQ=-u971LQYnB2FNJMkN=s6u-pJ4Z8g@mail.gmail.com>
 <CAHbLzkoB+oFTxtVYpeXQvko2q9HUVzUYrr83S6M6PUmXDQpkag@mail.gmail.com>
 <0edfcfed-e8c4-4c46-bbce-528c07084792@redhat.com> <Zl3cakfiRsPQDb8q@x1n>
 <8da12503-839d-459f-a2fa-4abd6d21935d@redhat.com> <Zl4m-sAhZknHOHdb@x1n>
 <9d9a5730-161b-4a9d-a696-1cf6d0c5123c@redhat.com>
 <CAHbLzkq=SAkA1qRoF6f6HYJ80jxSrnJ=H=c=2voV4TLA=F=10Q@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAHbLzkq=SAkA1qRoF6f6HYJ80jxSrnJ=H=c=2voV4TLA=F=10Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.06.24 22:44, Yang Shi wrote:
> On Mon, Jun 3, 2024 at 1:38 PM David Hildenbrand <david@redhat.com> wrote:
>>
>>>> try_get_folio() is all about grabbing a folio that might get freed
>>>> concurrently. That's why it calls folio_ref_try_add_rcu() and does
>>>> complicated stuff.
>>>
>>> IMHO we can define it.. e.g. try_get_page() wasn't defined as so.
>>>
>>> If we want to be crystal clear on that and if we think that's what we want,
>>> again I would suggest we rename it differently from try_get_page() to avoid
>>> future misuses, then add documents. We may want to also even assert the
>>
>> Yes, absolutely.
>>
>>> rcu/irq implications in try_get_folio() at entrance, then that'll be
>>> detected even without TINY_RCU config.
>>>
>>>>
>>>> On !CONFIG_TINY_RCU, it performs a folio_ref_add_unless(). That's
>>>> essentially a atomic_add_unless(), which in the worst case ends up being a
>>>> cmpxchg loop.
>>>>
>>>>
>>>> Stating that we should be using try_get_folio() in paths where we are sure
>>>> the folio refcount is not 0 is the same as using folio_try_get() where
>>>> folio_get() would be sufficient.
>>>>
>>>> The VM_BUG_ON in folio_ref_try_add_rcu() really tells us here that we are
>>>> using a function in the wrong context, although in our case, it is safe to
>>>> use (there is now BUG). Which is true, because we know we have a folio
>>>> reference and can simply use a simple folio_ref_add().
>>>>
>>>> Again, just like we have folio_get() and folio_try_get(), we should
>>>> distinguish in GUP whether we are adding more reference to a folio (and
>>>> effectively do what folio_get() would), or whether we are actually grabbing
>>>> a folio that could be freed concurrently (what folio_try_get() would do).
>>>
>>> Yes we can.  Again, IMHO it's a matter of whether it will worth it.
>>>
>>> Note that even with SMP and even if we keep this code, the
>>> atomic_add_unless only affects gup slow on THP only, and even with that
>>> overhead it is much faster than before when that path was introduced.. and
>>> per my previous experience we don't care too much there, really.
>>>
>>> So it's literally only three paths that are relevant here on the "unless"
>>> overhead:
>>>
>>>     - gup slow on THP (I just added it; used to be even slower..)
>>>
>>>     - vivik's new path
>>>
>>>     - hugepd (which may be gone for good in a few months..)
>>>
>>> IMHO none of them has perf concerns.  The real perf concern paths is
>>> gup-fast when pgtable entry existed, but that must use atomic_add_unless()
>>> anyway.  Even gup-slow !thp case won't regress as that uses try_get_page().
>>
>> My point is primarily that we should be clear that the one thing is
>> GUP-fast, and the other is for GUP-slow.
>>
>> Sooner or later we'll see more code that uses try_grab_page() to be
>> converted to folios, and people might naturally use try_grab_folio(),
>> just like we did with Vivik's code.
>>
>> And I don't think we'll want to make GUP-slow in general using
>> try_grab_folio() in the future.
>>
>> So ...
>>
>>>
>>> So again, IMHO the easist way to fix this WARN is we drop the TINY_RCU bit,
>>> if nobody worries on UP perf.
>>>
>>> I don't have a strong opinion, if any of us really worry about above three
>>> use cases on "unless" overhead, and think it worthwhile to add the code to
>>> support it, I won't object. But to me it's adding pain with no real benefit
>>> we could ever measure, and adding complexity to backport too since we'll
>>> need a fix for as old as 6.6.
>>
>> ... for the sake of fixing this WARN, I don't primarily care. Adjusting
>> the TINY_RCU feels wrong because I suspect somebody had good reasons to
>> do it like that, and it actually reported something valuable (using the
>> wrong function for the job).
> 
> I think this is the major concern about what fix we should do. If that
> tiny rcu optimization still makes sense and is useful, we'd better
> keep it. But I can't tell. Leaving it as is may be safer.

Willy moved that code in 020853b6f5e and I think it dates back to e286781d5f2e.

That contained:

+       /*
+        * Preempt must be disabled here - we rely on rcu_read_lock doing
+        * this for us.
+        *
+        * Pagecache won't be truncated from interrupt context, so if we have
+        * found a page in the radix tree here, we have pinned its refcount by
+        * disabling preempt, and hence no need for the "speculative get" that
+        * SMP requires.
+        */
+       VM_BUG_ON(page_count(page) == 0);
+       atomic_inc(&page->_count);
+


-- 
Cheers,

David / dhildenb


