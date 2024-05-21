Return-Path: <linux-kernel+bounces-184803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C918CAC2E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1261F21EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A781F6E61E;
	Tue, 21 May 2024 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bA+zcWhS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qtc2fJWr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bA+zcWhS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qtc2fJWr"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6174F88A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716287025; cv=none; b=h2QDBSOu1gpy/GkOY15OHeYW3KD1HBxBUz+I6XbKBoP/ZHrf6LrNlRlYudzJrRURm80w+49lEj1oqcGzZqQwBTHInHC6yJVJIT14DZL2BzBuPE48bf+hNktEQ4eEkKtmOM0zex+NmAZOJ+POScx6rvcdSvHU8ybqtJ2hrrCHPak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716287025; c=relaxed/simple;
	bh=+3FcXXUMwhjhiIYrECysvrpCu4cjXRCRft7zAMJgqxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nun3EUI7+SCLSP2wCkA8+/DPXsg5a6P1R4d6hCBHye2KSG8p+lMwfX3gINCv5pEHmxVOxtpKHOgzO+5juD9cHQ8MuKzk8EPRajMC/TP+gh04z15pd5Ysibg9ILtokIE7Gmu4dSl3rRwjso9/9T1NJL98xcPyDmHLPy4QSIM8U+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bA+zcWhS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qtc2fJWr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bA+zcWhS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qtc2fJWr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4EB815C04F;
	Tue, 21 May 2024 10:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716287021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2HWjoc4Tt+cW/CoaPn49Mt7pqUTZI4U/K0EbpV7waOA=;
	b=bA+zcWhSIDcNye/11nLo8HBJPCP+jQIZHnK7XZm+RQ287e4dDSgP+rDdAo8Jkwvl0m7Tsp
	NU5OE2AAqc8iH8N1BQ1vk+nYi/B1toEc7xKeGdNYuMswZzdeVpaxgs9Kpc0iZ+S3mUUfTu
	wRjue0HXFIA7U7Ax0Gfbyvj6pUPbaq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716287021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2HWjoc4Tt+cW/CoaPn49Mt7pqUTZI4U/K0EbpV7waOA=;
	b=qtc2fJWrnyG7/Nj9AxLSowPlE0yh2c6o19kOmIysaXwm9pH336r5KvhczNYDSxl0WUZE8O
	Cgrolw9cplEHr6Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bA+zcWhS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qtc2fJWr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716287021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2HWjoc4Tt+cW/CoaPn49Mt7pqUTZI4U/K0EbpV7waOA=;
	b=bA+zcWhSIDcNye/11nLo8HBJPCP+jQIZHnK7XZm+RQ287e4dDSgP+rDdAo8Jkwvl0m7Tsp
	NU5OE2AAqc8iH8N1BQ1vk+nYi/B1toEc7xKeGdNYuMswZzdeVpaxgs9Kpc0iZ+S3mUUfTu
	wRjue0HXFIA7U7Ax0Gfbyvj6pUPbaq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716287021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2HWjoc4Tt+cW/CoaPn49Mt7pqUTZI4U/K0EbpV7waOA=;
	b=qtc2fJWrnyG7/Nj9AxLSowPlE0yh2c6o19kOmIysaXwm9pH336r5KvhczNYDSxl0WUZE8O
	Cgrolw9cplEHr6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFF6C13A21;
	Tue, 21 May 2024 10:23:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aiqhMyx2TGYyAwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 21 May 2024 10:23:40 +0000
Date: Tue, 21 May 2024 12:23:35 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
	Vishal Moola <vishal.moola@gmail.com>
Subject: Re: [PATCH] mm/hugetlb: Move vmf_anon_prepare upfront in hugetlb_wp
Message-ID: <Zkx2JxmI8NsKtlRa@localhost.localdomain>
References: <20240521073446.23185-1-osalvador@suse.de>
 <338b4d56-7e5a-4d8f-8908-610f2c59e29e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <338b4d56-7e5a-4d8f-8908-610f2c59e29e@redhat.com>
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4EB815C04F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,linux.dev,gmail.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]

On Tue, May 21, 2024 at 11:56:54AM +0200, David Hildenbrand wrote:
> On 21.05.24 09:34, Oscar Salvador wrote:
> > hugetlb_wp calls vmf_anon_prepare() after having allocated a page, which
> > means that we might need to call restore_reserve_on_error() upon error.
> > vmf_anon_prepare() releases the vma lock before returning, but
> > restore_reserve_on_error() expects the vma lock to be held by the caller.
> > 
> > Fix it by calling vmf_anon_prepare() before allocating the page.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > Fixes: 9acad7ba3e25 ("hugetlb: use vmf_anon_prepare() instead of anon_vma_prepare()")
> > ---
> > I did not hit this bug, I just spotted this because I was looking at hugetlb_wp
> > for some other reason. And I did not want to get creative to see if I could
> > trigger this so I could get a backtrace.
> > My assumption is that we could trigger this if 1) this was a shared mapping,
> > so no anon_vma and 2) we call in GUP code with FOLL_WRITE, which would cause
> > the FLAG_UNSHARE to be passed, so we will end up in hugetlb_wp().
> 
> FOLL_WRITE should never result in FLAG_UNSHARE.

You are right.
It was quite early when I looked at this and I managed to confuse myself when
reading hugetlb_follow_page_mask().
 
> The joy of hugetlb reservation code.
> 
> LGTM

thanks David!
 

-- 
Oscar Salvador
SUSE Labs

