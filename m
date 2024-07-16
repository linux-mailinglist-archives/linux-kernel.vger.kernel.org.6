Return-Path: <linux-kernel+bounces-253238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B264931E78
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E0E282B88
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565174C7B;
	Tue, 16 Jul 2024 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiL3d261"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B711A1BF40
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 01:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721093015; cv=none; b=rUOpmpzQJ1pz0sFITiZom9j3GADtQvNXw9DptP2vwQJ2anmIlSLoxjF75gQNncPdY5+QAQRc/kGIhVDhnhlai//XJYmv9M3pD3qWXQSN1a5RLLqjZuL3Q2B9BYvtteEXd6i70BxXT8cyTigFyrG7OMrmiOfQWcMLsgmQEa8UZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721093015; c=relaxed/simple;
	bh=NimheLaqqm77C7NRwA++au2HU3MagG+bRyh5Di35wYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sEjS0Rh+CtCGeWlojMiVVSkFOpj+Xwj4w++2d7B+Muy7/mZXy26bsolE4Cl6pP56UXDjiYNqH6K2Bmg1LrUztrZKKzsftcuQjNHJfDnfN6oalxMbWi2h61fVBJ9j2dd+kM6lEojBKk3A9isq/7arq2wPPirWc+s3JQA87UvZRww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiL3d261; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7035b2947a4so2865495a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 18:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721093013; x=1721697813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUb+h4iR+SfupLLuXHRz6dRkSTTMmLi3YHN8v82yLpI=;
        b=GiL3d261hgSDQO4t7U3PTZP1t8DeA6S6T7EMrlDBpIwAzUX4COIPDEylPXrcAT2yWv
         JIeBEk4QpWld/kzN3ZYnIGt/WYWWrAw3NtLdFxsq7Bklf4ZhRsMrPt5IG2dGGbieFGCk
         liECeqgn/1FUnDkCtddPfUwc2SXaiugmVsxW2GMT60XwZciZfcr/TUyUyG0uvVP8stP1
         E96o09I/n5jyUZz9+QgunIVTAiR7d4MdfZJTb+RsEUypzmGtdm89qO2wuKJvrnIq0khc
         dAHySoJOUq+iPJkwvv/0qLRIMAF6cDDgfM0l/GNR9jwhZFm9+/oUCLNNVNOgGUacGHNn
         XkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721093013; x=1721697813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUb+h4iR+SfupLLuXHRz6dRkSTTMmLi3YHN8v82yLpI=;
        b=b07dE95ocFNOILFhh/qCvbMv0S/ZjSu4urs02F+oz9/UtUH1/Q6W6ClYk0aMWy05Y7
         vXFXqnuvyH1OnpWygs9wLeSaYJ6jlIhmGTCj/Dcn/KfEvHa3g5FyI4aUAcNfFMXkvsa2
         jqYHq8Q1SSR23z2sib0YrgFjoviFiQ9a32RtzG0SsP1J981noZCkqa+bBf9n/Wn7myFC
         BUjmrQ5pSN8Tf17BZJZW5+Bv2BpV7vq1HF+a5wrHIct/YwVt15DlhFHgl8QAcms2+JSJ
         mVBZS0QXQ8zPu0vtD/LVR97S8etGh4K8gQCuk2aCZJkxMX0tIRVVz+BS6vrnUKC/rqog
         Aqmw==
X-Forwarded-Encrypted: i=1; AJvYcCXpVce7URur+7z3ltUBRoyIwZqfMgxzHAhGtD7lKen3VSPF8E7PpeDcvAqTJXNK+2LY2YDLwcgSHi1ksniZzYncHxmELtLLKhk7K/yv
X-Gm-Message-State: AOJu0YyIzfStZyp8CgZsoLZ/UWGXZh+utzWXM91quAQHvS940q9pBptl
	A4b+kdLbYYXoCnVv9plcSF4X/eo7kf3gU/n+3j3r8dQjR60ysKk+
X-Google-Smtp-Source: AGHT+IH697lcHbRfq1jAnm9ryPLu+CgJ6tkqoTRWEM2EE1y+piw3W7TlglpeV/tGI4U4D5mO5A6xIw==
X-Received: by 2002:a05:6830:6302:b0:703:62c8:b247 with SMTP id 46e09a7af769-708d9be4484mr950244a34.35.1721093012720;
        Mon, 15 Jul 2024 18:23:32 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708c0c7f4f1sm1171650a34.35.2024.07.15.18.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 18:23:32 -0700 (PDT)
Message-ID: <4c9ab413-2d05-4cec-9d37-a7ea3b5941c8@gmail.com>
Date: Mon, 15 Jul 2024 20:23:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme_core: scan namespaces asynchronously
To: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>, Martin Wilck <martin.wilck@suse.com>,
 Ayush Siddarath <ayush.siddarath@dell.com>
References: <20240715203434.20212-1-stuart.w.hayes@gmail.com>
 <76fbe503-a8e7-47aa-9335-6e0a90cba4c2@grimberg.me>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <76fbe503-a8e7-47aa-9335-6e0a90cba4c2@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/15/2024 5:28 PM, Sagi Grimberg wrote:
> 
> 
> On 15/07/2024 23:34, Stuart Hayes wrote:
>> Use async function calls to make namespace scanning happen in parallel.
>>
>> Without the patch, NVME namespaces are scanned serially, so it can take
>> a long time for all of a controller's namespaces to become available,
>> especially with a slower (TCP) interface with large number of
>> namespaces.
>>
>> It is not uncommon to have large numbers (hundreds or thousands) of
>> namespaces on nvme-of with storage servers.
>>
>> The time it took for all namespaces to show up after connecting (via
>> TCP) to a controller with 1002 namespaces was measured on one system:
>>
>> network latency   without patch   with patch
>>       0                 6s            1s
>>      50ms             210s           10s
>>     100ms             417s           18s
>>
>> Measurements taken on another system show the effect of the patch on the
>> time nvme_scan_work() took to complete, when connecting to a linux
>> nvme-of target with varying numbers of namespaces, on a network of
>> 400us.
>>
>> namespaces    without patch   with patch
>>       1            16ms           14ms
>>       2            24ms           16ms
>>       4            49ms           22ms
>>       8           101ms           33ms
>>      16           207ms           56ms
>>     100           1.4s           0.6s
>>    1000          12.9s           2.0s
> 
> Not sure how common is the 1000 namespaces use-case, but the dozens of namespaces
> seems compelling enough.
> 
>>
>> On the same system, connecting to a local PCIe NVMe drive (a Samsung
>> PM1733) instead of a network target:
>>
>> namespaces    without patch   with patch
>>       1            13ms           12ms
>>       2            41ms           13ms
>>
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>> ---
>> changes from V2:
>>    * make a separate function nvme_scan_ns_async() that calls
>>      nvme_scan_ns(), instead of modifying nvme_scan_ns()
>>    * only scan asynchronously from nvme_scan_ns_list(), not from
>>      nvme_scan_ns_sequential()
>>    * provide more timing data in the commit message
>>
>> changes from V1:
>>    * remove module param to enable/disable async scanning
>>    * add scan time measurements to commit message
>>
>>
>>   drivers/nvme/host/core.c | 48 +++++++++++++++++++++++++++++++++-------
>>   1 file changed, 40 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 782090ce0bc1..dbf05cfea063 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4,6 +4,7 @@
>>    * Copyright (c) 2011-2014, Intel Corporation.
>>    */
>> +#include <linux/async.h>
>>   #include <linux/blkdev.h>
>>   #include <linux/blk-mq.h>
>>   #include <linux/blk-integrity.h>
>> @@ -3952,6 +3953,30 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>>       }
>>   }
>> +/*
>> + * struct async_scan_info - keeps track of controller & NSIDs to scan
>> + * @ctrl:    Controller on which namespaces are being scanned
>> + * @next_idx:    Index of next NSID to scan in ns_list
>> + * @ns_list:    Pointer to list of NSIDs to scan
>> + */
>> +struct async_scan_info {
>> +    struct nvme_ctrl *ctrl;
>> +    atomic_t next_idx;
> 
> next_nsid ?
> 

OK!

>> +    __le32 *ns_list;
>> +};
>> +
>> +static void nvme_scan_ns_async(void *data, async_cookie_t cookie)
>> +{
>> +    struct async_scan_info *scan_info = data;
>> +    int idx;
>> +    u32 nsid;
>> +
>> +    idx = (u32)atomic_fetch_add(1, &scan_info->next_idx);
>> +    nsid = le32_to_cpu(scan_info->ns_list[idx]);
>> +
>> +    nvme_scan_ns(scan_info->ctrl, nsid);
>> +}
>> +
>>   static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>>                       unsigned nsid)
>>   {
>> @@ -3975,12 +4000,14 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>>   static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>>   {
>>       const int nr_entries = NVME_IDENTIFY_DATA_SIZE / sizeof(__le32);
>> -    __le32 *ns_list;
>> +    struct async_scan_info scan_info;
> 
> What initializes next_idx?

See below--there's an atomic_set().  It is inside of the outer "for" loop because there can
be multiple lists that have to be scanned and it has to reset to 0 each time.

> 
>>       u32 prev = 0;
>>       int ret = 0, i;
>> +    ASYNC_DOMAIN(domain);
>> -    ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
>> -    if (!ns_list)
>> +    scan_info.ctrl = ctrl;
>> +    scan_info.ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
>> +    if (!scan_info.ns_list)
>>           return -ENOMEM;
> 
> I think you can leave the local variable ns_list as is, and just assign it to scan_info
> after, its common practice to allocate to a local pointer and use it to init a struct member.
> 
> Plus it will make the patch diff simpler.
> 

No problem, I agree.  I think someone suggested the opposite last time I submitted this.  :)

>>       for (;;) {
>> @@ -3990,28 +4017,33 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>>               .identify.nsid        = cpu_to_le32(prev),
>>           };
>> -        ret = nvme_submit_sync_cmd(ctrl->admin_q, &cmd, ns_list,
>> -                        NVME_IDENTIFY_DATA_SIZE);
>> +        ret = nvme_submit_sync_cmd(ctrl->admin_q, &cmd,
>> +                       scan_info.ns_list,
>> +                       NVME_IDENTIFY_DATA_SIZE);
>>           if (ret) {
>>               dev_warn(ctrl->device,
>>                   "Identify NS List failed (status=0x%x)\n", ret);
>>               goto free;
>>           }
>> +        atomic_set(&scan_info.next_idx, 0);

This atomic_set is what initializes next_idx.

>>           for (i = 0; i < nr_entries; i++) {
>> -            u32 nsid = le32_to_cpu(ns_list[i]);
>> +            u32 nsid = le32_to_cpu(scan_info.ns_list[i]);
>>               if (!nsid)    /* end of the list? */
>>                   goto out;
>> -            nvme_scan_ns(ctrl, nsid);
>> +            async_schedule_domain(nvme_scan_ns_async, &scan_info,
>> +                        &domain);
>>               while (++prev < nsid)
>>                   nvme_ns_remove_by_nsid(ctrl, prev);
>>           }
>> +        async_synchronize_full_domain(&domain);
>>       }
>>    out:
>>       nvme_remove_invalid_namespaces(ctrl, prev);
>>    free:
>> -    kfree(ns_list);
>> +    async_synchronize_full_domain(&domain);
>> +    kfree(scan_info.ns_list);
>>       return ret;
>>   }
> 

Thank you for the feedback!

