Return-Path: <linux-kernel+bounces-184735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704278CAB39
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934E61C2160D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B3A6AF88;
	Tue, 21 May 2024 09:45:50 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660BB7F7FF
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284750; cv=none; b=Fi41CNhzvF8Z30tJvja/bqN7X+wCa/JKYTSGDGejhR80zFfLxsk4LDdIwz5FouPPvmvNj0rKxo59IReSiUS97oU2nd9MKDhzNIqSBNy961Ik7LkSRq5IEiAFN2vAWw2UYyB6wGlK6CdqkrBDqXb/7gJdsyRS21CAEf4CNzUhFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284750; c=relaxed/simple;
	bh=shN1Ev8Qgj0UbAJFdFH5lku4SSg0NwBNpASQrqx5SAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4TVYYy4pQdl9lgLARmWAzq+4kUmjxuICWy6Z96ff2+xwxwJ5L6Jd+IP6n1vPxTzhKWmS7XaNZsZdTTNu+MoI/3PBmhmYyqJQpCWA0rZNVldTDRan5SRg3r26jNQibMyPmJcouyYbQltA9HSEVtlD3LJ7YnqkwFh8+4kksKktK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41ff95798d4so4870025e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716284747; x=1716889547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytk+HQw4vCY/ZsFxmn2Qu+I/J6GZpszaleTvoN+Y0Kw=;
        b=MJh6Tpgky7vXyOTeaJJmf5qtoLp6zNssac5MwbI1QkYRCQOAU137xm5T7vglNjm4or
         KsCtkp0eCC0ob9yXG28Iqr2A4kTuO+XZJaZq72gRxvJZiJVhCmOnYAgtHIuBKMgky74Q
         V22axSI6UUoFgDWvjYS4J6/0O9VmWGbWL1jfY8iAA0Uhq0hka5JjtpUUEsfBElO8xFGz
         pw9YVtdjFG/p/b6T50Y+zYulU4ftYsojJRocMAIkq7zIrZ73B6sDM975JsQY8KV43FLc
         XKFKgwE2c1zMOutBTzzZ9Em9ghh9xHFwnc+5F/e3Kzfwx4ttHNfrO24/voEDnN6Jf7sz
         gTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfhLdHJpd9XqUEjWwWdA/eQsMwZSjFsH+Oekz9uqBW5WuRHI3bjku0BwuiK/6P6FUXRbz3xAY+EJNnfoMfzCRG1F7tulPPRX9T+LtU
X-Gm-Message-State: AOJu0YziLN+xcgfGVpPe2Le2qOySdBBBhVk9LZK+Bj1VQjLx1d6DE++h
	eQf9fM5HH6WBr8ooXLApaJdMEyK/XBCYcJYapvnZyM1zFUlCKzxW
X-Google-Smtp-Source: AGHT+IEC0Q1sLZoQQmgxV8JbLvwWepf1ZWKX+aodXeqHEqJqt2+Whl/WHHSLoU6fBa7aoGD5HMxapA==
X-Received: by 2002:a05:600c:5116:b0:418:ef65:4b11 with SMTP id 5b1f17b1804b1-41feac59e8amr265338175e9.2.1716284746574;
        Tue, 21 May 2024 02:45:46 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ff6fd7e73sm417039275e9.27.2024.05.21.02.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 02:45:46 -0700 (PDT)
Message-ID: <3b8d33db-f2c3-469a-bfa0-8fc52594f243@grimberg.me>
Date: Tue, 21 May 2024 12:45:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Nilay Shroff <nilay@linux.ibm.com>, John Meneghini <jmeneghi@redhat.com>,
 kbusch@kernel.org, hch@lst.de, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/05/2024 11:48, Nilay Shroff wrote:
>
> On 5/21/24 01:50, John Meneghini wrote:
>> From: "Ewan D. Milne" <emilne@redhat.com>
>>
>> The round-robin path selector is inefficient in cases where there is a
>> difference in latency between multiple active optimized paths.  In the
>> presence of one or more high latency paths the round-robin selector
>> continues to the high latency path equally. This results in a bias
>> towards the highest latency path and can cause is significant decrease
>> in overall performance as IOs pile on the lowest latency path. This
>> problem is particularly accute with NVMe-oF controllers.
>>
>> The queue-depth policy instead sends I/O requests down the path with the
>> least amount of requests in its request queue. Paths with lower latency
>> will clear requests more quickly and have less requests in their queues
>> compared to higher latency paths. The goal of this path selector is to
>> make more use of lower latency paths, which will bring down overall IO
>> latency.
>>
>> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
>> [tsong: patch developed by Thomas Song @ Pure Storage, fixed whitespace
>>        and compilation warnings, updated MODULE_PARM description, and
>>        fixed potential issue with ->current_path[] being used]
>> Signed-off-by: Thomas Song <tsong@purestorage.com>
>> [jmeneghi: vairious changes and improvements, addressed review comments]
>> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
>> Link: https://lore.kernel.org/linux-nvme/20240509202929.831680-1-jmeneghi@redhat.com/
>> Tested-by: Marco Patalano <mpatalan@redhat.com>
>> Reviewed-by: Randy Jennings <randyj@redhat.com>
>> Tested-by: Jyoti Rani <jani@purestorage.com>
>> ---
>>   drivers/nvme/host/core.c      |  2 +-
>>   drivers/nvme/host/multipath.c | 86 +++++++++++++++++++++++++++++++++--
>>   drivers/nvme/host/nvme.h      |  9 ++++
>>   3 files changed, 92 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index a066429b790d..1dd7c52293ff 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -110,7 +110,7 @@ struct workqueue_struct *nvme_delete_wq;
>>   EXPORT_SYMBOL_GPL(nvme_delete_wq);
>>   
>>   static LIST_HEAD(nvme_subsystems);
>> -static DEFINE_MUTEX(nvme_subsystems_lock);
>> +DEFINE_MUTEX(nvme_subsystems_lock);
>>   
>>   static DEFINE_IDA(nvme_instance_ida);
>>   static dev_t nvme_ctrl_base_chr_devt;
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 5397fb428b24..0e2b6e720e95 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -17,6 +17,7 @@ MODULE_PARM_DESC(multipath,
>>   static const char *nvme_iopolicy_names[] = {
>>   	[NVME_IOPOLICY_NUMA]	= "numa",
>>   	[NVME_IOPOLICY_RR]	= "round-robin",
>> +	[NVME_IOPOLICY_QD]      = "queue-depth",
>>   };
>>   
>>   static int iopolicy = NVME_IOPOLICY_NUMA;
>> @@ -29,6 +30,8 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
>>   		iopolicy = NVME_IOPOLICY_NUMA;
>>   	else if (!strncmp(val, "round-robin", 11))
>>   		iopolicy = NVME_IOPOLICY_RR;
>> +	else if (!strncmp(val, "queue-depth", 11))
>> +		iopolicy = NVME_IOPOLICY_QD;
>>   	else
>>   		return -EINVAL;
>>   
>> @@ -43,7 +46,7 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
>>   module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
>>   	&iopolicy, 0644);
>>   MODULE_PARM_DESC(iopolicy,
>> -	"Default multipath I/O policy; 'numa' (default) or 'round-robin'");
>> +	"Default multipath I/O policy; 'numa' (default) , 'round-robin' or 'queue-depth'");
>>   
>>   void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
>>   {
>> @@ -127,6 +130,11 @@ void nvme_mpath_start_request(struct request *rq)
>>   	struct nvme_ns *ns = rq->q->queuedata;
>>   	struct gendisk *disk = ns->head->disk;
>>   
>> +	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
>> +		atomic_inc(&ns->ctrl->nr_active);
>> +		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
>> +	}
>> +
>>   	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
>>   		return;
>>   
>> @@ -140,8 +148,12 @@ void nvme_mpath_end_request(struct request *rq)
>>   {
>>   	struct nvme_ns *ns = rq->q->queuedata;
>>   
>> +	if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))
>> +		atomic_dec_if_positive(&ns->ctrl->nr_active);
>> +
>>   	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
>>   		return;
>> +
>>   	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
>>   			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
>>   			 nvme_req(rq)->start_time);
>> @@ -330,6 +342,40 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
>>   	return found;
>>   }
>>   
> I think you may also want to reset nr_active counter if in case, in-flight nvme request
> is cancelled. If the request is cancelled then nvme_mpath_end_request() wouldn't be invoked.
> So you may want to reset nr_active counter from nvme_cancel_request() as below:
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index bf7615cb36ee..4fea7883ce8e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -497,8 +497,9 @@ EXPORT_SYMBOL_GPL(nvme_host_path_error);
>   
>   bool nvme_cancel_request(struct request *req, void *data)
>   {
> -       dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
> -                               "Cancelling I/O %d", req->tag);
> +       struct nvme_ctrl *ctrl = (struct nvme_ctrl *)data;
> +
> +       dev_dbg_ratelimited(ctrl->device, "Cancelling I/O %d", req->tag);
>   
>          /* don't abort one completed or idle request */
>          if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
> @@ -506,6 +507,8 @@ bool nvme_cancel_request(struct request *req, void *data)
>   
>          nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
>          nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> +       if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))
> +               atomic_dec(&ctrl->nr_active);

Don't think this matters because cancellation only happens when we
teardown the controller anyways...

btw, can we have a better name than nr_active? this is just for IO and only
for multipath. Maybe ctrl->nr_mpath_io_active ?

Also perhaps rename the flag to NVME_MPATH_CTRL_IO_ACCOUNTING ?

