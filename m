Return-Path: <linux-kernel+bounces-546395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A56C7A4FA1B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4805D3AE646
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0C4204C1C;
	Wed,  5 Mar 2025 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="InR+ALWN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A111FC7F3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167056; cv=none; b=uqB0oBBZ5FX686cZjzNQw9wtH3WnGjoviW+c45zsTfn8SAiDdRM/4QnHPOrtzx5pxSjHNf/zV4p61pU9IT+YtzTHpOD6GWIkpw/CHOfO1THhZkBHqjGPAIsADUWGhU+V5Eq4iXQ3MGyd4ZaRH7Lft9lF/8ij4bAifol3I0jPzRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167056; c=relaxed/simple;
	bh=xgx4HSZDU7n/xVf5G1afLCQtvXJis/y/WjW4xj7HkDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqMX3sobygjqzECwx54LrbXm8VQ49Z/Cftso8XiLrmudew9DFmrCpVvpttuVY6nWN90cIucsMcEXLt4ZKYR3eO0DWOX6AnNJUc/WHlNDic54hYtYlOiP1O+n/q3PDG1AGREkHzM3mvlRpLhirQLe1aBr86nSnYUKA6HqOquvvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=InR+ALWN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741167053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8EJTkbR9th9cE9/5Rwb1aADNZHqX2tCQgBbpYJugojw=;
	b=InR+ALWNyyeDLjrT9QZZ4gjfSgmI0sVGUEkoChrQkfd4mIZ+nL7+xbEwdggsDZJIevoF5d
	Dd+6jEjtbGDFj3NrLTK1RLl95v7ajRre8XepLXzmqhFfIIH8mVgzFl2odCkiyjfD9zMZ1x
	ihWQZtcOrBZNClnBT2ayXIGheI+eXtc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-Z8tK5Fd3MmyGH7Vjh8P3jw-1; Wed, 05 Mar 2025 04:30:40 -0500
X-MC-Unique: Z8tK5Fd3MmyGH7Vjh8P3jw-1
X-Mimecast-MFC-AGG-ID: Z8tK5Fd3MmyGH7Vjh8P3jw_1741167040
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-47508cfc342so23873221cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 01:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741167040; x=1741771840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EJTkbR9th9cE9/5Rwb1aADNZHqX2tCQgBbpYJugojw=;
        b=YeoSUcWearcNzuAZtsBM9/1C2mijlQE3r7txWxFWQ4WYYxMjPAOI3lkTzYK8UBNiAf
         6wI3qVRS5wsysIlRIAH6yKa/NspY9EDARxQFNCJq7lDXP1lT6XmyrV5FXuQ/oOsAPOg4
         joIUZbk0bKBA4iVE0XUfMyZMBxs9hVxHpvQB19eSbqeHshSmPV69pb4h6qCAG4/UxnUZ
         FYuKqlDmnU8D2TMPmEIAYK1mzoDixK84XBc2boPSEjC69p7vJV29+lE6135vpDXtluB8
         Aba7XZPZOxfGLWRjHVD1WRvBOlOTGoUDOiFRcSTFWV154SI1BZ3ty7AyPMqFcG7u0KSQ
         rwuw==
X-Forwarded-Encrypted: i=1; AJvYcCXd06jfI8l1beMMeEh0germhtvQSFiOH/zmZGqoJhKRPGHC66wB6Ftx+/4AE0IBRm+6rVXvGiE8sXskXdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLeglAqNogqxSXyVU06hA43fGOHvz63GXW74x6ut/NsVHzhTRN
	HlBm/XoO7F7fq+kPxOCD45OWkbeIVwgiYk0BuZEOfm8w4loIim7KntUal8Ayyqd4DW9lB784f4x
	aRvAx+QC115hON/4nxc7BxPUqmtZz9iunCwrOLpmEtue2ldooLjd1KAC8h/B7Tg==
X-Gm-Gg: ASbGncvCLR0JHJAyyBKtmI1A+jYMRxIGdYtEo/oRvae+NVCdjkS4JdkXfbb1ArUErH2
	pHFkDxDYTmNWXyrqJEG9tXCRk+8c7eaiz0tsgwXSorJGkp4G/4ntAa6mBT4/26KrR83qZDwVanr
	AdcU3oHOG/3oZ8fVZBigUWkwyzsOQsGCY7jVh8ZcRq/6rbMnDUV8ivLOR3SzyP79DlZvKWhGweq
	h4digC8yIj3wD7cr/jdlImWDSPPCCT+42+yttSqsfCTWXl0vuEWyoXrI8Khlk/gbM86vfVo9sO/
	+SyTPZF0SP/quNWvzo2aS0oQE5JnGNWtyp6dQw1BuPHzoVIcGk7W1b9AXmALOkEJQ/vAoNE5+CN
	qRDsr
X-Received: by 2002:a0c:bf50:0:b0:6e8:ed7f:1a79 with SMTP id 6a1803df08f44-6e8ed7f1cc5mr6413576d6.32.1741167040315;
        Wed, 05 Mar 2025 01:30:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2KuetL5whCKoVGhof0MgQhHtXZOk/kgPtLg/+HfbSSzrYEBXTfgD8UUbLB7L4/6q+S+EFVg==
X-Received: by 2002:a0c:bf50:0:b0:6e8:ed7f:1a79 with SMTP id 6a1803df08f44-6e8ed7f1cc5mr6413326d6.32.1741167040054;
        Wed, 05 Mar 2025 01:30:40 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976eb173sm77524666d6.118.2025.03.05.01.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:30:38 -0800 (PST)
Date: Wed, 5 Mar 2025 09:30:33 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, paulmck@kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH RFC] sched: Disable DL server if sysctl_sched_rt_runtime
 is -1
Message-ID: <Z8gZuaAavG42unZb@jlelli-thinkpadt14gen4.remote.csb>
References: <20250304200116.2210119-1-joelagnelf@nvidia.com>
 <20250304150632.3fde716c@gandalf.local.home>
 <20250304234744.GA2283516@joelnvbox>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304234744.GA2283516@joelnvbox>

Hi Joel,

On 04/03/25 18:47, Joel Fernandes wrote:
> On Tue, Mar 04, 2025 at 03:06:32PM -0500, Steven Rostedt wrote:
> > On Tue,  4 Mar 2025 15:01:16 -0500
> > Joel Fernandes <joelagnelf@nvidia.com> wrote:
> > 
> > > Currently, RCU boost testing in rcutorture is broken because it relies on
> > > having RT throttling disabled. This means the test will always pass (or
> > > rarely fail). This occurs because recently, RT throttling was replaced
> > > by DL server which boosts CFS tasks even when rcutorture tried to
> > > disable throttling (see rcu_torture_disable_rt_throttle()).
> > > 
> > > Therefore this patch prevents DL server from starting when RC torture
> > > sets the sysctl_sched_rt_runtime to -1.
> > > 
> > > With this patch, boosting in TREE09 fails more than 50% of boost attempts
> > > making the test more useful.
> > > 
> > > Also add a check of this to task_non_contending() because otherwise it
> > > throws a warning (in the case when DL server was already started before
> > > rcutorture started).
> > > 
> > 
> > Hmm, I wonder if dl_server caused a regression. That is, disabling rt
> > throttling should allow RT tasks to starve anything it wants. And some RT
> > applications rely on this.
> > 
> > Should this include a Fixes and Cc stable?
> 
> Yeah that makes sense to me, I'll include the Fixes tag in the v2.

Not entirely sure we want to link the (legacy?) sched_rt_runtime
interface to DL server, as it has its own new interface at

/sys/kernel/debug/sched/fair_server/cpuX/*

Admittedly thought the latter is a debug interface, which is not ideal.

I was thinking we might want/need to add a kernel cmdline parameter to
tweak DL server parameters at boot (and possibly disable it), but it is
indeed less flexible than an interface tweakable at runtime.

If we end up using sched_rt_runtime (and _period) to tweak DL server I
believe we should make sure changes are consistent with the debug
interface at least.

Peter, what do you think?

Thanks,
Juri


