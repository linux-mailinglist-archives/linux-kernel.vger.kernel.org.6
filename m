Return-Path: <linux-kernel+bounces-436912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1539E8C8A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE412810E6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FA1214A64;
	Mon,  9 Dec 2024 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BF4ro7uk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NBTp1aiV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aAcutK/K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1QSTWCns"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0050915573D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730451; cv=none; b=f7xmUJ5DhTDhdIYR2j6w2fCVO21fJSbMVBtNfmzDRvt9mcKt7j4B3YqsxoMzTGrZJ1WPIpSk8mWWqG14Cm/b7Ulb/I//TM1DtTVgscKrvI3fqt0ScWCXJ9AMuHuwpGlnS8eqmSEyU1Iz/XeswcrNvde+MTJyvoqBERNT2yODjd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730451; c=relaxed/simple;
	bh=ybNjmwsTZW60QPnL1CVj8bpB4Fsm9qhIjPGLk6946Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9ZhZe7WiSVaJ/SCoVgVFAFmfPzwf5u7EP6VNQy63Dn8Q+JGhlIpCrgDTpPZU2zuWB/vgTJxc7iMkxhlaTAr3VWKazOODTSJagNb2ZMkRYRsEx0ekGT0qHIjK3PvcT9/iAyKkTAb+A3/FaVYlBKVZQGyIu9l0+LV126UbUHyPGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BF4ro7uk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NBTp1aiV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aAcutK/K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1QSTWCns; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1DDDE1F456;
	Mon,  9 Dec 2024 07:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733730447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xg4P7OO1TALA4m7z2IIjP48bp55d+w66lLv0UwH+feE=;
	b=BF4ro7uksvs9xuqmOjILtL+cFVF5I14LX94r1QuzzUd2q5D1bYv4A2VOuZrqv0J3XWvoG+
	9UO4mGaVA8Tp1u+Ka32c6eHyjcDqPnpir+DPpk0pDaPsWJO6SCCTIqaS6hNl78zTnMd+mx
	BnY/A+92Wt6YU7xPtnFelawMk6fJGXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733730447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xg4P7OO1TALA4m7z2IIjP48bp55d+w66lLv0UwH+feE=;
	b=NBTp1aiV5f3vta48TBzAvgjTBpD8bZtq9IadwyaG58nRbeeEIIIZHfJayBKAKFW130kp9q
	DoJ90SudQb31q0CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="aAcutK/K";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1QSTWCns
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733730446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xg4P7OO1TALA4m7z2IIjP48bp55d+w66lLv0UwH+feE=;
	b=aAcutK/KygNnacvTpoDgeRQL8Mdh5xIh/LePTGK5KjZrOAIYNeSCvo0VWAY5DRafZDG4vW
	QbAIu7i2M0U54yH27kpHiMD/WlylI/JtMPN2xBap2aryOi8pyXNKDlXYUuz14dz39dgeto
	zG6k/k0JuF+o85heDc+L5ZjoPlCfIq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733730446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xg4P7OO1TALA4m7z2IIjP48bp55d+w66lLv0UwH+feE=;
	b=1QSTWCnsmssl1Nt1jg1Bn9XiJkFRGR2K+7FQQiSZq73hv4i/PqoBTKi5cSNiJvfuNXJamy
	XWG5nNHjm/JeaODQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0D7E138D2;
	Mon,  9 Dec 2024 07:47:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G1YQJI2gVmfkfQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 09 Dec 2024 07:47:25 +0000
Date: Mon, 9 Dec 2024 08:47:24 +0100
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v1 1/2] mm/page_alloc: don't use __GFP_HARDWALL when
 migrating pages via alloc_contig*()
Message-ID: <Z1agjG29hU__jUD_@localhost.localdomain>
References: <20241205085217.2086353-1-david@redhat.com>
 <20241205085217.2086353-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205085217.2086353-2-david@redhat.com>
X-Rspamd-Queue-Id: 1DDDE1F456
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Thu, Dec 05, 2024 at 09:52:16AM +0100, David Hildenbrand wrote:
> We'll migrate pages allocated by other contexts; respecting the cpuset of
> the alloc_contig*() caller when allocating a migration target does not
> make sense.
> 
> Drop the __GFP_HARDWALL.
> 
> Note that in an ideal world, migration code could figure out the cpuset
> of the original context and take that into consideration.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

