Return-Path: <linux-kernel+bounces-210215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089E99040E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F38828415E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C453A29C;
	Tue, 11 Jun 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ft5M4dBN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kCckAyCp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ft5M4dBN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kCckAyCp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443702C694
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718122233; cv=none; b=n7DV/+c8WrBGpn77OdGp5TcAviyDH2leMRC5izEiNPr5ml1hZ2uYEgJQvgpMFq7PZTpHDGBg31lG6El7CQZOh9t6Xhi2P6E3t0ybYlQbsyDhRa/7KuWnRPSG7DyNFgTKffByR6tg4jZfMMdWSDdyoQsyAXppk1EseO0uaIGLSSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718122233; c=relaxed/simple;
	bh=n10Q89p05VcVCvPienMPsxJTwcefWgLSnoF7hKi8fn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjrAlqm0YwXrNlBMIn1BgveK8VGtNMdnk/Nd6mpNzJ9KlSXKDgN8np+OxkDK4DT7dJAbnRc9u3kwwo78xe3Ix/zqC43M+ch4ahs80YEKZg7orVvWONrro5XLJJAOlQC+GVXnNELANOSa+/fCsOnj/qIj5ai+0X3chneEeRsImoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ft5M4dBN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kCckAyCp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ft5M4dBN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kCckAyCp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D8EC33897;
	Tue, 11 Jun 2024 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718122229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QcRqjLgpqIHGpe2PS9pcLZoBz6DCvNoiWXtXXWQ7gVc=;
	b=Ft5M4dBNGECUCS9SOsUDt3DVWViAXB9GA9LLG4AosSdc4kaxThOanOro7PuC37JPxvCK8t
	Rw2dFRct3U4RRcNpmgZJwZmaicHozSjvYQXBLk1X85hh6+SyRYj65sZ1mbW5XAQPSjnHN3
	QVAK0hrdc/15sFYQO2XTJoZp00Xp+HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718122229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QcRqjLgpqIHGpe2PS9pcLZoBz6DCvNoiWXtXXWQ7gVc=;
	b=kCckAyCpA8jk9AGY+z9wTUUWVKs8HhQhD2HwhBJcK+pZu4yUc2obSnQK49ebWLynPv8p8E
	uZj+vycl0JCCVIBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718122229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QcRqjLgpqIHGpe2PS9pcLZoBz6DCvNoiWXtXXWQ7gVc=;
	b=Ft5M4dBNGECUCS9SOsUDt3DVWViAXB9GA9LLG4AosSdc4kaxThOanOro7PuC37JPxvCK8t
	Rw2dFRct3U4RRcNpmgZJwZmaicHozSjvYQXBLk1X85hh6+SyRYj65sZ1mbW5XAQPSjnHN3
	QVAK0hrdc/15sFYQO2XTJoZp00Xp+HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718122229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QcRqjLgpqIHGpe2PS9pcLZoBz6DCvNoiWXtXXWQ7gVc=;
	b=kCckAyCpA8jk9AGY+z9wTUUWVKs8HhQhD2HwhBJcK+pZu4yUc2obSnQK49ebWLynPv8p8E
	uZj+vycl0JCCVIBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B830B13A55;
	Tue, 11 Jun 2024 16:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O1RtKvR2aGZ3bgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 11 Jun 2024 16:10:28 +0000
Date: Tue, 11 Jun 2024 18:10:27 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 02/18] mm: Define __pte_leaf_size() to also take a PMD
 entry
Message-ID: <Zmh282yJjxc7zqbL@localhost.localdomain>
References: <cover.1717955558.git.christophe.leroy@csgroup.eu>
 <172b11c93e0de7a84937af2da9f80bd17c56b8c9.1717955558.git.christophe.leroy@csgroup.eu>
 <ZmgaHyS0izhtKbx6@localhost.localdomain>
 <ZmhcepJrkDpJ7mSC@x1n>
 <ZmhofWIiMC3I0aMF@localhost.localdomain>
 <ZmhrIdh3PLzvZU07@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmhrIdh3PLzvZU07@x1n>
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[csgroup.eu,linux-foundation.org,nvidia.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -8.30
X-Spam-Level: 

On Tue, Jun 11, 2024 at 11:20:01AM -0400, Peter Xu wrote:
> On Tue, Jun 11, 2024 at 05:08:45PM +0200, Oscar Salvador wrote:
> > The problem is that we do not have spare bits for 8xx to mark these ptes
> > as cont-ptes or mark them pte as 8MB, so I do not see a clear path on how
> > we could remove huge_ptep_get for 8xx.
> 
> Right, I remember I thought about this too when I initially looked at one
> previous version of the series, I didn't come up yet with a good solution,
> but I guess we probably need to get rid of hugepd first anyway.  We may
> somehow still need to identify this is a 8M large leaf, and I guess this is
> again the only special case where contpte can go over >1 pmds.

Yes, we definitely need first to get rid of hugepd, which is a huge
step, and one step closer to our goal, but at some point we will have to
see what can we do about 8MB cont-ptes for 8xx and how to mark them,
so ptep_get can work the same way as e.g: arm64
(ptep_get->contpte_ptep_get).

@Christophe: Can you think of a way to flag those ptes? (e.g: a
combination of bits etc)

> I'll leave this to Christophe, but IIUC thp is only PMD_ORDER sized, so
> shouldn't apply to the 8MB pages.

That might be it, yes.


-- 
Oscar Salvador
SUSE Labs

