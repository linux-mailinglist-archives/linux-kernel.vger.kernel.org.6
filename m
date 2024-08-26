Return-Path: <linux-kernel+bounces-301104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D90D95EC69
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5346B2817DC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51BF13D63D;
	Mon, 26 Aug 2024 08:53:10 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C10286A8;
	Mon, 26 Aug 2024 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662390; cv=none; b=auICy5TPc6vTZJsXE3uWQhCCo1m0Il0To36wLas+1gxuSpNKgPZLT3S9dhdYpYkIFA8Vkp8p2WmCGF0bHO44wunXt73qUatMdfwynWmwsZCBHIqiHIiNcdtuAahJeXn57F+gEbJbPJdPNHN0zpIYkctSQsre0TDwu6tOtN67UlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662390; c=relaxed/simple;
	bh=JMat9JXNnUW2lrDkaL1VdRKFwbn8dGm+d7htjhb2iaE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JAzyfy+Zu+hT70uD12q2ADr1ioBlIvS7oqFG6sRgg1ajSD2XxVldMp3rgg4atzwOLWoeTA14RqinOGqne7sN+CsULfcP/rC4TvGqDNYy3ZduSAP4f2wTLnH3sJ8SsJeZWg/8wfoXA6g8IhTPasm4oHZaOMY0UZmDyTPENHo9Fqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wskvz6fs2z4f3lVd;
	Mon, 26 Aug 2024 16:52:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4A40D1A191F;
	Mon, 26 Aug 2024 16:53:03 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4VtQsxmTZEICw--.17930S3;
	Mon, 26 Aug 2024 16:53:03 +0800 (CST)
Subject: Re: [PATCH 2/4] block: fix ordering between checking BLK_MQ_S_STOPPED
 and adding requests to hctx->dispatch
To: Muchun Song <muchun.song@linux.dev>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Muchun Song <songmuchun@bytedance.com>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
References: <20240811101921.4031-1-songmuchun@bytedance.com>
 <20240811101921.4031-3-songmuchun@bytedance.com> <ZsKtllxojkTe3mpY@fedora>
 <CAMZfGtWxE9z4GgmpEBXzwsy_HAyOOZ85+2HUyqE-9+n1f2aPJA@mail.gmail.com>
 <786a8d94-884c-8a31-151d-fdc82e1a0a63@huaweicloud.com>
 <3AC15539-1B9B-4996-A150-8CAB214159E5@linux.dev>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d044b53b-4917-778d-0f77-c99da8f03769@huaweicloud.com>
Date: Mon, 26 Aug 2024 16:53:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3AC15539-1B9B-4996-A150-8CAB214159E5@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3n4VtQsxmTZEICw--.17930S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr43tr4UKw15tr1kGF17Wrg_yoWrtr48pa
	18ta1jyF4Dtw4Utw12vr4xKF1Yyw43CrW7WryrGry3u3s09wnYvr40yw1Y9FySkr4kCr47
	tw4UXrWxWa1kZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/08/26 16:35, Muchun Song 写道:
> 
> 
>> On Aug 22, 2024, at 11:54, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2024/08/19 11:49, Muchun Song 写道:
>>> On Mon, Aug 19, 2024 at 10:28 AM Ming Lei <ming.lei@redhat.com> wrote:
>>>>
>>>> Hi Muchun,
>>>>
>>>> On Sun, Aug 11, 2024 at 06:19:19PM +0800, Muchun Song wrote:
>>>>> Supposing the following scenario with a virtio_blk driver.
>>>>>
>>>>> CPU0                                                                CPU1
>>>>>
>>>>> blk_mq_try_issue_directly()
>>>>>      __blk_mq_issue_directly()
>>>>>          q->mq_ops->queue_rq()
>>>>>              virtio_queue_rq()
>>>>>                  blk_mq_stop_hw_queue()
>>>>>                                                                      virtblk_done()
>>>>>      blk_mq_request_bypass_insert()                                      blk_mq_start_stopped_hw_queues()
>>>>>          /* Add IO request to dispatch list */   1) store                    blk_mq_start_stopped_hw_queue()
>>>>>                                                                                  clear_bit(BLK_MQ_S_STOPPED)                 3) store
>>>>>      blk_mq_run_hw_queue()                                                       blk_mq_run_hw_queue()
>>>>>          if (!blk_mq_hctx_has_pending())                                             if (!blk_mq_hctx_has_pending())         4) load
>>>>>              return                                                                      return
>>>>>          blk_mq_sched_dispatch_requests()                                            blk_mq_sched_dispatch_requests()
>>>>>              if (blk_mq_hctx_stopped())          2) load                                 if (blk_mq_hctx_stopped())
>>>>>                  return                                                                      return
>>>>>              __blk_mq_sched_dispatch_requests()                                          __blk_mq_sched_dispatch_requests()
>>>>>
>>>>> The full memory barrier should be inserted between 1) and 2), as well as between
>>>>> 3) and 4) to make sure that either CPU0 sees BLK_MQ_S_STOPPED is cleared or CPU1
>>>>> sees dispatch list or setting of bitmap of software queue. Otherwise, either CPU
>>>>> will not re-run the hardware queue causing starvation.
>>>>
>>>> Yeah, it is one kind of race which is triggered when adding request into
>>>> ->dispatch list after returning STS_RESOURCE. We were troubled by lots of
>>>> such kind of race.
>>> Yes. I saw the similar fix for BLK_MQ_S_SCHED_RESTART.
>>>>
>>>> stopping queue is used in very less drivers, and its only purpose should
>>>> be for throttling hw queue in case that low level queue is busy. There seems
>>>> more uses of blk_mq_stop_hw_queues(), but most of them should be replaced
>>>> with blk_mq_quiesce_queue().
>>>>
>>>> IMO, fixing this kind of issue via memory barrier is too tricky to
>>>> maintain cause WRITE/READ dependency is very hard to follow. I'd suggest to
>>>> make memory barrier solution as the last resort, and we can try to figure
>>>> out other easier & more reliable way first.
>>> I do agree it is hard to maintain the dependencies in the future. We should
>>> propose an easy-maintainable solution. But I thought it is a long-term issue
>>> throughout different stable linux distros. Adding a mb is the easy way to fix
>>> the problem (the code footprint is really small), so it will be very
>>> easy for others
>>> to backport those bug fixes to different stable linux distros. Therefore, mb
>>> should be an interim solution. Then, we could improve it based on the solution
>>> you've proposed below. What do you think?
>>
>> I'll agree with Ming, let's figure out a better fix first. Easy to backport to stables is not first consideration.
> 
> Hi Kuai,
> 
> All right. I usually focus on MM, it seems there is a gap between MM and BLock.
> Anyway, let's figure out if there is any good solution.
> 
>>> Thanks,
>>> Muchun.
>>>>
>>>> One idea I thought of is to call blk_mq_request_bypass_insert()(or rename
>>>> & export it) before calling blk_mq_stop_hw_queue() in driver, then
>>>> return new status code STS_STOP_DISPATCH for notifying blk-mq to stop
>>>> dispatch simply.
>>
>> New status code look good to me, however, I wonder can we just remove
>> the problematic blk_mq_stop_hw_queue(), and replace it by handling the
>> new status from block layer?
>>
>> - Passing the new status to blk_mq_run_dispatch_ops, and quiesce with
> 
> I didn't fully understand your suggestion. Let me ask some questions.
> blk_mq_stop_hw_queue() is usually called in blk_mq_ops->queue_rq path,
> it'll be easy for this case to pass the new status to blk_mq_run_dispatch_ops.
> Should we remove blk_mq_stop_hw_queues() as well? How to pass the new
> status to blk_mq_run_dispatch_ops in this case?

For queue_rq from dispatch path, it can be removed. However, it is
called from remove path as well, I don't check yet if it can be removed
there, that's another story.

And just add a return value for dispatch_ops to pass status.

Thanks,
Kuai

> 
>> the new status, if no request is inflight, unquiesce immediately;
> 
> Actually, I didn't understand how to avoid the above race. May you elaborate
> the scenario?
> 
> Muhcun,
> Thanks.
> 
>> - unquiesce is any IO is done afterwards;
> 
> 
> 
> 
> .
> 


