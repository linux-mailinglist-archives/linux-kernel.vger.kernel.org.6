Return-Path: <linux-kernel+bounces-411280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ECD9CF596
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 21:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FDCDB24C06
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5560C1DA23;
	Fri, 15 Nov 2024 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQpph3EA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C73D15FD13
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701800; cv=none; b=bspV4I0MJvyZEAs5pNR7q0r/Ro3k3iY8fnM7VxxurhImK68zBQ2I6oFbi+D/AfUp3mpcSS4bIuJaXdakQDdgQ+QAr9jQtbnlti0IeMdThMbsYqsgNhCYqTe+HeNSbwNYkUYTwnCLDk0UlfVGBVIAaP4RzaIHy5YhxqPlMpya9oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701800; c=relaxed/simple;
	bh=1SznUmdqtZegKerQ3VgWTpXRnwOhIQ/2Dr8SUd0yV3Y=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=knDVBC8Eofk8YMswhICyXlLxwhM4V/lY8YTEhiIietzYtMzNIw3BIsWAeUDpBrYlhJ8n/g65AOuur5GOlztep6mH7PQlNBaMfEb6LE4UFp8y+3tVXkNPlQq91ZmlzqkwxjBmUDIbwVb6uhFoDzuTXLtpuIn/KW4VojXCMMF8cag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQpph3EA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731701798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47jct9np3l3LaIFZ4OXk56isjcp/0L3e+wDt5EGa+/8=;
	b=dQpph3EAuZKVwuxZnqjf+zmmK05XU3ORXuysVXvZyHaYnUJ2xbBfJ+VLGHD0t9xgyFeJGv
	rPTvYvLKM/st5VzicqRclu+f3svBaLbCUELuqUDoK214112PHctbl3As+Lkq5ZgbWa9pKB
	ADVnjysinoihZtEI6O4SrHqjrHtyOXY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-z8YIG-0uP6ePz8OU7pBW6w-1; Fri, 15 Nov 2024 15:16:36 -0500
X-MC-Unique: z8YIG-0uP6ePz8OU7pBW6w-1
X-Mimecast-MFC-AGG-ID: z8YIG-0uP6ePz8OU7pBW6w
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-46354129681so29137321cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 12:16:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701796; x=1732306596;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47jct9np3l3LaIFZ4OXk56isjcp/0L3e+wDt5EGa+/8=;
        b=aq7n5QhRxWpwrkG0+Kiitt6/zBWWC2PnbRQ22PJj2tid6bNMrxAiJCnBLyVAnxYWOy
         LA0qdho6phPGOjLA9J8LSAvmQmRwGaSwNH6uKLsr8RczjHPVLD4RYIljmcv9aK36WBXG
         qceYrID92WqAtZaGhZS0deZSylkL9f8EpMqmlC73kLTdPwfmanxuAcOJU1UImLoESkZn
         aaFYvM0mhJI0pvFafMsv3U+Nc2fgB8pn8jub4/e2PNSWp5c0aVVy3HWkLXaEdxDISd+e
         EXA4Bhi0Ql+fmHzjJl559e9r+Ypr8ffytJv3N4ubodftSIg4KWCAz3GsGarSalogFdS8
         UIBw==
X-Forwarded-Encrypted: i=1; AJvYcCUOarZxmcA6w9mOQ4IuEJ5Xe6m7aKrq/df8+3GFFDws+2m7FiIXxhMDifGQLXoM4vnpaGt0rlCcjYCLQiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnBGbKYe+maIon38AR0VScJjUUBv1J5i1NMokzTF6SiywFaTsm
	VJtu5OALKxfnW6HNeIn2jfkzJbOm6ME8aRjyN79P9VOJpY6elVF6R2+QcUT8d/zN1tBOWusR+QX
	lCrkrNi3V0psqmq9x9/T6K1va+MGvr5dlYKEH024DQ9cPExydG92zBMxPWAicPw==
X-Received: by 2002:a05:622a:298d:b0:458:4ce6:5874 with SMTP id d75a77b69052e-46363e100c6mr44684161cf.21.1731701795698;
        Fri, 15 Nov 2024 12:16:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERnY+JbNXc4WeIlKHasy1jkDmzupHTdQb4rkdAIssWtSl07qv5EwwZHB2cPIgwgHVNBb/tLA==
X-Received: by 2002:a05:622a:298d:b0:458:4ce6:5874 with SMTP id d75a77b69052e-46363e100c6mr44683821cf.21.1731701795305;
        Fri, 15 Nov 2024 12:16:35 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635a9cc353sm23604461cf.18.2024.11.15.12.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 12:16:34 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a840176f-2a46-4a2f-b48f-9eab40e542f9@redhat.com>
Date: Fri, 15 Nov 2024 15:16:33 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] blk-mq: isolate CPUs from hctx
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Costa Shulyupin <costa.shul@redhat.com>
Cc: ming.lei@redhat.com, Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
References: <20241108054831.2094883-3-costa.shul@redhat.com>
 <qlq56cpm5enxoevqstziz7hxp5lqgs74zl2ohv4shynasxuho6@xb5hk5cunhfn>
Content-Language: en-US
In-Reply-To: <qlq56cpm5enxoevqstziz7hxp5lqgs74zl2ohv4shynasxuho6@xb5hk5cunhfn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/15/24 10:45 AM, Michal Koutný wrote:
> Hello.
>
> On Fri, Nov 08, 2024 at 07:48:30AM GMT, Costa Shulyupin <costa.shul@redhat.com> wrote:
>> Cgroups allow configuring isolated_cpus at runtime.
>> However, blk-mq may still use managed interrupts on the
>> newly isolated CPUs.
>>
>> Rebuild hctx->cpumask considering isolated CPUs to avoid
>> managed interrupts on those CPUs and reclaim non-isolated ones.
>>
>> The patch is based on
>> isolation: Exclude dynamically isolated CPUs from housekeeping masks:
>> https://lore.kernel.org/lkml/20240821142312.236970-1-longman@redhat.com/
> Even based on that this seems incomplete to me the CPUs that are part of
> isolcpus mask on boot time won't be excluded from this?
> IOW, isolating CPUs from blk_mq_hw_ctx would only be possible via cpuset
> but not "statically" throught the cmdline option, or would it?

The cpuset had already been changed to take note of the statically 
isolated CPUs and included them in its consideration. They are recorded 
in the boot_hk_cpus mask. It relies on the fact that most users will set 
both nohz_full and isolcpus boot parameters. If only nohz_full is set 
without isolcpus, it will not be recorded.

Cheers,
Longman



