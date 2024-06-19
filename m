Return-Path: <linux-kernel+bounces-220722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE1290E63D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE8D1C219C1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0757D06B;
	Wed, 19 Jun 2024 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GgvE4mn6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GgvE4mn6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1CA2139B1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786892; cv=none; b=e5fzoz6Ee/TIzEncoMRTy6ntSk3CInVaVNpwxpdjD/1BtotvrBiKFwFW5KzG45zKeKk+bcyQkcW/j6Tb//NDVSDXAPOvE2Q/IS0cAMPEe7y1vEAXZLcgbCzy7yff2EcacCNTwESHULHwJ3SleqNOh2S1VCc49zUdO19+kHMYsvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786892; c=relaxed/simple;
	bh=vXdCtGC+cVprPjBnMdf0BicddJYHsOyMpQ/w4gI4CAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6NKwokGWe7lsu9uOZGxs+RNnb388DgYxQjgmqr2YDm2mflcLA/hCY0rAvyteCmlogqZYp+Ug3Pzt46VvC5scbJfT7ciTNYI9lREA8tCZlaU0XTICA+l7qS7/7SOZZm2N4UfYX9dM8HtIGiM6cDXs2MeDpjpUvfnKPR4pqZKaM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GgvE4mn6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GgvE4mn6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC79E21A78;
	Wed, 19 Jun 2024 08:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718786887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35Rmt2W3E0m9QYiuNRzG4CufrPMKZEJTxI/tQbplZeA=;
	b=GgvE4mn6TiMzElr5XgZbpcKYEx6S7VZKdnpmBUHUEzuHcM9cCn3V5jKBXLEPOKnCZl7KjF
	HJkzs+wdIciy/wRCB11N8rWWQsK7uXsbPcADfi6dDz8tN2w3pzWKI3UBtByNdANt9Q4k6L
	sgOoYblw7cqDNaB2ENy6Gc2sU8XzN3A=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718786887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35Rmt2W3E0m9QYiuNRzG4CufrPMKZEJTxI/tQbplZeA=;
	b=GgvE4mn6TiMzElr5XgZbpcKYEx6S7VZKdnpmBUHUEzuHcM9cCn3V5jKBXLEPOKnCZl7KjF
	HJkzs+wdIciy/wRCB11N8rWWQsK7uXsbPcADfi6dDz8tN2w3pzWKI3UBtByNdANt9Q4k6L
	sgOoYblw7cqDNaB2ENy6Gc2sU8XzN3A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2A3E13AAA;
	Wed, 19 Jun 2024 08:48:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TvsFKEebcmZYIwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 19 Jun 2024 08:48:07 +0000
Date: Wed, 19 Jun 2024 10:48:07 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernel-team@meta.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@infradead.org>
Subject: Re: [PATCH] mm: ratelimit oversized kvmalloc warnings instead of once
Message-ID: <ZnKbR7IOd0b6GDBI@tiehlicka>
References: <20240618213421.282381-1-shakeel.butt@linux.dev>
 <ZnKGjdw8xkMZG0oX@tiehlicka>
 <ajp536dpkss32kmjihcfbl4ulunfho2odzw4ghwfekw2yv3ctt@fh62fmyxwwcs>
 <ZnKXNuuQRwNxRe4z@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKXNuuQRwNxRe4z@tiehlicka>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Wed 19-06-24 10:30:46, Michal Hocko wrote:
> On Wed 19-06-24 01:03:16, Shakeel Butt wrote:
> > On Wed, Jun 19, 2024 at 09:19:41AM GMT, Michal Hocko wrote:
> > > On Tue 18-06-24 14:34:21, Shakeel Butt wrote:
> > > > At the moment oversize kvmalloc warnings are triggered once using
> > > > WARN_ON_ONCE() macro. One issue with this approach is that it only
> > > > detects the first abuser and then ignores the remaining abusers which
> > > > complicates detecting all such abusers in a timely manner. The situation
> > > > becomes worse when the repro has low probability and requires production
> > > > traffic and thus require large set of machines to find such abusers. In
> > > > Mera production, this warn once is slowing down the detection of these
> > > > abusers. Simply replace WARN_ON_ONCE with WARN_RATELIMIT.
> > > 
> > > Long time ago, I've had a patch to do the once_per_callsite WARN. I
> > > cannot find reference at the moment but it used stack depot to note
> > > stacks that have already triggered. Back then there was no reponse on
> > > the ML. Should I try to dig deep and recover it from my archives? I
> > > think this is exactly kind of usecase where it would fit.
> > > 
> > 
> > Do you mean something like warn once per unique call stack?
> 
> Exactly!
> 
> > If yes then
> > I think that is better than the simple ratelimiting version as
> > ratelimiting one may still miss some abusers and also may keep warning
> > about the same abuser. Please do share your patch.
> 
> https://lore.kernel.org/all/20170103134424.28123-1-mhocko@kernel.org/

Btw. the code has changed a lot since 2017 when this was posted so it
will likely need a lot of massaging to rebase. Also I am not entirely
sure it is ok to change WARN_ONCE semantic like that anymore. Maybe we
need an explicit variant that does this per-call-site warnings. It is a
notable difference between library functions which can be called from
different callpaths and those that are used from a single place. I do
not have much time to dig deeper into this but if you want to take over
then go ahead. I still think this is a useful WARN_ONCE or in general
do_something_once semantic.
-- 
Michal Hocko
SUSE Labs

