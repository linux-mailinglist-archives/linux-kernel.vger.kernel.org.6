Return-Path: <linux-kernel+bounces-203714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845BD8FDF65
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727601C217D2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF72E13A896;
	Thu,  6 Jun 2024 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7fwqK5r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353A333F7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658318; cv=none; b=kV4byppHzb1iLUkrb1CzjIQlu0qjQzibYfYvRWr3B7ci8dLt7vJzxAcrOiPeYQvpdYkFDG3WwnJHdB2lR8HMA0g0Q61w5FfYLjLN6L2WpxPiPMHVKD8b+l13sK8G1o4ZsoJZAGIlODB0kOLdaE7lX/pDyCBRV2OCAYXoRoDcFEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658318; c=relaxed/simple;
	bh=R7ueCAy6fut9uiz4e8YxqXFLF/ZPouJCucHBSXavmKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2xLpybReW+OS7JSiVAc3y+rFI9LPEXyGiPN9PC9WV1Tkd8W/N5kb8t+jPJ1o0FLwVGMJF7viv55MPikjXXKO++0dMyDn1FmRwkDfQo/a95alX06u1rvA3h/N1z8lrDp3qx1KF/q45HWh7XVUbAI2yNC6qBN8+qraei/Hc9FmsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7fwqK5r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717658316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dX72FIZSO83pY1hyr/Pb+gOr6i7pkZCz4BjYbnrHA0M=;
	b=H7fwqK5rAMw0epZ/jg43H5jqXlQGdrXHhEemLG7UPWr9QkQI6sGasEjzMH/tW6UBGyUWuj
	wGBHF9QiVIlJ6Xs/jomQkM5Ap2BMAJxMYtjApopoCE6q8FZIkOQ3YkewSKh3kKV2mM46p8
	WdBPFdvL3iDahR+zklE14ctL+EoZ72E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-T3KeZaYkM8-d-2TkAA7PlA-1; Thu, 06 Jun 2024 03:18:30 -0400
X-MC-Unique: T3KeZaYkM8-d-2TkAA7PlA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42159c69a28so6003905e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 00:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717658309; x=1718263109;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dX72FIZSO83pY1hyr/Pb+gOr6i7pkZCz4BjYbnrHA0M=;
        b=DsMy6c8SCH20rv1NVAWTlpFb1vLDWi1YfPR9Ouirx8N8PJ9x7AQ6RT22Xojm32UHbA
         A7OWqhLgyTc15k64x6BIhCy6+FrQzxxN2Nt9dsLN/iqC1YxCDCTJaHAzuWopU3IQfjg+
         5atY3qj3onb+8uiwokqKLROgM0PnpHW9Gxz711h6ByoGqNKersbq0ojTf7J+ZZS6/nSr
         QKcS4eGirV7v2P4oGG3l/W8XhedKoRAmvA/SneX4YWKGT1bHpYIpwLP7N6PGCIycT2Jy
         vpVwY2biKuv4r28jrXKo9ZsmInj/sxjVDwTQoQ3x9w8iDUT1JT9AHiBzpfbkIxejqhWT
         9W6g==
X-Forwarded-Encrypted: i=1; AJvYcCV49nlvK/zwB4ft5UUJenzSFMA0fDU96XsQxzxmkaGBerQ7DEuOO/sMoaYZPq5imhIQrmRlY/l+dS7+5p+68Zf6giRuCEXhq9LxQwT7
X-Gm-Message-State: AOJu0YwMIqT5gEOvc3xsoD7XhjR/Cu/QVI2zJlhejGPlH47aLJMRIPbh
	4IwPFe61jk2q6dhE0K6v9aaViSLUMDztHGZHJ8vEsyHSo70BtM26LJH7TZIG1k8VPj1ae/J97hs
	ehgMOu6iVcsnWXWyLoCg6Xxo/kH5gtXJtje0XzAtjzi87rrAgiUVeHJ7njxAnXg==
X-Received: by 2002:a05:600c:5492:b0:421:2adb:dd6a with SMTP id 5b1f17b1804b1-421562cf75dmr43868885e9.7.1717658308875;
        Thu, 06 Jun 2024 00:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiLhU7W2wGa8163bjzf7SzT7/ibP37Tv22Zts4ijZMkgQq1vgrH2JqwhLxUHUDyemDkbTKnA==
X-Received: by 2002:a05:600c:5492:b0:421:2adb:dd6a with SMTP id 5b1f17b1804b1-421562cf75dmr43868655e9.7.1717658308440;
        Thu, 06 Jun 2024 00:18:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:8800:a73c:ec5b:c02c:5e0b? (p200300cbc7108800a73cec5bc02c5e0b.dip0.t-ipconnect.de. [2003:cb:c710:8800:a73c:ec5b:c02c:5e0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d69917sm768122f8f.62.2024.06.06.00.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 00:18:28 -0700 (PDT)
Message-ID: <eb11498d-1fa7-4415-8c7c-a8194fc58a48@redhat.com>
Date: Thu, 6 Jun 2024 09:18:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] mm: huge_memory: fix misused
 mapping_large_folio_support() for anon folios
To: Barry Song <21cnbao@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, ran xiaokai <ranxiaokai627@163.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mhocko@kernel.org, v-songbaohua@oppo.com, xu.xin16@zte.com.cn,
 yang.yang29@zte.com.cn
References: <CAGsJ_4wFyFBTDDfsBpi0sKs1WOH2jaKKoYWWj9Ln_PsNjP2uuA@mail.gmail.com>
 <20240605095406.891512-1-ranxiaokai627@163.com>
 <D667F08C-0CCE-4D5E-89A3-56674B0893DE@nvidia.com>
 <c110eb46-3c9d-40c3-ab16-5bd9f75b6501@redhat.com>
 <CAGsJ_4yBqBTLKBNME1vUTqz6XMdngVSp3V5RP7HqiQkLU-NWtA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4yBqBTLKBNME1vUTqz6XMdngVSp3V5RP7HqiQkLU-NWtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.06.24 03:34, Barry Song wrote:
> On Thu, Jun 6, 2024 at 2:42 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 05.06.24 16:08, Zi Yan wrote:
>>> On 5 Jun 2024, at 2:54, ran xiaokai wrote:
>>>
>>>>> On Tue, Jun 4, 2024 at 5:47?PM <xu.xin16@zte.com.cn> wrote:
>>>>>>
>>>>>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>>>>>
>>>>>> When I did a large folios split test, a WARNING
>>>>>> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
>>>>>> was triggered. But my test cases are only for anonmous folios.
>>>>>> while mapping_large_folio_support() is only reasonable for page
>>>>>> cache folios.
>>>>>>
>>>>>> In split_huge_page_to_list_to_order(), the folio passed to
>>>>>> mapping_large_folio_support() maybe anonmous folio. The
>>>>>> folio_test_anon() check is missing. So the split of the anonmous THP
>>>>>> is failed. This is also the same for shmem_mapping(). We'd better add
>>>>>> a check for both. But the shmem_mapping() in __split_huge_page() is
>>>>>> not involved, as for anonmous folios, the end parameter is set to -1, so
>>>>>> (head[i].index >= end) is always false. shmem_mapping() is not called.
>>>>>>
>>>>>> Using /sys/kernel/debug/split_huge_pages to verify this, with this
>>>>>> patch, large anon THP is successfully split and the warning is ceased.
>>>>>>
>>>>>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>>>>> Cc: xu xin <xu.xin16@zte.com.cn>
>>>>>> Cc: Yang Yang <yang.yang29@zte.com.cn>
>>>>>> ---
>>>>>>    mm/huge_memory.c | 38 ++++++++++++++++++++------------------
>>>>>>    1 file changed, 20 insertions(+), 18 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>> index 317de2afd371..4c9c7e5ea20c 100644
>>>>>> --- a/mm/huge_memory.c
>>>>>> +++ b/mm/huge_memory.c
>>>>>> @@ -3009,31 +3009,33 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>>>>           if (new_order >= folio_order(folio))
>>>>>>                   return -EINVAL;
>>>>>>
>>>>>> -       /* Cannot split anonymous THP to order-1 */
>>>>>> -       if (new_order == 1 && folio_test_anon(folio)) {
>>>>>> -               VM_WARN_ONCE(1, "Cannot split to order-1 folio");
>>>>>> -               return -EINVAL;
>>>>>> -       }
>>>>>> -
>>>>>>           if (new_order) {
>>>>>>                   /* Only swapping a whole PMD-mapped folio is supported */
>>>>>>                   if (folio_test_swapcache(folio))
>>>>>>                           return -EINVAL;
>>>>>> -               /* Split shmem folio to non-zero order not supported */
>>>>>> -               if (shmem_mapping(folio->mapping)) {
>>>>>> -                       VM_WARN_ONCE(1,
>>>>>> -                               "Cannot split shmem folio to non-0 order");
>>>>>> -                       return -EINVAL;
>>>>>> -               }
>>>>>> -               /* No split if the file system does not support large folio */
>>>>>> -               if (!mapping_large_folio_support(folio->mapping)) {
>>>>>> -                       VM_WARN_ONCE(1,
>>>>>> -                               "Cannot split file folio to non-0 order");
>>>>>> -                       return -EINVAL;
>>>>>> +
>>>>>> +               if (folio_test_anon(folio)) {
>>>>>> +                       /* Cannot split anonymous THP to order-1 */
>>>>>> +                       if (new_order == 1) {
>>>>>> +                               VM_WARN_ONCE(1, "Cannot split to order-1 folio");
>>>>>> +                               return -EINVAL;
>>>>>> +                       }
>>>>>> +               } else {
>>>>>> +                       /* Split shmem folio to non-zero order not supported */
>>>>>> +                       if (shmem_mapping(folio->mapping)) {
>>>>>> +                               VM_WARN_ONCE(1,
>>>>>> +                                       "Cannot split shmem folio to non-0 order");
>>>>>> +                               return -EINVAL;
>>>>>> +                       }
>>>>>> +                       /* No split if the file system does not support large folio */
>>>>>> +                       if (!mapping_large_folio_support(folio->mapping)) {
>>>>>> +                               VM_WARN_ONCE(1,
>>>>>> +                                       "Cannot split file folio to non-0 order");
>>>>>> +                               return -EINVAL;
>>>>>> +                       }
>>>>>
>>>>> Am I missing something? if file system doesn't support large folio,
>>>>> how could the large folio start to exist from the first place while its
>>>>> mapping points to a file which doesn't support large folio?
>>>>
>>>> I think it is the CONFIG_READ_ONLY_THP_FOR_FS case.
>>>> khugepaged will try to collapse read-only file-backed pages to 2M THP.
>>>
>>> Can you add this information to the commit log in your next version?
>>
>> Can we also add that as a comment to that function, like "Note that we
>> might still
>> have THPs in such mappings due to CONFIG_READ_ONLY_THP_FOR_FS. But in
>> that case,
>> the mapping does not actually support large folios properly.
>> "Or sth. like that.
> 
> +1. Otherwise, the code appears quite confusing.
> Would using "#ifdef" help to further clarify it?
> 
> #ifdef CONFIG_READ_ONLY_THP_FOR_FS
>              if (!mapping_large_folio_support(folio->mapping)) {
>                            ....
>              }

if (IS_ENABLED()) ...

Agreed.

-- 
Cheers,

David / dhildenb


