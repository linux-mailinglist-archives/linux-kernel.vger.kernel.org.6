Return-Path: <linux-kernel+bounces-515388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0112A36438
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AC13AC149
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD58625E456;
	Fri, 14 Feb 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbqKOlEY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4AB17555
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553413; cv=none; b=CF3fOlDPZE9+fVCUSct01NccsnlVrhS0TQ+0BJCEPOZ6IJEJtcG8LGs/56dyD42Ismr2osUh2n2dEUsEEZIN5pzA5vWdmPnX+iZx3uITMpk10Obdk0vWcOBWJnb+PvlZGgsHviOezBVCMPyOcraTcgjPBMqeGC3VuUP0GxoTLLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553413; c=relaxed/simple;
	bh=+Dh7vng6Bg6Mj4vQ2+6Vhnpc0aT2Z3+xpd0XciJ3YDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=couo9eKyxQMifs8EtW5GbiaKkRXEb097Nu4LAYhFmjOL86LDJd4fgA25WjYfktY4YldT+5rSBTzMeDPHAC1nj9pOpBjieSowkx4Y8HmdHHvmcfvxCppNDXy2nCX8kiuMVpvUc5zg2XUebuxIjpk0aRDMTwc3u6YRvV1sQCbF9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbqKOlEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1588C4CED1;
	Fri, 14 Feb 2025 17:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739553412;
	bh=+Dh7vng6Bg6Mj4vQ2+6Vhnpc0aT2Z3+xpd0XciJ3YDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WbqKOlEYHEmP5UIvcFQzH7iB6GHQ+zDoDhGYB/DOIMEOF/swjY+sEYPGeuOphrnny
	 tKhRuqm8sSplP6I+FRgbFbKwyj44M7OWWrn5PE9HjpZDXDksyZjXlYeXMcYZBSqkJ9
	 R2AYvm50qNF7DiLra4vbYiIFlXF4oSrj0vyhx3alAhELPKiXYQPTOJ0fC6A5LlXvnV
	 koTuIOyHjNnTSSDLNN3fs4CcJFoTlT63vlUmMgh34cvCHl0JVw8oYILwxVnBdsKXjA
	 0ScLyR359zQG9n45eZfcg5jEaDRNGCqOquwuXEJzNTYGifnpeRmQCn6IoXV9aEyXpf
	 sqw1i6r1N+WFA==
Date: Fri, 14 Feb 2025 07:16:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] workqueue: Log additional details when rejecting work
Message-ID: <Z696g2IEn_ktHVSM@slm.duckdns.org>
References: <20250214164349.13694-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214164349.13694-1-will@kernel.org>

On Fri, Feb 14, 2025 at 04:43:49PM +0000, Will Deacon wrote:
> Syzbot regularly runs into the following warning on arm64:
> 
>   | WARNING: CPU: 1 PID: 6023 at kernel/workqueue.c:2257 current_wq_worker kernel/workqueue_internal.h:69 [inline]
>   | WARNING: CPU: 1 PID: 6023 at kernel/workqueue.c:2257 is_chained_work kernel/workqueue.c:2199 [inline]
>   | WARNING: CPU: 1 PID: 6023 at kernel/workqueue.c:2257 __queue_work+0xe50/0x1308 kernel/workqueue.c:2256
>   | Modules linked in:
>   | CPU: 1 UID: 0 PID: 6023 Comm: klogd Not tainted 6.13.0-rc2-syzkaller-g2e7aff49b5da #0
>   | Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>   | pstate: 404000c5 (nZcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   | pc : __queue_work+0xe50/0x1308 kernel/workqueue_internal.h:69
>   | lr : current_wq_worker kernel/workqueue_internal.h:69 [inline]
>   | lr : is_chained_work kernel/workqueue.c:2199 [inline]
>   | lr : __queue_work+0xe50/0x1308 kernel/workqueue.c:2256
> 
>   [...]
> 
>   |    __queue_work+0xe50/0x1308 kernel/workqueue.c:2256 (L)
>   |  delayed_work_timer_fn+0x74/0x90 kernel/workqueue.c:2485
>   |  call_timer_fn+0x1b4/0x8b8 kernel/time/timer.c:1793
>   |  expire_timers kernel/time/timer.c:1839 [inline]
>   |  __run_timers kernel/time/timer.c:2418 [inline]
>   |  __run_timer_base+0x59c/0x7b4 kernel/time/timer.c:2430
>   |  run_timer_base kernel/time/timer.c:2439 [inline]
>   |  run_timer_softirq+0xcc/0x194 kernel/time/timer.c:2449
> 
> The warning is probably because we are trying to queue work into a
> destroyed workqueue, but the softirq context makes it hard to pinpoint
> the problematic caller.
> 
> Extend the warning diagnostics to print both the function we are trying
> to queue as well as the name of the workqueue.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Link: https://syzkaller.appspot.com/bug?extid=e13e654d315d4da1277c
> Signed-off-by: Will Deacon <will@kernel.org>

Applied to wq/for-6.14-fixes.

Thanks.

-- 
tejun

