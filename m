Return-Path: <linux-kernel+bounces-172788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5481C8BF6CC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CB61C21656
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BD528373;
	Wed,  8 May 2024 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbL5Ctkq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAC524B33
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715152380; cv=none; b=KaxAfG0klP0DLivlnWi9xLnBtPbj4jL/CV4ELARBXV6nP3/SVXLdx764zsh+lCfg66keOmQHK/70JGedGzh2IfkzC3CqrkqniqaFUq51zEjvwa7SSZVkmkhks7XuHTaS6VRMlYE9sUku8HQ59vkVbtBVySIKmPa3BxZfwQeabfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715152380; c=relaxed/simple;
	bh=CXY8CAjjH2LAn2DZu+w2LcTYznjvPU8MitE5Af/sm+U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=E8f19LRyKO2DrRR0Q2p9buO7GHCMxRugN5LdfsM2eVqrCLKfl7vEFoZgIYn7sBz3GM+kejeKmtRFewz5Mx72watpL+2vJzPRRvWi3C3yrQJkaj17T+cPF6hXIWPu9vfsnxTGn+YtOfc/fzMkvvDbpJG9alrf3XNxQjl2Wvz9AT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbL5Ctkq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715152377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6rW4wJ33EkBWxqc3YAFkR2q+QRdmV4hBDk0pwGvIydY=;
	b=IbL5CtkqUJ4F98dMY11or8pY8btBF2OCOPHH3oCMs8SUkMNDvYsuGNWz5LSsJ4uUScyfIv
	NQDxCGzvtqb/euBFoSJlifdwBFBKxIQZshjeODwWIk5s/r+XC8dcbaLDPxJ39wMjYZ3Sf4
	Q+acyHa/mbVBJCqkUkMLP3o3HJoiGqc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-xl6JVC2KMRqf-rop2XRW3A-1; Wed, 08 May 2024 03:12:56 -0400
X-MC-Unique: xl6JVC2KMRqf-rop2XRW3A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34fcf649d5dso328582f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 00:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715152375; x=1715757175;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6rW4wJ33EkBWxqc3YAFkR2q+QRdmV4hBDk0pwGvIydY=;
        b=Lx5MleMXbIh5MB/j50AmjZofPlhfN9IGtx/r5dg0kY/k9ppVTIzAvYEfYaxUKKsmG2
         Zc1ui3KnZ+Y2ioBn6mDSK1gMRYWTWYMz6efyN/BSiFyQQHfj5cGlay+z6LgKWONLu1hH
         npvma0zJEpvPPRC0ylIx7OT+KUHCeMno44KsBOH/+d0RfU07tb6q5aPwKDovczlhg34B
         bwRt9UKhIosTz0k0apOB0k4dAmpL1L02gB05urdY5HYb4NT3iyu7tYpADINFc0/XEaNV
         c3S0kGT8LKcCcUNxFHUMj/GbNXjgbPdKOrqwqoQcnsXrY2OA9DiEZe+BLeRqyn7Miuil
         HHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLgJphHuPBDz5lNgt/uSLY77kGSsudvhqChxSlATiG5cJI5HGP+GWERawDwu+GOchXWKOnyoWFQMIXYohOzZUW7xqGSCIIKTCEfV9z
X-Gm-Message-State: AOJu0YwgPK/XTcizt16skOxYnHhBzCeudli9jhMAHoSaDQWngX4mEkrb
	VD5QQC/J4Ntq/rDGFJ0iThI4FxSQykc2vIIyC8g/HBDugq8oHfDBApF3cCy2YrCHp716RKBd4Ok
	mVBKrbTWba4zw5JtuWx08TeHMVvPJmA5CQU7O4G4H7gwepouhTcntLHo/Vk/fpg==
X-Received: by 2002:adf:a388:0:b0:34d:118f:21ee with SMTP id ffacd0b85a97d-34fca2428f8mr1246045f8f.28.1715152375135;
        Wed, 08 May 2024 00:12:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZZupsg1Db/5JE5dUmFPCueW4kf8DoanWM6rHkv8I5Eu8zlJOQv4ibsbNV5d/M0ESqjYAQPw==
X-Received: by 2002:adf:a388:0:b0:34d:118f:21ee with SMTP id ffacd0b85a97d-34fca2428f8mr1246009f8f.28.1715152374591;
        Wed, 08 May 2024 00:12:54 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6bc3.dip0.t-ipconnect.de. [91.12.107.195])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d64a1000000b0034edd6d5bbdsm8882608wrp.7.2024.05.08.00.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 00:12:54 -0700 (PDT)
Message-ID: <ff1908f8-0887-403b-8d2a-d83a17895523@redhat.com>
Date: Wed, 8 May 2024 09:12:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] mm: shmem: add multi-size THP sysfs interface for
 anonymous shmem
From: David Hildenbrand <david@redhat.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ying.huang@intel.com, 21cnbao@gmail.com, shy828301@gmail.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <6b4afed1ef26dbd08ae9ec58449b329564dcef3e.1714978902.git.baolin.wang@linux.alibaba.com>
 <30329a82-45b9-4e78-8c48-bd56af113786@arm.com>
 <0b3735bc-2ad7-44f8-808b-37fc90d57199@linux.alibaba.com>
 <cb458b62-e27d-47d6-8efd-bacdb9da7530@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <cb458b62-e27d-47d6-8efd-bacdb9da7530@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.05.24 09:08, David Hildenbrand wrote:
> On 08.05.24 06:45, Baolin Wang wrote:
>>
>>
>> On 2024/5/7 18:52, Ryan Roberts wrote:
>>> On 06/05/2024 09:46, Baolin Wang wrote:
>>>> To support the use of mTHP with anonymous shmem, add a new sysfs interface
>>>> 'shmem_enabled' in the '/sys/kernel/mm/transparent_hugepage/hugepages-kB/'
>>>> directory for each mTHP to control whether shmem is enabled for that mTHP,
>>>> with a value similar to the top level 'shmem_enabled', which can be set to:
>>>> "always", "inherit (to inherit the top level setting)", "within_size", "advise",
>>>> "never", "deny", "force". These values follow the same semantics as the top
>>>> level, except the 'deny' is equivalent to 'never', and 'force' is equivalent
>>>> to 'always' to keep compatibility.
>>>
>>> We decided at [1] to not allow 'force' for non-PMD-sizes.
>>>
>>> [1]
>>> https://lore.kernel.org/linux-mm/533f37e9-81bf-4fa2-9b72-12cdcb1edb3f@redhat.com/
>>>
>>> However, thinking about this a bit more, I wonder if the decision we made to
>>> allow all hugepages-xxkB/enabled controls to take "inherit" was the wrong one.
>>> Perhaps we should have only allowed the PMD-sized enable=inherit (this is just
>>> for legacy back compat after all, I don't think there is any use case where
>>> changing multiple mTHP size controls atomically is actually useful). Applying
>>
>> Agree. This is also our usage of 'inherit'.

Missed that one: there might be use cases in the future once we would 
start defaulting to "inherit" for all knobs (a distro might default to 
that) and default-enable THP in the global knob. Then, it would be easy 
to disable any THP by disabling the global knob. (I think that's the 
future we're heading to, where we'd have an "auto" mode that can be set 
on the global toggle).

But I am just making up use cases ;) I think it will be valuable and 
just doing it consistently now might be cleaner.

-- 
Cheers,

David / dhildenb


