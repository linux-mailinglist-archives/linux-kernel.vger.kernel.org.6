Return-Path: <linux-kernel+bounces-239403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DE5925F40
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53BF1F27E4F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A47F17164D;
	Wed,  3 Jul 2024 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="V6C9//Pa"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DB913D61B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007652; cv=none; b=BXR3LLT0+kOpY/Z+jcFBOTynuUENwz+Pmr0CGNUGD8YRFNUgJv/yl//PC7MU7XUtOZfJpA6q2f3ODnhFQjafJ6qPWtFmh+mxr/MokvUMsRy8AMWAQ3yE3/FcRcxBvZQt6gi5ZMbHAov9Gn+6CdtWOMIeN09pVtIjxIMss7FFVgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007652; c=relaxed/simple;
	bh=h1S2QC4xqEr68NWDQmaXFNegpal0bU94w8d1XyaS8sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqdF6cZwxvrkHtC54M1V+E9D8URnyZDT5nsZ51+i0I18SrEO2jkdipgpb6xIedda34jz41wUv/wBIwsSnyj4s+rfDVAAGl6EPVzeYJYj5sZ3QamXLcxgo9XRzYag9oQc4C3EVtK8b2DGJyzFXE/d6AEnPVp0s4SPD9Ga4ocXUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=V6C9//Pa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42574064b16so33929945e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 04:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1720007649; x=1720612449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/dKdrQWpBi8sNN8osFIvhbjM6ILY5kr5k1v9ROGIPU=;
        b=V6C9//PaL4d34ClaqkkOBFnVJA6p0OOyIw3qZLIMSxyFsi8jMywMwqv4ZS+RhMDzAn
         3nRZ2NC7VwsoIHx+wuCS2AueJ9Im24fD0BRcUxhQClZxQSbwM81ISXxejZfRUVY0Mv+y
         qvRQUnl+OQs+EUUam63SJR/+nJUjliVIC7CT1QMkO3CQRcCckv259p2YpOvhFgIddbBJ
         CESb+4o5/soC4/jel6H2B5AU7JtWMK55epj/ffXY2g62Vscrfa2Kc/xAIKZTTu66XqkM
         Eg5kXCaSpLNimE65c7wEecz5gXqR9gWnixB3Hepkw3nhTn2Ejvk02Lv6jddTjk6J0teP
         DT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720007649; x=1720612449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/dKdrQWpBi8sNN8osFIvhbjM6ILY5kr5k1v9ROGIPU=;
        b=SE4lz7cnZ76podPknGQwq9C1R62BxVkD82LS7SvVENCnwzqOEGH2FekHbj69oN4tca
         nDQYBQlZcXZiNlAbYyhmsv1NCJR80Unz2dnXTnxtbloPkx9FXudnJtIa1oaMM6YuYmbM
         GZCFKuVutLVF7p6NsahOa74WtP/HfzeWfR2dGkJ0ONtoYfgKeGzrqeYi4SneuMz1osnh
         Lj5OhpSREF8RKluc74bDWXrHZpRNjzPCnBMStlfaB4L296NBOTPHHUWPjpOro7iynW4I
         Y4tcSHwAxg5U1Cyf9drGfWNmiKT0uJGeOs7IQMoaP/RxnTl++Er9CWvaNS01zKk0Zqlj
         3J8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUevBsnGzoMP7v4FiJ0Sb9zrUtYv+y7Ek/GW7WxL8MexcTE6+WyLoSFedUZnP7RZHlEXtJ4KKUTeJdOuYKeAdYLR6bqkj6dbq5HfAjR
X-Gm-Message-State: AOJu0Yx7nfXJyXK/qdzHtsjvHXZ13CJWZa0HcS0NpPkzS+y8u7rCU+jt
	0V4wuL5tpi9pad5kjIqxyPOHT+wGEOk7mVGVB2P/7ln6llKxf4KfGGobnWscOjw=
X-Google-Smtp-Source: AGHT+IFt1tHV9WjwDQ4r4yGBCAWHvI3yCcMRx5Lk/4wU8pkkhtSCAhHCYrUR3fEp3K/O1euw3ZoLyw==
X-Received: by 2002:a05:600c:3541:b0:425:62f7:92ea with SMTP id 5b1f17b1804b1-4257a02f7c9mr74975865e9.14.1720007649185;
        Wed, 03 Jul 2024 04:54:09 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42577a06536sm75008455e9.0.2024.07.03.04.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 04:54:08 -0700 (PDT)
Date: Wed, 3 Jul 2024 12:54:07 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, christian.loehle@arm.com,
	vincent.donnefort@arm.com, ke.wang@unisoc.com, di.shen@unisoc.com,
	xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] sched/fair: Use actual_cpu_capacity everywhere in
 util_fits_cpu()
Message-ID: <20240703115407.y6tjelkpq5njkzjy@airbuntu>
References: <20240624082011.4990-1-xuewen.yan@unisoc.com>
 <20240624082011.4990-3-xuewen.yan@unisoc.com>
 <20240628012832.37swdtxr4ds2kkp7@airbuntu>
 <CAKfTPtALDtnbPmq4401oLKzcEDurLKuCyqyNKOb1oYLAVJ2P4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtALDtnbPmq4401oLKzcEDurLKuCyqyNKOb1oYLAVJ2P4A@mail.gmail.com>

On 07/02/24 15:25, Vincent Guittot wrote:

> > >        *
> > >        * Only exception is for HW or cpufreq pressure since it has a direct impact
> > >        * on available OPP of the system.
> > > @@ -5011,7 +5011,7 @@ static inline int util_fits_cpu(unsigned long util,
> > >        * For uclamp_max, we can tolerate a drop in performance level as the
> > >        * goal is to cap the task. So it's okay if it's getting less.
> > >        */
> > > -     capacity_orig = arch_scale_cpu_capacity(cpu);
> > > +     capacity_actual = get_actual_cpu_capacity(cpu);
> > >
> > >       /*
> > >        * We want to force a task to fit a cpu as implied by uclamp_max.
> > > @@ -5039,7 +5039,7 @@ static inline int util_fits_cpu(unsigned long util,
> > >        *     uclamp_max request.
> > >        *
> > >        *   which is what we're enforcing here. A task always fits if
> > > -      *   uclamp_max <= capacity_orig. But when uclamp_max > capacity_orig,
> > > +      *   uclamp_max <= capacity_actual. But when uclamp_max > capacity_actual,
> > >        *   the normal upmigration rules should withhold still.
> > >        *
> > >        *   Only exception is when we are on max capacity, then we need to be
> > > @@ -5050,8 +5050,8 @@ static inline int util_fits_cpu(unsigned long util,
> > >        *     2. The system is being saturated when we're operating near
> > >        *        max capacity, it doesn't make sense to block overutilized.
> > >        */
> > > -     uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> > > -     uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> > > +     uclamp_max_fits = (capacity_actual == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> >
> > We should use capacity_orig here. We are checking if the CPU is the max
> > capacity CPU.
> 
> I was also wondering what would be the best choice there. If we
> consider that we have only one performance domain with all max
> capacity cpus then I agree that we should keep capacity_orig as we
> can't find a better cpu that would fit. But is it always true that all
> max cpu are tied to the same perf domain ?

Hmm I could be not thinking straight today. But the purpose of this check is to
ensure overutilized can trigger for the common case where a task will always
fit the max capacity cpu (whether it's on a single pd or multiple ones). For
that corner case fits_capacity() should be the only fitness check otherwise
overutilized will never trigger by default.

