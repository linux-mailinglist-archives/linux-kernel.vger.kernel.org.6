Return-Path: <linux-kernel+bounces-190485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958B58CFEE8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E3F282F70
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85E314F9E9;
	Mon, 27 May 2024 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DDxfd5pz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mCZhjzJU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DDxfd5pz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mCZhjzJU"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B782514F13B
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716809160; cv=none; b=ejhqIDZQE9vPBuzHHXNA/aHTZfVA4uN+dUAhFGOdnlIDTnBLZ0Ob1WaxsQhJjRpf5qWOXJSRlgwC04OND67WmJMTMRmkssUjKrUJyif88p0+VZFtD/LvbNLKfTKMK4kxjMXQyKAXez4QpEqO2WM7ri0jzfO8l/Z41JNurVKjMos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716809160; c=relaxed/simple;
	bh=mxaLW9F/KHm1Crwp8xU6s17vqlBhoqn3MlPE2dMdJz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok9xJbxI7Q2c1yoDhX1IO63S7ELvTVz0Xg32Ghq7XNBH6pNACD0tbP8/Tg4ue9WXB3NZE4RDdha7FKVfeL1rvL5QE+lAWEcvX7vb5tdgPUqfhUAodtH0Y1zhOJKERX8Ip7D6oKX0xvX0/6VJzGCzfcCMSEP1+XT4si2bCXfe+uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DDxfd5pz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mCZhjzJU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DDxfd5pz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mCZhjzJU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D46991FCFD;
	Mon, 27 May 2024 11:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716809156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+621Dnv2ibRxQTGa/2GbBLACpbN7ercwRBRx17FeVk=;
	b=DDxfd5pzRBfBiYYNnL2Fg9WCnRRkOEfeR9YBiddC+vQjA8+OJO8hoGwyqF7r6LPfktZoEt
	TXXtjgv6kbdyFfi60mh3Gmawr8NXtV6+05abXqHCfY3iqRgHk85G9VLUC1oaFT3PxVGdm0
	NYr5Z9FL1HstWWWqHmLt1EexrqTght8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716809156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+621Dnv2ibRxQTGa/2GbBLACpbN7ercwRBRx17FeVk=;
	b=mCZhjzJU5PsVCkeZkYpz/vZsgq5HliEWZ+WVjS7262gZNQAi/7nY91Cltbhn/32czXAv5R
	D4Od0ITOC1tg/JBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716809156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+621Dnv2ibRxQTGa/2GbBLACpbN7ercwRBRx17FeVk=;
	b=DDxfd5pzRBfBiYYNnL2Fg9WCnRRkOEfeR9YBiddC+vQjA8+OJO8hoGwyqF7r6LPfktZoEt
	TXXtjgv6kbdyFfi60mh3Gmawr8NXtV6+05abXqHCfY3iqRgHk85G9VLUC1oaFT3PxVGdm0
	NYr5Z9FL1HstWWWqHmLt1EexrqTght8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716809156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+621Dnv2ibRxQTGa/2GbBLACpbN7ercwRBRx17FeVk=;
	b=mCZhjzJU5PsVCkeZkYpz/vZsgq5HliEWZ+WVjS7262gZNQAi/7nY91Cltbhn/32czXAv5R
	D4Od0ITOC1tg/JBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5741413A6B;
	Mon, 27 May 2024 11:25:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HXTREsRtVGbSCgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 27 May 2024 11:25:56 +0000
Date: Mon, 27 May 2024 13:25:39 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 05/16] powerpc/mm: Fix __find_linux_pte() on 32
 bits with PMD leaf entries
Message-ID: <ZlRts-bXF49qLw2n@localhost.localdomain>
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
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]

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

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

