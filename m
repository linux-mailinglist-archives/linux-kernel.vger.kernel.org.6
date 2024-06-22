Return-Path: <linux-kernel+bounces-225727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6E5913477
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 16:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98E27B233E6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0656416F0EC;
	Sat, 22 Jun 2024 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCkVMw47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FCA1E4AB
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719066936; cv=none; b=tbTPDEEYtcX960+uMqPSoHuTCIPgnRkn/tvxkf3hY4JlD0nC/4fsODzNM9qbCxZ5MOD/o6jY9ZLX1pTHNRIcafkp25KwmiIH2T0JnuvlICviZFI7OftKx5EvTR7gkZugIi3VymsE2gbvrNHRGiP2FLcKbF2hJkoJ+8bR9BY324s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719066936; c=relaxed/simple;
	bh=SU2CmCvOdGRXuXI/SBqJYgyewvCjz0seOX8DDW5DfAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB5HGXEaIZ0eDuv9mxc5DL2XauUOIlELaa2AzIbUek+yrqDHe9n++F3pcFZXg7fMPKkLBWokYPamB6/zXZ+uOegwSw8EfzqHiUYzygZ10JTSaYphIqHaOWiqyngrA/VAgRr6ttl1XRZ9Keb7aIyrpO1NGAu/LRsJMrLKjQDmfoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCkVMw47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37600C3277B;
	Sat, 22 Jun 2024 14:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719066935;
	bh=SU2CmCvOdGRXuXI/SBqJYgyewvCjz0seOX8DDW5DfAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pCkVMw47BkFVjWeIhRYQKwrVuHyGUEezdRItByJEhS+8zwRabX4nGu+MMcO+aRdwb
	 xqXSamlInhEAnq8viHIPrErUjZacCNxgYuKg8vOd6h/FCJ7IyKW132VeZMJCs7l9Jo
	 hh2vopsVv5wtyMRd7jEh1IlwbSuOYC7QR4PMOEFNxRlIPZWvHpttVQ8k3x2rRrjXMb
	 uC8OqbyObuTzgENMw8p0vOsQqS+uJ3DzXWJsbdcoDkU/43IBzlSYmQ1rUIhOzn67VH
	 Iq8/gvAifTFrcYLHSA6N7OdvOqdLp4S5WCGAiSJSACHAkMOijXFCRoLU8PA1dtQEUZ
	 TvsHyDKLuqBRA==
Date: Sat, 22 Jun 2024 16:35:32 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V3 11/51] posix-cpu-timers: Handle SIGEV_NONE timers
 correctly in timer_set()
Message-ID: <ZnbhNF59091n4Xwl@pavilion.home>
References: <20240610163452.591699700@linutronix.de>
 <20240610164026.162380808@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610164026.162380808@linutronix.de>

Le Mon, Jun 10, 2024 at 06:42:18PM +0200, Thomas Gleixner a écrit :
> Expired SIGEV_NONE oneshot timers must return 0 nsec for the expiry time in
> timer_get(), but the posix CPU timer implementation returns 1 nsec.
> 
> Add the missing conditional.
> 
> This will be cleaned up in a follow up patch.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Split out into new patch to make review simpler - Frederic
> ---
>  kernel/time/posix-cpu-timers.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -706,7 +706,16 @@ static int posix_cpu_timer_set(struct k_
>  				old_expires = exp - val;
>  				old->it_value = ns_to_timespec64(old_expires);
>  			} else {
> -				old->it_value.tv_nsec = 1;
> +				/*
> +				 * A single shot SIGEV_NONE timer must return 0, when it is
> +				 * expired! Timers which have a real signal delivery mode
> +				 * must return a remaining time greater than 0 because the
> +				 * signal has not yet been delivered.
> +				 */
> +				if (sigev_none)

Does this patch build? The sigev_none variable doesn't seem to exist.

Thanks.

> +					old->it_value.tv_nsec = 0;
> +				else
> +					old->it_value.tv_nsec = 1;
>  				old->it_value.tv_sec = 0;
>  			}
>  		}
> 

