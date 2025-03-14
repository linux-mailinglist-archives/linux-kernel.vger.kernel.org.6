Return-Path: <linux-kernel+bounces-561147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BBBA60E12
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1C53AF9F7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8A01C862E;
	Fri, 14 Mar 2025 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nfiXhSs8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y0ImvUuo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nfiXhSs8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y0ImvUuo"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BA01D5AB5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946468; cv=none; b=jSeeXSF1sYHb5UVxKmOJJjUxN6OwfeCJxnt/kha8oe7Rr2Vgb/2AdWTdYJnKR1+oTTjk9Y/ykoh4clwWdfZDeZ4rzKxO83VVUC4zpQToN1qvZ8lo1B+YNr1Bjb2TxXvzrlv11iooMHlhVsp5clH+hVX1sP8eQWrIz/qdx2HXIBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946468; c=relaxed/simple;
	bh=O8VEFLKjScyKXuESkC92ob4pDgox1cwduHGXSJDxOME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrawvkIMRNYNhn2YgiqzuV4HOje3CsiZrlllghDXerpUpOkImLVmhM95pvN3OksYPo5U+klVdd4eoX1oi9IqH4r/jrLMwCUp2kKJKK1Wm/jufhsVEf6dv5UAbiAgRO+KLKPelOqu7hPCf3PcUgE5LRONL1JfNHnlarEXSpdfop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nfiXhSs8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y0ImvUuo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nfiXhSs8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y0ImvUuo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79BF61F452;
	Fri, 14 Mar 2025 10:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741946464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCQu6sjM1S582yyCJbxTmiOkhuaJtxfPp1egfeJdg7A=;
	b=nfiXhSs8QqcWFtFhJf7D+wykhDCezXIq/i9l01vGIF5eQUW18Zu2KtzurwbjiiGKl/IO7u
	4UoQCGTARxnvBoapnocaH/isiVkKNafBFDvdj5sTzvisex773CKrCKdqO6EwoVIIknMvZn
	Nqpy+byaqHa/gyY3DbXzQ7hYE7UTTiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741946464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCQu6sjM1S582yyCJbxTmiOkhuaJtxfPp1egfeJdg7A=;
	b=Y0ImvUuo/tydYTfoKChvKup2I492jKIOwiS049+NRqtQM5+HKPzhaBeZyV9eaDxEpZT3hr
	t81opyqNTMHP1xCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741946464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCQu6sjM1S582yyCJbxTmiOkhuaJtxfPp1egfeJdg7A=;
	b=nfiXhSs8QqcWFtFhJf7D+wykhDCezXIq/i9l01vGIF5eQUW18Zu2KtzurwbjiiGKl/IO7u
	4UoQCGTARxnvBoapnocaH/isiVkKNafBFDvdj5sTzvisex773CKrCKdqO6EwoVIIknMvZn
	Nqpy+byaqHa/gyY3DbXzQ7hYE7UTTiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741946464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCQu6sjM1S582yyCJbxTmiOkhuaJtxfPp1egfeJdg7A=;
	b=Y0ImvUuo/tydYTfoKChvKup2I492jKIOwiS049+NRqtQM5+HKPzhaBeZyV9eaDxEpZT3hr
	t81opyqNTMHP1xCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5ECAF13A31;
	Fri, 14 Mar 2025 10:01:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tl3AFmD+02cUXQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 14 Mar 2025 10:01:04 +0000
Message-ID: <ed253525-f8e9-408f-9ad8-007e133c21f6@suse.cz>
Date: Fri, 14 Mar 2025 11:01:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/10] memcg: introduce memcg_uncharge
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <20250314061511.1308152-4-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250314061511.1308152-4-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,linux.dev:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 3/14/25 07:15, Shakeel Butt wrote:
> At multiple places in memcontrol.c, the memory and memsw page counters
> are being uncharged. This is error-prone. Let's move the functionality
> to a newly introduced memcg_uncharge and call it from all those places.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>


