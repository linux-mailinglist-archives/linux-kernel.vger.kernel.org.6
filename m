Return-Path: <linux-kernel+bounces-530926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6385AA43A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A4D17B580
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4282641F6;
	Tue, 25 Feb 2025 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnF3y5kT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DCD2638B2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476827; cv=none; b=cD4xfVCJ0uCR4GNQodRX576+NjOFfc50lwZx7VAV3cajGmy2b3J1/uJYCA7Y+FTqVVHgTGo81vugorPUfT+TfN0c5RVoiuPzhmFni6vkzAGX2sqtO/JdCi7nlknGEy+AC4z1euwpa6OKZpbBH8mXFxCSeILGaXNfDeKOrpauE0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476827; c=relaxed/simple;
	bh=hpzWc/07P2v4g6KudoyyrwhPtSNsWhsK0U0s9XtiR+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTyGE9PKaviZqXY4t0kzW+H4v7HVxXXi0am+C0ZRSz4WznRFj0roo7V8Fac6Wa24SBcnVVf52aV9ENRWtWCj+Gr7suUucwYNq8TM3wvD3aHrxhqRkmAtDcAElDZdQUQF2ydlqiGfgdShwK6S5hnw0mPg9HvYFHCi9WPaOIRk5Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FnF3y5kT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740476824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ATdVageDUGCf4m2MKDFeKlLXMW2mrYHwQN8KjlpzpvU=;
	b=FnF3y5kT/maOhwZLW0qq8B4CeDuCb/0OnvKLPgC2DdYQ+UQhmeHPaI5HaB1B/ODPkOmA4B
	Te/dnx2jon40asPVJOuZ4DwB/85xXIg23QQfdwBo3S0DIGGeJnbUfxXbUIFgKR/ZL7qbfQ
	bn9pJ21QuA0ndGm2+KhwVLV3Kh8BXCU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-fn124-nkM5uDX7vEBqmhTA-1; Tue, 25 Feb 2025 04:47:02 -0500
X-MC-Unique: fn124-nkM5uDX7vEBqmhTA-1
X-Mimecast-MFC-AGG-ID: fn124-nkM5uDX7vEBqmhTA_1740476821
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f3bac2944so2385213f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476821; x=1741081621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATdVageDUGCf4m2MKDFeKlLXMW2mrYHwQN8KjlpzpvU=;
        b=jDexWaV4Z2ATns4XHqqyYXFSWZ7hUcZwykesLL5jjIYguDvG6WQXKDSxr6jf9siahm
         hM1a8ufCx9JpyIDFUtEHqj9Ysy6QhrsSnQeMLaHjWc9S5fNrHy1hLMxywsgofOv6np16
         5g8zR9tMQSldTK0xef/eu5Fh60pjX9kcKkVij8qdG22gAjBuzhyqRNmxQETOmX7oy09m
         uswLH27D0+ymyEmrYumMe3imhiIxQA7hDKIDSKuG5XeA3Rla4hPgfBCSVA7Sm4lIiLaU
         S/1mQH2Cw5exjrfIKSSw1bZTCj3fghymfIUWQp18hD++5RT4s9i8Vy0ESyRkvdtEiyLb
         W9rg==
X-Forwarded-Encrypted: i=1; AJvYcCXCINZ+5XhhcM99KLCPflHMVrmZe0I3p8N/pakNg5+BmlS3YnDvEFmX35vxgNbbICJ1fJy+eqQb9FHqCnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIOli09iQ1wYImOL+mwZppQLjks8l068Cnq1jS67jn5NdD1RUC
	DhQ0vGP8gvDkli72FWHnICHyKFzvrDUE5LVYcOUOoWD9mHyfphcoftdSIBNxmkECPgzyJsyWoV6
	39dP9P4WZTS2lMAglJ/lKslc6DHW1JVMuYTaHS3Fy9637/7aMRx68FQHvsipkNA==
X-Gm-Gg: ASbGnct90lxkpxaSp4iktAg25ei//Iam8SK6sDj/DqAt3mgtfYGHcLiTMZDFKgrmJt8
	Mgd+fyDqu6yMetXrvwWtIXevrZYiL+JAF8v1dHDMh5yTCG8xSkAyeHD1tWVFEZQnT4IqdcJux8o
	xxIViy9XINF0qU5yANKt1EqiD/cajgM+Oi1ZqzMysvPAWSWSG25CcfTYyRx3YoXx6tzI89VyyY4
	+8jycnVF/Wc94VMsLnz6UdT8RSGYBQ8h7IR7QUC/8VnCHVy9LzfxHphwFWq7zfo40kGr9GOocj/
	VA4IeSaG8i7T9Jxygcx55NohBu5JWSFEWSLO/x3x1Sov
X-Received: by 2002:a5d:6d8c:0:b0:38f:4acd:976d with SMTP id ffacd0b85a97d-38f6e7548d8mr14543724f8f.9.1740476821406;
        Tue, 25 Feb 2025 01:47:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjWkVxo4Tekgej/1fkI70u49bQKKn6X0w9GNSbdZFPVXuc19ytmMk7RncIRKSyrrCnqkg69g==
X-Received: by 2002:a5d:6d8c:0:b0:38f:4acd:976d with SMTP id ffacd0b85a97d-38f6e7548d8mr14543669f8f.9.1740476820998;
        Tue, 25 Feb 2025 01:47:00 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.7.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd866f6csm1721704f8f.14.2025.02.25.01.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:46:59 -0800 (PST)
Date: Tue, 25 Feb 2025 10:46:57 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Qais Yousef <qyousef@layalina.io>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
Message-ID: <Z72Rka_g1imcX5lt@jlelli-thinkpadt14gen4.remote.csb>
References: <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <285a43db-c36d-400e-8041-0566f089a482@arm.com>
 <Z62PPUOY5DClYo1A@jlelli-thinkpadt14gen4.remote.csb>
 <20250216163340.ttwddti5pzuynsj5@airbuntu>
 <Z7NNHmGgrEF666W_@jlelli-thinkpadt14gen4.remote.csb>
 <20250222235936.jmyrfacutheqt5a2@airbuntu>
 <Z7w7g1zb0nfu9-C7@jlelli-thinkpadt14gen4.remote.csb>
 <20250225000237.nsgbibqigl6nhhdu@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225000237.nsgbibqigl6nhhdu@airbuntu>

On 25/02/25 00:02, Qais Yousef wrote:
> On 02/24/25 10:27, Juri Lelli wrote:
> 
> > > Okay I see. The issue though is that for a DL system with power management
> > > features on that warrant to wake up a sugov thread to update the frequency is
> > > sort of half broken by design. I don't see the benefit over using RT in this
> > > case. But I appreciate I could be misguided. So take it easy on me if it is
> > > obviously wrong understanding :) I know in Android usage of DL has been
> > > difficult, but many systems ship with slow switch hardware.
> > > 
> > > How does DL handle the long softirqs from block and network layers by the way?
> > > This has been in a practice a problem for RT tasks so they should be to DL.
> > > sugov done in stopper should be handled similarly IMHO. I *think* it would be
> > > simpler to masquerade sugov thread as irq pressure.
> > 
> > Kind of a trick question :), as DL doesn't handle this kind of
> 
> :-)
> 
> > load/pressure explicitly. It is essentially agnostic about it. From a
> > system design point of view though, I would say that one should take
> > that into account and maybe convert sensible kthreads to DL, so that the
> > overall bandwidth can be explicitly evaluated. If one doesn't do that
> > probably a less sound approach is to treat anything not explicitly
> > scheduled by DL, but still required from a system perspective, as
> > overload and be more conservative when assigning bandwidth to DL tasks
> > (i.e. reduce the maximum amount of available bandwidth, so that the
> > system doesn't get saturated).
> 
> Maybe I didn't understand your initial answer properly. But what I got is that
> we set as DL to do what you just suggested of converting it kthread to DL to
> take its bandwidth into account. But we have been lying about bandwidth so far
> and it was ignored? (I saw early bailouts of SCHED_FLAG_SUGOV was set in
> bandwidth related operations)

Ignored as to have something 'that works'. :)

But, it's definitely far from being good.

> > > You can use the rate_limit_us as a potential guide for how much bandwidth sugov
> > > needs if moving it to another class really doesn't make sense instead?
> > 
> > Or maybe try to estimate/measure how much utilization sugov threads are
> > effectively using while running some kind of workload of interest and
> > use that as an indication for DL runtime/period.
> 
> I don't want to side track this thread. So maybe I should start a new thread to
> discuss this. You might have seen my other series on consolidating cpufreq
> updates. I'm not sure sugov can have a predictable period. Maybe runtime, but
> it could run repeatedly, or it could be quite for a long time.

Doesn't need to have a predictable period. Sporadic (activations are not
periodic) tasks work well with DEADLINE if one is able to come up with a
sensible bandwidth allocation for them. So for sugov (and other
kthreads) the system designer should be thinking about the amount of CPU
to give to each kthread (runtime/period) and the granularity of such
allocation (period).

> TBH I always though we use DL because it was the highest sched_class that is
> not a stopper.
> 
> Anyway. Happy to take this discussion into another thread if this is better.
> I didn't mean to distract from debugging the reported issue.

No worries! But, a separate thread might help to get more eyes on this,
I agree.

Best,
Juri


