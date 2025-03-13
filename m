Return-Path: <linux-kernel+bounces-560455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21A2A60473
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8AB1796D5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E399F1F78E0;
	Thu, 13 Mar 2025 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvoYpUpe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7D91F12EC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905415; cv=none; b=DSjGk/WIk8ACeJD6SSnIv7PZE/JJ18AqyKsI4uM5BW9/UiMKQDEKr3RdaF097evr3W0nAG1ZnEpXPzddSsAfiZRIf7OKqvdja6F9EXyh+MIwIOVP+U5124EjjHoi1+K0863W8nNbnc3nsk6VKlTVr3PUvljmjv7zXd33I+JgMYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905415; c=relaxed/simple;
	bh=6TIExaCI4u5uKKMmuk9W2uDdm2Lycq5IyfzdKQg7ER4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCLHuUGHTfwbb9pXBfQdxD2jsadLKX1HNrgDZR0to+oeoSSVc38ap9l4r345T0TMSLWQllE9FNvEClf91H5XDbDlfxdOk9mHFxdgM2Xu4XPQg99MjYlNAdvyMDk2aIyWt/7jKohr7G4Rhv0b4sQRefo4UJE1j7g/kACBBqJDkrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AvoYpUpe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741905412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MEn789IiFnrQsw71niQs8iSfggvunaGbnhoDDl6N9/8=;
	b=AvoYpUpesjdvTccge3sI4CU2OWPCtUpwqR9kngOLk7k4TNtlj8jp0r4IpE6Kge44z3vsmS
	hP7ItujSQ1m8ctFtVM0nChyg4O0Ivj3XQPAsV00sVkpLcW550PqoFbVADtEaHVgUFk61S2
	wBnFw4Zehf/iugCxQC+mCW+duVr/MSE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-8UdXG2PXNbC-Mz_7l3kMmA-1; Thu, 13 Mar 2025 18:36:50 -0400
X-MC-Unique: 8UdXG2PXNbC-Mz_7l3kMmA-1
X-Mimecast-MFC-AGG-ID: 8UdXG2PXNbC-Mz_7l3kMmA_1741905410
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4388eee7073so11858725e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741905409; x=1742510209;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MEn789IiFnrQsw71niQs8iSfggvunaGbnhoDDl6N9/8=;
        b=huB96upkF/QZfvF1au7P/XNSGFuZUVLqmPm/PWNmf0I02zbYpc6IX5OBDMJ3qABpgG
         j//q315KqMRioEK9ePD3CWaZP/FSOMLMbdzYstS5vEzcJZGImxVe44BfprPrMAryNVqk
         zOslPHT47E1trLqpuDBv52BFu1Vn6ZhwWK6YF0kuam3D+o+l78rSbXOFiRuzcpn362RC
         qN7aRyjtYMSwvvmcEbBPxQtZkFnxl7DmLHAydm7dqvbiywqif7Ooz5lP2AvsRqjuEUvP
         ye6vW4NASBs1Yl47K0Pw4EV7pohnr1W2PmAUviMeBMuEi0auw02dBU5OXgwAA9MFsSnG
         18yw==
X-Forwarded-Encrypted: i=1; AJvYcCX9p/IXs8qaR3HgpfLXSPf9OxCVR5YKFOkGpVEa2ImtR5ayQjfyU8j0l9udmmusC1wL/udceLQpOqkJjag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrm6uw58XN8NKxJ6NJj2n5Ou7lE3u1FIhb3IohZZ03FhWWGHWQ
	no2U843Uw0u/XkqJnA28PCn8gE0FzkHjxD2d1IXYHJ82AEJytNy8MtQSoZPxjM6vgY0CZtSAa81
	ad+iJY6hcU1uvv7XmCsxALZbKfcW9rR6zIJ9pLBOT6S9T/tUfIGiL/5llA9y5lg==
X-Gm-Gg: ASbGncuZX6/QuqKioz6cX2OsRUaVCeGnqOq4rz2Ks76ToX2c684nHd8dgPqxk2d14Oc
	Vk9uUF4JqiWDjMd/Sqv3GXBpIciYT1NAbaNIqbP2WrDPE91Q94Fd4mshjNOfNJPCcN0z41qMrhr
	Z7PTkQS1dIme7g4KA1MNl4hZZ+vBSs7ArBIhsF8qXsgL/nDcrkNYXxw25XHgxYck71L5HKhcunq
	iuiUivuWYK7SaMoKwUgC+ZEtCzrUNgSfPbsbpL1BjYC6P9zyEZXXVdsoi4eNXHWVsh2SNsev58+
	t3AkXl0Oijc8FNUHY3uMO96Gv7I/NrCQTuVVc6slM7thn5vKharhj1rNZoi469ggszzGL8cDLkN
	y1Zk+Wbc6nkmy1hy0RuMxt/LuZ0pVXcKjSmtfkmOh
X-Received: by 2002:a05:600c:210d:b0:43b:c305:3954 with SMTP id 5b1f17b1804b1-43d18081271mr38994745e9.8.1741905409621;
        Thu, 13 Mar 2025 15:36:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHogm6Nwm7wQHORJKU3v5xzf+Xl8FpKmWTaZqwSlRET//jXZSRmhmB8USMA7MGxQrcqx8/g3w==
X-Received: by 2002:a05:600c:210d:b0:43b:c305:3954 with SMTP id 5b1f17b1804b1-43d18081271mr38994565e9.8.1741905409283;
        Thu, 13 Mar 2025 15:36:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:3600:463c:fbbe:a2df:efd? (p200300cbc7423600463cfbbea2df0efd.dip0.t-ipconnect.de. [2003:cb:c742:3600:463c:fbbe:a2df:efd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d18a2af67sm33650475e9.26.2025.03.13.15.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 15:36:48 -0700 (PDT)
Message-ID: <713b6924-a653-453e-8fde-8c966638386b@redhat.com>
Date: Thu, 13 Mar 2025 23:36:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm/mempolicy: Support memory hotplug in weighted
 interleave
To: Gregory Price <gourry@gourry.net>, Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
 ying.huang@linux.alibaba.com, kernel_team@skhynix.com, honggyu.kim@sk.com,
 yunjeong.mun@sk.com
References: <Z9GwNWNC9VfR3Y6A@gourry-fedora-PF4VCD3F>
 <20250313063351.692-1-rakie.kim@sk.com>
 <Z9MGdwrgX8dYeHha@gourry-fedora-PF4VCD3F>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z9MGdwrgX8dYeHha@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.03.25 17:23, Gregory Price wrote:
> On Thu, Mar 13, 2025 at 03:33:37PM +0900, Rakie Kim wrote:
>>> I'm fairly certain this logic is wrong.  If I add two memory blocks and
>>> then remove one, would this logic not remove the sysfs entries despite
>>> there being a block remaining?
>>
>> Regarding the assumption about node configuration:
>> Are you assuming that a node has two memory blocks and that
>> MEM_OFFLINE is triggered when one of them is offlined? If so, then
>> you are correct that this logic would need modification.
>>
>> I performed a simple test by offlining a single memory block:
>> # echo 0 > /sys/devices/system/node/node2/memory100/online
>>
>> In this case, MEM_OFFLINE was not triggered. However, I need to
>> conduct further analysis to confirm this behavior under different
>> conditions. I will review this in more detail and share my
>> findings, including the test methodology and results.
>>
> 
> +David - might have a quick answer to this.  I would have expected a
> single memory block going offline to cause a notification.

Yes. Unless offlining failed, or the block was already offline :)

If it doesn't happen for an actual online memory block that is offline 
after the call, we would have a bug.


-- 
Cheers,

David / dhildenb


