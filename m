Return-Path: <linux-kernel+bounces-556262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A096A5C346
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065073A907D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27E325B666;
	Tue, 11 Mar 2025 14:08:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BE31C07D9;
	Tue, 11 Mar 2025 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702120; cv=none; b=k7MdShw1k8QDLXx+CXbrbAvS5tslCCUOX88Hp13/aHU/8EK2q2kKhKSChHYhk2ZRuE7qI5J7By5MAwuAiPQaiFcqVTw2ekblw3jo9ZtcthNh0UOCkFmWqCjXO6E/o+LtWCvBfOvUmCwT2F92vh9/hcRACZ7bI4fLwKp1iZv2MaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702120; c=relaxed/simple;
	bh=/0aJfE3w+ZRG+dTjYxqTqSTxFVwN+j1mMW6vC7nALZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3z3/tQqyqP+FMQgUjGuRufIIbtjOp0ifm9oAHNpQ66BNZDOYG8R9bwvNgyeZ+iI5QHXb8j2ln6Vds4DOACMD6NKPINqW51PGylonjm3fuZJnZ2K0HZK8yv18cbodWHA504LjE455oZBQINwVkFhVM0eDXpGyRsN1iNdPs/hMGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C7DC4CEE9;
	Tue, 11 Mar 2025 14:08:38 +0000 (UTC)
Date: Tue, 11 Mar 2025 10:08:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3] tracing: Show last module text symbols in the
 stacktrace
Message-ID: <20250311100832.747b3b83@batman.local.home>
In-Reply-To: <174161444691.1063601.16690699136628689205.stgit@devnote2>
References: <174161444691.1063601.16690699136628689205.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 22:47:27 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the previous boot trace buffer can include module text address in
> the stacktrace. As same as the kernel text address, convert the module
> text address using the module address information.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v3:
>   - Move module_delta to trace_scratch data structure.
>   - Remove LRU based removed module information.
> ---
>  kernel/trace/trace.c        |   99 +++++++++++++++++++++++++++++++++++++++++--
>  kernel/trace/trace.h        |    2 +
>  kernel/trace/trace_output.c |    4 +-
>  3 files changed, 98 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index c3c79908766e..0c1aa1750077 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -49,6 +49,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/irq_work.h>
>  #include <linux/workqueue.h>
> +#include <linux/sort.h>
>  
>  #include <asm/setup.h> /* COMMAND_LINE_SIZE and kaslr_offset() */
>  
> @@ -5996,11 +5997,41 @@ struct trace_mod_entry {
>  struct trace_scratch {
>  	unsigned long		kaslr_addr;
>  	unsigned long		nr_entries;
> +	long			*module_delta;

Why are we adding this pointer into the persistent memory when it is
useless after a crash?

>  	struct trace_mod_entry	entries[];
>  };
>  
>  static DEFINE_MUTEX(scratch_mutex);
>  
> +/**
> + * trace_adjust_address() - Adjust prev boot address to current address.
> + * @tr: Persistent ring buffer's trace_array.
> + * @addr: Address in @tr which is adjusted.
> + */
> +unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr)
> +{
> +	struct trace_scratch *tscratch;
> +	long *module_delta;
> +	int i;
> +
> +	/* If we don't have last boot delta, return the address */
> +	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
> +		return addr;
> +
> +	tscratch = tr->scratch;
> +	module_delta = READ_ONCE(tscratch->module_delta);
> +	if (!tscratch || !tscratch->nr_entries || !module_delta ||

You shouldn't have a !tscratch test just after dereferencing it:

		tscratch->module_delta

Perhaps have it be:

	module_delta = tscratch ? READ_ONCE(tscratch->module_delta) : 0;
	if (!module_delta || !tscratch->nr_entries || tscratch->entries[0].mod_addr > addr)


> +	    tscratch->entries[0].mod_addr > addr)
> +		return addr + tr->text_delta;
> +
> +	/* Note that entries must be sorted. */
> +	for (i = 0; i < tscratch->nr_entries; i++)
> +		if (addr < tscratch->entries[i].mod_addr)
> +			break;

If we are bother sorting it, why not do a binary search here?

> +
> +	return addr + module_delta[i - 1];
> +}
> +
>  static int save_mod(struct module *mod, void *data)
>  {
>  	struct trace_array *tr = data;
> @@ -6029,6 +6060,7 @@ static int save_mod(struct module *mod, void *data)
>  static void update_last_data(struct trace_array *tr)
>  {
>  	struct trace_scratch *tscratch;
> +	long *module_delta;
>  
>  	if (!(tr->flags & TRACE_ARRAY_FL_BOOT))
>  		return;
> @@ -6063,6 +6095,8 @@ static void update_last_data(struct trace_array *tr)
>  		return;
>  
>  	tscratch = tr->scratch;
> +	module_delta = READ_ONCE(tscratch->module_delta);
> +	WRITE_ONCE(tscratch->module_delta, NULL);
>  
>  	/* Set the persistent ring buffer meta data to this address */
>  #ifdef CONFIG_RANDOMIZE_BASE
> @@ -6071,6 +6105,8 @@ static void update_last_data(struct trace_array *tr)
>  	tscratch->kaslr_addr = 0;
>  #endif
>  	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
> +
> +	kfree(module_delta);
>  }
>  
>  /**
> @@ -9342,10 +9378,43 @@ static struct dentry *trace_instance_dir;
>  static void
>  init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
>  
> +static int make_mod_delta(struct module *mod, void *data)
> +{
> +	struct trace_scratch *tscratch;
> +	struct trace_mod_entry *entry;
> +	struct trace_array *tr = data;
> +	long *module_delta;
> +	int i;
> +
> +	tscratch = tr->scratch;
> +	module_delta = READ_ONCE(tscratch->module_delta);
> +	for (i = 0; i < tscratch->nr_entries; i++) {
> +		entry = &tscratch->entries[i];
> +		if (!strcmp(mod->name, entry->mod_name)) {
> +			if (mod->state == MODULE_STATE_GOING)
> +				module_delta[i] = 0;
> +			else
> +				module_delta[i] = (unsigned long)mod->mem[MOD_TEXT].base
> +						 - entry->mod_addr;
> +			break;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int mod_addr_comp(const void *a, const void *b, const void *data)
> +{
> +	const struct trace_mod_entry *e1 = a;
> +	const struct trace_mod_entry *e2 = b;
> +
> +	return e1->mod_addr > e2->mod_addr ? 1 : -1;
> +}
> +
>  static void setup_trace_scratch(struct trace_array *tr,
>  				struct trace_scratch *tscratch, unsigned int size)
>  {
>  	struct trace_mod_entry *entry;
> +	int i, nr_entries;
>  
>  	if (!tscratch)
>  		return;
> @@ -9362,7 +9431,7 @@ static void setup_trace_scratch(struct trace_array *tr,
>  		goto reset;
>  
>  	/* Check if each module name is a valid string */
> -	for (int i = 0; i < tscratch->nr_entries; i++) {
> +	for (i = 0; i < tscratch->nr_entries; i++) {
>  		int n;
>  
>  		entry = &tscratch->entries[i];
> @@ -9376,6 +9445,21 @@ static void setup_trace_scratch(struct trace_array *tr,
>  		if (n == MODULE_NAME_LEN)
>  			goto reset;
>  	}
> +
> +	nr_entries = i;
> +	tscratch->module_delta = kcalloc(nr_entries, sizeof(long), GFP_KERNEL);
> +	if (!tscratch->module_delta) {
> +		pr_info("module_delta allocation failed. Not able to decode module address.");
> +		goto reset;
> +	}
> +
> +	/* Sort the entries so that we can find appropriate module from address. */
> +	sort_r(tscratch->entries, nr_entries, sizeof(struct trace_mod_entry),
> +	       mod_addr_comp, NULL, NULL);
> +
> +	/* Scan modules to make text delta for modules. */
> +	module_for_each_mod(make_mod_delta, tr);
> +
>  	return;
>   reset:
>  	/* Invalid trace modules */
> @@ -10101,19 +10185,23 @@ static bool trace_array_active(struct trace_array *tr)
>  	return trace_events_enabled(tr, NULL) > 1;
>  }
>  
> -static void trace_module_record(struct module *mod)
> +static void trace_module_record(struct module *mod, bool remove)
>  {
>  	struct trace_array *tr;
> +	unsigned long flags;
>  
>  	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> +		flags = tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT);
>  		/* Update any persistent trace array that has already been started */
> -		if ((tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT)) ==
> -		    TRACE_ARRAY_FL_BOOT) {
> +		if (flags == TRACE_ARRAY_FL_BOOT && !remove) {

Can you rename the parameter from "remove" to "add" so we don't have a
double negative.

		if (flags == TRACE_ARRAY_FL_BOOT && add) {


>  			/* Only update if the trace array is active */
>  			if (trace_array_active(tr)) {
>  				guard(mutex)(&scratch_mutex);
>  				save_mod(mod, tr);
>  			}
> +		} else if (flags & TRACE_ARRAY_FL_LAST_BOOT) {
> +			/* Update delta if the module loaded in previous boot */
> +			make_mod_delta(mod, tr);
>  		}
>  	}
>  }
> @@ -10126,10 +10214,11 @@ static int trace_module_notify(struct notifier_block *self,
>  	switch (val) {
>  	case MODULE_STATE_COMING:
>  		trace_module_add_evals(mod);
> -		trace_module_record(mod);
> +		trace_module_record(mod, false);

		trace_module_record(mod, true);

>  		break;
>  	case MODULE_STATE_GOING:
>  		trace_module_remove_evals(mod);
> +		trace_module_record(mod, true);

		trace_module_record(mod, false);

>  		break;
>  	}
>  
>

-- Steve

