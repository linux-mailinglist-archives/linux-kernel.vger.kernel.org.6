Return-Path: <linux-kernel+bounces-519851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631B7A3A2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418E33B158B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF7726E658;
	Tue, 18 Feb 2025 16:25:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A596826E622
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895942; cv=none; b=PJNG3ypaON3Im1AvLbPXt0Y+LMJ0Jp2vKFXJ8uJTSm2UVzxJ925bQDzIK47qCWQxnLYBkNbU1J+KNYXhTx46yYrUW/m8sd/rKePgmK/emnOrD/QDj3Bgy1x/cfsQculp10eYzGHJm7yfIXSd897SWCVALfV32qZ1yp4/mbdh9Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895942; c=relaxed/simple;
	bh=s3z020jExDCDiFNOPpL8W4R81Z92L1w2M/kyMLr2Ums=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJ6o6hxJ3m2pv/bddKDmsM13P2YUWvT+z3Okei6BvVdB0ORSBVnohEiW+EBSzln5QmNdM3xO0nM55VdFGbIS0FEM6hOrTwvXoKi7dHuASWH1xTSH0nilMlYYCW9PaB8XtIy2QeCAb3aRjN6U6/dOezG196gUStIpG6y/Vi7+sTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C571C4CEE8;
	Tue, 18 Feb 2025 16:25:41 +0000 (UTC)
Date: Tue, 18 Feb 2025 11:26:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>
Subject: Re: [GIT PULL] ftrace: Updates for v6.14
Message-ID: <20250218112602.5611754e@gandalf.local.home>
In-Reply-To: <20250217133830.25e634d8@gandalf.local.home>
References: <20250119193134.0ebd56bc@gandalf.local.home>
	<20250217114918.10397-A-hca@linux.ibm.com>
	<20250217133830.25e634d8@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 13:38:30 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 17 Feb 2025 12:49:18 +0100
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> > $ cat /sys/kernel/debug/tracing/current_tracer
> > nop
> > 
> > Bisected to commit 4346ba160409 ("fprobe: Rewrite fprobe on function-graph
> > tracer"). Before this commit there were no ftrace enabled functions after the
> > test suite finished:
> > 
> > $ wc -l /sys/kernel/debug/tracing/enabled_functions
> > 0 /sys/kernel/debug/tracing/enabled_functions
> > 
> > This is on s390 with defconfig.  
> 
> Thanks, I can reproduce it on x86 (I didn't check that commit though).
> 
> I'll take a look.

I think I found 3 different bugs in the accounting of what is registered
and what is not. I'll post a patch series shortly. Two in the function
graph tracer subops accounting, and one in the fprobe accounting.

-- Steve

