Return-Path: <linux-kernel+bounces-250410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 048CC92F788
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1711C217CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36685143758;
	Fri, 12 Jul 2024 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q9wCDxXz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MKb7AGa0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q9wCDxXz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MKb7AGa0"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA392E3E5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775146; cv=none; b=jMM5VWZMXWPRtzSCcROb0D0ybEd1zZGyFOywjqP7nLIYNGTdP3GuEV0mtyiBnLnXjUP747JqDNwSU/fa62jCSw95fkNPZle6qo+98LZBN5SEFUNQ1jySNFV/8+qp4V6oraRWEa2cmaG8cH2KvSc5ll8F2HuwxcyITucoNl8mws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775146; c=relaxed/simple;
	bh=n9zCnby7RStLsYiaqLC7s2b1p5UbHmaaIR2SSzrVCaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrAnkSS0qYlfD5HBHIf0E/dZ9Py/GSzutdm637PrVUHWqe8Kdl1CQ4jiZ3lT/ic6/aXcgaagqPn39io8vaqJcvMFy1tLx79Dq45W9cvUDsZ73BUxwyeCWKQ8t06kFxuhtOnL6Co9RzesCeoaKmxLMIUgaN31v1+klzBD5WaAmHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q9wCDxXz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MKb7AGa0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q9wCDxXz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MKb7AGa0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 110681FB72;
	Fri, 12 Jul 2024 09:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720775143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KHPKYhyfY8y0bbRj9icGAe1iV34Xb9Ze5OLkT5Fpfys=;
	b=Q9wCDxXzSlQNBycICSy9ZwNIGEdp9BX9rVWK18hsV9BuJJNJr92v+Q2mozzdorbpgaTWMi
	qnMD40Aulb5C6kZqRdTelB1b18JQ+/kkOhDwIwGRIJlyf1pS2HgaFiemUd6Y2DBzgEfUyk
	glgL7ChQVSOTmdcKcfBETjbhNKA1kUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720775143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KHPKYhyfY8y0bbRj9icGAe1iV34Xb9Ze5OLkT5Fpfys=;
	b=MKb7AGa0OjPupFeWs4IXmlqLYSlM0zJ0SSjeDrn5vvUQvPlUbicpV1i6jiKHgnH5ezHjn2
	p1rs2R5/wVome8Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Q9wCDxXz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MKb7AGa0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720775143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KHPKYhyfY8y0bbRj9icGAe1iV34Xb9Ze5OLkT5Fpfys=;
	b=Q9wCDxXzSlQNBycICSy9ZwNIGEdp9BX9rVWK18hsV9BuJJNJr92v+Q2mozzdorbpgaTWMi
	qnMD40Aulb5C6kZqRdTelB1b18JQ+/kkOhDwIwGRIJlyf1pS2HgaFiemUd6Y2DBzgEfUyk
	glgL7ChQVSOTmdcKcfBETjbhNKA1kUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720775143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KHPKYhyfY8y0bbRj9icGAe1iV34Xb9Ze5OLkT5Fpfys=;
	b=MKb7AGa0OjPupFeWs4IXmlqLYSlM0zJ0SSjeDrn5vvUQvPlUbicpV1i6jiKHgnH5ezHjn2
	p1rs2R5/wVome8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 229AF13686;
	Fri, 12 Jul 2024 09:05:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y6A7BObxkGbPDwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 12 Jul 2024 09:05:42 +0000
Date: Fri, 12 Jul 2024 11:05:32 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Michal Hocko <mhocko@suse.com>, Donet Tom <donettom@linux.ibm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH 2/8] arch/s390: Teach
 arch_get_unmapped_area{_topdown} to handle hugetlb mappings
Message-ID: <ZpDx3CWGzvZ02qFa@localhost.localdomain>
References: <20240710105042.30165-1-osalvador@suse.de>
 <20240710105042.30165-3-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710105042.30165-3-osalvador@suse.de>
X-Rspamd-Queue-Id: 110681FB72
X-Spamd-Result: default: False [-1.51 / 50.00];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Wed, Jul 10, 2024 at 12:50:36PM +0200, Oscar Salvador wrote:
> We want to stop special casing hugetlb mappings and make them go
> through generic channels, so teach arch_get_unmapped_area{_topdown}
> to handle those.
> s390 specific hugetlb function does not set info.align_offset, so do
> the same here for compatibility.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

I could finally grab a s390 machine and I realized I made some silly
syntax mistakes here.
I am running some tests on s390 to make sure all is smooth.


-- 
Oscar Salvador
SUSE Labs

