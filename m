Return-Path: <linux-kernel+bounces-275990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C94E948CF4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEA41F24C54
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A109F1BE86E;
	Tue,  6 Aug 2024 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GOb2xykC"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9B15B54C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722940777; cv=none; b=kZ2EuqMZGIVXh6h0QD194oSFAElFtaNOjYw+pxPf8hzRVmplpFgd8A1lDVANGdE+zvOFj7hzxTVJDq7uQ1R/Txy32zXWWrO64bNLF0dijvQU00BbT0PRXR+7MqTsS7k8IPCAOB9EAJ7O/pKv6QKO31IHt6TDfW7lp+m6ZgywPl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722940777; c=relaxed/simple;
	bh=q4Y5msxJLDdqSHUidDCRbWsywG04LxO/kcGEtcDMcUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bemjwb49OxVDfI/yqI7OOn4FxRa4PrxxVGGEFW7C6gxVMo2FXOrkSgrK2vAqKYckauw2ndNtdHBE7gzguGCME0RIETdMjGd5hA7TgD1ws7Mo8bN1Mjh8xNwlpwEY9O3RMoyDy0JykjySbTr9pSBPaK4mm+2+4VOFPZD+zu0e60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GOb2xykC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DGNnOD/ncB9uIMZlnBUhnl/FC/huOzlX+hkkh4rYu28=; b=GOb2xykCcsch2NGFLdpQplas9j
	+1dQ7hVqODf0sh3zgXSaeH29K42B8CtIVFzacJXEcXNZ15OhnnIs6hNRLjchJhQ/6lhjrrxejZBia
	OKtCfA21jLCIb+zH9bptzHSwVODLjMHaEdITs9H6BAGzYysS71ws7AtP1xnNeIJr1gMZWCVlWbiDv
	9bHMDxjse7r/wtbr9fiPimpPjxKSqpipjLk+yf3jh3Cm6JBthJU4jev58kmGBkppl4HsK7CJdlJri
	wuOxEtpvE3zH075HiE/HgQ+6J+oAW3jB1NTVvf/TH/4LAOh7NEn6yoiB2sDWJDdbgHtOjP/TWfM/A
	UxEi1JiQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbHbD-00000005afk-0lo0;
	Tue, 06 Aug 2024 10:39:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CF3D330049D; Tue,  6 Aug 2024 12:39:26 +0200 (CEST)
Date: Tue, 6 Aug 2024 12:39:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Bin Lai <laib2@chinatelecom.cn>
Subject: Re: [PATCH next] sched: make printk safe when rq lock is held
Message-ID: <20240806103926.GU37996@noisy.programming.kicks-ass.net>
References: <20240806074131.36007-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806074131.36007-1-dongml2@chinatelecom.cn>

On Tue, Aug 06, 2024 at 03:41:31PM +0800, Menglong Dong wrote:
> The dead lock can happen if we try to use printk(), such as a call of
> SCHED_WARN_ON(), during the rq->__lock is held. The printk() will try to
> print the message to the console, and the console driver can call
> queue_work_on(), which will try to obtain rq->__lock again.
> 
> This means that any WARN during the kernel function that hold the
> rq->__lock, such as schedule(), sched_ttwu_pending(), etc, can cause dead
> lock.
> 
> Following is the call trace of the deadlock case that I encounter:
> 
>   PID: 0      TASK: ff36bfda010c8000  CPU: 156  COMMAND: "swapper/156"
>    #0 crash_nmi_callback+30
>    #1 nmi_handle+85
>    #2 default_do_nmi+66
>    #3 exc_nmi+291
>    #4 end_repeat_nmi+22
>       [exception RIP: native_queued_spin_lock_slowpath+96]
>    #5 native_queued_spin_lock_slowpath+96
>    #6 _raw_spin_lock+30
>    #7 ttwu_queue+111
>    #8 try_to_wake_up+375
>    #9 __queue_work+462
>   #10 queue_work_on+32
>   #11 soft_cursor+420
>   #12 bit_cursor+898
>   #13 hide_cursor+39
>   #14 vt_console_print+995
>   #15 call_console_drivers.constprop.0+204
>   #16 console_unlock+374
>   #17 vprintk_emit+280
>   #18 printk+88
>   #19 __warn_printk+71
>   #20 enqueue_task_fair+1779
>   #21 activate_task+102
>   #22 ttwu_do_activate+155
>   #23 sched_ttwu_pending+177
>   #24 flush_smp_call_function_from_idle+42
>   #25 do_idle+161
>   #26 cpu_startup_entry+25
>   #27 secondary_startup_64_no_verify+194
> 
> Fix this by using __printk_safe_enter()/__printk_safe_exit() in
> rq_pin_lock()/rq_unpin_lock(). Then, printk will defer to print out the
> buffers to the console.

Nope, sorry, not happening.

