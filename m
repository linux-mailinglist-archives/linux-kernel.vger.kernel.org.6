Return-Path: <linux-kernel+bounces-400878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9FD9C1390
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D04B21F6E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EBAB67A;
	Fri,  8 Nov 2024 01:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhhjWIvv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019E733E7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029001; cv=none; b=XCDU3huTPsV4TgVKh6wz0OJg2cSSn2uCntiou4O6dHgweR2mhAQYqCQ56NIXgah6l8lnhgxttYwdvSsNSIo509jhDxoq8vRTJSSMpqhZNb3NWN+uWy5TpyYh93X0A1qtbd81IcdcM6vYdkqDfkp+LcMjHvWbLRgkArZYRL6fjRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029001; c=relaxed/simple;
	bh=DGbyf/rovFNQPhr6Y7TGGaqTfWcDQ4P9WoM8/4ykUbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XH638xPxnQQSqt29d/V7r9uxuz6QNOwlaDIOwjhny66t3ugW7g17TfgDrOMlU1rLbBc3X07HlnRWotjk5pfI9275Tc3rqRuj7aiWI9oIBCt9a7T7uhBX7fHpI25PITx0ETAC8E4j/A5L7nCqq7JGJW7/rxpfz1NjatI4vQZZZgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhhjWIvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F0DC4CECC;
	Fri,  8 Nov 2024 01:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731029000;
	bh=DGbyf/rovFNQPhr6Y7TGGaqTfWcDQ4P9WoM8/4ykUbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhhjWIvvGtwGyLr1KzV29U/LcFROauzgf1669f9mR1dPmnvO8bWkg2RBx3tQeE+Tf
	 X4q8zwCUxe06LoYsKfNs9FRRy87dvXPZMmnN3CHrr0d6wVh6QkTM9EjArUeSvCrcWZ
	 2HcDaKsleAcY0AOteq7r8EN6JVdaON5ahdlpab5U++59FEjFM+pJd2jWnlA7Wrng9v
	 6NXdxdAzgoD9ok9kwyb/+sw3p2uovSQzB/d64bTU5QS6BqWtkHhHW6gOz/zCnYZeef
	 D2TV4eceiX1EoL4jKMfe5z/e/dbYq5D6aex+bBP91uQwNHkz8Xswh96Vkzutzsfd0m
	 Jbw3xcTIO7DDg==
Date: Thu, 7 Nov 2024 17:23:17 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Tuan Phan <tuanphan@os.amperecomputing.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf/arm-smmuv3: Fix lockdep assert in ->event_init()
Message-ID: <Zy1oBfroZLBwN6Jf@google.com>
References: <20241107215921.3518636-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107215921.3518636-1-ctshao@google.com>

On Thu, Nov 07, 2024 at 09:59:20PM +0000, Chun-Tse Shao wrote:
> Same as
> https://lore.kernel.org/all/20240514180050.182454-1-namhyung@kernel.org/,
> we should skip `for_each_sibling_event()` for group leader since it
> doesn't have the ctx yet.
> 
> Fixes: f3c0eba28704 ("perf: Add a few assertions")
> Reported-by: Greg Thelen <gthelen@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Tuan Phan <tuanphan@os.amperecomputing.com>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  drivers/perf/arm_smmuv3_pmu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index d5fa92ba8373..09789599fccc 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -431,6 +431,11 @@ static int smmu_pmu_event_init(struct perf_event *event)
>  			return -EINVAL;
>  	}
>  
> +	hwc->idx = -1;

I think you should update the event->cpu as well.

Thanks,
Namhyung

> +
> +	if (event->group_leader == event)
> +		return 0;
> +
>  	for_each_sibling_event(sibling, event->group_leader) {
>  		if (is_software_event(sibling))
>  			continue;
> @@ -442,8 +447,6 @@ static int smmu_pmu_event_init(struct perf_event *event)
>  			return -EINVAL;
>  	}
>  
> -	hwc->idx = -1;
> -
>  	/*
>  	 * Ensure all events are on the same cpu so all events are in the
>  	 * same cpu context, to avoid races on pmu_enable etc.
> -- 
> 2.47.0.277.g8800431eea-goog
> 

