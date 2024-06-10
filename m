Return-Path: <linux-kernel+bounces-207603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC2390198D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6B3281B98
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 03:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5476FC7;
	Mon, 10 Jun 2024 03:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XzuVDh8v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k7kv4Cr9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g80JSXZ/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xZDiG7fh"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144AD5227
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 03:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717990860; cv=none; b=AihQRkngPyk5X4NCE72wGWZ1J61z9GwvEZMOjk4phJGDSuD9hoHR1J2bxGTBqk7bhd0BgTTWwrIrJ/aEGSMWjYiLWC8mgbH0hMoVnmvu5lSySqH9SH4e/0wP29hUJESYno+vUeQwn9XCukjRbeUG0CHQ8xRIyy2Sj7CozFSRzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717990860; c=relaxed/simple;
	bh=pCJjDzAWRRb5muxi8e51kEbB19NgUlE6XNZVt4813ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fK5r9btyUGlMLR5wGyqVlsytv4HtOEKr7bOC+Rd8hzbis77HtmGxOXN8AzzdCmEXx1cRDHZj5+NkM9yh2bSupqAXQEGcC97k0TK+q+SicOQlgg65eFjrKPs14b+Si3R5S5oT9UAG68JM9c9sRhOWvbY3qAx47GHHOI2+H78lQSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XzuVDh8v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k7kv4Cr9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g80JSXZ/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xZDiG7fh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E23171F74A;
	Mon, 10 Jun 2024 03:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717990857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XhMeUSPitVOIJg+Ci4UGmlb8AHir6vvuaNsU4B/YN3Y=;
	b=XzuVDh8v0pD5ktmxgvQP591nI2YKBJiR2EqqtQR9tDYxJbpghtdjmJHQJiyoJC20iIZy1N
	WwrtB7C+DhvIZVuDXTo4lpSGQJuMgxMV7B6AUpn1JUuSNklbcUYZOPCPDr8sNhpNcQQHVv
	TPg75skKUgzfD4TU7yVIvKdm37i1TE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717990857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XhMeUSPitVOIJg+Ci4UGmlb8AHir6vvuaNsU4B/YN3Y=;
	b=k7kv4Cr9bxZsPs3tbU2SvoKUzp3a7hTtoWVht1nuoBVpZ+dCDIBRBKakoa7mHJHhkAOVAy
	oa6cp5WniPosyzAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717990856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XhMeUSPitVOIJg+Ci4UGmlb8AHir6vvuaNsU4B/YN3Y=;
	b=g80JSXZ/HTmohY5qWwhGy1p5v+b91LdxgDTMLyvg07kkCHB3Dnm10TeqcAaM7MPr/fRk9H
	FZzfRD9Xab8sghZxlWhEcS7Sr8BKkK45AJdRA9rhCjAyP2YAQ8eR/BlOoC5qmc4rB3CF4a
	t8Irtea3HRjeOz2nLq5U4UZ3drl/g30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717990856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XhMeUSPitVOIJg+Ci4UGmlb8AHir6vvuaNsU4B/YN3Y=;
	b=xZDiG7fhV7aTRHj5LgUMnmRDeBaCoCL4Hm/Xp7A9JakqDdq5iPvb0mZwEC1xZhNoRM34qq
	bvXYBL0194icwmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E0AF13A85;
	Mon, 10 Jun 2024 03:40:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XLnLH8h1ZmaeDQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 10 Jun 2024 03:40:56 +0000
Date: Mon, 10 Jun 2024 05:40:55 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 2/2] mm/highmem: make nr_free_highpages() return
 "unsigned long"
Message-ID: <ZmZ1x6QQYPFSOd7O@localhost.localdomain>
References: <20240607083711.62833-1-david@redhat.com>
 <20240607083711.62833-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607083711.62833-3-david@redhat.com>
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux-foundation.org,gmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]

On Fri, Jun 07, 2024 at 10:37:11AM +0200, David Hildenbrand wrote:
> It looks rather weird that totalhigh_pages() returns an
> "unsigned long" but nr_free_highpages() returns an "unsigned int".
> 
> Let's return an "unsigned long" from nr_free_highpages() to be
> consistent.
> 
> While at it, use a plain "0" instead of a "0UL" in the !CONFIG_HIGHMEM
> totalhigh_pages() implementation, to make these look alike as well.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
...
> -static inline unsigned int nr_free_highpages(void) { return 0; }
> -static inline unsigned long totalhigh_pages(void) { return 0UL; }
> +static inline unsigned long nr_free_highpages(void) { return 0; }
> +static inline unsigned long totalhigh_pages(void) { return 0; }

Although I doubt it has any consequences, I would just leave them both with UL,
so the return type is consistent with what we are returning.

Other than that

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs

