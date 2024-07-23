Return-Path: <linux-kernel+bounces-259773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 655F5939CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BF0282844
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435F914C5A3;
	Tue, 23 Jul 2024 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzvELRXH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CA1DDDC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721724676; cv=none; b=T9ZpXUDu9/i/zb81CA+t0ijxjI+YDrlRsIJxOZvrJJFZDvlAF5SQ6mhkyY2IikkZiS0FGOZSMogowFFHntT83NdoCknhDaVpiWmrknd8n45IoPK9UP1Fg3FTcsG92n0VMRq97uakeF9B530S4beysJF4SaOavZaBs7Y39hiGsDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721724676; c=relaxed/simple;
	bh=QuSt6B6kzEKTZfKHkVdmo7hwn8phjl+T48W87+wmF8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+FsdYe1TorpOpQAZNh27CO1d/UrCdEstli7nWYCJRyuysTZNyGnyt2iMBRUHqGqnbvhIE2nJ3lnFQVrOuUhE4nbMBdwQxKogAo1a7xLO7YlJy/lK6c2AnAPfykpCDRc+1wZXW2o30FNKPdos58/bkrEkpnMbF8zPHfaPPzvDQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzvELRXH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721724672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XbO198UeBpGnMCQfzSOZVL6WBSEYJ6mYl66ERaEPV4s=;
	b=VzvELRXHLXHenXCrdNIMmitCWpRQV03F+65flC8fsI5KMZshQy5KEhGuQMZsvgnIcvAiVN
	ll9VaWYwQJUYBhlBmLyZjqgFCXhynkJdxdVCfdb661TNrGQ4cCpr6ceaDCBU5q6M2hLXxB
	t+ZhogoE9lelP25GRM4WycDSCdo2Nn0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-vremut5uN2uPOCGBwKUrJw-1; Tue, 23 Jul 2024 04:50:27 -0400
X-MC-Unique: vremut5uN2uPOCGBwKUrJw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-79efed0e796so966157185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721724626; x=1722329426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbO198UeBpGnMCQfzSOZVL6WBSEYJ6mYl66ERaEPV4s=;
        b=U9b1uCRkGsXHG0s4wTrPMqLfxsccNcJjJWqGQz2XK3BEylQfSe/zh+kpRZ+bE+VHJe
         MIN1GWT5vaC64kSk3jHdRhiwPmT3fF3TDjf2ZsRuHrq/s9rdAkGxcFb3veOEl+BvrJSA
         vMbgsGqmXxv+Bndj7K4NidTO0Zuurf/N7xfEGNp+XMjKQUfaDEWpFui1jxwEuTUbeIfC
         rX2Z8AwYdQqgEEEoKvV4DnGyEXki6sJfzHRe6Y2BEadZWYc+ZobinXG4ZzdPfjTER8fg
         Wur9M//Txey0Gieta4jOAHYrJ1uJv1F7rr+GecOs7pyamY3gBB51BOHLYVaE3+5J+OVy
         bRNg==
X-Forwarded-Encrypted: i=1; AJvYcCXWi0Fi8pfm4YwhShkeMYpkxf+WkrSb4IwGylzdXBUl2IxRF9P+E6m7DrcLNkf4EiA1/+Fn2rjfKz89fkBq3/IqQaODTt7jxpsBVgB2
X-Gm-Message-State: AOJu0YwsGjCstTTlgHCcorypzQAEUYO9xRyDwg7AOu2dIWNTcZig9vBL
	QJAnF3FxitjMfwVSTaViDMQhVgj1U6pU9rDRjOMvmA9tSr2hOmVKhUTez094SrNlk28XaxTDVQD
	4klsAbkHeq8hS/w987PHQxQw9ecX2kW5RejidGoolKBbjTu+EQtYGBGVwcKXQZA==
X-Received: by 2002:a05:620a:258c:b0:79d:554d:731f with SMTP id af79cd13be357-7a1c2f7a5c3mr200368885a.29.1721724626412;
        Tue, 23 Jul 2024 01:50:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhdCv2zyLBW2MPFzcEt5RuedOMCGTU5EbDG4xwsuhayOt6swlOH697xhnSfXmhCPk2Xg+IFA==
X-Received: by 2002:a05:620a:258c:b0:79d:554d:731f with SMTP id af79cd13be357-7a1c2f7a5c3mr200366885a.29.1721724626072;
        Tue, 23 Jul 2024 01:50:26 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.147.11])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198faaff2sm458653685a.27.2024.07.23.01.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 01:50:25 -0700 (PDT)
Date: Tue, 23 Jul 2024 10:50:21 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] sched/deadline: Fix warning in migrate_enable for
 boosted tasks
Message-ID: <Zp9uzXUwbJOpuwsv@jlelli-thinkpadt14gen4.remote.csb>
References: <20240722132935.14426-1-wander@redhat.com>
 <20240722132935.14426-2-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722132935.14426-2-wander@redhat.com>

Hi Wander,

On 22/07/24 10:29, Wander Lairson Costa wrote:
> When running the following command:
> 
> while true; do
>     stress-ng --cyclic 30 --timeout 30s --minimize --quiet
> done
> 
> a warning is eventually triggered:
> 
> WARNING: CPU: 43 PID: 2848 at kernel/sched/deadline.c:794
> setup_new_dl_entity+0x13e/0x180
> ...
> Call Trace:
>  <TASK>
>  ? show_trace_log_lvl+0x1c4/0x2df
>  ? enqueue_dl_entity+0x631/0x6e0
>  ? setup_new_dl_entity+0x13e/0x180
>  ? __warn+0x7e/0xd0
>  ? report_bug+0x11a/0x1a0
>  ? handle_bug+0x3c/0x70
>  ? exc_invalid_op+0x14/0x70
>  ? asm_exc_invalid_op+0x16/0x20
>  enqueue_dl_entity+0x631/0x6e0
>  enqueue_task_dl+0x7d/0x120
>  __do_set_cpus_allowed+0xe3/0x280
>  __set_cpus_allowed_ptr_locked+0x140/0x1d0
>  __set_cpus_allowed_ptr+0x54/0xa0
>  migrate_enable+0x7e/0x150
>  rt_spin_unlock+0x1c/0x90
>  group_send_sig_info+0xf7/0x1a0
>  ? kill_pid_info+0x1f/0x1d0
>  kill_pid_info+0x78/0x1d0
>  kill_proc_info+0x5b/0x110
>  __x64_sys_kill+0x93/0xc0
>  do_syscall_64+0x5c/0xf0
>  entry_SYSCALL_64_after_hwframe+0x6e/0x76
>  RIP: 0033:0x7f0dab31f92b
> 
> This warning occurs because set_cpus_allowed dequeues and enqueues tasks
> with the ENQUEUE_RESTORE flag set. If the task is boosted, the warning
> is triggered. A boosted task already had its parameters set by
> rt_mutex_setprio, and a new call to setup_new_dl_entity is unnecessary,
> hence the WARN_ON call.
> 
> Check if we are requeueing a boosted task and avoid calling
> setup_new_dl_entity if that's the case.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Fixes: 2279f540ea7d ("sched/deadline: Fix priority inheritance with multiple scheduling classes")

I believe your fix makes sense to me. I only wonder if however it
actually fixes 295d6d5e37360 ("sched/deadline: Fix switching to
-deadline") instead of the change you reference above?

Thanks,
Juri


