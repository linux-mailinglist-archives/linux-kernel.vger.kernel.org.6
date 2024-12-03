Return-Path: <linux-kernel+bounces-429749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963CE9E22CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC022867CB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228E41F76B9;
	Tue,  3 Dec 2024 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XAEk2pKN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hL0q6hs9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XAEk2pKN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hL0q6hs9"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB2C1F76AD
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239725; cv=none; b=XLNPko1Cdg6do69kB/RJmMsDM9ejm171IYNh1p9didMhaHoMfXmYcQUBFAQLpIKiBvD3CZzhUN0u3gU/uIK3po2QTQCtqOG6lHCgcRHxfJBD5nDhTLxvRVBvHx4eSPgpgXgfSnlGOu03GcDYDaPvJgTcxPXCcGLxQfdRXDAaaso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239725; c=relaxed/simple;
	bh=TVuEAODP+azXyWX6un7ZCvhCdc704xWL0Ga4vAX2i3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJ7/jMRrKDCK4h0lZ9EDxsjjUNJhICUPFHHP01IO5XUoSj1TG4BfLw2ca9b+e88N/zwv2d98uYZzRAoHZOd0pL7B4ZTWMAqodsqXe9pjNzpOX0E/zdlduHiXpTqner77KtML9VnIFYB2GyFfnhy3b0f9tqL5AR7WNlTTmMMuqdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XAEk2pKN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hL0q6hs9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XAEk2pKN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hL0q6hs9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 932DB1F445;
	Tue,  3 Dec 2024 15:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733239721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DdefS+7y1zYZ+8Ncfrn6ijUx/CqLKtjsV+1aqpjQ8F8=;
	b=XAEk2pKN78oL/pIhzHC/tYeozuVf3WBPlyYbju1kMtaiGje6htK3jeDDv0VduqEZqGtnkK
	WU4pNqm43lWkOD/kPV8Ji3t6qC6qgB+G+GhSGP19l+y44w+61KYwbHmIBVJ5lUVoiJrE0+
	3D5bxer9+AgVyMXO24l+CdqyBdVSXQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733239721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DdefS+7y1zYZ+8Ncfrn6ijUx/CqLKtjsV+1aqpjQ8F8=;
	b=hL0q6hs9ToGpJ6OcoQBDs2DWj9KKvT9wX1OZaFKOMzwTKnGbfHlCN2FDuc0QDMhie5Yjoy
	zkt9+5ikgaRNPnDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XAEk2pKN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hL0q6hs9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733239721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DdefS+7y1zYZ+8Ncfrn6ijUx/CqLKtjsV+1aqpjQ8F8=;
	b=XAEk2pKN78oL/pIhzHC/tYeozuVf3WBPlyYbju1kMtaiGje6htK3jeDDv0VduqEZqGtnkK
	WU4pNqm43lWkOD/kPV8Ji3t6qC6qgB+G+GhSGP19l+y44w+61KYwbHmIBVJ5lUVoiJrE0+
	3D5bxer9+AgVyMXO24l+CdqyBdVSXQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733239721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DdefS+7y1zYZ+8Ncfrn6ijUx/CqLKtjsV+1aqpjQ8F8=;
	b=hL0q6hs9ToGpJ6OcoQBDs2DWj9KKvT9wX1OZaFKOMzwTKnGbfHlCN2FDuc0QDMhie5Yjoy
	zkt9+5ikgaRNPnDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4558913A15;
	Tue,  3 Dec 2024 15:28:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gUr8DakjT2cFSAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 03 Dec 2024 15:28:41 +0000
Date: Tue, 3 Dec 2024 16:28:39 +0100
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND v1] mm/memory_hotplug: move
 debug_pagealloc_map_pages() into online_pages_range()
Message-ID: <Z08jp0KSh6Hw_eJt@localhost.localdomain>
References: <20241203102050.223318-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203102050.223318-1-david@redhat.com>
X-Rspamd-Queue-Id: 932DB1F445
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Dec 03, 2024 at 11:20:50AM +0100, David Hildenbrand wrote:
> In the near future, we want to have a single way to handover PageOffline
> pages to the buddy, whereby they could have:
> 
> (a) Never been exposed to the buddy before: kept PageOffline when onlining
>     the memory block.
> (b) Been allocated from the buddy, for example using
>     alloc_contig_range() to then be set PageOffline,
> 
> Let's start by making generic_online_page() less special compared to

This got me confused for a moment. I'd have said "making
__free_pages_core" less special? As that is where we were calling 
debug_pagealloc_map_pages() if the context  on the context.

> ordinary page freeing (e.g., free_contig_range()), and perform the
> debug_pagealloc_map_pages() call unconditionally, even when the online
> callback might decide to keep the pages offline.
> 
> All pages are already initialized with PageOffline, so nobody touches
> them either way.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

