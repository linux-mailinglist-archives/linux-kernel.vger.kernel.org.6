Return-Path: <linux-kernel+bounces-304011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515C8961884
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 22:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15B91F24CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CDD1D3627;
	Tue, 27 Aug 2024 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCAO6sqc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B41186A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724790598; cv=none; b=kSW/ksNbjfCYw1aW0LhOivscWCRMPjd1UgV3rVosIzm+ncIpljje2G9UQs5HtMgwGVa3MXu0dnDReZC+poA6GDkUZJBnsNvrNDeO8QzzlBfoOO61xFO4odSrMTi3tTZ0L1ru6hocMZNnpDjQTCUeHlAh0oJuLfObqVGwiC5+yoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724790598; c=relaxed/simple;
	bh=p7no6Kg66EOPzk3ZiygOc+iVxvhxlykdGbuuqRJR5P0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CNi4ihk/0In4GzDUJVgHYIJdEIOr5bscYawcGTsY5NFILpMm7T/sKRUql5ypqtRKnyXDwvgmcGs9y+aM5HBJkgxYXeDf9VTAKC9684YpS3Gsr/dCGxQFWVlgJPfc04kay2DujWpTAwvD8xe2gnHtycwE/7UyZA8lVYgprDssYxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCAO6sqc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724790595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iE4zYQoOFY/pMThxDo83JhTYPwl7SdOyEEbfVoiSKbc=;
	b=fCAO6sqcYx/7XV5/IDxgfkN68+ZPUCTTMBxkoibqFwOZ1Z1SbghDy6tX68cYQZsuv5WV7H
	zpPQcUDGsk+E6jpXdhxHBcEJMcW7NtgTjvhL6+yfzCRnHMlyny6d4jk3ITsElCL1tcWXFi
	4XDar8MFBpBS2EgKxVw4Cn0P/mz6hgw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-GOZNrcDLPw-JDN1T0cJ9jw-1; Tue, 27 Aug 2024 16:29:54 -0400
X-MC-Unique: GOZNrcDLPw-JDN1T0cJ9jw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42807a05413so52592345e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724790593; x=1725395393;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iE4zYQoOFY/pMThxDo83JhTYPwl7SdOyEEbfVoiSKbc=;
        b=wvJSMGbBnQm1k9AnJi6Qkmle+QwmtlHqUfsz3M5+G9v596qw7K28zJFQgXmL3kjM3q
         uVMRMCPjvDwitOENV/Bmn5tOFa+9U7v8Au7czTySBZMKVk6ouRc9z9v4I1ajwdiSUopJ
         BhQb6EBJcyVAshAVaw8ROITbQNbuqYfkckz6bxnDqmJ61T4wWSWGmkiUDolUFeLMF+Lw
         ttSASrFdG6oMpWqWD1xQbX8io0BQrOZbWPDVwMdHjj4UukGLj3OtetuejMvJiZQTqkhL
         3Gqu1lt3wkGTSLLZMXerfNBXhF2eATd1hIOrp2mASoLTkmRlsypaRlsllKf4gMDsOdJ4
         t6rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ3ci8nG+YWO+cF1BRIbDah8NVo9fDQWgDuq5hKvntLa6Spqny8lfgBQ0psQ4HI7stuRmxJDv1TtYNMpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybIs/pO6rolcNB46s3QTTE8lmLRT/HgqjA3LuoOx4g16Vd8E1D
	rCXthG8aOtV+TFScy8h0UtrO2L+a0ZUIgKjJtPsdjLArYZVx+tuWxzEUICdKeKAlUrcsxvQibf4
	yxPsvMLwMbfIQpodlWeNbwI+PeaibADNf1hapzFsCy5dvMovMKF3P2xTvPmJhAQ==
X-Received: by 2002:a05:600c:4f08:b0:428:eb6:2e73 with SMTP id 5b1f17b1804b1-42acc8ff8a4mr114663465e9.29.1724790592649;
        Tue, 27 Aug 2024 13:29:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9p6cSCAtvnsR9SBaBgeYoO/yiN9jJ6jcXKyLC5hcsffsuClFDitNVecB7jt3bzXPKN+kCCg==
X-Received: by 2002:a05:600c:4f08:b0:428:eb6:2e73 with SMTP id 5b1f17b1804b1-42acc8ff8a4mr114663255e9.29.1724790591680;
        Tue, 27 Aug 2024 13:29:51 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308157c55sm13920924f8f.46.2024.08.27.13.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:29:51 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de,
 efault@gmx.de
Subject: Re: [PATCH 12/24] sched/fair: Prepare exit/cleanup paths for
 delayed_dequeue
In-Reply-To: <Zs2d2aaC/zSyR94v@chenyu5-mobl2>
References: <20240727102732.960974693@infradead.org>
 <20240727105029.631948434@infradead.org>
 <xhsmh8qx0y4n0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240813215421.GA10328@noisy.programming.kicks-ass.net>
 <20240813220757.GA22760@noisy.programming.kicks-ass.net>
 <20240814055330.GA22686@noisy.programming.kicks-ass.net>
 <Zs2d2aaC/zSyR94v@chenyu5-mobl2>
Date: Tue, 27 Aug 2024 22:29:50 +0200
Message-ID: <xhsmhed69ogjl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 27/08/24 17:35, Chen Yu wrote:
> On 2024-08-14 at 07:53:30 +0200, Peter Zijlstra wrote:
>> On Wed, Aug 14, 2024 at 12:07:57AM +0200, Peter Zijlstra wrote:
>> > On Tue, Aug 13, 2024 at 11:54:21PM +0200, Peter Zijlstra wrote:
>> >
>> > Obviously I remember it right after hitting send...
>> >
>> > We've just done:
>> >
>> >    dequeue_task();
>> >    p->sched_class = some_other_class;
>> >    enqueue_task();
>> >
>> > IOW, we're enqueued as some other class at this point. There is no way
>> > we can fix it up at this point.
>>
>> With just a little more sleep than last night, perhaps you're right
>> after all. Yes we're on a different class, but we can *still* dequeue it
>> again.
>
> Not quite get this. If the old class is cfs, the task is in a rb-tree. And
> if the new class is rt then the task is in the prio list. Just wonder
> would the rt.dequeue break the data of rb-tree?
>

On a class change e.g. CFS to RT, __sched_setscheduler() would
dequeue_task() (take it out of the RB tree), change the class,
enqueue_task() (put it in the RT priolist).

Then check_class_changed()->switched_from_fair() happens, dequeue_task(),
and that takes it out of the RT priolist. At least that's the theory, since
that currently explodes...

> thanks,
> Chenyu


