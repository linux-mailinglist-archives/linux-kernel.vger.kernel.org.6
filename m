Return-Path: <linux-kernel+bounces-555238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6CCA5A872
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3119165336
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0FC1E3DCD;
	Mon, 10 Mar 2025 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZa8XNvd"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0CF1C4A13
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741646317; cv=none; b=esoYv7k+gZMj7Y3TRSrdZmV7URHVbFnOMqnhVJpRWOl7FPQn51uWlVx+zgl1TCrbmGGPEtqQH7YjCAVx3f8N4/GkhiiwZ1k3XyUqNN2mdXby2AcGlfsFSlOSQpO+PtjDMtolwBmKFij6n6FNXtzcQE7D5EiA0NGHsP9cxNGojwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741646317; c=relaxed/simple;
	bh=WKsKFtjWIbDN4OoGrIKUZRgQgUtoB8CHwUZ6FzU1JHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYMIneVRYa0D7GS3GobxA07c8ZG3U8xYlTp1l5xqFjXYkyTbb3c1tNUW9wo7NTVn/dwBQvC+KBq6DXF9KPRfvh8gmZsK/Nc+w6jSuzvnoLxflbTcLcDu0s1MMCV5YarXWEIeusauJ+twhdfoDDTtXi5xr811X90VuQkTxFuv1d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZa8XNvd; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47666573242so77041cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741646315; x=1742251115; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ucqCc+pNsjeVT1mYPMT1VVaqVbNJnccS6ZcTeIOi+hI=;
        b=UZa8XNvdKDPvf/vGWPzqmOhTYskqI5XE/MD5dZ6XdlrJxKmAmGFKdJml+q8kIqur5M
         7wFHFxq1mmXJ5Bih7eDwwzEsfgIY4mGo7OdCc/vHvK24pzRHCYhLLL6+Hg5d8uB6vpVr
         060dDH1o0QNEBjtxcyWeFn6O9nchZ56JaqOgkc1nAYyF2hqW3qJtKXjulyK3wI3Nm5JN
         i6fh5zliycvpQMHPU0NTkwNrMhJQYTw0ibwAsEBv5SzFNGI7kXhAsITzgHyyhbO42Oga
         rLRJZcT0EygX6RBP3ZsXx+njc0Twj4Q10SPYmG0LiWCT6bzo7G2SsJX2hQKRtp+P/RIw
         ahMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741646315; x=1742251115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucqCc+pNsjeVT1mYPMT1VVaqVbNJnccS6ZcTeIOi+hI=;
        b=TN+9SHdQp9jsa71QG19PO60+7mR6NtsKVWTJPFagFVMDne2ajO+ADeyzSPQ8CGtd25
         G7XFWxsfP+sHOYmsC/sDW0mUhA/Co1reFrXcQ04Sii+r7M410RUmU/MlsFihqhCWwecx
         hvvkK6z1uA2CSURcH1ubX27L1/l0n6B01JLPtoPK2C2IIosRJo6JiX5GPYOqgZ+Kjm1G
         xDcoS2YM3RYcYNdvMkyGTxBgjykIVbR7FFORAkBpZXJoP1yf/7rR1Bmw/COdg96EHYPV
         IcrL2qkkyQee6kv4hrwMOWTAytoLp0xCyNFMzPSGb6bNpgEnyfD76USUUHH7IpQq+/mJ
         ZUmg==
X-Forwarded-Encrypted: i=1; AJvYcCXSqAH3X6IQlms73Kddn7eyZQ2BUWoJLaAl7BfhbxQlTTA2B9Mj/HTj3Q7a/N1ObgnXJbAsestI2ZJ/hTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6N2reT44Y4KsYP793z2Q1UwPFnfAJzHy+Z6OCwQ3+5zYD1mqr
	oL2PoM4ZS4UlfEy+NVInty41yR3MWJTpGl19gB5UZPLzA/znzD8jeQRM9IRt3Y1XiTG/6OxoIJn
	FNAMqzz5DZ47X4kjXjG+ABgw0IBou6DkPPU/Y
X-Gm-Gg: ASbGnctsU8GJHGSUbIuyCtlUQckeatMyYzrqG/dcgYPNIt6MDoSJ98Ftl2C50Q4p/d2
	+a7DRbdKTMJgCMMXxHJQhhtI8gVRy4Tr54N7l26SXytl6QN9cieVIVeb92Cb8Efz1brAzUZ+L9I
	ek4C5c8NVgEhML/n7ZAeHOmukTsOQ=
X-Google-Smtp-Source: AGHT+IGZo2ZQ73bYT9OrRMYOlmqWi0g+DdmLBWZ2XzXxRePUIcg5Va+6m/YTy/NtEi73Be2Ly81iL/phXDFgBkkmRfU=
X-Received: by 2002:ac8:7f4b:0:b0:476:605f:6660 with SMTP id
 d75a77b69052e-47665385fb1mr8988811cf.14.1741646314741; Mon, 10 Mar 2025
 15:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310074044.3656-1-wuyun.abel@bytedance.com> <20250310074044.3656-3-wuyun.abel@bytedance.com>
In-Reply-To: <20250310074044.3656-3-wuyun.abel@bytedance.com>
From: Josh Don <joshdon@google.com>
Date: Mon, 10 Mar 2025 15:38:23 -0700
X-Gm-Features: AQ5f1JoiEfOYPST_3M5H7X_XnLZJ8n6Dl8CTg8cD9jXGpdlH6cJuI9suTZ3BEnU
Message-ID: <CABk29Ns9wq+mB5mAfu72gi3RZkNdwzXmkZSq3FQpKkTEH23dgw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] sched/fair: Do not specialcase SCHED_IDLE cpus in
 select slowpath
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Tianchen Ding <dtcccc@linux.alibaba.com>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Thanks Abel,

> @@ -7481,12 +7481,13 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
>                                 latest_idle_timestamp = rq->idle_stamp;
>                                 shallowest_idle_cpu = i;
>                         }
> -               } else if (shallowest_idle_cpu == -1 && si_cpu == -1) {
> -                       if (sched_idle_cpu(i)) {
> -                               si_cpu = i;
> -                               continue;
> -                       }
> -
> +               } else if (shallowest_idle_cpu == -1) {
> +                       /*
> +                        * The SCHED_IDLE cpus do not necessarily means anything
> +                        * to @p due to the cgroup hierarchical behavior. But it
> +                        * is almost certain that the wakee will get better served
> +                        * if the cpu is less loaded.
> +                        */
>                         load = cpu_load(cpu_rq(i));
>                         if (load < min_load) {
>                                 min_load = load;

This seems reasonable due to the case you describe. However, I'm
wondering if you considered any heuristics here to help identify when
a target cpu should really be considered sched_idle from the
perspective of the incoming task. For example, in your cgroup
hierarchy, if you have a cpu currently only running tasks in your
besteffort container (and all cpus in the system are busy running
something), then that cpu should be considered as a good target for a
waking task in the "guaranteed" container, and not a good target for a
waking task in the "containerd" container.  A simple way to do this
would be to do a find_matching_se on the incoming task and the current
on_cpu task. That does have a drawback of cgroup pointer chasing in a
hot wakeup path, so I don't love it.

In any case, I'm fine with the change as-is, mostly curious if you
gave any additional thought to the case mentioned above.

Best,
Josh

