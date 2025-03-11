Return-Path: <linux-kernel+bounces-557023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC14A5D295
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF74189E4F6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE559264638;
	Tue, 11 Mar 2025 22:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhxwV8uP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6EC18A93C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 22:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741732381; cv=none; b=rZ8fyiLTd8vGQFVa33gPukd4Rd6tBfAhVH/NkJK7rKaPiNuTUJIEs/1FIjwn0Jm5B8mf4K1ytgF8NwFExNy680RVMHLdjsHNTcx51fX9PQtr4v8bsFG92pFaMLKG/9wU8J/ek/CorCgwaT4IQD2E6HYsxzPj78HT1ZlE1cULL+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741732381; c=relaxed/simple;
	bh=BaF9ZGzoFSePRSsl2veWOB/JiBZHP+sj4Wwzmjp2IUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXhwposwSB2dpVDlYBkukUNGR7aQapafLtbwHY2RzzXs4H3yFe4/o7ZJyZi3fxficML5/SeKdkhwTiWJ9sVXZoF4QKiKcyw6hxo306dnwZzNnSfkDOIPs/APq0xBbVnni509uqz1OeBCcbHPHGOZMxKsrrNiuXzrQiXI+fYrNL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhxwV8uP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFCCC4CEE9;
	Tue, 11 Mar 2025 22:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741732380;
	bh=BaF9ZGzoFSePRSsl2veWOB/JiBZHP+sj4Wwzmjp2IUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MhxwV8uPDU4naMVNabDU18B+yiZsSJZHhVLIqnU0MRjpGmzM6zV9oXli/GW0HelBf
	 Ij3mMMb+XBSH+XuX1bB4ViEhqGyv2l6WxwubzOtks2wV3VQgrXqsVU3G+ovEk6erK+
	 osAMjX7kb6cT0N3UUaucCu8McKTSASB043tuE2PmiS/q1gFsjh/YuLOoQ+DLmlWbCW
	 8yrmNhW6LAszhttmdBFAM3aYfnloUinAaV8bRzVkTPORnZOyfKpK3u4sOnRhdUz2tk
	 61nrF3OoXpZEAkBPTu97oRHRTw+uwYbHGCXx8/bv4TN8/5SZb+eZkRRwmuvkmai6Eu
	 P+T0KGfJuU20A==
Date: Tue, 11 Mar 2025 23:32:58 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [patch V3a 17/18] posix-timers: Provide a mechanism to allocate
 a given timer ID
Message-ID: <Z9C6GpaB9WvNzvJS@pavilion.home>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.526740902@linutronix.de>
 <Z9CsstMf-EVZpsiH@pavilion.home>
 <87msdrz0i9.ffs@tglx>
 <87jz8vz0en.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jz8vz0en.ffs@tglx>

Le Tue, Mar 11, 2025 at 11:07:44PM +0100, Thomas Gleixner a écrit :
> Checkpoint/Restore in Userspace (CRIU) requires to reconstruct posix timers
> with the same timer ID on restore. It uses sys_timer_create() and relies on
> the monotonic increasing timer ID provided by this syscall. It creates and
> deletes timers until the desired ID is reached. This is can loop for a long
> time, when the checkpointed process had a very sparse timer ID range.
> 
> It has been debated to implement a new syscall to allow the creation of
> timers with a given timer ID, but that's tideous due to the 32/64bit compat
> issues of sigevent_t and of dubious value.
> 
> The restore mechanism of CRIU creates the timers in a state where all
> threads of the restored process are held on a barrier and cannot issue
> syscalls. That means the restorer task has exclusive control.
> 
> This allows to address this issue with a prctl() so that the restorer
> thread can do:
> 
>    if (prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_ON))
>       goto linear_mode;
>    create_timers_with_explicit_ids();
>    prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_OFF);
>    
> This is backwards compatible because the prctl() fails on older kernels and
> CRIU can fall back to the linear timer ID mechanism. CRIU versions which do
> not know about the prctl() just work as before.
> 
> Implement the prctl() and modify timer_create() so that it copies the
> requested timer ID from userspace by utilizing the existing timer_t
> pointer, which is used to copy out the allocated timer ID on success.
> 
> If the prctl() is disabled, which it is by default, timer_create() works as
> before and does not try to read from the userspace pointer.
> 
> There is no problem when a broken or rogue user space application enables
> the prctl(). If the user space pointer does not contain a valid ID, then
> timer_create() fails. If the data is not initialized, but constains a
> random valid ID, timer_create() will create that random timer ID or fail if
> the ID is already given out. 
>  
> As CRIU must use the raw syscall to avoid manipulating the internal state
> of the restored process, this has no library dependencies and can be
> adopted by CRIU right away.
> 
> Recreating two timers with IDs 1000000 and 2000000 takes 1.5 seconds with
> the create/delete method. With the prctl() it takes 3 microseconds.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

