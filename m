Return-Path: <linux-kernel+bounces-542124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB17A4C5EB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE06616DA00
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B478912D758;
	Mon,  3 Mar 2025 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTUaTksp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FACA84A3E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017615; cv=none; b=V3yedkodJ1R2gQHDz8udIARmZOcBVnVImz48ibq0wBxyAguTZOoa8HCVjuPCfRoFKhlVffkyUGHbm2E1DbqWz5/zx4nl9wVQwFDu9MhOqM5z7FQ9KNjMVyqPkXRNM0ozzxOa1in5vpzpKvDD93ZM4MlHzGfJt/kPhWeHDTDcZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017615; c=relaxed/simple;
	bh=jFOF7k8K0bUwNF3eRcNy8u9EGvWjbUR67H+Rn8NM2ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhFo9DReIr0u7b34VGda4qzMl7UYRJy0h1kLgFYuxCKCGAzyrP6CDA1Hs9Ankl26jL3cxE9dqeVsghoVGHsm1PWjDHgae+XPWW2bXMw7HbdxQYxMZdHihkWDY4uiguJTFqSWn1deqzBHkD3EIJjvA1J/10eotJ6CVMJnYWY/zGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTUaTksp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741017612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DeMgwkEfJ4wko22XhtG7puIWAiqthft7+Cg2qc+WP50=;
	b=PTUaTksptWQtWv/X/3LpwolpEEwo/8LGF7gw+kPl+ZaPr9LMYjjntAncWHPhzwgOj+OJHN
	RtiiYVu4mBq2SoW8ogkiHsp6QZUC9/CO3lz4LN5SAnkeHg6oP/76kbReR3HUJITN6DEMkS
	dq4DhXvmu3gHocH9Nt3wNJx55P6BmJo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-YkbOGX_bN56a9kcK1P-suA-1; Mon, 03 Mar 2025 11:00:11 -0500
X-MC-Unique: YkbOGX_bN56a9kcK1P-suA-1
X-Mimecast-MFC-AGG-ID: YkbOGX_bN56a9kcK1P-suA_1741017610
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43bc1aa0673so5284115e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017610; x=1741622410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeMgwkEfJ4wko22XhtG7puIWAiqthft7+Cg2qc+WP50=;
        b=vndfz8H+f1iAzBZuCWy6gfvee7M39Sap/J6h8OwO9VyeW+q48KmRH0nM44ZoEmnXCV
         GQQ3Q/4jxrYRST1T0pn7atI5L/WMzHQZQQtKDaVtxjmoZzfSG7USe03Edtudz3wJ/FKC
         6BvEWe+o8t1hwl9C7IOAgdc4FloY99E27zFR5W9FdjvJJM45vDIRaUZR041bZBehfSJI
         4aeezHs1nutv9W74xWnGukRfGTB3Uvd0UC6SwzVxybfaIeN1JzRe/ZIs9S7x4mvtc0nm
         3BAd2L0l/uzP6pm4t73AaZW1RNHGSm0lBnR8tAzNztXx17HbZNyxdtMWa3kx1PgO8LBV
         apTw==
X-Forwarded-Encrypted: i=1; AJvYcCV8v2xp5nRhydySpRHqsZqy30VGA3i5YdjlrrnxBScEw9sR7JYrzoUmf/FNs7IVwE1Dl38I3jsOVDSVT+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+M1BROPL/P6vVEHEvTl86adIzGeqPwYFoZdwvIxouLmBRtes
	xBzYTUm0Jdnh/ZEk0iooMav5xc0ZhyBqUcH5aSLnVNgHHYn9hGpr2VLNTJXhnHTQiNGpI9QbHnb
	1uD+7tymKOs71zuKM3cXyLn1neJKzysa/+2D4blhSUpQtqHsdRqnRcP1xoXhVmg==
X-Gm-Gg: ASbGncurd2acX+nZRhkO0rNG4443gyasRXHL2t8His5Chj9wEl/MX7xbDH5ciu5SlTz
	HiO5yldo/55uJLwRaamHz2ZtfEVYIz9xchi2fJDMrdSwhg5pB3wrcrtOkZw/ZBZih0si3m2Kkri
	tzomWdwmJlG4mdYHwppidLmTU42UolARMeGdRVJIF3YlXb+ct/BWM7wHThBjRCPVBtL45JxUlS9
	EuN9/I/xCLIJEiJ9IZyVuBqdtTjDFLuDWm22gd1imLo15wGmIxrcCNvHmOao8girvx+5ay5hBOe
	Gvumnz7Tro8rbDLU8v4QCZ7CKtyAwKD7NCJ/DDSCPiJmb3FJhVqMckLUsn47QRFUSs3Vm+TE7Bu
	bezQq
X-Received: by 2002:a05:600c:1548:b0:439:685e:d4c8 with SMTP id 5b1f17b1804b1-43ba66fec18mr128239855e9.15.1741017609772;
        Mon, 03 Mar 2025 08:00:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcAeVlV0x3Lsv/XUbSYCaDoG4BHyq8Ft0JsRryYoUoofcmIq5h1yB/qI8Y+i3wzQ2M9xQFVA==
X-Received: by 2002:a05:600c:1548:b0:439:685e:d4c8 with SMTP id 5b1f17b1804b1-43ba66fec18mr128239335e9.15.1741017609386;
        Mon, 03 Mar 2025 08:00:09 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba58713bsm200147315e9.34.2025.03.03.08.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:00:08 -0800 (PST)
Date: Mon, 3 Mar 2025 16:00:06 +0000
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
Message-ID: <Z8XSBrCNjPVRJszF@jlelli-thinkpadt14gen4.remote.csb>
References: <537f2207-b46b-4a5e-884c-d6b42f56cb02@arm.com>
 <Z7cGrlXp97y_OOfY@jlelli-thinkpadt14gen4.remote.csb>
 <Z7dJe7XfG0e6ECwr@jlelli-thinkpadt14gen4.remote.csb>
 <1c75682e-a720-4bd0-8bcc-5443b598457f@nvidia.com>
 <d5162d16-e9fd-408f-9bc5-68748e4b1f87@arm.com>
 <9db07657-0d87-43fc-a927-702ae7fd14c7@arm.com>
 <Z7x8Jnb4eMrnlOa8@jlelli-thinkpadt14gen4.remote.csb>
 <4aa1de5c-4817-4117-b944-4b4c8f09ac40@nvidia.com>
 <Z72R5-I91l5FOJK6@jlelli-thinkpadt14gen4.remote.csb>
 <bd9eb72e-5c67-44a7-ba79-1557eaa319e6@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd9eb72e-5c67-44a7-ba79-1557eaa319e6@nvidia.com>

Hi Jon,

On 03/03/25 14:17, Jon Hunter wrote:
> Hi Juri,
> 
> On 25/02/2025 09:48, Juri Lelli wrote:
> > Hi Jon,
> > 
> > On 24/02/25 23:39, Jon Hunter wrote:
> > > Hi Juri,
> > > 
> > > On 24/02/2025 14:03, Juri Lelli wrote:
> > > > On 24/02/25 14:53, Dietmar Eggemann wrote:
> > 
> > ...
> > 
> > > > > So DL accounting in partition_and_rebuild_sched_domains() and
> > > > > partition_sched_domains()!
> > > > 
> > > > Yeah that's the gist of it. Wait for domains to be stable and recompute
> > > > everything.
> > > > 
> > > > Thanks for testing. Let's see if Jon can also report good news.
> > > 
> > > 
> > > Sorry for the delay. Yes this is working for me too! If you have an official
> > > patch to fix this, then I can give it a test on my side.
> > 
> > Good! Thanks for testing and confirming it works for you now.
> > 
> > I will be cleaning up the changes and send them out separately.
> 
> 
> I just wanted to see if you have posted anything yet? I was not sure if I
> missed it.

You didn't miss anything. I cleaned up and refreshed the set and I am
currently waiting for bots to tell me if it's good to be posted. Should
be able to send it out in the next few days (of course you will be cc-ed
:).

Thanks,
Juri


