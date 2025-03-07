Return-Path: <linux-kernel+bounces-551792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ED0A57101
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9B93B1EF6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F5924BBEF;
	Fri,  7 Mar 2025 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/7+0u34"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09398217718
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374017; cv=none; b=fWr8Uv7S+CoK+3I4gCvJhRn0l5D25kWrUyn+bCwdRznDTlXXepvboDNN7HPLh7fOhX2eGBiwzmziIi0BjZThG6aSl+Hbek2102+T6d/PIQIDAIC3Ce6p6nIX6lru+QAxxWoXj/00f5EWbWyEi5asGVKfW3vmDSFvxO9zniyNEnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374017; c=relaxed/simple;
	bh=gEdITdBQkxBcEo+xf0PTFVBaDxaG0wYNsG1JOV1teRc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z5A+7V+EuLjIFP/oBczT0sqYGeaB+lEgFxw3jWfIGGAdQKn7H+vnBty1PR2lJecwDjgOO4B8l3UiOu6RZw0TUg/zZoWIwwmGItP54HKuF/AAhf4AdReED/oIfUKkvt0smCfdNtP0IyoXVFvRynLUsGgFf0ADk7qDlLnmO7u4N8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c/7+0u34; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741374015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGL2mElf4pWcuuOVu/32c+R0ECrqVcIsm2yeFgp2v0k=;
	b=c/7+0u34WVIYHIR9e9BCCTkLIBbyV97scefF0pN8vEHrBBQkBlBfWqB/De/+0ErzC9UFGq
	r0Kd/t3rU16JElMPXHGIy5uOK39yatiurBmcU6y5bSoD6x5TSOE36sPl2WYdFMkZE5Xz+3
	mlova1UNlLPOAYIusNVIx0MCmT2V6Do=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-MCY5nabQMBCuTZJSdITCnQ-1; Fri, 07 Mar 2025 14:00:13 -0500
X-MC-Unique: MCY5nabQMBCuTZJSdITCnQ-1
X-Mimecast-MFC-AGG-ID: MCY5nabQMBCuTZJSdITCnQ_1741374013
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8ed78717eso36577906d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 11:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741374008; x=1741978808;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGL2mElf4pWcuuOVu/32c+R0ECrqVcIsm2yeFgp2v0k=;
        b=OfQMkrfa6q9cY2HJmVmxA4CZ+NcQKH9IRkmKEv/De1aIOmdI1FVLLMimcnhjQdBpzr
         BINr6vytZQve2GL/HA2Sq4IYeYi7oEE5ErnNcUIzNapL4e3+XSCuBj7Tk6brd5NytEka
         sORPHr+gQrYKQBPFqy+CrYC63FHDOZafyf4amQQgUmDTMZfRUQvJTxs4utLjMiEgSoBR
         R8XXD4+tcH3pMGJWlpc5tl4ghc1+ZKbAxUmBdVa+FiYOe1d22ULmpwD7eLbbzqwt2yn9
         PTy1TAmJ/eQCvzUHJp7rJFGf1/APCy8K+1RtkjyhcK2hGzDpoeMCMg5Ov3qTmIgohvxy
         1L7w==
X-Forwarded-Encrypted: i=1; AJvYcCXzl8baN7KDlMiIUGhQXuiv+HRGBpA8ippzLcrD96wEYfMPcJBrDFBw3iXdJKPrl0nlCeGx0uVHffQauWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIBAVa/JkeOj2K+gRSGIIIt7yXdrJvPaeES9CBtqVCLdJ+HeAJ
	Cu0IT0BRS1prFyCqabanlDjZBlOUWh4UWLFCOpVieHwNqph8nEhX+UIBs4kZUBluwW9Vwo9gmBr
	kE1ff8b/IxJLJfMCPEbW6THI4qZpgY8dF13spdqtZ3n4KfCU47O9m8YLmNIkwww==
X-Gm-Gg: ASbGnctIlHit/+SQSTj0tRbs46Sw2aCkN56lC7QM6ki/6s/ZzIYWTCCJSiQM+MIHNzx
	D7h+m4weC0NsXh5OKo+kZ8/zF4Zw5vKMiO1vzZp0m1jQ4Zj95e6vQV/H3eIvZhnB6VMfjqGgW60
	IGNrpOekoKeVhZGg2Nx0f7jVzwoqEZemS0+FXDIb1oZbR5YeedMLtocAHUDwZKYXW4Zov1A+63L
	SqvrEbECwbbZshD5iyRljBU4bE7/2q1d7LZy1vLgk5JxF+Lnx2rW5vQwPpE5sJmxHnGFekXJUgp
	TMyfjHhEwpIY16QTkOqJIOkkHvhv/Vr/hKxKUzTiAt03GE8YpqUsNkJpqRk=
X-Received: by 2002:ad4:5f85:0:b0:6e6:64a5:e18d with SMTP id 6a1803df08f44-6e9006060b9mr58690626d6.17.1741374008382;
        Fri, 07 Mar 2025 11:00:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5N9D50+NdtUHWHhWFcEiZ7MMlPprhjKEs/UhN9BLkC+eLvO3qMbCq10Xpj6qdcevGBpMctg==
X-Received: by 2002:ad4:5f85:0:b0:6e6:64a5:e18d with SMTP id 6a1803df08f44-6e9006060b9mr58690156d6.17.1741374008020;
        Fri, 07 Mar 2025 11:00:08 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b798sm22445896d6.80.2025.03.07.11.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 11:00:07 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <93c3f9ac-0225-429a-807c-d11c649c819e@redhat.com>
Date: Fri, 7 Mar 2025 14:00:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Fix SCHED_DEADLINE bandwidth accounting during
 suspend
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
 Jon Hunter <jonathanh@nvidia.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
Content-Language: en-US
In-Reply-To: <20250306141016.268313-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 9:10 AM, Juri Lelli wrote:
> Hello!
>
> Jon reported [1] a suspend regression on a Tegra board configured to
> boot with isolcpus and bisected it to commit 53916d5fd3c0
> ("sched/deadline: Check bandwidth overflow earlier for hotplug").
>
> Root cause analysis pointed out that we are currently failing to
> correctly clear and restore bandwidth accounting on root domains after
> changes that initiate from partition_sched_domains(), as it is the case
> for suspend operations on that board.
>
> This is v2 [2] of the proposed approach to fix the issue. With respect
> to v1, the following implements the approach by:
>
> - 01: filter out DEADLINE special tasks
> - 02: preparatory wrappers to be able to grab sched_domains_mutex on
>        UP (remove !SMP wrappers - Waiman)
> - 03: generalize unique visiting of root domains so that we can
>        re-use the mechanism elsewhere
> - 04: the bulk of the approach, clean and rebuild after changes
> - 05: clean up a now redundant call
> - 06: remove partition_and_rebuild_sched_domains() (Waiman)
> - 07: stop exposing partition_sched_domains_locked (Waiman)
>
> Please test and review. The set is also available at
>
> git@github.com:jlelli/linux.git upstream/deadline/domains-suspend
>
> Best,
> Juri
>
> 1 - https://lore.kernel.org/lkml/ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com/
> 2 - v1 https://lore.kernel.org/lkml/20250304084045.62554-1-juri.lelli@redhat.com
>
> Juri Lelli (8):
>    sched/deadline: Ignore special tasks when rebuilding domains
>    sched/topology: Wrappers for sched_domains_mutex
>    sched/deadline: Generalize unique visiting of root domains
>    sched/deadline: Rebuild root domain accounting after every update
>    sched/topology: Remove redundant dl_clear_root_domain call
>    cgroup/cpuset: Remove partition_and_rebuild_sched_domains
>    sched/topology: Stop exposing partition_sched_domains_locked
>    include/{topology,cpuset}: Move dl_rebuild_rd_accounting to cpuset.h
>
>   include/linux/cpuset.h         |  5 +++++
>   include/linux/sched.h          |  2 ++
>   include/linux/sched/deadline.h |  7 +++++++
>   include/linux/sched/topology.h | 10 ---------
>   kernel/cgroup/cpuset.c         | 27 +++++++++----------------
>   kernel/sched/core.c            |  4 ++--
>   kernel/sched/deadline.c        | 37 ++++++++++++++++++++--------------
>   kernel/sched/debug.c           |  8 ++++----
>   kernel/sched/rt.c              |  2 ++
>   kernel/sched/sched.h           |  2 +-
>   kernel/sched/topology.c        | 32 +++++++++++++----------------
>   11 files changed, 69 insertions(+), 67 deletions(-)
>
>
> base-commit: 48a5eed9ad584315c30ed35204510536235ce402

I have run my cpuset test and it completed successfully without any issue.

Tested-by: Waiman Long <longman@redhat.com>


