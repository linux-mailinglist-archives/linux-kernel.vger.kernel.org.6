Return-Path: <linux-kernel+bounces-234425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361E091C67E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4088A1C2247C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4165E6F30A;
	Fri, 28 Jun 2024 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kBgV/Bw3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7AF15ACA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719602431; cv=none; b=mkT+ihHYj8aJDtr8Hs0xKyczP7+Mycev5cpAfEL8/ywzqKbtBsLfyvdQ7bdNA/5VpBtc2mMktat3y6QMsX1NpIk6PX/KL6lQ+QEXf7FoMHPOtX96DkhbE1KvRwHb3kQUORHOBm3E5fp0bbhgomhKOSIcF0QfivWkY1x82VKeRV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719602431; c=relaxed/simple;
	bh=6Dw3Ya0BwTVP5zh3+nM08jlVpo/IFfSBl5+EFao+Mtc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PBMcUwxBQRbew8lhaqPHsleeSbTThbRf1Awz/lsLwsDxBNgCnpTk8J646v/J9x3ZwDDRCkwvREhctMBH6wYc4drohR+YZMQ8M93R8mkUWCO+RD8bpGRqNEUeRP0bUfdAgYauw+d0Nt+fJ7snf7DtTuLXBkzHXE1fXD1BoU3AeU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kBgV/Bw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E26CC116B1;
	Fri, 28 Jun 2024 19:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719602430;
	bh=6Dw3Ya0BwTVP5zh3+nM08jlVpo/IFfSBl5+EFao+Mtc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kBgV/Bw33yclobgOf/cAdPBb6kLC66sZauEA/GjH2ajxzRELid/tqYmP/LJZRrpGD
	 ygf3REjI/vTuYUgRYXzy2dkHg5yhC/DcyWZKgR7ySufPDhC0/FfnkzW9RRm7lBayzU
	 iGSRrThvIsv1bTmBJ9fRtinfSauBonVEj7219CwM=
Date: Fri, 28 Jun 2024 12:20:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Ben Segall
 <bsegall@google.com>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Klara Modin <klarasmodin@gmail.com>, Mel
 Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>, Steven
 Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider
 <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/task_struct: Move alloc_tag to the end of the
 struct.
Message-Id: <20240628122029.ed510073c534b739ee385521@linux-foundation.org>
In-Reply-To: <20240628094944.QwcHkf8J@linutronix.de>
References: <20240621102750.oH9p1FQq@linutronix.de>
	<20240628094944.QwcHkf8J@linutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 11:49:44 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2024-06-21 12:27:52 [+0200], To linux-mm@kvack.org wrote:
> > The alloc_tag member has been added to task_struct at the very
> > beginning. This is a pointer and on 64bit architectures it forces 4 byte
> > padding after `ptrace' and then forcing another another 4 byte padding
> > after `on_cpu'. A few members later, `se' requires a cacheline aligned
> > due to struct sched_avg resulting in 52 hole before `se'.
> > 
> > This is the case on 64bit-SMP architectures.
> > The 52 byte hole can be avoided by moving alloc_tag away where it
> > currently resides.
> > 
> > Move alloc_tag to the end of task_struct. There is likely a hole before
> > `thread' due to its alignment requirement and the previous members are
> > likely to be already pointer-aligned.
> > 
> > Fixes: 22d407b164ff7 ("lib: add allocation tagging support for memory allocation profiling")
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Could we please get this merged and worry about possible performance
> regression later? Or once there is a test case or an idea where this
> pointer might fit better but clearly the current situation is worse.
> 

All in favor of saving 56 bytes from the task_struct, but we can do
that by moving various things around.  Was alloc_tag the best choice?


