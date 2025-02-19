Return-Path: <linux-kernel+bounces-521288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C982A3BB17
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F94188CBE4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B16D1DB546;
	Wed, 19 Feb 2025 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J72QaYJh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADED1D9A50
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739959375; cv=none; b=Hl3C9t+u+Qs8yv/Qq6X9zzUC9lN3Do3e14fXl13rfDN+kv30dJc3JZQSD9xeFsef7Zh2gVteLlWRBj4fOm9AnfkRJDR1rol4DWIyqPtgiB70wgGfY1tFK9E03a6b8jWKd7h2ALgXvENK58ptj53QWdW8/vo+LlroLVuYsuTHU30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739959375; c=relaxed/simple;
	bh=pG3ehQ8ELvoaHuUfcRGNZ+bIa/1pT9JXhzOPZ5ksmPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JR9Rq6E/CBKnqpsYMCEbYKLiC65Sfic8zagl4iO0GEnaEq/QgCB/Tyvnh9d5cKpj31DRCmzj0Ms7Gj9tBecJ7+0LpetDzRwchX5Xqzl+mlbBYwQqZGZ+bprX1Eto/B3MUridd22FMYFJRJCQp9kfBpPy7NPqifRkUF7DBnAeIpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J72QaYJh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739959373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6zefS7lKlcewOYQ7mQ6LJ7/0/Vzj6dzTA0TGrsliN8=;
	b=J72QaYJhCDGyueB0hcefc5EZe4EOK36d6e734aSqrsSHrkhOdFwAjyRBwJ/2f35Ns9U3Ez
	oeKCEEAYBp8rkEcSK1wlbv1bTV0zmhteFtLcVodWgs4Av9S3oxZwZ+7Md1fqF9YdEruQZS
	KqYJAEHl8D6yU7iC+oIhzulRV3fZ/C8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-VbgXtBQKOiahazzqKkP6xg-1; Wed, 19 Feb 2025 05:02:51 -0500
X-MC-Unique: VbgXtBQKOiahazzqKkP6xg-1
X-Mimecast-MFC-AGG-ID: VbgXtBQKOiahazzqKkP6xg_1739959370
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-439385b08d1so54330625e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:02:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739959370; x=1740564170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6zefS7lKlcewOYQ7mQ6LJ7/0/Vzj6dzTA0TGrsliN8=;
        b=xQWd0pQrXlSB+Clg5Pj6CjaOAaMpbm6prpjqwkcZ7YiNgTb0Jq6pqJPs5C2ZEfNk3d
         sObqEdc0Ux4UykMvISbLAGG8aT9HH9IbcLeTeocUwGyB5n0/jaFMsjvSFzwNSqJP376O
         fsBdyiTOzzW2BrfNPt4p66HmVKlbTm3Jg2pHOW7WuhnI2eUNCe4n46/iweUO8o5O8dgb
         h6OZsaXJxi6Ydv6ozMWkSnscsbeoPhurWL/2tx9eA/twGoU35KO6KxMTOnyK6+mGYrUN
         6Kvs6PA+17kEeLZ8aIVfFfGzIIejm8BAHXprBaZlxXndGPAQQZsC5EHQKU73bhWWeiSl
         q71g==
X-Forwarded-Encrypted: i=1; AJvYcCWCf1NGHhHNcc+7nWFTBl7tHAQq/Exorn9kR6e2u7m1Qir9698TF734chqPzSpJ1GaQQlq3vmDrq+hjz/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+LW0GknACe16bvGMs8m4WopjSJwGN1/l6Ee/RaZJ0FMFk5YBb
	rUVr+PDtHzzRCBMoavuNBHT6m48bnNU/7//abPFMfkhqT7aKhh7Yol8RC6AXaoiJpNoMriHVVM0
	VYZw/zReatLYZVfsDIAyK8YfQRFY90nrNUFg4EUf7cPMSYqRMGLdn/z4Bb6W4gQ==
X-Gm-Gg: ASbGncurrZgAwkYiOIDT1KSUhMuEtFIXCewUTz4wCTtVQA9siMMQh++uefvRYId6z1/
	0LM/4TtWof3EAj+vHNjI/h+Nid1PeNLOPF0HQF/91jn2jDl//zbFiJfZ1N1yTLOzIFtCcI1SGEZ
	HH4VqjG5kBekXOU+uDK3yd7u3p0/TRsNHkgAYaeb4N/sy+6I9aDE3gbr7GOxEjthh9LP2WUTTlS
	eguxJ7lKxo1MPOoy3p17R2CwVkf4PTq+A2vbjzrWhJ8gngbDUp8FWkDD2PtxGJj0Y4fEPGzqClw
	XSoe8HwZk1H0vUwp1/bEEcS8IaSJ6VTYTA==
X-Received: by 2002:a5d:6a0e:0:b0:38d:e190:b713 with SMTP id ffacd0b85a97d-38f587ca520mr2058206f8f.37.1739959370114;
        Wed, 19 Feb 2025 02:02:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3CX/A5GZaT4XTXRfc/4HEl7SxwEen11NbYXLZ9oXbaY+XlUUSf56BBdLr7G7NBNgkHckUng==
X-Received: by 2002:a5d:6a0e:0:b0:38d:e190:b713 with SMTP id ffacd0b85a97d-38f587ca520mr2058177f8f.37.1739959369680;
        Wed, 19 Feb 2025 02:02:49 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.34.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439872b59e9sm76030525e9.31.2025.02.19.02.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:02:48 -0800 (PST)
Date: Wed, 19 Feb 2025 11:02:46 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Thierry Reding <treding@nvidia.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
Message-ID: <Z7WsRvsVCWu_By1c@jlelli-thinkpadt14gen4.remote.csb>
References: <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <78f627fe-dd1e-4816-bbf3-58137fdceda6@nvidia.com>
 <Z62ONLX4OLisCLKw@jlelli-thinkpadt14gen4.remote.csb>
 <30a8cda5-0fd0-4e47-bafe-5deefc561f0c@nvidia.com>
 <151884eb-ad6d-458e-a325-92cbe5b8b33f@nvidia.com>
 <Z7Ne49MSXS2I06jW@jlelli-thinkpadt14gen4.remote.csb>
 <Z7RZ4141H-FnoQPW@jlelli-thinkpadt14gen4.remote.csb>
 <d7cc3a3c-155e-4872-a426-cbd239d79cac@arm.com>
 <Z7SWvr86RXlBbJlw@jlelli-thinkpadt14gen4.remote.csb>
 <a0f03e3e-bced-4be7-8589-1e65042b39aa@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f03e3e-bced-4be7-8589-1e65042b39aa@arm.com>

On 19/02/25 10:29, Dietmar Eggemann wrote:

...

> I did now. 

Thanks!

> Patch-wise I have:
> 
> (1) Putting 'fair_server's __dl_server_[de|at]tach_root() under if  
>     '(cpumask_test_cpu(rq->cpu, [old_rd->online|cpu_active_mask))' in 
>     rq_attach_root()
> 
>     https://lkml.kernel.org/r/Z7RhNmLpOb7SLImW@jlelli-thinkpadt14gen4.remote.csb
> 
> (2) Create __dl_server_detach_root() and call it in rq_attach_root()
> 
>     https://lkml.kernel.org/r/Z4fd_6M2vhSMSR0i@jlelli-thinkpadt14gen4.remote.csb
> 
> plus debug patch:
> 
>     https://lkml.kernel.org/r/Z6M5fQB9P1_bDF7A@jlelli-thinkpadt14gen4.remote.csb
> 
> plus additional debug.

So you don't have the one with which we ignore special tasks while
rebuilding domains?

https://lore.kernel.org/all/Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb/

Could you please double check again against

git@github.com:jlelli/linux.git experimental/dl-debug

> The suspend issue still persists.
> 
> My hunch is that it's rather an issue with having 0 CPUs left in DEF
> while deactivating the last isol CPU (CPU3) so we set overflow = 1 w/o
> calling __dl_overflow(). We want to account fair_server_bw=52428
> against 0 CPUs. 
> 
> l B B l l l
> 
>       ^^^
>       isolcpus=[3,4]
> 
> 
> cpumask_and(mask, rd->span, cpu_active_mask)
> 
> mask = [3-5] & [0-3] = [3] -> dl_bw_cpus(3) = 1
> 
> ---
> 
> dl_bw_deactivate() called cpu=5
> 
> dl_bw_deactivate() called cpu=4
> 
> dl_bw_deactivate() called cpu=3
> 
> dl_bw_cpus() cpu=6 rd->span=3-5 cpu_active_mask=0-3 cpus=1 type=DEF
>                    ^^^^^^^^^^^^ ^^^^^^^^^^^^^^^^^^^
>   cpumask_subset(rd->span, cpu_active_mask) is false
> 
>   for_each_cpu_and(i, rd->span, cpu_active_mask)
>     cpus++                                       <-- cpus is 1 !!!
> 
> dl_bw_manage: cpu=3 cap=0 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=1 type=DEF span=3-5
                                                          ^^^^^^
This still looks wrong: with a single cpu remaining we should only have
the corresponding dl server bandwidth present (unless there is some
other DL task running.

If you already had the patch ignoring sugovs bandwidth in your set, could
you please share the full dmesg?

Thanks!


