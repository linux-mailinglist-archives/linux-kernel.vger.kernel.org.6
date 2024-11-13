Return-Path: <linux-kernel+bounces-407602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A94A9C6FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E72285741
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E667F202626;
	Wed, 13 Nov 2024 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUvd/btx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3325200BAB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502239; cv=none; b=Pg0JjNyfqUtTZZglhNb7b48r0CkmNkIrhXFraY/EBL51psLJ2exXtdUCPd1VmGsDXph/T2zePUkmtpmm8XcSWTk4+lj+hX+7eHow75Zqw+qjmMRLHJLAT2p0isMg/k6E+t+WDjMfyCjfBYjtk+wHreBbWKlqiE6uNS7P55QEZhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502239; c=relaxed/simple;
	bh=pu4ieQzMIEC+cCv8EiUP6oF43mrylIn2XMgy0u+REgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VltviREr3UnUaiUwPXW3+iyVywPVY62+HfR98vL1WY9gm7rZP4cZmoBRqaIOhoH7FYiYQq4FkFQU1X7FU9DlHlCbiOLVaPLq+OFGrnufeUNcC4fhbElSIHiZpurkNcivKt18suKrPeIUEKQS8CYliLH66sPwTF5+RY/7I++fX90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUvd/btx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731502236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a//nOgslom16UuQgDqqBTPi6y9iLqqL1BjQ/XIuEtjU=;
	b=OUvd/btxnlA3TXw0AR6BEfcpzWU5wYN00f6h0OV73TaJ4KdELinNUE2NKig7u1rw5kki27
	RJEMYFnLqN4q6QRsD2OwY2I+zMNlRlvjTnVx2za1YM580qRilyaKczO46E3/TrwibVgMEp
	Wmd3hdFFdb8OXNJO4S+Qsqip+vkxF3I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Uh7EhyTKO6aZeppzGphNqg-1; Wed, 13 Nov 2024 07:50:34 -0500
X-MC-Unique: Uh7EhyTKO6aZeppzGphNqg-1
X-Mimecast-MFC-AGG-ID: Uh7EhyTKO6aZeppzGphNqg
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d52ccc50eso3734648f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 04:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502233; x=1732107033;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a//nOgslom16UuQgDqqBTPi6y9iLqqL1BjQ/XIuEtjU=;
        b=i4F4qaL3TKBK4Oj6P8xj6FkailMk55RIufIgIGItWE3LiqWGD9SmKr4Vj71uK6MIRw
         p5jTKdX0Iu+7t8KROUhW9il75jOkDqboYEdq35+MCXGekuZIAF9vqVEYO77gFLWJHvAS
         SmjbTvAgEMeZgeSGpXsQ/ayg4DnIsIhQN7s+smUomd9kPRx9wuFczS+Q6U3W0/xCnwx7
         5DlHboSKwVlJgLi/268skhJtuYZa+b6Y+JpRWbKTR8EBcFEo8FETokMp1/SzNzoSaPF/
         ScyumMVjFnyBW9mKPd2zU7vcvpCV4hfyXWRTUEgWpHTPWw2EmAQ8KPkbedzEn4Lr9sRI
         YwuA==
X-Forwarded-Encrypted: i=1; AJvYcCU7pn/K1XDH59WV0QSEMeA/VKTSzahCe1O/uB5SBRSihoibdynIBD98ZVIi7yh+qLN0I9YDIb5ucFm8yVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzls2TIzOoGXqaMNPpULp8MhBqLz/9Nwb17AV9YaUJ24aov1gTL
	O64gzQxDuIKxcxrjaay5SmsCZne8kLUxw/5yqtFsCtGhOvB3xKrwCb+JnFJIVpItSLhXphYtWPp
	B73yn0w6mynI7zrPYRv112E60Ffsf4bz8uEu2+o7qsctXZgSSEVtJfRKGTA0W3Q==
X-Received: by 2002:a05:6000:154d:b0:37d:45f0:dd0a with SMTP id ffacd0b85a97d-381f18672b7mr16355732f8f.1.1731502233604;
        Wed, 13 Nov 2024 04:50:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHW8m4bFchFCSBPhVncAtAHE6ZvOYaU5kvFq0q71snYM1BqPti/LEPBqo3rWcT7+Tbi4kRPqw==
X-Received: by 2002:a05:6000:154d:b0:37d:45f0:dd0a with SMTP id ffacd0b85a97d-381f18672b7mr16355707f8f.1.1731502233211;
        Wed, 13 Nov 2024 04:50:33 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea4f6sm18252890f8f.64.2024.11.13.04.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:50:32 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Andrea Ciprietti <ciprietti@google.com>, linux-kernel@vger.kernel.org
Cc: Andrea Ciprietti <ciprietti@google.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Josh Don
 <joshdon@google.com>
Subject: Re: [PATCH] sched/smt: Call sched_core_cpu_deactivate() after error
 is handled
In-Reply-To: <20241108121120.3912918-1-ciprietti@google.com>
References: <20241108121120.3912918-1-ciprietti@google.com>
Date: Wed, 13 Nov 2024 13:50:31 +0100
Message-ID: <xhsmhy11nb8mg.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 08/11/24 12:11, Andrea Ciprietti wrote:
> In sched_cpu_deactivate(), the error path restores most of the initial
> state before returning, but, if CONFIG_SCHED_SMT is defined, it does not
> undo the previous call to sched_core_cpu_deactivate().
>
> There is no easy way to invert such function since it overrides some shared
> state of the leader CPU. Instead, simply move the call past the error
> handling code. This is fine since cpuset_cpu_inactive() performs unrelated
> operations.
>
> Note that there's no need for #ifdef since cpuset_core_* have empty
> definitions when CONFIG_SCHED_SMT is not set (in which case this patch is a
> no-op).
>
> Fixes: 3c474b3239f1 ("sched: Fix Core-wide rq->lock for uninitialized CPUs")
> Cc: stable@kernel.org
> Suggested-by: Josh Don <joshdon@google.com>
> Signed-off-by: Andrea Ciprietti <ciprietti@google.com>
> ---
>  kernel/sched/core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 719e0ed1e976..4d55bc243ae5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8187,10 +8187,6 @@ int sched_cpu_deactivate(unsigned int cpu)
>  	 */
>  	sched_smt_present_dec(cpu);
>  
> -#ifdef CONFIG_SCHED_SMT
> -	sched_core_cpu_deactivate(cpu);
> -#endif
> -
>  	if (!sched_smp_initialized)
>  		return 0;

                ^^^^^^^^
You're moving the call to the other side of this, however I don't recall
that hot-unplug can happen before sched_init_smp(). Built-in rcutorture
wouldn't start flipping CPUs until device_initcall's, which happens later
in kernel_init_freeable():

  kernel_init_freeable()
  `\
    smp_init() <- boots all secondaries
    sched_init_smp()
    do_basic_setup()
    `\
      do_initcalls()

So this looks okay, but needs a mention in the changelog IMO.

>
> @@ -8204,6 +8200,7 @@ int sched_cpu_deactivate(unsigned int cpu)
>  		sched_update_numa(cpu, true);
>  		return ret;
>  	}
> +	sched_core_cpu_deactivate(cpu);
>  	sched_domains_numa_masks_clear(cpu);
>  	return 0;
>  }
> -- 
> 2.47.0.277.g8800431eea-goog


