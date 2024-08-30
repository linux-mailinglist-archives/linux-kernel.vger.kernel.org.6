Return-Path: <linux-kernel+bounces-307891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D46AF9654AA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D211C21F03
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F062A364D6;
	Fri, 30 Aug 2024 01:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wk202Rnm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W1AqS0GS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DcgODDeG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3eSFWCsJ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D5C1D131D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724981159; cv=none; b=pW0dJY83PLfQJNKW6UeLeUoS2+UQguMHUdKpWmTU60V0cuFPdqyBaUptiLRnXWSypHvjKQIqVNukaj1k8kdeBGqkqxpkR01Mi2Qmy5AHx9Cuu40C4Sr/Y+/jDenwXWShYP83iwulvmtUmOf/Cr2vdFALnIanY3AJBLhYpJ7Si+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724981159; c=relaxed/simple;
	bh=+gR0cGdgBkEhuhPaAEsIhvm08TkihZhAZ/tk1eKThIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXxsRYxDJ9ocoaJrkvNcsl5W0rH7LEaZpnVqVd8sNMuU3fFXBxWEZPUwBh2rEdk61j8h7TW10WksHOl9i2WlmTVKgRmT7w6YUE1DbVxRp8VlWUaNd1PmDWJhLrai4Qa4Dv7zgZYskX8/T+SfWJ5o+5wfTnUbwUcbWtFsvehJhIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wk202Rnm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W1AqS0GS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DcgODDeG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3eSFWCsJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2DBE51F78E;
	Fri, 30 Aug 2024 01:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724981155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHsq2qSnzK/WyObA9tNCLJrjzJAu6qt4bkngVOGgmrc=;
	b=wk202Rnm0bCKb/+R4QSMV/Ikt7s1XtHr37K5qhdYOVgyTSK6zKr5wC/VYHJ4aRglsLPSos
	DVQ3XDqs64hIg0rMd7E1/B4xYXgxgUZNleaffX1qQA1WMgOsOrxauoQ2mQMPgjSv9+w7LA
	UK/sisof1goq1pcbn3sl8fVRmqBjGec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724981155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHsq2qSnzK/WyObA9tNCLJrjzJAu6qt4bkngVOGgmrc=;
	b=W1AqS0GSo76VkimdCz1IkhiR9mHtOZIfa1pdMeWN+ehlC0IsKtqQqxebzuQivhSdrPqg2a
	WYeNo8bBFU21dDAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724981154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHsq2qSnzK/WyObA9tNCLJrjzJAu6qt4bkngVOGgmrc=;
	b=DcgODDeGPHuXjFVv6PKz75VAXftwz4jc0s+uj6RDacDQ/fQXPvdKsyRP1xoSAH2bHRouTY
	BiqnV/hsUt3CT6vVxAyEPtP8M6A0wIpDkSktIZgszywfaeW56CilXTsGkqXMF8A1jPL6UO
	MXsznAjEQJVNFd/yeqadQOTNglePGu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724981154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHsq2qSnzK/WyObA9tNCLJrjzJAu6qt4bkngVOGgmrc=;
	b=3eSFWCsJNNO8nPCIwEkqvCt+nBFzMkG5grAsKLuKGFNav+7ZuvF6KW7jY0Y5Wrh3+DH1wd
	ZX9NCKOB/SeyaECA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3EEB139B0;
	Fri, 30 Aug 2024 01:25:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lvuRFJ4f0Wb7BAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Fri, 30 Aug 2024 01:25:50 +0000
Date: Fri, 30 Aug 2024 01:25:35 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linux-kernel-library@freelists.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Mel Gorman <mgorman@suse.de>,
 Hajime Tazaki <thehajime@gmail.com>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] sched: remove unused __HAVE_THREAD_FUNCTIONS hook
 support
Message-ID: <20240830012535.6b6f6de1.ddiss@suse.de>
In-Reply-To: <20240822043328.4180-1-ddiss@suse.de>
References: <20240822043328.4180-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[freelists.org,redhat.com,infradead.org,linaro.org,suse.de,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

[cc'ing Ard as ia64 remover]

Ping - any thoughts on this patch?

On Thu, 22 Aug 2024 04:33:28 +0000, David Disseldorp wrote:

> __HAVE_THREAD_FUNCTIONS could be defined by architectures wishing to
> provide their own task_thread_info(), task_stack_page(),
> setup_thread_stack() and end_of_stack() hooks.
> 
> Commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
> removed the last upstream consumer of __HAVE_THREAD_FUNCTIONS, so change
> the remaining !CONFIG_THREAD_INFO_IN_TASK && !__HAVE_THREAD_FUNCTIONS
> conditionals to only check for the former case.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  include/linux/sched.h            | 2 +-
>  include/linux/sched/task_stack.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f8d150343d42..9dbcdfe173cf 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1874,7 +1874,7 @@ extern unsigned long init_stack[THREAD_SIZE / sizeof(unsigned long)];
>  
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>  # define task_thread_info(task)	(&(task)->thread_info)
> -#elif !defined(__HAVE_THREAD_FUNCTIONS)
> +#else
>  # define task_thread_info(task)	((struct thread_info *)(task)->stack)
>  #endif
>  
> diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
> index ccd72b978e1f..55042ff01a6d 100644
> --- a/include/linux/sched/task_stack.h
> +++ b/include/linux/sched/task_stack.h
> @@ -33,7 +33,7 @@ static __always_inline unsigned long *end_of_stack(const struct task_struct *tas
>  #endif
>  }
>  
> -#elif !defined(__HAVE_THREAD_FUNCTIONS)
> +#else
>  
>  #define task_stack_page(task)	((void *)(task)->stack)
>  


