Return-Path: <linux-kernel+bounces-562288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D400CA621EE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163534217A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2991DF242;
	Fri, 14 Mar 2025 23:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6GkiZ2d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6621F2C5F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 23:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741995509; cv=none; b=JHy4oPKHdYa6bcZooTB/5HyXuG/hH+DwiXF2e3xxKK+CTcjajlhJosl2NsrHx0UfQTsSe6LBzBvl6DvtPL1MiQmczFKaLwwTMYbV5XKfbhMSRlXGPw/A7VUYufVJ4TovZtkSwvPg/UYopjdSjTShOitqF0tMq9T/iHSY0jCpUp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741995509; c=relaxed/simple;
	bh=69dd7xd1mZ55evjwRl2iomzzadXg2Ym/yARHbh32Wvc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FYUk+oFGzaYgFhSczWFKbPD4q6RfGdGv+n2RPhxqfyjJWIY64DGs6xytVJQFPaKF8LWZT3jG56Op2M7B81WMXeRpdgPuAqheljQncpVtgyzS93fEOQZ7TsurxLoK1iELCffm63Qz9lxYgwsLWMS2E3kN8d30SLzoErBSK16RKSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g6GkiZ2d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741995505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/+pqPwhhuA1m70WXFMJFVUSIH0xVcsCxujFwd6BBu4=;
	b=g6GkiZ2dZvRemqcScw5rLsZxlhjBq4MwKeyMZDMlYZq/GCqQ072m4Ao05t1hazpl2+3vc1
	8kvHxBQz2TZg7glkdtqdNvOKKrh9q5iFiAq296f6Oj2U2U/Jhys4IzEDQGSAlXmtF7Y6Gd
	GnxDUbg5OZIZcFLsdHFxRHHhuXYgIJs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-0YsQH1ImNoOKkQJNtrSlrg-1; Fri, 14 Mar 2025 19:38:24 -0400
X-MC-Unique: 0YsQH1ImNoOKkQJNtrSlrg-1
X-Mimecast-MFC-AGG-ID: 0YsQH1ImNoOKkQJNtrSlrg_1741995504
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c54a6b0c70so287528285a.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741995504; x=1742600304;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/+pqPwhhuA1m70WXFMJFVUSIH0xVcsCxujFwd6BBu4=;
        b=maV86zcV5nI7DISWgquqGzjVocOb41mZAbO4mH7Q06YNOjTg2O8wAOD7BvJZnXLTk+
         RYbyJK6kfokOMjgwIb2yaK4PkZ8Pg/onrlrziDZ6Yo40/uZsg7zzhrE7STThYYuONxr8
         l3UfBRhs/y7nIFQVFK4HZwDyQzVNYvDmJkNiUEN8cSpSpkOFtm423+K6Pz8hs/SxQJHy
         QqflaAVFzjpaVRO88hr/Sm/6pKlP/TK/xabK+HwyslSk9+/2129ayx16KLUV9Ifg/HJv
         xnNIa5RGb3U5mvRK9kUNmHES2s1P0ZNspyWyZY6q+g0jkfpJCdQws2LvO+rkZRDCtQ9y
         IjhA==
X-Gm-Message-State: AOJu0YyYuwMWsSKjEIG1tkDDZMZfExSMimMLBlYVc9p7Mepn7p3AukQn
	2LqPaU8UVIEunBIYED4HI8m6Lz/kgClYkZQmfYb8a+z6oEAtgt/Frw3YHdH2Qgkj6tHxpgVDk8x
	CzUV6trqtYnrMqQYwcfLyl6bDDIHrC2UhrgShV1OIlQFK5NTEqYyUXnikTynrMw==
X-Gm-Gg: ASbGncum59dz7+TlxgB/62Ss+P8obCXaShvIwf1YzRj6YaUUMTpoELcWVM6C9XBkzSG
	4+4iGl1zDQqN5Ez6VN+IAPsl/4acajSWcdfSrOOZVr6v2upoxLUU4E06AwZMa7QPgRVypMsTiN+
	N+rce7kkpO2ii88FclzEdMkWsQTZSRcJjQklhhczBZOU5gwGz++zPdUX/L4/ZROxyG7s8SVDMGH
	WGx1athtB8azwWQF/8qN7qm0ZY5GwjKq3/C4aiEugYVGarZSMg3FCf/kOyjrS00eOCYbjUdWf9N
	eMo4EbRa4v1fcPGj7zBkGSQfWKhAXr0xLUsf/aUcRhYY35+58CTt30NqUejcAw==
X-Received: by 2002:a05:620a:640b:b0:7c5:4b37:ae49 with SMTP id af79cd13be357-7c57c8efafbmr753880885a.48.1741995504091;
        Fri, 14 Mar 2025 16:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPSq3ng216shHxbLkXiUw8F6svxt3dd/sUT4M3Q1RJfkRQvMLJ7aqJ/o7XllrZpXwtwUT4IA==
X-Received: by 2002:a05:620a:640b:b0:7c5:4b37:ae49 with SMTP id af79cd13be357-7c57c8efafbmr753878585a.48.1741995503815;
        Fri, 14 Mar 2025 16:38:23 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d8aecfsm311297885a.100.2025.03.14.16.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 16:38:23 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <521d9ec6-9aab-46d9-82e6-dab9c52970af@redhat.com>
Date: Fri, 14 Mar 2025 19:38:22 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/isolation: Make use of more than one
 housekeeping cpu
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
 Vishal Chourasia <vishalc@linux.ibm.com>,
 Vineeth Reddy <vineethr@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20250218184618.1331715-1-pauld@redhat.com>
 <Z8b_A4YnOcNzGcaU@localhost.localdomain>
 <20250305171441.GC51446@pauld.westford.csb>
Content-Language: en-US
In-Reply-To: <20250305171441.GC51446@pauld.westford.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/5/25 12:14 PM, Phil Auld wrote:
> On Tue, Mar 04, 2025 at 02:24:19PM +0100 Frederic Weisbecker wrote:
>> Le Tue, Feb 18, 2025 at 06:46:18PM +0000, Phil Auld a écrit :
>>> The exising code uses housekeeping_any_cpu() to select a cpu for
>>> a given housekeeping task. However, this often ends up calling
>>> cpumask_any_and() which is defined as cpumask_first_and() which has
>>> the effect of alyways using the first cpu among those available.
>>>
>>> The same applies when multiple NUMA nodes are involved. In that
>>> case the first cpu in the local node is chosen which does provide
>>> a bit of spreading but with multiple HK cpus per node the same
>>> issues arise.
>>>
>>> We have numerous cases where a single HK cpu just cannot keep up
>>> and the remote_tick warning fires. It also can lead to the other
>>> things (orchastration sw, HA keepalives etc) on the HK cpus getting
>>> starved which leads to other issues.  In these cases we recommend
>>> increasing the number of HK cpus.  But... that only helps the
>>> userspace tasks somewhat. It does not help the actual housekeeping
>>> part.
>>>
>>> Spread the HK work out by having housekeeping_any_cpu() and
>>> sched_numa_find_closest() use cpumask_any_and_distribute()
>>> instead of cpumask_any_and().
>>>
>>> Signed-off-by: Phil Auld <pauld@redhat.com>
>>> Reviewed-by: Waiman Long <longman@redhat.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Juri Lelli <juri.lelli@redhat.com>
>>> Cc: Frederic Weisbecker <frederic@kernel.org>
>>> Cc: Waiman Long <longman@redhat.com>
>>> Cc: linux-kernel@vger.kernel.org
>>> Link: https://lore.kernel.org/lkml/20250211141437.GA349314@pauld.westford.csb/
>> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>>
> Thanks Frederic!
>
> Anyone with commit powers willing to pick this up?

Is this patch eligible to be merged into sched/core for the current 
cycle or will have to wait until the next one?

Thanks,
Longman


