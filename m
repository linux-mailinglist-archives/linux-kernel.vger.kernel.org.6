Return-Path: <linux-kernel+bounces-224241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFB8911F48
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907A41F27BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C974316D9A3;
	Fri, 21 Jun 2024 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iIhR7FzE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iIhR7FzE"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BDF18E20
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959823; cv=none; b=JobCpzEk3ghOFazSwHqbhQYhzLqNt0iRQCyBF130cn4nx4i8OZTmJRlWIdWeLFnxmc63Ivh5S4dmYU9sDgTn2E0ldX8biVADjbkHWqcSVkXGEagFlkjf5Ezig+ujxS4afp93+MOpSBAv9ZyvlPHdjqH6O2LVopjToPqPIUuPmDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959823; c=relaxed/simple;
	bh=1EOieLYALgDf3OC33tQ9uV5hkGF+ygvbKawrP3xPyWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUAvYbQecO2gRBJM6rLakEapCpDL6s52fNZnCqEc2hLUJb6WIzUwCECrMviewEMo4qnk4gRc/DwEnMzZLuBpE/XorQnCeQjzVsviaRYmv6IIVW8LcCKBKn7wtb5aYvNSFXA+mdoVltrAtqoXL+X3ZwCDlUWr4RxmSF//X15CUGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iIhR7FzE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iIhR7FzE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B147521AD8;
	Fri, 21 Jun 2024 08:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718959815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4IBFY55aY3D9MyZlJoKqwYGdFQP0jr3zjoMUTUGofdc=;
	b=iIhR7FzEJGs/zGPIlfZppTXopHjXVLCnP5MjHuwuOAum0PiC48QyeuoPLMR3p/C8wndJvM
	lvAFeNf1QL2ruYvFEsjDPxzW9eJY8K+7Kh6+ucM7F6M8kNamvejRsuWQevL8Nl0RuJ4PLc
	aRAVIDa1k2Zw2yI1NDBd8l0ajBEycMg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718959815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4IBFY55aY3D9MyZlJoKqwYGdFQP0jr3zjoMUTUGofdc=;
	b=iIhR7FzEJGs/zGPIlfZppTXopHjXVLCnP5MjHuwuOAum0PiC48QyeuoPLMR3p/C8wndJvM
	lvAFeNf1QL2ruYvFEsjDPxzW9eJY8K+7Kh6+ucM7F6M8kNamvejRsuWQevL8Nl0RuJ4PLc
	aRAVIDa1k2Zw2yI1NDBd8l0ajBEycMg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CC7813ABD;
	Fri, 21 Jun 2024 08:50:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ok9sH8c+dWbZMQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 21 Jun 2024 08:50:15 +0000
Date: Fri, 21 Jun 2024 10:50:10 +0200
From: Michal Hocko <mhocko@suse.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: alexjlzheng@gmail.com, "Eric W. Biederman" <ebiederm@xmission.com>,
	akpm@linux-foundation.org, brauner@kernel.org, axboe@kernel.dk,
	tandersen@netflix.com, willy@infradead.org, mjguzik@gmail.com,
	alexjlzheng@tencent.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: optimize the redundant loop of
 mm_update_next_owner()
Message-ID: <ZnU-wlFE5usvo9ah@tiehlicka>
References: <20240620152744.4038983-1-alexjlzheng@tencent.com>
 <20240620172958.GA2058@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620172958.GA2058@redhat.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,xmission.com,linux-foundation.org,kernel.org,kernel.dk,netflix.com,infradead.org,tencent.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu 20-06-24 19:30:19, Oleg Nesterov wrote:
> Can't review, I forgot everything about mm_update_next_owner().
> So I am sorry for the noise I am going to add, feel free to ignore.
> Just in case, I see nothing wrong in this patch.
> 
> On 06/20, alexjlzheng@gmail.com wrote:
> >
> > When mm_update_next_owner() is racing with swapoff (try_to_unuse()) or /proc or
> > ptrace or page migration (get_task_mm()), it is impossible to find an
> > appropriate task_struct in the loop whose mm_struct is the same as the target
> > mm_struct.
> >
> > If the above race condition is combined with the stress-ng-zombie and
> > stress-ng-dup tests, such a long loop can easily cause a Hard Lockup in
> > write_lock_irq() for tasklist_lock.
> >
> > Recognize this situation in advance and exit early.
> 
> But this patch won't help if (say) ptrace_access_vm() sleeps while
> for_each_process() tries to find another owner, right?
> 
> > @@ -484,6 +484,8 @@ void mm_update_next_owner(struct mm_struct *mm)
> >  	 * Search through everything else, we should not get here often.
> >  	 */
> >  	for_each_process(g) {
> > +		if (atomic_read(&mm->mm_users) <= 1)
> > +			break;
> 
> I think this deserves a comment to explain that this is optimization
> for the case we race with the pending mmput(). mm_update_next_owner()
> checks mm_users at the start.
> 
> And. Can we drop tasklist and use rcu_read_lock() before for_each_process?
> Yes, this will probably need more changes even if possible...
> 
> 
> Or even better. Can't we finally kill mm_update_next_owner() and turn the
> ugly mm->owner into mm->mem_cgroup ?

Yes, dropping the mm->owner should be a way to go. Replacing that by
mem_cgroup sounds like an improvemnt. I have a vague recollection that
this has some traps on the way. E.g. tasks sharing the mm but living in
different cgroups. Things have changes since the last time I've checked
and for example memcg charge migration on task move will be deprecated
soon so chances are that there are less roadblocks on the way.
-- 
Michal Hocko
SUSE Labs

