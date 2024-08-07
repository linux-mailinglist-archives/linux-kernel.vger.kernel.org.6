Return-Path: <linux-kernel+bounces-277695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5990394A4E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C87B1C2223D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F201D1756;
	Wed,  7 Aug 2024 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wm3DFLYB"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274AD19066E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024849; cv=none; b=PzbzPhyyL1bG6x2qBvX7GtmzZjWVQg6YvSyJ7A7yWLQeXTLvXZMszfm3GMDNUE4usaYolxdZy7HOxe+7uq5hqzwmy0aTfvc74rpvUQKKRPLIhRvEWpvvZ22uvVIe7KikNdtaTpsAMN/rti5kpFi9/N5WNPp2lPCQgaHVh22+UHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024849; c=relaxed/simple;
	bh=DN4Tn1xE2M0WcZ5JI7GtUQ4qLZ1GznAtL3tNk5n7WtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHMSynbEqypLClWCSfi8eUucwY2O/s2EpSNVsbmSAz+QIcCeUVVTaKA9bb425eDfFZK6GikGm/ut5srHFTiqYv+glLtiSa8mOv9hSnp/Yn+i2A0Ze5ibgoI3mmLrZ/Sr1W82ngmEunyGg+eRQYcuk2CVKNC1ge3+Vu+d5Na1Ehc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wm3DFLYB; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cfcbdfa572so1132663a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 03:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723024847; x=1723629647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pvk8+58D7bYAu3LaZCoq7oPShkNrCdHz8ijBCfnKnzk=;
        b=wm3DFLYBQCJ5v0b3CW7hmTGlV9TeLtKJsNKTdJu+IxC8bdJe6glx3XreiVICNPndOB
         J4r+L/1Ep2kdOiLrI8umyC5IKnDF8PJPrrwA5r2esqFqLNO/6O4kncgjTRKDohRUuOgR
         e6TbJPsST3iPUnSWly5BLAC7ehThj2I9iVKoAJX2Ez58ysD0eGyJO0EQw+CwelsSfvFa
         wcrNnWnGDgXro4IjJDgBUmRox2QIqcCUStDVAw8LBVFPO900v2w05XSga+XPMXCe+cq1
         Wq1ERqVN/A78EZWbIm/Ehjzkkcf3WZnQNMFOxani5DD7iy1y4Q0AMyo86rSDaspBu15d
         louQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723024847; x=1723629647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvk8+58D7bYAu3LaZCoq7oPShkNrCdHz8ijBCfnKnzk=;
        b=NeBxMMqNpIm/mM6d23HMZIR6swIY7dqMfOzaOWMxQg5hMwFRvmBsa/hPCfSxu/os/i
         Jt9J5yWIY975+9zsis1jvkKfb46186O94JNNzObG2koPECJ0aUMHs6d5nxZR4hjFbTun
         QsbPrKGFoYRFY2YSySrq/L7XPsN0sQupLC4vZAuS552GQ3yu7D1vR/aUPIMJeyqN6ycv
         u+m4VRjNHlHGMdJBpy+MhZ6MgDT3Vx0Tuu7NFIQNkS9MDdkkjgyR/4RLK0FWUfkwE8ZN
         34+WYbFmz43U6wjYQfu9CQK5hD/lrW9xzv/bWJTqgqmcnZ9/tuddQGZ/6r4FEcdGA0bc
         5qGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHJQ2NrleuWhLDWl3VGk5BkPIQ0DNsEoD+HruNw7aqzwyGsghIThQHQWYXGX18joGh/iOnlN3dnt29TtmxxMZDGo9aV0Q1sWw5gdS1
X-Gm-Message-State: AOJu0YzgftcSKrn3tEic4KKFYclr3HvQXwTlpgsBFg5ykOODRjEOb1lu
	LKoslqJV40aUb34hDAWhxsgh0m4FzOVrP5aQ7naiWtzrtXJO6sW85MHvrrWjwHyrnyEIphOUvGY
	kem8L5jJmBqxitLXSd6H1q6lS174Lxw6awVQvyg==
X-Google-Smtp-Source: AGHT+IHDq3sOBU5R4QSRS3RcA8ctymQNZrz5UFsyxHt2fKFrrLOWBFYd8+BksUjO5UiRzMm/WG6Z9QWSrXaTnVUQrz8=
X-Received: by 2002:a17:90b:4f45:b0:2cf:5e34:f1e4 with SMTP id
 98e67ed59e1d1-2cff943dd1amr18357938a91.13.1723024847417; Wed, 07 Aug 2024
 03:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807080032.2302853-1-arnd@kernel.org>
In-Reply-To: <20240807080032.2302853-1-arnd@kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 7 Aug 2024 12:00:35 +0200
Message-ID: <CAKfTPtDs-Y5_puGU2QYd_NatB7RQzgGQPuwfaCWXrq_8Vqw2dw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: avoid integer overflow warning for fair_server_period_max;
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Arnd

On Wed, 7 Aug 2024 at 10:00, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The clalculation of fair_server_period_max includes an integer overflow:
>
> In file included from kernel/sched/build_utility.c:72:
> kernel/sched/debug.c:341:57: error: integer overflow in expression of type 'long int' results in '-100663296' [-Werror=overflow]
>   341 | static unsigned long fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */
>
> Avoids this by using an unsigned constant to start with.

Dan sent something similar
https://lore.kernel.org/lkml/a936b991-e464-4bdf-94ab-08e25d364986@stanley.mountain/

>
> Fixes: d741f297bcea ("sched/fair: Fair server interface")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/sched/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 0148bc65d39c..242e7f264a0b 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -338,7 +338,7 @@ enum dl_param {
>         DL_PERIOD,
>  };
>
> -static unsigned long fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */
> +static unsigned long fair_server_period_max = (1u << 22) * NSEC_PER_USEC; /* ~4 seconds */
>  static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
>
>  static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubuf,
> --
> 2.39.2
>

