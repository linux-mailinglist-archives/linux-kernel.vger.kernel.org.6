Return-Path: <linux-kernel+bounces-402199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C58E9C24F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290801F23773
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EE41A9B3F;
	Fri,  8 Nov 2024 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtYQsHcV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF4233D80
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091319; cv=none; b=mYJa+oqZH6Xv//zpEwJaRVrJ84KrZjrC/rh+A3xS688duTNLwVfcw3vdYIkPJk5RwFRWJ4O8n9JBi5OFRcNpnaGkzcEfD17m8Iu7TK4gpcB6eaC7D2mwYmonVyvyuH5wvhJJIDTOV4XT3VK4gs+c8Zoo2xXptQQKaGxtHVesHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091319; c=relaxed/simple;
	bh=yiKNa1YzJHyP9N6NdrPYpDcZO3xnlIP0Sab7+rA3o2Q=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WiLyQLEEswJq2koSrrC7G1nGLxxzzj5rYlv0no2KY3sTHPXdOvgAdnTLL26iuk2j9BJXOlY3zpIDx6W3nwbXBZGfxOBa2pOExEIU1nPP805kPXzarushfU71HJ6geaDXydCbtnQgS05TRHSvQ0bJLiT1E+h2C/+sHrFkUbpKNNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtYQsHcV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731091316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q0FfSEVRQAO88lPffDrAoJKoPZUU0PR3SZ3mo7sUVTQ=;
	b=YtYQsHcVwfwe7Kmd335rh8HcM33uPc0ipB3QvIPNUy+MGcb+p1AqBczMGL2nTpOKzh1BsA
	G01K4Lzjy2iDz3N8kU8a6SPwHNwcUafm5MLcUcp2gSDw3v41EJs83nsrOeAtNvFYzM9s7/
	xIbd/3hSskFou8wwmAdrfK5XDACmPuI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-smw3K7kGP9-q6HOG7ljvKw-1; Fri, 08 Nov 2024 13:41:55 -0500
X-MC-Unique: smw3K7kGP9-q6HOG7ljvKw-1
X-Mimecast-MFC-AGG-ID: smw3K7kGP9-q6HOG7ljvKw
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbd2cb2f78so48787986d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 10:41:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091314; x=1731696114;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0FfSEVRQAO88lPffDrAoJKoPZUU0PR3SZ3mo7sUVTQ=;
        b=kEtO3Cigp4N96UU4NGYODArylnS5JoyQLUGeOM8gQBEhcW/XSV+6l0Ivuiz+Xyh8qz
         bZY6CsTyP7zmUOvJKx+ok+YxBlYUebbvutdgv9ssyCfcdXNCaudtSUNdsML+vyBEKgCk
         DEE6h3UXAZgTgLMdow9sbiHh+6ICi4JtwakoWvhIxgi3IcdHG3idpyVrS2MgqxdiFkSo
         09iO3LvSGC2AbFpI9FnbkWKZgbY+cU7ZZNEia38UrCg5QcAsmQq889pqlKKSBnnSjbuE
         7ogO2F9TyrxrxfYHzxkNIv1ExGTXvipUJwuRckudBmOvttHxVdhvaCjX8k8O6o0bHjkA
         v6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3YH9X5k36wd3nHY5hH7WEdNU6OILocKGS46j8lOIeh/8RmzL82WeeGCeapCcfICWrzz1SZoGNXVU5NKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvfR0Hn3vdaM2ci8LmaaC2e4V7pmOFgiVrMSbsb6hFiy9+4uhN
	jnG6k6quKChgfhvpzf59/hDzzUEQpYQD3CpOBG08qIP138yXxD2simvqpf3WP+pQOAA+Afpbp8P
	WC+NVqL0tR939azCnYunsbA16sASPIfRRzrYhiqET1bSbBCv40jTjcIvhB9iNww==
X-Received: by 2002:a05:6214:238a:b0:6cb:55e4:54d5 with SMTP id 6a1803df08f44-6d39d57cfe0mr68186356d6.10.1731091314628;
        Fri, 08 Nov 2024 10:41:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEulkMBjLQa5N5BKzR6Ili4m1lWrIDuuPghe2E7BICMEkEDxY1C13mo8CapNL0jCDlWwTqnyQ==
X-Received: by 2002:a05:6214:238a:b0:6cb:55e4:54d5 with SMTP id 6a1803df08f44-6d39d57cfe0mr68185966d6.10.1731091314302;
        Fri, 08 Nov 2024 10:41:54 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961ed63fsm22203876d6.32.2024.11.08.10.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 10:41:53 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c4eebfa9-bfea-4ebe-b5d1-de88f1f5cc54@redhat.com>
Date: Fri, 8 Nov 2024 13:41:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/deadline: Skip overflow check if 0 capacity
To: Juri Lelli <juri.lelli@redhat.com>, Waiman Long <llong@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
 Joel Fernandes <joel@joelfernandes.org>
References: <20241108042924.520458-1-longman@redhat.com>
 <Zy4RWJPH9jxew_7G@jlelli-thinkpadt14gen4.remote.csb>
 <735344cd-1c32-451f-904e-235578e1a360@redhat.com>
 <Zy48-zbUnjTzxXXB@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <Zy48-zbUnjTzxXXB@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/8/24 11:31 AM, Juri Lelli wrote:
> On 08/11/24 08:39, Waiman Long wrote:
>> On 11/8/24 8:25 AM, Juri Lelli wrote:
>>> On 07/11/24 23:29, Waiman Long wrote:
>>>> By properly setting up a 1-cpu sched domain (partition) with no
>>>> task, it was found that offlining that particular CPU failed because
>>>> dl_bw_check_overflow() in cpuset_cpu_inactive() returned -EBUSY. This
>>>> is due to the fact that dl_bw_capacity() return 0 as the sched domain
>>>> has no active CPU causing a false positive in the overflow check.
>>>>
>>>> Fix this corner case by skipping the __dl_overflow() check in
>>>> dl_bw_manage() when the returned capacity is 0.
>>>>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>>>    kernel/sched/deadline.c | 8 +++++++-
>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>>>> index be1b917dc8ce..0195f350d6d3 100644
>>>> --- a/kernel/sched/deadline.c
>>>> +++ b/kernel/sched/deadline.c
>>>> @@ -3479,7 +3479,13 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
>>>>    	} else {
>>>>    		unsigned long cap = dl_bw_capacity(cpu);
>>>> -		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
>>>> +		/*
>>>> +		 * In the unlikely case of 0 capacity (e.g. a sched domain
>>>> +		 * with no active CPUs), skip the overflow check as it will
>>>> +		 * always return a false positive.
>>>> +		 */
>>>> +		if (likely(cap))
>>>> +			overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
>>> The remaining total_bw that make this check fail should be the one
>>> relative to the dl_server on the cpu that is going offline. Wonder if we
>>> shouldn't rather clean that up (remove dl_server contribution) before we
>>> get to this point during an hotplug operation. Need to think about it a
>>> little more.
>> static inline bool
>> __dl_overflow(struct dl_bw *dl_b, unsigned long cap, u64 old_bw, u64 new_bw)
>> {
>>          return dl_b->bw != -1 &&
>>                 cap_scale(dl_b->bw, cap) < dl_b->total_bw - old_bw + new_bw;
>> }
>>
>> With a 0 cap, cap_scale(dl_b->bw, cap) will always be 0. As long as total_bw
>> isn't 0 and bw isn't -1, the condition will be true.
> Right, but I fear that by hiding the special corner case we would also
> miss the cases where we have DEADLINE tasks with bandwidth on that
> single CPU and then ignore it.
>
> So, maybe something like the below?
>
> ---
>   kernel/sched/deadline.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index be1b917dc8ce..7884e566557c 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -130,11 +130,24 @@ static inline int dl_bw_cpus(int i)
>   	if (cpumask_subset(rd->span, cpu_active_mask))
>   		return cpumask_weight(rd->span);
>   
> +	/*
> +	 * Hotplug extreme case in which the last remaining online CPU in a
> +	 * root domain is going offline. We get here after that cpus has been
> +	 * cleared from cpu_active_mask, so the loop below would return 0
> +	 * CPUs, which of course doesn't make much sense. Return at least 1
> +	 * CPU.
> +	 */
> +
> +	if (cpumask_weight(rd->span) == 1)
> +		return 1;
> +
>   	cpus = 0;
>   
>   	for_each_cpu_and(i, rd->span, cpu_active_mask)
>   		cpus++;
>   
> +	WARN_ON(!cpus);
> +
>   	return cpus;
>   }
> ---

This patch looks good to me.

With this patch and my cpuset patches applied, the test_cpuset_prs.sh 
test passed without any error. You can add the following tags if you 
send this patch out.

Reported-by: Waiman Long <longman@redhat.com>
Tested-by: Waiman Long <longman@redhat.com

> That said though, I believe I just found an additional issue. With the
> above the system doesn't crash (it did w/o it), but happily moves
> DEADLINE tasks out of a domain with a single CPU going offline. Last
> time I looked at this we were properly checking and failing the hotplug
> operation, but it was indeed a while ago, so not sure yet what changed.
> More staring.
>
> Oh, so broken, yay. :)

The cpuset code will move tasks in a partition with no effective CPUs to 
its parent.

Cheers,
Longman



