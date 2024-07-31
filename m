Return-Path: <linux-kernel+bounces-268933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959FE942B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DF9286B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65921AAE06;
	Wed, 31 Jul 2024 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1Ae4+WM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37663CF73
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419652; cv=none; b=VUP4sH6fsEf7XIvuRy6MRHOuRYGK41+4Yu+lAS7RvyojRiqX1MNFdz7YFDNP34vUmCoR3Az2T8cJClWwwkvge/yfbUUluRaI6YkM0JdrnKHtCr4wCnTFAnPkPFwsslSyVISTxIq+lb27eKATcbSMgqxj7+OFH4yaLsJ3re3dv8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419652; c=relaxed/simple;
	bh=dISmReQlh2SwRL29x9kCwA9FD5vEtI9HQRrQgEF4dU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RF1RhNZJmhmAw6TAuc4u00wQfEiKrOthx3DfM8fsw/kdGGxCo51QsYXx3CUClqLKdsqW6WMILhSqN2qb8tjcUr4FT2u3Jr73HXA2mPxXYLoa/SoGFuyh6CmxlxRQK5E67EabZIOpTgT+QZswYwFffHVk8sd/S73IBd2kCZ6tyLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1Ae4+WM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722419649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2wfMeqK09rbi9LwVAA4h/ZLoG3N2U7eInL651XH13XE=;
	b=d1Ae4+WMzTyleoT6iui12Tp1eJf7RHpbyVDP4oizvZ4S3aJ6LMr0cCI087BWjeXxrydbcG
	K61lTHCPyDTFSMPn4+FIm3Xi4D6Dq8heR2KW+jNchsJFsgr3dvU9W228gfk/WnjJB1v1cf
	OFL5GxxQUslOP16unC9QcBI3txe0z4U=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-6iMVXG8AOZ6KwZf_PZpKxA-1; Wed, 31 Jul 2024 05:54:08 -0400
X-MC-Unique: 6iMVXG8AOZ6KwZf_PZpKxA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a1dbbe6d6fso684986885a.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722419648; x=1723024448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wfMeqK09rbi9LwVAA4h/ZLoG3N2U7eInL651XH13XE=;
        b=Al9ZmqiSakhJJ34B2wP922mrcX4xSqYK986pYSw1xpDF491SOUHjPSxJztoIxFhrUj
         P/f9K+wrI02H1M0ZvDpUkZJ+84gwkgt/y26WjVO7p000VXpdpVKrbUaN+J5eY3VAIg6v
         eKt1RJ9tHd+Neh9jVhtC83P6RAmxxx4els/bN/TxTn/rP5hLj/GJKky+b9fEida2TDI1
         x+Gy8sxuHKSsgtZ5AMXDEbiVcU7WFCW/HPce9bf1a95M1dlw+/547OXhPuEtUwbQZWmn
         AWm6BFKam6NLTIZrTpE9nq9Z5tvlqHU/ndgwanmXz7wklZZ92v7fKdi3YCZ36G4YmFwo
         +AJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNrixQY3y0mxfMlBnNwIuwqUHaUM/53hwCL8OJW11h5fhTAAgI0arudy/B9kF4Oj5NJ9ZW4+e126JE/GCJKk0CTFFw8tiO5ThDadWW
X-Gm-Message-State: AOJu0Yznt3XahCZ0Zs+BUv1MxyNwDr0s0uIfMIvk0CmEkFjEgTNRsMyR
	27wysEAirPUhdhiCfxp5nG+8m8erQQ36PLfZIaE2qHo03tis0j9KLCGNv4UtdRjL7EqR+VaFfSl
	SKxJm5Td+G8o/Wu/uquewNRjbIgUSuubtoyR9Mru+0nS73oL4FTJ+gALF063K8A==
X-Received: by 2002:a05:620a:390d:b0:7a1:d5f3:c7d1 with SMTP id af79cd13be357-7a1e52545b4mr1643066585a.22.1722419647860;
        Wed, 31 Jul 2024 02:54:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxyG6RTf1AJPWZBXXEaxMF1mBkvr2bpnVwv5GZhUXV8qpgFv0kY8QPoUdli8IpSz2y6KvQuw==
X-Received: by 2002:a05:620a:390d:b0:7a1:d5f3:c7d1 with SMTP id af79cd13be357-7a1e52545b4mr1643063285a.22.1722419647490;
        Wed, 31 Jul 2024 02:54:07 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([2a02:b125:8010:68f9:cb3d:8fb3:24a5:346c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1eec80ae0sm388918485a.83.2024.07.31.02.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 02:54:07 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:53:58 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>
Subject: Re: [PATCH v11 7/7] sched: Split scheduler and execution contexts
Message-ID: <ZqoJtszWte1IvF0Q@jlelli-thinkpadt14gen4.remote.csb>
References: <20240709203213.799070-1-jstultz@google.com>
 <20240709203213.799070-8-jstultz@google.com>
 <20240712150158.GM27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712150158.GM27299@noisy.programming.kicks-ass.net>

On 12/07/24 17:01, Peter Zijlstra wrote:
> On Tue, Jul 09, 2024 at 01:31:50PM -0700, John Stultz wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Let's define the scheduling context as all the scheduler state
> > in task_struct for the task selected to run, and the execution
> > context as all state required to actually run the task.
> > 
> > Currently both are intertwined in task_struct. We want to
> > logically split these such that we can use the scheduling
> > context of the task selected to be scheduled, but use the
> > execution context of a different task to actually be run.
> > 
> > To this purpose, introduce rq_selected() macro to point to the
> > task_struct selected from the runqueue by the scheduler, and
> > will be used for scheduler state, and preserve rq->curr to
> > indicate the execution context of the task that will actually be
> > run.
> 
> > * Swapped proxy for selected for clarity
> 
> I'm not loving this naming...  what does selected even mean? What was
> wrong with proxy? -- (did we have this conversation before?)

Or maybe curr and sched_ctx as an alternative (if proxy confuses people
:), so that it's more direct/straightforward (even though it's not
symmetric)?


