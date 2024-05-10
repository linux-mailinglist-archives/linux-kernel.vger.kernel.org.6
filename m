Return-Path: <linux-kernel+bounces-175830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0A18C25D8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B5A1C217D8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8132D12C467;
	Fri, 10 May 2024 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LWA3yB3n";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LWA3yB3n"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88D75339E
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348019; cv=none; b=fUotG4ksyNXOGoOcvw2h4Mvh1eUF8COVY4apg5/cF0oWHZRPEhf+1zqRG3VvDDYm9fgOm4LREO/7EJLB+rXfY6NjkiMj3q6ONMaZO3fCuq7EQ9tSW9QIswJcGAHvXl4OPZF7GkPbGswxcn/ATqr16bH91mpu2P/AdzD9JGuD254=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348019; c=relaxed/simple;
	bh=uDOukQ73ZJHi76qm9+oS4eVsH62iJdBg7hMZoNnyZ58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLPiABk9yeaGUvsPFsgYDPhFqDbkXGCvF+wFNHqAeZKjgz3iCfNph+tCqUfkm7PEVja6v7Ya9patv8kX2pYAIaRAkINeGc8u0kZFHebFnDSxNY9wTAvBgx3mUmzdmzBqGHGTlUFUANWT96hxwafGU6DbyTCztbQnrguJbL3rSTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LWA3yB3n; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LWA3yB3n; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A8834670C0;
	Fri, 10 May 2024 13:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715348009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H7flCeeu/RqHijW2rCZbgRalVKYx9U95MIGkT6wJRF4=;
	b=LWA3yB3n2h6A9F2zfs3K64ygwUTdGdLCEbzkEnqgEOHn6X/33t/f2M427FkntTdPcwULTA
	TtV8ASS341OFDlmQkyZ9CwiSknvBxIHm2zOk5DeV43IRxOIzHvIwQ9ArLN34SpvWOiiE2z
	wkCul0JoEamzw6mF/E/vYxPHLaQhqRw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=LWA3yB3n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715348009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H7flCeeu/RqHijW2rCZbgRalVKYx9U95MIGkT6wJRF4=;
	b=LWA3yB3n2h6A9F2zfs3K64ygwUTdGdLCEbzkEnqgEOHn6X/33t/f2M427FkntTdPcwULTA
	TtV8ASS341OFDlmQkyZ9CwiSknvBxIHm2zOk5DeV43IRxOIzHvIwQ9ArLN34SpvWOiiE2z
	wkCul0JoEamzw6mF/E/vYxPHLaQhqRw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A3B7139AA;
	Fri, 10 May 2024 13:33:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bKHNHikiPmZpBwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 10 May 2024 13:33:29 +0000
Date: Fri, 10 May 2024 15:33:28 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and
 put under config option
Message-ID: <Zj4iKJnp5wU6NkCf@tiehlicka>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509034138.2207186-1-roman.gushchin@linux.dev>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A8834670C0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Wed 08-05-24 20:41:29, Roman Gushchin wrote:
> Cgroups v2 have been around for a while and many users have fully adopted them,
> so they never use cgroups v1 features and functionality. Yet they have to "pay"
> for the cgroup v1 support anyway:
> 1) the kernel binary contains useless cgroup v1 code,
> 2) some common structures like task_struct and mem_cgroup have never used
>    cgroup v1-specific members,
> 3) some code paths have additional checks which are not needed.
> 
> Cgroup v1's memory controller has a number of features that are not supported
> by cgroup v2 and their implementation is pretty much self contained.
> Most notably, these features are: soft limit reclaim, oom handling in userspace,
> complicated event notification system, charge migration.
> 
> Cgroup v1-specific code in memcontrol.c is close to 4k lines in size and it's
> intervened with generic and cgroup v2-specific code. It's a burden on
> developers and maintainers.
> 
> This patchset aims to solve these problems by:
> 1) moving cgroup v1-specific memcg code to the new mm/memcontrol-v1.c file,
> 2) putting definitions shared by memcontrol.c and memcontrol-v1.c into the
>    mm/internal.h header
> 3) introducing the CONFIG_MEMCG_V1 config option, turned on by default
> 4) making memcontrol-v1.c to compile only if CONFIG_MEMCG_V1 is set
> 5) putting unused struct memory_cgroup and task_struct members under
>    CONFIG_MEMCG_V1 as well.

This makes sense and I have to admit I didn't think this was so much
code to move. It will make the code base much esier to follow. I do not
think we can drop that code anytime soon as there is still quite a lot
of use of v1 out there. From my experience there is no good reason for
many other than inertia and those are just waiting for somebody to move
them to v2. There are some workloads which depend on v1 only features
and we should discuss what to do about those.
-- 
Michal Hocko
SUSE Labs

