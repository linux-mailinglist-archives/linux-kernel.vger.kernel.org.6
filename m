Return-Path: <linux-kernel+bounces-232292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCAE91A664
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443F0281E73
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8AF15383C;
	Thu, 27 Jun 2024 12:16:49 +0000 (UTC)
Received: from smtp134-25.sina.com.cn (smtp134-25.sina.com.cn [180.149.134.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6501304A3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719490609; cv=none; b=PJLsMMPd0Mwx4AkM2j7oSI3Eabxblh4AW5XF9xbZDVvDe4lunTfJ4Hn3WRfRFxrlTr7+HMLzytiMDD0Lag3crmTKevZr0jqhJ/WnZHCIbSeyqwKzbadxkW1OX0t5PsmcdCPhn8YJ2qcqB4WooJnThneDcgtiotsuVAk0QkjEovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719490609; c=relaxed/simple;
	bh=ZcZ/fMAZaiW/5sor0Jr7UwJx4S5vpxSj6WBY4ifdW4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WaMNZCBT0ShWtqgC1YV4ewJIf+XSp9nXqcFVxci1ZDttqw1lSePvSYwMk9xr0huhtDslWKMuqDE/x9HrfONDIdkIa16VudpZnQY0rP798AA8xsb7s3oqlNXSEd/A5eczSkMapRN/gfYKx+eRxrhTmTa1G6QHwEto1NeDrpWHBu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.136])
	by sina.com (10.185.250.21) with ESMTP
	id 667D582300001048; Thu, 27 Jun 2024 20:16:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5955733408299
X-SMAIL-UIID: 01DA74F255DE4C7FB9D6ED568ACF3AE6-20240627-201637-1
From: Hillf Danton <hdanton@sina.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] workqueue: Improve scalability of workqueue watchdog touch
Date: Thu, 27 Jun 2024 20:16:28 +0800
Message-Id: <20240627121628.2278-1-hdanton@sina.com>
In-Reply-To: <20240625114249.289014-3-npiggin@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jun 25, 2024 at 09:42:45PM +1000, Nicholas Piggin wrote:
> On a ~2000 CPU powerpc system, hard lockups have been observed in the
> workqueue code when stop_machine runs (in this case due to CPU hotplug).
> This is due to lots of CPUs spinning in multi_cpu_stop, calling
> touch_nmi_watchdog() which ends up calling wq_watchdog_touch().
> wq_watchdog_touch() writes to the global variable wq_watchdog_touched,
> and that can find itself in the same cacheline as other important
> workqueue data, which slows down operations to the point of lockups.
> 
> In the case of the following abridged trace, worker_pool_idr was in
> the hot line, causing the lockups to always appear at idr_find.
> 
Wonder if the MCS lock does not help in this case.

>   watchdog: CPU 1125 self-detected hard LOCKUP @ idr_find
>   Call Trace:
>   get_work_pool
>   __queue_work
>   call_timer_fn
>   run_timer_softirq
>   __do_softirq
>   do_softirq_own_stack
>   irq_exit
>   timer_interrupt
>   decrementer_common_virt
>   * interrupt: 900 (timer) at multi_cpu_stop
>   multi_cpu_stop
>   cpu_stopper_thread
>   smpboot_thread_fn
>   kthread
> 

