Return-Path: <linux-kernel+bounces-239681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 513D09263E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72BA1F21FFC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9282B17BB39;
	Wed,  3 Jul 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCbRf+If"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475CC1DA319
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018502; cv=none; b=OjBf4ajanUHN3IBp20UqQ9p3JLZV6r33cK0sWZopDXzsqRmMeKANYhk3ewLBwKBxdKFPM5Bu1eVJqpJKLLBkigRVma34yGC82OieXltpT1HBND1UimK5p6jK1J4BXcPKJJFkqwBZLxYNg0FaVstKCsJ6OqVI/psy3xto/QTzIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018502; c=relaxed/simple;
	bh=snDQDDyLA00EBLFqmDZtu42ZDwCdtxV8FFojaJwQJeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhImw7Dm1jlr8udKkhjwAAeFlKq+WkYchQ6bk8stGGBSKiMSndN8hdN63Ql1OgmPDacblBRMZk0hbQo+SQacCjWyWRIvmkHAceGXxZIW5+9x3e3zcwZUwnL0kpe+nOkXxRk3+mQ7QVCAPVQRD5mXY/wZ1pUqD5n7VlullXyIWiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gCbRf+If; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7066c799382so4603330b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720018500; x=1720623300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CJra/hwZ4zcRXGF8MC6VA/thedkR4ig6VKv4A5Elx4s=;
        b=gCbRf+IfChDFpcuxNGlyMqKtQrtj1LUkOHHFoy0/qFXSmfZQ2QyjG/zY0+omQ9gA05
         RRqdpvIRwvaM0fVka5sbTVZMfe1Z3J20n2azQQBKQ8x+zTdqogajrfmRrfbItDOIadZ0
         fVq0VmCW67Pg4VBJwDHOOEnCJc8u9LsYz42CcB6V9cnJl/CZUUnbB4hJyxOel8yk8sTY
         uzGHJnb6pJlx//jymGVspoWYZSuvpSWwmxI+MR1pvUfKPv5hqegF2Afm/OXBCv9jur6U
         cl/aoEN+okbHjYoAGKhqM1lzZIPbJmZYssgKUwWkpNTjjjRQ76gzXb5f9Wy8EKe+XT1M
         oekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720018500; x=1720623300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJra/hwZ4zcRXGF8MC6VA/thedkR4ig6VKv4A5Elx4s=;
        b=dmr0AetTFb8F3MiBVfnyNtXw6PpXXFBPB0/ngX4s4OqeuysH51EgzuiXa1m9hAN+Zb
         gZS5aKxK7CiYgztpTSUOj9GBNk1Z8fyvn5kNR9CmPKRRC0mOrbKHcI+QTDQqSiOTIp6Z
         unj/QYMLv1jEGj54JxiF+O+/k3JpjeLmmL4xyAqxZ7xhj8nx+g80FbMRJZ4hjGNsx4h1
         8O42vS0wcEnacW30neFdKYZpf1+qKC0B0Ysbvbk+G2sA4tOykun+b0UEFYITFOEJ24vh
         rY7BumHxWWK2O0ttka8kYXYm7dztesML+OVmxV7V4UjFyG2xSfLB/5Sj7zYHTtWwc2i+
         RSTA==
X-Forwarded-Encrypted: i=1; AJvYcCW6TUNdOTm18ApMpanEYVDMV/5a+LAEOJUj9ZV4IBoS9I7V5g2DIKTTsLlfAK60PDfzYU2/9OfbZDiszUgaKx2eRR9F/XiEcGPJy8Hi
X-Gm-Message-State: AOJu0Yz+8wA3y+88U+skS01OFV7/+H+fK8qXzKvBW5vXi8AHrePIvgUN
	T9xh5TDFpLo5BaTIJv7ri15sbYTN7mz6UypFJVn18/OBoPKKdBktfTE8YwaEg2XfvoUKwuhz1YT
	RTGOEr4H/zNdaRGI6Yt91oMQvNzHqNR33TRxvUA==
X-Google-Smtp-Source: AGHT+IF5DrWqR54rMlVhGn9iJTMK8TJZJpWVDW7F9HCl+FEPivRxR+MxR5vkOxV020W4XrKZPHjjxW1kOR10PedlLpo=
X-Received: by 2002:a05:6a00:230c:b0:704:2f65:4996 with SMTP id
 d2e1a72fcca58-70aaad3b5c9mr14365683b3a.11.1720018500452; Wed, 03 Jul 2024
 07:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624082011.4990-1-xuewen.yan@unisoc.com> <20240624082011.4990-3-xuewen.yan@unisoc.com>
 <20240628012832.37swdtxr4ds2kkp7@airbuntu> <CAKfTPtALDtnbPmq4401oLKzcEDurLKuCyqyNKOb1oYLAVJ2P4A@mail.gmail.com>
 <20240703115407.y6tjelkpq5njkzjy@airbuntu>
In-Reply-To: <20240703115407.y6tjelkpq5njkzjy@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 3 Jul 2024 16:54:48 +0200
Message-ID: <CAKfTPtCNEa+pAbo1br_1SDSn8=x67YMCi_jytpjUMHv7a9xMKA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] sched/fair: Use actual_cpu_capacity everywhere in util_fits_cpu()
To: Qais Yousef <qyousef@layalina.io>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	christian.loehle@arm.com, vincent.donnefort@arm.com, ke.wang@unisoc.com, 
	di.shen@unisoc.com, xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 13:54, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 07/02/24 15:25, Vincent Guittot wrote:
>
> > > >        *
> > > >        * Only exception is for HW or cpufreq pressure since it has a direct impact
> > > >        * on available OPP of the system.
> > > > @@ -5011,7 +5011,7 @@ static inline int util_fits_cpu(unsigned long util,
> > > >        * For uclamp_max, we can tolerate a drop in performance level as the
> > > >        * goal is to cap the task. So it's okay if it's getting less.
> > > >        */
> > > > -     capacity_orig = arch_scale_cpu_capacity(cpu);
> > > > +     capacity_actual = get_actual_cpu_capacity(cpu);
> > > >
> > > >       /*
> > > >        * We want to force a task to fit a cpu as implied by uclamp_max.
> > > > @@ -5039,7 +5039,7 @@ static inline int util_fits_cpu(unsigned long util,
> > > >        *     uclamp_max request.
> > > >        *
> > > >        *   which is what we're enforcing here. A task always fits if
> > > > -      *   uclamp_max <= capacity_orig. But when uclamp_max > capacity_orig,
> > > > +      *   uclamp_max <= capacity_actual. But when uclamp_max > capacity_actual,
> > > >        *   the normal upmigration rules should withhold still.
> > > >        *
> > > >        *   Only exception is when we are on max capacity, then we need to be
> > > > @@ -5050,8 +5050,8 @@ static inline int util_fits_cpu(unsigned long util,
> > > >        *     2. The system is being saturated when we're operating near
> > > >        *        max capacity, it doesn't make sense to block overutilized.
> > > >        */
> > > > -     uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> > > > -     uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> > > > +     uclamp_max_fits = (capacity_actual == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> > >
> > > We should use capacity_orig here. We are checking if the CPU is the max
> > > capacity CPU.
> >
> > I was also wondering what would be the best choice there. If we
> > consider that we have only one performance domain with all max
> > capacity cpus then I agree that we should keep capacity_orig as we
> > can't find a better cpu that would fit. But is it always true that all
> > max cpu are tied to the same perf domain ?
>
> Hmm I could be not thinking straight today. But the purpose of this check is to
> ensure overutilized can trigger for the common case where a task will always
> fit the max capacity cpu (whether it's on a single pd or multiple ones). For
> that corner case fits_capacity() should be the only fitness check otherwise
> overutilized will never trigger by default.

Ok, so I messed up several use cases but in fact both are similar ...

if capacity_actual != SCHED_CAPACITY_SCALE and uclamp_max ==
SCHED_CAPACITY_SCALE
then uclamp_max_fits = (capacity_actual == SCHED_CAPACITY_SCALE) &&
(uclamp_max == SCHED_CAPACITY_SCALE) is false
and uclamp_max_fits = !uclamp_max_fits && (uclamp_max <=
capacity_actual); is also false because (uclamp_max <=
capacity_actual) is always false

if capacity_actual == SCHED_CAPACITY_SCALE and uclamp_max ==
SCHED_CAPACITY_SCALE
then we are the same as with capacity_orig

