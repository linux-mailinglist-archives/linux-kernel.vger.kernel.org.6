Return-Path: <linux-kernel+bounces-170084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 787268BD1B2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EAF12851D7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720371553A7;
	Mon,  6 May 2024 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NC+BDK1+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SMx6EZos";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NC+BDK1+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SMx6EZos"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F85154C0A
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010266; cv=none; b=oLTiej/C6CPsdRu0Hm5JD6meze4nC1MaBu3ZuolohBYHbg6tcU/vT7VdKshOsej9ZNSGIugAKOFKJ6u1Rl2HkRg6GYOSKtr9iBwswI9bwEdNrFLyuULr1LUIebpxOl1coGuiP8bFT+MC2Lz07rRjkXTqdzD6x0sCWL4cn6U0dWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010266; c=relaxed/simple;
	bh=mHb+yST+jxhpSTwZSJ4VfVHKAc54GQqwhqikWwwV9zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6xWS9X+zIb5RLDaBLsUmhIGh7ZJY62MKl9A/5gWFuvMfxXqjlLx4Ta7JXOSV/AxPhG/L34LdszzO4mMvzE64inc9gg+MDds8MFTMmLUsCami1RGN3OWJ3/Ya6hQhOVqUByo3sKzLTYkbus92doDzzTVeJkXSiEcyoCemLwFGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NC+BDK1+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SMx6EZos; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NC+BDK1+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SMx6EZos; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A27CC38590;
	Mon,  6 May 2024 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715010263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+v0bQfDYhEJjeC4GC6jz30GjJBlSHabfty94pUQWzEY=;
	b=NC+BDK1+6RrBo1yHw/gCfyZEn4jaBDF/gsTlPiI69rkqV9DK87j/fFhHYMC8oFrqT9390o
	cDjjFrNJP5vKXpry6bK8OFuVduBlqQuGodPP21k8Pf/3uRhsLBgjYFiI0Xy32PTlb1fXCO
	I1v/GnB9A/O/pan79qwBBDgqIpRhwKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715010263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+v0bQfDYhEJjeC4GC6jz30GjJBlSHabfty94pUQWzEY=;
	b=SMx6EZoskkKlW4wIPfUPcQA+CYqiq7cp6KtuD5YwK447tbmNQw/30m6h84EQnKssShptRF
	B9M5SDUOl8h6FwCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NC+BDK1+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SMx6EZos
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715010263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+v0bQfDYhEJjeC4GC6jz30GjJBlSHabfty94pUQWzEY=;
	b=NC+BDK1+6RrBo1yHw/gCfyZEn4jaBDF/gsTlPiI69rkqV9DK87j/fFhHYMC8oFrqT9390o
	cDjjFrNJP5vKXpry6bK8OFuVduBlqQuGodPP21k8Pf/3uRhsLBgjYFiI0Xy32PTlb1fXCO
	I1v/GnB9A/O/pan79qwBBDgqIpRhwKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715010263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+v0bQfDYhEJjeC4GC6jz30GjJBlSHabfty94pUQWzEY=;
	b=SMx6EZoskkKlW4wIPfUPcQA+CYqiq7cp6KtuD5YwK447tbmNQw/30m6h84EQnKssShptRF
	B9M5SDUOl8h6FwCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C5BA13A25;
	Mon,  6 May 2024 15:44:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +6dQANf6OGbOCwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 06 May 2024 15:44:23 +0000
Date: Mon, 6 May 2024 17:44:17 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	syzbot+41bbfdb8d41003d12c0f@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 2/4] mm,page_owner: Fix refcount imbalance
Message-ID: <Zjj60VQWR-Nm6SfU@localhost.localdomain>
References: <20240404070702.2744-1-osalvador@suse.de>
 <20240404070702.2744-3-osalvador@suse.de>
 <202405060754.4405F8402F@keescook>
 <Zjj6KN0GhXbv3VYY@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjj6KN0GhXbv3VYY@localhost.localdomain>
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A27CC38590
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,rivosinc.com,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[41bbfdb8d41003d12c0f];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Mon, May 06, 2024 at 05:41:28PM +0200, Oscar Salvador wrote:
> On Mon, May 06, 2024 at 07:59:11AM -0700, Kees Cook wrote:
> > This pr_warn() isn't needed: refcount will very loudly say the same
> > thing. :)
> 
> Yes, but I wanted to get the handle so I can match it with the
> backtrace.

Although on a second though, I could just switch it to pr_info(),
otherwise the warnings from both refcount and page_owner might get
tangled.

I will check and send a patch later.
 

-- 
Oscar Salvador
SUSE Labs

