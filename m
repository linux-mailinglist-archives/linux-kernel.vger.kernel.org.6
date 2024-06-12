Return-Path: <linux-kernel+bounces-211645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA849054D4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A25B22F98
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1884417E8E8;
	Wed, 12 Jun 2024 14:12:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947CA5336D;
	Wed, 12 Jun 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201569; cv=none; b=evKe0sodGpgmMnlW2V9CxSjR36jSCBYTqV3e0gyDXXKB0+S+vEEFBF6O/v05AJuay2Jfmjl8o7zbakqkMy0Q2yPaUSYNsFlOAM3Xbv5XA0NUU/ryQIlzxNeIZNlXHGC/R+4EJCswbbbrBJmabVvKLdlSD2O757B4nf7BZwe5eac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201569; c=relaxed/simple;
	bh=iOMYlsNUD4In4rhG3CCxDYocCLMlHDu5Sy6BBOT1Ab8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSdm7JBfbZxg+btfWba1KIqoAS3Zb17kiIyckxeR9IhlKrXxmnvdIaGyWV4gBZvWmU2MKUS144yd5WA8IR4w6uyU/IVRFTn0YZsPZbNl4hcZ7nZbkKXkJI8hEXdBqa95GDs8BaJuIYB8jCa6rTZ2AE4TGIPOCGoBpcgaIRXwEBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D923BC4AF1A;
	Wed, 12 Jun 2024 14:12:45 +0000 (UTC)
Date: Wed, 12 Jun 2024 10:12:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vincent Donnefort
 <vdonnefort@google.com>, Joel Fernandes <joel@joelfernandes.org>, Daniel
 Bristot de Oliveira <bristot@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, suleiman@google.com, Thomas Gleixner
 <tglx@linutronix.de>, Vineeth Pillai <vineeth@bitbyteword.org>, Youssef
 Esmat <youssefesmat@google.com>, Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>, Borislav
 Petkov <bp@alien8.de>, "Paul E. McKenney" <paulmck@kernel.org>, David
 Howells <dhowells@redhat.com>, Mike Rapoport <rppt@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Guenter
 Roeck <linux@roeck-us.net>, Ross Zwisler <zwisler@google.com>, Kees Cook
 <keescook@chromium.org>
Subject: Re: [PATCH v5 01/13] ring-buffer: Allow mapped field to be set
 without mapping
Message-ID: <20240612101245.1a6a5836@rorschach.local.home>
In-Reply-To: <20240612021722.239841009@goodmis.org>
References: <20240612021642.941740855@goodmis.org>
	<20240612021722.239841009@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 22:16:43 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> In preparation for having the ring buffer mapped to a dedicated location,
> which will have the same restrictions as user space memory mapped buffers,
> allow it to use the "mapped" field of the ring_buffer_per_cpu structure
> without having the user space meta page mapping.
> 
> When this starts using the mapped field, it will need to handle adding a
> user space mapping (and removing it) from a ring buffer that is using a
> dedicated memory range.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 28853966aa9a..aa8eb878e0d4 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -491,6 +491,7 @@ struct ring_buffer_per_cpu {
>  	unsigned long			pages_removed;
>  
>  	unsigned int			mapped;
> +	unsigned int			user_mapped;	/* first user space mapping */

This actually needs to be a counter and not just save the mapped value
when it first gets set :-p

As the mappings could technically be incremented and decremented
differently.

I'll send a new patch. But since my long test keeps failing for subtle
things, I'm not going to post another series until the full test passes.

-- Steve


>  	struct mutex			mapping_lock;
>  	unsigned long			*subbuf_ids;	/* ID to subbuf VA */
>  	struct trace_buffer_meta	*meta_page;
> @@ -5224,6 +5225,9 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
>  {
>  	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
>  
> +	if (!meta)
> +		return;
> +
>  	meta->reader.read = cpu_buffer->reader_page->read;
>  	meta->reader.id = cpu_buffer->reader_page->id;
>  	meta->reader.lost_events = cpu_buffer->lost_events;
> @@ -6167,7 +6171,7 @@ rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
>  
>  	mutex_lock(&cpu_buffer->mapping_lock);
>  
> -	if (!cpu_buffer->mapped) {
> +	if (!cpu_buffer->mapped || !cpu_buffer->meta_page) {
>  		mutex_unlock(&cpu_buffer->mapping_lock);
>  		return ERR_PTR(-ENODEV);
>  	}
> @@ -6194,7 +6198,7 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
>  	if (inc && cpu_buffer->mapped == UINT_MAX)
>  		return -EBUSY;
>  
> -	if (WARN_ON(!inc && cpu_buffer->mapped == 0))
> +	if (WARN_ON(!inc && cpu_buffer->mapped < cpu_buffer->user_mapped))
>  		return -EINVAL;
>  
>  	mutex_lock(&cpu_buffer->buffer->mutex);
> @@ -6328,7 +6332,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
>  
>  	mutex_lock(&cpu_buffer->mapping_lock);
>  
> -	if (cpu_buffer->mapped) {
> +	if (cpu_buffer->user_mapped) {
>  		err = __rb_map_vma(cpu_buffer, vma);
>  		if (!err)
>  			err = __rb_inc_dec_mapped(cpu_buffer, true);
> @@ -6359,12 +6363,15 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
>  	 */
>  	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>  	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
> +
>  	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>  
>  	err = __rb_map_vma(cpu_buffer, vma);
>  	if (!err) {
>  		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> -		cpu_buffer->mapped = 1;
> +		/* This is the first time it is mapped externally */
> +		cpu_buffer->mapped++;
> +		cpu_buffer->user_mapped = cpu_buffer->mapped;
>  		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>  	} else {
>  		kfree(cpu_buffer->subbuf_ids);
> @@ -6392,10 +6399,10 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
>  
>  	mutex_lock(&cpu_buffer->mapping_lock);
>  
> -	if (!cpu_buffer->mapped) {
> +	if (!cpu_buffer->user_mapped) {
>  		err = -ENODEV;
>  		goto out;
> -	} else if (cpu_buffer->mapped > 1) {
> +	} else if (cpu_buffer->mapped > cpu_buffer->user_mapped) {
>  		__rb_inc_dec_mapped(cpu_buffer, false);
>  		goto out;
>  	}
> @@ -6403,7 +6410,10 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
>  	mutex_lock(&buffer->mutex);
>  	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>  
> -	cpu_buffer->mapped = 0;
> +	/* This is the last user space mapping */
> +	if (!WARN_ON_ONCE(cpu_buffer->mapped != cpu_buffer->user_mapped))
> +		cpu_buffer->mapped--;
> +	cpu_buffer->user_mapped = 0;
>  
>  	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>  


