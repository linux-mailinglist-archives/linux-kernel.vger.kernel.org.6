Return-Path: <linux-kernel+bounces-429752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D589B9E2358
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E1A16D035
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94461F76CE;
	Tue,  3 Dec 2024 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PS54EpbB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P2746Q0s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PS54EpbB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P2746Q0s"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D201F76C7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239856; cv=none; b=YP+09jUIb5aM6zRZEcNMbB/ddlJbyXQAFvBUDRxeOP7Yb69hI2EeJPcFeCgYOBBrNxT721wlsuwh02r2NDejL52iG0JYQ8ulkG0npuG0nV3DrUB+i7qJGWfJTKZI61QqjsAHE16a4h7c+fJBd4bEWrqHR26JF+9RvsN8bx7X/WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239856; c=relaxed/simple;
	bh=zWQgHYpyRQa2VA+Oolvik8QyyEbMbRXlJpcJNxb0ics=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbEL0WYUQnVbkideEk0U5oTikXMKlpWWqsrG3b0j5dJFIimFF8GgMv/y97OYCgr/t/m5tKvSeeLA1YIBEVbJPftQCvR+884bchLwc3NIGAP/zkkpRwJmV8tcpB9cnzAtSp8jCoY4uyno0jLgOT/X+hZFNitYN1VC5Aj9Imm79jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PS54EpbB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P2746Q0s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PS54EpbB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P2746Q0s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 066B51F445;
	Tue,  3 Dec 2024 15:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733239853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RHb8MOnWhrezL6xDBmamy+BIYbJwg/hcDSsuLIyNMKs=;
	b=PS54EpbB3GsItM2TlmOBy9MwWXLh+ZtKNQPY9jKbgSYxnD4ODh6WKWO3wsJZyeMMcy8/8X
	THqYM/gYTMue0PF5FRt0pJlGPtmRtJLM9II/2lz+YV9kPSpIhWmgIbiJTaLlvZSzGhjCoS
	n4GKvQM7lOgDD/FJPPQZK1nJ40j5yjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733239853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RHb8MOnWhrezL6xDBmamy+BIYbJwg/hcDSsuLIyNMKs=;
	b=P2746Q0sIH/p8zHpc4SmyGUCWw1dQg+5ZsOLHETYVmbjcKXVxMeQxS39gv92jzbWEGeFMv
	PUSuHL2OuzgR3IDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733239853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RHb8MOnWhrezL6xDBmamy+BIYbJwg/hcDSsuLIyNMKs=;
	b=PS54EpbB3GsItM2TlmOBy9MwWXLh+ZtKNQPY9jKbgSYxnD4ODh6WKWO3wsJZyeMMcy8/8X
	THqYM/gYTMue0PF5FRt0pJlGPtmRtJLM9II/2lz+YV9kPSpIhWmgIbiJTaLlvZSzGhjCoS
	n4GKvQM7lOgDD/FJPPQZK1nJ40j5yjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733239853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RHb8MOnWhrezL6xDBmamy+BIYbJwg/hcDSsuLIyNMKs=;
	b=P2746Q0sIH/p8zHpc4SmyGUCWw1dQg+5ZsOLHETYVmbjcKXVxMeQxS39gv92jzbWEGeFMv
	PUSuHL2OuzgR3IDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5739913A15;
	Tue,  3 Dec 2024 15:30:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZBpaEiwkT2ffSAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 03 Dec 2024 15:30:52 +0000
Date: Tue, 3 Dec 2024 16:30:50 +0100
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH RESEND v2 1/6] mm/page_isolation: don't pass gfp flags to
 isolate_single_pageblock()
Message-ID: <Z08kKtfC0F41WscX@localhost.localdomain>
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203094732.200195-2-david@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.ozlabs.org,linux-foundation.org,nvidia.com,ellerman.id.au,gmail.com,csgroup.eu,kernel.org,linux.ibm.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -8.30
X-Spam-Flag: NO

On Tue, Dec 03, 2024 at 10:47:27AM +0100, David Hildenbrand wrote:
> The flags are no longer used, we can stop passing them to
> isolate_single_pageblock().
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

