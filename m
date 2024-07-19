Return-Path: <linux-kernel+bounces-257497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47791937ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBB01F23C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5808D146A8B;
	Fri, 19 Jul 2024 16:19:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58CA14601F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405982; cv=none; b=G7kPXuOjoaUd6j6vVuoDbybNKBsJTX7iSw46WgRjCf+XA8i0kahYbLr7gv+4v7CzRn+kYPIigfCankHHNsNDCGnkB+JegiALXO8uuGRffD+vJHFcgAmCpgbfi4oB8MKIziYsSbUvMsJSMkefuFEvQ3ZdBsdGpvqMaRo9WhFq/Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405982; c=relaxed/simple;
	bh=1i0PzR7QkgmqmeaO9W5e8cM06PuMNASiDLVM3pB9ruA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTXPG1mXbLXIthikFpWLqbmwK7EnyNMeNz/Y5mRLpfVjjBFZr/cD9y9YN84N+Dsa0iKT03GTPb+eSu6zwUiLMoD831tLR2zHlAMiTomc2Iao38gs9+4ToG+5UnqLcEDO5g1VD5p6QPeV3k8MVMH5WwJ2+K9pKJc6hDsFah7hwFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB232C32782;
	Fri, 19 Jul 2024 16:19:41 +0000 (UTC)
Date: Fri, 19 Jul 2024 12:19:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, Thorsten Blum
 <thorsten.blum@toblux.com>
Subject: Re: [GIT PULL] ring-buffer: Updates for 6.11
Message-ID: <20240719121940.5ce9a90a@rorschach.local.home>
In-Reply-To: <7e29c303-c91f-4229-9b9d-b60d8a60c38b@efficios.com>
References: <20240716155118.152dea35@rorschach.local.home>
	<a71100aa-ffe4-477e-814a-1564e00cb067@efficios.com>
	<20240719103218.6c1eedfc@rorschach.local.home>
	<7e29c303-c91f-4229-9b9d-b60d8a60c38b@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jul 2024 10:59:37 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > So I went to update this, and realized there's no place that actually
> > mentions anything about this being used across reboots (besides in the
> > change logs). The only documentation is in kernel-parameters.txt:
> > 
> >                          If memory has been reserved (see memmap for x86), the instance
> >                          can use that memory:
> >                          
> >                                  memmap=12M$0x284500000 trace_instance=boot_map@0x284500000:12M
> > 
> >                          The above will create a "boot_map" instance that uses the physical
> >                          memory at 0x284500000 that is 12Megs. The per CPU buffers of that
> >                          instance will be split up accordingly.
> > 
> > I do plan on adding more documentation on the use cases of this, but I
> > was planning on doing that in the next merge window when the
> > reserve_mem kernel parameter can be used. Right now, we only document
> > what it does, and not what it is used for.
> > 
> > Do you still have an issue with that part missing? No where does it
> > mention that this is used across boots. There is a file created in the
> > boot mapped instance directory that hints to the usage
> > (last_boot_info), but still there's no assumptions made.
> > 
> > In other words, why document a restriction on something that hasn't
> > been documented?  
> 
> AFAIU the intended use of this feature is to convey trace buffer
> data from one kernel to the next across a reboot, which makes it
> a whole different/new kind of ABI.

That may be my intention, but there's nothing here to imply that. In
fact, after I read the document, it looks to me as a way to simply
designate a location of address space for the ring buffer. This could
be because of some special hardware. Nothing here says "exists on
reboot". Thinking that this implies that the ring buffer will last
across boots is not going to make it a new API. In fact, in my test
cases, it fails (due to KASLR) approximately once every 5 boots. So
it's not something you can even rely on.

> 
> Having no documentation will not stop anyone from using this new
> feature and make assumptions about ABI guarantees. I am concerned
> that this ABI ends up being defined by accident/misuses rather than
> by design if it is merged without documentation.

This is not an ABI. Remember, Linus's mandate is to "not break user
space". There's no use space involved here.

> 
> Very often when I find myself documenting a feature, I look back at
> the user-facing result and modify the ABI where it does not make
> sense. Merging this ABI without documentation prevents that.

Again, this isn't a "user facing feature", where I consider "user"
being user space.

> 
> So if you ask my honest opinion there, I would say that merging this
> ABI without documentation feels rushed.

It's not an ABI (Application Binary Interface). What's the application?
What's the binary interface? It's a kernel command line telling the
kernel to place the ring buffer at some specific address space. Nothing
more.

-- Steve



