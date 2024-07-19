Return-Path: <linux-kernel+bounces-257379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96826937936
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5251B282F65
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D3CC2D6;
	Fri, 19 Jul 2024 14:32:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDC63D62
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399541; cv=none; b=eBIalnJ6zpwe/7YxPXd6yQe4ecfTINaNl5C9uJeiP01+6Drronnaby6TLux6dOd6+V7QMcVXOw+izEYjmch695LqBD2qLfwV2HKgzpzb2CR9c0noRNu2XACI8Bs/S+lYLZ+gtNc6ZZr7OGbI4cMsZSZ/1vv0QnW3+FSsHQIFdDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399541; c=relaxed/simple;
	bh=H0/pVJkUPBAloJUYHyhfiIj/4kICO5yYgHMXhRxQV8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPuLBgjaCJZ2Q0KBBo81SaGPqjZWjGVSCRRGRtVap8QkkBAwoay8ckISz0KN+QCmunbddEXPu7UYxvMKINHqdXjnP4YGnUlSXuZ58hiknlkry7PzPmBvn+Ev8E30h5BcJ8vSnIFL8U3W+W+gpDhwN8ItBqmKjR12Vj+NLday/qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE43C32782;
	Fri, 19 Jul 2024 14:32:19 +0000 (UTC)
Date: Fri, 19 Jul 2024 10:32:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, Thorsten Blum
 <thorsten.blum@toblux.com>
Subject: Re: [GIT PULL] ring-buffer: Updates for 6.11
Message-ID: <20240719103218.6c1eedfc@rorschach.local.home>
In-Reply-To: <a71100aa-ffe4-477e-814a-1564e00cb067@efficios.com>
References: <20240716155118.152dea35@rorschach.local.home>
	<a71100aa-ffe4-477e-814a-1564e00cb067@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jul 2024 16:05:26 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2024-07-16 15:51, Steven Rostedt wrote:
> > 
> > 
> > Linus,
> > 
> > tracing/ring-buffer: Have persistent buffer across reboots  
> 
> Hi Steven,
> 
> Perhaps I'm missing something here, but we discussed previously that
> you would document the fact that users of this feature are expected
> to run the same kernel before/after reboot.
> 
> Looking at this PR, I fail to find that documentation, or in fact
> any documentation at all. Is this something that was overlooked ?

So I went to update this, and realized there's no place that actually
mentions anything about this being used across reboots (besides in the
change logs). The only documentation is in kernel-parameters.txt:

                        If memory has been reserved (see memmap for x86), the instance
                        can use that memory:
                        
                                memmap=12M$0x284500000 trace_instance=boot_map@0x284500000:12M

                        The above will create a "boot_map" instance that uses the physical
                        memory at 0x284500000 that is 12Megs. The per CPU buffers of that
                        instance will be split up accordingly.

I do plan on adding more documentation on the use cases of this, but I
was planning on doing that in the next merge window when the
reserve_mem kernel parameter can be used. Right now, we only document
what it does, and not what it is used for.

Do you still have an issue with that part missing? No where does it
mention that this is used across boots. There is a file created in the
boot mapped instance directory that hints to the usage
(last_boot_info), but still there's no assumptions made.

In other words, why document a restriction on something that hasn't
been documented?

-- Steve

