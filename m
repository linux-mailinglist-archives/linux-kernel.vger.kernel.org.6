Return-Path: <linux-kernel+bounces-202146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C40588FC852
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B8E1F2646A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7643718FDD3;
	Wed,  5 Jun 2024 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neUR0Jq6"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B15E18FC94
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580955; cv=none; b=sXXMvGUbUopnq+oqcHKYaYLWYi/nrEB7u/s8vuF1RhqKVPBp4pIupSPHcFPowjWLRZzihyWbcpwpvXyIvcIVXjox/I9tBB3aiOeBtoO98OrUn/mdmfas2CJS4KbWd3yHWidStUnSLuCTQFVohA2fts7IyRiNJK03irlNXWFnEUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580955; c=relaxed/simple;
	bh=hOLNcDZCGKgSDU33PfDe6Z4+0rMSUeoTuhlzo6cZC6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B7eMJEyfMC4HD2lmr1aZ2lSxbv9Ea7UNfN8FmOBmHqAQRurVXdGjgVp7ydtqJlBn+ANzjEpCBG6DHdewgMHHFCwFmL/+RY68zu32AwYnSNG8QSvlNxAGK+Nk25zqJ7YVT+QZVZN2xLywyGUizuX7NNaP/6KW24fa9KgiyGgwSeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neUR0Jq6; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ba6c41e1a7so919019eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 02:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717580953; x=1718185753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gBpE7UiCHuApO7sKV5bJ6IlGQVWs8dFL+WzC3J5powo=;
        b=neUR0Jq6whR8kObrrXfdZkwSQM7pUxsBLaMPON55bTDny5GwuzxredEnyny1uuWoHj
         ulUUwZUIHl/i6A6SrhnRCBaoEHBpSL0rCR02Ve9FE0WR5GnFq9nV0EaJHj6lF3FsZQeE
         mN7FXsvqpYFjDIKgSzSSXXGCsP/OpKI/c8NKAsXUqh9h6md04bzAxbQ5GeeoGP+IYu6W
         aJ+mplUY6qtKHPrPPItI6NLYEVEWhTIJytFlRNi+GG5PYkmh8D5m2aKKngFsJMlZSxdS
         yVelDpx1rCbj3E2MEUvAqe7sbNTNccvPsHbag0xOqcUsj+MQKNDfnviQut+lJ8ssoz0d
         FdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717580953; x=1718185753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBpE7UiCHuApO7sKV5bJ6IlGQVWs8dFL+WzC3J5powo=;
        b=GyqVqvedGMAJsefc7ubpFUx6oZznuVg7az71dOHiiKMBK3Xb+qt3K8jys4xpzXWFi1
         v74i2CAk+Lhc5qb/X/Zztb4vQhBfacp1nJnVyNVniJhlY8IMoXMzcWGUgi4ocHA8NIiA
         NIhZhMNqt4jN8IGYXdchjkzim2minuetMDTpkCJCEVBmxWmy7yE7048SCBk/BxfQiO9Z
         yKuQDDXn9Oi0/3NCIx9X74HRN01OFZOiuA8nr+N6JmsJyrbaB+O9kz/lNjuQWDxvcngK
         sT/TJOlEjTq9O5X+NJC2vrFEZcojdc9GBUCipddCWYVGHNvcFHAtK236rCr7rRxyqaur
         oUTw==
X-Forwarded-Encrypted: i=1; AJvYcCUWi3aAh1wf2/aXjmM4eC4xAo+gn7NCqKvFiiVVQVa5ZPyANOC/eUZQ8a0xl4W3d0kejCbiOEmFvy1ufSjspgFQiVJK/u8A0QbECcrE
X-Gm-Message-State: AOJu0Yw9abhzpU+MNW1Q4uDPZ0qhPwd/MggdDX3n1lM/DX1Tz8ffMl60
	AqarywZiD9j5f416Ivzd6ypVAP+6/uVQBmXimgjBQRF9Gp5oVeX/
X-Google-Smtp-Source: AGHT+IEcOXkFEFOaMDaacHQ5vyKJ033GOf8ZPTGEtTmQcafQv5JFPfsnd6BIPsj17eC1ydBaMu4tbQ==
X-Received: by 2002:a05:6358:7e45:b0:196:ecaf:a54e with SMTP id e5c5f4694b2df-19c6ca12483mr217805455d.29.1717580952997;
        Wed, 05 Jun 2024 02:49:12 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4b973csm7000813a12.79.2024.06.05.02.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 02:49:12 -0700 (PDT)
Message-ID: <1a4f8984-e262-4611-81ec-6ea12fa5b20d@gmail.com>
Date: Wed, 5 Jun 2024 17:49:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm/ksm: reduce the flush action for ksm merging
 page
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-2-alexs@kernel.org>
 <9ca730ce-2b2f-42d2-8c7a-78735a995c64@redhat.com>
 <4d299245-3166-4810-b22b-2a5b4f54a049@gmail.com>
 <7c6ae2a3-8ec3-4c9b-81c3-125f6973f0f3@redhat.com>
 <d059e397-beea-43dc-8c58-d7833b1d8bd4@gmail.com>
 <59921e08-d0f1-4bc8-acee-368a978286a4@redhat.com>
 <a3942479-764f-4e19-8b90-682fa56c8e20@gmail.com>
 <41130a02-80cc-4ee4-89ab-e889844a35f7@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <41130a02-80cc-4ee4-89ab-e889844a35f7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/5/24 5:14 PM, David Hildenbrand wrote:
> On 05.06.24 11:10, Alex Shi wrote:
>>
>>
>> On 6/5/24 3:26 PM, David Hildenbrand wrote:
>>> On 04.06.24 15:02, Alex Shi wrote:
>>>>
>>>>
>>>> On 6/4/24 6:45 PM, David Hildenbrand wrote:
>>>>> On 04.06.24 12:26, Alex Shi wrote:
>>>>>>
>>>>>>
>>>>>> On 6/4/24 4:07 PM, David Hildenbrand wrote:
>>>>>>> On 04.06.24 06:24, alexs@kernel.org wrote:
>>>>>>>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>>>>>>>
>>>>>>>> We can put off the flush action util a merging is realy coming. That
>>>>>>>> could reduce some unmerge page flushing.
>>>>>>>> BTW, flushing only do at arm, mips and few other archs.
>>>>>>>>
>>>>>>>
>>>>>>> I'm no expert on that flushing, but I thought we would have to do the flushing before accessing page content -- before calculating the checksum etc.
>>>>>>>
>>>>>>> Now you would only do it before the pages_identical() check, but not when calculating the checksum.
>>>>>>>
>>>>>>
>>>>>> Hi David,
>>>>>>
>>>>>> Thanks a lot for comments!
>>>>>>
>>>>>> If calc_checksum() is wrong before pages_idential(), (that's just after page was write_protected, that's a real guarantee for page context secured) pages_identical could recheck and make thing right.
>>>>>>
>>>>>
>>>>> Yes, but you would get more wrong checksums, resulting in more unnecessary pages_identical() checks.
>>>>>
>>>>> That is missing from the description, and why we want to change that behavior.
>>>>>
>>>>> What's the net win?
>>>>>
>>>>>> And as to 2 flush functions here, I didn't see the guarantee for other writer from any other place. So maybe we should remove these flush action?
>>>>>
>>>>> "I didn't see the guarantee for other writer from any other place" can you rephrase your comment?
>>>>>
>>>>> If you mean "the process could modify that page concurrently", then you are right. But that's different than "the process modified the page in the past and we are reading stale content because we missed a flush".
>>>>
>>>>
>>>> Maybe moving the flush before checksum could relief some worries. :)
>>>> But still no one knows what flush really help, since if page content only syncs to memory by the flush, the kernel or process can't be work with current code.
>>>
>>> Please explain to me why we care about moving the flushs at all :)
>>>
>>> If they are NOP on most architectures either way, why not simply leave them there and call it a day?
>> Uh, 2 reasons:
>> 1, it uses page and can't convert to folio now.
>> 2, as you pointed, flush action w/o page reading seems just waste time.
> 
> Alex, I don't think the approach you take for coming up with the current set of patches is a good idea.
> 
> Please reconsider what you can actually convert to folios and what must stay pages for now due to support for large folios in that code.
> 
> Then, please explain properly why changes are required and why they are safe.
> 
> For example, for in scan_get_next_rmap_item() we really *need* the page and not just the folio. So just leave the flushing there and be done with it.
> 

Hi David,

Thanks a lot for your review.
Though all patches are passed in kernel selftest, but if we do care the saving more than quick processing, the main purpose of this patchset is gone. I'll drop this series.

Thanks
Alex

