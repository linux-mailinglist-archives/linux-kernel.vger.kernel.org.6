Return-Path: <linux-kernel+bounces-252919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC949319E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C750F282E87
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A9A56440;
	Mon, 15 Jul 2024 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4p6krJH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6DD4E1C8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721066290; cv=none; b=iZwOc9ywJKlRIvX6qowMjxoKEgQ33jCY3QIsvBnXsPXWQeBOVD2kF+6cXJMAXtbOTbGWLMCJIJTFJ6IHa/VuqdVCsb39zqVGKYwmEnnnu0MwPYbN6Uch5jNGzURbInCJGscBOXEltgnlytvW2e1nOcouE9zz3lbi5+NObBz//5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721066290; c=relaxed/simple;
	bh=Ain5nSPiw7lNbJABKbWUNj9bz6NYPkehR1zADRdCQoU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wr2/0zoNW2KRcc2ckXhZScYYSmlKZo2uBwrZb101FImWpo1xrMkzI2UnUI01bO1hreYTV3xRwuJH/XsbbIjOQjP0ViUjlr1V8P6mVsqK7cyVFqVm/BvCN3GF93ycp15Qfb+eoQcg1xuaopyA6IRRTpZWNjgFeGhJ8a5hExrboug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X4p6krJH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721066288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NyVNluZIssgAn1o8oMq9PDVu4RkJuOP1nUmOEKmGOcU=;
	b=X4p6krJHPw4PmKJBcgzP6cZwrv3Be7aYOfQGEYFwyeSSauEj3Xd0S4DHrcC8ZSgwNngwjy
	9MnL1R2sntO/kxfozU0a+z/8Bff8deKwKEY4dV971CxmQOexNL8h/afZ6H27hhhZCySuia
	MYcrsXxva7+9w5hjq+YvUkoyrXaw5kk=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-QWrKbE7-M1aqRANSWKc4Mg-1; Mon, 15 Jul 2024 13:58:06 -0400
X-MC-Unique: QWrKbE7-M1aqRANSWKc4Mg-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3d9de099758so3963354b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721066286; x=1721671086;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyVNluZIssgAn1o8oMq9PDVu4RkJuOP1nUmOEKmGOcU=;
        b=oYd7I21Mm5ZmUOkqGiigAgJYvWCdw8Y5GZIBNC7QmJqIbeVgX5qe4E8FLY7VQJ4+rd
         LzyAdng7GWgV815zIMLezAjUTy3EhHKEf1Aa6ntAIPtAb4Ohstvf3A9ZLDaALvGDQW0U
         fo+uxtfdhVXCQ88OVQx3YjAtgszL6gjoif8pQjF7InyoYzMtAEiJLWJdfdk81bX8J27g
         0HLgFHkTYE5n1vA4TjYSkzNAMOAODx/r6ZFfbTTiYi/Y1Kf6I/lZxE7p9YAc/HzLseNe
         ZIsfO5+x+UaC5b1DbGvQJz36e0iaJspA2mo8IIizdJhp7qxZOnFV4Bc+2Mq1ibve/g7J
         rOQA==
X-Gm-Message-State: AOJu0YyVTqHbSNwfMdjG7xmzNZ2btoxogXqMdi8gy+88i2sNbos11+xn
	3aLpuAuYEwYC2QYe8erXCrh0z1IMSeWI3ucdYoix1+4sLbfJlAtrtoalXHnRWcEXkaowHJzzg2K
	+zBmtVXq7IST3D4nIUOLdjpWxbZGF5/sclQWZ2rKKtOuUY6TPe4zYoBKTJoayCw==
X-Received: by 2002:a05:6808:2225:b0:3d9:3e48:8b13 with SMTP id 5614622812f47-3dac632346cmr362249b6e.10.1721066286028;
        Mon, 15 Jul 2024 10:58:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVCU8MN7DhrLsiuwZc963RljtvATaJVy4fNJFEYXFUGjmBmJoDfzyTAMTP0WdwPNOir3nLCg==
X-Received: by 2002:a05:6808:2225:b0:3d9:3e48:8b13 with SMTP id 5614622812f47-3dac632346cmr362221b6e.10.1721066285770;
        Mon, 15 Jul 2024 10:58:05 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160b908c3sm221471585a.25.2024.07.15.10.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 10:58:04 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Phil Auld <pauld@redhat.com>, Clark Williams
 <williams@redhat.com>, Tomas Glozar <tglozar@redhat.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, Arnd
 Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Palmer Dabbelt
 <palmer@rivosinc.com>, Andrew Morton <akpm@linux-foundation.org>, Oleg
 Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH v3 03/10] task_work, sched: Add a _locked variant to
 task_work_cancel()
In-Reply-To: <20240712152021.GR27299@noisy.programming.kicks-ass.net>
References: <20240711130004.2157737-1-vschneid@redhat.com>
 <20240711130004.2157737-4-vschneid@redhat.com>
 <20240712152021.GR27299@noisy.programming.kicks-ass.net>
Date: Mon, 15 Jul 2024 19:57:59 +0200
Message-ID: <xhsmhle221qs8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 12/07/24 17:20, Peter Zijlstra wrote:
> On Thu, Jul 11, 2024 at 02:59:57PM +0200, Valentin Schneider wrote:
>> Later commits will need to issue a task_work_cancel() from within the
>> scheduler with the task's ->pi_lock held.
>> 
>> Add a _locked variant that expects p->pi_lock to be held. Expose it in a
>> separate scheduler header file, as this really is a scheduler-only
>> interface.
>> 
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  kernel/sched/task_work_sched.h | 14 +++++++
>>  kernel/task_work.c             | 67 ++++++++++++++++++++++++++--------
>>  2 files changed, 66 insertions(+), 15 deletions(-)
>>  create mode 100644 kernel/sched/task_work_sched.h
>> 
>> diff --git a/kernel/sched/task_work_sched.h b/kernel/sched/task_work_sched.h
>> new file mode 100644
>> index 0000000000000..e235da456427f
>> --- /dev/null
>> +++ b/kernel/sched/task_work_sched.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Scheduler internal task_work methods
>> + */
>> +#ifndef _KERNEL_TASK_WORK_SCHED_H
>> +#define _KERNEL_TASK_WORK_SCHED_H
>> +
>> +#include <linux/task_work.h>
>> +#include <linux/sched.h>
>> +
>> +struct callback_head *
>> +task_work_cancel_locked(struct task_struct *task, task_work_func_t func);
>> +
>> +#endif
>
>
> Do we really need that exposed? Can't we squirrel that way in
> kernel/sched/sched.h and forget about it?
>

Nah that's not required, I thought a clean cut header would be neater but
given its single user, tossing that to sched.h looks better.

>> +struct callback_head *
>> +task_work_cancel_locked(struct task_struct *task, task_work_func_t func)
>> +{
>> +	lockdep_assert_held(&task->pi_lock);
>
> I'm thinking that lockde_assert wants to live in your _locked function
> above.
>

Quite so!


