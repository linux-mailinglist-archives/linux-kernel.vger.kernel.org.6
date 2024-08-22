Return-Path: <linux-kernel+bounces-297243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A091F95B4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE211F23798
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64DD1C93D6;
	Thu, 22 Aug 2024 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aFYEWgbO"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C42326AF6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724329075; cv=none; b=pvtlnWJ+v6Uwz5ZHAFWqoMb8yXrbA9Yd4t+RVEuX2rlmRp8Vid6dB9+Jm1sneaQbHxIlKQMGd79s3qy5s928HtKrXpJduilpZWPsqFeFBA4kMNVO7D5BZnwqXWINIDiKgymn8Y8NsDcObLTuFIDifhDZongOt7YAxJEEM6NpeBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724329075; c=relaxed/simple;
	bh=yKdYHN5fAuWGvkVxOvcdficZ9Tw/QihuTEpUC1rwE3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWxsrNO7NjPkJNQtxdC7De4VdC2QKPoDkO+BscFL4OYtMmZ5mq7ah1F9E5CP+0L9B4qm40IF9L8tr1hjs88WdcdPbDdLuZAM6qGAiAAzGecZoAj77FOPPPxnuFHyRRepIrsJRt8rMWdjjK1I0RlnczEMSnzINRIo3EyTyx/eqiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aFYEWgbO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-201f2b7fe0dso6391605ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 05:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724329073; x=1724933873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yx+C2U4iF94VXeDjm9C7FkXz5nA7V9VNqSYF9OlMlok=;
        b=aFYEWgbOUJRv/lXiyfcgitU+peU0OZ+LiESE2c4oRYi91o0/JHhtL0I6OZhagPf41Y
         vYKq6bIUfnqyy607sNp7fUPusTxU2B6cAyTr/g8cEuTicR8V+ocuAY0Eh/ldsnTbWz8K
         UU8MVO4XWDFbge1e0iTAl0NMdA9prPCB6BUMaMiY9CamlK/UXQo/9t/PUm5DSSKXhvMk
         vqK1PGZmDwk5YOLxqtfrFh1/ZKr2VS7z05FUENBEbJBffKrTQBDcHqi+GcLz4Av2bdLv
         RTXKCLo6BDe3dBLsj8u0x/mPEkJS1x48EmRn1b4+DNdGXkQ44xHGrDDnNhtg8aGZ9dX+
         NOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724329073; x=1724933873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yx+C2U4iF94VXeDjm9C7FkXz5nA7V9VNqSYF9OlMlok=;
        b=me1tusy6V46/ezJUZk2mXN/ZBOH1+QtuzqVaAnI/e9xP5KuBRtFhG2yD7M/ztKEs0L
         zZqDuLs3qihs6vsq3YjVRaW5mOjXkd6tQgodfwxhBlqJrJ6dKKWdBnD5OELzDjowqHxz
         FJ/I+OWoNzKIS8PnxsQT+WoTmPehPEtQPj71ESOLZd6t+OQSBvjGoCL/kyL9xjCmVqgv
         iG55PuxdLnCUHS72xunFSTX3EIRXxtbgjFai2GS7g8HXY5MVrtDYskhmJq7i7tviyX61
         +ALoPJCoJ61kNwdJASLtCA8k6hxaqLtcHCWZ20mfco9SQNAYM3PhcWTfplmZGkDkBCXt
         azrw==
X-Forwarded-Encrypted: i=1; AJvYcCULFuusLNm+gGRYi8NORS/VpfiPMi20XClMbQb+WeYphZBNgEq4y/UhPgX2A+YAJVYD6FP2RqejDPD4SqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh024HLN5RdJMNGUtcHqUcRpjc7ADYqS5LzpkT5864hq6pgnX8
	nd0NIkwiNjseLsf9ahKhMN5G9NoSgUMM/HzvQd4l0jnWq/iyyejgtQJuPk3+wb8=
X-Google-Smtp-Source: AGHT+IGQCmIxIo4n5wGGT5nxKPt1EKhdUohcyrEN/h8veL+3fxj79HNkDhzIeZh/LJSzH8gYmwu90A==
X-Received: by 2002:a17:902:e745:b0:1fb:93d6:9fef with SMTP id d9443c01a7336-2038890f96fmr17992995ad.38.1724329073509;
        Thu, 22 Aug 2024 05:17:53 -0700 (PDT)
Received: from [10.255.182.243] ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dbed6sm11386985ad.172.2024.08.22.05.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 05:17:52 -0700 (PDT)
Message-ID: <da7aa8d2-098c-431b-86d0-b817981a9a5f@bytedance.com>
Date: Thu, 22 Aug 2024 20:17:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] mm: handle_pte_fault() use
 pte_offset_map_maywrite_nolock()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>,
 LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "vbabka@kernel.org" <vbabka@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "vishal.moola@gmail.com" <vishal.moola@gmail.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <cover.1724226076.git.zhengqi.arch@bytedance.com>
 <239432a0bc56464e58a6baf3622fdc72526c8d57.1724226076.git.zhengqi.arch@bytedance.com>
 <6a586524-5116-4eaf-b4f3-c1aea290d7c1@cs-soprasteria.com>
 <b4bf605a-d31a-40ad-8cee-fe505e45dc64@bytedance.com>
 <4b867535-8481-4fa1-bed1-ad25a76682f0@redhat.com>
 <ef40c2ef-e4a4-4b02-85b8-a930285a3d0e@bytedance.com>
 <61c05197-0baa-4680-ad24-5965ba37dc35@redhat.com>
 <83142dc8-edcf-4e47-8215-8b359a2b7156@bytedance.com>
 <04dccff9-87dd-4e97-a712-b62fa51b32f7@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <04dccff9-87dd-4e97-a712-b62fa51b32f7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

On 2024/8/22 17:29, David Hildenbrand wrote:
> On 21.08.24 12:03, Qi Zheng wrote:
>>
>>

[...]

>>>>>>>> -        vmf->pte = pte_offset_map_nolock(vmf->vma->vm_mm, 
>>>>>>>> vmf->pmd,
>>>>>>>> -                         vmf->address, &vmf->ptl);
>>>>>>>> +        vmf->pte = pte_offset_map_maywrite_nolock(vmf->vma->vm_mm,
>>>>>>>> +                              vmf->pmd, vmf->address,
>>>>>>>> +                              NULL, &vmf->ptl);
>>>>>
>>>>> I think we discussed that passing NULL should be forbidden for that
>>>>> function.
>>>>
>>>> Yes, but for some maywrite case, there is no need to get pmdval to
>>>> do pmd_same() check. So I passed NULL and added a comment to
>>>> explain this.
>>>
>>> I wonder if it's better to pass a dummy variable instead. One has to
>>> think harder why that is required compared to blindly passing "NULL" :)
>>
>> You are afraid that subsequent caller will abuse this function, right?
> 
> Yes! "oh, I don't need a pmdval, why would I? let's just pass NULL, 
> easy" :)
> 
>> My initial concern was that this would add a useless local vaiable, but
>> perhaps that is not a big deal.
> 
> How many of these "special" instances do we have?

We have 5 such special instances.

> 
>>
>> Both are fine for me. ;)
> 
> Also no strong opinion, but having to pass a variable makes you think 
> what you are supposed to do with it and why it is not optional.

Yeah, I added 'BUG_ON(!pmdvalp);' in pte_offset_map_ro_nolock(), and
have updated the v2 version [1].

[1]. 
https://lore.kernel.org/lkml/cover.1724310149.git.zhengqi.arch@bytedance.com/

Thanks,
Qi

> 

