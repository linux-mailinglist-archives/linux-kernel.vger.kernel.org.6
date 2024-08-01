Return-Path: <linux-kernel+bounces-271029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2C89448B6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9606B2BC3C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D6D16FF39;
	Thu,  1 Aug 2024 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccK7F+BV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7503016F267
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505272; cv=none; b=qRBhjl7InKwlsBAMquaCF/OPGwED7QCzriENZGAMvuPeodvsi1LfulvwqgFA3YlzdEb8Li33df8Qqo8jE+dV2gtSU4/daGV/XogRaGws8ZPxiM035eSYTnY7PtwDc+45eE3YE21S8OQ6AVBvFJkqn3UNH0pmNdMFbm9LEuKZNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505272; c=relaxed/simple;
	bh=ORiPuve6s3gV3FKnSrCOt0lTBv88CkScw38pGfRTNts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fr4OU1e0c0/kG7A0V+puwf/gsv0LDXCpVuibCd3nsi/183uCpHFzlh5tid4ZylgIjgIxSaPU9OUTrP2yU+FefL7u0nOnEk8769wPoLJGMlix0SSIQevKDBrEK0s6fUKkaZ3srG81pfyUk8hjql83+tpmnuq8BTiOUZeixF5MQuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ccK7F+BV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722505269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JqaOCZP7dv3D/jOl/pWT+vlAhTBWLDEcV/CyJ7dI+tk=;
	b=ccK7F+BVOp5De5RtPNi6XHpyxX2gRqQO0KYloGbQcqJYkPOrEq2oDtdvo2DUeIQW4SL4Ch
	4BJOOLpaMeRhZKQPFbxkC30+OtSIfxM3y/yefA/6HQzRIa0+Et+XgUOgxF8LlcV8KjVy2j
	LXaH9ekIEWROTGuoVpYP75O9v7eb0JI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-rJy7NKZzPwCCrjvmW8jX9g-1; Thu, 01 Aug 2024 05:41:08 -0400
X-MC-Unique: rJy7NKZzPwCCrjvmW8jX9g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3687529b63fso2942261f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722505267; x=1723110067;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JqaOCZP7dv3D/jOl/pWT+vlAhTBWLDEcV/CyJ7dI+tk=;
        b=LBIeBXZJWiKtEcHiNmCl/l1ATb/vw42YXpNXG0g+3eBDZHumFsqwpPy5RMQOnxhL/M
         sILcc+CayJCfVhpBO8l4JpKg8+GfvqgkIqn7sG5ubVyU31fiQ3FJvvdX2LlALEZg+mAV
         hTBqY+4s1rcP1ypnb60OFK/SvTumyf41oh3SfhHE/fDBEP/Xg3kU+7X2hVwb7EdpMkH1
         kY00ZhGGyMdTt5Eghwg274d7tmNBfLirkDBU6u5cYHBh+pZuiI6XZkwD8ccL6WjMFlcm
         6SRA6oSx2JH3qqjt56O4X1bhThW8945HcQRFNNBzIHJUsLsgeH4xS+NyQkX6vX/Vcu+7
         Bbiw==
X-Forwarded-Encrypted: i=1; AJvYcCUDx0H1ZqLK5s/pjg+kEEz0FWVOtW3q++Np1vydwu0uylW2iovScX0ODwQodsFGcf7LJHsnGJg0NFx5ChLGYgDszpcXpZMo2DE/JuKy
X-Gm-Message-State: AOJu0YzsCj1tsSCMLyq47SQHZ3ZEHN+qUPTdlNXG92Z9JQIee2P2XbU6
	M+4dd5KGNoMx31uuQsA8jB/VBAlCkNLKrj2QvrE+kaU6msU03PXQN20QC0wEdMr1g1tK+skKB86
	49puyGrZBgRY9KgzjlhL9KoLQ7i5ZuHnTDHpAHOowFB7X8FF6hLNBuLaC74Zk8g==
X-Received: by 2002:a05:6000:c44:b0:367:8a00:fac3 with SMTP id ffacd0b85a97d-36baade6840mr1238159f8f.30.1722505267035;
        Thu, 01 Aug 2024 02:41:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUXSfCLweNJWwgc+QabjZVMvT0mNLyetEJuPNRBQl0zNI7lyZZSfLnIIlE8dXeHZBbubBd5A==
X-Received: by 2002:a05:6000:c44:b0:367:8a00:fac3 with SMTP id ffacd0b85a97d-36baade6840mr1238131f8f.30.1722505266425;
        Thu, 01 Aug 2024 02:41:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5c00:e650:bcd7:e2a0:54fe? (p200300cbc7075c00e650bcd7e2a054fe.dip0.t-ipconnect.de. [2003:cb:c707:5c00:e650:bcd7:e2a0:54fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0668sm18975127f8f.10.2024.08.01.02.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 02:41:05 -0700 (PDT)
Message-ID: <a6a38ad5-c754-44ad-a64b-f9ea5b764291@redhat.com>
Date: Thu, 1 Aug 2024 11:41:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race condition observed between page migration and page fault
 handling on arm64 machines
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
 willy@infradead.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 osalvador@suse.de, baolin.wang@linux.alibaba.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 ioworker0@gmail.com, gshan@redhat.com, mark.rutland@arm.com,
 kirill.shutemov@linux.intel.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240801081657.1386743-1-dev.jain@arm.com>
 <3b82e195-5871-4880-9ce5-d01bb751f471@redhat.com>
 <bbe411f2-4c68-4f92-af8c-da184669dca8@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <bbe411f2-4c68-4f92-af8c-da184669dca8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.08.24 11:38, Dev Jain wrote:
> 
> On 8/1/24 14:12, David Hildenbrand wrote:
>> On 01.08.24 10:16, Dev Jain wrote:
>>> I and Ryan had a discussion and we thought it would be best to get
>>> feedback
>>> from the community.
>>>
>>> The migration mm selftest currently fails on arm64 for shared anon
>>> mappings,
>>> due to the following race:
>>
>> Do you mean MAP_SHARED|MAP_ANON or MAP_PRIVATE|MAP_ANON_fork? Because
>> you note shmem below, I assume you mean MAP_SHARED|MAP_ANON
> 
> 
> Yes.
> 
>>
>>>
>>> Migration:                        Page fault:
>>> try_to_migrate_one():                    handle_pte_fault():
>>> 1. Nuke the PTE                        PTE has been deleted =>
>>> do_pte_missing()
>>> 2. Mark the PTE for migration                PTE has not been deleted
>>> but is just not "present" => do_swap_page()
>>>
>>
>> In filemap_fault_recheck_pte_none() we recheck under PTL to make sure
>> that a temporary pte_none() really was persistent pte_none() and not a
>> temporary pte_none() under PTL.
>>
>> Should we do something similar in do_fault()? I see that we already do
>> something like that on the "!vma->vm_ops->fault" path.
>>
>> But of course, there is a tradeoff between letting migration
>> (temporarily) fail and grabbing the PTL during page faults.
> 
> 
> To dampen the tradeoff, we could do this in shmem_fault() instead? But
> then, this would mean that we do this in all
> 
> kinds of vma->vm_ops->fault, only when we discover another reference
> count race condition :) Doing this in do_fault()
> 
> should solve this once and for all. In fact, do_pte_missing() may call
> do_anonymous_page() or do_fault(), and I just
> 
> noticed that the former already checks this using vmf_pte_changed().

What I am still missing is why this is (a) arm64 only; and (b) if this 
is something we should really worry about. There are other reasons 
(e.g., speculative references) why migration could temporarily fail, 
does it happen that often that it is really something we have to worry 
about?

-- 
Cheers,

David / dhildenb


