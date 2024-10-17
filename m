Return-Path: <linux-kernel+bounces-370138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD3A9A2853
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FF91F22AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D56B1DF272;
	Thu, 17 Oct 2024 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdudpvsT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEA31DF266
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181782; cv=none; b=XgLA72gsSrMTnako21CrKyFwcrNa6NejAGrLArhOZwiveda6IRwCgPdQ4MubXAwaTHJWyEvEmJv6orkmL3ECZNajXGV9uvXJ6gZnPFvaRBjfGMkgOVzV+mJrpqBfVSrPE6EEANyhqQN7zBL+uMbN0BuvBidss+CuwPcKjZu2M4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181782; c=relaxed/simple;
	bh=K7CEYc/fQX0v9pRvAdUKQQDJnxP5K6UapLlIXyZZeAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhIJBu4oBkDSkTWrmdONSJUThVrM68nEukzxDi+KGvyZsWn8cAZ7i0pIVdZPXu94AyUzzaiSzsDC/cYD4WemyqbYIYv3spaJXEEIrsv0ovPni7zZCFwGKWJ9zTW5CwfQnnbpc3AAitLtR+MlG1XhBeIIFaLdXvPUIPVxIWhrV4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdudpvsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FF2C4CEC3;
	Thu, 17 Oct 2024 16:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729181782;
	bh=K7CEYc/fQX0v9pRvAdUKQQDJnxP5K6UapLlIXyZZeAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XdudpvsTk8XL+6x+0pRd5EOLhCDBx15at3a5EyxEvNE1S1BZRi6gHS/XLluXZ7yWe
	 JQyUKbNqJEL6NyBX3YeuyCcqbBqdDwd5RToGZ9n4CLTT8L0h+gBgz9TeYp+6ssnZ1O
	 naGsau1AO1DnnAbNz/y15lYZkP20a5bzhAlhtYxmD2IitfldlkNVNNe956HlqtaH0G
	 TqMLgPT+f3lOK1jJlX404Ge1CF3hGulZmhkXjnrEbKXde7cWuZHsFBoAT979IkL1Yl
	 N/Ix+fe3khHCKOpn/L+phYk+BbxcW2FGEcP3McrclQfjpeHseupvLsIY4uIhTVpFGB
	 ZJpNcK+X3GX2Q==
Date: Thu, 17 Oct 2024 18:16:19 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: =?utf-8?B?5pyx5oG65Lm+?= <zhukaiqian@xiaomi.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	=?utf-8?B?5byg5ZiJ5Lyf?= <zhangjiawei8@xiaomi.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?546L6Z+s?= <lingyue@xiaomi.com>,
	=?utf-8?B?54aK5Lqu?= <xiongliang@xiaomi.com>,
	"isaacmanjarres@google.com" <isaacmanjarres@google.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	=?utf-8?B?5qKB5Lyf6bmP?= <weipengliang@xiaomi.com>,
	=?utf-8?B?57+B6YeR6aOe?= <wengjinfei@xiaomi.com>
Subject: Re: [PATCH] tick/broadcast: Plug clockevents replacement race
Message-ID: <ZxE4U0YzXAY9RPOp@pavilion.home>
References: <042520850d394f0bb0004a226db63d0d@xiaomi.com>
 <87o77m1v9r.ffs@tglx>
 <b07f9746a58d46919b1600b22f5dff05@xiaomi.com>
 <835d5847-1aa0-4852-89c7-6a6996b3eb65@linaro.org>
 <bc1a086b932f454f9379c49221983675@xiaomi.com>
 <87o775uh0y.ffs@tglx>
 <87frrs8lsg.ffs@tglx>
 <87cymdsu0r.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cymdsu0r.ffs@tglx>

Le Mon, Aug 12, 2024 at 04:19:48PM +0200, Thomas Gleixner a écrit :
> 朱恺乾 reported and decoded the following race condition when a broadcast
> device is replaced:
> 
> CPUA					CPUB
>  __tick_broadcast_oneshot_control()
>    bc = tick_broadcast_device.evtdev;
> 					tick_install_broadcast_device(dev)
>         				clockevents_exchange_device(cur, dev)
> 					   shutdown(cur);
> 					   detach(cur);
> 					   cur->handler = noop;
> 					   tick_broadcast_device.evtdev = dev;
> 
>   tick_broadcast_set_event(bc, next_event); <- FAIL: arms a detached device.
> 
> If the original broadcast device has a restricted interrupt affinity mask
> and the last CPU in that mask goes offline then the BUG() in
> tick_cleanup_dead_cpu() triggers because the clockevent device is not in
> detached state.
> 
> The reason for this is that tick_install_broadcast_device() is not
> serialized vs. tick broadcast operations.
> 
> The obvious cure is to serialize tick_install_broadcast_device() with
> tick_broadcast_lock against a concurrent tick broadcast operation.
> 
> That requires to split clockevents_exchange_device() into two parts, one
> which does the exchange, shutdown and detach operation and the other which
> drops the module reference count. This is required because the module
> reference cannot be dropped while holding tick_broadcast_lock.

The reason why the module reference can not be dropped while holding
tick_broadcast_lock is not obvious though. What can go wrong?

Thanks.

