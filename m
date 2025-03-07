Return-Path: <linux-kernel+bounces-551198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D610A5694E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D6B1898ACB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33AD21A457;
	Fri,  7 Mar 2025 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kip3kzr8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A920DD79
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355217; cv=none; b=WmjPUwsF3sc9EfRcU94mo1cHGwIy4XUbRjbd8+pd+6KMa0Uj+ucGNcP4rJs0Wocbh+QWVWATiPwmpKj+ej0KjSglfbd5Uy6RyZ/cSSidrz57yYt5vzbqVeTk8lsXwwPokTxtWChJ1pk6lOSo/PfR2DTgO7SN26zfV1+haMgakzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355217; c=relaxed/simple;
	bh=8WwNjezJF569GFODmGLqiC3SEpVDFY+ddnvepovWS2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se68eKGH3wxs+Ct+iidtNRMso9c733KTuRO+MO+tjKDFVp/LXnw4tCoD7+7oSF7XZMUZ9lLV3ZLKHl8XaSdVpz2exHdjtg/tsEhTVYXy+3+OhE044ArekPmtSgiYHmiFxR2GrXC+EFhoC/8LtbNGw9+oxam1KWyacqIWfAiJyeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kip3kzr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFE0C4CED1;
	Fri,  7 Mar 2025 13:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741355216;
	bh=8WwNjezJF569GFODmGLqiC3SEpVDFY+ddnvepovWS2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kip3kzr8+MtnBbHhY3wiGsvy2L7HOLd0njYClwziLY0K+7smxBgc6pbE9ksfq6BhM
	 9d1Tu9NAAlaGzuQKcfd152naCTuTuyl0xqIa3KILAfBFrQc4UnpKiEIYyF8jT4k3zI
	 uEjNLLnAqYZEIUk996avo+E68SjgZ7+hx2VxfJXpvdXz3zhuNfAFgOTZso/4TNGe2N
	 57dqu/yEbEl1mps6/fyvValRfwUo6lM5H0HlS9PeYiTPinv1D/UZas6lz38g5in9PU
	 ivNF1pNZOHwqH2a+MAdGlioKHx/u6XQ7tpCwy4gtdEIcmnz+sY+2BBdhqUOmJ6pI/m
	 WtLZ06M2BcDhA==
Date: Fri, 7 Mar 2025 14:46:53 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 01/17] posix-timers: Initialise timer before adding it
 to the hash table
Message-ID: <Z8r4zVJz8-XaN52Q@localhost.localdomain>
References: <20250302185753.311903554@linutronix.de>
 <20250302193626.974094734@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250302193626.974094734@linutronix.de>

Le Sun, Mar 02, 2025 at 08:36:44PM +0100, Thomas Gleixner a écrit :
> From: Eric Dumazet <edumazet@google.com>
> 
> A timer is only valid in the hashtable when both timer::it_signal and
> timer::it_id are set to their final values, but timers are added without
> those values being set.
> 
> The timer ID is allocated when the timer is added to the hash in invalid
> state. The ID is taken from a monotonically increasing per process counter
> which wraps around after reaching INT_MAX. The hash insertion validates
> that there is no timer with the allocated ID in the hash table which
> belongs to the same process. That opens a mostly theoretical race condition:
> 
> If other threads of the same process manage to create/delete timers in
> rapid succession before the newly created timer is fully initialized and
> wrap around to the timer ID which was handed out, then a duplicate timer ID
> will be inserted into the hash table.
> 
> Prevent this by:
> 
>   1) Setting timer::it_id before inserting the timer into the hashtable.
>  
>   2) Storing the signal pointer in timer::it_signal with bit 0 set before
>      inserting it into the hashtable.
> 
>      Bit 0 acts as a invalid bit, which means that the regular lookup for
>      sys_timer_*() will fail the comparison with the signal pointer.
> 
>      But the lookup on insertion masks out bit 0 and can therefore detect a
>      timer which is not yet valid, but allocated in the hash table.  Bit 0
>      in the pointer is cleared once the initialization of the timer
>      completed.
> 
> [ tglx: Fold ID and signal iniitializaion into one patch and massage change
>   	log and comments. ]
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/all/20250219125522.2535263-3-edumazet@google.com

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

