Return-Path: <linux-kernel+bounces-574226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC60A6E23B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428AE3A973C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573862641C8;
	Mon, 24 Mar 2025 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RqDxtzo2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB23210FB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742840679; cv=none; b=JU3yEN86rz7U7JMMEhzPHt0ntDA1jFWE5J/S4dg31DqXo+8qsYS0VhFU5j3ynD2FJn0IJA9OPdHNMTgmlp66ur6qabNdEJKpO1Fx06FSQAW8S29KV2ZZbPA2TsaB8cQWNXMlaGE4WL5IPSWrxfDojnHTFNvmbQ0Lb82Z2FNrK4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742840679; c=relaxed/simple;
	bh=xXzfj9fQLP7hjMh90JgOK+ainmvisxrWtghTMWsJ100=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUfsMg/8fMEfq1GA5vt45uKq856vBvj067ZktofjBa8r4oWnwrmld3pTmkYlrYna1v+C7BL/G/N0NFlSOKtgYs6mnHGTJUKLxNV28DjjrUAKWopGE2K7bFHKJSOhJEGqUgsmxbicyRhZBoCilcA7VS6qi+53H8qqbGJktUE3eAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RqDxtzo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE78C4CEDD;
	Mon, 24 Mar 2025 18:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742840679;
	bh=xXzfj9fQLP7hjMh90JgOK+ainmvisxrWtghTMWsJ100=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqDxtzo2CL5SfoMu2IkjOsYyJqbZd+Gj9u6f9IHVhteFl9gHI+ip6cAYVAiAu6cjK
	 +dEIljTLIDU4zY7Y5gAhE/PsztXy2C6ilGcLDx2F7kz/vpicPRlQxlOujsE2bhYA3/
	 TIX5bUZQ/YpSP0MOA/z/DRTaMBvfkpI0rTzIlfpI=
Date: Mon, 24 Mar 2025 11:23:16 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Tiffany Y. Yang" <ynaffit@google.com>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2] binder: use buffer offsets in debug logs
Message-ID: <2025032403-spout-unabashed-5df1@gregkh>
References: <20250324180716.1012478-3-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324180716.1012478-3-ynaffit@google.com>

On Mon, Mar 24, 2025 at 06:07:18PM +0000, Tiffany Y. Yang wrote:
> Identify buffer addresses using vma offsets instead of full user
> addresses in debug logs.
> 
> Signed-off-by: Tiffany Y. Yang <ynaffit@google.com>
> ---
>  drivers/android/binder.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index d1aa6d24450a..994ae205aa07 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3261,20 +3261,20 @@ static void binder_transaction(struct binder_proc *proc,
>  
>  	if (reply)
>  		binder_debug(BINDER_DEBUG_TRANSACTION,
> -			     "%d:%d BC_REPLY %d -> %d:%d, data %016llx-%016llx size %lld-%lld-%lld\n",
> +			     "%d:%d BC_REPLY %d -> %d:%d, buffer offset %lx-%lx size %lld-%lld-%lld\n",
>  			     proc->pid, thread->pid, t->debug_id,
>  			     target_proc->pid, target_thread->pid,
> -			     (u64)tr->data.ptr.buffer,
> -			     (u64)tr->data.ptr.offsets,
> +			     (unsigned long)tr->data.ptr.buffer - proc->alloc.buffer,
> +			     (unsigned long)tr->data.ptr.offsets - proc->alloc.buffer,
>  			     (u64)tr->data_size, (u64)tr->offsets_size,
>  			     (u64)extra_buffers_size);
>  	else
>  		binder_debug(BINDER_DEBUG_TRANSACTION,
> -			     "%d:%d BC_TRANSACTION %d -> %d - node %d, data %016llx-%016llx size %lld-%lld-%lld\n",
> +			     "%d:%d BC_TRANSACTION %d -> %d - node %d, buffer offset %lx-%lx size %lld-%lld-%lld\n",
>  			     proc->pid, thread->pid, t->debug_id,
>  			     target_proc->pid, target_node->debug_id,
> -			     (u64)tr->data.ptr.buffer,
> -			     (u64)tr->data.ptr.offsets,
> +			     (unsigned long)tr->data.ptr.buffer - proc->alloc.buffer,
> +			     (unsigned long)tr->data.ptr.offsets - proc->alloc.buffer,
>  			     (u64)tr->data_size, (u64)tr->offsets_size,
>  			     (u64)extra_buffers_size);
>  
> @@ -4223,20 +4223,21 @@ static int binder_thread_write(struct binder_proc *proc,
>  			if (IS_ERR_OR_NULL(buffer)) {
>  				if (PTR_ERR(buffer) == -EPERM) {
>  					binder_user_error(
> -						"%d:%d BC_FREE_BUFFER u%016llx matched unreturned or currently freeing buffer\n",
> +						"%d:%d BC_FREE_BUFFER matched unreturned or currently freeing buffer at offset %lx\n",
>  						proc->pid, thread->pid,
> -						(u64)data_ptr);
> +						(unsigned long)data_ptr - proc->alloc.buffer);
>  				} else {
>  					binder_user_error(
> -						"%d:%d BC_FREE_BUFFER u%016llx no match\n",
> +						"%d:%d BC_FREE_BUFFER no match for buffer at offset %lx\n",
>  						proc->pid, thread->pid,
> -						(u64)data_ptr);
> +						(unsigned long)data_ptr - proc->alloc.buffer);
>  				}
>  				break;
>  			}
>  			binder_debug(BINDER_DEBUG_FREE_BUFFER,
> -				     "%d:%d BC_FREE_BUFFER u%016llx found buffer %d for %s transaction\n",
> -				     proc->pid, thread->pid, (u64)data_ptr,
> +				     "%d:%d BC_FREE_BUFFER at offset %lx found buffer %d for %s transaction\n",
> +				     proc->pid, thread->pid,
> +				     (unsigned long)data_ptr - proc->alloc.buffer,
>  				     buffer->debug_id,
>  				     buffer->transaction ? "active" : "finished");
>  			binder_free_buf(proc, thread, buffer, false);
> @@ -5053,7 +5054,7 @@ static int binder_thread_read(struct binder_proc *proc,
>  		trace_binder_transaction_received(t);
>  		binder_stat_br(proc, thread, cmd);
>  		binder_debug(BINDER_DEBUG_TRANSACTION,
> -			     "%d:%d %s %d %d:%d, cmd %u size %zd-%zd ptr %016llx-%016llx\n",
> +			     "%d:%d %s %d %d:%d, cmd %u size %zd-%zd ptr offset %lx-%lx\n",
>  			     proc->pid, thread->pid,
>  			     (cmd == BR_TRANSACTION) ? "BR_TRANSACTION" :
>  				(cmd == BR_TRANSACTION_SEC_CTX) ?
> @@ -5061,8 +5062,8 @@ static int binder_thread_read(struct binder_proc *proc,
>  			     t->debug_id, t_from ? t_from->proc->pid : 0,
>  			     t_from ? t_from->pid : 0, cmd,
>  			     t->buffer->data_size, t->buffer->offsets_size,
> -			     (u64)trd->data.ptr.buffer,
> -			     (u64)trd->data.ptr.offsets);
> +			     (unsigned long)trd->data.ptr.buffer - proc->alloc.buffer,
> +			     (unsigned long)trd->data.ptr.offsets - proc->alloc.buffer);
>  
>  		if (t_from)
>  			binder_thread_dec_tmpref(t_from);
> -- 
> 2.49.0.395.g12beb8f557-goog
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

