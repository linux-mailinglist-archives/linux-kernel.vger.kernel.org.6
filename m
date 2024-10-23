Return-Path: <linux-kernel+bounces-378111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D139B9ACB89
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD521C21064
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E104C1B652C;
	Wed, 23 Oct 2024 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="f1js9bWK"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAD01AAE00
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691322; cv=none; b=aIh9x0fzuE+GJggOfkEWJ9UJvYCLl2h5QIu+IBeYhA1mVem/C0gz6rfwUTq5g9YtaE5nFNPZbiFL1mVVSlMiDo5jE+yLTQ3Y0ccnqPK6tSdB1fEtyKr6Co/GTnqNKr5DIA86jDHDYw77t8fjagaxYBnX6w4jJ7xlAMVR2dQmxAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691322; c=relaxed/simple;
	bh=XIGajH1WfcU2vrjwHWK3Ps8Yjlrjs5GemtdLFAHQzlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liy+KnWNXwrK0BULb8kGu5fQaWaLfW1OmK7fIuryI4BwRdUReSD06pIiWa50zF1d2eWpSC3yLuXxRZlx58jfrMYlEq9BWeHYuvRb/ydN6OQyo/y50xDIwJ6g5BDW7XzWt5Asp5IpGO9oOHyGcna1bIsobIiZEWXJ53bEHVsmIQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=f1js9bWK; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-83aad99d6bfso260839539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729691317; x=1730296117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gEIqUzGMIrBpPH9lAOie9M7I6NLNlESkw5pvksDp/zQ=;
        b=f1js9bWKIoStim4CfGFIp/8NuG704qhWEsFAA3GFSiVZjYGrIq0bZv1ATgF48qNWSr
         UQAT2YxcxMvVDDx+WAUWaNRcgD0lmTXfFji88vICfrCWWWlVMH1Gd8ffZpn2A2KDPe9E
         0yIebbYS+ZbDqwiYIC83fhwmwhdymlH7wZi0lUJwv0bK5nCghtj65oKvicQHB8mjzF8A
         P27M0zrnc4DsJ4F+tAOs46Lyw0qWGX54UmCLVBXax0DqfXxwz2SfCSYr0ClTebYdxSEL
         4CYuzEtMpD1LjJGR0bwFUkmaIX7AQnqjI+vKFZB7NY0r+K95BuFKeYfw06bIQyKpEI91
         uL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729691317; x=1730296117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEIqUzGMIrBpPH9lAOie9M7I6NLNlESkw5pvksDp/zQ=;
        b=hNVlHM/F2ym1ikjFNkdHP741b8Rr+59HzBF6K4LMdsEvuRAcJR42Axyp01QoTadRzi
         YSNIiTvtX0SPGdNL2RncaT3SobRrtXhAX50pSDTgT9FdrkYnX0McQ5fcRra03Q6mqLlq
         PUsiUyKfAiDrHjvKENMkBGlJ+s2kcwZ13mEul3TDpdo3h1Q00DLD2z3wYkG0omG0mJwe
         HzwtnRtVS1fzoq8zivpWhLC6uVEO4FNzPohg+wDwBjDXXQubgQff+MQ3JQZsk74miyRE
         nJYWP0MBnacE8bgUFBFy/uAFf0d3DrEDKDpQ48rFl3shjhLtzPzDqXHAkyhfUEnv193C
         W0Bw==
X-Forwarded-Encrypted: i=1; AJvYcCV553PZrkUTzNdoL3BXYG2CxA23P3zLKna7U8W2Tc+aTU7QUa6g5a+d182BE0359C/bAvCpa/p0rPpPM1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3rZ3HtIh3YZbmYT+7c1+naWi9HNS4bZ6Iai3TvyYTTUqgEDbY
	aInie9FcTC6Kgoj4kDZeniL0YZmKkQ/o7+6RMt1Nc5vL01fPoDIa/2q66OE1N/E=
X-Google-Smtp-Source: AGHT+IHzPfoXN73PCw1LM7z9gdgS3t3XCwcu2wJWjvpKYFx7Doynd8Jdu5IggzzFdQsBoQxTRaKfqA==
X-Received: by 2002:a05:6602:14c7:b0:83a:b881:7abe with SMTP id ca18e2360f4ac-83af63ebc86mr286739739f.14.1729691316627;
        Wed, 23 Oct 2024 06:48:36 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a556f58sm2040691173.42.2024.10.23.06.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 06:48:36 -0700 (PDT)
Message-ID: <f8ff8b69-f4d0-40d4-a2c5-b5bfeb973c71@kernel.dk>
Date: Wed, 23 Oct 2024 07:48:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/2] blk-mq: add support for CPU latency limits
To: Tero Kristo <tero.kristo@linux.intel.com>
Cc: hch@lst.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241018075416.436916-1-tero.kristo@linux.intel.com>
 <20241018075416.436916-3-tero.kristo@linux.intel.com>
 <cb9d65fe-47b9-4539-a8d0-9863e8ebf49f@kernel.dk>
 <fa2bc7e5088fd309d846a57edf06520dc83632ba.camel@linux.intel.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <fa2bc7e5088fd309d846a57edf06520dc83632ba.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/24 7:26 AM, Tero Kristo wrote:
> On Fri, 2024-10-18 at 08:21 -0600, Jens Axboe wrote:
>> On 10/18/24 1:30 AM, Tero Kristo wrote:
>>> @@ -2700,11 +2701,62 @@ static void blk_mq_plug_issue_direct(struct
>>> blk_plug *plug)
>>>  static void __blk_mq_flush_plug_list(struct request_queue *q,
>>>  				     struct blk_plug *plug)
>>>  {
>>> +	struct request *req, *next;
>>> +	struct blk_mq_hw_ctx *hctx;
>>> +	int cpu;
>>> +
>>>  	if (blk_queue_quiesced(q))
>>>  		return;
>>> +
>>> +	rq_list_for_each_safe(&plug->mq_list, req, next) {
>>> +		hctx = req->mq_hctx;
>>> +
>>> +		if (next && next->mq_hctx == hctx)
>>> +			continue;
>>> +
>>> +		if (q->disk->cpu_lat_limit < 0)
>>> +			continue;
>>> +
>>> +		hctx->last_active = jiffies + msecs_to_jiffies(q-
>>>> disk->cpu_lat_timeout);
>>> +
>>> +		if (!hctx->cpu_lat_limit_active) {
>>> +			hctx->cpu_lat_limit_active = true;
>>> +			for_each_cpu(cpu, hctx->cpumask) {
>>> +				struct dev_pm_qos_request *qos;
>>> +
>>> +				qos = per_cpu_ptr(hctx-
>>>> cpu_lat_qos, cpu);
>>> +				dev_pm_qos_add_request(get_cpu_dev
>>> ice(cpu), qos,
>>> +						      
>>> DEV_PM_QOS_RESUME_LATENCY,
>>> +						       q->disk-
>>>> cpu_lat_limit);
>>> +			}
>>> +			schedule_delayed_work(&hctx-
>>>> cpu_latency_work,
>>> +					      msecs_to_jiffies(q-
>>>> disk->cpu_lat_timeout));
>>> +		}
>>> +	}
>>> +
>>
>> This is, quite literally, and insane amount of cycles to add to the
>> hot
>> issue path. You're iterating each request in the list, and then each
>> CPU
>> in the mask of the hardware context for each request.
> 
> Ok, I made some optimizations to the code, sending v3 shortly. In this,
> all the PM QoS handling and iteration of lists is moved to the
> workqueue, and happens in the background. The initial block requests
> (until the workqueue fires) may run with higher latency, but that is
> most likely an okay compromise.
> 
> PS: Please bear with me, my knowledge of the block layer and/or NVMe is
> pretty limited. I am sorry if these patches make you frustrated, that
> is not my intention.

That's fine, but I'd much rather you ask for clarification if there's
something that you don't understand, rather than keep adding really
expensive code to the issue path. Pushing the iteration to the workqueue
indeed sounds like the much better approach.

-- 
Jens Axboe

