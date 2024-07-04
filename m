Return-Path: <linux-kernel+bounces-241132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4199692776A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E4128376D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78761AE852;
	Thu,  4 Jul 2024 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AoinLBuY"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250881822E2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720100857; cv=none; b=VdR9bncR3e28u0W5DY+E+MPpVeGpQdnyzVGErGu626yq9EoWnkqnnY4L9i8HXvjWTu9Dhjreb42Y8ke8fJBaz0bY0/MQ5djzzeJAilhkF7CgQRjHBGEWOoHg1AHhI1bsyiZGHm4hzka0sRYB3SlqMJYPCnS4NkHzWUtxkWDQLVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720100857; c=relaxed/simple;
	bh=eDM9jT/qNbI/zcyvdUC6pQzI5yk1dMRNa8g9ZFxgmIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feQc2MOi1rFChIiEwXmRa8L9kIA3U7yQfaRYKJ0gy4Rbk85c/A+XSflv0C9W8YnBrRGvYiyy92ShALLjVuPKyFE/XWC5awonfQcsDLwm809YfqWi6RoVa6hFXAK+DAQ9hhyD07Cwfap8LwwiGbr9SLq3+xQKx6622zBV2ggOc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AoinLBuY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NLQzzal07EqgcX0VPVS91kE6C8Bk6zJGZq+107oJ8b0=; b=AoinLBuYpduMh7WvV25MYcFQ2r
	M9c7+h+mBlrqEwYkleh9KL4LxjMqN6EvHWlRHRgK7T6GlMS6fETFkUxb/xLCJG+bY/TAFFu8s1dQ8
	OAgrm+KFxhk846WQiKtzgpzSthF/QUOglAkZej/efR0b0zlD3XesOs2c1e2K2Q6sWeqvaGFIjbVX7
	9v1YIfeEhLfkbCtGOjSxm1nLeNKNry4M94N6YaeUhQAHMcYxx9w7V3/8YugZPR3ZaDJkk4N9KbNvC
	GOwzPqI4Xchgu7judRCte9qVP9gkC62LOXjMbYvLmbfVh25SSgeh/UZ2x2U9nMVvcEdB5cgm0sX28
	VT0y2/hA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPMnw-0000000AE1n-0BsE;
	Thu, 04 Jul 2024 13:47:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E1BB3300694; Thu,  4 Jul 2024 15:47:16 +0200 (CEST)
Date: Thu, 4 Jul 2024 15:47:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: xu.xin16@zte.com.cn
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, he.peilin@zte.com.cn, yang.yang29@zte.com.cn,
	tu.qiang35@zte.com.cn, jiang.kun2@zte.com.cn,
	zhang.yunkai@zte.com.cn, liu.chun2@zte.com.cn, fan.yu9@zte.com.cn,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next v2] sched/core: Add WARN() to check overflow
 in migrate_disable()
Message-ID: <20240704134716.GU11386@noisy.programming.kicks-ass.net>
References: <202407032053257877vuVsFfB1hh0DKSowPd8p@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407032053257877vuVsFfB1hh0DKSowPd8p@zte.com.cn>

On Wed, Jul 03, 2024 at 08:53:25PM +0800, xu.xin16@zte.com.cn wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8cc4975d6b2b..327010af6ce9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2259,6 +2259,7 @@ void migrate_disable(void)
>  	struct task_struct *p = current;
> 
>  	if (p->migration_disabled) {
> +		WARN(p->migration_disabled == USHRT_MAX, "migration_disabled has encountered an overflow.");
>  		p->migration_disabled++;
>  		return;
>  	}

How about we do something like this?

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7a5ea8fc8abb..06a559532ed6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2237,6 +2237,12 @@ void migrate_disable(void)
 
 	if (p->migration_disabled) {
 		p->migration_disabled++;
+#ifdef CONFIG_DEBUG_PREEMPT
+		/*
+		 * Warn about overflow half-way through the range.
+		 */
+		WARN_ON_ONCE((s16)p->migration_disabled < 0);
+#endif
 		return;
 	}
 
@@ -2254,14 +2260,20 @@ void migrate_enable(void)
 		.flags     = SCA_MIGRATE_ENABLE,
 	};
 
+#ifdef CONFIG_DEBUG_PREEMPT
+	/*
+	 * Check both overflow from migrate_disable() and superfluous
+	 * migrate_enable().
+	 */
+	if (WARN_ON_ONCE((s16)p->migration_disabled <= 0))
+		return;
+#endif
+
 	if (p->migration_disabled > 1) {
 		p->migration_disabled--;
 		return;
 	}
 
-	if (WARN_ON_ONCE(!p->migration_disabled))
-		return;
-
 	/*
 	 * Ensure stop_task runs either before or after this, and that
 	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().

