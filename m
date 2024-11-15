Return-Path: <linux-kernel+bounces-410612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3313A9CDE08
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6E5282E07
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265FE1B652B;
	Fri, 15 Nov 2024 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIGCznIT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CCD1B21B6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731672385; cv=none; b=Qx+M9ymlyl9KqL07l6KCU2uzA6e3bmrEOacBm91P38m3GpTFGfVq4kPs3X7B1g5miE24iKSZf9RQemCqnqd9oZPXxbpVIdCK/g2znv51SGpLpsWO5T3M73tkbO5a6IdvaR6NnwNM95q7/acnG4orcpLgLf7H+5S0oLuFT+rVq+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731672385; c=relaxed/simple;
	bh=9cLYF5Y9N14G0jya0Gw2sFofAVNisnbAW2MEgFStvNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Us878ngBxGDhA4BmqwTzJso+iBoezmUvF57V45GaDroBNoYIp4ERyAHb5/syJQNAUUTOf4hI3LBnC6ZfYQw1HVsCIcbu+yoyUWhMISI+T6qbqRlFeSiMIuS+LniyRJHJerIoYGZ7UdzkMWR+Qij3C8w6B6TZ+nxUJRj/cLv9/Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VIGCznIT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731672382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dXKYfFH14d/tQ6qy22rrt9FvVPPlJ7Javhwa5aga5ck=;
	b=VIGCznIT54Yg5KtCe0BjvuTZQO5E/AbNCkgvNMydyPyrhC5treYz0dICA8u5OnQ64mH/al
	VRmermMrX04smAdpr9LDyllEipLANmvgAny/R7nFy6L3B1bVuB3ISIo+gELn7+ecX1g7BY
	KJg2mjoXKEyLqXIlecunRplGlQNA8ao=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-JFiRyRjzPyGR1xIl7Nl-Pw-1; Fri, 15 Nov 2024 07:06:20 -0500
X-MC-Unique: JFiRyRjzPyGR1xIl7Nl-Pw-1
X-Mimecast-MFC-AGG-ID: JFiRyRjzPyGR1xIl7Nl-Pw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5606250aso897500f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 04:06:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731672379; x=1732277179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXKYfFH14d/tQ6qy22rrt9FvVPPlJ7Javhwa5aga5ck=;
        b=KWyv+pmO6kzITdO7Mb2ERe5VxMqMjIbCv00pEYZZhFK/PtA793X0RyTaY2OuONHPko
         Q3g+Q+78JCTlidKjAb4kBhBPXue+e+0la88qsm+W4es1iickSYKUF10/TnG5L7bWnIWQ
         1FRjpCyH/KGarsFag+zbatpr1AbpBYGawk36tCpeMwKOjLrfD51ZV2VvsOrM/Ze0rPFL
         AwZuHQgdAu0lN53lGT4HOIar8pcuqHL7LQdMMvmxk2RdOZMnN9MRgAizwCcbRBfFDfmr
         D/vfcCy6FrZfA3XSYLqx6JHb7Ch/9xzlpEHP2X4Pwf3z3+sf62HL5fSK0AGRKa4Gfz2W
         jWLg==
X-Gm-Message-State: AOJu0YztkYi7pW9iMi71+ExI9i2chbV8rfuvhZUyJ0vttxhlUPCBYeW0
	iiURVNnpkwgnL+OHad7olX3SxyseceYKwWZZ0aKn7BVaUijLStQ6FZw0otvN3Zx0X5BXLCfDCFU
	LAsoPygIo8EH33Koff6zGSy8pS4Hq0N1ZvkRSBF0l4DIMhFhvN9+ndTeOUQSQUB2DRkJc0UW+
X-Received: by 2002:a05:6000:156b:b0:37d:5436:49b with SMTP id ffacd0b85a97d-3822590476cmr1855820f8f.13.1731672378999;
        Fri, 15 Nov 2024 04:06:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwGqn46v0gzfjomgwxM1BVXDUVHtJOb+t3C3YKWqeIhVYhUok1C59X+0aqnseP1q/9ZYQp3A==
X-Received: by 2002:a05:6000:156b:b0:37d:5436:49b with SMTP id ffacd0b85a97d-3822590476cmr1855796f8f.13.1731672378603;
        Fri, 15 Nov 2024 04:06:18 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada408dsm4169808f8f.10.2024.11.15.04.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 04:06:17 -0800 (PST)
Date: Fri, 15 Nov 2024 12:06:15 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Benjamin Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com,
	Davidlohr Bueso <dave@stgolabs.net>, regressions@lists.linux.dev,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] locking: rtmutex: Fix wake_q logic in
 task_blocks_on_rt_mutex
Message-ID: <Zzc5N_3jxOZ3ng3m@jlelli-thinkpadt14gen4.remote.csb>
References: <20241114190051.552665-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114190051.552665-1-jstultz@google.com>

Hi John,

On 14/11/24 11:00, John Stultz wrote:
> Anders had bisected a crash using PREEMPT_RT with linux-next and
> isolated it down to commit 894d1b3db41c ("locking/mutex: Remove
> wakeups from under mutex::wait_lock"), where it seemed the
> wake_q structure was somehow getting corrupted causing a null
> pointer traversal.
> 
> I was able to easily repoduce this with PREEMPT_RT and managed
> to isolate down that through various call stacks we were
> actually calling wake_up_q() twice on the same wake_q.
> 
> I found that in the problematic commit, I had added the
> wake_up_q() call in task_blocks_on_rt_mutex() around
> __ww_mutex_add_waiter(), following a similar pattern in
> __mutex_lock_common().
> 
> However, its just wrong. We haven't dropped the lock->wait_lock,
> so its contrary to the point of the original patch. And it
> didn't match the __mutex_lock_common() logic of re-initializing
> the wake_q after calling it midway in the stack.
> 
> Looking at it now, the wake_up_q() call is incorrect and should
> just be removed. So drop the erronious logic I had added.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@layalina.io>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Benjamin Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Metin Kaya <Metin.Kaya@arm.com>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: kernel-team@android.com
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: regressions@lists.linux.dev
> Cc: Thorsten Leemhuis <linux@leemhuis.info>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Fixes: 894d1b3db41c ("locking/mutex: Remove wakeups from under mutex::wait_lock")
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Closes: https://lore.kernel.org/lkml/6afb936f-17c7-43fa-90e0-b9e780866097@app.fastmail.com/
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---

LGTM.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri


