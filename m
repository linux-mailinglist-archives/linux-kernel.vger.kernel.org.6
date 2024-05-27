Return-Path: <linux-kernel+bounces-190514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7C48CFF5C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328DF1F23E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242C015ECF3;
	Mon, 27 May 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TPgt3s5r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1Z0ASMc8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FK4yjBeY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="csvjI1Mp"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA6115ECDE
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810603; cv=none; b=avGduaeOlxX6K0LVxRrbkYCskBL0/t1pa83S/luN5O38QeKN9BCeCSZAoUhuI/QUKRNumhZ8drw/zq9ydUGf0t4POlXQW0lt9Bz6i06ySbpPDLDJS/0ddHKwcGoIElpH+PERWejhn5ALVYO474tCCsKGdib4EHLjY9H3xJhVbD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810603; c=relaxed/simple;
	bh=wrcYuQ4mk5lfvedS0hfgue6NgEYm68+OvAVcFDW58kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/80bv6VxQ576oKLBLEIflHcrxB9Bgi+ZSqDbAUgL3n3+yBcj7HxozmsAIcS9sM6XsJj1DTTsB8wYA3O3kKi8X9ACiiMH0l7b4B87soxLIwBazP60/fXGJxrbdhESeATW271/D9FkYeSs9ANsPAK1tXwMaHBQfRsQYSlizrp0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TPgt3s5r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1Z0ASMc8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FK4yjBeY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=csvjI1Mp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C7ECE1FD15;
	Mon, 27 May 2024 11:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716810600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2f3e4eA0EYCAHDS7kAJ9/g5TIlOdMCZlb+GA1zYLi7c=;
	b=TPgt3s5r0y0zXEu2robnj+9lLutIHjCzLce9yz+3C99s1hA24IDqi5wHhwjeDr02ZZVz8R
	n4xC9bW1klAfzCsj1ZXS6ekk94BNK8HA0Qg302UVk2gkFyIXbMSWNGbHTKPNmcU9BxnRsN
	Oym+8TKailW0cYqcGO8tI7+ZGLkIuMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716810600;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2f3e4eA0EYCAHDS7kAJ9/g5TIlOdMCZlb+GA1zYLi7c=;
	b=1Z0ASMc8+dP1Ki9ltstJGOnEV9G29DLn1s1Zlg0rjXDq3g+kCgtU4w5vdq57CELAoqMrOC
	Tllpfuv60NGXr6Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FK4yjBeY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=csvjI1Mp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716810599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2f3e4eA0EYCAHDS7kAJ9/g5TIlOdMCZlb+GA1zYLi7c=;
	b=FK4yjBeYP9PYFDTeqXn48SfZzVnJl1EldFXcgzO7TrabhK6zcQ98ZrZ3Zlx/vCTnumDsNL
	qcdaK6iibqaYrYELRp8EYqaeNvi/Sak4dznhd7GqdItnqvq6PP2RttZvPHjLDUVdPJp1gd
	YF0WQIgZ8A0yOKCBkxzuiZZ242HOx90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716810599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2f3e4eA0EYCAHDS7kAJ9/g5TIlOdMCZlb+GA1zYLi7c=;
	b=csvjI1Mp0aR+Ir6mBbK08dJfwgSIBseTtQfDbHdXoGVJpLRitdjsTO7lzK9/DYur8XeJTr
	YB+0/aBXjrLYjWDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BFA013A6B;
	Mon, 27 May 2024 11:49:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dhO/D2dzVGYUUAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 27 May 2024 11:49:59 +0000
Date: Mon, 27 May 2024 13:49:49 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 06/16] powerpc/mm: Allow hugepages without hugepd
Message-ID: <ZlRzXe_AZpphZZv2@localhost.localdomain>
References: <cover.1716714720.git.christophe.leroy@csgroup.eu>
 <f1f0466e04a048333f1d15867553eba5ef83c1de.1716714720.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1f0466e04a048333f1d15867553eba5ef83c1de.1716714720.git.christophe.leroy@csgroup.eu>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C7ECE1FD15
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

On Sun, May 26, 2024 at 11:22:26AM +0200, Christophe Leroy wrote:
> In preparation of implementing huge pages on powerpc 8xx
> without hugepd, enclose hugepd related code inside an
> ifdef CONFIG_ARCH_HAS_HUGEPD
> 
> This also allows removing some stubs.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

