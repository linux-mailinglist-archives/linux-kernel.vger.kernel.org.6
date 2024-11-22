Return-Path: <linux-kernel+bounces-418198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 488E09D5E87
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4041F21B65
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CD11DDC0C;
	Fri, 22 Nov 2024 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DW0yDYvo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42D04500E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732276889; cv=none; b=f2uQX1HV8XDZIqtJHqtxYXluPWqQt4EWINnohxtvR2wyL7LwoiBGQobikOp6iWlFhpjZMuHl42wA3Y2XrqziUt0dSS5nOvtc0W1dFIQbKRHBQC/dLmlxT89RtyVAuNE3Hqgg/3XsqjPralgGu0Idc1OLOvOwX4D1QZmBfqfBZ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732276889; c=relaxed/simple;
	bh=SI6rn+xuBp3BcktgH4EM27m9Tv6PFcPr2zKWa+N13t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRb8TCtzL1VwrwpJLlf4LveKXzXexSx+TnaEnKVTRnloSCUs0bDkcSYiKRfgZraIbw37s2pwlwhkZiioxGBUFeUwoS3d/Jft2sqXwwtFygHsvkDhwgk4Moq9xsvA16N7GgWL5R/ryy65Vp3D04v0zsK69cRPvTF7cmJwZQISANA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DW0yDYvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1A6C4CECE;
	Fri, 22 Nov 2024 12:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732276889;
	bh=SI6rn+xuBp3BcktgH4EM27m9Tv6PFcPr2zKWa+N13t4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DW0yDYvoady0QZvZndYmHmjOynqvNmoWtGm0Th6gyUlUiKOOQYKf8cF6dQ9Uv+G9c
	 UYJdyTK3e4pEvJdDojq47ScWkKmBOUshqY62jVf1WwyNqQV944z2MbqMyZhpm5gMOA
	 KSp0E2fs+yVfvnRDYy3a02FmR/yy4NbfXkKS+L5h/L2Gclc0+7YkBTQMzmfjxAfRE5
	 pnqK7Lda6R1ksOlwxwnSsZXESA/dKbPzH+DyG9nWigwzU5TM1ryZmS2nyMaPxvNdW7
	 x94BjK47GyzvIwq65bMx2HNzPfOFAvIs4fOPwr34/vDu7lZX56MlvSmXVJLJhmPP44
	 k/qSMDmmQY8Iw==
Date: Fri, 22 Nov 2024 13:01:26 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Anthony Mallet <anthony.mallet@laas.fr>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: posix timer freeze after some random time, under pthread
 create/destroy load
Message-ID: <Z0BylnuVaxwCNP9n@pavilion.home>
References: <26411.57288.238690.681680@gargle.gargle.HOWL>
 <Zz95qDPU2wcEp26r@localhost.localdomain>
 <20241122082407.GA14342@redhat.com>
 <Z0BliWkMHHzohMt3@pavilion.home>
 <20241122114949.GA24815@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122114949.GA24815@redhat.com>

Le Fri, Nov 22, 2024 at 12:49:50PM +0100, Oleg Nesterov a écrit :
> On 11/22, Frederic Weisbecker wrote:
> >
> > Le Fri, Nov 22, 2024 at 09:24:07AM +0100, Oleg Nesterov a écrit :
> > > On 11/21, Frederic Weisbecker wrote:
> > > >
> > > > I think this started with commit:
> > > >
> > > > bcb7ee79029d (posix-timers: Prefer delivery of signals to the current thread)
> > > >
> > > > The problem is that if the current task is exiting and has already been reaped,
> > > > its sighand pointer isn't there anymore.
> > >
> > > Thanks...
> > >
> > > This can only happen if the exiting task has already passed exit_notify() which
> > > sets exit_state. So I'd suggest to check current->exit_state instead of PF_EXITING
> > > in the patch below.
> > >
> > > Oleg.
> >
> > Right, I don't mind either way,
> 
> Me too, so feel free to ignore,
> 
> > though if it's past PF_EXITING,
> > complete_signal() -> wants_signal() will defer to another thread anyway, right?
> 
> Right. So I think it would be better to rely on complete_signal() in this
> case even if the current logic is very simple and dumb.

Just to make sure I understand correctly, this means you'd prefer to keep
the PF_EXITING test?

> 
> > Due to retarget_shared_pending() being called after the flag being set...
> 
> Yes. Whatever we do send_sigqueue/complete_signal can choose an exiting thread
> which doesn't have PF_EXITING yet, in this case retarget_shared_pending() from
> that thread will pick another target for signal_wake_up/TIF_SIGPENDING.

Right.

Thanks.

> 
> Thanks!
> 
> Oleg.
> 

