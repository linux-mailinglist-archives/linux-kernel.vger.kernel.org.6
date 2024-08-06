Return-Path: <linux-kernel+bounces-276644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDC0949682
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF311C22E1A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B5E481A3;
	Tue,  6 Aug 2024 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ+j6qT3"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373CB15E8B;
	Tue,  6 Aug 2024 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964659; cv=none; b=p5x/wurifZKvAUvIqjjUyRmLiKXH3cJYaOE+kEvDdMygElw+E4nKPdNl9gdpE+Lwcd7rS/qtlLQCrGiCNXuQO2JRweik04TO4AkRqSMNz9/8wzNyvHqVBFx00u/f/Lyrm0oEPW1ur+C4rJtYzhGCtbnHotLgnP+GzGN7xdHMmfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964659; c=relaxed/simple;
	bh=phyWWTU0EUxG9zR0LDR7MZl+8Bc7Rj6a46djkxmxiy4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IZllJOs2rT8ziWh3H9kACyo2dwau1ZIWRpPAwq7JvvV7dQ8MeA9oAR7i06ukB/g6D/G5hLz0AnXEAw+Qld9Qgm8a4NaTghCvFSctZ76dd142KKnBqa2DFDQ7er0KhNbWwHxZiyhlvuuqRwI/SYXqw2KIIIo+gVHeMAwk0ox/WLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZ+j6qT3; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bb477e3a6dso1078792a12.0;
        Tue, 06 Aug 2024 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722964655; x=1723569455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U5E3m3xR2f5j4NfA6FT6lRNRwGjOhVrtBrgm3G/5l/c=;
        b=dZ+j6qT3DdE86PjDzwoZ7KfAxuEu8TFRrUNqFwpHbZ4dSUHn7GVy8iyD1ZQOQ4KUQZ
         Fu/GrL3dSJaVkmatGQyJQlRGmKf+/to9kRec0l18+puu13H1xu0y2G1XCFv31IR3IKb+
         0OBEnls8W/+REcGIieY+ubj3PuUB+6rSubcLOOr6N4e9kKFSzIa6WEhgKJ/Ge+wpVgQO
         1SNDeIrjxqo/E/oHFzZvuxFTTBi37HFdkBPbroHzITMerVO1kBpkOxGx11CgIObYrxm2
         MrWJzh6EgIN2R+noz77SGZ/O+S8rTqFSTAUPe4JNUN+qXsNCuK8LgKK/IiC279LUjmRh
         9D7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964655; x=1723569455;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U5E3m3xR2f5j4NfA6FT6lRNRwGjOhVrtBrgm3G/5l/c=;
        b=ENvZY00kfAWFfRG5Oh625lquUbixn7mypvhgSN65SNj3+ErGiGS35OthZUNlW4rbUc
         qNsp4+b4Qtc9oMYEOVEfxBqOWktlMebzh+tFxasIZU5s3ampznO5ZY8kqV4ecl3omisi
         qDsfNJck1SY3ZCR5AzAvMoYX7/hXtDUH/YODJxZIeWTvse74QqTxR0Wa7+K1xT8F5QwJ
         ADmZ+b1dWGGJutq2rknHL5V5+b/RVxlZJIi1TBZeN7r86pdCtnMQQ8uwmwOCASdbWMF6
         8PyLcuIWk6cNRi+Byg19lNxozZIZk2RRoiEVrhtnsxuso44sH1J7DPbcJFNhi9OgTANn
         8mAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSNzD7wAk6uOtbhV1YwVoHHfZThp8YX66dTL2PVVVqUNqk6Zjp/j24V/qm15fr16dgCIMWAMC0SXjjmd86DhVXn5cjCOJpXwVb1cRoFd/0ukWzlqFfNJE/QPm1cgunbdftzbAviM3h
X-Gm-Message-State: AOJu0YxQiKBuxJja4wS/FUqom4G9ucmBE8FchVRriPAp+1d7Tcb8rI9o
	/ys1fy5CwmXgPIXLpUMlUdqiCeQB8blnz+sEon/GB6C6p/IVTYa2
X-Google-Smtp-Source: AGHT+IE96P5l565yxy94zPgJ5U259m/KIM58yGVqtb9APjL9+gBFDafoZMbLnDv59z5jDGB+gViYCA==
X-Received: by 2002:a17:907:9801:b0:a7a:c083:857b with SMTP id a640c23a62f3a-a7dc5070469mr1087953266b.42.1722964655064;
        Tue, 06 Aug 2024 10:17:35 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:c24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c12ff1sm566452466b.58.2024.08.06.10.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 10:17:34 -0700 (PDT)
Message-ID: <842f3fd3-9d95-4050-8bed-9631a6adca6d@gmail.com>
Date: Tue, 6 Aug 2024 18:17:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
From: Usama Arif <usamaarif642@gmail.com>
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <dc00a32f-e4aa-4f48-b82a-176c9f615f3e@redhat.com>
 <3cd1b07d-7b02-4d37-918a-5759b23291fb@gmail.com>
 <73b97a03-3742-472f-9a36-26ba9009d715@gmail.com>
 <95ed1631-ff62-4627-8dc6-332096e673b4@redhat.com>
 <01899bc3-1920-4ff2-a470-decd1c282e38@gmail.com>
 <4b9a9546-e97b-4210-979b-262d8cf37ba0@redhat.com>
 <64c3746a-7b44-4dd6-a51b-e5b90557a30a@gmail.com>
 <fc63e14d-8269-4db8-9ed2-feb2c5b38c6c@redhat.com>
 <204af83b-57ec-40d0-98c0-038bfeb393a3@gmail.com>
 <58025293-c70f-4377-b8be-39994136af83@redhat.com>
 <930e111a-b13b-43d9-93f8-5bf28f343074@gmail.com>
Content-Language: en-US
In-Reply-To: <930e111a-b13b-43d9-93f8-5bf28f343074@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/08/2024 00:04, Usama Arif wrote:
> 
> 
> On 01/08/2024 07:36, David Hildenbrand wrote:
>>>> I just added a bunch of quick printfs to QEMU and ran a precopy+postcopy live migration. Looks like my assumption was right:
>>>>
>>>> On the destination:
>>>>
>>>> Writing received pages during precopy # ram_load_precopy()
>>>> Writing received pages during precopy
>>>> Writing received pages during precopy
>>>> Writing received pages during precopy
>>>> Writing received pages during precopy
>>>> Writing received pages during precopy
>>>> Writing received pages during precopy
>>>> Writing received pages during precopy
>>>> Writing received pages during precopy
>>>> Writing received pages during precopy
>>>> Writing received pages during precopy
>>>> Writing received pages during precopy
>>>> Writing received pages during precopy
>>>> Writing received pages during precopy
>>>> Writing received pages during precopy
>>>> Writing received pages during precopy
>>>> Writing received pages during precopy
>>>> Writing received pages during precopy
>>>> Disabling THP: MADV_NOHUGEPAGE # postcopy_ram_prepare_discard()
>>>> Discarding pages # loadvm_postcopy_ram_handle_discard()
>>>> Discarding pages
>>>> Discarding pages
>>>> Discarding pages
>>>> Discarding pages
>>>> Discarding pages
>>>> Discarding pages
>>>> Registering UFFD # postcopy_ram_incoming_setup()
>>>>
>>>
>>> Thanks for this, yes it makes sense after you mentioned postcopy_ram_incoming_setup.
>>> postcopy_ram_incoming_setup happens in the Listen phase, which is after the discard phase, so I was able to follow in code in qemu the same sequence of events that the above prints show.
>>
>>
>> I just added another printf to postcopy_ram_supported_by_host(), where we temporarily do a UFFDIO_REGISTER on some test area.
>>
>> Sensing UFFD support # postcopy_ram_supported_by_host()
>> Sensing UFFD support
>> Writing received pages during precopy # ram_load_precopy()
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Disabling THP: MADV_NOHUGEPAGE # postcopy_ram_prepare_discard()
>> Discarding pages # loadvm_postcopy_ram_handle_discard()
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Registering UFFD # postcopy_ram_incoming_setup()
>>
>> We could think about using this "ever user uffd" to avoid the shared zeropage in most processes.
>>
>> Of course, there might be other applications where that wouldn't work, but I think this behavior (write to area before enabling uffd) might be fairly QEMU specific already.
>>
>> Avoiding the shared zeropage has the benefit that a later write fault won't have to do a TLB flush and can simply install a fresh anon page.
>>
> 
> I checked CRIU and that does a check at the start as well before attempting to use uffd: https://github.com/checkpoint-restore/criu/blob/criu-dev/criu/kerndat.c#L1349
> 
> If writing to an area before enabling uffd is likely to be QEMU specific, then you make a good point to clear pte instead of using shared zeropage to avoid the TLB flush if uffd is ever used.
> 
> I think "ever used uffd" would need to be tracked using mm_struct. This also won't cause an issue if the check is done in a parent process and the actual use is in a forked process, as copy_mm should take care of it.
> The possibilities would then be:
> 1) Have a new bit in mm->flags, set it in new_userfaultfd and test it in try_to_unmap_unused, but unfortunately all the bits in mm->flags are taken.
> 2) We could use mm->def_flags as it looks like there is an unused bit (0x800) just before VM_UFFD_WP. But that makes the code confusing as its used to initialize the default flags for VMAs and is not supposed to be used as a "mm flag".
> 3) Introducing mm->flags2 and set/test as 1. This would introduce a 8 byte overhead for all mm_structs.
> 
> I am not sure either 2 or 3 are acceptable upstream, unless there is a need for more flags in the near future and the 8 byte overhead starts to make sense. Maybe we go with shared zeropage?


There is an another option to use bit 32 of mm->flags for 64 bit kernel only for ever_used_uffd, but considering the 2 reasons below, I will send a v2 of the series (in a few days incase any more comments come up) with shared zeropage in all circumstances (and addressing the comments in the other patches).
- "ever used uffd" is not a 100% safe, i.e. someone might not check uffd support before using it and do the same sequence of events as qemu precopy + postcopy (+ some bitmap to track and check whether to request a page from uffd handler). Its very unlikely that anyone else does this, but we have to cater for all current and future usecases.
- If THP shrinker is splitting and pointing pages to a shared zeropage, then the page was considered "unused" and unlikely to have a write fault at some point in the near future, hence the probability of incurring that TLB flush on write fault is low.

