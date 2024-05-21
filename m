Return-Path: <linux-kernel+bounces-184753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94868CAB7F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B912F1C20C69
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998A46BB56;
	Tue, 21 May 2024 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RHLYxZSd"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9824F88A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286060; cv=none; b=SdMmFI+Sy6E9EEZyAQT/mpgRX5VFiTBkMdbiNRxQ2Xo0Vr2UBl/AOnXXP/NNj7c+1SmR123kuggG/D1yJasr1fZE4kcogVqj5AkoPimWZj8iY2jsupxY8K5ANoBzPB/4Qvf1HI8W4wl0bWdT5DcX1mZ9SnhNCmSYq6IMnyJIWf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286060; c=relaxed/simple;
	bh=yC7+bXHe1gKyLh4Hvf9TGa+gHitgUAYW5bSdYiR01n4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PUHsByJkp8/Adh9P3spTEeMWHn0HUppomhouEIfGVuMCsBwM1lORSKxwNVJEnvvnrBDXobaC81K1SdJwRQr8GIMhOPhvtiPQm8khqhBicrRh5LKcISE2LrBNQ2SKa+wXgj7CBXivFF3J/kbboT951IhGYtJghtlDjw73zByI5W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RHLYxZSd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44L9wGrk018521;
	Tue, 21 May 2024 10:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wVfissdxa/UD1MY8S1tJISNCM1N/Ncgb4g/4fLaT8yA=;
 b=RHLYxZSdBwS7U45y249LfZHnknFli7ErDyFoVuXU7tQMu6LRE8Bd/e/WlDSjY+44lDtO
 vivXhp9DivBsLO1pB2HrNGn11zlKOvV2MCcsF64t9jnN/sIrAbKXZMh6IoH3Q2MFFB5+
 uMaxTSdu0N6sTVJhwBMtIYcwZWKn88HnsnU1dcxrteqykC1tLFltb1mllkJOA53qFXti
 BbbOApUP7o1e3UZwXC2lGP5XsJjwp96cIS+R09I8AJgXGSBZB2fRhiOJQsIZDaIpeRn9
 AaKLBkbFrdqUCLZi5wBEv97l/usMg/3YUJYxSTOyrtUCUgDae5sloEviAYhMsjEWmHqS sA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8secg0rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 10:07:18 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44LA7I9g000738;
	Tue, 21 May 2024 10:07:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8secg0rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 10:07:18 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44LA1tOr000893;
	Tue, 21 May 2024 10:07:17 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y77205605-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 10:07:17 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44LA7Fxe13828802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 10:07:17 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B5FA58043;
	Tue, 21 May 2024 10:07:15 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6FF458063;
	Tue, 21 May 2024 10:07:11 +0000 (GMT)
Received: from [9.171.37.250] (unknown [9.171.37.250])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 May 2024 10:07:11 +0000 (GMT)
Message-ID: <95fe3168-ec39-4932-b9fc-26484de49191@linux.ibm.com>
Date: Tue, 21 May 2024 15:37:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Sagi Grimberg <sagi@grimberg.me>, John Meneghini <jmeneghi@redhat.com>,
        kbusch@kernel.org, hch@lst.de, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
 <3b8d33db-f2c3-469a-bfa0-8fc52594f243@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <3b8d33db-f2c3-469a-bfa0-8fc52594f243@grimberg.me>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JowJE3a3mKZtlrKWK8moAY9iR9or18BR
X-Proofpoint-GUID: S3QMzy3tYiXWeomFSdT3Lp4vRrZctCF1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_06,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405210076



On 5/21/24 15:15, Sagi Grimberg wrote:
> 
> 
> On 21/05/2024 11:48, Nilay Shroff wrote:
>>
>> On 5/21/24 01:50, John Meneghini wrote:
>>> From: "Ewan D. Milne" <emilne@redhat.com>
>>>
>>> The round-robin path selector is inefficient in cases where there is a
>>> difference in latency between multiple active optimized paths.  In the
>>> presence of one or more high latency paths the round-robin selector
>>> continues to the high latency path equally. This results in a bias
>>> towards the highest latency path and can cause is significant decrease
>>> in overall performance as IOs pile on the lowest latency path. This
>>> problem is particularly accute with NVMe-oF controllers.
>>>
>>> The queue-depth policy instead sends I/O requests down the path with the
>>> least amount of requests in its request queue. Paths with lower latency
>>> will clear requests more quickly and have less requests in their queues
>>> compared to higher latency paths. The goal of this path selector is to
>>> make more use of lower latency paths, which will bring down overall IO
>>> latency.
>>>
>>> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
>>> [tsong: patch developed by Thomas Song @ Pure Storage, fixed whitespace
>>>        and compilation warnings, updated MODULE_PARM description, and
>>>        fixed potential issue with ->current_path[] being used]
>>> Signed-off-by: Thomas Song <tsong@purestorage.com>
>>> [jmeneghi: vairious changes and improvements, addressed review comments]
>>> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
>>> Link: https://lore.kernel.org/linux-nvme/20240509202929.831680-1-jmeneghi@redhat.com/
>>> Tested-by: Marco Patalano <mpatalan@redhat.com>
>>> Reviewed-by: Randy Jennings <randyj@redhat.com>
>>> Tested-by: Jyoti Rani <jani@purestorage.com>
>>> ---
>>>   drivers/nvme/host/core.c      |  2 +-
>>>   drivers/nvme/host/multipath.c | 86 +++++++++++++++++++++++++++++++++--
>>>   drivers/nvme/host/nvme.h      |  9 ++++
>>>   3 files changed, 92 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index a066429b790d..1dd7c52293ff 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -110,7 +110,7 @@ struct workqueue_struct *nvme_delete_wq;
>>>   EXPORT_SYMBOL_GPL(nvme_delete_wq);
>>>     static LIST_HEAD(nvme_subsystems);
>>> -static DEFINE_MUTEX(nvme_subsystems_lock);
>>> +DEFINE_MUTEX(nvme_subsystems_lock);
>>>     static DEFINE_IDA(nvme_instance_ida);
>>>   static dev_t nvme_ctrl_base_chr_devt;
>>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>>> index 5397fb428b24..0e2b6e720e95 100644
>>> --- a/drivers/nvme/host/multipath.c
>>> +++ b/drivers/nvme/host/multipath.c
>>> @@ -17,6 +17,7 @@ MODULE_PARM_DESC(multipath,
>>>   static const char *nvme_iopolicy_names[] = {
>>>       [NVME_IOPOLICY_NUMA]    = "numa",
>>>       [NVME_IOPOLICY_RR]    = "round-robin",
>>> +    [NVME_IOPOLICY_QD]      = "queue-depth",
>>>   };
>>>     static int iopolicy = NVME_IOPOLICY_NUMA;
>>> @@ -29,6 +30,8 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
>>>           iopolicy = NVME_IOPOLICY_NUMA;
>>>       else if (!strncmp(val, "round-robin", 11))
>>>           iopolicy = NVME_IOPOLICY_RR;
>>> +    else if (!strncmp(val, "queue-depth", 11))
>>> +        iopolicy = NVME_IOPOLICY_QD;
>>>       else
>>>           return -EINVAL;
>>>   @@ -43,7 +46,7 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
>>>   module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
>>>       &iopolicy, 0644);
>>>   MODULE_PARM_DESC(iopolicy,
>>> -    "Default multipath I/O policy; 'numa' (default) or 'round-robin'");
>>> +    "Default multipath I/O policy; 'numa' (default) , 'round-robin' or 'queue-depth'");
>>>     void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
>>>   {
>>> @@ -127,6 +130,11 @@ void nvme_mpath_start_request(struct request *rq)
>>>       struct nvme_ns *ns = rq->q->queuedata;
>>>       struct gendisk *disk = ns->head->disk;
>>>   +    if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
>>> +        atomic_inc(&ns->ctrl->nr_active);
>>> +        nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
>>> +    }
>>> +
>>>       if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
>>>           return;
>>>   @@ -140,8 +148,12 @@ void nvme_mpath_end_request(struct request *rq)
>>>   {
>>>       struct nvme_ns *ns = rq->q->queuedata;
>>>   +    if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))
>>> +        atomic_dec_if_positive(&ns->ctrl->nr_active);
>>> +
>>>       if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
>>>           return;
>>> +
>>>       bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
>>>                blk_rq_bytes(rq) >> SECTOR_SHIFT,
>>>                nvme_req(rq)->start_time);
>>> @@ -330,6 +342,40 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
>>>       return found;
>>>   }
>>>   
>> I think you may also want to reset nr_active counter if in case, in-flight nvme request
>> is cancelled. If the request is cancelled then nvme_mpath_end_request() wouldn't be invoked.
>> So you may want to reset nr_active counter from nvme_cancel_request() as below:
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index bf7615cb36ee..4fea7883ce8e 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -497,8 +497,9 @@ EXPORT_SYMBOL_GPL(nvme_host_path_error);
>>     bool nvme_cancel_request(struct request *req, void *data)
>>   {
>> -       dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
>> -                               "Cancelling I/O %d", req->tag);
>> +       struct nvme_ctrl *ctrl = (struct nvme_ctrl *)data;
>> +
>> +       dev_dbg_ratelimited(ctrl->device, "Cancelling I/O %d", req->tag);
>>            /* don't abort one completed or idle request */
>>          if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
>> @@ -506,6 +507,8 @@ bool nvme_cancel_request(struct request *req, void *data)
>>            nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
>>          nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>> +       if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))
>> +               atomic_dec(&ctrl->nr_active);
> 
> Don't think this matters because cancellation only happens when we
> teardown the controller anyways...
> 
I think in case if we reset the nvme controller then we don't teardown 
controller, isn't it? In this case we cancel all pending requests, and 
later restart the controller.

Thanks,
--Nilay


