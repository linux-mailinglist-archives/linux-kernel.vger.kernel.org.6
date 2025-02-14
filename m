Return-Path: <linux-kernel+bounces-515629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 161D1A366D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9395E1895669
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60D91C862E;
	Fri, 14 Feb 2025 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kDA28hb0"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416A81917F1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739564689; cv=none; b=by1TKkXRZaqkNGVfLc6czEMNdrFCastcnXFVEDdsbXdN5gUA1W2gHudLrL7Mx1LqD7FBMDoW6I6UC0UYD7+m1w202H0JwqlH2ORBQL9HuFpEecekRx/67v53NDNPTFHwQz0bJaARdumBgObWcy/e9uVWfLgEGszPvc0Gi4vXSXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739564689; c=relaxed/simple;
	bh=kDCHjqf+tITo9cR0qNmxoVWjoLGUdueCDAuclCPtD0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujwWPVSYXKQGvzvtt4V3MeW7GsOcQcEUCN5HxpQK20AA0agu28dvgT4GqZya2KYdOW90FsTPdBfxoKlh91j2a//sIF5NavN9jMQrgq5zkzuGl5z384YImQAtDBPLZif8E0+G81DIweWmdBO7v98u9u4RdsqKCmmsx9Os0QgT4mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kDA28hb0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k5mlGd161Fb2mbXOpGK8vr/0cBDbeNy3jyIyWjvgX10=; b=kDA28hb0oVD0ZQHivzbsb8Dg1G
	OV99FtgkkVHixzD6XhpCjgG/6Glyv+w3eJBJLcUeeekF9g6+zlOV/paVomtE3eji/g1kMhNFLXdOw
	JtoK+hOt3e3rn+n89aViKmX6SyBQeJcyHYzu9pDXwZh1pZ8th4bUwT/4Wp5iNGUr57HA8/d6IuZry
	q7f659es1crXk4g+hTUmUWb4SMxFwd2mKPOe0kd1q2OmbtpzAes0Wlk3ct++5rrjq7QLx4ZM3YRFC
	x3PurT6+O8O1mIPGIW6Zp7MDzqczpG2Ymb4ITNQamJsX9eCus9oQMgbJ7ihgJ1dqgJVgo7UAtKvyq
	VsICRgDQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tj2Eq-00000001KoV-1lXa;
	Fri, 14 Feb 2025 20:24:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C03713002F0; Fri, 14 Feb 2025 21:24:38 +0100 (CET)
Date: Fri, 14 Feb 2025 21:24:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: mingo@kernel.org, lucas.demarchi@intel.com,
	linux-kernel@vger.kernel.org, willy@infradead.org, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: Re: [PATCH v2 24/24] perf: Make perf_pmu_unregister() useable
Message-ID: <20250214202438.GB2198@noisy.programming.kicks-ass.net>
References: <20250205102120.531585416@infradead.org>
 <20250205102450.888979808@infradead.org>
 <1f4e4bb1-ba5e-4e5f-b6e3-e7603e3d6b0e@amd.com>
 <20250212124945.GH19118@noisy.programming.kicks-ass.net>
 <57fa247d-9c85-4f20-9723-d568272651f9@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57fa247d-9c85-4f20-9723-d568272651f9@amd.com>

On Thu, Feb 13, 2025 at 01:22:55PM +0530, Ravi Bangoria wrote:
> Apparently not, it ends up with:
> 
>   ------------[ cut here ]------------
>   WARNING: CPU: 145 PID: 5459 at kernel/events/core.c:281 event_function+0xd2/0xf0
>   WARNING: CPU: 145 PID: 5459 at kernel/events/core.c:286 event_function+0xd6/0xf0

>    remote_function+0x4f/0x70
>    generic_exec_single+0x7f/0x160
>    smp_call_function_single+0x110/0x160
>    event_function_call+0x98/0x1d0
>    _perf_event_disable+0x41/0x70
>    perf_event_for_each_child+0x40/0x90
>    _perf_ioctl+0xac/0xb00
>    perf_ioctl+0x45/0x80

Took me a long while trying to blame this on the 'event->parent =
NULL;', but AFAICT this is a new, unrelated issue.

What I think happens is this perf_ioctl(DISABLE) vs pmu_detach_events()
race, where the crux is that perf_ioctl() path does not take
event2->mutex which allows the following interleave:


	   event1  <---> ctx1
	    |  ^
 child_list |  | parent
	    v  |
	   event2  <---> ctx2


perf_ioctl()
  perf_event_ctx_lock(event1)
    get_ctx(ctx1)
    mutex_lock(ctx1->mutex)
  _perf_ioctk()
    perf_event_for_each_child()
     mutex_lock(event1->child_mutex)
     _perf_event_disable(event1)
     _perf_event_disable(event2)
       raw_spin_lock_irq(ctx2->lock)
       raw_spin_unlock_irq()
       event_function_call(event2, __perf_event_disable)
         task_function_call()
           <IPI __perf_event_disable>


pmu_detach_events()
  event2 = pmu_get_event() <-- inc(event2->refcount);
  pmu_detach_event(event2)
    perf_event_ctx_lock(event2)
      get_ctx(ctx2)
      mutex_lock(ctx2->lock)
    __pmu_detach_event()
      perf_event_exit_event()
        mutex_lock(event1->child_mutex)
        perf_remove_from_context(event2, EXIT|GROUP|CHILD|REVOKE)
          lockdep_assert_held(ctx2->mutex)
          raw_spin_lock_irq(ctx2->lock)
          raw_spin_unlock_irq(ctx2->lock)
          event_function_call(event2, __perf_remove_from_context)
            task_function_call(event_function)
	      <IPI __perf_remove_from_context>
                remote_function()
                  event_function()
                    perf_ctx_lock(cpuctx, ctx2)
                      raw_spin_lock(ctx2->lock)
                    __perf_remove_from_context(event2)
                    event_sched_out()
                    perf_group_detach()
                    perf_child_detach()
                    list_del_event()
                    event->state = REVOKED;
                    cpc->task_epc = NULL; // event2 is last
                    ctx->is_active = 0;         <--.
                    cpuctx->task_ctx = NULL;       |
                                                   |
                                                   |
           <IPI __perf_event_disable>              |
             remote_function()                     |
               event_function()                    |
                 perf_ctx_lock(cpuctx, ctx2)       |
                   raw_spin_lock(ctx2->lock)       |
                                                   |
                 WARN_ON_ONCE(!ctx2->is_active)   -'
                 WARN_ON_ONCE(cpuctx->task_ctx != ctx2)


Still trying to work out how best to avoid this.

