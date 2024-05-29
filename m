Return-Path: <linux-kernel+bounces-193823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C881E8D32B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84377283631
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92855169AC2;
	Wed, 29 May 2024 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OBwd7COA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tu8OT6rM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CCA6F079
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974220; cv=none; b=B7uSPvvWA6YAs0fG/e010bsqV+h2l/aECv5zy9CBimVMQFCxPf5TkXhh+QSs1KvE/V8idXu8XchMbGQAMu78lx7CDfG0epF9ueq4Iiy/+ewtCv09L3ak1HeUUby/xlLP0aB4WgYrCojwJ7fzWR7dyCPLgacBPpR4EfBif/sEURc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974220; c=relaxed/simple;
	bh=g+v8I5RS5Rx3vW6PyLEYjBK98J13/Fvd9jdUMa+sqsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvNocw+r3ApVhfpAzDE2eTYnDytBumHIg7EYqKbVASOYP4iKG4nWIMBmjxZC/xe8jDNT+zcM+UbYrNcSS5+bwTqPSNeVeg9KKousq/tGVHVhtKtzNFsQDKblSU95NZ6leMMVSoFmtXxAlVnSEuiT8yKicpsW3vjVLrDfXByqcHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OBwd7COA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tu8OT6rM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CBD3F229ED;
	Wed, 29 May 2024 09:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716974217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=drsjYDhKr/t1LAl2BAdlMhkJ1IEJgrd0Ng+4OFdPbmA=;
	b=OBwd7COAQnOiMDeJuo2vxc2pmkPCg2GLFhMXAp0qIDQnhPtjjTmae/UggwkRPMVzjKcBoR
	RLWHjre8fRDz8f9pWn/9bTBjTA4MlGmqh7bMJTJMxeg6PTfUHBvwmYxcVXXesTf1vF9fNq
	6HThrSWikRwLLBW+RHEEmo4S0buH8P0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tu8OT6rM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716974216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=drsjYDhKr/t1LAl2BAdlMhkJ1IEJgrd0Ng+4OFdPbmA=;
	b=tu8OT6rM1QvKJsWHdBsrZuYnoqNjKJ9mN4DG8b155lWQim62knoTjOks0AMAWQ6IKYjZ9K
	fjSA/XtcW0buJ61w51DHjvZaKhIsUwh50+L0Uu4qOrxHNgnZTnm5WAtCkpWmoNGCIyfIJ6
	T27ZviTngtAqAQMYiDfJz4OyFF3Rk2M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7F1A13A6B;
	Wed, 29 May 2024 09:16:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g1wcJojyVmbxdgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 29 May 2024 09:16:56 +0000
Date: Wed, 29 May 2024 11:16:56 +0200
From: Michal Hocko <mhocko@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] memcg: Remove the lockdep assert from
 __mod_objcg_mlstate().
Message-ID: <ZlbyiMnd4x24bR8F@tiehlicka>
References: <20240528121928.i-Gu7Jvg@linutronix.de>
 <09e085bb-f09e-4901-a2dd-a0b789bb8a4d@kernel.org>
 <20240528134027.OxDASsS3@linutronix.de>
 <c84d6962-34fa-42e5-899c-925579cbfb26@kernel.org>
 <20240528141341.rz_rytN_@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528141341.rz_rytN_@linutronix.de>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linutronix.de:email,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CBD3F229ED
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue 28-05-24 16:13:41, Sebastian Andrzej Siewior wrote:
> The assert was introduced in the commit cited below as an insurance that
> the semantic is the same after the local_irq_save() has been removed and
> the function has been made static.
> 
> The original requirement to disable interrupt was due the modification
> of per-CPU counters which require interrupts to be disabled because the
> counter update operation is not atomic and some of the counters are
> updated from interrupt context.
> 
> All callers of __mod_objcg_mlstate() acquire a lock
> (memcg_stock.stock_lock) which disables interrupts on !PREEMPT_RT and
> the lockdep assert is satisfied. On PREEMPT_RT the interrupts are not
> disabled and the assert triggers.
> 
> The safety of the counter update is already ensured by
> VM_WARN_ON_IRQS_ENABLED() which is part of __mod_memcg_lruvec_state() and
> does not require yet another check.
> 
> Remove the lockdep assert from __mod_objcg_mlstate().
> 
> Fixes: 91882c1617c15 ("memcg: simple cleanup of stats update functions")
> Link: https://lore.kernel.org/r/20240528121928.i-Gu7Jvg@linutronix.de
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs

