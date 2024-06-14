Return-Path: <linux-kernel+bounces-214848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D9A908B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E33328A8D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6635195FEA;
	Fri, 14 Jun 2024 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E2cu7y74";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hF4PBPoG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E2cu7y74";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hF4PBPoG"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963621957F3;
	Fri, 14 Jun 2024 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718365716; cv=none; b=Dh2RPI2GuUOHPGrdF47QbihUTWwIdD2ekz7Y3rypHyXxVoja5urP796gfOl1XAhcc01ggyE+6KgKh+IszCZrQz0W7kTdDih8PO7g64kyZWncZL6nUgHK/ObJmz6bSkxejTRukeiU+UQ1xNEk7y1CXMeTqYQf7mYD0PwW3qc/v5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718365716; c=relaxed/simple;
	bh=T96qca2RM0tVHe1VlsX3EaZMhWCFQOCkVyM4NNouzZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWA0soPYUcv+crIjASxlnccQkrO3V8UEfeuZkg9pT5+rYl69iGHbOMtDNBS7XONq887R8GG1PlpPUjc8inDbpU/jm4reu0Xm5i/rXUZ13V3r1B3Mpu8waRNMNUQ4qmBMxysUu4mhBfvpbokyTiY3MREF23yQWgA4KREMmY+O71k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E2cu7y74; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hF4PBPoG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E2cu7y74; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hF4PBPoG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B429320428;
	Fri, 14 Jun 2024 11:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718365712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CrLYCz09vrQoCSmw+MIDjSXKU5jzuAlXQ7QADNdyiY=;
	b=E2cu7y74loxlC4ul3crfB6HNmlw1hEtRE7E9Nzh2S4GqVGHZJOPn4tUQWOpiB5NEW5i4p1
	7Ds5WICk5okNxY/YaC8Pk7dCoUews3A1jpugEak/HCDLoiDQHkw+AAk/SmlJjj2MWPIMGR
	4Le4BhBdPJck5piK5ZAOq0c+8yHD+i0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718365712;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CrLYCz09vrQoCSmw+MIDjSXKU5jzuAlXQ7QADNdyiY=;
	b=hF4PBPoGl+fsrCdF8GxGDGxbdAN0c79SSeM7/X4daQICMnR0MliyJE1M0mQIs+0Eg7yoxW
	T4qyukkhShatHvBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718365712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CrLYCz09vrQoCSmw+MIDjSXKU5jzuAlXQ7QADNdyiY=;
	b=E2cu7y74loxlC4ul3crfB6HNmlw1hEtRE7E9Nzh2S4GqVGHZJOPn4tUQWOpiB5NEW5i4p1
	7Ds5WICk5okNxY/YaC8Pk7dCoUews3A1jpugEak/HCDLoiDQHkw+AAk/SmlJjj2MWPIMGR
	4Le4BhBdPJck5piK5ZAOq0c+8yHD+i0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718365712;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CrLYCz09vrQoCSmw+MIDjSXKU5jzuAlXQ7QADNdyiY=;
	b=hF4PBPoGl+fsrCdF8GxGDGxbdAN0c79SSeM7/X4daQICMnR0MliyJE1M0mQIs+0Eg7yoxW
	T4qyukkhShatHvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48F2E13AAF;
	Fri, 14 Jun 2024 11:48:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uvhpDhAubGaMHgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 14 Jun 2024 11:48:32 +0000
Date: Fri, 14 Jun 2024 13:48:30 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Oscar Salvador <OSalvador@suse.com>,
	cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-36000: mm/hugetlb: fix missing hugetlb_lock for resv
 uncharge
Message-ID: <ZmwuDvvTDpCFGTdi@localhost.localdomain>
References: <2024052023-CVE-2024-36000-cfc4@gregkh>
 <Zkto8rbtAUBql-78@tiehlicka>
 <Zkz4RRgfwUHPbQ5z@x1n>
 <Zk7ws6H0wwuiFAJW@tiehlicka>
 <Zk8bgS8IboS-7jQw@localhost.localdomain>
 <Zk9j5j-VSAOWrmg7@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk9j5j-VSAOWrmg7@x1n>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Thu, May 23, 2024 at 11:42:30AM -0400, Peter Xu wrote:
> I really don't know enough on these areas to tell, perhaps I missed
> something.  But maybe any of you may have some idea..  In general, I think
> besides LOCKDEP the lock is definitely needed to at least make sure things
> like:
> 
> 	__set_hugetlb_cgroup(folio, NULL, rsvd);

I do not think this is a problem, you are only setting folio->_hugetlb_cgroup_rsvd
to the hugetlb cgroup.
And no one else should fiddle with that folio.

> 	page_counter_uncharge(),

This on the hand might be another story:

 page_counter_uncharge
  new = atomic_long_sub_return(nr_pages, &counter->usage)
  propagate_protected_usage

The first atomic_long_sub_return is ok because it is an atomic one, so
whoever comes last will not see e.g: a half-updated value.
But propagate_protected_usage() is a bit more convoluted as involves a bunch of
atomic operations and comparasions that in case they are not serialized, the counters
will not be consistent, which means that any charge/uncharge operation that comes after
might not reflect reality.

So I guess we could end up with scenarios where cgroups would not get as many pages as
they should, or maybe more pages than they should.

If this reasoning is accurate, I am leaning towards taking this as a security fix.

-- 
Oscar Salvador
SUSE Labs

