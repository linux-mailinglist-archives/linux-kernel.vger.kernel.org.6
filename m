Return-Path: <linux-kernel+bounces-439183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FFA9EABF8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC4028B5B6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A98D233D9C;
	Tue, 10 Dec 2024 09:28:42 +0000 (UTC)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996EE233D99
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822921; cv=none; b=lH1A8vOpnVtFpXg1CLbMvh+MyvFwn+8L13R1DQ5u+XbeWUJ+M+JtYtM1CPmQLvL51DXuntWtZ0R5tG6yW4zvPTv62rPQA86jtZyPcYTZfQzqCPZFmJ3oYBiEkJCtT3K2GN8+n3aY3ZZgOPBm60WYmWdxzIGsLDd0BvQkjdYyMbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822921; c=relaxed/simple;
	bh=Hen9mL8VFnCsSIqmrutXZMQBQMKYv8eIqkZRi/7iyZA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n633yfC2GXoNghoTlyJN3bQ/abRVaJoD2VAU0TRtYEO9mkVZl1OTxl9kQSgw1g4OOtMYSqXsYgdWE3wNISUXECIMxavM3VIJ9z6i80b5L05VYaQD1bgCw/mxThGSJ9L3ciT35cpxxlEQ/DyGbNhgmdAcZNKfG1byI8rcdq22PrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso57893855e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822918; x=1734427718;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNPVayImEARcjG/YE4JLJqKletj7xza5QUpWWQutVv4=;
        b=DXZtjFK1TS61IGfAe5B6+/O+q85MZ0JnVD8eOmfRMftSYvauNsbQboB5RbCZxF3Eeb
         au6dFVX1O/JhnG4AO/6/0pPpqcRH5zRYeCa2/uHSwOFJ9+f6gmM+cHwQR1kNzQmPs92U
         DdLhL0NLI1WMU8lR42KfBuG0vbMjDi8lO8tAKoAU4gIna8zcDxnMLyNiO5KkUCQtlGA4
         ioN+TRskXBGJIuV0xSbAB/XoMoZIhUsBB5M2pw3idUJE/KnRuM3eRW113drDO67LhWiD
         Z9OQj2SHqiJgr2U0k6sYRHUwI3Ej7qdzV0skDb4n/VzwmGO1P0b9xzbuEBqOw8DTlV9b
         NG6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBjDOOQ3rGSjLAx6iiUySy4igoTTPZwy8hggB7oC6nmx/rWJGU3WrhUQJ4caBAMz1Q9wi5JX7dzpPmXYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdbXOdLo9nzhxTcr64eb/lB0NJaUIyVCxYfPmTA7kzD8y0PVKW
	lU8l47vIcTJ7WISqxdDZ3WBZXOX1PRcqKbQI29UY5SNMWurbtG4V
X-Gm-Gg: ASbGnctE/UkyQyx/hGE/TQzA7KCjjDzP5vQ8FumUKVUGMtm1jjdU2cLyq9Bnte0HgtG
	c9RlDxgO0vzf+bFMBRTbQ2y4/oxrBhzQWL3KLxgPZf0xosdnhPNO8oLS0pm7M9KsuqwWxXbZ4Gw
	ROe1Mua1juLKlxIcf7UnUD+9oYABBhnFB2SSuyoPZamN2K5K2uGN6fE+Ko4gn3orSCoE3E+G9Lt
	UyQRfmD86H0b2IdwuMIcLzqSRJmkBNj1iMYFLYBKqec/YdaCXEEv6EpILVIvrbK/1aRBQIUulFu
	sl6N7NNaBg==
X-Google-Smtp-Source: AGHT+IFK7vTYn6092bwB7F2DYU6RsnFI1A5x4DrQT9rWLIyY/ZkpGoI8o/AdJSdgSUdgw2sz/06//g==
X-Received: by 2002:a05:600c:4587:b0:434:f396:525e with SMTP id 5b1f17b1804b1-434f39653f2mr67596805e9.9.1733822917624;
        Tue, 10 Dec 2024 01:28:37 -0800 (PST)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386257de681sm15192837f8f.30.2024.12.10.01.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 01:28:37 -0800 (PST)
Message-ID: <10db7c11-5578-4386-88ae-542ffcaac818@ovn.org>
Date: Tue, 10 Dec 2024 10:28:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Peter Zijlstra <peterz@infradead.org>,
 Joel Fernandes <joel@joelfernandes.org>, LKML
 <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, vineethrp@google.com,
 shraash@google.com, marcel.ziswiler@codethink.co.uk
Subject: Re: [v6.12] WARNING: at kernel/sched/deadline.c:1995
 enqueue_dl_entity (task blocked for more than 28262 seconds)
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
References: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org>
 <20241206151819.GA3949140@google.com>
 <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>
 <20241209105514.GK21636@noisy.programming.kicks-ass.net>
 <CAO7JXPgSYCzu0mtnWqBaS8ihmoQXX3WE_Yb_rEYuMeQn+B6KJg@mail.gmail.com>
 <20241209125601.GQ35539@noisy.programming.kicks-ass.net>
 <8ff30c5d-b8ac-4825-874a-d73931b85014@ovn.org>
 <CAO7JXPijXstA3Eh_LrRGiK26U1Mfn8C1jSXP+4kfTnQRxSax7g@mail.gmail.com>
 <CAO7JXPjGFmfwAVcSaRhtM2Mf=V9P6oQm6H=QfHcFhtkLU8magQ@mail.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <CAO7JXPjGFmfwAVcSaRhtM2Mf=V9P6oQm6H=QfHcFhtkLU8magQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 03:58, Vineeth Remanan Pillai wrote:
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index fbdca89c677f..1f4b76c1f032 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1159,8 +1159,6 @@ static inline void update_curr_task(struct
>> task_struct *p, s64 delta_exec)
>>         trace_sched_stat_runtime(p, delta_exec);
>>         account_group_exec_runtime(p, delta_exec);
>>         cgroup_account_cputime(p, delta_exec);
>> -       if (p->dl_server)
>> -               dl_server_update(p->dl_server, delta_exec);
>>  }
>>
>>  static inline bool did_preempt_short(struct cfs_rq *cfs_rq, struct
>> sched_entity *curr)
>> @@ -1210,6 +1208,11 @@ s64 update_curr_common(struct rq *rq)
>>         return delta_exec;
>>  }
>>
>> +static inline bool dl_server_active(struct dl_sched_entity *dl_se)
> Sorry a small typo in here. it should be struct sched_dl_entity and
> not dl_sched_entity. The line should be:
> 
> "static inline bool dl_server_active(struct sched_dl_entity *dl_se)"

Sure.  I can try that.

Note:  I did indeed got lucky with the warning after 1 minute the
first time.  The second time I tried the system didn't show any
issues up until 6 hours into the test...

Best regards, Ilya Maximets.


