Return-Path: <linux-kernel+bounces-175820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C959A8C25AC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C444B24131
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F4F12C485;
	Fri, 10 May 2024 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tbQNBYv1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tbQNBYv1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC95F12BF21
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347611; cv=none; b=IaIEix2LnbMezDANT7L+GFDl1A0eyCvrNyv9Kpx6hiMHc6BK+UuV8Rs6pLGcRvlHHU0XZXNp+nGbeDeKNxRXeTKl/yhoFvRcQnP5Lr8AXnEZNqEl6JuibRTLI5uxoPe/WdByLpML7rMHEVJ8ufCfJ/+iFnOyKaVVNFcChfjzK8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347611; c=relaxed/simple;
	bh=Ptqv9/UW3AsNmkl/pJs5+10YJOZ9fx/1CAxitID4Ki0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fl6bi8HHk2Oq56CoLeIfG++1zuIsKLoFqBazaQTmnwzdmizMR1zWDiM/IInaTBVN+GgVYZkDgdBgTBqEhAAs+FweH3P7dVMlwC8KiFakiwRQNi/NAuPNZWUE2juEHxvmHJf0b6TdUKJueaqeJ+QLkgTj+nJAqWUdfMZYMq3tdXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tbQNBYv1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tbQNBYv1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA54D3EE5F;
	Fri, 10 May 2024 13:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715347607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1neooF3mgFb2Ddvo0cNo073MdM8ntyg4Z5+TI/To1Kw=;
	b=tbQNBYv1lmYZAGyalO4mAfwP7QwGulUxps7d9B0PgH0qvlMmlyg5MXTDCllCtazbcrzawM
	rhn4MWki0abWLgsRsxbIIjoZYZOLIwxKnV7mgFiFzAa3fygHB9+v+Ei87EK7WHkTmgPJty
	rhTdQ7hPX8HYsu6AVEU4MWcE5hvP3ws=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715347607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1neooF3mgFb2Ddvo0cNo073MdM8ntyg4Z5+TI/To1Kw=;
	b=tbQNBYv1lmYZAGyalO4mAfwP7QwGulUxps7d9B0PgH0qvlMmlyg5MXTDCllCtazbcrzawM
	rhn4MWki0abWLgsRsxbIIjoZYZOLIwxKnV7mgFiFzAa3fygHB9+v+Ei87EK7WHkTmgPJty
	rhTdQ7hPX8HYsu6AVEU4MWcE5hvP3ws=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EE82139AA;
	Fri, 10 May 2024 13:26:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rS1BApYgPmaMBAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 10 May 2024 13:26:46 +0000
Date: Fri, 10 May 2024 15:26:35 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rfc 6/9] mm: memcg: move cgroup v1 oom handling code into
 memcontrol-v1.c
Message-ID: <Zj4gi-vOxLZi2van@tiehlicka>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
 <20240509034138.2207186-7-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509034138.2207186-7-roman.gushchin@linux.dev>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.44 / 50.00];
	BAYES_HAM(-1.64)[92.72%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -2.44
X-Spam-Flag: NO

On Wed 08-05-24 20:41:35, Roman Gushchin wrote:
[...]
> @@ -1747,106 +1623,14 @@ static bool mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
>  
>  	memcg_memory_event(memcg, MEMCG_OOM);
>  
> -	/*
> -	 * We are in the middle of the charge context here, so we
> -	 * don't want to block when potentially sitting on a callstack
> -	 * that holds all kinds of filesystem and mm locks.
> -	 *
> -	 * cgroup1 allows disabling the OOM killer and waiting for outside
> -	 * handling until the charge can succeed; remember the context and put
> -	 * the task to sleep at the end of the page fault when all locks are
> -	 * released.
> -	 *
> -	 * On the other hand, in-kernel OOM killer allows for an async victim
> -	 * memory reclaim (oom_reaper) and that means that we are not solely
> -	 * relying on the oom victim to make a forward progress and we can
> -	 * invoke the oom killer here.
> -	 *
> -	 * Please note that mem_cgroup_out_of_memory might fail to find a
> -	 * victim and then we have to bail out from the charge path.
> -	 */
> -	if (READ_ONCE(memcg->oom_kill_disable)) {
> -		if (current->in_user_fault) {
> -			css_get(&memcg->css);
> -			current->memcg_in_oom = memcg;
> -			current->memcg_oom_gfp_mask = mask;
> -			current->memcg_oom_order = order;
> -		}
> +	if (!mem_cgroup_v1_oom_prepare(memcg, mask, order, &locked))
>  		return false;
> -	}
> -
> -	mem_cgroup_mark_under_oom(memcg);
> -
> -	locked = mem_cgroup_oom_trylock(memcg);

This really confused me because this looks like the oom locking is
removed for v2 but this is not the case because
mem_cgroup_v1_oom_prepare is not really v1 only code - in other words
this is not going to be just return false for CONFIG_MEMCG_V1=n.

It makes sense to move the userspace oom handling out to the v1 file. I
would keep mem_cgroup_mark_under_oom here. I am not sure about the oom
locking thing because I think we can make it v1 only. For v2 I guess we
can go without this locking as the oom path is already locked and it
implements overkilling prevention (oom_evaluate_task) as it walks all
processes in the oom hierarchy. 

> -
> -	if (locked)
> -		mem_cgroup_oom_notify(memcg);
> -
> -	mem_cgroup_unmark_under_oom(memcg);
>  	ret = mem_cgroup_out_of_memory(memcg, mask, order);
> -
> -	if (locked)
> -		mem_cgroup_oom_unlock(memcg);
> +	mem_cgroup_v1_oom_finish(memcg, &locked);
>  
>  	return ret;
>  }

-- 
Michal Hocko
SUSE Labs

