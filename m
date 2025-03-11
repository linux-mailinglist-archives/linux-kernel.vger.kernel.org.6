Return-Path: <linux-kernel+bounces-556406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F12A5C72F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFB13BA229
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DBD25EF80;
	Tue, 11 Mar 2025 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRR7Ck1n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7025BAAA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706781; cv=none; b=VJ1qTs0UakTzOHjbbuJlEd97wQdOhR2V57CT4D7YHngOcfzSyNmom8GuY29UnM22hMAVmUYlQeol31HLrD4hCQsLM8LUd8HpDwuqB+8yBl45nqsfLfFqXU8mMAAU9yXlZqBIdnR0Tuto/PAjPlQIDyvd6UGgFezcJOjnOd09J4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706781; c=relaxed/simple;
	bh=ds1M7pNWk+VG4ZEUQqsx2raLTL5dzRcPgc74R5lYb2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knYfLT7KRbHB6/TR0u5hkYSFf6oSJ08yqmcl5G+rx+3yhJDd0cj3g327dJfpbtM/7nAx5ReFErLpdWPc8I+R7liIHfRAaxltXlS/Nwn7i2JERKw9ClPsYeW8Ltr1+doHRFXiZeLA2U8r9lt+l6zgmbo22xDRVhukdK7eygmAR3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRR7Ck1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13131C4CEE9;
	Tue, 11 Mar 2025 15:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741706781;
	bh=ds1M7pNWk+VG4ZEUQqsx2raLTL5dzRcPgc74R5lYb2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRR7Ck1nPIsvlPJhjBlYzxjs6WbZvOB60PMtmgX8t2rRATQsWHA/ZkGpbSmpeIOSQ
	 7s+9vHsSVeEv/svh/FtA3Rzf6NFGvGVNOnERyr2t+lJzQOKMvDwvOjBAJkZZWyzR83
	 gTgiRJSkaEm5T65gwibNT4WlaGW1jbOoTHEnlSlW8jol8TdETW3dwb0F2bv9e9QVti
	 NHmtBa+zIlsbfDLvftw+tUOqheZqer/dYX2Hrf1xoOf1+uGDj37FqQ7U2fhD+cKG1Q
	 jEyTSiXg7apFeJ/xIZeaHbWpjWUiKQz0a+J1zpIY65FcTyiPc2nldjbt4WvW81A/Xe
	 XGDIlPk4jnIGQ==
Date: Tue, 11 Mar 2025 16:26:18 +0100
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
Subject: Re: [patch V3 16/18] posix-timers: Dont iterate /proc/$PID/timers
 with sighand:: Siglock held
Message-ID: <Z9BWGsZX9CFHUXQo@localhost.localdomain>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.465175807@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250308155624.465175807@linutronix.de>

Le Sat, Mar 08, 2025 at 05:48:45PM +0100, Thomas Gleixner a écrit :
> The readout of /proc/$PID/timers holds sighand::siglock with interrupts
> disabled. That is required to protect against concurrent modifications of
> the task::signal::posix_timers list because the list is not RCU safe.
> 
> With the conversion of the timer storage to a RCU protected hlist, this is
> not longer required.
> 
> The only requirement is to protect the returned entry against a concurrent
> free, which is trivial as the timers are RCU protected.
> 
> Removing the trylock of sighand::siglock is benign because the life time of
> task_struct::signal is bound to the life time of the task_struct itself.
> 
> There are two scenarios where this matters:
> 
>   1) The process is life and not about to be checkpointed
> 
>   2) The process is stopped via ptrace for checkpointing
> 
> #1 is a racy snapshot of the armed timers and nothing can rely on it. It's
>    not more than debug information and it has been that way before because
>    sighand lock is dropped when the buffer is full and the restart of
>    the iteration might find a completely different set of timers.
> 
>    The task and therefore task::signal cannot be freed as timers_start()
>    acquired a reference count via get_pid_task().
> 
> #2 the process is stopped for checkpointing so nothing can delete or create
>    timers at this point. Neither can the process exit during the traversal.
> 
>    If CRIU fails to observe an exit in progress prior to the dissimination
>    of the timers, then there are more severe problems to solve in the CRIU
>    mechanics as they can't rely on posix timers being enabled in the first
>    place.
> 
> Therefore replace the lock acquisition with rcu_read_lock() and switch the
> timer storage traversal over to seq_hlist_*_rcu().
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

