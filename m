Return-Path: <linux-kernel+bounces-357087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ABC996B56
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B78A1F25A46
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456E3194C96;
	Wed,  9 Oct 2024 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vgx2qRYa"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D33C192B77
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479139; cv=none; b=VMfV0dWYngM1NLWGCSDVaAXWn7KZyMoJnxbeZlZfunp2qlPR0ZVjtIqW3PYb7o8su0d6P5KlCqrGNIGfnyynRnoLuju8eOnMvYEn18kkQNBHRnIqD/ekzLVkpoSsYIXHKvT7Er5xXONfmwWqGtf1k38wMX6B0BKA6KE+Dvn63AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479139; c=relaxed/simple;
	bh=4NOEau2uX2dqSpD63GnG5MaHsk67KViGc7ZlZXT2mHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDhyjMOwtGYXPS0NaZXRo7yl78QEcXZky6tem/Gz/A8htOmaOvFaPRCXW1Ua16ro5mO8SMwrjv5zR0fi7Rwbc4CZNS0QZpBSpp4D9sHMSPF564vYFOIWOS6uYCzTaOk4F0+Fe2hGR8kl68VGqMyP+T47Pyao/hxs6et2olWus1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vgx2qRYa; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zAIwW0GGFjJMqo/Ec7vOEM/ksT01wH4zeDme46btrJo=; b=Vgx2qRYawpc5JRjYVS+9CrTpFc
	dKJ4rFjP1MZRFfqw798/wIN9Iv/Vv62VQtKy5FGSFcNLWrregbmKR6VFT945p93CAoU65Jdsg/juj
	7oSo1Y5rRmAdl+zJjCJ7Yju30RV/l2rhVHXcQ4zEYSRkHBSVGv/vXLx0ySZf18dJdf+JPwSxCL3pg
	wbpVn6k1/wwKA5rp/YwKGFtvA4m3NxPptX2G5WdihEOz8899Xvggxv53Iik8wkKpNIR+S4WiPM3Pw
	YzDgQkFGOmrwA+hb+ngJjK5FV4IXHJL1YB8zRZO/SzBukqzTKWBjEmlsdIZGWJdZroErha/zMshP7
	HuW5b2kA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syWNf-00000004xZz-0aPE;
	Wed, 09 Oct 2024 13:05:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BEAA530057A; Wed,  9 Oct 2024 15:05:30 +0200 (CEST)
Date: Wed, 9 Oct 2024 15:05:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] sched: idle: Optimize the generic idle loop by
 removing needless memory barrier
Message-ID: <20241009130530.GO17263@noisy.programming.kicks-ass.net>
References: <20241009093745.9504-1-quic_zhonhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009093745.9504-1-quic_zhonhan@quicinc.com>

On Wed, Oct 09, 2024 at 05:37:45PM +0800, Zhongqiu Han wrote:
> The memory barrier rmb() in generic idle loop do_idle() function is not
> needed, it doesn't order any load instruction, just remove it as needless
> rmb() can cause performance impact.
> 
> The rmb() was introduced by the tglx/history.git commit f2f1b44c75c4
> ("[PATCH] Remove RCU abuse in cpu_idle()") to order the loads between
> cpu_idle_map and pm_idle. It pairs with wmb() in function cpu_idle_wait().
> 
> And then with the removal of cpu_idle_state in function cpu_idle() and
> wmb() in function cpu_idle_wait() in commit 783e391b7b5b ("x86: Simplify
> cpu_idle_wait"), rmb() no longer has a reason to exist.
> 
> After that, commit d16699123434 ("idle: Implement generic idle function")
> implemented a generic idle function cpu_idle_loop() which resembles the
> functionality found in arch/. And it retained the rmb() in generic idle
> loop in file kernel/cpu/idle.c.
> 
> And at last, commit cf37b6b48428 ("sched/idle: Move cpu/idle.c to
> sched/idle.c") moved cpu/idle.c to sched/idle.c. And commit c1de45ca831a
> ("sched/idle: Add support for tasks that inject idle") renamed function
> cpu_idle_loop() to do_idle().
> 
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git

Thanks!

