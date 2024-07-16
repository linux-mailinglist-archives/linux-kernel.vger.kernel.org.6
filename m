Return-Path: <linux-kernel+bounces-253532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CA793228F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC5C1C21B00
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6745C19538C;
	Tue, 16 Jul 2024 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mv6Y/wD9"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D35333C5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121405; cv=none; b=HQ37XBh5Uwe9Cx5hzOB7juJIlA6ijcVhkXx2FMvdtE7O2/xmwXVyIWz6NsHYCff1vpQwmK4sy/cSk0k7+S+jSmhOCiI9jMOb9Oz4DmSbXpuPeIpjvl6PXjvgTQSwWyRr2PE6SADWaOrqpwHCo94GeV+jPV+Db+PKt19VRm+EMFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121405; c=relaxed/simple;
	bh=OcYFxFwD1zyvRyXWAjug80yxWWHETJTnfUsMmsUMR04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyJOyfXdTiQwXNd75yxuoVm5aUYF7SNVKVZVDBXuUCqp0h9ftXwKp0AqfbPeQ3jNFuvUuOqurZtSfIvgHZBdB5uLlw9H2BQ6GuAnjdeKZK3Kbs0mzhmbKqMqgUucrrPueA5JQrt/5TejGBckDsp1R3haaBL6pPTiwwUX5RswnZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mv6Y/wD9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JC7zuP3uglh/e+Uh4F75W/F2+8YMHqY2AsW50eThHAU=; b=Mv6Y/wD9LhxHmHU0wtqgQiatX4
	96/sHxSknx8C4K4GrLvYgQUusMlT0kHf0Mao6agMOgDN+8a/XqrbiMACdfbaGi3OeftUvTw5VT8s9
	eE3VibMsyVsezccq39QRsFyw9JDaNkNRBvaBTLj0rIG2hiVgi4AnQc3+bQnIxrDUNUIC5r+ZcgluW
	XPxT2C+6UBnmkQicLOUM5hBPpKqzHd9C6zu58XFQwI71Sid2NI4ModZn+P8m2zvCQFvNk5fMgAFvO
	NPDMRYDpp35wrNCyCDS/yZTYJniJTjKeM8SsCBQNoVybB0ixUN77Qotl6LBNfgMVYOsdGCP6jM26+
	8bMpYhrg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTeIZ-000000020mM-2Yz2;
	Tue, 16 Jul 2024 09:16:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 41FD73003FF; Tue, 16 Jul 2024 11:16:39 +0200 (CEST)
Date: Tue, 16 Jul 2024 11:16:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: xu.xin16@zte.com.cn
Cc: bsegall@google.com, dietmar.eggemann@arm.com, fan.yu9@zte.com.cn,
	he.peilin@zte.com.cn, jiang.kun2@zte.com.cn, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, liu.chun2@zte.com.cn, mgorman@suse.de,
	mingo@redhat.com, rostedt@goodmis.org, tu.qiang35@zte.com.cn,
	vincent.guittot@linaro.org, yang.yang29@zte.com.cn,
	zhang.yunkai@zte.com.cn
Subject: Re: [PATCH linux-next v3 RESEND] sched/core: Add WARN_ON_ONCE() to
 check overflow for migrate_disable
Message-ID: <20240716091639.GB26750@noisy.programming.kicks-ass.net>
References: <20240716104244764N2jD8gnBpnsLjCDnQGQ8c@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716104244764N2jD8gnBpnsLjCDnQGQ8c@zte.com.cn>

On Tue, Jul 16, 2024 at 10:42:44AM +0800, xu.xin16@zte.com.cn wrote:
> From: Peilin He <he.peilin@zte.com.cn>
> 
> Background
> ==========
> When repeated migrate_disable() calls are made with missing the
> corresponding migrate_enable() calls, there is a risk of
> 'migration_disabled' going upper overflow because
> 'migration_disabled' is a type of unsigned short whose max value is
> 65535.
> 
> In PREEMPT_RT kernel, if 'migration_disabled' goes upper overflow, it may
> make the migrate_disable() ineffective within local_lock_irqsave(). This
> is because, during the scheduling procedure, the value of
> 'migration_disabled' will be checked, which can trigger CPU migration.
> Consequently, the count of 'rcu_read_lock_nesting' may leak due to
> local_lock_irqsave() and local_unlock_irqrestore() occurring on different
> CPUs.
> 
> Usecase
> ========
> For example, When I developed a driver, I encountered a warning like
> "WARNING: CPU: 4 PID: 260 at kernel/rcu/tree_plugin.h:315
> rcu_note_context_switch+0xa8/0x4e8" warning. It took me half a month
> to locate this issue. Ultimately, I discovered that the lack of upper
> overflow detection mechanism in migrate_disable() was the root cause,
> leading to a significant amount of time spent on problem localization.
> 
> If the upper overflow detection mechanism was added to migrate_disable(),
> the root cause could be very quickly and easily identified.
> 
> Effect
> ======
> Using WARN_ON_ONCE() to check if 'migration_disabled' is upper overflow
> can help developers identify the issue quickly.
> 
> Signed-off-by: Peilin He<he.peilin@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> Reviewed-by: Qiang Tu <tu.qiang35@zte.com.cn>
> Reviewed-by: Kun Jiang <jiang.kun2@zte.com.cn>
> Reviewed-by: Fan Yu <fan.yu9@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Liu Chun <liu.chun2@zte.com.cn>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>

Thanks, I'll queue this for sched/urgent once -rc1 rolls around.

