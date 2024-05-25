Return-Path: <linux-kernel+bounces-189281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBB78CEDE3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 06:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83211F21A37
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 04:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E008F72;
	Sat, 25 May 2024 04:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jEuDA50d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Hw080IjZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jEuDA50d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Hw080IjZ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02B5E566
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 04:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716611738; cv=none; b=KZeXhfa+sbnnx8SxuyN6viTG0Ov2ppupzZx1ZTF/a/GdJH/ufvAaL3J28UqQ4B4NOZFb5GAOWrw/sLOte5HHn1yBl7MepB/wyNIJPTEcEw7GC5XgeMkmulyKbjKrSQvGh5oSxQmdNdCm6BTMf83uWR1g7eG1qyBlx10FH+ZhK4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716611738; c=relaxed/simple;
	bh=r+bZUthXkqBc6ajk2TjUXY5YPQGUHdKAGqQFmLWPLxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sA4Wb+2lGis5ukm7cPsBdg+RK1jHK4V09W2fTJNGpH4/ndtUanqLCBEhFsa8C3AsRKlmQsYaEKwWJsxLE2W/2f2TTYSuaWVZXI5oEAw9k/OqcFn09NI59rUHoeatJXqrhmRR86164HOMOvB7fcuyGJYdjPhuTyMRJvW4ixmURrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jEuDA50d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Hw080IjZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jEuDA50d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Hw080IjZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3778340A3;
	Sat, 25 May 2024 04:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716611734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAR/KSCrC5bL7GZChS4ptojHBPTVtU1QG1noLesxm6g=;
	b=jEuDA50dLntxOGELXKI4qEeWr/V+CaRxCdiOUzPdnIRvDi5/zK0XkRCmTAZy1wMQPCIS80
	0IaM+NLFjiKWQzgpy/cufDsUy0SP+eHYbytzXy+ubegIB20C8TMmqXTKJ/inBorr91nUr7
	pBGs3iF56AnWXc9vlBjyET4uDr5BrrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716611734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAR/KSCrC5bL7GZChS4ptojHBPTVtU1QG1noLesxm6g=;
	b=Hw080IjZdbmzoh1NF9fvOmgSZm3v0K6OCVCqVSDn1Th3qHiq/yI5pSgIecmVycDo0Ce0wr
	mUYgoFCwNmLo81Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716611734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAR/KSCrC5bL7GZChS4ptojHBPTVtU1QG1noLesxm6g=;
	b=jEuDA50dLntxOGELXKI4qEeWr/V+CaRxCdiOUzPdnIRvDi5/zK0XkRCmTAZy1wMQPCIS80
	0IaM+NLFjiKWQzgpy/cufDsUy0SP+eHYbytzXy+ubegIB20C8TMmqXTKJ/inBorr91nUr7
	pBGs3iF56AnWXc9vlBjyET4uDr5BrrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716611734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAR/KSCrC5bL7GZChS4ptojHBPTVtU1QG1noLesxm6g=;
	b=Hw080IjZdbmzoh1NF9fvOmgSZm3v0K6OCVCqVSDn1Th3qHiq/yI5pSgIecmVycDo0Ce0wr
	mUYgoFCwNmLo81Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3903D13A6B;
	Sat, 25 May 2024 04:35:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q3RoC5ZqUWZpJwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Sat, 25 May 2024 04:35:34 +0000
Date: Sat, 25 May 2024 06:35:32 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 14/20] powerpc/e500: Remove enc field from struct
 mmu_psize_def
Message-ID: <ZlFqlO7oic7_Isn4@localhost.localdomain>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <9c7f189b7733b00e8dc9825e76b6bb257bbd519b.1715971869.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c7f189b7733b00e8dc9825e76b6bb257bbd519b.1715971869.git.christophe.leroy@csgroup.eu>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]

On Fri, May 17, 2024 at 09:00:08PM +0200, Christophe Leroy wrote:
> enc field is hidden behind BOOK3E_PAGESZ_XX macros, and when you look
> closer you realise that this field is nothing else than the value of
> shift minus ten.
> 
> So remove enc field and calculate tsize from shift field.
> 
> Also remove inc filed which is unused.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs

