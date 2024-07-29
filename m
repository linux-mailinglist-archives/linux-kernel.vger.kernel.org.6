Return-Path: <linux-kernel+bounces-265165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D759693ED7E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9851F224E6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFDC82862;
	Mon, 29 Jul 2024 06:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cD5hgNPv"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C242F7F47F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722234680; cv=none; b=aXraWCHTNwehxES6Iz9/dSls9KhfekEM+7uYmPzqDp7SYRcJxMozOJio5yybdJau4SgB5fAoznSmPDVefZ+I936jAaIEhl91oQ9XJ8QAc0SCI12L5VbmlI3dBfidtUrEMUTbaIapfvLdOaBEWJqbNIZPKLt4CGzBSBL1AveDSTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722234680; c=relaxed/simple;
	bh=/C3B0Oct8zCSYrOl8yi03Lq+0uiGOJZUjSa+xisHWCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESvGE/JVEKFXTH3/kw9eAJmJQtdTBE++xVyP/naLIBBkRyje5kAcDPZPAh/fxqWKjy6CvHnnujX955W8iOHvrdBO6kadxu3r9wKm/ELwvNYCMiicjdNvGNy52z9Mb1XQsXb80W/PHtxln24yw+aPKnqtYxMiZvYSW1rxFxez93g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cD5hgNPv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cb5789297eso1586667a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 23:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722234678; x=1722839478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nWoiF4yuxuiqN4YSC5480YbCBqC3nr5lj8cUGhjIgQ=;
        b=cD5hgNPvlydlk/diyXLYdE24iZ3XSF59XPopCZEzIsgx8vWEw9lsBVSCDmZWaye2bL
         qaSddJzWPq0pSTMSkpjMMaZq6KYMjFQdOAT3mbzWLHsyUrmkujIu/gdTB79UR76l1KDZ
         bngZjidciHQKMD7M/6DJwI0w2tLGFeGFotLLf1QbnPoy1lnVf66AjO1/VpVIwkddQtH9
         z321tX0IrRfPULEKPFqZkrv0i5XB2I4TxZsyumfPRdLQn092A9R6E3A6O/SdgQrXhKVR
         uVVISJQgLo5R8tQXlkdmHGL83tTZqw7mtXHSXL5iBWYbqZNuS5TZVARdy6g+Xw4AtKHz
         4+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722234678; x=1722839478;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9nWoiF4yuxuiqN4YSC5480YbCBqC3nr5lj8cUGhjIgQ=;
        b=lobruqTXNMSPpln3FYaqNMCkWl80yMbOoGtAq61ButdwfBqjtbfso2wuxDeu/aSxd+
         s4pOD5OXipK1XwhMaWkoljioZxofbNAmNpbCjlYHA0zbjSy60JlCAqI87lxlxz5nkUKa
         Tn5XuUHOebi79/i9nmjC/CK557BmkSmhj47P0ibI8NGzny/tEHA3+1oy5Ws7I0BVSeYP
         Ul1K0K5ZkRP2YiT2Fd+a7G6G3+BtdH6a96N4PALPIjzgeGayfO83A4VjTeec+/3vprsL
         zHR05eJptDH+Y9n41HnoNwqKwMYiK1t0u+VY5pzcKK2WwpAYxxK3453RxChdZ9kiYzCb
         k2Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ2sFkIN74GNQ7ejmP0ecxDhV8jN9hF6A4RrIAy7RJzDlN/4tfjR3Kv536ZvfUPB3jUzunGC+J/ANmCjbyn88FnOxOSqKLC+2DZAYs
X-Gm-Message-State: AOJu0YyKUkvAc33bO7gLogZeGZBcz3wDjK3cDtdj3ndI0Nvdd2mx8nGX
	pp+GaI1Fckyjsp04g5BHrXC95/tDL5/pfwO7Q3dO/ax2k1cj6rNxkG73jRxPMNQ=
X-Google-Smtp-Source: AGHT+IFBAB3zGDkyPt3DXHHvQeAOIU1sLHtjrAIPrLPMrDJrsJNaVKrgBkR465ShyKpSJnXwtkyP6g==
X-Received: by 2002:a17:90a:d812:b0:2cf:5c8b:aa96 with SMTP id 98e67ed59e1d1-2cf7e09b500mr4396218a91.9.1722234678047;
        Sun, 28 Jul 2024 23:31:18 -0700 (PDT)
Received: from [10.84.153.104] ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb65158bfsm9862931a91.0.2024.07.28.23.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 23:31:17 -0700 (PDT)
Message-ID: <1cc3630c-6b2c-4eee-9757-873c17d42e9e@bytedance.com>
Date: Mon, 29 Jul 2024 14:31:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] psi: Inherit parent cgroup psi enable state
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: chengming.zhou@linux.dev, linux-kernel@vger.kernel.org, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, surenb@google.com, peterz@infradead.org
References: <20240729034100.1876510-1-zhouchuyi@bytedance.com>
 <0a6182b4-e5e8-0eb6-234a-9097fffe5069@amd.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <0a6182b4-e5e8-0eb6-234a-9097fffe5069@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

在 2024/7/29 12:45, K Prateek Nayak 写道:
> Hello Chuyi,
> 
> On 7/29/2024 9:11 AM, Chuyi Zhou wrote:
>> Currently when a parent cgroup disables psi through cgroup.pressure, 
>> newly
>> created child cgroups do not inherit the psi state of the parent cgroup.
>>
>> This patch tries to solve this issue. When a child cgroup is created, it
>> would inherit the psi enabled state of the parent in group_init().
>> Once the enable state is found to be false in the css_populate_dir(), the
>> {cpu, io, memory}.pressure files will be hidden using cgroup_file_show().
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   kernel/cgroup/cgroup.c | 21 +++++++++++++++++++--
>>   kernel/sched/psi.c     |  4 ++--
>>   2 files changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index c8e4b62b436a4..775fe528efcad 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -1719,6 +1719,24 @@ static void css_clear_dir(struct 
>> cgroup_subsys_state *css)
>>       }
>>   }
>> +static int populate_psi_files(struct cgroup_subsys_state *css)
>> +{
>> +    struct cgroup *cgrp = css->cgroup;
>> +    int ret, i;
>> +
>> +    ret = cgroup_addrm_files(css, cgrp, cgroup_psi_files, true);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    if (cgrp->psi && !cgrp->psi->enabled) {
>> +        for (i = 0; i < NR_PSI_RESOURCES; i++)
>> +            cgroup_file_show(&cgrp->psi_files[i], 0);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +
>>   /**
>>    * css_populate_dir - create subsys files in a cgroup directory
>>    * @css: target css
>> @@ -1742,8 +1760,7 @@ static int css_populate_dir(struct 
>> cgroup_subsys_state *css)
>>                   return ret;
>>               if (cgroup_psi_enabled()) {
>> -                ret = cgroup_addrm_files(css, cgrp,
>> -                             cgroup_psi_files, true);
>> +                ret = populate_psi_files(css);
>>                   if (ret < 0) {
>>                       cgroup_addrm_files(css, cgrp,
>>                                  cgroup_base_files, false);
>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>> index 020d58967d4e8..d0aa17b368819 100644
>> --- a/kernel/sched/psi.c
>> +++ b/kernel/sched/psi.c
>> @@ -180,7 +180,7 @@ static void group_init(struct psi_group *group)
>>   {
>>       int cpu;
>> -    group->enabled = true;
>> +    group->enabled = group->parent ? group->parent->enabled : true;
> 
> Since this is only the init path, if the user later enables PSI
> accounting for a parent, should it not re-evaluate it for the groups
> down the hierarchy?
> 
> Looking at "cgroup_pressure_write()", I could not spot it calling
> "css_populate_dir()". Should it not walk the hierarchy and do a
> "cgroup_file_show()" considering the changes in you patch?
> 
> (P.S. I'm not too familiar with this piece of code so please do let me
>   know if I missed something obvious)

Perhaps my description in the commit log was not clear enough. This 
patch is intended to make child cgroups inherit the state of the parent 
node *during initialization*. The cgroup.pressure interface remains the 
same as before, only changing the enable state at the current level.

In production environments, the overhead of PSI could be significant on 
some machines (with many deep levels of cgroups). For certain tasks 
(such as /sys/fs/cgroup/offline/pod_xxx), we may not need to monitor 
their PSI metrics. With this patch, after disabling 
/sys/fs/cgroup/offline/cgroup.pressure, any subsequently deployed 
offline pods will not enable PSI. Although users can disable PSI by 
traversing all cgroups under /sys/fs/cgroup/offline/, this may not be 
convenient enough.

Thanks.

