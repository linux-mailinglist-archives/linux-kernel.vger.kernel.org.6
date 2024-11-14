Return-Path: <linux-kernel+bounces-409584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36299C8ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3270F1F21DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F451A2658;
	Thu, 14 Nov 2024 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCu6GR4q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17000153803
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599327; cv=none; b=TnYq84iUqKavWDsKznntqZag3vpdndhdJtF76lkQaqZpKqdp742CpTcBB7cXg9jqLEDUOaDyYmNga10HN+Twdij6PbyFTCNrM4yOWZj/h8pW+/lM/IsMh8btvoVhB/zVrVDhGyzA9bM9pcBReFgkwUdStxK+ylAg+gpvx7xPtXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599327; c=relaxed/simple;
	bh=Cr4zh3Huan6wC82sBXmJ9IOIYOwMUYdpM3trjg32boA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BNw/7FfWo4m6j6AOcPiv1egxZDInHVm6qWAihDSjzkA7SU2Sk4uVj2LJl/9DRAuL2tWMaG+nWQzxIlPmmw2YPd+pBZW61geo+hIoZAr5SF07FwLSw0nBwQ3Jy/MEsrTsRltO4hgkWeVJvf+U2THI1LO1su/Tp78ld9G/XhfauDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCu6GR4q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731599325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hxu65R1VpWi7OygodLPAoq8pHTPiYLLEu9HCXe73kUo=;
	b=hCu6GR4qh6ND10cOOk0zyFYU6xiNBlVBJNQqXZvviY0ko2DWjUdtvdAJwaYK2oq726e1IC
	K05rQyCpBSiWvjrDBhKv2+R7U7Q8pWvz4TumPnfcP0wG433b0/0VPqdZLC2VdLivM2n6Ng
	QlbYbWmT1pRVulwEIwnXVX8/sRMajqc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-Q0rHoNr8PtehcLhz4j_N2A-1; Thu, 14 Nov 2024 10:48:43 -0500
X-MC-Unique: Q0rHoNr8PtehcLhz4j_N2A-1
X-Mimecast-MFC-AGG-ID: Q0rHoNr8PtehcLhz4j_N2A
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbebfc1725so8909416d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:48:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731599323; x=1732204123;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hxu65R1VpWi7OygodLPAoq8pHTPiYLLEu9HCXe73kUo=;
        b=BN+qTasTUELV4ssOdV3G3tw7andwcn4WepBPifiV5KIxn31HACEB28Z0vsfbivCqBU
         EpfqkBMmt/DbSOZnvZnaks/+0lne5/5TS+frvNvBg1gjjBAd01UhnV8udyaFYJEF4nh+
         uPUOnaQp8jFKe/XGNgU9YsS3MIiWp3M6lV36+1+K+Oas2of3rSnpeHv392d5imkfv5d0
         7YjsY6QpFHpY2NCOWCYwo/J9LuYpTImvTeYYcVEvBwVAYb4bShokNE/I7XMPLK7kaYvl
         OwpFnbwQHzKOFM5e7r8LN0sQw6xLlteTKlQj4/pvMd5uXVQS81h0ZcEHg5UWve9NM/X1
         uTPA==
X-Forwarded-Encrypted: i=1; AJvYcCULGRjMt7mu5scLciZapR1JCKDidd9sp55kuJv77vArQQADHjXISRZAGb+ydVyYv6kAK9IQCgBCMIs/bUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvvun2iku1S2p4UX7Te/gbAO43MQQZJZr8kz31/Vx3DlIINl56
	HPMI4bz47/9pM+zWzbTnlWiDL+qMbZtSkTcTYiWRHzNMIRiKh19FtTntJ6vSwGAwkyzrSB7LexC
	4tWVYuL+i2v3TRKpHWC2fizwmKqOATr5J/T5I5tJ4gVEQdsuk+02m/wKX1SDRWQ==
X-Received: by 2002:a05:6214:4984:b0:6cd:7a2e:4611 with SMTP id 6a1803df08f44-6d3edeb0549mr31849826d6.47.1731599323405;
        Thu, 14 Nov 2024 07:48:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbOxWGUuPQZsAGzr3v4Bmwr4RaINJu13zJ5e9Sq/GXMpfn4gtjidU8tgSmSdZvNosq3q56xQ==
X-Received: by 2002:a05:6214:4984:b0:6cd:7a2e:4611 with SMTP id 6a1803df08f44-6d3edeb0549mr31849476d6.47.1731599323085;
        Thu, 14 Nov 2024 07:48:43 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee972c59sm6631096d6.130.2024.11.14.07.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 07:48:42 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <82be06c1-6d6d-4651-86c9-bcc828cbcb80@redhat.com>
Date: Thu, 14 Nov 2024 10:48:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix DEADLINE bandwidth accounting in root domain
 changes and hotplug
To: Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Phil Auld <pauld@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Aashish Sharma <shraash@google.com>,
 Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20241114142810.794657-1-juri.lelli@redhat.com>
Content-Language: en-US
In-Reply-To: <20241114142810.794657-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/24 9:28 AM, Juri Lelli wrote:
> Hello!
>
> v2 of a patch series [3] that addresses two issues affecting DEADLINE
> bandwidth accounting during non-destructive changes to root domains and
> hotplug operations. The series is based on top of Waiman's
> "cgroup/cpuset: Remove redundant rebuild_sched_domains_locked() calls"
> series [1] which is now merged into cgroups/for-6.13 (this series is
> based on top of that, commit c4c9cebe2fb9). The discussion that
> eventually led to these two series can be found at [2].
>
> Waiman reported that v1 still failed to make his test_cpuset_prs.sh
> happy, so I had to change both patches a little. It now seems to pass on
> my runs.
>
> Patch 01/02 deals with non-destructive root domain changes. With respect
> to v1 we now always restore dl_server contributions, considering root
> domain span and active cpus mask (otherwise accounting on the default
> root domain would end up to be incorrect).
>
> Patch 02/02 deals with hotplug. With respect to v1 I added special
> casing when total_bw = 0 (so no DEADLINE tasks to consider) and when a
> root domain is left with no cpus due to hotplug.
>
> In all honesty, I still see intermittent issues that seems to however be
> related to the dance we do in sched_cpu_deactivate(), where we first
> turn everything related to a cpu/rq off and revert that if
> cpuset_cpu_inactive() reveals failing DEADLINE checks. But, since these
> seem to be orthogonal to the original discussion we started from, I
> wanted to send this out as an hopefully meaningful update/improvement
> since yesterday. Will continue looking into this.
>
> Please go forth and test/review.
>
> Series also available at
>
> git@github.com:jlelli/linux.git upstream/dl-server-apply
>
> Best,
> Juri
>
> [1] https://lore.kernel.org/lkml/20241110025023.664487-1-longman@redhat.com/
> [2] https://lore.kernel.org/lkml/20241029225116.3998487-1-joel@joelfernandes.org/
> [3] v1 - https://lore.kernel.org/lkml/20241113125724.450249-1-juri.lelli@redhat.com/
>
> Juri Lelli (2):
>    sched/deadline: Restore dl_server bandwidth on non-destructive root
>      domain changes
>    sched/deadline: Correctly account for allocated bandwidth during
>      hotplug
>
>   kernel/sched/core.c     |  2 +-
>   kernel/sched/deadline.c | 65 +++++++++++++++++++++++++++++++++--------
>   kernel/sched/sched.h    |  2 +-
>   kernel/sched/topology.c |  8 +++--
>   4 files changed, 60 insertions(+), 17 deletions(-)
>
Thanks for this new patch series. I have confirmed that with some minor 
twisting of the cpuset code, all the test cases in the 
test_cpuset_prs.sh script passed.

Tested-by: Waiman Long <longman@redhat.com>


