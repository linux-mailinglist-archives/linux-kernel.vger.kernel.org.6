Return-Path: <linux-kernel+bounces-290642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEF09556C8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 11:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D1F1F21734
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 09:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D370914901B;
	Sat, 17 Aug 2024 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jKFoHC/7"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB701411EB;
	Sat, 17 Aug 2024 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723887217; cv=none; b=eGSN4tmzjmOQFJYBs6nr6eVHegBu/FBFC0Mf/fOt8I956/cpiCeTVHhUEkmi4VH7eDeXGL//Ho95KojvTJxdJnWVPQPPNL2GM3goIQzGS4GanYFc0zLzR2kERb+HRqqlAJVyZtATNGg0KsN/Q19phsRfsssYM/ihlLb9wS7MnzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723887217; c=relaxed/simple;
	bh=ap6BK1dpLtw76BVXZL6KNruenWK7WNcOp7+pF+z9FIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrLn2uxAWMfwy3t7JK5txaXcYZTa3/4LFF7lq6vAjOy6XDA5MKH93sRpHRXm+HjacYSiLemGg0xm/Cxlq+hOMS/vc+1HVOEdicBOPmrIfViW5AYeQDMm0/0LgOWSHnqzmFaoMvWd7ff1QMQrQnuT5he4RjJBxPr1joTYtfhfiDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jKFoHC/7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2ZOwe7O5BwdOYvqDabz4Y+jG7y6qLWUeelHQPh/w5lA=; b=jKFoHC/7VRX+LlikRmGoPgGbuM
	eYFUJ2X8GfbEdWjCVSNPdaM7UuSkFyZE81XUqlhXyhebDGNosXljLMzwv3XFuZqd6dGlzz9qu0S02
	bc/cmJbIWFi46/olgz+LuMHYH/JRMFUNLRYayylyTErR2MTv39Si9RcTZP+3GONIXVap/nCaoxizf
	L7TwS/6cv5GxmIwnuL7JeTM/cjVMbHLhwJwuHe96cbxpgYqvKpBn8EFNMznXi5v22xt0MPkoVvbwy
	YaPE4HzhuENXSB8f/lf9Y+cnCYtCSugjCxsCjA9wflbs+mg6DSOUHgaPeI9/He9iaZHxGCmp2SRtS
	5BkSNRQQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sfFoR-00000008pnn-09Bo;
	Sat, 17 Aug 2024 09:33:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A4521300848; Sat, 17 Aug 2024 11:33:29 +0200 (CEST)
Date: Sat, 17 Aug 2024 11:33:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [peterz-queue:sched/core] [sched/fair]  420356c350:
 WARNING:at_kernel/sched/core.c:#__might_sleep
Message-ID: <20240817093329.GA32430@noisy.programming.kicks-ass.net>
References: <202408161619.9ed8b83e-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408161619.9ed8b83e-lkp@intel.com>

On Fri, Aug 16, 2024 at 05:15:12PM +0800, kernel test robot wrote:
> kernel test robot noticed "WARNING:at_kernel/sched/core.c:#__might_sleep" on:
> 
> commit: 420356c3504091f0f6021974389df7c58f365dad ("sched/fair: Implement delayed dequeue")
> https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/core

> [   86.252370][  T674] ------------[ cut here ]------------
> [ 86.252945][ T674] do not call blocking ops when !TASK_RUNNING; state=1 set at kthread_worker_fn (kernel/kthread.c:?) 
> [ 86.254001][ T674] WARNING: CPU: 1 PID: 674 at kernel/sched/core.c:8469 __might_sleep (kernel/sched/core.c:8465) 

> [ 86.283398][ T674] ? handle_bug (arch/x86/kernel/traps.c:239) 
> [ 86.283995][ T674] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
> [ 86.284787][ T674] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
> [ 86.285682][ T674] ? __might_sleep (kernel/sched/core.c:8465) 
> [ 86.286380][ T674] ? __might_sleep (kernel/sched/core.c:8465) 
> [ 86.287116][ T674] kthread_worker_fn (include/linux/kernel.h:73 include/linux/freezer.h:53 kernel/kthread.c:851) 
> [ 86.287701][ T674] ? kthread_worker_fn (kernel/kthread.c:?) 
> [ 86.288138][ T674] kthread (kernel/kthread.c:391) 
> [ 86.288482][ T674] ? __cfi_kthread_worker_fn (kernel/kthread.c:803) 
> [ 86.288951][ T674] ? __cfi_kthread (kernel/kthread.c:342) 
> [ 86.289560][ T674] ret_from_fork (arch/x86/kernel/process.c:153) 
> [ 86.290162][ T674] ? __cfi_kthread (kernel/kthread.c:342) 
> [ 86.291465][ T674] ret_from_fork_asm (arch/x86/entry/entry_64.S:254) 

AFAICT this is a pre-existing issue. Notably that all transcribes to:

kthread_worker_fn()
  ...
repeat:
  set_current_state(TASK_INTERRUPTIBLE);
  ...
  if (work) { // false
    __set_current_state(TASK_RUNNING);
    ...
  } else if (!freezing(current)) // false -- we are freezing
    schedule();

  // so state really is still TASK_INTERRUPTIBLE here
  try_to_freeze()
    might_sleep() <--- boom, per the above.


