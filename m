Return-Path: <linux-kernel+bounces-310225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A330967680
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 14:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E431C21537
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 12:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7904617D374;
	Sun,  1 Sep 2024 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVkTrIw9"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5749016A938;
	Sun,  1 Sep 2024 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725194923; cv=none; b=o/t72xVVddA86SiYHqR0Mm8KW/+D2TzOyC4oKzAoKVKJhEdv11x6jSRtnVwe7Ud+eJfpLzN5wQmwMm0kZhBC759w44pSBL5S8fryDH6/4WIT7M9SLVA1m4FZiRO8nXnmvBQZkdcO6QMr0msl/c46tG1Zl3XzIMxnnIBfIsoxX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725194923; c=relaxed/simple;
	bh=samEHV0jUn7URIWtdg/4icgKiqYX0iRtvAJqyxfr5+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npfgkWRzeckLaI+y08u88y5r96vz4pJSKuredK0LVactTipfVjQBRTRVdGVi732W1NGLQVOufL4P82SvioHBc9aASbX3Pz1xIHmqXiawe4IX+9cGdz2+/RiwWM/ptemAQdVCuv/LREd38Fq4eSG7cUiRbBPZTIbWj+JDEIAgLZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVkTrIw9; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2d8a744aa9bso459282a91.3;
        Sun, 01 Sep 2024 05:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725194922; x=1725799722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EHDZ89ZCH8BG0OnvARBGCqyVQ1Az25bpqUNy0Tps9uM=;
        b=KVkTrIw9HI1RIn8aNf8niDvFUs/T/1RVIQiFcg7nK0EGoK9Yh6txWqOSGZF/F9+LJl
         6NKPFT23k2TJLedaF7hMbCZa9r9VdnBZZys6xClU5LpCdedr2R5kyg1knAMHfgyRSCIj
         RUrHFb1eggxKrq4CxYkLkoiWMC8+5Tkj9U/dKwnLr/rh/SGioM5Zsps47Q+X1C0Fpe+O
         0jnkaMfP/IJx/E5Fo9t6bu8CK4NVyHFQk4PvgAx90y5b94smyOJwD1pmM6iT9h4KFvl5
         zCPdOHYydESu307lYxnNYm3KXFsiixGQZ5Dwe2KZzJrihaylpVNzuOxXtkJBleOFLyxq
         HSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725194922; x=1725799722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHDZ89ZCH8BG0OnvARBGCqyVQ1Az25bpqUNy0Tps9uM=;
        b=vUBI9cP5H4UDOhkN9CKRrnRGZuit+RWENvULt1nADckTbwiI/ihVHxY1OftlDQwUGV
         AyxAPbotXhc8WaQhvkX+zd6KjhQZCjmQ8PokFNrIVCX8Y+Ot9uePFIzHLTGNDIgifM8Z
         dNkN/kWM1E3mbAjXfmuc4KQHiYDC7qD1g0cBa8Gfo3g2TqpGWcvY43j0m8oWnoiHMKSF
         nOeVzFzFxOguV35nyx11eNOhid1+z5TFGH36Y4G7dllYb1qdC1afhjBGmaq2TMmRi1XB
         yXyrPjfH+ktoycaNlxoT9e742vM15h1OjzZlSg/b2RsJVQLnmQYHLlECNlc4yrePNcNT
         TBzw==
X-Forwarded-Encrypted: i=1; AJvYcCVhhYhmB2C3vJhl7YURgjJo2T/vcCsh6jJYIB+nTzqS2VjsVdXXy+HOjrkeLL0AJ2Z/A+E3U25+LQQ=@vger.kernel.org, AJvYcCXDMq8Va2WhcHSEP+EJpQAejlk8Y4Uj+0WncRXWoRvP+bsStCWTMvC/4jbkWBeKbCS/B5trpT+hblIIVz7O@vger.kernel.org
X-Gm-Message-State: AOJu0YxIzHP2Z3vGQP4TFODDz+/crvjwXG/8fwzdwtjfe/rnwSTulm/o
	tQtfELEluupRY0qR3WxQ+D3mIgVg3yTagZ6M/oj+C/pehs4JY8NH
X-Google-Smtp-Source: AGHT+IHNPGYZH2Q3By8yr2BcK+qndvFwTyIiLLbuRFNZ+8D6GOScYCcHZ1bWib54ZWWoXTNPiT5bFA==
X-Received: by 2002:a17:902:f691:b0:203:a0c3:b342 with SMTP id d9443c01a7336-2054bc909a0mr27514865ad.9.1725194921590;
        Sun, 01 Sep 2024 05:48:41 -0700 (PDT)
Received: from [192.168.3.171] ([183.159.77.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b3343sm51993695ad.30.2024.09.01.05.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2024 05:48:41 -0700 (PDT)
Message-ID: <9eb5af0d-730c-459d-9c2e-5ad7b78f30d7@gmail.com>
Date: Sun, 1 Sep 2024 20:48:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] mm: Introduce a pageflag for partially mapped
 folios
To: Usama Arif <usamaarif642@gmail.com>, Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 yuzhao@google.com, david@redhat.com, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, ryncsn@gmail.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com, libang.li@antgroup.com,
 Lance Yang <ioworker0@gmail.com>
References: <20240819023145.2415299-1-usamaarif642@gmail.com>
 <20240819023145.2415299-5-usamaarif642@gmail.com>
 <CAGsJ_4yKuvMSazWABXqaeRr84hLEubET0nCUhPFYHQnfR4Tm8w@mail.gmail.com>
 <a09b6af0-4fdb-4ac1-9cbe-9b422ebc3308@gmail.com>
 <CAGsJ_4xeWt9n3zX3-DknE=NftkWS0fe2vKTJT9tLuJPM4EaEwg@mail.gmail.com>
 <9a58e794-2156-4a9f-a383-1cdfc07eee5e@gmail.com>
 <CAGsJ_4xiG+oGkjt3nf0Zh2rdztz8h_AaahZWs4N3UARhw7DcgQ@mail.gmail.com>
 <CAGsJ_4z2YL01wvVgsFsbzGAQ5KowXgxLcj=Y7DSX7ODOF5MUvw@mail.gmail.com>
 <953d398d-58be-41c6-bf30-4c9df597de77@gmail.com>
 <CAGsJ_4y49c8-hDgjNuqMZnNWfUT-ktxeqkfX0EQz4-Pu3x9-Dg@mail.gmail.com>
 <5ed479c9-21eb-4bc8-8c17-79e1b6081355@gmail.com>
Content-Language: en-US
From: Bang Li <libang.linux@gmail.com>
In-Reply-To: <5ed479c9-21eb-4bc8-8c17-79e1b6081355@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

hi, Usama

On 2024/8/22 3:04, Usama Arif wrote:

>
> On 20/08/2024 17:30, Barry Song wrote:
>
>> Hi Usama,
>> thanks! I can't judge if we need this partially_mapped flag. but if we
>> need, the code
>> looks correct to me. I'd like to leave this to David and other experts to ack.
>>
> Thanks for the reviews!
>
>> an alternative approach might be two lists? one for entirely_mapped,
>> the other one
>> for split_deferred. also seems ugly ?
>>
> That was my very first prototype! I shifted to using a bool which I sent in v1, and then a bit in _flags_1 as David suggested. I believe a bit in _flags_1 is the best way forward, as it leaves the most space in folio for future work.
>
>> On the other hand, when we want to extend your patchset to mTHP other than PMD-
>> order, will the only deferred_list create huge lock contention while
>> adding or removing
>> folios from it?
>>
> Yes, I would imagine so. the deferred_split_queue is per memcg/node, so that helps.
>
> Also, this work is tied to khugepaged. So would need some thought when doing it for mTHP.
>
> I would imagine doing underused shrinker for mTHP would be less beneficial compared to doing it for 2M THP. But probably needs experimentation.
>
> Thanks

Below is the core code snippet to support "split underused mTHP". Can we extend the
khugepaged_max_ptes_none value to mthp and keep its semantics unchanged? With a small
modification, Only folios with page numbers greater than khugepaged_max_ptes_none - 1
can be added to the deferred_split list and can be split. What do you think?

diff --git a/mm/memory.c b/mm/memory.c
index b95fce7d190f..ef503958d6a0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4789,6 +4789,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
         }

         folio_ref_add(folio, nr_pages - 1);
+       if (nr_pages > 1 && nr_pages > khugepaged_max_ptes_none - 1)
+               deferred_split_folio(folio, false);
         add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
         count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_FAULT_ALLOC);
         folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);

shmem THP has the same memory expansion problem when the shmem_enabled configuration is
set to always. In my opinion, it is necessary to support "split underused shmem THP",
but I am not sure if there is any gap in the implementation?

Bang
Thanks


