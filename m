Return-Path: <linux-kernel+bounces-274031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E85947189
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 01:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A07D280E1B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 23:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7144413B29F;
	Sun,  4 Aug 2024 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je6wmkQb"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB06926AF3;
	Sun,  4 Aug 2024 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722812667; cv=none; b=EMgAW/RJVHqx1PSEP2e2N1/JELa41nJ+AIA73Bml8mKkVj9/aYB7vtUuknvTD90fDWAegopXwTG9PzcV16b7TWg7Xg5SBH0TmPJa1RJ+834U6YXj1q/2Hujdb1VOrkSixe7yHy6X4TFtdvxS+/D7/vQK8msVtU4CdvXSngUj3gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722812667; c=relaxed/simple;
	bh=/mvJuqzbxHk/yVXjnu/OzajnDrpnxKl29YyqwZc+3us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihDvrLXKHw7BWrJIJg0qYSexdeRoIq+fSZBgbgVOj8b1ui6z/6g/7pNUP110Azb50OEReClxfV0JsaN8U71OQjUfbhn2pQRuaalEb3Q0ewoxq/e1iDnFCCwKkzSvj+ugQOgyePqaEMl7Mu/p1qsHo8Uj73GFW5ThBj49SG5ok5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je6wmkQb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso68952375e9.0;
        Sun, 04 Aug 2024 16:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722812664; x=1723417464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sk1dtiHwwmKlrxqNQkxNJP5+HAxZZqo3ycqfI2UvHWw=;
        b=Je6wmkQbO91PFlIFiG5XMSUKTiIfA5yX5BbtlLPDMGAqGuADVSVH/vDQssyCqcrowN
         teJtetLfb83aPzoCTpCcfVFvjkmSfqna4cxRBiP30pPSm2bVuIp06KXxMcto0cN6yFHR
         zjg71DW2ZpXZPuSxahhtRz/eMvLqN8BfZWVPK9MXjTKKwmClb1jOrVmT7sIRzpvrbA3P
         vGAA2pPb1s6kgaBukZ0TQxdorNAIQAuQmNz0ZlGJAvY27DCjgQ7NfA3kKERuJ7DKbEuP
         JKV/z71o4iUrCj+qnAZqPkXjpLDHpysNiWRSZgj5i/HrRPYQ/AtszV572/LDJVPNjThG
         DyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722812664; x=1723417464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk1dtiHwwmKlrxqNQkxNJP5+HAxZZqo3ycqfI2UvHWw=;
        b=RcogmH60g9s4vOPNU2Uyuiq+YZ6BmubEDlSlDdVubp63h5HhMHi56U1xcWdSmMosyv
         Fagl5UcFMzmZhWzVsE1bTL4kSPF1NeBcZ8dkhLRQICIFT2Yr2jV8lcCwSu7l1uvMkn/c
         NokgS42jdsz6968lgKF9n2TW75kGnK8ysbkOxcw58hYN7DH+Yn5Gb+AMXQgSXeM1o2Rt
         Wc8aKznra45UQw9IJXsnXYLRPpKMyFCCcLEQ/rjWvPEBXHeCjC+ofCLHeuxd/xt+i6qy
         rhqKbBnssBtsgCrhPwAWQ7rgngcDsusBZw8+DJQSsm/4woq+ZhfEC+l4zGuyfgGiP3Yq
         Kdxw==
X-Forwarded-Encrypted: i=1; AJvYcCV66WdDAP6eiPV6uJZx2poxq9ZB8gR/s6NKNrMGYPhI/msNLYk6EE9Jimq4VTQo1CmpKSOA4OPBJtaKXLSqVFKVvcNLW+AcmNMdCMCVlW5MF+upWcJ0L5aRxDbS2p5Xgpi3HlzLN4TF
X-Gm-Message-State: AOJu0Yzw3k+sM81SLh6wRXbK23mR0l30n1iuW1Kys8hEV9ZssrQjOVwG
	ZufGrnQPkVT/UpALDrk0ROk9M+dCJoktPq3g6L5Fp9l8xQ5/Wl/a
X-Google-Smtp-Source: AGHT+IE6OhiyMfW628st/dncl7sEGRh5oHdDYLCxtbrvUNoY3hxLjELfYegePbKghQvkqMn0qh3UBQ==
X-Received: by 2002:a05:600c:19cd:b0:426:5cee:4abc with SMTP id 5b1f17b1804b1-428e6b07cc9mr68917585e9.20.1722812663814;
        Sun, 04 Aug 2024 16:04:23 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89aa93sm176367475e9.10.2024.08.04.16.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 16:04:23 -0700 (PDT)
Message-ID: <930e111a-b13b-43d9-93f8-5bf28f343074@gmail.com>
Date: Mon, 5 Aug 2024 00:04:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
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
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <58025293-c70f-4377-b8be-39994136af83@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/08/2024 07:36, David Hildenbrand wrote:
>>> I just added a bunch of quick printfs to QEMU and ran a precopy+postcopy live migration. Looks like my assumption was right:
>>>
>>> On the destination:
>>>
>>> Writing received pages during precopy # ram_load_precopy()
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Disabling THP: MADV_NOHUGEPAGE # postcopy_ram_prepare_discard()
>>> Discarding pages # loadvm_postcopy_ram_handle_discard()
>>> Discarding pages
>>> Discarding pages
>>> Discarding pages
>>> Discarding pages
>>> Discarding pages
>>> Discarding pages
>>> Registering UFFD # postcopy_ram_incoming_setup()
>>>
>>
>> Thanks for this, yes it makes sense after you mentioned postcopy_ram_incoming_setup.
>> postcopy_ram_incoming_setup happens in the Listen phase, which is after the discard phase, so I was able to follow in code in qemu the same sequence of events that the above prints show.
> 
> 
> I just added another printf to postcopy_ram_supported_by_host(), where we temporarily do a UFFDIO_REGISTER on some test area.
> 
> Sensing UFFD support # postcopy_ram_supported_by_host()
> Sensing UFFD support
> Writing received pages during precopy # ram_load_precopy()
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Disabling THP: MADV_NOHUGEPAGE # postcopy_ram_prepare_discard()
> Discarding pages # loadvm_postcopy_ram_handle_discard()
> Discarding pages
> Discarding pages
> Discarding pages
> Discarding pages
> Discarding pages
> Discarding pages
> Discarding pages
> Discarding pages
> Discarding pages
> Discarding pages
> Discarding pages
> Discarding pages
> Discarding pages
> Discarding pages
> Discarding pages
> Registering UFFD # postcopy_ram_incoming_setup()
> 
> We could think about using this "ever user uffd" to avoid the shared zeropage in most processes.
> 
> Of course, there might be other applications where that wouldn't work, but I think this behavior (write to area before enabling uffd) might be fairly QEMU specific already.
> 
> Avoiding the shared zeropage has the benefit that a later write fault won't have to do a TLB flush and can simply install a fresh anon page.
> 

I checked CRIU and that does a check at the start as well before attempting to use uffd: https://github.com/checkpoint-restore/criu/blob/criu-dev/criu/kerndat.c#L1349

If writing to an area before enabling uffd is likely to be QEMU specific, then you make a good point to clear pte instead of using shared zeropage to avoid the TLB flush if uffd is ever used.

I think "ever used uffd" would need to be tracked using mm_struct. This also won't cause an issue if the check is done in a parent process and the actual use is in a forked process, as copy_mm should take care of it.
The possibilities would then be:
1) Have a new bit in mm->flags, set it in new_userfaultfd and test it in try_to_unmap_unused, but unfortunately all the bits in mm->flags are taken.
2) We could use mm->def_flags as it looks like there is an unused bit (0x800) just before VM_UFFD_WP. But that makes the code confusing as its used to initialize the default flags for VMAs and is not supposed to be used as a "mm flag".
3) Introducing mm->flags2 and set/test as 1. This would introduce a 8 byte overhead for all mm_structs.

I am not sure either 2 or 3 are acceptable upstream, unless there is a need for more flags in the near future and the 8 byte overhead starts to make sense. Maybe we go with shared zeropage?

