Return-Path: <linux-kernel+bounces-556408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A61FA5C702
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D5517DDBE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DCB1A5BA4;
	Tue, 11 Mar 2025 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p9QCQp8g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y1TNnQtg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p9QCQp8g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y1TNnQtg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90225EF95
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706825; cv=none; b=gt3X+SJNg/vLSJVyBrctw4/+2IsZEGbHALV1Ch9dyJmmUfQjUbYQigzia/38pgdrPXWYaCM+H4Tgqxm0H/lRj4TEVUYXeofzzuNTcPDJb6Y1V7Kp031FF5pqYxkg0sN7PS3UpJBM6kWF32DG94XqhzaWuVd/MaSoIbbmDuaPLLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706825; c=relaxed/simple;
	bh=D747M/be/Ol3AbU41YWWPkC1CihYGNR9PRPRoEEYJXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkCwRnf5KSM0m6jcIu6N1db9DRQAowFCvSALEw6NeoT8StSBcTiNCRCdRFVX3JwA0DVLRniEg+IFNqRlikvZ91ceBO4LIBkza2G7ZJSttVOzfsRv7DPAI/uQOBJuJe8G//40vuobmZwYrUGByYWfatTsqLR2GEAe8MRmJOXHc0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p9QCQp8g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y1TNnQtg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p9QCQp8g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y1TNnQtg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40E731F388;
	Tue, 11 Mar 2025 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741706822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQOXzr2En1dG/w+YyDGi7QuOUnx3tihKizQWRPD23Is=;
	b=p9QCQp8gefEdNVn1qmYxVhu5wpz/vAit7pXv+TVMcMcDGjQXmIHMs4qh504FLK3iCmEU/S
	GUhhAQpuhs3rzBrXK7G68oq+Z85ItR+EPYTE5Me7KkPwcchme8ChMTmJEQPNaP8gGMgRk0
	VWsuOLjPgkJzk0LtLL1SsT2l+706iwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741706822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQOXzr2En1dG/w+YyDGi7QuOUnx3tihKizQWRPD23Is=;
	b=y1TNnQtgN2Q9sdx3uHCYihq4mS+SOEdRYEFZLUNzU0ExjkWVv/e9o+EOlguVWxEjvaMepf
	B/tU3zmqVrSJnoCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741706822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQOXzr2En1dG/w+YyDGi7QuOUnx3tihKizQWRPD23Is=;
	b=p9QCQp8gefEdNVn1qmYxVhu5wpz/vAit7pXv+TVMcMcDGjQXmIHMs4qh504FLK3iCmEU/S
	GUhhAQpuhs3rzBrXK7G68oq+Z85ItR+EPYTE5Me7KkPwcchme8ChMTmJEQPNaP8gGMgRk0
	VWsuOLjPgkJzk0LtLL1SsT2l+706iwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741706822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQOXzr2En1dG/w+YyDGi7QuOUnx3tihKizQWRPD23Is=;
	b=y1TNnQtgN2Q9sdx3uHCYihq4mS+SOEdRYEFZLUNzU0ExjkWVv/e9o+EOlguVWxEjvaMepf
	B/tU3zmqVrSJnoCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5B76134A0;
	Tue, 11 Mar 2025 15:27:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zFKrKUVW0GeQbAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 11 Mar 2025 15:27:01 +0000
Date: Tue, 11 Mar 2025 16:26:56 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Gavin Shan <gshan@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, akpm@linux-foundation.org,
	shan.gavin@gmail.com
Subject: Re: [PATCH v2 1/3] mm/sparse: Expose for_each_present_section_nr()
Message-ID: <Z9BWQO0U_LSqdTCP@localhost.localdomain>
References: <20250311004657.82985-1-gshan@redhat.com>
 <20250311004657.82985-2-gshan@redhat.com>
 <e36bfe8a-fbf6-46b4-9f8f-c44b7352583e@redhat.com>
 <cb351bda-06bd-44d0-907d-9baee76c0823@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb351bda-06bd-44d0-907d-9baee76c0823@redhat.com>
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kvack.org,vger.kernel.org,linuxfoundation.org,kernel.org,linux-foundation.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Mar 11, 2025 at 09:52:09PM +1000, Gavin Shan wrote:
> Yes, but this series has been queued by Andrew Morton. Andrew, would
> you mind to squash PATCH[3/1] to PATCH[2/3]? Or I can respin to do that
> in v3.

Since it is in mm-unstable, maybe just resend a v3 with all acks + this
squashed and be done with it.


-- 
Oscar Salvador
SUSE Labs

