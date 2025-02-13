Return-Path: <linux-kernel+bounces-513004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C178CA3406A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C36E163BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0128B23F439;
	Thu, 13 Feb 2025 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONBKX1ru"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E01F462A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453605; cv=none; b=surfdVJWp4GBXMi3DrLQMMJnLa07mJVxQVIa9s3xsgh/c4QKnUjDUe1dMulGrm+6I4ad7hKxbGTJBsUJMEdwAvbNaxAUMsdgxcxhaAOZkYcxbaWfReoyKhtx9uYSbH+ypZphk7Qt3a9uacb26pbSpCoheq1UZ3n5P0v3iobb8SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453605; c=relaxed/simple;
	bh=nJSNN6N7hXFIyR3N87Ol1SOQiDheBw1MjwCj9roRY2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=allIAti1FC4leJm7hNbooDWotTW4M6dCLMuPNLO62RrYKuBan9USGIx1/FAnbmNoUmB+RDizv+fzzR07QyrTsfAOyMwX7jvDjcyd2U/mZsIyRJwvGccpsg0MMlCPHMZpDmw9Bp+APND/amhUFQaKG6xmI0nsLj+UW6n8P4y0sPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONBKX1ru; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739453602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oZygvgN/S5+5cVst+J1p4HFlB8Rids65GqUffC9Shyg=;
	b=ONBKX1ruiwd3dEtNzcYVCMBanO+vrtu/5r0ybZ4ezEvwmM+OvwQ71J/zp7WnDmKeVO0moh
	k0mDgYV00luMZOQBTNjo9fFfetqndobuCMHOq7PG+qCJ/HR/o5rhZ0rUwRhoxpcX7UM///
	ztVyreRJempNHZqlbJXuOf74J1ylfhY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-79BeOIS3P8GvSBz-FdaOwA-1; Thu, 13 Feb 2025 08:33:21 -0500
X-MC-Unique: 79BeOIS3P8GvSBz-FdaOwA-1
X-Mimecast-MFC-AGG-ID: 79BeOIS3P8GvSBz-FdaOwA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-439385b08d1so6576455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739453600; x=1740058400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZygvgN/S5+5cVst+J1p4HFlB8Rids65GqUffC9Shyg=;
        b=uWeB1C0E64PEzunAB9oonZQFfZAh5vRUgezas+u1+Ll2E096jA+XHTop0Y/kI3bt/0
         x4UtpjVCWW6/9gDuFJnOevghLhdsFrUxBWcM6UVYmagF7YwPTfCAw6+qEs41jslxUTm4
         tHYLpiXRmwBFNGIEXtdaFSIYgo60ECKttoj/s1rj+PZp9ySdETQtzZ0UA7CQ/nWbnXwp
         sjSyvyWyzD0TqkfmmjqOPoNrqXojJv2jRkmDPekyOVbDvDUcRSGAsElt+Q7zZOgEqt0M
         a6EnEuuBNCSzp/eAH9bMNsAwbTBVDClFrxu1RQ0HdR3u+kUyuKv6RkCidXvlQT8wm9Ox
         e1cA==
X-Forwarded-Encrypted: i=1; AJvYcCUNx3JM06a/GsB/E537Z6Fa9H6AsO2PytohPDECrHDJag9RGaxe8C/NoQ2CNVe+WrCKO+AgCZY1H3EIZUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW6XwfJ/EjyOcJAgVSYGpitIF0za1YBl/EGPDohT2YwuRm472F
	Xr+BkGWjL0WYEe77yBu69mAWp7fdfaDSxOMpGQt1zQ7ysAcHbUpWeaV3+em4mihlsWT+FDqOP/y
	ZyDz56GYzlnC/2frnC9WNlwIIdN7kM3lKaD4TZYeRhC6B53q5W+Jn2ndRSjkErA==
X-Gm-Gg: ASbGncv8PuSdZ4cv2ziDF9FB9F/yc3pEJ5JYDOJFRItXlXflEv4g1OzAjdZ/nsogtTB
	hadjVXBPTWA+75M+icWMWBJ7x1WeBr17P/GNYEybdWGEo56ABtclJdy106Abud9QQnhjnpP/ZJP
	jh0zuesU38IlVZcv7czI8V9rkQML/9V9TrAo1+3Krvzw6ONqo+xJ6DIy3cYM8Ep/IJLeUdBa1BL
	yxy4+pAao+3wm1Uc3U5OA7OAVhIgOx7R5j0KxxEZgHlHuvBE9F04vgFzdEc8sPxRbD2tl4MQKzQ
	hhcjXBi2t6qUT4JCksfqQ0duTtjzKX1JAA==
X-Received: by 2002:a05:600c:4f0c:b0:439:33c5:386c with SMTP id 5b1f17b1804b1-43958157f77mr83212055e9.5.1739453600007;
        Thu, 13 Feb 2025 05:33:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2MJ61/t+gptH5JllikXxa/xlRnj0nayEvWq7iwSFksSny2k2oIj3/PETDLaZiU1GBGHmn/w==
X-Received: by 2002:a05:600c:4f0c:b0:439:33c5:386c with SMTP id 5b1f17b1804b1-43958157f77mr83211485e9.5.1739453599593;
        Thu, 13 Feb 2025 05:33:19 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.34.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b41b5sm1951535f8f.14.2025.02.13.05.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 05:33:18 -0800 (PST)
Date: Thu, 13 Feb 2025 14:33:16 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Message-ID: <Z630nGN1IHhyYIYl@jlelli-thinkpadt14gen4.remote.csb>
References: <a305f53d-44d4-4d7a-8909-6a63ec18a04b@nvidia.com>
 <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
 <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
 <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <285a43db-c36d-400e-8041-0566f089a482@arm.com>
 <Z62PPUOY5DClYo1A@jlelli-thinkpadt14gen4.remote.csb>
 <c8f626ba-1be4-4c25-b283-d1e11a061aac@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8f626ba-1be4-4c25-b283-d1e11a061aac@arm.com>

On 13/02/25 12:27, Christian Loehle wrote:
> On 2/13/25 06:20, Juri Lelli wrote:
> > On 12/02/25 19:22, Dietmar Eggemann wrote:
> >> On 11/02/2025 11:42, Juri Lelli wrote:
> > 
> > ...
> > 
> >>> What about we actually ignore them consistently? We already do that for
> >>> admission control, so maybe we can do that when rebuilding domains as
> >>> well (until we find maybe a better way to deal with them).
> >>>
> >>> Does the following make any difference?
> >>
> >> It at least seems to solve the issue. And like you mentioned on irc, we
> >> don't know the bw req of sugov anyway.
> >>
> >> So with this change we start with 'dl_bw->total_bw = 0' even w/ sugov tasks.
> >>
> >> dl_rq[0]:
> >>   .dl_nr_running                 : 0
> >>   .dl_bw->bw                     : 996147
> >>   .dl_bw->total_bw               : 0       <-- !
> >>
> >> IMHO, people who want to run serious DL can always check whether there
> >> are already these infrastructural DL tasks or even avoid schedutil.
> > 
> > It definitely not ideal and admittedly gross, but not worse than what we
> > are doing already considering we ignore sugovs at AC and the current
> > bandwidth allocation its there only to help with PI. So, duck tape. :/
> > 
> > A more proper way to work with this would entail coming up with sensible
> > bandwidth allocation for sugovs, but that's most probably hardware
> > specific, so I am not sure how we can make that general enough.
> > 
> > Anyway, looks like Jon was still seeing the issue. I asked him to verify
> > he is using all the proposed changes. Let's see what he reports.
> 
> FWIW it also fixes my reproducer.
> 
> I agree that dummy numbers for sugov bw is futile, but real bw numbers
> also don't make a lot of sense (what if we exceed them? The system
> won't be able to change frequency, i.e. might not be able to provide
> bw for other DL tasks then either?).
> I'm slightly worried about now allowing the last legal CPU for a sugov
> cluster to offline, which would lead to a cluster still being active
> but sugov DL unable to run anywhere. I can't reproduce this currently
> though. Is this an issue in theory? Or am I missing something?

Not sure I get what your worry is, sorry. In my understanding when the
last cpu of a policy/cluster gets offlined the corresponding sugov
kthread gets stopped as well (sugov_exit)?


