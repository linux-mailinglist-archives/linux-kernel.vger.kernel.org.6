Return-Path: <linux-kernel+bounces-260529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C25593AA92
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FAC81F23B78
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49296FC2;
	Wed, 24 Jul 2024 01:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5iipFJe"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E779F4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721784413; cv=none; b=c7PDahI53DCS7FrOBaL3RiRsTypiRv2LLRX0/ql1dTR1mnfUKRsqFliL2mRZheCL5FbJpGdnNyJDX4vSuJfllp8zAgp4wpFdwnwLVluCx7WvunprNS1C8cEWBGIQ5t+PB/VjK+Q0+T093k6F84we38W5DFWFy7YgE9r+khz0tpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721784413; c=relaxed/simple;
	bh=DjPvcl/K7JqPRWan5v6GqGbzAkDANj8eR9YbcOMpcFw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XWSnZ78viUcO2oST2CciGGcFGq7sfUzTQGpTTHNeirzlVswEnjup7Sw4KSNSwzGrGNvDXFpSQ3VJOFb9Q9rA5d2Z69cxZxln62QwweCWampYo6DRPFtFP/erw0duGy4dwOlM2jYMqeOLnOQvMtedB9sv20noI/snkcSJF+7Z6yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o5iipFJe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd643d7580so55595ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721784411; x=1722389211; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SuiLMEUyBjzE0cIBX8hCFIUQgvaff54AEtN290ROgmA=;
        b=o5iipFJeMOhe8e+l7d9DzRkriLpPBE/xeB9DH/CuN04p1D5mbwxGnKrmvh4/khcERR
         r+jG/irnF1lIxADrWjs9/hIfF2vwZitKQdUs9QGmgpz13HUi6/TLNhOqsK8pW1gwmNZq
         9KNsOF/CO/erkGNSjZaRETnSO9VBGjx2oJFiZNUMWHkgZ25W/ZtqohyWpKFnUMx+Zeug
         ONOQEwuEwmQbMbUVEkrBJRVLawUIGVMNvBk/C5I4kZX0XeZJ4TR6T3rE7HPnyDYrX0ke
         aF56YCEIqhLpILdj7hTOCgWPHcWLChvt90ikBPGLSS/Bm+h5wwMcgi1dwJBwN0duLAZN
         VCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721784411; x=1722389211;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuiLMEUyBjzE0cIBX8hCFIUQgvaff54AEtN290ROgmA=;
        b=XB5R4agPGYTWUAmeVvl8XYWW9N7wNeRpOEndBe+2WOK/GQR/4lygnslCjx2cdojHxU
         CL5KIjOtrMeKmKy79GIW1B8BScCD1n82JWgaqpjBVCsxSAUTCaLQlkj+pDScmuRxWtS3
         JCPVZD3i9FrYy8Plm5Cxr6/pqkgRxaJyIgCG6Isd2nCd8NzOTedXWUx5sFmYHxASyGzy
         UPwy9pHBXFs0MWPB5xr2GbMBzXYsvrplOFz2kn1DyaugbSenbB9/GifZVfjZrKLzdc1w
         eKe7+w7WGJXXxAb0W90impxG+YphAOvgJWdf37L/fLKNxK2wdv+8K3rE2GpaRIDgC6ZO
         pOog==
X-Forwarded-Encrypted: i=1; AJvYcCUfHUnk7veGBGoOnP1J8MkzsNLitxTsw+q43Pi19bgfFxBTWFD/+pOPjtd7nPYcNZKdwQfaVGTiiaIf7lvE69JI1CWs8LpWFovEPq27
X-Gm-Message-State: AOJu0Yye5avpBzVDwjzHPweXLyqXkN1SbeEvj8Avd0lOYajgtoF2Buyh
	cKL43/Du4cXRg6PaL/xlPgr7oxCHVymO/B0/20IFDZGypntdQoBTPn13i7HmvA==
X-Google-Smtp-Source: AGHT+IFOJK9aRGCKWYjn1E83DO/1DTbZ27LqmMKFBedCQk3QtgQ+jauxDGeYMMRgtlnvjFzKHQ3rzg==
X-Received: by 2002:a17:903:1105:b0:1eb:3f4f:6f02 with SMTP id d9443c01a7336-1fdd3aea6b0mr1884095ad.12.1721784410429;
        Tue, 23 Jul 2024 18:26:50 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f486a3bsm81799655ad.284.2024.07.23.18.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 18:26:49 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: mingo@redhat.com,  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  mgorman@suse.de,  vschneid@redhat.com,
  chengming.zhou@linux.dev,  linux-kernel@vger.kernel.org,
  joshdon@google.com
Subject: Re: [PATCH v2 1/2] sched/fair: Decrease cfs bandwidth usage in
 task_group destruction
In-Reply-To: <20240723122006.47053-2-zhouchuyi@bytedance.com> (Chuyi Zhou's
	message of "Tue, 23 Jul 2024 20:20:05 +0800")
References: <20240723122006.47053-1-zhouchuyi@bytedance.com>
	<20240723122006.47053-2-zhouchuyi@bytedance.com>
Date: Tue, 23 Jul 2024 18:26:48 -0700
Message-ID: <xm26le1rzijr.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chuyi Zhou <zhouchuyi@bytedance.com> writes:

> The static key __cfs_bandwidth_used is used to indicate whether bandwidth
> control is enabled in the system. Currently, it is only decreased when a
> task group disables bandwidth control. This is incorrect because if there
> was a task group in the past that enabled bandwidth control, the
> __cfs_bandwidth_used will never go to zero, even if there are no task_group
> using bandwidth control now.
>
> This patch tries to fix this issue by decrsasing bandwidth usage in
> destroy_cfs_bandwidth(). cfs_bandwidth_usage_dec() calls
> static_key_slow_dec_cpuslocked which needs to hold hotplug lock, but cfs
> bandwidth destroy maybe run in a rcu callback. Move the call to
> destroy_cfs_bandwidth() from unregister_fair_sched_group() to
> cpu_cgroup_css_free() which runs in process context.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>

Reviewed-By: Ben Segall <bsegall@google.com>

> ---
>  kernel/sched/core.c  |  2 ++
>  kernel/sched/fair.c  | 13 +++++++------
>  kernel/sched/sched.h |  2 ++
>  3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6d35c48239be..7720d34bd71b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -12992,8 +12995,6 @@ void unregister_fair_sched_group(struct task_group *tg)
>  	struct rq *rq;
>  	int cpu;
>  
> -	destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));
> -
>  	for_each_possible_cpu(cpu) {
>  		if (tg->se[cpu])
>  			remove_entity_load_avg(tg->se[cpu]);

There is a slightly subtle point here that autogroup cannot have a quota
set. If there's some shenanigans way that that's possible then it would
need a destroy as well. autogroup is already making assumptions anyways
though.

