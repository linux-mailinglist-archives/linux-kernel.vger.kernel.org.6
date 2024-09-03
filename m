Return-Path: <linux-kernel+bounces-312989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD299969EC1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9031F24DBF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D301A724B;
	Tue,  3 Sep 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rr4PUu99"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380521CA6B5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369056; cv=none; b=HFweanMNFRszn1RZPGkh5CWWhdB3q9kVYyCF+Xuodw3dSbF8CCw/VJQIrL8QSoMq/i/Kk2NNOBIVCygCeqGTJGY1xwRFl4drxUApUte7sD9eV2vYyNd6D6J0OIolKL9FbAaUTKpjXHh+Hr+dBK5mymFnwASPTNzR+0VcT7uRNF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369056; c=relaxed/simple;
	bh=7ljDtEh2yGy7dXUeTwd1MTJ8A6pLBZJjp4bVEZazz5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s55t77nIUi+msxhP0afT0Ce9PZrJcKY0Qt/sdWOZWsYsvCzLDm2RQdC3M/doPMjVezgc/zGX15v/cX/O4gf13wy0K3JJGL/kuboXzubLyxLALC0WzxrDBdxpr9g9SEtJw49oJIJwxu2x0YgH0X7odquUamtZjd29GJZ1WzhTn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rr4PUu99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD17C4CEC4;
	Tue,  3 Sep 2024 13:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725369055;
	bh=7ljDtEh2yGy7dXUeTwd1MTJ8A6pLBZJjp4bVEZazz5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rr4PUu99oefqkVR4bwmACmnAJIXSgbj4tdibHr5Cn1tCQkBvpllAP1GruUOsmd4sQ
	 wx+TjPlH0a11mKGQUvlVZV/rJgLqO48Bnde9CNGr9hbowvatqxS+Ke1hzkTuQfkjv8
	 r04IWZrr/t7WsXLZO8L5FpvtnsTihU5LUkXTC+Ys2b+xo8Us1BspGxG8s3a4bC91wF
	 OBGjaCpmawD049eOYD1uJBKw9ANX+h7gGfOspMybY/r2ngeEpOyssR/P70KuE0BCfN
	 S9szgoUWoxLDuAekCvzVPBoFV2jY+hoSFnNIDJ+TtZH203mMgnsMCrD6uWUZbbkmZC
	 YY7HqOEOvDAoQ==
Date: Tue, 3 Sep 2024 15:10:53 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/isolation: Add HK_FLAG_SCHED to nohz_full
Message-ID: <ZtcK3aF_d3BUhiVz@localhost.localdomain>
References: <20240818234520.90186-1-longman@redhat.com>
 <20240818234520.90186-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240818234520.90186-2-longman@redhat.com>

Le Sun, Aug 18, 2024 at 07:45:18PM -0400, Waiman Long a écrit :
> The HK_FLAG_SCHED/HK_TYPE_SCHED flag is defined and is also used
> in kernel/sched/fair.c since commit de201559df87 ("sched/isolation:
> Introduce housekeeping flags"). However, the corresponding cpumask isn't
> currently updated anywhere. So the mask is always cpu_possible_mask.
> 
> Add it in nohz_full setup so that nohz_full CPUs will now be removed
> from HK_TYPE_SCHED cpumask.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/sched/isolation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 5891e715f00d..a514994af319 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -196,7 +196,7 @@ static int __init housekeeping_nohz_full_setup(char *str)
>  	unsigned long flags;
>  
>  	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
> -		HK_FLAG_MISC | HK_FLAG_KTHREAD;
> +		HK_FLAG_MISC | HK_FLAG_KTHREAD | HK_FLAG_SCHED;
>  
>  	return housekeeping_setup(str, flags);
>  }

find_new_ilb() already has HK_FLAG_MISC to prevent an isolated CPU
from being elected as an ilb. So I think we should simply remove HK_FLAG_SCHED.

Thanks.

