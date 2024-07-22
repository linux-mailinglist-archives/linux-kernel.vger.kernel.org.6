Return-Path: <linux-kernel+bounces-259457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E820693967F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 00:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F7D1F23084
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23205446A2;
	Mon, 22 Jul 2024 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lIfjzvgz"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E2D1849
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721687080; cv=none; b=A+uZ5jA1ssMz55UnHcvKXkPirzLX4iRCev+S6yxeht66b/+8zFMXhcJgppjEYQtnW36Sw7agYG3Y7XypCnKnsOXReoxEGqb/MMoLaI0t71we4l08x7JOUlvlztfalmmX+IhrIgDg4m2QeHPcT054Thy2QD95TzsYOfmo7sv+ouw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721687080; c=relaxed/simple;
	bh=vO6rmvbxhIWw/b9dIYBkFphBLukSyITQOI24YmXhbwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WW3+RWjfhPjsa8usxjgyhVRLN8F91hM3whldO3WmXMFxqlOYdpEAplxnyJ287Mzx5kX1W8YIAvqUAdGdAqNcXzdsP6xk4eAMAHfSue+/hPmKtmIZGpWmb/gonpM2B2DfsAVvYoBb9VwPMJQzAqhwYGQLfLDioDeRFkBZOk0aYH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lIfjzvgz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd657c9199so24435ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721687078; x=1722291878; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iDvnXEVhBUCHClpEhf7m97WF+5v7B3FfanXNEwumccw=;
        b=lIfjzvgz00qJuDBbgfLeQZymA+eeu8ldiUzHU74/hULXsjEFHWF16dPAHhlsIy/Zu9
         ydqLGEoDv3ftt/kBjmuq6GOA4OGtlQaOHwskqWogLiAo8Y+8744T2L1f0B0DhswmgN+R
         Ah5Z8OqGJ0jyrjJdEDRaFhF9EvDBYxwxPXrb5utgtlv3HKLCzg5CWR+fWESdR4vuScl7
         PY+dcpC+LoLbOhdvZMvdR5BgfKB2+t2N98SZO3aHJosrHNCp32+kjXT7mGq0dqaTiTxh
         lLhpzQvut1z+wQDis/ZputoYMcsNUD9qc0swJ+hSo9kJ7Q5l6SnNgMmSWXNoVyg4zj89
         +rDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721687078; x=1722291878;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDvnXEVhBUCHClpEhf7m97WF+5v7B3FfanXNEwumccw=;
        b=RF8QSYcV0QOEp8ESQs1lR8/2AsZyhwysQdNFGAd7aRYfxPlsSjdjrHW4DxTuLrQXic
         mCJGMJFwaoD0myM5u9JsgMb3W0ClSl/JxGYziycabXgY0O2RBcc/9qQXRz48+jCerVRE
         cUjkUNHjutxrFZ6g+EWBakI6xssP5GXKig/jVzChg8GG3ZYpPFgL89tiP/uylTZPCdFZ
         U4MZz1GIzWe94VulcfeF36E2rUtx8Je7FrheH+UNjp2/Rji0rlySEZwtxC/Fklw3mv/9
         hx4qpYYQ41RXRi/A7vaRLnJm0+edeOchGVfde3aPNSW300xN4PSsHwZkXYaJe583VtWd
         m5PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYxk6/7zbqQHN1kUnI8Bu7IoTotfHb8eGbxi3QsT729Zz2LQGtI2MhKu4hTVqFQWceqOAnS62p1oLOkzU6/lh5B5sUW5Uo9p085MmI
X-Gm-Message-State: AOJu0Yx4u6Q3Ft7cD387TdU3luKidkRvDCComvJ1tonuNIkzN1HYn+tB
	trAWlEAYKa8DLUYP2CmHI0fWrpK035oPge9j5WzNa875XvHUlrE6SiUpLlRm0Q==
X-Google-Smtp-Source: AGHT+IEPbeDaWFcAmhpLTQu4BhqnlKvzWFuikEQdyG2wqOIUMpauodgg6xwQ9OS1Yu2ZIMrQfnmatA==
X-Received: by 2002:a17:902:c947:b0:1f2:fefc:e8e7 with SMTP id d9443c01a7336-1fd7961f3d8mr6227895ad.2.1721687078177;
        Mon, 22 Jul 2024 15:24:38 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd96e65774sm29472295ad.24.2024.07.22.15.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 15:24:37 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: mingo@redhat.com,  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  mgorman@suse.de,  vschneid@redhat.com,
  chengming.zhou@linux.dev,  linux-kernel@vger.kernel.org,
  joshdon@google.com
Subject: Re: [PATCH 2/2] sched/core: Avoid unnecessary update in
 tg_set_cfs_bandwidth
In-Reply-To: <20240721125208.5348-3-zhouchuyi@bytedance.com> (Chuyi Zhou's
	message of "Sun, 21 Jul 2024 20:52:08 +0800")
References: <20240721125208.5348-1-zhouchuyi@bytedance.com>
	<20240721125208.5348-3-zhouchuyi@bytedance.com>
Date: Mon, 22 Jul 2024 15:24:36 -0700
Message-ID: <xm26plr5ysij.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chuyi Zhou <zhouchuyi@bytedance.com> writes:

> In the kubernetes production environment, we have observed a high
> frequency of writes to cpu.max, approximately every 2~4 seconds for each
> cgroup, with the same value being written each time. This can result in
> unnecessary overhead, especially on machines with a large number of CPUs
> and cgroups.
>
> This is because kubelet and runc attempt to persist resource
> configurations through frequent updates with same value in this manner.
> While optimizations can be made to kubelet and runc to avoid such
> overhead(e.g. check the current value of cpu request/limit before writing
> to cpu.max), it is still worth to bail out from tg_set_cfs_bandwidth() if
> we attempt to update with the same value.

Yeah, this is silly of userspace, but we also do the same sort of check
for shares, so sure.

We do need it to be inside of a lock though, multiple threads could
in theory write to the file at once. Just move it down inside of
cfs_constraints_mutex and that's fine.

>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  kernel/sched/core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6d35c48239be..4db3ef2a703b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9081,6 +9081,8 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
>  				     burst + quota > max_cfs_runtime))
>  		return -EINVAL;
>  
> +	if (cfs_b->period == ns_to_ktime(period) && cfs_b->quota == quota && cfs_b->burst == burst)
> +		return 0;
>  	/*
>  	 * Prevent race between setting of cfs_rq->runtime_enabled and
>  	 * unthrottle_offline_cfs_rqs().

