Return-Path: <linux-kernel+bounces-260532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B33E893AA9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69822283B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4336BA47;
	Wed, 24 Jul 2024 01:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wfVjKEDj"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568A79F4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721784857; cv=none; b=n1L68jwDGrG4bm2FnDBnq34jNzbFOZXX4dQoUxyciCX1t+GYn2yj3X8HYwYdeOFRA5mrZPBfavPiUSOIAZkPvjAFRE4RMNt4BMeHjjRefPlpX+49XYdiss7NwcBEjscN6EXWN+38V8DlQuyoZd15gWHxIzPMJTzaB9xtUJ2izVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721784857; c=relaxed/simple;
	bh=aT+h210BT2JUWtrXjXFykcBpBDwnkrUWOD9dpgMA01M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LwVZAkuqcyjHUkEk8XhMqr0yt4NWyZ2KWHcVOJSSFNZwFx2IvrlAr7nKaKGewTvj0etT4JfiWqhASr6hKB9DpvYF87PtLtkg/69sypnzdrDRSv2Ir3XFU+f1WHDOI+EDvsOGXUUgpU8fhkyM4Wp3MMH9LerIDPvEikiomKlyVjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wfVjKEDj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd643d7580so56525ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721784855; x=1722389655; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IX7tUUTyuLfAxhlIQpJKT/5V3ggK/z1UtcxWyBnw4a4=;
        b=wfVjKEDjvCxn/B1iQdcYCD1m1EFcKGz2BEUiShmMZQ1m9qlAolXF2JRM/u+pK2EiZh
         HqDFwQatlk7i6xwiMJ88BMj6zQAHqaSeXwnd3YNel3deDw6fvuBh41+Vnan5DxGrVKkL
         Gz4yeiztX5YT85NptvvdDaIZ7otgfU2xKBBv87ZDzpVuDXXfgolzDUp4SqPVjq4EY6fy
         dtLQI3ikk8VYTcCf1f3E73CciPj90Y/wvaKij/zOzKj+jGfmsOsdfcAJlS/WXH/1g/ep
         whptJGQDnEeglVGto7qEvW/Aih94k3KORL10gftPdX6BdvT5CMHrAB5qDUafS4rXjQbm
         7LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721784855; x=1722389655;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IX7tUUTyuLfAxhlIQpJKT/5V3ggK/z1UtcxWyBnw4a4=;
        b=OE6yN2qDyUhkOePJn3g72RbuZAfcU5e6foZO4yknY0f8XhpOShN3xeLCL368aOfkDs
         hLW5WnsKVWuCIXrYycWVp+f6TqlKoXmn3DqSrEMhEq9e08AbFkFMJHGP5jGZDozRdJi1
         8yo9jxyZjcatT+mVK5WwNHSmgGrSLAnZVxGaSfSR59HOJCMseGCSTX/SPspiymtSOBSy
         I5V7Hx88EZQMUEBOzPir2VNP7qfOM5bcootjiFGyoFTHbZkw2Zroqx32gPEZL+fO6j/v
         uNb9bfR11a5IGWmmVV4GB2qei92nDoe1vx8wcgOJUm2NYRzqyUWarhnkabxAnRBJqBwn
         +RmA==
X-Gm-Message-State: AOJu0YyC+DHI0g+tivqLxJBhvGLRebU9efRfgJocriFjYcy8h34XLdVz
	LdWRY3qU8k9fZbZYQksl7y1unysVOK5XooIYayVcl4GycG4pHJSU3qZNRM9ibg==
X-Google-Smtp-Source: AGHT+IGr1O86WP3V8FbnoWAMwrvFj7oMhzGCnQawx3yLPJFJyNjoBduQsQUlIObs2knWQP7kZkbTpA==
X-Received: by 2002:a17:902:da8a:b0:1f9:dc74:6c2b with SMTP id d9443c01a7336-1fdd3d4c5e0mr1816955ad.29.1721784854584;
        Tue, 23 Jul 2024 18:34:14 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff4b8166sm7577995b3a.85.2024.07.23.18.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 18:34:14 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,  rcu@vger.kernel.org,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Juri Lelli
 <juri.lelli@redhat.com>,  Vincent Guittot <vincent.guittot@linaro.org>,
  Dietmar Eggemann <dietmar.eggemann@arm.com>,  Steven Rostedt
 <rostedt@goodmis.org>,  Mel Gorman <mgorman@suse.de>,  Phil Auld
 <pauld@redhat.com>,  Clark Williams <williams@redhat.com>,  Tomas Glozar
 <tglozar@redhat.com>,  "Paul E. McKenney" <paulmck@kernel.org>,  Frederic
 Weisbecker <frederic@kernel.org>,  Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>,  Joel Fernandes <joel@joelfernandes.org>,
  Josh Triplett <josh@joshtriplett.org>,  Boqun Feng
 <boqun.feng@gmail.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Lai Jiangshan <jiangshanlai@gmail.com>,
  Zqiang <qiang.zhang1211@gmail.com>,  Alexander Gordeev
 <agordeev@linux.ibm.com>,  Catalin Marinas <catalin.marinas@arm.com>,
  Arnd Bergmann <arnd@arndb.de>,  Guo Ren <guoren@kernel.org>,  Palmer
 Dabbelt <palmer@rivosinc.com>,  Andrew Morton <akpm@linux-foundation.org>,
  Oleg Nesterov <oleg@redhat.com>,  Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH v3 10/10] sched/fair: Throttle CFS tasks on return
 to userspace
In-Reply-To: <xhsmhikwwyw8r.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	(Valentin Schneider's message of "Tue, 23 Jul 2024 17:16:20 +0200")
References: <20240711130004.2157737-1-vschneid@redhat.com>
	<20240711130004.2157737-11-vschneid@redhat.com>
	<xm26y15yz0q8.fsf@google.com>
	<xhsmhikwwyw8r.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Date: Tue, 23 Jul 2024 18:34:11 -0700
Message-ID: <xm26a5i7zi7g.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Valentin Schneider <vschneid@redhat.com> writes:

> On 18/07/24 17:25, Benjamin Segall wrote:
>> Valentin Schneider <vschneid@redhat.com> writes:
>>
>>> I've tested a 10ms runtime / 100ms period cgroup with an always running
>>> task: upstream gets a "clean" periodic pattern of 10ms runtime every 100ms,
>>> whereas this gets something more like 40ms runtime every 400ms.
>>
>> Hmm, this seems a little odd since TWA_RESUME does a kick_process.
>
> I didn't ponder too much on the workload used here, but the point I wanted
> to bring up is: if you give a cgroup X amount of runtime, it may still
> consume more than that within a single period because execution in
> kernelspace isn't immediately stopped/throttled.
>
> It means the "standard" bandwidth control behaviour becomes a bit more
> bursty.

Yeah, more bursty behavior when doing cpu-burning syscalls is expected.
With the check on exit to user I wouldn't expect anything worse than the
duration of the syscall though, so it depends on what your test was.


>>> +
>>> +	/*
>>> +	 * Account tasks woken up in children; by this point all direct children
>>> +	 * have been visited.
>>> +	 */
>>> +	task_delta += cfs_rq->unthrottled_h_nr_running;
>>> +	idle_task_delta += cfs_rq->unthrottled_idle_h_nr_running;
>>> +
>>> +	cfs_rq->h_nr_running += task_delta;
>>> +	cfs_rq->idle_h_nr_running += idle_task_delta;
>>> +
>>> +	/*
>>> +	 * unthrottle_cfs_rq() needs a value to up-propagate above the
>>> +	 * freshly unthrottled cfs_rq.
>>> +	 */
>>> +	cfs_rq->unthrottled_h_nr_running = task_delta;
>>> +	cfs_rq->unthrottled_idle_h_nr_running = idle_task_delta;
>>
>> I think this should have no effect, right?
>
> Hm so my thoughts here are:
> The walk_tg_tree_from(tg_unthrottle_up) will update *nr_running counts up
> to the cfs_rq->tg->se[cpu_of(rq)]. However if that cfs_rq isn't the root
> one, we'll need the for_each_sched_entity() loop further down
> unthrottle_cfs_rq() to update the upper part of the hierarchy. The values
> that will be up-propagated there are the ones being saved here.

I'm pretty sure this comment was left over from when I didn't understand
what they were being used for. I'm pretty sure I remember intending to
remove it.


