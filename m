Return-Path: <linux-kernel+bounces-191515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E70D68D1095
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F201F221EB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F32152DE7;
	Mon, 27 May 2024 23:43:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7360C45C14;
	Mon, 27 May 2024 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716853439; cv=none; b=umlCShUvk2GuGhRg7XpIO78vRaG40BHvHRFIsUyaxYvNoCaEWpz1cMZsHUsu1mzLdW/AELqVWEQL4y+q9byWSJR/oSslxaY4pib3Uqy/ZyzlrsC2Be9zDJQ6jXFS+pg2FStff3Lw+tHArCGhStW6QVIOd9LuiNzO5h4VMD2bIZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716853439; c=relaxed/simple;
	bh=wA75dp8NtJiqrtCG2x9kKbaGpLOo0caNQxzgsGyldXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6YGivvUZ2c0UiVtFN+7R7LNqmnj1JVasQbU31a+Yi3C7ARZ+roN8whGwicV/yeGMhdS+9cQRJFF79HyFBD2fQJTWORwq+TO0/gRSBSkwFhg2LphQRmmwQc8CeyXEhptFaSdINsmR8pJ8KmVqpZ3K3lTtHh5P+SvZGNnrp/DFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158A8C2BBFC;
	Mon, 27 May 2024 23:43:57 +0000 (UTC)
Date: Mon, 27 May 2024 19:43:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-users
 <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/2] ring-buffer: Fix a race between readers and resize
 checks
Message-ID: <20240527194356.5078b56f@rorschach.local.home>
In-Reply-To: <2b920bab-23a2-4a8d-95c2-b69472d38373@suse.com>
References: <20240517134008.24529-1-petr.pavlu@suse.com>
	<20240517134008.24529-3-petr.pavlu@suse.com>
	<20240520095037.33a7fde6@gandalf.local.home>
	<2b920bab-23a2-4a8d-95c2-b69472d38373@suse.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 11:36:55 +0200
Petr Pavlu <petr.pavlu@suse.com> wrote:

> >>  static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
> >>  {
> >> @@ -2200,8 +2205,13 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
> >>  		 */
> >>  		synchronize_rcu();
> >>  		for_each_buffer_cpu(buffer, cpu) {
> >> +			unsigned long flags;
> >> +
> >>  			cpu_buffer = buffer->buffers[cpu];
> >> +			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> >>  			rb_check_pages(cpu_buffer);
> >> +			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock,
> >> +						   flags);  
> > 
> > Putting my RT hat on, I really don't like the above fix. The
> > rb_check_pages() iterates all subbuffers which makes the time interrupts
> > are disabled non-deterministic.  
> 
> I see, this applies also to the same rb_check_pages() validation invoked
> from ring_buffer_read_finish().
> 
> > 
> > Instead, I would rather have something where we disable readers while we do
> > the check, and re-enable them.
> > 
> > 			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> > 			cpu_buffer->read_disabled++;
> > 			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> > 
> > // Also, don't put flags on a new line. We are allow to go 100 characters now.  
> 
> Noted.
> 
> > 
> > 
> >   			rb_check_pages(cpu_buffer);
> > 			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> > 			cpu_buffer->read_disabled--;
> > 			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> > 
> > Or something like that. Yes, that also requires creating a new
> > "read_disabled" field in the ring_buffer_per_cpu code.  
> 
> I think this would work but I'm personally not immediately sold on this
> approach. If I understand the idea correctly, readers should then check
> whether cpu_buffer->read_disabled is set and bail out with some error if
> that is the case. The rb_check_pages() function is only a self-check
> code and as such, I feel it doesn't justify disrupting readers with
> a new error condition and adding more complex locking.

Honestly, this code was never made for more than one reader per
cpu_buffer. I'm perfectly fine if all check_pages() causes other
readers to the same per_cpu buffer to get -EBUSY.

Do you really see this being a problem? What use case is there for
hitting the check_pages() and reading the same cpu buffer at the same
time?

-- Steve

