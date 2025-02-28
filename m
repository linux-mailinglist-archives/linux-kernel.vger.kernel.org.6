Return-Path: <linux-kernel+bounces-538235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA47A49628
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8CF188A18F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E7625A341;
	Fri, 28 Feb 2025 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D7xOMS7u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rzUugGZN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cTSLYIv8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rSTOXzj6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F3B25A32B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736765; cv=none; b=ZSVW4BjNWoBHuwcNhASsZjmLKajQFvC7Y7CVnCbXnK/afaT9WDQ/uNR6FV77cCHCGqrtst1YaQLCUH4gxCrUnTuVVMQmekQI9C+CCeJNKAGLClc9GPvqECfUjsdHiU4aM7jrzXS4z6u5ltTV39HXY7tRocJ5ZRXP3ejjq9Q43Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736765; c=relaxed/simple;
	bh=TBKDKAHba6vy4Gu+Okfq348lsxqNrjmdldedIzZQ+LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCSPOSn8aQObRZIiM3C5eh7PE2cTNcDGVeK3guVNFQOy09ySoLRaKzQw2nHxisqtpPCQoax3mno785w8YBAHhwbsirTXfx+J34YYO1/NDLDva8wJ20BRg4hl3Roen6rUUi/deqogUQKpE+pz7/Ihz1xhNnzgQ5CWiBCW5bMlruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D7xOMS7u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rzUugGZN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cTSLYIv8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rSTOXzj6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71E7E2116C;
	Fri, 28 Feb 2025 09:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740736761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s12o1+CXrrYel8uzxeTgDHxzQL0Te2TUvuy+8vHWHvw=;
	b=D7xOMS7ukH/cI+58o34ihd1euOVdChw0UmmNoTmOhLlusbe19k3zaSCFTTLrjdUm5/Amoz
	75UvFC6gJDM/jCrL825VD2GVfD1ilDeUHgF5tUK1CgcHwQgsH24udQKlgwv00LmaVMGTAO
	BFIX7iXGq9gTVstP6OiGsO5Y5YojwxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740736761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s12o1+CXrrYel8uzxeTgDHxzQL0Te2TUvuy+8vHWHvw=;
	b=rzUugGZN4MZjETVS3RYrTOrlojEnmO2c/tK9lOx0V1g1B7Il6gO6FBVKZcpP1avVF3nNla
	nH4tvs6mp3lNY1BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cTSLYIv8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rSTOXzj6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740736760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s12o1+CXrrYel8uzxeTgDHxzQL0Te2TUvuy+8vHWHvw=;
	b=cTSLYIv8dC3/2W5ZzlOb7WFh+EwfO3e9CnNBwy7nyyVaGwVb/mZoPZXkBwrXx2WYY8Vvli
	iqB/62DoFaZ+HLSFZY6+n4H3tUP5zS9kT2RYzTX8KErsMc5qy1p7Tew4xC1LTeRb4b+OOS
	CNJzbm2mgXjYHIBszQ0648Dj1U37OP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740736760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s12o1+CXrrYel8uzxeTgDHxzQL0Te2TUvuy+8vHWHvw=;
	b=rSTOXzj6EMhn5udsT9DpQyLEhUUo8Vjyxq0fynASTHkczBTN7LDiR/OxyLGtB3u9+VRCfk
	pp6+CZMwlia+K3CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57295137AC;
	Fri, 28 Feb 2025 09:59:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eFPsFPiIwWeQWAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 28 Feb 2025 09:59:20 +0000
Message-ID: <13614e0a-4985-42a1-87b2-a57237437a08@suse.cz>
Date: Fri, 28 Feb 2025 10:59:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] mm/page_alloc: Clarify should_claim_block()
 commentary
Content-Language: en-US
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Michal Hocko
 <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry.ahmed@linux.dev>
References: <20250228-clarify-steal-v4-0-cb2ef1a4e610@google.com>
 <20250228-clarify-steal-v4-2-cb2ef1a4e610@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250228-clarify-steal-v4-2-cb2ef1a4e610@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 71E7E2116C
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/28/25 10:52, Brendan Jackman wrote:
> There's lots of text here but it's a little hard to follow, this is an
> attempt to break it up and align its structure more closely with the
> code.
> 
> Reword the top-level function comment to just explain what question the
> function answers from the point of view of the caller.
> 
> Break up the internal logic into different sections that can have their
> own commentary describing why that part of the rationale is present.
> 
> Note the page_group_by_mobility_disabled logic is not explained in the
> commentary, that is outside the scope of this patch...
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> +	/*
> +	 * Unmovable/reclaimable allocations would cause permanent
> +	 * fragmentations if they fell back to allocating from a movable block
> +	 * (polluting it), so we try to claim the whole block regardless of the
> +	 * allocation size. Later movable allocations can always steal from this
> +	 * block, which is less problematic.
> +	 */
> +	if (start_mt == MIGRATE_RECLAIMABLE || start_mt == MIGRATE_UNMOVABLE)
> +		return true;
> +
> +	if (page_group_by_mobility_disabled)
> +		return true;
> +
> +	/*
> +	 * Movable pages won't cause permanent fragmentation, so when you alloc

s/you/we/ for consistency? I think Andrew can amend locally to avoid resend.

Thanks.

> +	 * small pages, we just need to temporarily steal unmovable or
> +	 * reclaimable pages that are closest to the request size. After a
> +	 * while, memory compaction may occur to form large contiguous pages,
> +	 * and the next movable allocation may not need to steal.
> +	 */
>  	return false;
>  }
>  
> 


