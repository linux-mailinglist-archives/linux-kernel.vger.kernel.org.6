Return-Path: <linux-kernel+bounces-560448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6753A60466
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65501189A8AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EF91F8691;
	Thu, 13 Mar 2025 22:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/OG5URD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978071F76B6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905205; cv=none; b=ObevaGjFYTyWYuWsuEdwD5vyaz1Rr5aG+3dLCnhmQ4/LTLr8yLbWLeOuEYl+dBGbXNDOs10wa0Y4Jud0g+pxQES4MVeS9H5vB7rtpscpvlta05BZpXml7nKbld9hdvci1My6b3mokMMZjTUSo+3ufGo5ouANxdQiV7KWttwszT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905205; c=relaxed/simple;
	bh=mPTy8jBoK9taKq5Plt2kSz6mtUaYvM9yKY5Fw3D6lik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmzAIbnyphBNMnBLNn1aD68QWCIOPoPknOpC4frfFf/SD3qOpQjABzGOHzCzVURAcuEVRe0et8PSqnDAotQWB4ByGJD5paMOF9khFmcOF8gDj5Xg6brh53zHJm9ur1YtY6n6hihJS4X03KscoiYxNvUZvDJsTozL8FNkNpTchRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/OG5URD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741905202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XMLsxBDuZP5DuVJGRHR2kuGT4MbjTR865prTgJ6YJPw=;
	b=I/OG5URDIbFRdsD4C95cHsMIv4AL5zAvMENkH29Z54bUj2NiOl/kFZfVAhh4LLDR6jtn7i
	U30FoPshSvCjH7HrRR/S303Gd1eUqOL8rTqKzUYydmcK1cUd62625iRLmHF7MBjZNQAwSy
	50ACglWPv0/9gclCIy7TaiVvdUMdpBI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-WNsuFWuIPg6cjc1Hws_JcQ-1; Thu, 13 Mar 2025 18:33:19 -0400
X-MC-Unique: WNsuFWuIPg6cjc1Hws_JcQ-1
X-Mimecast-MFC-AGG-ID: WNsuFWuIPg6cjc1Hws_JcQ_1741905198
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so10480645e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741905198; x=1742509998;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XMLsxBDuZP5DuVJGRHR2kuGT4MbjTR865prTgJ6YJPw=;
        b=ktO7Z54qSp9mgcLSxwi9pYH7BPjmdaMJkRc7KCQRRoB+kAQ/Y9G8EBQnh1KRHtxkEb
         COAw+8W+IapU1CS9SoGECAr53p/wM06wDXwmaqmdVKN6CmJ/B6zo9RWL+vremVu0t5lG
         c0VUyseUWZMz916QV+jZbgiuyhuu57OnYTOC60ZwkOlBfXhp8b97yA43Z7gYD1gNNsos
         4oetxLEb/NmaNlE0tOyeL0D3bH+iXnWwjGI797XQCAGwHZkDGs9421oex8Ms9VvQdRPz
         DrTMuSfwv+HdPHMkjxa4fqcXyVwEaY8wP/JlCS3SuPWMylPUlTwaW/CY2Mi2TCKhX1fc
         T8aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOjckfBwpC85VKJqncDwLMv3crsFjSolSHDkeRroRg17A09PAtOHRjSuLUajgapu71QH8vHltXhv/eKWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhKbqmhOW0nG7dUhVxENxRSzFaDXgLIQpfCalUrK1l7nIRBclc
	H0sz2BEYMqGfDGeCsOoD3t8Y8Nvuk73l4ELKBYmf5XEVUL0NMOx+9WTFH2i5PE1YUl+PVq+KKrT
	DWmN5FUfZ8yh2AsYYZKDXECHtXEQx/KeTooO+2V7r2LUwGVfik5AF7BMNehSJlw==
X-Gm-Gg: ASbGncsOl6U26ReJUBGpkxRnsHWyTaOtjn+gT9TqlbVI8D+AsxBxgSZWteXe/KFB+sr
	Ug+ewLL5RJqqHVyc5EeeAZ429P1ugp+DnSAjHoKM9zBOidvdA0gKN/QshfUOXhSjPrL8eby97Ar
	08XZWExKAXdvHjbM34rbRiZ6iw6gb+/tTqMaJiFTyVLHUvf88CpI3sQSha0Fbdfm2gHS8QmWKp/
	knSEa7nHVhThGg9W1FfwEH+E4yX/ffRFg/hj8Y/C5ihmNh8FGff7l/aajH2VJz5QFT9h4I8po6/
	FvgxVhaSRokLhX+NT4uip9t/niz0UfG3qWQUPTaEokzmRQ==
X-Received: by 2002:a05:600c:4f0c:b0:43d:683:8cb2 with SMTP id 5b1f17b1804b1-43d1ec8db3dmr4177835e9.14.1741905198123;
        Thu, 13 Mar 2025 15:33:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERr00diM/pusqeo7Sq0Psil11/HkcSIz4darXRoQvvc4mBmtkajVmoM851r3dYsCbC6t87gA==
X-Received: by 2002:a05:600c:4f0c:b0:43d:683:8cb2 with SMTP id 5b1f17b1804b1-43d1ec8db3dmr4177375e9.14.1741905197671;
        Thu, 13 Mar 2025 15:33:17 -0700 (PDT)
Received: from [192.168.3.141] (p5b0c698e.dip0.t-ipconnect.de. [91.12.105.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d17b8b778sm36320745e9.1.2025.03.13.15.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 15:33:17 -0700 (PDT)
Message-ID: <d7ccdde7-39e5-411b-bcd7-63767c765129@redhat.com>
Date: Thu, 13 Mar 2025 23:33:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/5] meminfo: add a per node counter for balloon drivers
To: Nico Pache <npache@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, jerrin.shaji-george@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com,
 sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 nphamcs@gmail.com, yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com,
 alexander.atanasov@virtuozzo.com
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-2-npache@redhat.com>
 <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>
 <CAA1CXcCv20TW+Xgn18E0Jn1rbT003+3gR-KAxxE9GLzh=EHNmQ@mail.gmail.com>
 <e9570319-a766-40f6-a8ea-8d9af5f03f81@redhat.com>
 <CAA1CXcBsnbj1toxZNbks+NxrR_R_xuUb76X4ANin551Fi0WROA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAA1CXcBsnbj1toxZNbks+NxrR_R_xuUb76X4ANin551Fi0WROA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.03.25 18:35, Nico Pache wrote:
> On Thu, Mar 13, 2025 at 2:22 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 13.03.25 00:04, Nico Pache wrote:
>>> On Wed, Mar 12, 2025 at 4:19 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 12.03.25 01:06, Nico Pache wrote:
>>>>> Add NR_BALLOON_PAGES counter to track memory used by balloon drivers and
>>>>> expose it through /proc/meminfo and other memory reporting interfaces.
>>>>
>>>> In balloon_page_enqueue_one(), we perform a
>>>>
>>>> __count_vm_event(BALLOON_INFLATE)
>>>>
>>>> and in balloon_page_list_dequeue
>>>>
>>>> __count_vm_event(BALLOON_DEFLATE);
>>>>
>>>>
>>>> Should we maybe simply do the per-node accounting similarly there?
>>>
>>> I think the issue is that some balloon drivers use the
>>> balloon_compaction interface while others use their own.
>>>
>>> This would require unifying all the drivers under a single api which
>>> may be tricky if they all have different behavior
>>
>> Why would that be required? Simply implement it in the balloon
>> compaction logic, and in addition separately in the ones that don't
>> implement it.
> 
> Ah ok that makes sense!
> 
>>
>> That's the same as how we handle PageOffline today.
>>
>> In summary, we have
>>
>> virtio-balloon: balloon compaction
>> hv-balloon: no balloon compaction
>> xen-balloon: no balloon compaction
>> vmx-balloon: balloon compaction
>> pseries-cmm: balloon compaction
> 
> I'm having a hard time verifying this... it looks like only
> vmx-balloon uses the balloon_compaction balloon_page_list_enqueue
> function that calls balloon_page_enqueue_one.

Also check balloon_page_enqueue, which ends up calling 
balloon_page_enqueue_one.

> 
>>
>> So you'd handle 3 balloon drivers in one go.
>>
>> (this series didn't touch pseries-cmm)
> Ah I didn't realize that was a balloon driver. Ill add that one to the todo.


Well, by implementing it in the compaction code that todo would be done :)

-- 
Cheers,

David / dhildenb


