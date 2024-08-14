Return-Path: <linux-kernel+bounces-286626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC504951D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787FE28A169
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5E51B3725;
	Wed, 14 Aug 2024 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Po2HOw0w"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6289518C910
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646060; cv=none; b=KyU8zHUvvfb9svZ0B+xXwB8lVJFKEj1L+zwtEYnWRwGrineQ2eNtd6UVx+fw8s8jqcQlRVv9pp5bjeEfViYNUYGgrbA2Py8HqnzFfOtrOFPF5fG+uje1pmZEkpwUK1nfWkX9HXWVXb6+kptng1YlGaulMCX9WZdNfzE7bfBJ8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646060; c=relaxed/simple;
	bh=eT5FFvtfwZJjX9SlpCIbwQFZM/SYFPR+7CaHAsM34mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AloNSKJoZF/f2WdOPa+xlea9RuTvcnEiwQCHF/J6Ax6bfPfDYE7EtqEHnK8eJroWH8bAYTn45CftXAREkiEgEM+uE2R42YpNOzLiXCtThNpCJi2ovVavUpojxcOV/7OP8MPBtGQQa9xXd0eYYkgSb+zhMmxGjOO4nCxkbF/ODnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Po2HOw0w; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d3c05ec278so113344a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723646059; x=1724250859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SKavW0jMUKbktNcZNV7KuLNxq3tK5FUv2jPt4ATzNto=;
        b=Po2HOw0wJ21cNQ9eH7FbAIuIbyu505LGGnObz6BJIliKXVF/pMEAaIKBwTCDnc6ixA
         BxAA7FOGpleerNR4DyeNJcuFpRuVjeTfTgf2rNhxIG0vXXcDCJknH2fpofSJQ36DXUR/
         HboeCiZneifTTMQOfSdVV29NXXJHqwWe1ieO2sdmFsVlLGTAQE6pdxDdzF/+wdsOpS4Y
         Vt8rGRuM9DWI49oGBxsNayfBCCn6CDQcAXgrUyYs3NFiLObxPNO268JUKP2lJUMysLJw
         C3Pn+dG6OpqQh3Eu1+QcQze79GFbYb6OGNx4aK6KDv7w0xKK9OD4ZsSFgyTCMdKDXLTG
         KmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723646059; x=1724250859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKavW0jMUKbktNcZNV7KuLNxq3tK5FUv2jPt4ATzNto=;
        b=SfI1hflwzc7JeTbX6hCehFA8kQIeJeEbx8sW5axI3CoAKIj1vym7q+gp325nh6NA/G
         cC8pwKMcuVUJUffPkPXoWyOHy9QLEcOpg1ELO9Ah1z/Vl2bWmC+Cs45vH4VK4S/qhKvE
         McEM77IzePuGpaJ1kiOoi25WxuXf6YXD8g5U5xYfIDRNzmatfvhzRXHJmAgQh4GchEER
         ff6o31cCqr4ukU24vmhddZbCHWSoAznE7MFmyK855CrEyRjvueiMfHgepZ0gZOp7cweF
         DljdPL05Lb/0HoNqQFIDzxs+3COt0FwGPqEki1zyicADIA0InLoQbErcXKTgkl10yV4W
         Ig4w==
X-Forwarded-Encrypted: i=1; AJvYcCV0xU/+6KKp8AD0WcwIoUpMqPXJf/sMDIbydwlbpFtZXuBennY0xJ7nSLemNSvY0tvpeXovPKn6LAMECqCMt7/FU0u6Hq+22nmrmsvF
X-Gm-Message-State: AOJu0YxTGLmpP2cF1x0Q8CcEr8l7uMh28DBzBHet7/U86w7uegRNfkpi
	/wfJA2ffT7Oxz08ctWMYJA8Bo5x1RBh3E0fabpJ9joFMHQBd/8xFEjMdO8/cBiDBCweju9hSEXP
	lpnBYwxl3mb38bM5vOZA0yLVQU3iGzohlvDcNvQ==
X-Google-Smtp-Source: AGHT+IHyF9Y1f01iZF7fh/Jc8+XzOvZLXjaIXfN7d+YBCNdxSerNV9cnNRIMc3Ldp5FJjlrXiPYMczwdA28YfdDiIg4=
X-Received: by 2002:a17:90b:1e4d:b0:2d3:adc5:ef25 with SMTP id
 98e67ed59e1d1-2d3adc5f1d0mr2117590a91.22.1723646058656; Wed, 14 Aug 2024
 07:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727102732.960974693@infradead.org>
In-Reply-To: <20240727102732.960974693@infradead.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 14 Aug 2024 16:34:06 +0200
Message-ID: <CAKfTPtALe942tjoyq1RqSYyM40PG+tfEY8skRDxRM1daWLSKUg@mail.gmail.com>
Subject: Re: [PATCH 00/24] Complete EEVDF
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de, 
	efault@gmx.de
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Jul 2024 at 13:02, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hi all,
>
> So after much delay this is hopefully the final version of the EEVDF patches.
> They've been sitting in my git tree for ever it seems, and people have been
> testing it and sending fixes.
>
> I've spend the last two days testing and fixing cfs-bandwidth, and as far
> as I know that was the very last issue holding it back.
>
> These patches apply on top of queue.git sched/dl-server, which I plan on merging
> in tip/sched/core once -rc1 drops.
>
> I'm hoping to then merge all this (+- the DVFS clock patch) right before -rc2.

While trying to test what would be the impact of delayed dequeue on
load_avg, I noticed something strange with the running slice. I have a
simple test with 2 always running threads on 1 CPU and the each thread
runs around 100ms continuously before switching to the other one
whereas I was expecting 3ms (the sysctl_sched_base_slice on my system)
between 2 context swicthes

I'm using your sched/core branch. Is it the correct one ?

>
>
> Aside from a ton of bug fixes -- thanks all! -- new in this version is:
>
>  - split up the huge delay-dequeue patch
>  - tested/fixed cfs-bandwidth
>  - PLACE_REL_DEADLINE -- preserve the relative deadline when migrating
>  - SCHED_BATCH is equivalent to RESPECT_SLICE
>  - propagate min_slice up cgroups
>  - CLOCK_THREAD_DVFS_ID
>
>

