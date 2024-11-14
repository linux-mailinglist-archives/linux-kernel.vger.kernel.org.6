Return-Path: <linux-kernel+bounces-409594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D91F9C8EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E705228977A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E692418CC0C;
	Thu, 14 Nov 2024 15:53:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA98487BF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599631; cv=none; b=Znt3WWdpEjTaVUD/mD+FYfsm9GoDaZ7Sd2CwmZZRuEIs59Hlzjdn1lJbGx6bdRcCAZeZCFqvnooJ8ROclZOA5hZglttUJ3q8XyP0I0ohOJvKzNH602NLinARQHO78H++WMYOSaWGo+6YOGI1G9aQV9vcDBb4GAyEVSFjqD5SlHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599631; c=relaxed/simple;
	bh=XvKm27mu5dDXZTEjbH/rYYsOXdnLHAPNYRhv5/bN9nk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K20GZ6nHLbGOosEBNK6ItKR3iLG6vvVp5UIcPgJBifOGLyZKp5sLo9cC2yxOb6/vf/vAi6MQiWGBG0u856sGz5I2I1SGkqRYVaO6qPf8mx/BBRUSzw/Sq+7OYZbh8uX4NuEli3vw5a0otjogv1uF+9hBQzVRHW+GA1gGIZ/KZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73590C4CECD;
	Thu, 14 Nov 2024 15:53:50 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:54:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [GIT PULL] ring-buffer: Revert previous fix as it wasn't the
 actual fix
Message-ID: <20241114105412.43b00a95@gandalf.local.home>
In-Reply-To: <20241114104149.1da4f584@gandalf.local.home>
References: <20241114104149.1da4f584@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi Linus,

You can hold off on pulling this. I just found another issue I want to fix
and will likely have another pull request tomorrow on top of this one.

-- Steve


On Thu, 14 Nov 2024 10:41:49 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Linus,
> 
> Revert: "ring-buffer: Do not have boot mapped buffers hook to CPU hotplug"
> 
> - A crash that happened on cpu hotplug was actually caused by the incorrect
>   ref counting that was fixed by commit 2cf9733891a4 ("ring-buffer: Fix
>   refcount setting of boot mapped buffers"). The removal of calling cpu
>   hotplug callbacks on memory mapped buffers was not an issue even though
>   the tests at the time pointed toward it. But in fact, there's a check in
>   that code that tests to see if the buffers are already allocated or not,
>   and will not allocate them again if they are. Not calling the cpu hotplug
>   callbacks ended up not initializing the non boot CPU buffers.
> 
>   Simply remove that change.
> 
> 
> Please pull the latest trace-ringbuffer-v6.12-rc7 tree, which can be found at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> trace-ringbuffer-v6.12-rc7
> 
> Tag SHA1: 81ccc26cac30f76e5fb6d76aec178677c3e209ad
> Head SHA1: 580bb355bcae7e9a6606ce9644af09b2a793f1bb
> 
> 
> Steven Rostedt (1):
>       Revert: "ring-buffer: Do not have boot mapped buffers hook to CPU hotplug"
> 
> ----
>  kernel/trace/ring_buffer.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> ---------------------------
> commit 580bb355bcae7e9a6606ce9644af09b2a793f1bb
> Author: Steven Rostedt <rostedt@goodmis.org>
> Date:   Wed Nov 13 23:08:39 2024 -0500
> 
>     Revert: "ring-buffer: Do not have boot mapped buffers hook to CPU hotplug"
>     
>     A crash happened when testing cpu hotplug with respect to the memory
>     mapped ring buffers. It was assumed that the hot plug code was adding a
>     per CPU buffer that was already created that caused the crash. The real
>     problem was due to ref counting and was fixed by commit 2cf9733891a4
>     ("ring-buffer: Fix refcount setting of boot mapped buffers").
>     
>     When a per CPU buffer is created, it will not be created again even with
>     CPU hotplug, so the fix to not use CPU hotplug was a red herring. In fact,
>     it caused only the boot CPU buffer to be created, leaving the other CPU
>     per CPU buffers disabled.
>     
>     Revert that change as it was not the culprit of the fix it was intended to
>     be.
>     
>     Cc: Masami Hiramatsu <mhiramat@kernel.org>
>     Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>     Link: https://lore.kernel.org/20241113230839.6c03640f@gandalf.local.home
>     Fixes: 912da2c384d5 ("ring-buffer: Do not have boot mapped buffers hook to CPU hotplug")
>     Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 3ea4f7bb1837..5807116bcd0b 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2337,12 +2337,9 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
>  	if (!buffer->buffers[cpu])
>  		goto fail_free_buffers;
>  
> -	/* If already mapped, do not hook to CPU hotplug */
> -	if (!start) {
> -		ret = cpuhp_state_add_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
> -		if (ret < 0)
> -			goto fail_free_buffers;
> -	}
> +	ret = cpuhp_state_add_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
> +	if (ret < 0)
> +		goto fail_free_buffers;
>  
>  	mutex_init(&buffer->mutex);
>  


