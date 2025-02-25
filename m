Return-Path: <linux-kernel+bounces-530932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2697BA43A43
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2899D188AEC8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC32262D1B;
	Tue, 25 Feb 2025 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZg5V0lo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDAB26156E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476913; cv=none; b=npdrlZc763xUOut3Aqz5rM3FbjE0GHM7gypyI6hL8MELy0bLyY7F4KC9MvUShwWTBsxvcXyPrT1iZY1f5HLdEYRB++v6hL6ZJSJMu8Q73d79yvgoNOlkb2Z1jgHsZzjZ4IM7MlAKRkDGHT9eOTSQTy+R7YGjLwSOVL9n8I+hsDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476913; c=relaxed/simple;
	bh=nGlvMoyzBTZDRXMl3c+sUlUWlnh5FHc2EHGicv360qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqSonSbsqkSwvc7Jq+sY6Q3p+ga8umo95H4MLW0EzQZwalbXK3Jq6JCIZNfXDizL4ASWdapQPO3Yn5QhUnyN0oZsGx6mZUZ70DYXkjl38Jow/tlY0glz+wlM4TRoIoaggZSxKVfnlqamwT0DzBnZRHbBK9eSjGz2Po7sLY187nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZg5V0lo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740476910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0682VwDrfrWl0p9aic376RslWqpGKhFnq7HFGON2EH0=;
	b=PZg5V0loYNIW+qM6MUp8tsWqs7GDfWJFSEyACoG5MkOKqrd+8wctfS8UzSVIU3lm5ZLOBg
	79nT///+yMEZR5qQ+yJGwzojUWbb9Xb7bAEFhxMoSt6xysJW8yMnjx3i726vYpZvVjOKrX
	y2F8taLG33WAwKSs5XuKpcRSCfX1XZc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-ztGJjNwtMIOdkwMvmujNtQ-1; Tue, 25 Feb 2025 04:48:28 -0500
X-MC-Unique: ztGJjNwtMIOdkwMvmujNtQ-1
X-Mimecast-MFC-AGG-ID: ztGJjNwtMIOdkwMvmujNtQ_1740476907
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43935e09897so37399735e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476907; x=1741081707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0682VwDrfrWl0p9aic376RslWqpGKhFnq7HFGON2EH0=;
        b=qrPtqVDwVgcRJztRZgMElG9FfpOWbYVfdammAnRRRoprjQ4ZLag/8/cVkkjFnD6It0
         wBPkhMCdGGXY+Gk1RNxn73iCKOP+4lcszGulmE3IRrFM70q3JoJXMaS0wVwMgYI02Kyo
         PB10UlRHA7LGmCHKI1SG6ndMt4Y5zWAzR6tbGGycFNkqDdIESdVcD78VQFiY5MJoKT8q
         8JVSuhXN2q4UnRjNNZBngL6VoaZpR7Yuq6K2l3FEdFckeAN1o2lD//NTbH2FMG1r3KPv
         yEGiRDdLXbGzA6EqGRSl2dgbb96qbDlQ7EywFcyFqtoWd00aJ+kaG7MkFQYDLpem5HnM
         sfwg==
X-Forwarded-Encrypted: i=1; AJvYcCW49m11E11ZLLQv4CgafTYeMzYBqR4rx25CgVvT052jMmaG/kDXenLYok6xEduFzE8NTcFDqXWCgLvLSNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsasbRCQX28JGF6xxPfB1nijOcb00PGp5iLRfErusPlw0JWLNs
	L9+4bBrTTYgR0hSv6wWlSv15lYPikDGGb0ozNISFCSpf+OGBczIqRmlFroncYxKNunZuRUzqmqU
	6UpRPm/ddRkTWCkNLKGFe60vitPrgY+IWklo/x9KaP/4kGb4PjVo9YZwY+Xmwsw==
X-Gm-Gg: ASbGncu2f0b+Olaj+IqA5plpTNtUTc/i9mZtRdb7YnmqcW7PQKYTrTieLabNGV5sI6i
	1hIUV3cPiahMuj/2Xrr5dwwpeI4/DJIQFj8ReQwy43IWwcc7W+YYeXvUa1DSv+IqmD2bxRuTVUJ
	eCtxri8tMfIia6yJLIhpDKB6oLBv+J0Mufjz9MRKoykuZUQWsj98hoHsVS1PAT536vOouv+CGhi
	Oc/i9kYhVpWyZYPieCm1ClltBQ1Ojzn5yXmWFQS4roh+2nduuJ1ENa6LDEPNqFhsmtmwqEeCG9Y
	Wpue6HsHxM+h0yxOV6ELeln4x/VHXFMuTitEXpK6x0o0
X-Received: by 2002:a05:600c:4686:b0:439:8c6d:7ad9 with SMTP id 5b1f17b1804b1-439ae225a53mr147040155e9.31.1740476906816;
        Tue, 25 Feb 2025 01:48:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6KgXf9mu9XV5XIx/bzsC4rdve5WG9ngEo3WrqVFcizZhbRqC2DByd0rmzNqluKUQCmvTvDA==
X-Received: by 2002:a05:600c:4686:b0:439:8c6d:7ad9 with SMTP id 5b1f17b1804b1-439ae225a53mr147039685e9.31.1740476906457;
        Tue, 25 Feb 2025 01:48:26 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.7.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b01346d1sm136419845e9.0.2025.02.25.01.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:48:25 -0800 (PST)
Date: Tue, 25 Feb 2025 10:48:23 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Thierry Reding <treding@nvidia.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
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
Message-ID: <Z72R5-I91l5FOJK6@jlelli-thinkpadt14gen4.remote.csb>
References: <Z7WsRvsVCWu_By1c@jlelli-thinkpadt14gen4.remote.csb>
 <4c045707-6f5a-44fd-b2d1-3ad13c2b11ba@arm.com>
 <537f2207-b46b-4a5e-884c-d6b42f56cb02@arm.com>
 <Z7cGrlXp97y_OOfY@jlelli-thinkpadt14gen4.remote.csb>
 <Z7dJe7XfG0e6ECwr@jlelli-thinkpadt14gen4.remote.csb>
 <1c75682e-a720-4bd0-8bcc-5443b598457f@nvidia.com>
 <d5162d16-e9fd-408f-9bc5-68748e4b1f87@arm.com>
 <9db07657-0d87-43fc-a927-702ae7fd14c7@arm.com>
 <Z7x8Jnb4eMrnlOa8@jlelli-thinkpadt14gen4.remote.csb>
 <4aa1de5c-4817-4117-b944-4b4c8f09ac40@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aa1de5c-4817-4117-b944-4b4c8f09ac40@nvidia.com>

Hi Jon,

On 24/02/25 23:39, Jon Hunter wrote:
> Hi Juri,
> 
> On 24/02/2025 14:03, Juri Lelli wrote:
> > On 24/02/25 14:53, Dietmar Eggemann wrote:

...

> > > So DL accounting in partition_and_rebuild_sched_domains() and
> > > partition_sched_domains()!
> > 
> > Yeah that's the gist of it. Wait for domains to be stable and recompute
> > everything.
> > 
> > Thanks for testing. Let's see if Jon can also report good news.
> 
> 
> Sorry for the delay. Yes this is working for me too! If you have an official
> patch to fix this, then I can give it a test on my side.

Good! Thanks for testing and confirming it works for you now.

I will be cleaning up the changes and send them out separately.

Best,
Juri


