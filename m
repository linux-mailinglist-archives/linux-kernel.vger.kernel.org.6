Return-Path: <linux-kernel+bounces-220697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6363D90E57E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5D81F22A95
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F7579DD4;
	Wed, 19 Jun 2024 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SqCt513j";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SqCt513j"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44356448
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785850; cv=none; b=aEmvDWrDoZ+LKsib2DnzTkfWUiJUGJgsSq2O8sHAuqKCMr/nOkc+qG7L0Wg884ckaMubSoUUhXSSYtmFo9g4e/4rTF7dKgp7XQZ36EJspZjgp0zcZeScgClRi3Y1aQ/hVdzD3LzIjajOHaGFgUT2mpb2wqxDVsBCZnnh9RawX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785850; c=relaxed/simple;
	bh=iuTm0NDUxdEgh6C5LmYedrKC39nulEaAGuIfK6jpCnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mwj19mfTdBgEk1HXvV7F9LZRyDPlFZN2I7CLDx9wlXHWS/nDgAVQoBR6939dYDj854st+5heeHzu+l0/0gaURXh693efgRPwDs+JT5BT9BdYnVuzucD6aL5h+dLsrG7wjN2nY6OoL9/XR2wJnnFzGW346gitrU8Uf1AQ8p9inFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SqCt513j; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SqCt513j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE6D21F80C;
	Wed, 19 Jun 2024 08:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718785846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3csz8VA55EtnZ1qgNXezIt/I0+UuI2lwvyZNtecuq3U=;
	b=SqCt513j19wKluV1OJniLT9Q9ap6QMmNV2A55jNTZPUKeULT0twMe90B9kSygqO3t9EHNQ
	dbNU2khWPeMiJUXvVxTuMjbzSGXq/WgVTUiJAsb14nP/ZyAsekpojF6Xjm7LQ3t60QCm8R
	u4YQtQzYYekTI+nMPjJnljIgSKcTp90=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718785846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3csz8VA55EtnZ1qgNXezIt/I0+UuI2lwvyZNtecuq3U=;
	b=SqCt513j19wKluV1OJniLT9Q9ap6QMmNV2A55jNTZPUKeULT0twMe90B9kSygqO3t9EHNQ
	dbNU2khWPeMiJUXvVxTuMjbzSGXq/WgVTUiJAsb14nP/ZyAsekpojF6Xjm7LQ3t60QCm8R
	u4YQtQzYYekTI+nMPjJnljIgSKcTp90=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CC0413AAA;
	Wed, 19 Jun 2024 08:30:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pgs7IzaXcmbgHQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 19 Jun 2024 08:30:46 +0000
Date: Wed, 19 Jun 2024 10:30:46 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernel-team@meta.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@infradead.org>
Subject: Re: [PATCH] mm: ratelimit oversized kvmalloc warnings instead of once
Message-ID: <ZnKXNuuQRwNxRe4z@tiehlicka>
References: <20240618213421.282381-1-shakeel.butt@linux.dev>
 <ZnKGjdw8xkMZG0oX@tiehlicka>
 <ajp536dpkss32kmjihcfbl4ulunfho2odzw4ghwfekw2yv3ctt@fh62fmyxwwcs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajp536dpkss32kmjihcfbl4ulunfho2odzw4ghwfekw2yv3ctt@fh62fmyxwwcs>
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
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 19-06-24 01:03:16, Shakeel Butt wrote:
> On Wed, Jun 19, 2024 at 09:19:41AM GMT, Michal Hocko wrote:
> > On Tue 18-06-24 14:34:21, Shakeel Butt wrote:
> > > At the moment oversize kvmalloc warnings are triggered once using
> > > WARN_ON_ONCE() macro. One issue with this approach is that it only
> > > detects the first abuser and then ignores the remaining abusers which
> > > complicates detecting all such abusers in a timely manner. The situation
> > > becomes worse when the repro has low probability and requires production
> > > traffic and thus require large set of machines to find such abusers. In
> > > Mera production, this warn once is slowing down the detection of these
> > > abusers. Simply replace WARN_ON_ONCE with WARN_RATELIMIT.
> > 
> > Long time ago, I've had a patch to do the once_per_callsite WARN. I
> > cannot find reference at the moment but it used stack depot to note
> > stacks that have already triggered. Back then there was no reponse on
> > the ML. Should I try to dig deep and recover it from my archives? I
> > think this is exactly kind of usecase where it would fit.
> > 
> 
> Do you mean something like warn once per unique call stack?

Exactly!

> If yes then
> I think that is better than the simple ratelimiting version as
> ratelimiting one may still miss some abusers and also may keep warning
> about the same abuser. Please do share your patch.

https://lore.kernel.org/all/20170103134424.28123-1-mhocko@kernel.org/

-- 
Michal Hocko
SUSE Labs

