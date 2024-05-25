Return-Path: <linux-kernel+bounces-189266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 348638CEDBD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 05:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1876281AC1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 03:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269DA2566;
	Sat, 25 May 2024 03:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Uwqw16Hj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9CbiNVzJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Uwqw16Hj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9CbiNVzJ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950E6137E
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 03:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716608223; cv=none; b=hFNsH1CnssTMuVtavZW/wkCpqgpFyo3jPJotzqT4NtGZQSTEVjqX7Hh0e20M046X9OahWJF59lW5vlUJUhAlSrGTaMTYrP6uJyQajSV8dgvmLhiaiuKLMpSsRl9dI0WB8HquaOXSwzFL3yRjclPvzF2afudvg/1ALp6nYqHFRq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716608223; c=relaxed/simple;
	bh=bsL1nSREhgR40bPuneAHGxewDWwT29wHhsZ3oc8G8Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhdkXtaOfSRMLw5JU/o0ys9UO3NrWUX8FEy2ym2UQbT/XBwBTRHMdhSKqCFZOdEKMo1TYI7IW0hZAfCMo09BLmFXZOuH+bog7eweE7O3hcvaR2pO3mKFK05wtawEQPUWbt1AIm2oVonSTM6wqgK4obmjmCXCMZcjlnEgYZvfvng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Uwqw16Hj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9CbiNVzJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Uwqw16Hj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9CbiNVzJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D6633405A;
	Sat, 25 May 2024 03:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716608214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bIDylrp4rAhC0c41PjakISlV7LrJwB6HuPbm/+rCJHc=;
	b=Uwqw16HjUJg6/uq7vYSrf4/zhZbRm4HhvRVzl9PA8qemuQLwP7ObtZjDhMajHX84rRfPWB
	o2JLCg2GHeKvPVlY7YmWfmV9lrdlPu8fe+yfXOCepAGJfhR2AQ1lP9pchFu67tDXxiupnC
	Kproe7bZpVx16psAq9ZO+2//Uimzxec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716608214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bIDylrp4rAhC0c41PjakISlV7LrJwB6HuPbm/+rCJHc=;
	b=9CbiNVzJueLBbwIJRZD0Jy/fglymQ55KSDVWQeV8fYlxVFGccoz+ghzdSuC+MLKaLCbMzs
	0l8Bv4ctN1/DZgCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Uwqw16Hj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9CbiNVzJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716608214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bIDylrp4rAhC0c41PjakISlV7LrJwB6HuPbm/+rCJHc=;
	b=Uwqw16HjUJg6/uq7vYSrf4/zhZbRm4HhvRVzl9PA8qemuQLwP7ObtZjDhMajHX84rRfPWB
	o2JLCg2GHeKvPVlY7YmWfmV9lrdlPu8fe+yfXOCepAGJfhR2AQ1lP9pchFu67tDXxiupnC
	Kproe7bZpVx16psAq9ZO+2//Uimzxec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716608214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bIDylrp4rAhC0c41PjakISlV7LrJwB6HuPbm/+rCJHc=;
	b=9CbiNVzJueLBbwIJRZD0Jy/fglymQ55KSDVWQeV8fYlxVFGccoz+ghzdSuC+MLKaLCbMzs
	0l8Bv4ctN1/DZgCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C14A713A1E;
	Sat, 25 May 2024 03:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2HaZLNVcUWa/aAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Sat, 25 May 2024 03:36:53 +0000
Date: Sat, 25 May 2024 05:36:44 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 08/20] powerpc/8xx: Simplify struct mmu_psize_def
Message-ID: <ZlFczHaQ0JNi6PVu@localhost.localdomain>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <ca2d232f07adfd7b3ed56d339a6071155cc9bcb7.1715971869.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca2d232f07adfd7b3ed56d339a6071155cc9bcb7.1715971869.git.christophe.leroy@csgroup.eu>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4D6633405A
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]

On Fri, May 17, 2024 at 09:00:02PM +0200, Christophe Leroy wrote:
> On 8xx, only the shift field is used in struct mmu_psize_def
> 
> Remove other fields and related macros.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

