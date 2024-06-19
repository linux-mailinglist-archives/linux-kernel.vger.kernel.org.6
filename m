Return-Path: <linux-kernel+bounces-220597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739C290E439
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 684DAB2422D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EF77580C;
	Wed, 19 Jun 2024 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t8WY50uk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t8WY50uk"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4B141C7F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781590; cv=none; b=V3i3W5Ty3GPnOsECiS0ynUzDI6G8x1C+kJ9M0yWPIvSoikA93NHUc+9yQhQ3RFsCz+leYLkGwUQgNOlZtAtSUxRpdwkNjuduhWTVrVcZe+d3gZXjJukarqZ5iEsIYuTj3UAt+/4FKJhuI1U64GunWYs5Jkbwok69BwNRmSqsYcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781590; c=relaxed/simple;
	bh=i4kJreW8OiFOCHGE9oGq9bL1mbeNntwp76ysR8pLN1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0QnGJsM2d1gdxiTyCZ43Dgllnm6aA6vbfv6Z1A8EsecSHoFkmx3vJIeHvSSMr71er+BeS3LRnCmgz4MFjR95wmezTzBmS7yEdKOQctFWhSRweR4hlymXVW9X8ywW1B/AGi6PIZmCVuAryQVg0TJ42TMTMWHDGX0sYZvxsXg7rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t8WY50uk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t8WY50uk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A79E421A42;
	Wed, 19 Jun 2024 07:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718781586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dyUwDpNg9ilLIjNA73Mb7FzUGR35jHF2ijEAvN3j7xI=;
	b=t8WY50ukZ29L9JpdEATNsF5bCgIBct2S+fVjDXiVF9trMtBfnD88gqy/4C7/xZQYtgZLvl
	98hACeQFefZ0OLGJF+NgFCz/sg6wPwi8V09IbJ2G2JxyGDdQvxtl5MTaLgjFU0qh+zlz6T
	reSgxh1l8IsBOSgz44mIThv1FRO+/Dc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718781586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dyUwDpNg9ilLIjNA73Mb7FzUGR35jHF2ijEAvN3j7xI=;
	b=t8WY50ukZ29L9JpdEATNsF5bCgIBct2S+fVjDXiVF9trMtBfnD88gqy/4C7/xZQYtgZLvl
	98hACeQFefZ0OLGJF+NgFCz/sg6wPwi8V09IbJ2G2JxyGDdQvxtl5MTaLgjFU0qh+zlz6T
	reSgxh1l8IsBOSgz44mIThv1FRO+/Dc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E16213AAA;
	Wed, 19 Jun 2024 07:19:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VJLqIJKGcmYJBwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 19 Jun 2024 07:19:46 +0000
Date: Wed, 19 Jun 2024 09:19:41 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernel-team@meta.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@infradead.org>
Subject: Re: [PATCH] mm: ratelimit oversized kvmalloc warnings instead of once
Message-ID: <ZnKGjdw8xkMZG0oX@tiehlicka>
References: <20240618213421.282381-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618213421.282381-1-shakeel.butt@linux.dev>
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

On Tue 18-06-24 14:34:21, Shakeel Butt wrote:
> At the moment oversize kvmalloc warnings are triggered once using
> WARN_ON_ONCE() macro. One issue with this approach is that it only
> detects the first abuser and then ignores the remaining abusers which
> complicates detecting all such abusers in a timely manner. The situation
> becomes worse when the repro has low probability and requires production
> traffic and thus require large set of machines to find such abusers. In
> Mera production, this warn once is slowing down the detection of these
> abusers. Simply replace WARN_ON_ONCE with WARN_RATELIMIT.

Long time ago, I've had a patch to do the once_per_callsite WARN. I
cannot find reference at the moment but it used stack depot to note
stacks that have already triggered. Back then there was no reponse on
the ML. Should I try to dig deep and recover it from my archives? I
think this is exactly kind of usecase where it would fit.

> Reported-by: Kyle McMartin <kyle@infradead.org>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/util.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 10f215985fe5..de36344e8d53 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -649,7 +649,8 @@ void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node)
>  
>  	/* Don't even allow crazy sizes */
>  	if (unlikely(size > INT_MAX)) {
> -		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
> +		WARN_RATELIMIT(!(flags & __GFP_NOWARN), "size = %zu > INT_MAX",
> +			       size);
>  		return NULL;
>  	}
>  
> -- 
> 2.43.0

-- 
Michal Hocko
SUSE Labs

