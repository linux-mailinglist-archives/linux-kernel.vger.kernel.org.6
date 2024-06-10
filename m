Return-Path: <linux-kernel+bounces-207854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFBD901D04
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D70F1F218F5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541466F2E0;
	Mon, 10 Jun 2024 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jwWQwOiv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jwWQwOiv"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45A341A87;
	Mon, 10 Jun 2024 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008448; cv=none; b=nvRqdJheQ9Z7dutf55Y+JkgBJX1D5u2i1cAvJAOASkzzhJkDa4otkMkiow0+W6NqzU5J5nnqMFm5wiESmHmn4cTtxVvZogyarJ3KFW4mGnHD5KwDvU5zig0iX9ophK8ce555MrD/AJVmOnhXKQqvN8bQlAK791P9CZCUgHXQF+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008448; c=relaxed/simple;
	bh=5965FQLNStEGt965UYd9CLN8sLcDni2f2mM/+cHIs0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YURxz+g8oM1dyfGbLbbaSnXtH6H/HX9BId6bk56HDP+XNNCdX3W3GyCflKWUR5si8Dg/C2QwE7Oe1YPN1rLICZX5KDMzLyXXkHNpc6mlBkBiNq+th02ZtTWG0/M3FKcm1nUGC3OmxaJk126aPlNLRi6ePRL3ZUiGamolG6rAMkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jwWQwOiv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jwWQwOiv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C857E1F7BA;
	Mon, 10 Jun 2024 08:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718008444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Au++wnz5Tas7A1LBOukOfXCfGvbDAMafITBwuLmAKI8=;
	b=jwWQwOivodA/BQp/+V2YYOzqXnBNHV4Ujw9rRxOFJu8b5vsk0d4WlJLsUrwcBCcTyyAetL
	MtBXUcnujqu3HgBrziC7A3F3gD+29ucQLwhYwe+SjcuYOIOW8yH6cIIAWPzEan4jKzF0Lc
	wCtYa4oZV5HNMeO6c6tJwW2Hj+l3adA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718008444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Au++wnz5Tas7A1LBOukOfXCfGvbDAMafITBwuLmAKI8=;
	b=jwWQwOivodA/BQp/+V2YYOzqXnBNHV4Ujw9rRxOFJu8b5vsk0d4WlJLsUrwcBCcTyyAetL
	MtBXUcnujqu3HgBrziC7A3F3gD+29ucQLwhYwe+SjcuYOIOW8yH6cIIAWPzEan4jKzF0Lc
	wCtYa4oZV5HNMeO6c6tJwW2Hj+l3adA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEF4F13A51;
	Mon, 10 Jun 2024 08:34:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yju0J3y6ZmbhWQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 10 Jun 2024 08:34:04 +0000
Date: Mon, 10 Jun 2024 10:34:04 +0200
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Jones <tonyj@suse.de>
Subject: Re: CVE-2021-47543: perf report: Fix memory leaks around perf_tip()
Message-ID: <Zma6fJmtaz8vgae2@tiehlicka>
References: <2024052439-CVE-2021-47543-a01a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052439-CVE-2021-47543-a01a@gregkh>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

As far as I understand this is a bug in perf (userspace tool). This can
occur when running 'perf report' which has a generally short lived
lifespan. Is this really a CVE fix? What is the actual security threat?

Btw. CVE-2021-47545 is another one matcing the same pattern.

On Fri 24-05-24 17:10:03, Greg KH wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> perf report: Fix memory leaks around perf_tip()
> 
> perf_tip() may allocate memory or use a literal, this means memory
> wasn't freed if allocated. Change the API so that literals aren't used.
> 
> At the same time add missing frees for system_path. These issues were
> spotted using leak sanitizer.
> 
> The Linux kernel CVE team has assigned CVE-2021-47543 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Fixed in 5.4.164 with commit df5990db088d
> 	Fixed in 5.10.84 with commit ff061b5bda73
> 	Fixed in 5.15.7 with commit 71e284dcebec
> 	Fixed in 5.16 with commit d9fc706108c1
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2021-47543
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	tools/perf/builtin-report.c
> 	tools/perf/util/util.c
> 	tools/perf/util/util.h
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/df5990db088d4c7fea9a2f9b8195a7859e1768c4
> 	https://git.kernel.org/stable/c/ff061b5bda73c4f785b4703eeb0848fd99e5608a
> 	https://git.kernel.org/stable/c/71e284dcebecb9fd204ff11097469cc547723ad1
> 	https://git.kernel.org/stable/c/d9fc706108c15f8bc2d4ccccf8e50f74830fabd9

-- 
Michal Hocko
SUSE Labs

