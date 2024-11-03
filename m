Return-Path: <linux-kernel+bounces-393947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1069BA7C1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 20:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3718128175C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 19:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EDC18991B;
	Sun,  3 Nov 2024 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfOeMl5J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0CB7C0BE
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730663727; cv=none; b=IdUcsrAQeS2XwR+2NR0ikkYUjVXJJP/uuzkn6FhTxDHGBCo0U2dHEwuBLxSnLwzxdajgHKeDK+cOf1y8zTd7BZsp6oWWXuuxVH7b3qjlhLGAp4imDSorxyxNPIVp9V1NEjw1vGDu030gNlgO2SfnIjWmyUiDnj381dPCdMdAj0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730663727; c=relaxed/simple;
	bh=+5NsxsjAx8HZ75zU5qnHDT3UHbDD0DExcjzIjgCrSPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhuBLzuvvtBX6qH3C7wyrkByHPn5OTVOK5zhMLDqyMcv58OzcVQbdqzDYFUVzK7qRE9cX2g34Dq7H1VPNC4EM2+6Jva1VAM485xnARUlz2xpEGPm9aqicEDlm9kkITWricj/5Csbfq1qChGHiXvY6vQBwtR7uo5XAUoOH0H4sUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfOeMl5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D521C4CECD;
	Sun,  3 Nov 2024 19:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730663725;
	bh=+5NsxsjAx8HZ75zU5qnHDT3UHbDD0DExcjzIjgCrSPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rfOeMl5J63ZggCS+KGqXAL7i6ow1Q9ugTvfclv7KmUKW6GbcxTpl7aQdQ3nvxyO7D
	 v38CLOD4aA3ByW7SHVUEhiQ6el1aMK6+J4SB04Y9nKRYM+RLQbTTp8CXZvHjLWdK90
	 pHibD6gWHQs/IMBGZOmKXvGYtrv/7jFugqwCwpfZA9P52Ml2bKAafEYnKRNC8UfK9c
	 xOQiRvl/c3UYLbYWidFBSV83m+QBdOssBuptqYhpHa5Ak69oPYXPa9CrbFgnorreXw
	 9nteE+9Js0rfQTBjCt21RG2x1QVgKH5kTlnoorS8734kYyqVmp8w43x46HyhooO8nx
	 60pArQpMk51Mw==
Date: Sun, 3 Nov 2024 20:55:22 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch v6 17/20] signal: Queue ignored posixtimers on ignore list
Message-ID: <ZyfVKmNIhgNBhA7q@pavilion.home>
References: <20241031151625.361697424@linutronix.de>
 <20241031154425.624061922@linutronix.de>
 <ZyTj2W8Jndv0nzga@localhost.localdomain>
 <871pzuvfzg.ffs@tglx>
 <Zya5wy9UyVo2cRvq@pavilion.home>
 <871pzsr6rg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871pzsr6rg.ffs@tglx>

Le Sun, Nov 03, 2024 at 10:44:35AM +0100, Thomas Gleixner a écrit :
> On Sun, Nov 03 2024 at 00:46, Frederic Weisbecker wrote:
> > And what about the other callers of flush_sigqueue_mask()? Such as SIGCONT
> > removed when SIGSTOP arrives? And the reverse as well? This moves the pending
> > timers signals to the ignore list until the signal is unignored, but in that
> > case SIGCONT is not ignored? Or perhaps SIGCONT and SIGSTOP can't be set for
> > posix timers?
> 
> You can set SIGSTOP/CONT on a posix timer. Whether that makes sense or
> not is a different question :)
> 
> Even on current mainline the behaviour is pretty much unspecified. Some
> combinations "work", some not. I just tried out of morbid curiousity. :)

I see.

So probably we shouldn't care too much, right?

> 
> Thanks,
> 
>         tglx
> 
> 

