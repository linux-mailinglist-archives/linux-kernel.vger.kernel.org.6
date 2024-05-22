Return-Path: <linux-kernel+bounces-186704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAD18CC7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E23282E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D77145B14;
	Wed, 22 May 2024 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bqTuloCq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4nprBEog";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bqTuloCq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4nprBEog"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBE155C3E
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716411434; cv=none; b=apVAJAc+0jqbQHi3RBIL2b+pYTy6OrB9reQK7NROsNBWTLeGJDeJYPQbKkO1q5jmKMxzez6RDeD8C1egRiJ21HJI0g+e0vTHvrUj60vCJLwgukKUrdTVyElQ84/aDcg5yeAop4bnjJZycHuXLkaA2+n1RDCbmRvd8hpvBLLhWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716411434; c=relaxed/simple;
	bh=M2j5s0xIcd8XGs8P/xlFsZ6Gfu7HT+TtpmwO1MUK7pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDiQwyQzveGb3IG3G75YWmf0JzHiBKTkjf7vYfQGXX1QY4AZ5c+65CIixWlriLewtKIaQieUlua/eq0YGLw17R8MUlE4k7cS5aBXZsgdGdq+FlTM5JsiUgdG9mD8f1zTXIUTmKF3Ghr1lzK9Ji0o6IEsOqVZ2xhm6udaM7TYBk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bqTuloCq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4nprBEog; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bqTuloCq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4nprBEog; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E64121B47;
	Wed, 22 May 2024 20:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716411430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IwKif20iR1XbQYDKzMIquMFCCIEXEwcy1cEYBeyrq7c=;
	b=bqTuloCqjWVwMGLoVKn1xJfVK5fqub1uLAr4TuMwoq86GAzCimfE0qgSB46AOPm8Vp1Y+r
	+PqPz9W2bvlpq5jgp7NpaTI1xg22I5lRzgaAogwmAzQZNs4eil7MNaDB9XKo+oxiz5ROJv
	glV6FnbSL9WY2SYWackSTM4NAwbrDxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716411430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IwKif20iR1XbQYDKzMIquMFCCIEXEwcy1cEYBeyrq7c=;
	b=4nprBEoggeOIerkHbZ0EK0EWj6Vemv12qvuPLlRbdRBW+DzVGfr2jwSMzK6M/GJeEVHWlO
	vMFbDbVUaJ4sJoBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716411430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IwKif20iR1XbQYDKzMIquMFCCIEXEwcy1cEYBeyrq7c=;
	b=bqTuloCqjWVwMGLoVKn1xJfVK5fqub1uLAr4TuMwoq86GAzCimfE0qgSB46AOPm8Vp1Y+r
	+PqPz9W2bvlpq5jgp7NpaTI1xg22I5lRzgaAogwmAzQZNs4eil7MNaDB9XKo+oxiz5ROJv
	glV6FnbSL9WY2SYWackSTM4NAwbrDxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716411430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IwKif20iR1XbQYDKzMIquMFCCIEXEwcy1cEYBeyrq7c=;
	b=4nprBEoggeOIerkHbZ0EK0EWj6Vemv12qvuPLlRbdRBW+DzVGfr2jwSMzK6M/GJeEVHWlO
	vMFbDbVUaJ4sJoBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CF6313A6B;
	Wed, 22 May 2024 20:57:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y/o1ACZcTmYHagAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 22 May 2024 20:57:09 +0000
Date: Wed, 22 May 2024 22:57:08 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Jane Chu <jane.chu@oracle.com>
Cc: linmiaohe@huawei.com, nao.horiguchi@gmail.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] mm/memory-failure: send SIGBUS in the event of
 thp split fail
Message-ID: <Zk5cJJTFek9yzDh5@localhost.localdomain>
References: <20240521235429.2368017-1-jane.chu@oracle.com>
 <20240521235429.2368017-6-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521235429.2368017-6-jane.chu@oracle.com>
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,linux-foundation.org,kvack.org,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,oracle.com:email]

On Tue, May 21, 2024 at 05:54:29PM -0600, Jane Chu wrote:
> While handling hwpoison in a THP page, it is possible that
> try_to_split_thp_page() fails. For example, when the THP page has
> been RDMA pinned. At this point, the kernel cannot isolate the
> poisoned THP page, all it could do is to send a SIGBUS to the user
> process with meaningful payload to give user-level recovery a chance.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

