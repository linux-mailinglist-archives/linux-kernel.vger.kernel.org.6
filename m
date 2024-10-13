Return-Path: <linux-kernel+bounces-362731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D5899B8C0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 09:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6D81F21A32
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 07:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7220D1304AB;
	Sun, 13 Oct 2024 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IUgrHdl7"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A30042AA5
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 07:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728804834; cv=none; b=mTh4wMw0CkkRV1dqAWj5+Cqt37Wur7ciSLAX6gX+nsQ+7pCm5KSQ9UIH4xeLwYsHJGx8r2M+P33UbicvYLDqplrqmCjSdlhdc9Yr8JaofeNbut1Tt1fq7qGH40YwEL09D8R0fi5erQhCDVzlQV5LEgSvRZC4VdLaiF9xne4W+YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728804834; c=relaxed/simple;
	bh=S8Z2vfvb5UddMxMoUsWfKcFwQE36b6S7gfQZSeQlW3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpaXk84QhGWnjXGkVbUs67dXlFW0+HOZWqGtQkCNaqEN6Pb7EYwCnNBcBWF+TXIExCX3hyG0ZAAit5EqFuydI0AN1lnaenc8aKQ0yK+B6S09Mr8t+kIRoXdU1DIgPQnKmpOa7J87mOlwDaad7yvO0TljHvjH9fm7MpRq4qjn07w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=IUgrHdl7; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [IPV6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f] (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 74BF382E;
	Sun, 13 Oct 2024 09:32:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728804731;
	bh=S8Z2vfvb5UddMxMoUsWfKcFwQE36b6S7gfQZSeQlW3c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IUgrHdl7J10CiwhelK+fB90yMM2kVYcCPsjb1SHN3zkO+V2uBgv4xYotOXgm89i/C
	 /G3TPWX8PAEUZV3JgCyZSICcwOxgExtzeRuYwEvKYon4XWSqRq9z1P25zsMoP7IqSC
	 yGc+XZnIcWEJxFPZld+JRYdvFZ/wDfWjAH4Fy0do=
Message-ID: <14912c78-32c4-4c61-97db-c9f6dbbd3bb1@ideasonboard.com>
Date: Sun, 13 Oct 2024 13:03:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] staging: vchiq_core: Refactor notify_bulks()
To: Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 kernel-list@raspberrypi.com, Stefan Wahren <wahrenst@gmx.net>
References: <20241012185652.316172-1-umang.jain@ideasonboard.com>
 <20241012185652.316172-5-umang.jain@ideasonboard.com>
 <172880414537.1925926.9488617715642757683@ping.linuxembedded.co.uk>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <172880414537.1925926.9488617715642757683@ping.linuxembedded.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/10/24 12:52 pm, Kieran Bingham wrote:
> Quoting Umang Jain (2024-10-12 19:56:50)
>> Move the statistics and bulk completion events handling  to a separate
>> function. This helps to improve readability for notify_bulks().
>>
>> No functional changes intended in this patch.
>>
>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>> ---
>>   .../interface/vchiq_arm/vchiq_core.c          | 77 +++++++++++--------
>>   1 file changed, 46 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>> index e9cd012e2b5f..19dfcd98dcde 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>> @@ -1309,6 +1309,49 @@ get_bulk_reason(struct vchiq_bulk *bulk)
>>          return VCHIQ_BULK_RECEIVE_DONE;
>>   }
>>   
>> +static int service_notify_bulk(struct vchiq_service *service,
>> +                              struct vchiq_bulk *bulk)
>> +{
>> +       int status = -EINVAL;
>> +
>> +       if (!service || !bulk)
>> +               return status;
> Both of these are guaranteed by the (only) caller so I'm not sure they're
> needed ?
>
> But maybe it would be used elsewhere later?
>
> If these checks were kept, and the int status removed as mentioned below
> this would just be ' return -EINVAL;' of course.
>
> Or just drop them if it's easier and guaranteed.
>
>> +
>> +       if (bulk->actual != VCHIQ_BULK_ACTUAL_ABORTED) {
>> +               if (bulk->dir == VCHIQ_BULK_TRANSMIT) {
>> +                       VCHIQ_SERVICE_STATS_INC(service, bulk_tx_count);
>> +                       VCHIQ_SERVICE_STATS_ADD(service, bulk_tx_bytes,
>> +                                               bulk->actual);
>> +               } else {
>> +                       VCHIQ_SERVICE_STATS_INC(service, bulk_rx_count);
>> +                       VCHIQ_SERVICE_STATS_ADD(service, bulk_rx_bytes,
>> +                                               bulk->actual);
>> +                               }
> I think the indentation on this } has gone wrong here.
>
>> +       } else {
>> +               VCHIQ_SERVICE_STATS_INC(service, bulk_aborted_count);
>> +       }
>> +
>> +       if (bulk->mode == VCHIQ_BULK_MODE_BLOCKING) {
>> +               struct bulk_waiter *waiter;
>> +
>> +               spin_lock(&service->state->bulk_waiter_spinlock);
>> +               waiter = bulk->userdata;
>> +               if (waiter) {
>> +                       waiter->actual = bulk->actual;
>> +                       complete(&waiter->event);
>> +               }
>> +               spin_unlock(&service->state->bulk_waiter_spinlock);
>> +
>> +               status = 0;
> This just looks odd here. If it weren't for this I'd have probably been
> fine with the initialisation of status
>
>> +       } else if (bulk->mode == VCHIQ_BULK_MODE_CALLBACK) {
>> +               enum vchiq_reason reason = get_bulk_reason(bulk);
>> +               status = make_service_callback(service, reason, NULL,
>> +                                              bulk->userdata);
> I think I would probably just drop the int status altogether and make this
>
> 		return make_service_callback(service, reason, NULL,
> 					     bulk->userdata);
>
>> +       }
>> +
>> +       return status;
> And return 0 here. Then we get rid of the awkward initialisation and
> usages above.

I usually have the tendency to minimise return  statements in a routine 
and ideally target for single return statement at the end.

  But I do agree on the awkward initialisation of status = 0

>
>> +}
>> +
>>   /* Called by the slot handler - don't hold the bulk mutex */
>>   static int
>>   notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
>> @@ -1333,37 +1376,9 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
>>                   * requests, and non-terminated services
>>                   */
>>                  if (bulk->data && service->instance) {
>> -                       if (bulk->actual != VCHIQ_BULK_ACTUAL_ABORTED) {
>> -                               if (bulk->dir == VCHIQ_BULK_TRANSMIT) {
>> -                                       VCHIQ_SERVICE_STATS_INC(service, bulk_tx_count);
>> -                                       VCHIQ_SERVICE_STATS_ADD(service, bulk_tx_bytes,
>> -                                                               bulk->actual);
>> -                               } else {
>> -                                       VCHIQ_SERVICE_STATS_INC(service, bulk_rx_count);
>> -                                       VCHIQ_SERVICE_STATS_ADD(service, bulk_rx_bytes,
>> -                                                               bulk->actual);
>> -                               }
>> -                       } else {
>> -                               VCHIQ_SERVICE_STATS_INC(service, bulk_aborted_count);
>> -                       }
>> -                       if (bulk->mode == VCHIQ_BULK_MODE_BLOCKING) {
>> -                               struct bulk_waiter *waiter;
>> -
>> -                               spin_lock(&service->state->bulk_waiter_spinlock);
>> -                               waiter = bulk->userdata;
>> -                               if (waiter) {
>> -                                       waiter->actual = bulk->actual;
>> -                                       complete(&waiter->event);
>> -                               }
>> -                               spin_unlock(&service->state->bulk_waiter_spinlock);
>> -                       } else if (bulk->mode == VCHIQ_BULK_MODE_CALLBACK) {
>> -                               enum vchiq_reason reason =
>> -                                               get_bulk_reason(bulk);
>> -                               status = make_service_callback(service, reason, NULL,
>> -                                                              bulk->userdata);
>> -                               if (status == -EAGAIN)
>> -                                       break;
>> -                       }
>> +                       status = service_notify_bulk(service, bulk);
>> +                       if (status == -EAGAIN)
>> +                               break;
> This now reads as
>                   if (bulk->data && service->instance) {
>                           status = service_notify_bulk(service, bulk);
>                           if (status == -EAGAIN)
>                                   break;
> 		}
>
> which is much nicer.

agreed, will address this
>
> With the updates above handled, then I think we're more accurately at no
> functional changes:
>
> Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>
>
>
>>                  }
>>   
>>                  queue->remove++;
>> -- 
>> 2.45.2
>>


