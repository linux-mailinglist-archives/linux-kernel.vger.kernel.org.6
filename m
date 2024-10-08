Return-Path: <linux-kernel+bounces-355377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8864995171
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D5C2852C2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415461DFD84;
	Tue,  8 Oct 2024 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="E2dHmoh5"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6FB1DF98E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397403; cv=none; b=HYjitk48RhQtkccRknhvC0T34Wmr40ZCXq9ZmaZYuucWiVNYMtHZknlySQZKlOOalkP1w+MJvWUMdnV4fnoSTZ+bXUZLeSRYScyyLJF+rMzKpFV4rdG5iRd5DOfWXlHWUCGODV5kv76PgRHuiaqGPzWxTKdqx/IaCbK4CjMe+og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397403; c=relaxed/simple;
	bh=BDRbogWNxzXaoWUBFIHD1YZttL/bdNz+74bVdj6tMoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHdAgE7zWugqJAX+TAXaL9Yik2xJTCwn4nWFwq+rWaTI5NQmVv7t2U0wvdBlxwa3Hx43sMPywCFiTXZEH9stQqatuRv62vkKwLBKWSJndN8l4WlE/AVSeOVv/COlFYiV6vK3+jWwhwZsw6o5L9J07bKW5J2dZjHGrYb2XxIojYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=E2dHmoh5; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7157d323709so84500a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1728397400; x=1729002200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MgPeVlBjaRguCn1fEjHw6ym4a2Oju2wd3Z1wqCeEBTg=;
        b=E2dHmoh5P5jPjw0uBdXk2Af7weW/7D8CCk3oO9ISbdOhyrenlC6iEfiSM9xOOriPVD
         2irfHTTBxlxItWXD86W1utWo5FWAt+2FxiDIoEcU5yFmQoy7X3/tSaC42CmD7S4Dr691
         JbdwROt7hWVnxGyB/f4RQSLQUr59lKDemtG8oFW9DQ4D21Ox0oq/IbxEElcMZIblwDKI
         Ajr9NJlK1j505xw2UjDX5jjddBGi9RDc1aZA6pIFSoiEjcQgRtfSg4FczY1IyhF6TfId
         XemarIkGvJcYrKm2yV9+zeAQnVfwNtehqFB3Q3HPROl0aSY4FrogiVUDEH9kFVuo15ue
         5Lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397400; x=1729002200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgPeVlBjaRguCn1fEjHw6ym4a2Oju2wd3Z1wqCeEBTg=;
        b=YG6XEKSH1dvkDllJ0pkEfnwFVzY+q38AFYQt6Y8z2S1NRMR4v5Af/sVRhp842zOoMe
         mgHCGMrQBXq02vRayvMiCEpg6PPM+qdOCULpUuKIzqb2Q7/m6K7IKu3PUkYUXItMa1wd
         rUp9A2nT6kSKu9wd3hZnKDBuB96V198AC18v/DNFnqgaHzuHoy7VzU784/gH6yVXh76d
         0nT00bPSHh2WhkyAHi1VuZekWgmQVrBcHwxF9S3klsvUa5ccnwlsaTgLWV6wcC5N+ZPu
         JHcyrWoZ4w1trKy74eBn9ji/qCfnFavuU4Cx7qcLXP4y9PnDKHqWc8mVt9qKpSMUUeEK
         Sphg==
X-Forwarded-Encrypted: i=1; AJvYcCVdNztliAuKiCLpIFzL0OV1vnfLIbuvQ+ztiXGsTFU/RZUo5/WKRnvno55g1xH0iuPuw3xemv1pqKVpaoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYjkKKqE+LtdMbTDIxOb1oZFE/2+nnHAT0u9lNGczAchDUh6jP
	E0J6I5WUMKFwI+hzGxCvo16shz5//sgVfk77EgJ7qfe64xiQ5fKTJQcy2632Uj6FY/TRCYu3UbV
	3
X-Google-Smtp-Source: AGHT+IGEAdTxQJ9jkgBSTp9ntWqgSyAT1MJSRdXkHsyxO6DKYb5+FoEQ9nsLjFYX//O7igTaKAWTqQ==
X-Received: by 2002:a05:6358:e49e:b0:1bc:7c89:6018 with SMTP id e5c5f4694b2df-1c2b7f81663mr419801455d.9.1728397400089;
        Tue, 08 Oct 2024 07:23:20 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7afcb6c6a8csm40321085a.118.2024.10.08.07.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:23:18 -0700 (PDT)
Date: Tue, 8 Oct 2024 10:23:13 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, surenb@google.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] sched: Fix cgroup irq accounting for
 CONFIG_IRQ_TIME_ACCOUNTING
Message-ID: <20241008142129.GB6937@cmpxchg.org>
References: <20241008061951.3980-1-laoar.shao@gmail.com>
 <20241008061951.3980-5-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008061951.3980-5-laoar.shao@gmail.com>

On Tue, Oct 08, 2024 at 02:19:51PM +0800, Yafang Shao wrote:
> @@ -5587,7 +5587,24 @@ void sched_tick(void)
>  	rq_lock(rq, &rf);
>  
>  	curr = rq->curr;
> -	psi_account_irqtime(rq, curr, NULL);
> +
> +#ifdef CONFIG_IRQ_TIME_ACCOUNTING
> +	if (static_branch_likely(&sched_clock_irqtime)) {
> +		u64 now, irq;
> +		s64 delta;
> +
> +		now = cpu_clock(cpu);
> +		irq = irq_time_read(cpu);
> +		delta = (s64)(irq - rq->psi_irq_time);
> +		if (delta > 0) {
> +			rq->psi_irq_time = irq;
> +			psi_account_irqtime(rq, curr, NULL, now, delta);
> +			cgroup_account_cputime(curr, delta);
> +			/* We account both softirq and irq into softirq */
> +			cgroup_account_cputime_field(curr, CPUTIME_SOFTIRQ, delta);
> +		}
> +	}
> +#endif
>  
>  	update_rq_clock(rq);
>  	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
> @@ -6667,7 +6684,25 @@ static void __sched notrace __schedule(int sched_mode)
>  		++*switch_count;
>  
>  		migrate_disable_switch(rq, prev);
> -		psi_account_irqtime(rq, prev, next);
> +
> +#ifdef CONFIG_IRQ_TIME_ACCOUNTING
> +		if (static_branch_likely(&sched_clock_irqtime)) {
> +			u64 now, irq;
> +			s64 delta;
> +
> +			now = cpu_clock(cpu);
> +			irq = irq_time_read(cpu);
> +			delta = (s64)(irq - rq->psi_irq_time);
> +			if (delta > 0) {
> +				rq->psi_irq_time = irq;
> +				psi_account_irqtime(rq, prev, next, now, delta);
> +				cgroup_account_cputime(prev, delta);
> +				/* We account both softirq and irq into softirq */
> +				cgroup_account_cputime_field(prev, CPUTIME_SOFTIRQ, delta);
> +			}
> +		}
> +#endif

This should be inside its own function - to avoid duplication of
course, but also the ifdefs and overly detailed accounting code in the
middle of core scheduling logic.

#ifdef CONFIG_IRQ_TIME_ACCOUNTING
static void account_irqtime(struct rq *rq, ...)
{
	...
}
#else
static inline void account_irqtime(...) {}
#endif

