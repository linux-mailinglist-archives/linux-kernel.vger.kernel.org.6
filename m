Return-Path: <linux-kernel+bounces-556974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2952A5D1D0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16BA117AB99
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36DD2641DD;
	Tue, 11 Mar 2025 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snoijnoj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2A715820C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741728950; cv=none; b=osR48ADX3Y4MeCbjrfajR+q4bjxAo5CWe1m3USuQ6gAXuo1rId0Q8sFdJoRY46+/4ncgWkQ2pp5hs6nJENEuy9s+f265gO2Bo5ketqs1ZnH8V+wZ1TUr7UAhMqABoQ40Ftd1Nhh2x91OYJkk+qLi/OGTqW5/VVVC4OJ2nL1ZZPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741728950; c=relaxed/simple;
	bh=UK5a4abykqj/lB+sen+lq9d72t66utS2w52WKVV+tVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRf89nABAys2AcVwwOsEZTCQkO8yxPMFx5mH9UtMNKIvYgBsqw+tycYudmDRBpO1knC9jZU79CrQewBCrjxeeMMQJKuQfC4XrWstWxIlFyDBtn04HGKu7o63FxK0t5LYwkvflvQz2hOoRcuWIIdoJbzPNbr11eAFmuQwHc61EQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snoijnoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BC0C4CEE9;
	Tue, 11 Mar 2025 21:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741728949;
	bh=UK5a4abykqj/lB+sen+lq9d72t66utS2w52WKVV+tVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snoijnojTRY8NagDz43y0jswgK/8ZhPBrLOdb13w1o8l4LKdNCzZoT5FDYd4n1MXr
	 hGruCjfjKAwjf/n6zottsTf+DkOFG4fiayCYzduHyMIzI9hRe5zln/hLHzs6yopMBt
	 Ipxqp4iv3i0gjsjClEylSOjb+/1vIEp9pQmDgoJS+Kq8SP6dAdgbcFCenvaoLPUCdl
	 yKPw+sBUs/LaWc/oocy8oh8MxIPV6/x6VXeuxem6WEr17QPdNKAxpdpBBCwswbI32G
	 Uk4sT3KkyAtq8DtTR/Syz8IqW3+yD+xdvFSy7csf2Z0xmqAMBUyIa9rtYQjyUwxLdk
	 GrHsvOkYm2hdQ==
Date: Tue, 11 Mar 2025 22:35:46 +0100
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
Subject: Re: [patch V3 17/18] posix-timers: Provide a mechanism to allocate a
 given timer ID
Message-ID: <Z9CsstMf-EVZpsiH@pavilion.home>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.526740902@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250308155624.526740902@linutronix.de>

Le Sat, Mar 08, 2025 at 05:48:47PM +0100, Thomas Gleixner a écrit :
> @@ -364,6 +389,16 @@ static enum hrtimer_restart posix_timer_
>  	return HRTIMER_NORESTART;
>  }
>  
> +long posixtimer_create_prctl(unsigned long ctrl)
> +{
> +	if (ctrl > PR_TIMER_CREATE_RESTORE_IDS_ON)
> +		return -EINVAL;
> +
> +	guard(spinlock_irq)(&current->sighand->siglock);
> +	current->signal->timer_create_restore_ids = ctrl == PR_TIMER_CREATE_RESTORE_IDS_ON;

Is the locking necessary here? It's not used on the read side.
It only makes sense if more flags are to be added later in struct signal and the
fields write can race.

Also do we want to carry this PR_TIMER_CREATE_RESTORE_IDS_ON accross exec? Posix
timers are removed then anyway.

Thanks.

