Return-Path: <linux-kernel+bounces-513219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E418A3448A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436D03A1255
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEF823A9AB;
	Thu, 13 Feb 2025 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQ4qa4LO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5591123A9A3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458314; cv=none; b=We111AvdBfAxOZJ+NbzPQqDM0g6q/QXfNRZMG/Bo4OriizKiXI68Q1U/9yJjf+EFgypaeC0YLhhCFcY6cWcMNzRDrkVUZuTFaAyJ7DXp+4sa7BbGqC3E6rRV9znc/ukZyY9zM+aEk5kP70y3ItKhQQ/F0UYnrikscSsHCYRWL58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458314; c=relaxed/simple;
	bh=B1z2sR69wDiofUV84ZSOpgKNuRtWcJLfrcwnnKTulKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dvto5WGtq+aS5MF/0p6TkYdSJ+VX1Vio8OwmrJoHSqfRo9YKXvmZfbnBl2XcG2gB5fqvt7PMTkr2ZHj/Khja56JFIh4+G/2gxZCoKNnREgz1VrboGcdtZVHDOQK28bi59KpA+bbUObtFcnFlpgTav51SeybbAGHZNhPuOr05Cu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQ4qa4LO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739458311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6lhS8iVQB+96sJToCHUOQOlC5WCDphVwPzl2IuwUXiI=;
	b=QQ4qa4LOHdb7a4Z/wQh7+oQyOqdhoBTFL7jqSzIShYSW++0fPAbm4a25cpcyeMwiPHe1hD
	73bL+2L7w/3UrBYito6jqIzJhVgrdbdk56eBIOQqeZcZoFv5kw1ymrJTdX9SSAR9bGm7hf
	s/QSlIorDwdND5wyYl/pBvBPQ2YQO+4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-cMicW8-jPLq-q-qhvc3MSw-1; Thu, 13 Feb 2025 09:51:50 -0500
X-MC-Unique: cMicW8-jPLq-q-qhvc3MSw-1
X-Mimecast-MFC-AGG-ID: cMicW8-jPLq-q-qhvc3MSw_1739458309
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so7865795e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739458309; x=1740063109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lhS8iVQB+96sJToCHUOQOlC5WCDphVwPzl2IuwUXiI=;
        b=WxtJlGrdp0NS6cJAELcq+M4RkSx4HcJ22IH/Vg59kt50VOLGdAI4zdtzSU8vHLQWuV
         BBC10v0PGHyCVitnSCQuUA4OM6PfO20BOAjS/WBvznC4AGOcyDfxaD5JEGJBnsv+PxVM
         SdfALWu37kkyyVJ7FShezgt7ljiFI3Jr94LY3mjwomCrkVZ80hDnnC8Q1y/U2UVkBLjQ
         w4reY3tDBYlmmmSiOs4OP+XWSWKIwZ5y5t+Et6bNqrVnRcWJxcOWVKjf41Rm5NZyr6zW
         KZW2iOOGyj+P+mmGxEJ+meLxfDy7o6sSC2TA4KKnuRTVFwqCCCTy+YVhxpxDevW4snLJ
         Fd9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmsIoMPqsXo7Yl2qJcc1wMBEyrcMsl8sUAHAN4v2MDM6M7RnSgg/hyoCZ1UQQiUKdnQoNtB7AEu/kVdlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpr71HbhKqjGomUvFyejJ8HvhoqvEvUQV/nnYmY8NwK++w3ok5
	/hoZCxSdMWbhtaF2c/TKDGY7CY8Qid576yNJA5toSh40obGbDK3dmdnWB7yyS57EEr762I5mHQ5
	xDP/4GIIXxHdbVrGiT7F/MzjMhmH4QG4m+rlw67KuBpdh++lu5U+SDBPSDBzkfA==
X-Gm-Gg: ASbGnctiG9gCPCcJ/mHNXk8I20xsz0UghV9RWnzX20PXYZli7fmBd/pNXeElHJ81Gb+
	0pBLSZS9Z2PKU8zREDXwKEK1+/U0B2vVW3wy4fBtql+uz9zR1d2d58CTNWVoM4BrDyanXoezaja
	0ZaHhTCjYclkZiygYxmEtjmxgttO2lsMvCCgRDdLPhc8RKBl67/J++89vLkMGfSkNbntpQVn8kx
	B9vBiRU/R8NMJdYzwRaIhWprbfU3bKa0vaiyKdXN95HzmwDLl3CAViqI36Rpc3Fg6GILGrkKXdi
	ipXagoyeErYGwYGue0xgf4BuAghujEvV0w==
X-Received: by 2002:a05:600c:6019:b0:439:608f:a37f with SMTP id 5b1f17b1804b1-439608fa43bmr42015735e9.5.1739458308844;
        Thu, 13 Feb 2025 06:51:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAxIKUIaTswRoefZud2gAVQybC2383WLjWG+1WPkr5JTxOxoGMUsCV4ourXMPYfLZFnt8FrQ==
X-Received: by 2002:a05:600c:6019:b0:439:608f:a37f with SMTP id 5b1f17b1804b1-439608fa43bmr42015405e9.5.1739458308485;
        Thu, 13 Feb 2025 06:51:48 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.34.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7d2sm51597405e9.25.2025.02.13.06.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:51:47 -0800 (PST)
Date: Thu, 13 Feb 2025 15:51:45 +0100
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
Message-ID: <Z64HAYoBpu5jUUcb@jlelli-thinkpadt14gen4.remote.csb>
References: <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
 <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <285a43db-c36d-400e-8041-0566f089a482@arm.com>
 <Z62PPUOY5DClYo1A@jlelli-thinkpadt14gen4.remote.csb>
 <c8f626ba-1be4-4c25-b283-d1e11a061aac@arm.com>
 <Z630nGN1IHhyYIYl@jlelli-thinkpadt14gen4.remote.csb>
 <9629f060-28f4-4743-9e60-688cba039f87@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9629f060-28f4-4743-9e60-688cba039f87@arm.com>

On 13/02/25 13:38, Christian Loehle wrote:
> On 2/13/25 13:33, Juri Lelli wrote:

...

> > Not sure I get what your worry is, sorry. In my understanding when the
> > last cpu of a policy/cluster gets offlined the corresponding sugov
> > kthread gets stopped as well (sugov_exit)?
> > 
> 
> The other way round.
> We may have sugov kthread of cluster [6,7] affined to CPU1. Is it
> guaranteed that we cannot offline CPU1 (while CPU6 or CPU7 are still
> online)?

Uhu, is this a sane/desired setup? Anyway, I would say that if CPU1 is
offlined sugov[6,7] will need to be migrated someplace else.

> Or without the affinity:
> cluster [6,7] with isolcpu=6 (i.e. sugov kthread of that cluster can
> only run on CPU7). Is offlining of CPU6 then prevented (as long as
> CPU7 is online)?
> I don't see how.
> Anyway we probably want to change isolcpu and affinity to merely be 
> a suggestion for the sugov DL case. Fundamentally it belongs to what
> is run on that CPU anyway.

I would tend to agree.


