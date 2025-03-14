Return-Path: <linux-kernel+bounces-561081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A271EA60D55
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4CC19C609E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628E61EE7AD;
	Fri, 14 Mar 2025 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Adu0nhLN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E147C197A68
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944660; cv=none; b=RBp25ORCEQMtgrqHRLzY3iq9mfWt62Ewoz3FfNUzW7puvd/oWFNqwHY7e4KjnuoSS3zFd/A722g3BiSM1TJJaZ1amTM3BXYJYcwJuByY8hDObMNwPQFp+bFXb92PwnDPoD4bMnN01HrTA5B6vTF2LR3Q/bXwmv6hr4+zduSVtKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944660; c=relaxed/simple;
	bh=e93eE40n9bUFNxE5voxoWM330uqXG0CNIr05Q7FIhps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guMJ10XzuBsIZtXPFDNA5m2EJzQ4583kxmjmlDSXC2RF5HwC9/aRWuyxm1aBwxv8dFAnujhEzAPb9Hd/o+ZtebWTmz02OVIYmRcwIIa/cbrZWvBdup2VFpYJZXuZi0Tl/X2LC3aIKsaULwjJrxFtkD4OStj3wrIiuPVX/AM1yn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Adu0nhLN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741944657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+uw1Q3X470tWmgPcYoi9tjQ2jSl9Kq26p5f4ZluhfM=;
	b=Adu0nhLNwIGj7yKZi0gstjfB9P2GaeMCv9nQ8fFWVnrYILqzUV+FrVKwx9i9l0TGtR1PQn
	7arbXaVQxwwWlmfaA3+YK33SLd/LuDgBSW0CyoE07ygqbyQELOGUhHBpdcJPSfMmJ5FsFM
	K2qXTWAcFoZcJEWpXes6Sb0RGgTz4uc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-KEr8ooGYO4eeXOsWnOPaxA-1; Fri, 14 Mar 2025 05:30:56 -0400
X-MC-Unique: KEr8ooGYO4eeXOsWnOPaxA-1
X-Mimecast-MFC-AGG-ID: KEr8ooGYO4eeXOsWnOPaxA_1741944655
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d01024089so14162445e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741944655; x=1742549455;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+uw1Q3X470tWmgPcYoi9tjQ2jSl9Kq26p5f4ZluhfM=;
        b=CF/73PSpXdDA0Uv2WEF1hu0nXiAG46d68SWpDzXOGVVwfiMqkugj6oiZuVhzRGxOJl
         nJNXKPNllIyrhVGoEaopmszj+nrhpUj6M2ruYOA8iE6N4BrMWyR+54SJKjoaQTLTHqhb
         oqh+6Lc3h+N5olVkV8ViFW1WvHY6uCz6a757jbxFVQPRdJ9I2tVKfJULHVG96/cWbj46
         UmSl4jRULQZvYro0sUH25b5YivQLvNWzpoSsLXmc/HO13Ee814YVl7CI+iy08iku6M82
         WV/KwhkFBgVqGFa3eOzLXnqeLH7ctzMT8j6s30xomM+W6mkmzFTuYr/2LCdl5JO1b6Hz
         wGPg==
X-Forwarded-Encrypted: i=1; AJvYcCW/A7B6pOwG3UYCxVxvqd+itsBMemfLj/og2/VmifVgTWM/XiGBTpnJ1/P8hazevqQKnzzZQ3eniUZOKi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuUJcy95TuN5r4G5BIZpyEa985LYej3GXNy8UBYMI2XNG/KiXb
	ZIfFIjqaKTr/f6/1oEbMA10u8LyX87Mo1p72s4HXO0Euit3THwLJa+w1jDnBCORDQCncB1x48PO
	Bq0rGc7wX6bqyk6qO8AR3AtkKBT7C2WRwG4tf5YcmSDf/xiauJNK9eaF2hS2C5w==
X-Gm-Gg: ASbGnctLQZwH4TPM6CRtSPvx7u8eu6eQ4i02CJLXOihYdQYGpxLe+wBRzz1qwxrppRr
	XtQBTvaLA+hwMb3qUEjLPfTwy4JlsRJ3xLGG5c7r2FkzDY6Z29hEN0M4xST+zI5npDqZJDLtyfO
	Q1Vzmg3w/UuAGR9Ye40GN2lfyR+6qOnssYFUF12peQaVjBrzbOGRzthJpZTxl9JsniyOd5eiate
	j/2yhGEQly0eLJE9DU0wmeP8FHZsM9652VWVbazuMEQiKN2Yc6pYJOfiomZ1EfDpkTyElASt2F8
	nfzCXG4R81R1JkSjkVdD/JtEReicm94sX5GoN+ohXV8=
X-Received: by 2002:a5d:64c9:0:b0:391:2c67:7999 with SMTP id ffacd0b85a97d-39720779405mr2492408f8f.48.1741944654797;
        Fri, 14 Mar 2025 02:30:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVyKsCgKPTZlOlR372qt56ZtOxfikpuBkcvr2h0zJSg+sZGyxVB7bK/X4XNDrN1LVrxoUbwA==
X-Received: by 2002:a5d:64c9:0:b0:391:2c67:7999 with SMTP id ffacd0b85a97d-39720779405mr2492368f8f.48.1741944654341;
        Fri, 14 Mar 2025 02:30:54 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b69eesm5049255f8f.34.2025.03.14.02.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:30:53 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:30:51 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Harshit Agarwal <harshit@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] sched/deadline: Fix race in push_dl_task
Message-ID: <Z9P3S_GjAQPSedbI@jlelli-thinkpadt14gen4.remote.csb>
References: <20250307204255.60640-1-harshit@nutanix.com>
 <Z9FXC7NMaGxJ6ai6@jlelli-thinkpadt14gen4.remote.csb>
 <8B627F86-EF5F-4EA2-96F4-E47B0B3CAD38@nutanix.com>
 <Z9Lb496DoMcu9hk_@jlelli-thinkpadt14gen4.remote.csb>
 <59E10428-6359-4E0A-BBB2-C98DF01F79BA@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59E10428-6359-4E0A-BBB2-C98DF01F79BA@nutanix.com>

On 13/03/25 19:38, Harshit Agarwal wrote:
> 
> 
> >>> 
> >>> Maybe to discern between find_lock_later_rq() callers we can use
> >>> dl_throttled flag in dl_se and still implement the fix in find_lock_
> >>> later_rq()? I.e., fix similar to the rt.c patch in case the task is not
> >>> throttled (so caller is push_dl_task()) and not rely on pick_next_
> >>> pushable_dl_task() if the task is throttled.
> >>> 
> >> 
> >> Sure I can do this as well but like I mentioned above I don’t think
> >> it will be any different than this patch unless we want to
> >> handle the race for offline migration case or if you prefer
> >> this in find_lock_later_rq just to keep it more inline with the rt
> >> patch. I just found the current approach to be less risky :)
> > 
> > What you mean with "handle the race for offline migration case"?
> 
> By offline migration I meant dl_task_offline_migration path which
> calls find_lock_later_rq. So unless we think the same race that this
> fix is trying to address for push_dl_task can happen for
> dl_task_offline_migration, there is one less reason to encapsulate
> this in find_lock_later_rq.
> 
> > 
> > And I am honestly conflicted. I think I like the encapsulation better if
> > we can find a solution inside find_lock_later_rq(), as it also aligns
> > better with rt.c, but you fear it's more fragile?
> > 
> 
> Yes I agree that encapsulation in find_lock_later_rq will be ideal
> but by keeping it limited to push_dl_task I wanted to keep the change
> more targeted to avoid any possible side effect on
> dl_task_offline_migration call path.
> 
> Let’s say if we go ahead with making the change in find_lock_later_rq
> itself then we will have to fallback to current checks for throttled case
> and for remaining we will use the task != pick_next_pushable_dl_task(rq)
> check. Below is the diff of how it will be:
> 
>                 /* Retry if something changed. */
>                 if (double_lock_balance(rq, later_rq)) {
> -                       if (unlikely(task_rq(task) != rq ||
> +                       if (unlikely(is_migration_disabled(task) ||
>                                      !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
> -                                    task_on_cpu(rq, task) ||
> -                                    !dl_task(task) ||
> -                                    is_migration_disabled(task) ||
> -                                    !task_on_rq_queued(task))) {
> +                                    (task->dl.dl_throttled &&
> +                                      (task_rq(task) != rq ||
> +                                       task_on_cpu(rq, task) ||
> +                                       !dl_task(task)
> +                                       !task_on_rq_queued(task))) ||
> +                                    (!task->dl.dl_throttled &&
> +                                      task != pick_next_pushable_dl_task(rq)))) {
>                                 double_unlock_balance(rq, later_rq);
>                                 later_rq = NULL;
>                                 break;
>  
> Let me know your thoughts and I can send v2 patch accordingly.

So, it looks definitely more complicated (and fragile?), but I think I
still like it better. Maybe you could add a comment in the code
documenting the two different paths and the associated checks, so that we
don't forget. :)

What do others think?

Thanks!
Juri


