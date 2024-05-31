Return-Path: <linux-kernel+bounces-197308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205858D6911
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3144B1C2624B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A8D8002F;
	Fri, 31 May 2024 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oknd0hc1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B67E591
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717180697; cv=none; b=iExDIOS9gF9BLo72STOpq76YWbOnt7jM2rHN9OXmPQinhEjjrx6UGg3WLQG9GfegKniZEY9Wq5YqdH1rHR88W2mnZWt5ZWU/tCulydjkEbS504eWapCXkcX0c6jJk1H8tXRcWVTacrCJMhvXo+EcTF89AhkUj3amxwP73iVU1d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717180697; c=relaxed/simple;
	bh=Z24nPTc5WNU09mDYrBR9lmqdOWtHhvWNWIsggI9bdPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5iGAVnUufBKf0YOjV+tCLYiO3isQ9Rb3DCIZ60tAIJtb+Dum6HBvOyPeQORkh8CYVWYiu6qc7iuAzMcOFg70aeLdjFUaX5TgMRIyBeorsVh3puZ3AzIP3mvFN2LXLOjRvkYDd2IlqNSlFqPpFi3hj4ZUBTLYnR/+A+jCis9uoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oknd0hc1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717180695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iKg+jpln7A8vhODItQJu8TlGcCL7FlyTgrtCstM6y9E=;
	b=Oknd0hc16tQxxJpTTnOWT6wRip/NchsAgmJoT2XwYSzheaNqQmyZcov5aTg49X9LO1x5JF
	ZlrDT4tvIohef6lr/gv6UsijVlQ9uwxV2DpvnDIx1co7tpelIZdxmbkpz0sxnrIAQTNyUL
	X2J8Z2T7YU2rAQBH7b1G49qSf8gB3BA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-fYyy4nV-OFu1p3LsGgN4_w-1; Fri, 31 May 2024 14:38:13 -0400
X-MC-Unique: fYyy4nV-OFu1p3LsGgN4_w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35e0f8bcc3cso490472f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717180692; x=1717785492;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iKg+jpln7A8vhODItQJu8TlGcCL7FlyTgrtCstM6y9E=;
        b=XN0HXCl0wBCfAUbVBJHrn2X86BOLyEnPpVO6EfwfiyH2xq1K5Q68kxO5AY+dRPLTp+
         6HOUaQo6zMd+RxVhSU7YLuKKHx3PJIwgxisEEj5e8EaDZCLojvDo1a97naies1m3kArr
         AYGOFR3jUwMOHt3BUKHslzHKo4yyaSze8zUbYJUhbkeZMjYUJarBeSdmH4C14u6K+R+p
         +VoNoW0RuYcNnz52zNPFnEoMKrJ7cwNcTkGcDtABJN7GpiTYJsEbeQRnMsni8jAFQ1pg
         aV+y4GRWypqhU3MgSqny5wtE53xahnoufaGG9BHUU2igMeevv++3YGBAvaFcFDY0J7bS
         sJ3w==
X-Forwarded-Encrypted: i=1; AJvYcCUMmRz1QNQ4HMj4GpWOJFgjoTRUAK17WUKVPVmZciAe2AkRPY66cII8TYirgyxuZ6F/9z70EzS0zijqzWeBMCdfIfRUB5vI3PW7ybME
X-Gm-Message-State: AOJu0YwxBOrTvmUHLZaaCqGau3d+gA17QeW0mNFRpCBt5GEKco6sYccv
	E5rP0E3CBCLnSCYQS4G9QSVxvv76CJ/NSmcZvYpqYB9d1gkVT+HD1CTbjoZ7vbjP1Pyiho8M+SW
	gMq9bwC00EpqUuKfk5cflJc0+ubZag1sTK3FhG6p1r37uZks3q4+PMVFFdFwt3Q==
X-Received: by 2002:a5d:5229:0:b0:34d:95f:c46 with SMTP id ffacd0b85a97d-35e0f32d5c4mr2081238f8f.59.1717180691759;
        Fri, 31 May 2024 11:38:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKmDSl+jaW9sNvh7/e1M04pEEWyy6AF4NeIBemT1177Yi/2qWj/BOyQLDKv7APd6Eht6nshQ==
X-Received: by 2002:a5d:5229:0:b0:34d:95f:c46 with SMTP id ffacd0b85a97d-35e0f32d5c4mr2081223f8f.59.1717180691185;
        Fri, 31 May 2024 11:38:11 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6f0d.dip0.t-ipconnect.de. [91.12.111.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0659bbbsm2396801f8f.110.2024.05.31.11.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 11:38:10 -0700 (PDT)
Message-ID: <a088b5cf-503e-4ed7-b427-f17a9ec5d1a8@redhat.com>
Date: Fri, 31 May 2024 20:38:09 +0200
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
Cc: kernel test robot <oliver.sang@intel.com>, Peter Xu <peterx@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Rik van Riel <riel@surriel.com>,
 oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Christopher Lameter <cl@linux.com>,
 linux-mm@kvack.org
References: <202405311534.86cd4043-lkp@intel.com>
 <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
 <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com>
 <CAHbLzkqphyX473LBCXXf8rWEr-8m2PB--CT0cwCax3mUyZPGhA@mail.gmail.com>
 <CAHbLzkqG=9VmAcOgFr-50ZdZtf7xj2PqpfD3UHUsMX3jR=+snw@mail.gmail.com>
 <f4599bd2-72af-4e8d-a0fe-153b69816133@redhat.com>
 <CAHbLzkrOspjVuQw=BN2+RZmV_Ydpz_50yY7FEakJw8Zm14Y9-Q@mail.gmail.com>
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
In-Reply-To: <CAHbLzkrOspjVuQw=BN2+RZmV_Ydpz_50yY7FEakJw8Zm14Y9-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31.05.24 20:30, Yang Shi wrote:
> On Fri, May 31, 2024 at 11:24 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 31.05.24 20:13, Yang Shi wrote:
>>> On Fri, May 31, 2024 at 11:07 AM Yang Shi <shy828301@gmail.com> wrote:
>>>>
>>>> On Fri, May 31, 2024 at 10:46 AM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 31.05.24 18:50, Yang Shi wrote:
>>>>>> On Fri, May 31, 2024 at 1:24 AM kernel test robot <oliver.sang@intel.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> kernel test robot noticed "kernel_BUG_at_include/linux/page_ref.h" on:
>>>>>>>
>>>>>>> commit: efa7df3e3bb5da8e6abbe37727417f32a37fba47 ("mm: align larger anonymous mappings on THP boundaries")
>>>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>>>>>
>>>>>>> [test failed on linus/master      e0cce98fe279b64f4a7d81b7f5c3a23d80b92fbc]
>>>>>>> [test failed on linux-next/master 6dc544b66971c7f9909ff038b62149105272d26a]
>>>>>>>
>>>>>>> in testcase: trinity
>>>>>>> version: trinity-x86_64-6a17c218-1_20240527
>>>>>>> with following parameters:
>>>>>>>
>>>>>>>            runtime: 300s
>>>>>>>            group: group-00
>>>>>>>            nr_groups: 5
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> compiler: gcc-13
>>>>>>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>>>>>>>
>>>>>>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>>>>>>
>>>>>>>
>>>>>>> we noticed the issue does not always happen. 34 times out of 50 runs as below.
>>>>>>> the parent is clean.
>>>>>>>
>>>>>>> 1803d0c5ee1a3bbe efa7df3e3bb5da8e6abbe377274
>>>>>>> ---------------- ---------------------------
>>>>>>>           fail:runs  %reproduction    fail:runs
>>>>>>>               |             |             |
>>>>>>>               :50          68%          34:50    dmesg.Kernel_panic-not_syncing:Fatal_exception
>>>>>>>               :50          68%          34:50    dmesg.RIP:try_get_folio
>>>>>>>               :50          68%          34:50    dmesg.invalid_opcode:#[##]
>>>>>>>               :50          68%          34:50    dmesg.kernel_BUG_at_include/linux/page_ref.h
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>>>>>> the same patch/commit), kindly add following tags
>>>>>>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>>>> | Closes: https://lore.kernel.org/oe-lkp/202405311534.86cd4043-lkp@intel.com
>>>>>>>
>>>>>>>
>>>>>>> [  275.267158][ T4335] ------------[ cut here ]------------
>>>>>>> [  275.267949][ T4335] kernel BUG at include/linux/page_ref.h:275!
>>>>>>> [  275.268526][ T4335] invalid opcode: 0000 [#1] KASAN PTI
>>>>>>> [  275.269001][ T4335] CPU: 0 PID: 4335 Comm: trinity-c3 Not tainted 6.7.0-rc4-00061-gefa7df3e3bb5 #1
>>>>>>> [  275.269787][ T4335] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>>>>>>> [ 275.270679][ T4335] RIP: 0010:try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
>>>>>>> [ 275.271159][ T4335] Code: c3 cc cc cc cc 44 89 e6 48 89 df e8 e4 54 11 00 eb ae 90 0f 0b 90 31 db eb d5 9c 58 0f 1f 40 00 f6 c4 02 0f 84 46 ff ff ff 90 <0f> 0b 48 c7 c6 a0 54 d2 87 48 89 df e8 a9 e9 ff ff 90 0f 0b be 04
>>>>>>
>>>>>> If I read this BUG correctly, it is:
>>>>>>
>>>>>> VM_BUG_ON(!in_atomic() && !irqs_disabled());
>>>>>>
>>>>>
>>>>> Yes, that seems to be the one.
>>>>>
>>>>>> try_grab_folio() actually assumes it is in an atomic context (irq
>>>>>> disabled or preempt disabled) for this call path. This is achieved by
>>>>>> disabling irq in gup fast or calling it in rcu critical section in
>>>>>> page cache lookup path
>>>>>
>>>>> try_grab_folio()->try_get_folio()->folio_ref_try_add_rcu()
>>>>>
>>>>> Is called (mm-unstable) from:
>>>>>
>>>>> (1) gup_fast function, here IRQs are disable
>>>>> (2) gup_hugepte(), possibly problematic
>>>>> (3) memfd_pin_folios(), possibly problematic
>>>>> (4) __get_user_pages(), likely problematic
>>>>>
>>>>> (1) should be fine.
>>>>>
>>>>> (2) is possibly problematic on the !fast path. If so, due to commit
>>>>>        a12083d721d7 ("mm/gup: handle hugepd for follow_page()") ? CCing Peter.
>>>>>
>>>>> (3) is possibly wrong. CCing Vivek.
>>>>>
>>>>> (4) is what we hit here
>>>>>
>>>>>>
>>>>>> And try_grab_folio() is used when the folio is a large folio. The
>>>>>
>>>>>
>>>>> We come via process_vm_rw()->pin_user_pages_remote()->__get_user_pages()->try_grab_folio()
>>>>>
>>>>> That code was added in
>>>>>
>>>>> commit 57edfcfd3419b4799353d8cbd6ce49da075cfdbd
>>>>> Author: Peter Xu <peterx@redhat.com>
>>>>> Date:   Wed Jun 28 17:53:07 2023 -0400
>>>>>
>>>>>        mm/gup: accelerate thp gup even for "pages != NULL"
>>>>>
>>>>>        The acceleration of THP was done with ctx.page_mask, however it'll be
>>>>>        ignored if **pages is non-NULL.
>>>>>
>>>>>
>>>>> Likely the try_grab_folio() in __get_user_pages() is wrong?
>>>>>
>>>>> As documented, we already hold a refcount. Likely we should better do a
>>>>> folio_ref_add() and sanity check the refcount.
>>>>
>>>> Yes, a plain folio_ref_add() seems ok for these cases.
>>>>
>>>> In addition, the comment of folio_try_get_rcu() says, which is just a
>>>> wrapper of folio_ref_try_add_rcu():
>>>>
>>>> You can also use this function if you're holding a lock that prevents
>>>> pages being frozen & removed; eg the i_pages lock for the page cache
>>>> or the mmap_lock or page table lock for page tables.  In this case, it
>>>> will always succeed, and you could have used a plain folio_get(), but
>>>> it's sometimes more convenient to have a common function called from
>>>> both locked and RCU-protected contexts.
>>>>
>>>> So IIUC we can use the plain folio_get() at least for
>>>> process_vm_readv/writev since mmap_lock is held in this path.
>>>>
>>>>>
>>>>>
>>>>> In essence, I think: try_grab_folio() should only be called from GUP-fast where
>>>>> IRQs are disabled.
>>>>
>>>> Yes, I agree. Just the fast path should need to call try_grab_folio().
>>>
>>> try_grab_folio() also handles FOLL_PIN and FOLL_GET, so we may just
>>> keep calling it and add a flag to try_grab_folio, just like:
>>>
>>> if flag is true
>>>       folio_ref_add()
>>> else
>>>       try_get_folio()
>>
>>
>> try_grab_page() is what we use on the GUP-slow path. We'd likely want a
>> folio variant of that.
>>
>> We might want to call that gup_try_grab_folio() and rename the other one
>> to gup_fast_try_grab_folio().
> 
> Won't we duplicate the most code with two versions try_grab_folio()?
> 
> I meant something like:
> 
> try_grab_folio(struct page *page, int refs, unsigned int flags, bool fast)
> {
>      if fast
>          try_get_folio()
>      else
>          folio_ref_add()
> }
> 

That's insufficient to handle FOLL_PIN. Likely we should do this:

diff --git a/mm/gup.c b/mm/gup.c
index 231711efa390d..fea93a64bf235 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -203,8 +203,8 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
  }
  
  /**
- * try_grab_page() - elevate a page's refcount by a flag-dependent amount
- * @page:    pointer to page to be grabbed
+ * try_grab_folio() - elevate a folios's refcount by a flag-dependent amount
+ * @folio:   pointer to folio to be grabbed
   * @flags:   gup flags: these are the FOLL_* flag values.
   *
   * This might not do anything at all, depending on the flags argument.
@@ -216,16 +216,16 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
   * time. Cases: please see the try_grab_folio() documentation, with
   * "refs=1".
   *
+ * Must not be called from GUP-fast: the folio must not get freed concurrently.
+ *
   * Return: 0 for success, or if no action was required (if neither FOLL_PIN
   * nor FOLL_GET was set, nothing is done). A negative error code for failure:
   *
   *   -ENOMEM           FOLL_GET or FOLL_PIN was set, but the page could not
   *                     be grabbed.
   */
-int __must_check try_grab_page(struct page *page, unsigned int flags)
+int __must_check try_grab_page(struct folio *folio, unsigned int flags)
  {
-       struct folio *folio = page_folio(page);
-
         if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
                 return -ENOMEM;
  
@@ -239,7 +239,7 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
                  * Don't take a pin on the zero page - it's not going anywhere
                  * and it is used in a *lot* of places.
                  */
-               if (is_zero_page(page))
+               if (is_zero_folio(folio))
                         return 0;
  
                 /*
@@ -260,6 +260,11 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
         return 0;
  }
  
+int __must_check try_grab_page(struct page *page, unsigned int flags)
+{
+       return gup_try_grab_folio(page_folio(page), flags);
+}
+
  /**
   * unpin_user_page() - release a dma-pinned page
   * @page:            pointer to page to be released


Then, fix the callers and rename the other one to gup_fast_*.


-- 
Cheers,

David / dhildenb


