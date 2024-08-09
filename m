Return-Path: <linux-kernel+bounces-280299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CFF94C856
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE172839AA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35A511CBD;
	Fri,  9 Aug 2024 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HBXFiyUt"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A47312B8B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168759; cv=none; b=oy79/EZD/YJUkSHJjMSDNXjW3Qw/lb/3U38pc2vDhl3M+nxLX6UECQ7l8yXBz3Ao6uWhpVtQGckLetNsJ1ScxUpcJteU4qRDD9PrMaeKrjhBWU9Y79a9lfuPBOtaTUr6fM6mgzR9+wjZFX+AzreQx8K5co0ERfsrKasnQr1na2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168759; c=relaxed/simple;
	bh=WqapPhJd4up6BabgiqCpDKyWdkUYttxWT5ytTZDJLbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxU0HzMUD6JpNjL9DZCzLl7IU8tphbvHVYhNdFbnRordVX0Ms8sX463UfifKhTNu5hgkteKkBoSZ2GE4xPJ6VNYaHCxBvxjU2D420++GdGpuFDs9WDM6Fu9FVHNo6Rfb18iOot2uxd0b19TmP4nRLgTNPi3zyUHTdSYNnx9xjEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HBXFiyUt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70eae5896bcso1439640b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 18:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723168757; x=1723773557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bc6qffhUwkcXDacAW5Q78/sO/0S1JDVscanGD2RO8to=;
        b=HBXFiyUtYcWRcCnJHOY6POPe5ik2oERcs65MVdkhe/R8xtK/WEabeLTTOhW9BudO2m
         egR6JaR8IIkDT/VJ/HUVTNI3i/X/Rq5fa8sC/hTHxcW/t5MB5EZdt1YVv5pQirFvnm+M
         2PGlj7Hd6aIKkmH5tWhlc/9Tb2s8ZR4lboE+TMTgkT4UeigF+6KfCDd4upUCjByHmjew
         3vCt08ChUjotiGptNjwXDHi7oS3eJ/0Zo6OWDYtMafaPOzMbqWMMMa1mZt+qcGWwPSfn
         beWl+1WsOiAPxiLhvcZWzK1QYLsCY8NGaBM5U1SgfYbW+FNlLkM9/5eMRHPVjzbws+mC
         KqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723168757; x=1723773557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bc6qffhUwkcXDacAW5Q78/sO/0S1JDVscanGD2RO8to=;
        b=REtogmh49IdN/oDPUgOp6oY80sFH3tQEt1tWGiD+ToLTqTakz2z63hQjVC0dnihi4N
         dGEFE7FYWYYAaLFtD70zh9Zvte8M4Um26iPtWkPQnNwCR6L1piLCbXyzHDlfC+e1fN7N
         hEhwQRy6yDS3rIZPaqRjFDh5FNU+YCZa7xcYw/0f/gyChaHmtDd9bW5zJhaDAGBy2R4h
         s9baBr7QCIrLdIaU+5AghvRaLLKs1umFFeuxezsl+233glmoNaRaFEXQzGHx36sb4n8h
         4urpYSmv/qbvJt9Zf4KkXPsfCSuymZpLRtVhcsm9+ZNOeZi43gWenrAwWjMFeJSw5KSd
         WR5g==
X-Forwarded-Encrypted: i=1; AJvYcCU82RdUTtCqYQQlgnIfFAEK6vJM8bAUEknreDHAmw2ynGef5MSpc+ub/VVwKbt4nY5MdTjyBklw/9K1Q8sm4tZI5FRy4PjmwJbSFxLa
X-Gm-Message-State: AOJu0Yx+qF38A5gE9CXbwYWCxfQxWDVq/674pQA9TymBt2QzsBjxi8UJ
	be9wGHJXz0g4mlxlFgnQXCmi4cu0G6MpBC/YLpIgl1I9lBguWek15bwH4QsB3i8=
X-Google-Smtp-Source: AGHT+IG3he0uCvXiEW00NgfKnLWgtrpdEAA57ga0AU/qpFPwIontak7wRj1ywcp/+A5LgcQbO6J1eg==
X-Received: by 2002:a05:6a00:3a04:b0:70a:ffc7:f921 with SMTP id d2e1a72fcca58-710dc79c714mr17715b3a.22.1723168756859;
        Thu, 08 Aug 2024 18:59:16 -0700 (PDT)
Received: from [10.70.146.105] ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb209337sm1784092b3a.15.2024.08.08.18.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 18:59:16 -0700 (PDT)
Message-ID: <aa5b5bf5-64cd-4c23-a491-5e04acf53d23@bytedance.com>
Date: Fri, 9 Aug 2024 09:59:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH 1/2] perf sched timehist: Add --show-prio
 option
Content-Language: en-US
To: vineethr@linux.ibm.com
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240806015701.1309833-1-yangjihong@bytedance.com>
 <20240806015701.1309833-2-yangjihong@bytedance.com>
 <3f4a68aa-8a74-4698-bf90-d69c315d5ffd@linux.ibm.com>
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <3f4a68aa-8a74-4698-bf90-d69c315d5ffd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 8/9/24 02:42, Madadi Vineeth Reddy wrote:
> Hi Yang Jihong,
> 
> On 06/08/24 07:27, Yang Jihong wrote:
>> The --show-prio option is used to display the priority of task.
>> It is disabled by default, which is consistent with original behavior.
>>
>> The display format is xxx (priority does not change during task running)
>> or xxx->yyy (priority changes during task running)
>>
> 
> I had done the following steps.
> 1) Ran 'perf sched record stress-ng --cpu 32 -l 50 --timeout 40s'
> 2) Changed the nice value of stress-ng while the record was going on.
> ps -C stress-ng -o pid=
> 64195
> 
> renice -n 10 -p 64195
> 
> 3) Then ran 'perf sched timehist --show-prio'
> 
> 343918.720052 [0015]  stress-ng[64195]    120  0.013      0.013   21.719
> .
> .
> 343958.797257 [0009]  stress-ng[64195]    130  40076.812  0.007   0.393
> 
> The output shows the final priority change of stress-ng from 120 to 130,
> but the transition format xxx->yyy is not displayed.
> 
> Am I missing something?
> 

1. I think it may be because when change the priority of stress-ng, the 
stress-ng task had been sched_out and did not run.

2.
sched_switch: A         ->  B(prio1)
sched_switch: B(prio_2) ->  C

The specific details are that:
first process the first sched_switch event, read the priority of task B, 
as prio1.
then process the second sched_switch event, read the priority of task B, 
as prio2.

Only when change the priority of task B, it is in the running state, 
will show prio1->prio2

Thanks,
Yang.

