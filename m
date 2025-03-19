Return-Path: <linux-kernel+bounces-568514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C01FA696A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4DD3B923E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED32F202979;
	Wed, 19 Mar 2025 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="o+lG5xED"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186811EE029
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405741; cv=none; b=M9wGzMc8QVnknpq0dc1bDlmaG9xF1VqfYk0/L1L4L7J1cjHvFc61zuzQVrNJVSnIWimc2aAQgZybfCn3VgAwliteXv8tvZNxVR1J/F+JzGh8u1+TRhPVuxncsFdVBpa7Gcl/0HFajqijKc8gtZlgO8H/aIF4LaCZ/fY2ziUkxOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405741; c=relaxed/simple;
	bh=MUhF9in8CsGyHL2stqfTwwH0anNmdag7zG4QuEZo0h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQMwyYpZNk2SfNjdpN7J525RCVrU/sE1YyuZl4xacvHz5jm3K7X3927KLHypPfpCpZ3/VK33EKlCeDyUKcDlFK9ur9RE0uARcOdrppE7QX+iiNl2bQlJv1ZARSO/o4n7WDAL7PY5HKOUX8TlHa3HT5ZlCD/fxuJwcTGDV8oe9yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=o+lG5xED; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c547932d2eso441731785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742405738; x=1743010538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gGhGDuuhhwM0Ly0sNcJ9dpabn4WGi06NRVVNOwZFOBw=;
        b=o+lG5xEDMU8TmMvjKkLPWeTC/muq5YP05VFyM+6iFrbPqZe/VX0OSbTuIN3xspc0RP
         kPd2QfTWHgnXup+jdqYB8NG2MLVmpKRO8fz5Cyuy2dXCQJMG3wZmtZGvDOxZEhayEYyS
         s5VZpcSlTWDrkSBe01jJcdED0bkSc7nTfHbad2fJKeCHi1G7JJ96GsDThoSX7Wok7ily
         E8ZziICjwUhBigI9HUP87Zo12qy/wgnqFNo7UCYVQSgaieCjBPar1PtbVHDSMbSbmnrN
         QZtggwXddZxhL28AXX/iqA/LTC2Cw43d8h9OQcx40c8Z0q/126d6yFdB+dKBb8bXa4m3
         +gRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742405738; x=1743010538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGhGDuuhhwM0Ly0sNcJ9dpabn4WGi06NRVVNOwZFOBw=;
        b=kmGthGfuuIyaWX/wlGQ6DbSDObNkx01gTfJwTjOXhDoZEu+2gTU7J3/1SUmEaT6slJ
         x6m2giKPxBwSefw+2u7LFxrz0d+Bvo964KMbinKH4DxyOsufYln7GqtGsCPqDSP/dXtu
         q3Wc0n0KoNbNhxLmNKnLVoJ16UvUHJsZtVvInmllrSAH0c3uYvTAv06PA5u5HiJQ86fT
         H3xX5ARe+yaCwOSpL1eE6X9FoYgwGyHqLrY84RtXpud+Lq2Kkp80g4ATOyfuie8wa8eh
         TtOGq7dWVfEe6veUjsV4qELu47F5+YVWjsUIt2tw7hxD9tvUUY/1ALBoyu+xgATXG8l5
         EpVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2ESRgICFAt1rEsu8diH7fYHRC7bFgPu6k5yPGCQ+VS9NvsZOFcu7IOV1Q73dw8F7CrGYcqj6vuhIfQzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeSQa4kXmvL73kpm9gdWijDLbJzFbQslxpyI0O/3NB4JikbRyb
	I85JwGa5iqPMaDZU63Z4l65VP0aoBvaM/igp45Uw1Ewg7qBeeUkzK/ls7INRHdI=
X-Gm-Gg: ASbGnctVkyoNxYKJznNRnbijxSrR5jr5u7eiNze3geIc0iRpglYFHRLSt7glW2Ud7wp
	H0KdnVN9r/6gn2zGtS1jiIyk/CL7ILub+dNmF9DSxgfw/FVPs098Pj0XWU47yRLO89NqHD6Vcd/
	BWPJ+M6Sv2UWbilhTo4Jl7jzbuJAS5/Gfg4yCqL3K7mHixIqTyFC5FRerEOTz2k+UGH71pfpHpC
	z+UzPCdEc03iQcE82oT6lLBGwibf3xaQGt4xRRRcT0VoOIXthdntHZsOVbX3z0xqWWWaMdQrpuU
	gAI1nBhogdbSh/NKzr5X8ueG2Y13VF5IOuXWYlNsdKQ=
X-Google-Smtp-Source: AGHT+IFR0/DfY8PYnes84poP8QP06hXgfeFrcg01HIiFZ9sGfXEz2eMa/vjBdtqJwbnxBH9L/Po3Bw==
X-Received: by 2002:a05:620a:25d1:b0:7c5:3b8d:9f37 with SMTP id af79cd13be357-7c5b0c9401bmr1747185a.30.1742405737601;
        Wed, 19 Mar 2025 10:35:37 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c5ad3b2908sm67625185a.88.2025.03.19.10.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:35:36 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:35:36 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Greg Thelen <gthelen@google.com>
Cc: Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumzaet@google.com>,
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <20250319173536.GB1876369@cmpxchg.org>
References: <20250319071330.898763-1-gthelen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319071330.898763-1-gthelen@google.com>

On Wed, Mar 19, 2025 at 12:13:30AM -0700, Greg Thelen wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> cgroup_rstat_flush_locked() grabs the irq safe cgroup_rstat_lock while
> iterating all possible cpus. It only drops the lock if there is
> scheduler or spin lock contention. If neither, then interrupts can be
> disabled for a long time. On large machines this can disable interrupts
> for a long enough time to drop network packets. On 400+ CPU machines
> I've seen interrupt disabled for over 40 msec.
> 
> Prevent rstat from disabling interrupts while processing all possible
> cpus. Instead drop and reacquire cgroup_rstat_lock for each cpu. This
> approach was previously discussed in
> https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/,
> though this was in the context of an non-irq rstat spin lock.
> 
> Benchmark this change with:
> 1) a single stat_reader process with 400 threads, each reading a test
>    memcg's memory.stat repeatedly for 10 seconds.
> 2) 400 memory hog processes running in the test memcg and repeatedly
>    charging memory until oom killed. Then they repeat charging and oom
>    killing.
> 
> v6.14-rc6 with CONFIG_IRQSOFF_TRACER with stat_reader and hogs, finds
> interrupts are disabled by rstat for 45341 usec:
>   #  => started at: _raw_spin_lock_irq
>   #  => ended at:   cgroup_rstat_flush
>   #
>   #
>   #                    _------=> CPU#
>   #                   / _-----=> irqs-off/BH-disabled
>   #                  | / _----=> need-resched
>   #                  || / _---=> hardirq/softirq
>   #                  ||| / _--=> preempt-depth
>   #                  |||| / _-=> migrate-disable
>   #                  ||||| /     delay
>   #  cmd     pid     |||||| time  |   caller
>   #     \   /        ||||||  \    |    /
>   stat_rea-96532    52d....    0us*: _raw_spin_lock_irq
>   stat_rea-96532    52d.... 45342us : cgroup_rstat_flush
>   stat_rea-96532    52d.... 45342us : tracer_hardirqs_on <-cgroup_rstat_flush
>   stat_rea-96532    52d.... 45343us : <stack trace>
>    => memcg1_stat_format
>    => memory_stat_format
>    => memory_stat_show
>    => seq_read_iter
>    => vfs_read
>    => ksys_read
>    => do_syscall_64
>    => entry_SYSCALL_64_after_hwframe
> 
> With this patch the CONFIG_IRQSOFF_TRACER doesn't find rstat to be the
> longest holder. The longest irqs-off holder has irqs disabled for
> 4142 usec, a huge reduction from previous 45341 usec rstat finding.
> 
> Running stat_reader memory.stat reader for 10 seconds:
> - without memory hogs: 9.84M accesses => 12.7M accesses
> -    with memory hogs: 9.46M accesses => 11.1M accesses
> The throughput of memory.stat access improves.
> 
> The mode of memory.stat access latency after grouping by of 2 buckets:
> - without memory hogs: 64 usec => 16 usec
> -    with memory hogs: 64 usec =>  8 usec
> The memory.stat latency improves.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Greg Thelen <gthelen@google.com>
> Tested-by: Greg Thelen <gthelen@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

