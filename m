Return-Path: <linux-kernel+bounces-177366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68A68C3D90
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05EF91C2113A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C101482F8;
	Mon, 13 May 2024 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xrMTWOPD"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53131146A60
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590236; cv=none; b=dBrRCB/HbJGU1wNp9HSjBEnM3zto/9Utq17V1DVIeCkFeWzLo+ugfOqQ1niYhTjEUeqsNwaoMCreOlRdLFtcnNd8mEJRBW2No6U8Up6idRZDnnT/9TDKBz1NkX/iITQ8/AsZufJkHtxtEl78/BGbHSe5+7j2Q8xLV3w2aYvu2rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590236; c=relaxed/simple;
	bh=t2CpuG2/kXnCeTE/h8lPr+FMfqwXNQ5Ys+9794rjXJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDbuYPzSr3td+2MQ+iNtI/O4jy25JDZnUz/jy81CkpQVYE0OzccctGL//3y5PmRvdfx9F1BjKcjXaPnTzy3cuH8r0Ub1EHZYPBTwA7RiTc9nAsM6MkSpLwLWZQ7J64+r1jJ3m9p7AP1sBNjT11gnOzVqziJDH/JJYVeSs7iwFro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xrMTWOPD; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78f049ddd7dso328975285a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 01:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715590233; x=1716195033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q7++kW2Cm2K1g7q3S48vKWO4QTE6hzmFVZfJMpS2VOE=;
        b=xrMTWOPD/nGYN6oAofxf1WL+q0jIplyPEYwzxkM8gvbe0Qjy3BWHT4YQ5OWda7WY89
         Xoyf/ZZ+tvpi1YwCbTyTdOoJKgqGNQhuO+0RF10norYt+5l59K/IVjl1K3nuoYEs1SjB
         zNUcYve7NhdvCUeenKU9hYk4DpaDWgjUPjbEzPBDWq3ieichMQg5x5rXjAIn6sFZ0iri
         DVRjwIABIitkXBo83SnWKQQ+0CZd5SMzDyYfi0kGj1vnUH4EJGNsGi9DRpl/TosQzFFB
         ght3RB7Bqo2AESl+Yx8FkDoC4e+p+tIZ3OeBvj6MKZVeYPR9fpGuXRIk8/gVmXYlQ31e
         Xydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715590233; x=1716195033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7++kW2Cm2K1g7q3S48vKWO4QTE6hzmFVZfJMpS2VOE=;
        b=fgh8qiaF1wCPFVffJF/l0gzzpQbrBHPs2n/uB+VdVMuhSfid4ANS3yUd1A9WxUJDPT
         EC+GcgpcA9ZAGRMPfwcFuVDj4dyl0xnuH8oqveUba7sWq22bUZBwEcCI0u3436zlAur6
         sd7GF0UdkotQEKLSUuOoQsOSrzbyHz9wUS+B35srxW/5MyEhXNrgxsYy+cFCrtGMB2N5
         k6UM5w0vs17HOmjsDJmz9ibLtx/nJ8bGYF47IroVdia7GIEMiyzYZxqMzVEC4z2k1LPb
         NSfYEmg9fRO6OL1r4H/oAu1bb6ZNd/LZa6/2ZdG6QgvB/2lGOYVCNjwzDCmu+JLy6dlZ
         +GlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUraDvT966wSmygryAp/YosqZMsXBvN13T0AYL1vY5vqbdaHn+YJuo+uVWPRgORtrY8vvUkQjh3B3PltDMtWo9qFNT/nXz25bhVCJ1E
X-Gm-Message-State: AOJu0Yx4xG2dXbDAP+CuFTwAXC46wH3nAuVcQD6EqOhKHSzd1kIt2wkN
	Q+Ikm3IeuylxAcmxt0Uw76MulvQDrJgJiEeaLg1Uosd0Ak1RmBHZc/fK315K/PnArGOEGhC9LjC
	J65e3OFKP9Ut603Ks62jqB5KyjdfYnyKiFl6ajA==
X-Google-Smtp-Source: AGHT+IF0Vv5wfCSDrAajeXEdHfFjYzk73OIgqIT9Tf6OHm+deGoTKaxKl7QrCK4aOkONq6C5mZzP/vrdPcnxOA4XBEw=
X-Received: by 2002:a05:620a:4085:b0:792:c3a3:ba3b with SMTP id
 af79cd13be357-792c75779aamr1186274785a.10.1715590233169; Mon, 13 May 2024
 01:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505233103.168766-1-qyousef@layalina.io> <CAKfTPtDvBAFauUfyWZhYRUz6f42iMAJcwcdDDQh+V8+QfDwc2Q@mail.gmail.com>
 <20240507110809.a45amdmhy5vr5cuw@airbuntu> <CAKfTPtDHWBKfksW4jQJ3KZVb7_GDXLZB1F7auYVZE1ddyDpgYQ@mail.gmail.com>
 <20240511020303.c27wr52eqflft2o3@airbuntu>
In-Reply-To: <20240511020303.c27wr52eqflft2o3@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 13 May 2024 10:50:21 +0200
Message-ID: <CAKfTPtAaxGrHjQyikJdrROA3qdwp08R-b6k0zo=u146emeBncg@mail.gmail.com>
Subject: Re: [PATCH v2] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 May 2024 at 04:03, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 05/07/24 14:53, Vincent Guittot wrote:
>
> > No I mean going out of idle. On an idle cpu, nothing happens at CFS
> > task wakeup and we have to wait for the next tick to apply the new
> > freq. This happens for both short task with uclamp min or long
> > running/sleeping task (i.e. with high util_est)
>
> I think I found the problem, thanks for catching it!

Ok I will test it when I will be back and have access to the board

>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cbe79c8ac2ed..dea9383a906e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4714,7 +4714,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>         if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
>                 __update_load_avg_se(now, cfs_rq, se);
>
> -       cfs_rq->decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> +       cfs_rq->decayed |= update_cfs_rq_load_avg(now, cfs_rq);
>         cfs_rq->decayed |= propagate_entity_load_avg(se);
>
>         if (!se->avg.last_update_time && (flags & DO_ATTACH)) {

