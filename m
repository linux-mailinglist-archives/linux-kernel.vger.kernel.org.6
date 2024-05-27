Return-Path: <linux-kernel+bounces-190033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0358CF896
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FA7281F02
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30870D268;
	Mon, 27 May 2024 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OFtu+AIv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gKgvAIJr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OFtu+AIv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gKgvAIJr"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FEA8BFC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716786189; cv=none; b=EW7bzDeQFhvO2dJ9ZT6Ew5DnTNsA3d9rMSMJbdZ1pf+VVB1XQTAgfcOgNkH7ecRJCYB1EhxDbOv9Whyw0r75koD4/YtdhzsaAMcJCNDszyIAxuNzYRvrCTvzFoQpuEkKYSQMw/UPMw9eUHk+uTb+t5x9JnH2J1gAxQQT7PKcapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716786189; c=relaxed/simple;
	bh=BoKeT6yP7WqKfznp+eQZWLvDQLIZNATbCmbpQY3u03I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhmgoaljejNziBQPIe/UmaMuQIwf0ktJj5j5A64BnKxDA5NK7Gqf3p6/tRdNXDiS2AJCLP64HRd4pKL8fIHxyJy+14mUlJsvxSDzScVboPevopvspMfokqRwOuuP9ngf61sTMyOUGWn5gLcDXCowknP5/txg7Km4hqUHcgIm+aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OFtu+AIv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gKgvAIJr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OFtu+AIv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gKgvAIJr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D5601F8BD;
	Mon, 27 May 2024 04:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716785763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xC5zp4HlZu07QkP75GPGGYKgpdHreqvBoXt6mnZlkEs=;
	b=OFtu+AIvEFBHI7CLLozC3h/eRZHm8F+B2wBXLlvWcSR+3kbPqOHglqZW6aTQ7l75/l1e4x
	XZfAbxQqlMCOH3ujBeCuGIFJeSUsqGMEl63asJ8IH/j6Di1uvzBemsF2ICZ4vlLm7rlzit
	DftKcNb86yaaxN+Mlh9ls7ix4sKsLqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716785763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xC5zp4HlZu07QkP75GPGGYKgpdHreqvBoXt6mnZlkEs=;
	b=gKgvAIJrkIFFeoKTrAZkAnnA+2IeuOQm55UrZ0Sh6aHkWiHBHRpf5XdVO55mjjnQGk0brV
	ak70Quay7XyHLjAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716785763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xC5zp4HlZu07QkP75GPGGYKgpdHreqvBoXt6mnZlkEs=;
	b=OFtu+AIvEFBHI7CLLozC3h/eRZHm8F+B2wBXLlvWcSR+3kbPqOHglqZW6aTQ7l75/l1e4x
	XZfAbxQqlMCOH3ujBeCuGIFJeSUsqGMEl63asJ8IH/j6Di1uvzBemsF2ICZ4vlLm7rlzit
	DftKcNb86yaaxN+Mlh9ls7ix4sKsLqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716785763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xC5zp4HlZu07QkP75GPGGYKgpdHreqvBoXt6mnZlkEs=;
	b=gKgvAIJrkIFFeoKTrAZkAnnA+2IeuOQm55UrZ0Sh6aHkWiHBHRpf5XdVO55mjjnQGk0brV
	ak70Quay7XyHLjAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9786713A6B;
	Mon, 27 May 2024 04:56:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9T1yImISVGaodAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 27 May 2024 04:56:02 +0000
Date: Mon, 27 May 2024 06:55:53 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 05/16] powerpc/mm: Fix __find_linux_pte() on 32
 bits with PMD leaf entries
Message-ID: <ZlQSWRvZuyaY886M@localhost.localdomain>
References: <cover.1716714720.git.christophe.leroy@csgroup.eu>
 <aa54834e9ee5e40179def32ff5834a8a2a02c413.1716714720.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa54834e9ee5e40179def32ff5834a8a2a02c413.1716714720.git.christophe.leroy@csgroup.eu>
X-Spam-Flag: NO
X-Spam-Score: -8.30
X-Spam-Level: 
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.977];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]

On Sun, May 26, 2024 at 11:22:25AM +0200, Christophe Leroy wrote:
> Building on 32 bits with pmd_leaf() not returning always false leads
> to the following error:
> 
>   CC      arch/powerpc/mm/pgtable.o
> arch/powerpc/mm/pgtable.c: In function '__find_linux_pte':
> arch/powerpc/mm/pgtable.c:506:1: error: function may return address of local variable [-Werror=return-local-addr]
>   506 | }
>       | ^
> arch/powerpc/mm/pgtable.c:394:15: note: declared here
>   394 |         pud_t pud, *pudp;
>       |               ^~~
> arch/powerpc/mm/pgtable.c:394:15: note: declared here
> 
> This is due to pmd_offset() being a no-op in that case.
> 
> So rework it for powerpc/32 so that pXd_offset() are used on real
> pointers and not on on-stack copies.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Maybe this could be folded into the patch that makes pmd_leaf() not returning
always false, but no strong feelings:

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

