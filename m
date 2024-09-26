Return-Path: <linux-kernel+bounces-340999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E542B987A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048F51C22966
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBEB17C9AA;
	Thu, 26 Sep 2024 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ys3MuEQq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB5B4085D
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727382092; cv=none; b=mJCGsZ7qDXIiWMQUQN+72XHi4evI5vL+Mg+K5NAApjb9q/dGiArXQHZNLOZkrvOsEuOs3fD1Kgs6EAxhlj+VcO0A8Ofw9uwuowy8SKaHaBg8pOyhytVY7flQIbINCO6Phyll09Hp4o6s18Yw+svlBTznmhV8jydcbuP0DCuYbV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727382092; c=relaxed/simple;
	bh=PXh3wzvgTPSep8a82OzlPI3iEmG7z1vcYLsfrA4WbRA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AVABonx6vM4Q/sU3s7eKda6eXLPw3fpN+nTHo0VMgaPh2uL2SPvkn5+f4yiG/UQ0iAoPk4y0RICgu6vfFSPjvAzlasD6UvHJSx5oRXitY3V0rTAqKVsnnHbyOOrKsvtbdiAfmBExcJudccgc6RZp1aa/bba39XmrjMFA/pP3VJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ys3MuEQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984BBC4CEC5;
	Thu, 26 Sep 2024 20:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727382091;
	bh=PXh3wzvgTPSep8a82OzlPI3iEmG7z1vcYLsfrA4WbRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ys3MuEQqRKez3P1oRPf+4kqDtVoVqwRjPxubw3pYYVS+JoHIcop9TEDWCqTgVNmME
	 aajd/+7Xkjtjt5IaItPxQfVocPRumfAMIUtUmhBGWWKYVamxUYwVH46/i7DenpeHop
	 ABx2o2KYIqsjb89d+i1vBTLt02sd93LqK542yew8=
Date: Thu, 26 Sep 2024 13:21:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Hillf Danton <hdanton@sina.com>, Tejun Heo
 <tj@kernel.org>, syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
Subject: Re: [PATCH] kthread: Unpark only parked kthread
Message-Id: <20240926132130.b1d1f6943d225368d3062d5e@linux-foundation.org>
In-Reply-To: <20240913214634.12557-1-frederic@kernel.org>
References: <20240913214634.12557-1-frederic@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 23:46:34 +0200 Frederic Weisbecker <frederic@kernel.org> wrote:

> Calling into kthread unparking unconditionally is mostly harmless when
> the kthread is already unparked. The wake up is then simply ignored
> because the target is not in TASK_PARKED state.
> 
> However if the kthread is per CPU, the wake up is preceded by a call
> to kthread_bind() which expects the task to be inactive and in
> TASK_PARKED state, which obviously isn't the case if it is unparked.
> 
> As a result, calling kthread_stop() on an unparked per-cpu kthread
> triggers such a warning:
> 
> 	WARNING: CPU: 0 PID: 11 at kernel/kthread.c:525 __kthread_bind_mask kernel/kthread.c:525
> 	 <TASK>
> 	 kthread_stop+0x17a/0x630 kernel/kthread.c:707
> 	 destroy_workqueue+0x136/0xc40 kernel/workqueue.c:5810
> 	 wg_destruct+0x1e2/0x2e0 drivers/net/wireguard/device.c:257
> 	 netdev_run_todo+0xe1a/0x1000 net/core/dev.c:10693
> 	 default_device_exit_batch+0xa14/0xa90 net/core/dev.c:11769
> 	 ops_exit_list net/core/net_namespace.c:178 [inline]
> 	 cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:640
> 	 process_one_work kernel/workqueue.c:3231 [inline]
> 	 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
> 	 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
> 	 kthread+0x2f0/0x390 kernel/kthread.c:389
> 	 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> 	 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 	 </TASK>
> 
> Fix this with skipping unecessary unparking while stopping a kthread.

How does userspace trigger this?  Is it an issue in current mainline?

Should we backport the fix into -stable kernels (depends on the answers
to the above questions).

It looks like the issue is old, so a Fixes: probably isn't needed.  But
as the issue is old, why did it come to light now?

