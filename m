Return-Path: <linux-kernel+bounces-533347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CA1A458CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056A9167FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A4420CCEA;
	Wed, 26 Feb 2025 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f2LfHC0g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="67J56Lmy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f2LfHC0g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="67J56Lmy"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764E51E1DEA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559795; cv=none; b=Q6N4Kp8axZ6uEnbrKSwdt2N7G7nHh2yllKU9kvTZP3iOCScEY/zMt7h7zXMcuh+FdPuTp+5Wkimvkm2n1FVgGAKA/hNWjPMsWz0IF2YvvnJ3upXoNDpQQ92kvMd5nsiOX2geqQEOMFkj6+wWHM8fyy0kgqJV1N1hZkdy2iVydb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559795; c=relaxed/simple;
	bh=Oy3A1jiV57G49nbTlvzYkdMU0xorWZZ7LJcXKR+Gs8k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PH9ePJ+BvsRgW0LxkXZCuAFJvpO7EU08SYW+5bG7usxrhqFim/y9LUICL7sSQlVGt9LrjD7DgP4v1B0oH9FzHmW0TuefKHD0+Lfv1c+3vNVdUtuTxxXNbbSNvRQunvvTpYkUxUtQgQiuN+P3P4fwnOeprWkIQYyvL2UrkNaxl/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f2LfHC0g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=67J56Lmy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f2LfHC0g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=67J56Lmy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 946881F387;
	Wed, 26 Feb 2025 08:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740559790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HOm8FZkDzDs8UwSLwsHkts4ETafNqMowoqvHKC3w7k=;
	b=f2LfHC0g+4p4HoZOzDvLFeK+PFqkgn7XbFwr096DPY2M6Wzpwl+QJT9m1PGrgbi/E8B1ET
	8VmnNqJqwvl06W4dxXS/jZW9KLuoyazLhk2xAbccSPtdgnkcNQJzXwZCZsyASwTUNCWLQc
	tZWEfIHWcoHgg2uVZBMSA6Bp+d686Tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740559790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HOm8FZkDzDs8UwSLwsHkts4ETafNqMowoqvHKC3w7k=;
	b=67J56LmyuyX48ZnIxubo6rt5HwTClaKdwkXGvRP19tka77Ai9da12/p5RBgvqFxTkMUWHK
	jxO70BWuDbsCdnAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740559790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HOm8FZkDzDs8UwSLwsHkts4ETafNqMowoqvHKC3w7k=;
	b=f2LfHC0g+4p4HoZOzDvLFeK+PFqkgn7XbFwr096DPY2M6Wzpwl+QJT9m1PGrgbi/E8B1ET
	8VmnNqJqwvl06W4dxXS/jZW9KLuoyazLhk2xAbccSPtdgnkcNQJzXwZCZsyASwTUNCWLQc
	tZWEfIHWcoHgg2uVZBMSA6Bp+d686Tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740559790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HOm8FZkDzDs8UwSLwsHkts4ETafNqMowoqvHKC3w7k=;
	b=67J56LmyuyX48ZnIxubo6rt5HwTClaKdwkXGvRP19tka77Ai9da12/p5RBgvqFxTkMUWHK
	jxO70BWuDbsCdnAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 848C01377F;
	Wed, 26 Feb 2025 08:49:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MtDZH67Vvmf3TQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 26 Feb 2025 08:49:50 +0000
Message-ID: <9b21789c-86a5-428e-baee-004e22b40b65@suse.cz>
Date: Wed, 26 Feb 2025 09:51:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm: page_alloc: group fallback functions together
From: Vlastimil Babka <vbabka@suse.cz>
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Jackman <jackmanb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250225001023.1494422-1-hannes@cmpxchg.org>
 <20250225001023.1494422-4-hannes@cmpxchg.org>
 <e6b42857-6be5-48c3-a25e-f44fef2225d4@suse.cz>
Content-Language: en-US
In-Reply-To: <e6b42857-6be5-48c3-a25e-f44fef2225d4@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 



On 2/25/25 12:02 PM, Vlastimil Babka wrote:
> On 2/25/25 01:08, Johannes Weiner wrote:
>> The way the fallback rules are spread out makes them hard to
>> follow. Move the functions next to each other at least.
>>
>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Vlastimil Babka <vbabka@suse.cz>

Sorry, meant:

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>



