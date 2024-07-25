Return-Path: <linux-kernel+bounces-261627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E78593BA12
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9BCB23A18
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB2E4C74;
	Thu, 25 Jul 2024 01:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Wimf2Aex"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328C828EC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721870353; cv=none; b=c6ikP4VlaiztVkDDnDNpMfEikKeu8wlnWWoOh7LtOXrPTBHsDKYrk5Sb0p30tXN5ibnZQ1Pq1BPICrD1za8oEa8weXWVdHSb3VjZGCvxLalBRSv7oP/ZhZMHcVMozpQvlJoh3NudSroODfrGfR3axPejc5T4Sw7UYyDWxzczRVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721870353; c=relaxed/simple;
	bh=qj4XMVH8nB0hsZM62lx9qwau8kTHf08pAm3zw41TbIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLFR9qxr/Nh9uAEBs5Bqf/tJNqyu4KP2oV4J92PpaamqI16zyC0tnFBev0Nz/Unm4yIMUkATeeNb5AEGFPaXsqr0K+If1kR9xkKGkeSUuRPGc7Rl/VbuMaeLRO1AdR5F5Lrab8t/2DbU2yvBH8rqM/u3LV8WQqkiWi2jLu1Dqr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Wimf2Aex; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-368526b1333so833637f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1721870349; x=1722475149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AqU8lUe0bj+tTV7gIbAMr6qtI8kzFRCvMqvsujgddCg=;
        b=Wimf2Aex7LGR+F03gPK1hg2viW/8kgUfqiSCGf2ApkanVjpSDFoXiT5o9DhPD+fPTU
         35Re9vW7XBjf+noCEI74IloRyJPnnh7DEo+VXHGsoH4FtqEJKMCjIU+MgxqForAw+oQH
         ojY8zuvl6O7+24NfhVDmoLbltPhnvGIAix1edxc9i5k+Od0XDvNfJ01Km/3JereMpKbT
         eYGnOXCTmt6WEZpdFSZhGsjzVTCnGuRKbGDYFQU3JFf7zxrcSph4BLIhhaZ2CG8gyscD
         I9VuqftNjvjjRc/Bkzysw4VpywrzgvcyIUeMqlxBtp4HqmTwVX3pX9VMjyq9dC4R41ET
         Zecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721870349; x=1722475149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqU8lUe0bj+tTV7gIbAMr6qtI8kzFRCvMqvsujgddCg=;
        b=OZwdRlirvOuNcAGngkdmSj72iiBd5niqZmN8MAzqdMUOvfBDvE1rnmzEF9Ku7e78wu
         2+CdAMrvTnxvDkxMYqr9uzAqOrcK42u3C369PRQtz/r7busgXCSN3NNsfoUhJcfZH1vE
         rALvgzIEyVEb4x5LDvoFYBW5/EaTZlT/HiP2r2DqNB0zWQ5AP+ag2m0x/xy4G8G0/Hf4
         8Wf27DouWo+M7MJBok/pF5y0dBlw6rhjAlgwj4PwmGhFuze4nPZSNPNzU6MEK+XC/Rxu
         PHh3jLIhAeVZ2MDOIiQBxbSr504NDLRoMatRPOoVlxchn6gaoowCfKNxBed+NF8dOVZL
         l1jg==
X-Forwarded-Encrypted: i=1; AJvYcCWLLEikZq3MUPjqfGJrPo6GYSPc6pvxyBLpmJOQsQf+vof9clpI1xB3T70luxnnWV5MbbLCivMniFI2CpYuymzsj9YNiXmNtm0nnpbe
X-Gm-Message-State: AOJu0YyreGJl5Ccc6GG22VFy4t2pTXvC7yJqvjsZPUdvMVuV0VoWypto
	W9QO6+slap9FCVuIlxoWyn5DKjctD+qeYiXbQJHOBZoTZCBS75lsBfYtSecCvIE=
X-Google-Smtp-Source: AGHT+IE0mHUM2hxQC2Qm9Jwj5xdAp6VgvGIjUvYXsAkuJxIGjxUXJpAB73r+PtS9T+GbXUXxMi2jGg==
X-Received: by 2002:a5d:6847:0:b0:360:866f:5083 with SMTP id ffacd0b85a97d-36b31baa861mr710636f8f.32.1721870349158;
        Wed, 24 Jul 2024 18:19:09 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857e3bsm359004f8f.81.2024.07.24.18.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 18:19:08 -0700 (PDT)
Date: Thu, 25 Jul 2024 02:19:07 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <20240725011907.3f5ropfai3xoy3l3@airbuntu>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>

On 07/15/24 12:32, Tejun Heo wrote:
> NOTE: I couldn't get git-request-pull to generate the correct diffstat. The
>       diffstat at the end is generated against the merged base and should
>       match the diff when sched_ext-for-6.11 is pulled after tip/sched/core
>       and bpf/for-next.
> 
> The following changes since commit d329605287020c3d1c3b0dadc63d8208e7251382:
> 
>   sched/fair: set_load_weight() must also call reweight_task() for SCHED_IDLE tasks (2024-07-04 15:59:52 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.11
> 
> for you to fetch changes up to 8bb30798fd6ee79e4041a32ca85b9f70345d8671:
> 
>   sched_ext: Fixes incorrect type in bpf_scx_init() (2024-07-14 18:10:10 -1000)
> 
> ----------------------------------------------------------------
> sched_ext: Initial pull request for v6.11
> 
> This is the initial pull request of sched_ext. The v7 patchset
> (https://lkml.kernel.org/r/20240618212056.2833381-1-tj@kernel.org) is
> applied on top of tip/sched/core + bpf/for-next as of Jun 18th.
> 
>   tip/sched/core 793a62823d1c ("sched/core: Drop spinlocks on contention iff kernel is preemptible")
>   bpf/for-next   f6afdaf72af7 ("Merge branch 'bpf-support-resilient-split-btf'")
> 
> Since then, the following changes:
> 
> - cpuperf support which was a part of the v6 patchset was posted separately
>   and then applied after reviews.

I just reviewed this and I think you're going in the wrong direction here.
I don't think the current level of review was sufficient and we're rushing
things to get them into 6.11.

	https://lore.kernel.org/lkml/20240724234527.6m43t36puktdwn2g@airbuntu/

We really shouldn't change how schedutil works. The governor is supposed to
behave in a certain way, and we need to ensure consistency. I think you should
look on how you make your scheduler compatible with it. Adding hooks to say
apply this perf value that I want is a recipe for randomness.

Generally I do have big concerns about sched_ext being loaded causing spurious
bug report as it changes the behavior of the scheduler and the kernel is not
trusted when sched_ext scheduler is loaded. Like out-of-tree modules, it should
cause the kernel to be tainted. Something I asked for few years back when
Gushchin sent the first proposal

	https://lwn.net/Articles/873244/
	https://lore.kernel.org/lkml/20211011163852.s4pq45rs2j3qhdwl@e107158-lin.cambridge.arm.com/

How can we trust bug and regression report when out-of-tree code was loaded
that intrusively changes the way the kernel behaves? This must be marked as
a kernel TAINT otherwise we're doomed trying to fix out of tree code.

And there's another general problem of regression reports due to failure to
load code due to changes to how the scheduler evolves. We need to continue to
be able to change our code freely without worrying about breaking out-of-tree
code. What is the regression rule? We don't want to be limited to be able to
make in-kernel changes because out-of-tree code will fail now; either to load
or to run as intended. How is the current code designed to handle failsafe when
the external scheduler is no longer compatible with existing kernel and *they*
need to rewrite their code, pretty much the way it goes for out-of-tree modules
now?


Thanks

--
Qais Yousef

