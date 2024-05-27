Return-Path: <linux-kernel+bounces-190759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04248D023D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E69F28B1EF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3208815EFA8;
	Mon, 27 May 2024 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Tyc2CM5h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q1dF3XHF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Tyc2CM5h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q1dF3XHF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D281640B
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716818089; cv=none; b=XVy/hq9WLLBCgU45EVr6++zbDPKyNvvz4qeDeHlp16XKfxiL40BI2s6i8PiDuoKm2snp2z7f9pEG0gxnk/AQU/jpZZIDE4ugr5SjZ1zdXNZlpwuUt7ap0Uc4K+Fqjud/DNIvze++Wy5I96Rcjy3Tj+hYLvIDValtlQ8IdT+ZyIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716818089; c=relaxed/simple;
	bh=5+/RNfW7vRzWZ0tF6n6pkr8k8vsW4bwaEDIqJGrqVcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DECVmoZP+DSx1k8ZtU8MK3E1O38BFwfukilyP1iTblu7rhL8xiLI5PHErG+loQH2qDmiIjiAFGjl2jvlB5aVNxepqgxgRm9BGibAOpYxFnRtD9y3sb0POK4uU4jei4lHQIziLQT937UJAzeyYHrguveC42DQP7Y7Y7BjuMxIRc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Tyc2CM5h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q1dF3XHF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Tyc2CM5h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q1dF3XHF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F37091FDBC;
	Mon, 27 May 2024 13:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716818086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ffJQ9lsRqvbcsan0P8FZrl2jwHiRvYxA8CCEXBq7XsY=;
	b=Tyc2CM5hgWIq3f6AU34XKyRXiLygMKCA2iCTb9VmcdR38uKpQ4Mntap8tJ+ISkQT76pf/G
	l94K0bZNi6AllZA3cFW3Ie2EoBmG9vi/wTH8tv0kHISGAJct/nEJ5FRvcVljhMlcOsmrqQ
	wWP2hjLFcryJEqIJf6jmitDcaWovaYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716818086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ffJQ9lsRqvbcsan0P8FZrl2jwHiRvYxA8CCEXBq7XsY=;
	b=q1dF3XHFgMh0HIrCLWKu/pnjaeh/WaGRUfaFeG/sMIJiNo2FZ9PBp8fqHIeWUYHG6CjjK0
	cqwdWOv971zrFxDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Tyc2CM5h;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=q1dF3XHF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716818086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ffJQ9lsRqvbcsan0P8FZrl2jwHiRvYxA8CCEXBq7XsY=;
	b=Tyc2CM5hgWIq3f6AU34XKyRXiLygMKCA2iCTb9VmcdR38uKpQ4Mntap8tJ+ISkQT76pf/G
	l94K0bZNi6AllZA3cFW3Ie2EoBmG9vi/wTH8tv0kHISGAJct/nEJ5FRvcVljhMlcOsmrqQ
	wWP2hjLFcryJEqIJf6jmitDcaWovaYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716818086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ffJQ9lsRqvbcsan0P8FZrl2jwHiRvYxA8CCEXBq7XsY=;
	b=q1dF3XHFgMh0HIrCLWKu/pnjaeh/WaGRUfaFeG/sMIJiNo2FZ9PBp8fqHIeWUYHG6CjjK0
	cqwdWOv971zrFxDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AF5713A56;
	Mon, 27 May 2024 13:54:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I2w+H6WQVGYEFgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 27 May 2024 13:54:45 +0000
Date: Mon, 27 May 2024 15:54:36 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <dhildenb@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
	Vishal Moola <vishal.moola@gmail.com>
Subject: Re: [PATCH] mm/hugetlb: Move vmf_anon_prepare upfront in hugetlb_wp
Message-ID: <ZlSQnLvqIILiayiW@localhost.localdomain>
References: <20240521073446.23185-1-osalvador@suse.de>
 <ZlRKI_tJ2CYhmekw@localhost.localdomain>
 <9f3371fa-0d46-4e93-a00b-0f5cb30b58bb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f3371fa-0d46-4e93-a00b-0f5cb30b58bb@redhat.com>
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F37091FDBC
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,linux.dev,gmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]

On Mon, May 27, 2024 at 03:17:01PM +0200, David Hildenbrand wrote:
> gup_must_unshare() without a VMA is only used for GUP-fast. Before
> triggering a page fault we always fallback to GUP-slow first, where we have
> a VMA.

I see, thanks for explaining!

> IMHO we better not make assumptions that hugetlb_wp() will always already
> have an anon VMA.

Fine by me, I just wanted to have the picture more clear, because I could not
see how we could end up in such situation, but better be safe and than sorry.

@Andrew: This fix is to avoid an issue like [1], but for hugetlb_wp().

[1] https://lore.kernel.org/linux-mm/000000000000daf1e10615e64dcb@google.com/T/
 

-- 
Oscar Salvador
SUSE Labs

