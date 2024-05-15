Return-Path: <linux-kernel+bounces-179768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BF58C6509
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EAE22847B5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E625F47D;
	Wed, 15 May 2024 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="P8M3cF3l"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E10C3EA7B
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715769707; cv=none; b=tUzmZmyKC/h9fmAPvvSnLPo4HikjMS84mBaJjrR/PmAuyfh1dnJvPCMJhVAVTXBeSg8SFO0k7XVM/FAFnKKLEIhoeLkmHBSjY2Rwrv9f9OHuN5lLUv93em/QzZq8l/ujJKKcHixhfl6ZSpqwW5FHxSw/1WaKK7vN2HD9QsMZArs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715769707; c=relaxed/simple;
	bh=a9wkHhUJWVV3yQtuVqY+qJwF3/obOofzKdDuefLnj08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8Uc0Uo+5QQJvHJZV0FNMZP1nZE8WXx5v5ThHzX1waDABr/Jon/Rj6v4NSb1DVp0rBnS6UdF37ImoR81ul3UeTJ0b/9iuTD68hxAa+A+9TPYnDSIr/QzNuZ6h31zENKbV8mrn2zYsxPWybHkbPFqZBrglxvLS97+iQw/UQSjTbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=P8M3cF3l; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34eb52bfca3so5759925f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 03:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1715769704; x=1716374504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/+NRR3+IfqH/kpAJB4exa1cThZV0WhydAmUFhF/U9iw=;
        b=P8M3cF3lbz3dtak4hGTFatV5TdyMRghfR1GYhU4ILsySdqBdXMQ1mGdikbWTGMh8zF
         nnvbbBNVLWDZnC8EgQZ1a5Doj/MyD0tNu9UT65IVO8OmahEgcIx5bjvXp/1GvqSxErQI
         aAhEttS82VWEx3957b3Q2pwt4x+6KLmbMVAmU3mQv8G+J4SS6KKCg1lM2+FjD02VFyMo
         PFHM1RahEmbw07GyvWV90d6NKSJko8wlli+WA4qH9mcI3G+zH+I6hbj4oGoMQlNa8QdB
         3ji11u26az7HnROEZRdFZiLcFtV1mR/Z1aKJcrpvE5FHLtIza78OqlFpfDGjcmukHIQB
         t6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715769704; x=1716374504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+NRR3+IfqH/kpAJB4exa1cThZV0WhydAmUFhF/U9iw=;
        b=lL3xfy0W8mJKrD2xJ89p5ILznYuc8SooE1sp8e0ij4nEgbc/cpUoGYfhYuMg8YGNAd
         0HgzZLf2qwHir0O4QGW4HDEVdFfM5bFhlTNK7OJ1mfbgTUzytqOrno/fi653pHKTXJpu
         k7PPhqEBc6ZsFIkeb45IxYgUevNrKvEptpqMO/KQjCmGjPKoEiWYH/o19z7Jg9QVmAel
         ij61WxrwRE63reEUeQSJNzhMJtGlQm0E7e0RIvg39il5yVSgAC6tXvalQh/8cs7YRn27
         7+l2rCoj1XA68n4Sqr9bwhNDp3uOLWrhr+m1THByKaESLSK28Vj7TR4KIE2GbtG1YETf
         WQrA==
X-Forwarded-Encrypted: i=1; AJvYcCWBW9uub1Ctt91dmi2Ki1OkuNWUkEaINd6S4LV3RDRMNRWtP9AV6WmBPE29wPXhWCS7JDKeWBs1CZpzFrs5GoCXtFJJrRryZbXk9k+C
X-Gm-Message-State: AOJu0YwY/KYT7as+m5vckab3MkhV9bdbGbHnC46uZSkbdc6HeuDPMxQu
	sR5vwkSvXVzes/xH7znywOrZS46Sq+6bCobMbxY75XZR0WuQLyYliJDhxpe4AHM=
X-Google-Smtp-Source: AGHT+IFaM9VRyR4FThs7fOUSqSs0WiDCGUmBOz64cLyxF8dyICs+/P/LhXL9OS3JDrblbXiB5eAXfw==
X-Received: by 2002:a5d:444b:0:b0:34f:41e7:eb37 with SMTP id ffacd0b85a97d-3504a73dec5mr13993514f8f.30.1715769703749;
        Wed, 15 May 2024 03:41:43 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b897985sm16099225f8f.44.2024.05.15.03.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 03:41:43 -0700 (PDT)
Date: Wed, 15 May 2024 11:41:42 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched: Consolidate cpufreq updates
Message-ID: <20240515104142.5ixmhzaomva2a2u7@airbuntu>
References: <20240512190018.531820-1-qyousef@layalina.io>
 <9e845146-8a31-407c-a5ee-e2e32f1655e5@arm.com>
 <20240513220903.no2j6zl4tk7lr6um@airbuntu>
 <09717ad7-2a4b-486c-a4f5-e3f09a212add@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09717ad7-2a4b-486c-a4f5-e3f09a212add@arm.com>

On 05/15/24 12:00, Dietmar Eggemann wrote:
> On 14/05/2024 00:09, Qais Yousef wrote:
> > On 05/13/24 14:43, Dietmar Eggemann wrote:
> >> On 12/05/2024 21:00, Qais Yousef wrote:
> >>
> >> [...]
> >>
> >>> @@ -4682,7 +4659,7 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >>>  
> >>>  	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
> >>>  
> >>> -	cfs_rq_util_change(cfs_rq, 0);
> >>> +	cpufreq_update_util(rq_of(cfs_rq), 0);
> >>
> >> Isn't this slighlty different now?
> >>
> >> before:
> >>
> >>    if (&rq->cfs == cfs_rq) {
> >>        cpufreq_update_util(rq, ....)
> >>    }
> >>
> >> now:
> >>
> >>    cpufreq_update_util(rq_of(cfs_rq), ...)
> >>
> >> You should get way more updates from attach/detach now.
> > 
> > Yes, well spotted!
> > 
> > Looking at the path more closely, I can see this is called from
> > enqueue_task_fair() path when a task migrates to new CPU. And when
> > attach_task_cfs_rq() which is called when we switch_to_fair(), which I already
> > cover in the policy change for the RUNNING task, or when
> > task_change_group_fair() which what I originally understood Vincent was
> > referring to. I moved the update to this function after the detach/attach
> > operations with better guards to avoid unnecessary update.
> 
> Yeah, all !root cfs_rq attach or detach wouldn't change anything since
> the util_avg wouldn't have propagated to the root cfs_rq yet. So
> sugov_get_util() wouldn't see a difference.
> 
> Yes, enqueue_entity() sets DO_ATTACH unconditionally.
> 
> And dequeue_entity() sets DO_DETACH for a migrating (!wakeup migrating)
> task.
> 
> For a wakeup migrating task we have remove_entity_load_avg() but this
> can't remove util_avg from the cfs_rq. This is deferred to
> update_cfs_rq_load_avg() in update_load_avg() or __update_blocked_fair().
> 
> And switched_{to,from}_fair() (check_class_changed()) and
> task_change_group_fair() are the other 2 users of
> {attach,detach}_entity_load_avg(). (plus online_fair_sched_group() for
> attach).
> 
> > I understood this will lead to big change and better apply immediately vs
> > wait for the next context switch. But I'll ask the question again, can we drop
> > this and defer to context switch?
> 
> Hard to say really, probably we can. All benchmarks with score numbers
> will create plenty of context switches so you wont see a diff. And for
> more lighter testcases you would have to study the differences in trace
> files and reason about the implications of potentially kick CPUfreq a
> little bit later.

I lean to drop this and let the CPU state considered to be 'settled' on next
context switch.

But I'll wait to hear more opinions before I post a new version.

Thanks!

