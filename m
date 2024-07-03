Return-Path: <linux-kernel+bounces-240221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FFC926A66
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54B63B23956
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E841922E6;
	Wed,  3 Jul 2024 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4guCz28n"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607422BD19
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042639; cv=none; b=Dccl9srtVZoFAwmzEd7ctZ9cj8/FGtXY3P5SrF0pjBroLyf09dGgvhF+VYlwftEpeHmFO82KUqlsjphUPtoverNpTIQmdCqeRbCzl+PtfoUdGcT6ZPY3mHqDEZ5fk0W0CGrqqMcI/JqEw0qoGrUOoki6ZYzTZ9uesVdTg1SmWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042639; c=relaxed/simple;
	bh=aGY4JJ7NrcVaIcFo1rEJ2jw8kYcxyHDAh/LTsW7tpVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prtL1TD/O1xWgw9mUt2bAKLaSRW2h1H7glrufn/MmqPtqjdYonKmXGRoozOQ1aMl2qhYchrtLaGwDn+lgaLCOlJk+NA8Vzcmp/fqRD3NrqZgAkWchvi86dGxh7MU6tjhvS6ZB9EUyzGewszEwuwUCWOo1Hk3dULEOn8827apgdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4guCz28n; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fb10519ae3so20535ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 14:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720042637; x=1720647437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SsKaNV/QilXxMlGWjE5Y3ek6SYClBFD1a8IKmwgCqHo=;
        b=4guCz28nlPUX5xScbDtTzyUTbebiah/1XfhVnQd52gDEPJCkmZX26LmUXttec4T2Oa
         h97FI3xo9Elm2ckhnacvpxmBmqTjzeuEtLqu/xgI5qzU2KaJLLBUusD0mOYsbguK5H2J
         wtUZwOlIrK9gl5GZxGc50+WeEc5UJ6MVKFQgjMjcSVCHV8IxGpJrgwQo+I+jfGPXrrXU
         3kN0SR0wbPexyL5MC+DHMlyiXZoHUEkv0AXepUHdUXVSnhVuDKZ1y5HkGlUWiBJhFb/+
         tutZ6JDiHk/5IyiKjIVnnIatT1t5BxdzAnN2otxt7RQD8CUk81qc/+MhXglkpmiMs9Nm
         oHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042637; x=1720647437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsKaNV/QilXxMlGWjE5Y3ek6SYClBFD1a8IKmwgCqHo=;
        b=oWHcKw8GpTFsdoUYXZLc7Clr6VQU5zIwjgg5vNVuhK5XEVxItLgTI6Y3c3csWAmjqE
         LHwQTIqC4Un1CnhS+pvt+m41FfXVbHZvmzybBzzeiQAQ81fbQcitg9W9Dctdc0URjJZl
         tzIYqnoCBB/t9Z8/W8bGCedeLfrZ60rmOB2Lh9bc9O7KXiS2Wlzt0BM5ZkuTmCRx/1TD
         YkizSzuSpbmsJb/eTGuASG9HCRRI2EKVgE2eJT2MPOry78u5APOm6EkwMMMxiY8GEUlz
         FJaKOw/0+Mcuu0/NJ5iWkLQmK3iuvHNmGsvGY7LKMVQKvlcGJsdF8zQPD3RgfOAK6UXW
         4bxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYDg27HuSM8XbrdTpAnCMZBAjjxqjCSLxii8LGeDYilTcrsYe2klDD0nhVD53js/nY5R87zVNl6CXHQH0CmlLkSiUOQPSGwMw9tLNk
X-Gm-Message-State: AOJu0YwFdptvPdo5ZFyWTUq5JzyWfvLV5I8AyRmG8wapSmwgICoDz9zU
	3y0j8Q9QhSzlZi9sz5IF4jI+Dm9OcjzLQycfA6sSWBWt7WnYvL7QSvwbJUulIw==
X-Google-Smtp-Source: AGHT+IGTqTsZmzhyrTz3vvsHq/xKinAvJI6+Jy3C2I+ajzgYv53kM/TvqnJdQuzeWnds72lFvTmrSA==
X-Received: by 2002:a17:903:64d:b0:1f6:3a2e:f6c6 with SMTP id d9443c01a7336-1fb3267301bmr243515ad.21.1720042637262;
        Wed, 03 Jul 2024 14:37:17 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:77ce:79b0:1f72:f91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3e7fe9sm11266858a91.50.2024.07.03.14.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:37:16 -0700 (PDT)
Date: Wed, 3 Jul 2024 14:37:12 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: tglx@linutronix.de, "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	saravanak@google.com, Manish Varma <varmam@google.com>,
	Kelly Rossmoyer <krossmo@google.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5] fs: Improve eventpoll logging to stop indicting
 timerfd
Message-ID: <ZoXEiCvdNRr_tj2N@google.com>
References: <20240606172813.2755930-1-isaacmanjarres@google.com>
 <4x5wsktkcwt7einzjowricl27pzusx6ggls43zionql7ixi5cz@icbegmuqqxcl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4x5wsktkcwt7einzjowricl27pzusx6ggls43zionql7ixi5cz@icbegmuqqxcl>

On Tue, Jun 25, 2024 at 07:58:43PM +0200, Mateusz Guzik wrote:
> On Thu, Jun 06, 2024 at 10:28:11AM -0700, Isaac J. Manjarres wrote:
> > +static atomic_t wakesource_create_id  = ATOMIC_INIT(0);
> >  static const struct file_operations eventpoll_fops;
> >  
> >  static inline int is_file_epoll(struct file *f)
> > @@ -1545,15 +1546,21 @@ static int ep_create_wakeup_source(struct epitem *epi)
> >  {
> >  	struct name_snapshot n;
> >  	struct wakeup_source *ws;
> > +	pid_t task_pid;
> > +	int id;
> > +
> > +	task_pid = task_pid_nr(current);
> >  
> >  	if (!epi->ep->ws) {
> > -		epi->ep->ws = wakeup_source_register(NULL, "eventpoll");
> > +		id = atomic_inc_return(&wakesource_create_id);
> > +		epi->ep->ws = wakeup_source_register(NULL, "epoll:%d:%d", id, task_pid);
> 
> How often does this execute? Is it at most once per task lifespan?
Thank you for your feedback! This can execute multiple times throughout
a task's lifespan. However, I haven't seen it execute that often.

> The var probably wants to be annotated with ____cacheline_aligned_in_smp
> so that it does not accidentally mess with other stuff.
> 
> I am assuming there is no constant traffic on it.
Right, I don't see much traffic on it. Can you please elaborate a bit
more on what interaction you're concerned with here? If it's a
concern about false sharing, I'm worried that we may be prematurely
optimizing this.

--Isaac

