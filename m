Return-Path: <linux-kernel+bounces-362760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D6699B913
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 12:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3D11C20BCD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 10:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723D813D251;
	Sun, 13 Oct 2024 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mscq3wPu"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA551DA32
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728815795; cv=none; b=QCxaFUkiJj2WZkpm34jnRMNwIQAlEcaBx38tdNEQN+3NOQsn/s3MbDry9qk8mdF6BDSygSDUdUr9qz4g9k+713s1o39yTtjc26YjQZZhrTFIU0JQWsEaBS2hpo6gwzM63pEnmGwMdZ0AmQiFrgXwW8h46gw8wCpp2C9gL+/DqZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728815795; c=relaxed/simple;
	bh=jv181G+FaIRLVdfFraR5EE0bpproMOxHJsKmM5Os9HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbALD0/ubVfpyVollTu9At492PyY0OIStlDy84BESCXK00fFzcODQDoHufWJKf/Pp4N8HE3oBxkS3PmSyj+S/piMCY4/XHYK7kcWBgSNVDWosk1EctEjEd93b2uFUzplB7IF3TudwCxKT9RWqdCIZUMOZBka9S0jeJ3szw+LjXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=mscq3wPu; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [IPV6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f] (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7712A4CE;
	Sun, 13 Oct 2024 12:34:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728815691;
	bh=jv181G+FaIRLVdfFraR5EE0bpproMOxHJsKmM5Os9HE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mscq3wPuxaMUV0emVJ0SaMswbj9okRLex+1DjuEN3wug1OphqXwSL/UadvJq3HkR+
	 8eFiaLN7k3kZlpfHtXgCZzkbx9VUHaF4MH0e0pWGiwZSsKvUR8Ozy5GjPbQ5wKoRVx
	 4HL+YaXlTQDoxd34q+VQ9Uu1tqF7OgZkO1zaxZ54=
Message-ID: <bc535633-8489-4eb4-99ce-f9671eb054e1@ideasonboard.com>
Date: Sun, 13 Oct 2024 16:06:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] staging: vchiq_arm: Use devm_kzalloc for mgmt
To: Stefan Wahren <wahrenst@gmx.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 kernel-list@raspberrypi.com
References: <20241013084529.377488-1-umang.jain@ideasonboard.com>
 <20241013084529.377488-3-umang.jain@ideasonboard.com>
 <50425e82-2a41-4a3b-a983-2560ab0ccab2@gmx.net>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <50425e82-2a41-4a3b-a983-2560ab0ccab2@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/10/24 2:43 pm, Stefan Wahren wrote:
> Hi Umang,
>
> Am 13.10.24 um 10:45 schrieb Umang Jain:
>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> except of the missing commit message, this patch looks good to me. I
> understand the concerns about devm_kzalloc, but I think this doesn't
> apply in this case.

That's what I was wondering as well, since I tried module unloading and 
with the cdev also goes away? So shouldn't be conern, right ?

>
> Since this should be treated as RFC, is it already tested?

yes, it was tested
>
> Regards
>> ---
>>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git 
>> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c 
>> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> index e780ed714a14..334fb7037766 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> @@ -1345,7 +1345,7 @@ static int vchiq_probe(struct platform_device 
>> *pdev)
>>           return -ENOENT;
>>       }
>>
>> -    mgmt = kzalloc(sizeof(*mgmt), GFP_KERNEL);
>> +    mgmt = devm_kzalloc(&pdev->dev, sizeof(*mgmt), GFP_KERNEL);
>>       if (!mgmt)
>>           return -ENOMEM;
>>
>> @@ -1403,8 +1403,6 @@ static void vchiq_remove(struct platform_device 
>> *pdev)
>>
>>       arm_state = vchiq_platform_get_arm_state(&mgmt->state);
>>       kthread_stop(arm_state->ka_thread);
>> -
>> -    kfree(mgmt);
>>   }
>>
>>   static struct platform_driver vchiq_driver = {
>


