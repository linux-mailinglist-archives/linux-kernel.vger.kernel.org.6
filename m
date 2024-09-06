Return-Path: <linux-kernel+bounces-318276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2D596EB01
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146D0285B19
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09F513B590;
	Fri,  6 Sep 2024 06:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J1etErN7"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538DC12C475
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 06:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605489; cv=none; b=kqNtI7kRgvbzE+pMSX0vgExxzPcge/M+g+7IvMkcvR5HcKCR6doPmwNY+fvhUujedTkodzNxP4p5Wfi0vsMXKQwZoIHo2W5PG9ZAQGqEC0Ow84RIU7p0rz9iLUpU/I4/V0MvFhUkrnl1YqKZbxzSiPwKAvVflLe8F3vaS1tTfz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605489; c=relaxed/simple;
	bh=Pecr8WNcW0eNzVqrMuK1IDJVqXPklyBCCPVr9ywYEcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnESJjxXQQ6VHIvZptQhgGsqTRsrjItRQDbddgJSm+aJOyPipboCYj+aCpI70ldfCAYkEj149iEjovJzH6VFWthLNck85/h5B6omKqG9uU7vvhlrKEvC+MUYm0HJufocwVU3g5AXN/2CdWiODal5CGvHnOSkujwok3MlEu6j88I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J1etErN7; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d5119d6fedso728397a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 23:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725605486; x=1726210286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HGs4J/C2FsNH6b2ZrDNc8NNPoNk/uKcv2JOY/O7tqL8=;
        b=J1etErN75Iu+DigPtdvljWycwXMpmNnofZ47fEku/9N+bpwcZc/hsWGX5YhpHZfg6p
         IhPgOIde3VH43pHJu5vMzkQzOTNbRwtfrAyPydUNBAuGp4Xc0yb4RCf3B4LTanYN51Ff
         VAVRVsVAuQ/JngrlvSrz/J0LYkR++UTlJ/ukPhf+jbVqRNU3q0pAsuIx0nVAf1zNIvLo
         VyeUBwHh7lTS9QHzWjt4PVhlGtEismUNoftEV/k31yAPHjtU7uvEM7cbRru+TL74Mkek
         z0a0Wm8eXT3KypqCdGe4snZSMY7sScNJ+mQttUsOKX6xAi4051kS2caG1POdsGL+zfYO
         JbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725605486; x=1726210286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGs4J/C2FsNH6b2ZrDNc8NNPoNk/uKcv2JOY/O7tqL8=;
        b=mWODtDZ2LBgU4VegdTToBOgw+WDT4+RPwcoFoOlTBmGfVcpBOVD/K67gJ3jFhXu9zH
         6ts5lkLCCcsA9GVNkI385dr93TBHnAdjq17DloXWFs85hAiJKU77elol49XaZ482KQj8
         YaKMCobcw963vQKKOjfOK/bhSHZJJwL7bXLy7pPsc+/SIun2KVDaB4tuSwMZFf41ad9Q
         BEhWdJ8P+L/Sl5iesTFve2b3QfODIrBjzYs4u7rhLPPAm2GNXgb2kP0eMLQ/PBSIDKIg
         McflkCRJfNyk5vzisol1pMffWYpjK1JQQ4N0OT/DWQVAcrN+4LbjH6eN5S22Yn7uHA1K
         22wA==
X-Forwarded-Encrypted: i=1; AJvYcCU9PmVG66HeRObgI3LPfdD6ssoXoDSWaQ2J2TXvzRSOfyw7PyWXe0Tyf1A/po9CCW0up5supA/IGoRhY1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6dn9/P5lDvQ8cd9DyMjtd1rlOQQLR89etc+vIm2CzgLPR562x
	5Msh3awHpFWOji9qccdhIpfZ62njbqzz3DGvpaXJhd6cn/HVZIpE+wQhlok0bBnXVTwI+qFVXaL
	orom4DnDFMOePLauDdjqEz2OY7ZtTdextseXEBw==
X-Google-Smtp-Source: AGHT+IFN8ldfwrXs3NCPIafvXSdW7e0E9mQT2lNDBEFXw4EaQc2eMsymIjQ5hKRKWUVc1Qi8HlwsJbIAISP989ptvro=
X-Received: by 2002:a17:90b:3881:b0:2c9:5a71:1500 with SMTP id
 98e67ed59e1d1-2dad4bfb4c2mr3120395a91.0.1725605486239; Thu, 05 Sep 2024
 23:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-2-vincent.guittot@linaro.org> <a499b2f6-eac3-4c15-bca6-001a724225ff@arm.com>
In-Reply-To: <a499b2f6-eac3-4c15-bca6-001a724225ff@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 6 Sep 2024 08:51:13 +0200
Message-ID: <CAKfTPtCaQkzGZdfi_-yoYmYY-49ZD7+nWfrbETryJKg=K-JB3w@mail.gmail.com>
Subject: Re: [PATCH 1/5] sched/fair: Filter false overloaded_group case for EAS
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com, 
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 11:01, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>
> On 30/08/2024 14:03, Vincent Guittot wrote:
> > With EAS, a group should be set overloaded if at least 1 CPU in the group
> > is overutilized bit it can happen that a CPU is fully utilized by tasks
> > because of clamping the compute capacity of the CPU. In such case, the CPU
> > is not overutilized and as a result should not be set overloaded as well.
> >
> > group_overloaded being a higher priority than group_misfit, such group can
> > be selected as the busiest group instead of a group with a mistfit task
> > and prevents load_balance to select the CPU with the misfit task to pull
> > the latter on a fitting CPU.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   kernel/sched/fair.c | 12 +++++++++++-
> >   1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index fea057b311f6..e67d6029b269 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9806,6 +9806,7 @@ struct sg_lb_stats {
> >       enum group_type group_type;
> >       unsigned int group_asym_packing;        /* Tasks should be moved to preferred CPU */
> >       unsigned int group_smt_balance;         /* Task on busy SMT be moved */
> > +     unsigned long group_overutilized;       /* No CPU is overutilized in the group */
>
> Does this have to be unsigned long? I think a shorter width like bool
> (or int to be consistent with other fields) expresses the intention.

yes an unsigned int is enough

>
> Also the comment to me is a bit confusing. All other fields are positive
> but this one's comment is in a negative tone.

Coming from the 1st way I implemented it but then I forgot to update
the comment. Should be:
/* At least one CPU is overutilized in the group */

>
> >       unsigned long group_misfit_task_load;   /* A CPU has a task too big for its capacity */
> >   #ifdef CONFIG_NUMA_BALANCING
> >       unsigned int nr_numa_running;
> > @@ -10039,6 +10040,13 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
> >   static inline bool
> >   group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
> >   {
> > +     /*
> > +      * With EAS and uclamp, 1 CPU in the group must be overutilized to
> > +      * consider the group overloaded.
> > +      */
> > +     if (sched_energy_enabled() && !sgs->group_overutilized)
> > +             return false;
> > +
> >       if (sgs->sum_nr_running <= sgs->group_weight)
> >               return false;
> >
> > @@ -10252,8 +10260,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >               if (nr_running > 1)
> >                       *sg_overloaded = 1;
> >
> > -             if (cpu_overutilized(i))
> > +             if (cpu_overutilized(i)) {
> >                       *sg_overutilized = 1;
> > +                     sgs->group_overutilized = 1;
> > +             }
> >
> >   #ifdef CONFIG_NUMA_BALANCING
> >               sgs->nr_numa_running += rq->nr_numa_running;

