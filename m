Return-Path: <linux-kernel+bounces-570969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D66FA6B728
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6FF3AEC2E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8381EFF99;
	Fri, 21 Mar 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3aW0Ojgt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CKiki4sm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3aW0Ojgt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CKiki4sm"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2D7374EA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549002; cv=none; b=leJlcVBkbVmpAxOcdBtrRJmabpMDsST2yamjSNGd97DMcWxEtJRdDZGaAfyyIi09BKgvP+YDmcsL17012hBNVq0TQL7N/6mA7MfySeQWlX2pu8L9u0I0q+J1W+pqRMOGPQwfvGrNgMozcBBGiRUN19zc1zravA2KO3M1WapdKO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549002; c=relaxed/simple;
	bh=Y6HmI47x48EcHtbHmdLlp++5iq7QADg1SdJ6wYALaqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwRhBqS+EHFHJTHTwIiMcWPIglF34m+dLNLrS1sVgutwAXzVhCiDGfrHP9xWWDUV16o9KwSHF8Lj3cAB/AFBE4dIspnD3uH31wCBcY0NXp7Ps6nsw7dglqEGNwd4lRAbnIY68ZOTA+mjRHqnRdc0d43zi56zS6wfvDkPCGiGeWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3aW0Ojgt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CKiki4sm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3aW0Ojgt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CKiki4sm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9ED561F811;
	Fri, 21 Mar 2025 09:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742548998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0ekydIUL19bBUVwdBrjmogv64mi7OWGmORGaBoX/cc=;
	b=3aW0Ojgt59S9vR79L7I6adY7rJdSDEytImCpUkfnOjlqNTCWhf9qrDwHCpGwVdAXZdIi0k
	hRdvPet+CeENyhmu57WBbArXHxkEm2x2fLZQzOUPgTQ6GA0JdjtijZImpeLMWp5281werZ
	sFiFflpf3ZuQptmMzGdHqQlDUkyeAHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742548998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0ekydIUL19bBUVwdBrjmogv64mi7OWGmORGaBoX/cc=;
	b=CKiki4smZ7unIOkS+/kyWtzKrvOhY8tH7kXjCGJDuOOOP8k69tXREdLaGcziHwObgAteyg
	PJiyI72dKSUws8AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3aW0Ojgt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CKiki4sm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742548998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0ekydIUL19bBUVwdBrjmogv64mi7OWGmORGaBoX/cc=;
	b=3aW0Ojgt59S9vR79L7I6adY7rJdSDEytImCpUkfnOjlqNTCWhf9qrDwHCpGwVdAXZdIi0k
	hRdvPet+CeENyhmu57WBbArXHxkEm2x2fLZQzOUPgTQ6GA0JdjtijZImpeLMWp5281werZ
	sFiFflpf3ZuQptmMzGdHqQlDUkyeAHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742548998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0ekydIUL19bBUVwdBrjmogv64mi7OWGmORGaBoX/cc=;
	b=CKiki4smZ7unIOkS+/kyWtzKrvOhY8tH7kXjCGJDuOOOP8k69tXREdLaGcziHwObgAteyg
	PJiyI72dKSUws8AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86B48139AA;
	Fri, 21 Mar 2025 09:23:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sOGEIAYw3WeGGAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 21 Mar 2025 09:23:18 +0000
Message-ID: <b9e1269e-e79b-446b-9483-4fdbc1ee42f4@suse.cz>
Date: Fri, 21 Mar 2025 10:23:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix parameter passed to page_mapcount_is_type()
To: Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 willy@infradead.org, david@redhat.com, osalvador@suse.de, gehao@kylinos.cn,
 shan.gavin@gmail.com
References: <20250321053148.1434076-1-gshan@redhat.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250321053148.1434076-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9ED561F811
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,infradead.org,redhat.com,suse.de,kylinos.cn,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 3/21/25 06:31, Gavin Shan wrote:
> Found by code inspection. There are two places where the parameter
> passed to page_mapcount_is_type() is (page->__mapcount), which is
> correct since it should be one more than the value, as explained in
> the comments to page_mapcount_is_type(): (a) page_has_type() in
> page-flags.h (b) __dump_folio() in mm/debug.c

IIUC you are right. Luckily thanks to the the PGTY_mapcount_underflow limit,
this off-by-one error doesn't currently cause visible issues i.e.
misclassifications legitimate mapcount as page type and vice versa, right?
We'd have to have a mapcount underflown severely right to the limit to make
that off-by-one error cross it?

I wonder if a more future-proof solution would be to redefine
page_mapcount_is_type() instead to not subtract. But I'll leave that to willy.

> PATCH[1] fixes the parameter for (a)
> PATCH[2] fixes the parameter for (b)
> 
> Gavin Shan (2):
>   mm: Fix parameter passed to page_mapcount_is_type()
>   mm/debug: Fix parameter passed to page_mapcount_is_type()
> 
>  include/linux/page-flags.h | 2 +-
>  mm/debug.c                 | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 


