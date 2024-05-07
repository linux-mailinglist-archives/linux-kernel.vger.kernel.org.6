Return-Path: <linux-kernel+bounces-171917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3668BEA93
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62069B2123E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E650216C6A0;
	Tue,  7 May 2024 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHx/YF9z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89CDE570
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715103193; cv=none; b=YlWf/bsJ2ZvhzWRqlw7vp0txcpv44m+N61zbX5q+sZQNWD0MWTqoKFUUEF8gyKbAQYNSDYPAaCU6VmDiLBODLck2VqTksMG9IgFwvsUcfDsTssvXO7ycRvKMHOyw6LUPg/AjuCenlQQW5p9GO84cE+3mL8CTMika46rOCcO28v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715103193; c=relaxed/simple;
	bh=VnJBAbOCa52ViZa6L66uVdwwdZWSOWVuvuOZFZ6Jcr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2EhAqAEQDFhc5PBzNgI3pMRRS8aAgAFslpozYRM6Cq37T4aj5XL4onAKBWaljxY7HQlIHG4bTAOLVS3wR8GmWU5xapDfEJKEmaQpI6uWMd24bcAmd0umtVL+AoB8/3pym4lr9NEGfgM9D2noNGsAtxofbtkwIA8OVb4Is+ck48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHx/YF9z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715103190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=09efpo39bRTC3YRJfTZglKjlMT81zzvkrh+B3AsQjGU=;
	b=FHx/YF9zrCkThhxT50ZBrw3oFY7h770V/7rkBq1zsEgxWxlppFVrhx9Sjy/77Rlg7BoQJv
	7KxlDX10FVnQ4RWeivSgkQeOzh3nti8p796cIp2GDegP0cSLoVhcEYupFGdXO5VGT4EAhb
	t2808FRa58jazCGjqKwO4/LWwY0WF1Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-RWHH9JhNPqW2E9cUp9S00g-1; Tue, 07 May 2024 13:33:09 -0400
X-MC-Unique: RWHH9JhNPqW2E9cUp9S00g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-416ac21981dso18181595e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 10:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715103188; x=1715707988;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=09efpo39bRTC3YRJfTZglKjlMT81zzvkrh+B3AsQjGU=;
        b=OCyPpAGIVoMlC3NgwcimJQVqINPK8WtIGOg7xdyGpLTbh6RSrxMqM+ImNqqfu4RSAN
         CG7fcSlMw9BhsTNRjvOl1l7Kw9PGIcgqP5eJHN69m99L2HQM7lXx36fwDaDZTj8AfstT
         Y/8uYixCeSlgarN7VHZe0OVXSuVP0SV6eZnN5ofBjjR2E1pmaMnKpB7bZrhz9GX1V2ZR
         hQ8j6o9nBDF3J4/M74YKbtbnQdZGQN1XKyFEOXAtWW2qsYfwtm+sDpRt9c5+YK8mKd/O
         a/kF7cDT40YmqFJi3JtOkud1O/P6FIa7jwcbQJv6MTNZb9X1kK0ixbBtvvDnciNhmxnG
         YMRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/fJcMK38u2GO4Y1lR6MB2iU6EdCo3XjWY71CXt/PGziBcjSIfMCFkNvj78V2+Qw2dGbZno27iOUKp3dXJ6Xp6kHR47ppbsk5rAxMZ
X-Gm-Message-State: AOJu0YyuCV+oQUdHlo+hF9SA9KSpOK77pOFM7jNRbkh5OrxrqiqhZgvd
	4axKbzOFENJjXmgSLYwuO96t00NEcvrx91pCxMSG1JaX1oeRy35yfKJBgYqYFxt6fVX13QY4fvl
	LDC8CqkmKECcqmAOcEKn/g4V2lofTDv0jdUhebxKRIAaLy59vGAdwiP9EOnfAOw==
X-Received: by 2002:a05:600c:4fc8:b0:419:f4d6:463b with SMTP id 5b1f17b1804b1-41f2da2d4d4mr31857595e9.14.1715103188022;
        Tue, 07 May 2024 10:33:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIWSUqs1NaxcXrbJQR/i6OexHnw8CC3YkNSn4f2ipAhOc8cmI7QZJt3f3w2JGPuN6s4xslbA==
X-Received: by 2002:a05:600c:4fc8:b0:419:f4d6:463b with SMTP id 5b1f17b1804b1-41f2da2d4d4mr31857255e9.14.1715103187534;
        Tue, 07 May 2024 10:33:07 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6166.dip0.t-ipconnect.de. [91.12.97.102])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b0041563096e15sm24328825wms.5.2024.05.07.10.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 10:33:07 -0700 (PDT)
Message-ID: <19645506-f17d-4202-807e-f0e5c99af742@redhat.com>
Date: Tue, 7 May 2024 19:33:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: Andrew Morton <akpm@linux-foundation.org>,
 Lance Yang <ioworker0@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, willy@infradead.org,
 sj@kernel.org, maskray@google.com, ziy@nvidia.com, ryan.roberts@arm.com,
 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 libang.li@antgroup.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240501042700.83974-1-ioworker0@gmail.com>
 <20240501042700.83974-3-ioworker0@gmail.com>
 <cc9fd23f-7d87-48a7-a737-acbea8e95fb7@linux.alibaba.com>
 <CAK1f24kyCj2Svguuu07wDuVEWYYbcmRc_18ihgVAzSjoJ9ox2A@mail.gmail.com>
 <a8f7a8da-c2e1-443c-9220-a224d97b1c81@redhat.com>
 <CAK1f24=rWdgscbDa6pMqOmTEDOHVLo5NQ=7jOo9TdyJRXahHZg@mail.gmail.com>
 <20240507102241.0a09db69afd62efb5ce84f17@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240507102241.0a09db69afd62efb5ce84f17@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.05.24 19:22, Andrew Morton wrote:
> On Tue, 7 May 2024 16:38:07 +0800 Lance Yang <ioworker0@gmail.com> wrote:
> 
>>>> Yep, I'll also set pvmw.ptl to NULL here if any corner cases arise.
>>>>
>>>
>>> This series already resides in mm-stable. I asked Andrew to remove it
>>> for now. If that doesn't work, we'll need fixup patches to address any
>>> review feedback.
>>
>> I'll patiently wait Andrew's response, and then submit the next version or
>> fixup patches accordingly.
> 
> Well, which series are we talking about?  "mm/madvise: enhance
> lazyfreeing with mTHP in madvise_free v10" or ""Reclaim lazyfree THP
> without splitting v4" or both?

See my other mail, "mm/madvise: enhance lazyfreeing with mTHP in 
madvise_free v10" is all acked/reviewed and good to go.

> 
> And how significant are the needed fixup patches?
> 
> And what is our confidence level after those fixups are in place?

I'm afraid I won't have time to review this series this/next week, so I 
cannot tell. I already assumed this would not be 6.10 material.

-- 
Cheers,

David / dhildenb


