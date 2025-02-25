Return-Path: <linux-kernel+bounces-531105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7619CA43C39
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88DE27AC8C3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4842267715;
	Tue, 25 Feb 2025 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sE5Qd+9i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ap9KqqLL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sE5Qd+9i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ap9KqqLL"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56343267AE7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480607; cv=none; b=RB+3t954qIGcPOALxo5zOuHFj6xetYh++skoNmlYeOPgZjrofZOE57IkDhw3oLCZY0zXriRFsD+eS9R5XFet+DOsapTGrnaTstvzixxlmdq58p6AEJHafVyPSyNGxZmEKACIysOdE90hkY2vV3gn6A9ofD/vK2NKVSjD9GKX9Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480607; c=relaxed/simple;
	bh=Q+MYPajuZg8lm6VFX9d3C3CvkMe6EYpJYWUejKN3rsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9H7QEBMrSdOhJevwGcSngje+IDcJdrOOlS2pO4a64SMB1W8z0qmirDX7hRmap4lQDnfG1K2S6brhSAoGH0/RHW1GxsEBQGL3fC7KyMJBszldbOCL5J5g827o52Te/PeK8APzp7l68F6o0o9mYRaOzTDQrWVjA8y9o5uO8sVAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sE5Qd+9i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ap9KqqLL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sE5Qd+9i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ap9KqqLL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F9421F44F;
	Tue, 25 Feb 2025 10:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740480603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ooEgPRdbCn4oVVE3Zoo25QbzovMbvcZ86trl0Eo+lH8=;
	b=sE5Qd+9ip3wwWavLaelZQr22rsvfTRWHg05T8fzq3wNLEna4u3/VNx+N0i8eS0nQaYmRBs
	L9J1FLuo5VC3yJjCdHhDwGDNOn49it4/H8qQAcCubFEIZraMt7LWO+V9ftPrEI+PhvcMEX
	yMIDgkbBTw5wqzjEeQF3tfbym7eoou8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740480603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ooEgPRdbCn4oVVE3Zoo25QbzovMbvcZ86trl0Eo+lH8=;
	b=ap9KqqLL7gHGFcC/Hhy8OSoIomThK7gE8ibZ61OENzjDvok3+07FrNWWZf7UVGLA9cwE0G
	we0oJMH/3TzXg8Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740480603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ooEgPRdbCn4oVVE3Zoo25QbzovMbvcZ86trl0Eo+lH8=;
	b=sE5Qd+9ip3wwWavLaelZQr22rsvfTRWHg05T8fzq3wNLEna4u3/VNx+N0i8eS0nQaYmRBs
	L9J1FLuo5VC3yJjCdHhDwGDNOn49it4/H8qQAcCubFEIZraMt7LWO+V9ftPrEI+PhvcMEX
	yMIDgkbBTw5wqzjEeQF3tfbym7eoou8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740480603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ooEgPRdbCn4oVVE3Zoo25QbzovMbvcZ86trl0Eo+lH8=;
	b=ap9KqqLL7gHGFcC/Hhy8OSoIomThK7gE8ibZ61OENzjDvok3+07FrNWWZf7UVGLA9cwE0G
	we0oJMH/3TzXg8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EEFA13888;
	Tue, 25 Feb 2025 10:50:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KsoqB1ugvWfPLwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 25 Feb 2025 10:50:03 +0000
Message-ID: <68ac1af7-988b-42c6-8249-8949eb7fd986@suse.cz>
Date: Tue, 25 Feb 2025 11:50:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm: page_alloc: don't steal single pages from biggest
 buddy
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Jackman <jackmanb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250225001023.1494422-1-hannes@cmpxchg.org>
 <20250225001023.1494422-2-hannes@cmpxchg.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250225001023.1494422-2-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 2/25/25 01:08, Johannes Weiner wrote:
> The fallback code searches for the biggest buddy first in an attempt
> to steal the whole block and encourage type grouping down the line.
> 
> The approach used to be this:
> 
> - Non-movable requests will split the largest buddy and steal the
>   remainder. This splits up contiguity, but it allows subsequent
>   requests of this type to fall back into adjacent space.
> 
> - Movable requests go and look for the smallest buddy instead. The
>   thinking is that movable requests can be compacted, so grouping is
>   less important than retaining contiguity.
> 
> c0cd6f557b90 ("mm: page_alloc: fix freelist movement during block
> conversion") enforces freelist type hygiene, which restricts stealing
> to either claiming the whole block or just taking the requested chunk;
> no additional pages or buddy remainders can be stolen any more.
> 
> The patch mishandled when to switch to finding the smallest buddy in
> that new reality. As a result, it may steal the exact request size,
> but from the biggest buddy. This causes fracturing for no good reason.
> 
> Fix this by committing to the new behavior: either steal the whole
> block, or fall back to the smallest buddy.
> 
> Remove single-page stealing from steal_suitable_fallback(). Rename it
> to try_to_steal_block() to make the intentions clear. If this fails,
> always fall back to the smallest buddy.
> 
> The following is from 4 runs of mmtest's thpchallenge. "Pollute" is
> single page fallback, "steal" is conversion of a partially used block.
> The numbers for free block conversions (omitted) are comparable.
> 
> 				     vanilla	      patched
> 
> @pollute[unmovable from reclaimable]:	  27		  106
> @pollute[unmovable from movable]:	  82		   46
> @pollute[reclaimable from unmovable]:	 256		   83
> @pollute[reclaimable from movable]:	  46		    8
> @pollute[movable from unmovable]:	4841		  868
> @pollute[movable from reclaimable]:	5278		12568
> 
> @steal[unmovable from reclaimable]:	  11		   12
> @steal[unmovable from movable]:		 113		   49
> @steal[reclaimable from unmovable]:	  19		   34
> @steal[reclaimable from movable]:	  47		   21
> @steal[movable from unmovable]:		 250		  183
> @steal[movable from reclaimable]:	  81		   93
> 
> The allocator appears to do a better job at keeping stealing and
> polluting to the first fallback preference. As a result, the numbers
> for "from movable" - the least preferred fallback option, and most
> detrimental to compactability - are down across the board.
> 
> Fixes: c0cd6f557b90 ("mm: page_alloc: fix freelist movement during block conversion")
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!


