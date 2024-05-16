Return-Path: <linux-kernel+bounces-180759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0656F8C72BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED09281D60
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57322131181;
	Thu, 16 May 2024 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tekL+mXF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f2K2rcLM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YMf5zKyk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eqjn0Nqy"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40AE130A7F
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848016; cv=none; b=OD4lAtOaj7lfMYQCWmtO0Qab2sdPcqZSroL7TpNovkOES4kj3OWkGd5bUF1lKZC8OsB9SCyk/lxTiag9QWk28394OM6Yqk1RZiCl++nS62jWiZQ+TPXV+wu+IztewYZWDZExOYsm02KaJ3pSuCUn913gV8QWufnenH2yXv3lgnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848016; c=relaxed/simple;
	bh=5g5pjcCmVKQET7+bpE8KYrV3O+xZwFqaHXLPCFI9VsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYMIposiA7bfbWiRD9uLRGzstYHK8kvZQC1F1Rln5N6HWP1+pUjuQqQtezMh4at8Wa1g8G7GPeqEXPpsXJcHIjR4K1kaBVbq6yiE6y5umpFLZRnIFB30xV3kkGOcchnUdD5ueqnQU+0RIta8cuvbG/gvHM8p5+kyZpTZKwzO1oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tekL+mXF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f2K2rcLM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YMf5zKyk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eqjn0Nqy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0C825BF89;
	Thu, 16 May 2024 08:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715848013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=88ImWpY7VkoQko/tSvrYsTjEj80P+5Y5W9boRDo+w58=;
	b=tekL+mXFxayesuXP5qToh9CjvJxWl8RhxtUk5xuGYsX6+HniKsq4J6seOZRd82nFomzjIt
	5JJs3YYRPXhhv2HVg4G5sBPYc/DimCWNjDH71fbtNJ2oNvXYJS+kp955fMUsiNOC7DHn6H
	VKRhRT6DjmuLKZZgxZhFMTP81ETHu+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715848013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=88ImWpY7VkoQko/tSvrYsTjEj80P+5Y5W9boRDo+w58=;
	b=f2K2rcLMTcGrKqnvHVwEbFMFDeMG28XGzq4K1lvmxGHhNvcrzl997Ib5yEOi6vwl1cXlvi
	aOE4gdjubGjRquAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YMf5zKyk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eqjn0Nqy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715848012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=88ImWpY7VkoQko/tSvrYsTjEj80P+5Y5W9boRDo+w58=;
	b=YMf5zKykrMHV/ZWMo8u3c69dOQcWTy481/aJlNDPx9d91YG+unI/aCdy8ClUiLwUDXjDBP
	p1Ys5dItRpmK2rtpFSKNQNUOjENNNXuRFSIA+Otqf624eamAJgJJCHe7nOh1ZxccC+tU8K
	Ei9iwIhC4TNrDMAMeoYqcPw8YylEMdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715848012;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=88ImWpY7VkoQko/tSvrYsTjEj80P+5Y5W9boRDo+w58=;
	b=eqjn0NqyTRaaXRFcZvRIcL9JN1J3JIJa9vYOujZhWZWKDMnQ3BbAw4HsAtzTkheqHNM0LL
	ZJlFjbkBMYo20aBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EE8C137C3;
	Thu, 16 May 2024 08:26:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XexSHEzDRWYaEQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 16 May 2024 08:26:52 +0000
Date: Thu, 16 May 2024 10:26:51 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
	shy828301@gmail.com, nao.horiguchi@gmail.com,
	xuyu@linux.alibaba.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/huge_memory: don't unpoison huge_zero_folio
Message-ID: <ZkXDS9y_cBSzBzeN@localhost.localdomain>
References: <20240515023607.870022-1-linmiaohe@huawei.com>
 <e1c93779-8cde-4986-85d3-2134fb8970b3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c93779-8cde-4986-85d3-2134fb8970b3@redhat.com>
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F0C825BF89
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	SUSPICIOUS_RECIPS(1.50)[];
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
	FREEMAIL_CC(0.00)[huawei.com,linux-foundation.org,gmail.com,linux.alibaba.com,kvack.org,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Wed, May 15, 2024 at 05:55:39PM +0200, David Hildenbrand wrote:
> > +	if (is_huge_zero_folio(folio)) {
> > +		unpoison_pr_info("Unpoison: huge zero page is not supported %#lx\n",
> > +				 pfn, &unpoison_rs);
> > +		goto unlock_mutex;
> > +	}
> > +

Sorry for spamming your reply David, but for some unknown reason I am not able
to find the original patch in my mailbox, in none of the two accountes I am
subscribed, so I guess I will have to reply here.

Just two things

1) We do not care if someone grabs a refcount for huge_zero_folio,
   because since it is not supported anyway the outcome will not change.
   Also, AFAIK, there is no chance we can unpoison that folio.
   Therefore, I would just lift the check two blocks and place it right after
   the hw_memory_failure check.

2) The whole thing is unsupported, but you will return -EBUSY while you
   should be returning -EOPNOTSUPP AFAICS.

with that you can add:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

