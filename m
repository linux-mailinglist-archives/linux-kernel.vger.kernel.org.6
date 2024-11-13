Return-Path: <linux-kernel+bounces-407829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ADE9C772F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92846B2DC48
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2625C1DF272;
	Wed, 13 Nov 2024 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aocn2+g7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7017B401
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509885; cv=none; b=Ypfr7XDLZx5hLLKrVIAzI9SHqNjabDKg6HXXD/EB0x1ue+F98ntuZj9yqXYqp4B/WgoS25X/1yfH/t6mCPwQCCcigyiTtouMG0zvjVVWKiwIZNVOgGE3/bgrq1gUj99URWnWgAWcODMoHR+lAewQRH9z3AtwvyQ/hBN/UhnxyGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509885; c=relaxed/simple;
	bh=7gR8XVU2CNtYu1Oyh2JjI4aaVwZlNnrmNB4SslkNI3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxhSypVE4TkOF75zTCyJt1oW4wQ4wE2KuAmdFGFiFS7ZkxsEuz3qxh5qKUUkAk+fKK72Kpco12mB2Va36yIQMj5gz+rN7E7jDVxt1MpaAMy8ZTNI8vKNLzR/l7YOoCAX+DfI9l4yy0Nt6rAAiWq3WPvNcIzNYThS5qz1LLwvhas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aocn2+g7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731509882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R2k38l89u20sHjk8k3TDf4GQjG0PrKhQiw5KJOawrK0=;
	b=aocn2+g7HzZIo9JZoijc3kX2Ev+pnUpG+qWzXoY5qZ73ZgaDPAUkCHt7fpmhhYcPizte/r
	qSS7ldjP5qLJT7ZMW2E6OF+DupFjMAiDczgQNBL5PQhbzbpq6H0TdL2hKVq4NjGhQQI3Rx
	wRe6u27l/RsaMJBSioty3wxMXXU5i8c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-bE272VgwNKGcnb6y3M7znQ-1; Wed, 13 Nov 2024 09:58:01 -0500
X-MC-Unique: bE272VgwNKGcnb6y3M7znQ-1
X-Mimecast-MFC-AGG-ID: bE272VgwNKGcnb6y3M7znQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315e8e9b1cso5289315e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731509880; x=1732114680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2k38l89u20sHjk8k3TDf4GQjG0PrKhQiw5KJOawrK0=;
        b=dC/yEDeaBOkYYVv+KU8GV6GgQtodjysUtnNYXY1UX06oHpiSwzrUvEdoEHAFoTO/6X
         w07eKCGdUz0uRyW746SjkZT49S6Z3Cyy2GLHABYbqm277uAdpqEmcpWG3FIAIA15+LBA
         QkMgyBEzrX2FwKXniB41XlVeAt8/u7rsoDv+EuPoT7HfHRX9J5auVahUXquaC0uZgWmF
         NIftCgUNz+mDrWB5dv5Iw9VxSkOsvz3pmySBA5uaBtfGZNiC8HLS2DBau64ycYd7qBYQ
         kdrsVyUFEJnyxDPoCBeWFEcZaqDtD866CkpEzgFOQBslX2NhnN291FONw04N/hhyrAaZ
         gVpg==
X-Forwarded-Encrypted: i=1; AJvYcCVQvWnRYcapUngkj/jNbBsY7z7gAN8+gIaeAJPfe23tUwGpDrvqK1jCA83A7wO0A4kXE4VUEc0HwR0RXAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8HYOTWEgtKrF9pdzBA0nuNM/xa8h7/Fo+Ub2APw9Rz+7sfU80
	nGwbGsoZvAMtWm+1nwWJksOQYvdDU/f3FlkvkjzsXDkdB7psK1Pi/1tiW0WdbMH0yPYwr4hTqxy
	ms/AZyF/hLdP7fG/ojjRVDNYtUmlHk9S0jnrjNk1FN2hYUIm1Jq6xJhbn/1vo0w==
X-Received: by 2002:a05:600c:8608:b0:426:5e32:4857 with SMTP id 5b1f17b1804b1-432b77fe58bmr179043105e9.0.1731509880617;
        Wed, 13 Nov 2024 06:58:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbHfPhsWEudGXZ7kN+eXfuDpQRWjyreBI6PrYOBgf6hzoJmN9zYelKhExY/ziaYnQssXzN4Q==
X-Received: by 2002:a05:600c:8608:b0:426:5e32:4857 with SMTP id 5b1f17b1804b1-432b77fe58bmr179042745e9.0.1731509880186;
        Wed, 13 Nov 2024 06:58:00 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54f82b6sm27007005e9.15.2024.11.13.06.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:57:59 -0800 (PST)
Date: Wed, 13 Nov 2024 14:57:56 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Phil Auld <pauld@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/deadline: Restore dl_server bandwidth on
 non-destructive root domain changes
Message-ID: <ZzS-dDgMwa15P9lL@jlelli-thinkpadt14gen4.remote.csb>
References: <20241113125724.450249-1-juri.lelli@redhat.com>
 <20241113125724.450249-2-juri.lelli@redhat.com>
 <20241113134328.GA402105@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113134328.GA402105@pauld.westford.csb>

Hi Phil,

On 13/11/24 08:43, Phil Auld wrote:
> Hi Juri,
> 
> On Wed, Nov 13, 2024 at 12:57:22PM +0000 Juri Lelli wrote:
> > When root domain non-destructive changes (e.g., only modifying one of
> > the existing root domains while the rest is not touched) happen we still
> > need to clear DEADLINE bandwidth accounting so that it's then properly
> > restore taking into account DEADLINE tasks associated to each cpuset
> 
> "restored, taking ..."  ?

Yep.

> > (associated to each root domain). After the introduction of dl_servers,
> > we fail to restore such servers contribution after non-destructive
> > changes (as they are only considered on destructive changes when
> > runqueues are attached to the new domains).
> > 
> > Fix this by making sure we iterate over the dl_server attached to
> > domains that have not been destroyed and add them bandwidth contribution
> > back correctly.
> > 
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> 
> 
> Looks good to me. 
> 
> 
> Reviewed-by: Phil Auld <pauld@redhat.com>

Thanks!
Juri


