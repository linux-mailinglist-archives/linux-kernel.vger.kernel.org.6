Return-Path: <linux-kernel+bounces-255885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D390693460B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 04:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31441C21760
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623571946F;
	Thu, 18 Jul 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN4GLZg0"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FDB2BB1C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721268628; cv=none; b=cWrtx2iY+g5ZXlgK0zC+kGMqdIN8F3u2lnS7Vyrf/Y97FqwW2fi0VHJo7556xfSU+HCsHzSr7VXUptaapCmrIT7CkZwrW2OcmE43ZKWVXG9p/9QyXdlkqsUXPMFdOROVJ24eRtyD1o808Fq/5GXzKGK53zwD6SZ9QEmDWuntq1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721268628; c=relaxed/simple;
	bh=m0X7sR1sru4+X7nVEM9l8/qnP+CJ1yNnC/m5fBlK6cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f2Wqq0t8DDvmBeijBTyseOr1uliIbFzYQSMpqQNoGB9PSLz3GqoaFtmpBDW6FeV0NXy04SiLyqFZuGUKf/Bs3xgnChzqNVUopcg+P15Au+X9CZ3hua3wtLtF8l8aijg7HvZoivNxrez0Jfuvmr4CFeDbOGcy6TJujsc2TVVsOD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aN4GLZg0; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7037a208ff5so180991a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 19:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721268625; x=1721873425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIFfDmFpN4eqAMaaNo7FF8H1RWJDQ9fSWvSB6h3IB14=;
        b=aN4GLZg0uqbxY48KQCTVZZOYHHbptPClgjWLJ2OL11c7G6yJH0RxUWWMIlvFzOvRSk
         a35BP0K5jGt2KzIhbd8sMsN4uWONEb+FvoADZel+WiZTjrWrmDyaCbG6OiTTJF4+IUJz
         0J6E+xWPcfOunMvnMfjPQLGov01pi3nWSj25FaiCKU9eEklS0nmPUxZfE6YLeP0asSmi
         TJA1FKVDM5+WgFVA5d8AurVDr39pLK4BjvpzZoTmsIr7Bs1kMymnWd+8R3RymsSmOzxE
         /i8Fn58HhKrWpRsy5IVLIjj3zcwBsLhico1tjnEGw8i+8rhaOUZberoFB4629t7BxlKl
         beVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721268625; x=1721873425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIFfDmFpN4eqAMaaNo7FF8H1RWJDQ9fSWvSB6h3IB14=;
        b=aXNiNSW/Vnyp/IIyIQQPOWHdHtpfsbStRJePjHpmFJEV0V+plESM76K7qHckD6HNbx
         E14Heu/IURupViDKtAE7QIotFZjjCNJxjtsLGPWCTu0UHuYCe0w2rZhFvVRR5lRvf7h7
         4q6Fa+7SBIDX7tErj8gJ6gofCJAlLWsVMKxQI0yCuJ4Gh+zyUJ2yAn/w9+WgdD5+BdSQ
         /rz4O+wft5n3ZHf7ZwXyMdrRMHPY2L24ATfwi0jCPTJFTqRsrxY6OvxGaDXWFXFYMdaK
         Yw4QVMrch+0Dn72I/j17qmr4eclSUD5Jw1f5r29eg22rh1nl/Vt0NuocEgjWwbSYoGzD
         rMew==
X-Gm-Message-State: AOJu0YwNr7MJlJJw9qxq4f256Ot3r8mx20FDtVZqrAFQhADQCCCvf/c4
	FfoSxlUKVIXQxPDvETAN8weGc/7i3iimNmrJl68KKl358+5g/8Uy
X-Google-Smtp-Source: AGHT+IFdfi1fpC7A1dDA7DH5ZmL+8xb4lKgvB0goy07ZvGthxot9YWzsXiGqELyb/+bAn7uzc0FvNQ==
X-Received: by 2002:a05:6830:314f:b0:704:2dd4:3628 with SMTP id 46e09a7af769-708e37891a2mr4276406a34.9.1721268625174;
        Wed, 17 Jul 2024 19:10:25 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708e7901391sm314553a34.74.2024.07.17.19.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 19:10:24 -0700 (PDT)
Message-ID: <6629583d-4681-49bc-8a7c-a87c3051c30b@gmail.com>
Date: Wed, 17 Jul 2024 21:10:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme_core: scan namespaces asynchronously
To: Keith Busch <kbusch@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Martin Wilck <martin.wilck@suse.com>,
 Ayush Siddarath <ayush.siddarath@dell.com>
References: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
 <Zpgtr33uqbMogK7c@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <Zpgtr33uqbMogK7c@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/17/2024 3:46 PM, Keith Busch wrote:
> On Wed, Jul 17, 2024 at 01:55:50PM -0500, Stuart Hayes wrote:
> 
> Looks good to me. Just one minor comment below.
> 
>> @@ -3978,11 +4008,15 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>>   	__le32 *ns_list;
>>   	u32 prev = 0;
>>   	int ret = 0, i;
>> +	ASYNC_DOMAIN(domain);
>> +	struct async_scan_info scan_info;
>>   
>>   	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
>>   	if (!ns_list)
>>   		return -ENOMEM;
>>   
>> +	scan_info.ctrl = ctrl;
>> +	scan_info.ns_list = ns_list;
>>   	for (;;) {
>>   		struct nvme_command cmd = {
>>   			.identify.opcode	= nvme_admin_identify,
>> @@ -3998,19 +4032,23 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>>   			goto free;
>>   		}
>>   
>> +		atomic_set(&scan_info.next_nsid, 0);
>>   		for (i = 0; i < nr_entries; i++) {
>>   			u32 nsid = le32_to_cpu(ns_list[i]);
>>   
>>   			if (!nsid)	/* end of the list? */
>>   				goto out;
>> -			nvme_scan_ns(ctrl, nsid);
>> +			async_schedule_domain(nvme_scan_ns_async, &scan_info,
>> +						&domain);
>>   			while (++prev < nsid)
>>   				nvme_ns_remove_by_nsid(ctrl, prev);
>>   		}
>> +		async_synchronize_full_domain(&domain);
>>   	}
>>    out:
>>   	nvme_remove_invalid_namespaces(ctrl, prev);
>>    free:
>> +	async_synchronize_full_domain(&domain);
> 
> A goto this "free" label appears to mean the async domain has nothing
> scheduled, so synchronizing won't be necessary. This should be moved up
> tharmlesso the "out" label, I think.
> 
> I can change that up when applying; just wanted to mention it in case
> I'm missing something.

I agree, you aren't missing anything.  Thank you very much!  If you want
me to submit a new patch with this and Thomas' changes, let me know.

