Return-Path: <linux-kernel+bounces-280518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2EF94CB91
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23042282388
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84D817CA09;
	Fri,  9 Aug 2024 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcmghpNv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896B17CA04
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723189368; cv=none; b=Srq31Lra67VPe/7NaeXgQahSC8EGZZMSdpaODP5rVLrC1GM3k9jRyG5RzD0gfqZUF/eoYMyK5x1oCwjVdA5MFGfORpSYcl9nZIOLIwhXGcgU16g8ZAkU/4Zsmst4T9HU5T0QZjXAZigYOIULoePGvoauZCBfLEI2dJzNDfPeckc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723189368; c=relaxed/simple;
	bh=iqpqY4Mz02a4XXRlY5NSi535Wlig7PeZ+dkLg0mpRq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMtuZoBAEaJzCC9Exv0EOVUc9sBL+yocxnFMFc8cyoqO5AatKdkWwZ1TMFRW6TqCZdGu2khzDpJlA/0osvTv6/QoJh2c+vizfO5rJtpOn5bEtCs/Nbdhb5y80UR90ZOzgiSFHf/5amo44rUkmOaKvPhlmxbr0gGPZffv8k0304U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcmghpNv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723189364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3mzbNoONi9GdzgSxgBM7Loyz11zvAii/cozyn0JFv8s=;
	b=GcmghpNvhU/2ULAOIaVC9+i733dXh7pR/iTgBMbzA+Ko+xanVNsjj5Q14NgQaYdJGe4iS1
	MZO9dI/N+wGaxixJPppSq0W4iYUs97ykwIL1BYmbiwuNpIfmvfSUYz5Ma4gGrXKyJqT1mv
	r3MCxqQp2yP7EQgRk2lBE3r5o1D0INk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-2jZ2Fb4pOgurFt6V2IOFwA-1; Fri, 09 Aug 2024 03:42:43 -0400
X-MC-Unique: 2jZ2Fb4pOgurFt6V2IOFwA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4281d0d1c57so13460645e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 00:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723189362; x=1723794162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mzbNoONi9GdzgSxgBM7Loyz11zvAii/cozyn0JFv8s=;
        b=G+TmLm+ThqeCnAFGpyexiGpQAAHiP8K3hrori0S5/ZoJudZEc1WdI1TbJVvm24KHOF
         UxS+dyWxjSbJtoST1Va68H6ZAjpeomffWlsZm8V51zhxLTKCXI5bHmC5WiP4Jf0+Kx4s
         rivXC0Ad2/S+H9Oq+nxEE58Red8Zmnh/ocCFYwsEECKPo+NmEN0bHMciH+cDw2rfEda3
         YUUn8XFAxwBIkLXtI9j8opcc2FwIXlP1D+QmP3G88nSH57/A0EnOSsNgJuK+1VaSp22G
         WzFP80Cy68YUwrm1s3Ho7ULP4alrtGTU+JZdQu/l+xws5cq0texOpuwrOG6YqFvExakv
         mT5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/ysC3o6eM0L+A6L9K94l5pQ9fOlUvpvsN3a2gCb3zvXtNLz39e9TTbYLKHXVs9zwp3QviXqybiIM9MEqcNMpzIyrfvvr2TcdZ/Xu7
X-Gm-Message-State: AOJu0YwopRaG7xWvLHC7446wC6eHsFAzZiEjD6QmeTKvJ5XF4QKPTSwi
	dotyRJuQSrzblf+wC49hQEucop7DYUjwxTO+LQ4ag/imVP+NWcY+2tQtX4iWO96S6DvLpjVMGfD
	NM2eeLwZcgAb73fnwtptk3sEcmRtgasf7VBo0IQD1FZlUmapQ/l6jaAEd1MzOFg==
X-Received: by 2002:a05:600c:3ba1:b0:428:b4a:7001 with SMTP id 5b1f17b1804b1-4290b8ddf1bmr33446945e9.15.1723189362408;
        Fri, 09 Aug 2024 00:42:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7SDkNhvKREFsyY1hymxa4EHM9XWF0EINXQbTXDvdD7OWRKmOjdwEhS84+VW/DzwLaII9zcQ==
X-Received: by 2002:a05:600c:3ba1:b0:428:b4a:7001 with SMTP id 5b1f17b1804b1-4290b8ddf1bmr33446755e9.15.1723189361912;
        Fri, 09 Aug 2024 00:42:41 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.159.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27208d75sm4399714f8f.85.2024.08.09.00.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 00:42:41 -0700 (PDT)
Date: Fri, 9 Aug 2024 09:42:39 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Qais Yousef <qyousef@layalina.io>
Cc: Christian Loehle <christian.loehle@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/cpufreq: Use USEC_PER_SEC for deadline task
Message-ID: <ZrXIb7BFOWY11DKt@jlelli-thinkpadt14gen4.remote.csb>
References: <3c726cf5-0c94-4cc6-aff0-a453d840d452@arm.com>
 <20240809012410.marjxrio3sjequnn@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809012410.marjxrio3sjequnn@airbuntu>

On 09/08/24 02:24, Qais Yousef wrote:
> Adding more sched folks to CC
> 
> On 08/06/24 14:41, Christian Loehle wrote:
> > Convert the sugov deadline task attributes to use the available
> > definitions to make them more readable.
> > No functional change.
> > 
> > Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index eece6244f9d2..012b38a04894 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -654,9 +654,9 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
> >  		 * Fake (unused) bandwidth; workaround to "fix"
> >  		 * priority inheritance.
> >  		 */
> > -		.sched_runtime	=  1000000,
> > -		.sched_deadline = 10000000,
> > -		.sched_period	= 10000000,
> > +		.sched_runtime	= USEC_PER_SEC,
> > +		.sched_deadline = 10 * USEC_PER_SEC,
> > +		.sched_period	= 10 * USEC_PER_SEC,
> 
> I think NSEC_PER_MSEC is the correct one. The units in
> include/uapi/linux/sched/types.h is not specified. Had to look at
> sched-deadline.rst to figure it out.

In practice it's the same number :). But, you are correct, we want
1ms/10ms and unit is nanoseconds, so NSEC_PER_MSEC.


