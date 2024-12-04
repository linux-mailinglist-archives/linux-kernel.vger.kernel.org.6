Return-Path: <linux-kernel+bounces-430824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D109E3643
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DCA4B2D154
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B271A3A95;
	Wed,  4 Dec 2024 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ee1l/Ah+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zTnU/GM2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ee1l/Ah+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zTnU/GM2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451F419D886
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733302805; cv=none; b=pM7lYExBOnGwcZVUGJa73fvXFj72m7hDnZNoWpbO3JEbS+jSHlnMU6IzzZW75JvskQQmS6hEmLUPoxBiG6hziw6QODEWMiA/5Udtbts8JJMLHMLsvn2+gOdfu53+4t8zNa9rIfL7q6WGDuXRZeHAbfTwMEeuXIP3M/5WJp9nZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733302805; c=relaxed/simple;
	bh=Qx80hxquxZr3ftNpYm5KabLhAsBZavcEMUvEulyetSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1tT5JiLK4sODsdU8ripiMOnXHTGWJ9R9dySEZS4837IsWCmpjV/nu15w9ZhrAKV2cpXZlCUkhiZp/fwVrFybP3pqEAAURQ02u5NqjN/HLVfaMndsAyklObqffKqU8nvzbwG8KAhnc0HCRpxFAb0vR5ys93JbKG9AGcuJaXG5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ee1l/Ah+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zTnU/GM2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ee1l/Ah+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zTnU/GM2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 76CC52115F;
	Wed,  4 Dec 2024 09:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733302801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dpM2g75VsCwF4ni06a0Pzx4MSEcEE2LipOKSwUbh+bo=;
	b=Ee1l/Ah+Pm5rKdmO+heBpdxK+OnoQ1Y6vsDu/7UdtyhbeTig6IMM+ir6esMbt7WsVye4Dj
	TYUsezH0zs8DaQMlZByRLKBlew8vVBji8ZWQWGso6Ka1ti1Jh981Qda3YuzLSycRLRrda7
	8BCgN9p+ZU/U5Pjl0WZ6wKu9G+1ZGmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733302801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dpM2g75VsCwF4ni06a0Pzx4MSEcEE2LipOKSwUbh+bo=;
	b=zTnU/GM2sKznNNBKjO8JuBYwiqqwB3w6yaFytNWcjcrWE9hbjOk6QGtYs5hxmvQTfY4zO3
	8vHnKuloPcTIbgBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733302801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dpM2g75VsCwF4ni06a0Pzx4MSEcEE2LipOKSwUbh+bo=;
	b=Ee1l/Ah+Pm5rKdmO+heBpdxK+OnoQ1Y6vsDu/7UdtyhbeTig6IMM+ir6esMbt7WsVye4Dj
	TYUsezH0zs8DaQMlZByRLKBlew8vVBji8ZWQWGso6Ka1ti1Jh981Qda3YuzLSycRLRrda7
	8BCgN9p+ZU/U5Pjl0WZ6wKu9G+1ZGmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733302801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dpM2g75VsCwF4ni06a0Pzx4MSEcEE2LipOKSwUbh+bo=;
	b=zTnU/GM2sKznNNBKjO8JuBYwiqqwB3w6yaFytNWcjcrWE9hbjOk6QGtYs5hxmvQTfY4zO3
	8vHnKuloPcTIbgBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5389139C2;
	Wed,  4 Dec 2024 09:00:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HKtXLRAaUGfLYwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 04 Dec 2024 09:00:00 +0000
Date: Wed, 4 Dec 2024 09:59:55 +0100
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH RESEND v2 4/6] mm/page_alloc: sort out the
 alloc_contig_range() gfp flags mess
Message-ID: <Z1AaC5Hj2RV_5FDD@localhost.localdomain>
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-5-david@redhat.com>
 <feffbbe8-4176-48e8-b503-ef53d7914197@suse.cz>
 <96c92857-4850-4f85-9474-ac193c5ea48c@redhat.com>
 <04c1d28e-bbea-4499-9a6d-770f9ca53ba9@suse.cz>
 <d736f1c0-343e-4031-88ba-3b33b73dbeba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d736f1c0-343e-4031-88ba-3b33b73dbeba@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,kvack.org,lists.ozlabs.org,linux-foundation.org,nvidia.com,ellerman.id.au,gmail.com,csgroup.eu,kernel.org,linux.ibm.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid]
X-Spam-Score: -8.30
X-Spam-Flag: NO

On Tue, Dec 03, 2024 at 08:19:02PM +0100, David Hildenbrand wrote:
> It was always set using "GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL",
> and I removed the same flag combination in #2 from memory offline code, and
> we do have the exact same thing in do_migrate_range() in
> mm/memory_hotplug.c.
> 
> We should investigate if__GFP_HARDWALL is the right thing to use here, and
> if we can get rid of that by switching to GFP_KERNEL in all these places.

Why would not we want __GFP_HARDWALL set?
Without it, we could potentially migrate the page to a node which is not
part of the cpuset of the task that originally allocated it, thus violating the
policy? Is not that a problem?
 

-- 
Oscar Salvador
SUSE Labs

