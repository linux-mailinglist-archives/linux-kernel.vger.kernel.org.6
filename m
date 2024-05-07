Return-Path: <linux-kernel+bounces-170909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 191CF8BDDB5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BEB6284F56
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB1814E2CD;
	Tue,  7 May 2024 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jXT81tP+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LfRkAYkX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jXT81tP+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LfRkAYkX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D614D44E
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715072562; cv=none; b=hZY8JdSRGW3mG1CfiKbUAPn3FeoT1ggUdIKK+HSQPhp0ZWTRLomyA1T3FYQ6z3AixxZf31DzKlffPgMcjeq6TU9BO/0aA1E0PQz7y7xi06DZ6m1GenrQJg8BdOi+vuWDQhopQaPcdNPJZEaO0LJM0ZIIRU3IGducUVJiIUHWL9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715072562; c=relaxed/simple;
	bh=60jS181WO5k71seEepe3WjZoVHuIO2PGj2XzHCB4kn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THdezfaDRkqdc/fPzW99oaJGKnqLUUNbQ3fOPlqU+eg95pKtFtMQQYh+pgDqhVP6Rl5ODI27tBC1Fsi29dsuSlHezecU/TjVbYGd71sMCToqoPnWeMxwb702w+tGbcmudxbwflf0I+cxYuDp9FvNnapeFHQzBW0JRhDZaEfV20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jXT81tP+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LfRkAYkX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jXT81tP+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LfRkAYkX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D18DD206B1;
	Tue,  7 May 2024 09:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715072552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixaChRQaGvKUHEvNH8Bz6whyZ7S1illey/rZiGocvi8=;
	b=jXT81tP+Re2hes4VND70fiagI72rujWt0OqRG9tVRAwmfQC3zILCE6avtnrzRQZ41VinIz
	2KBi5Brli5rTF11eq++jiWUYuz7XE3x9p0oRgGSjKEp62voTVY3ld+2BoEOBAX0iZiFlCk
	GgA6LfygyR6rao2k7JjHjmaFh8wjYig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715072552;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixaChRQaGvKUHEvNH8Bz6whyZ7S1illey/rZiGocvi8=;
	b=LfRkAYkX5N7Oao+7Jux7Gwo6vYjLRALURbKFhHMeME0iBTC6jyCpshpWJI0+Si3xJfUzQV
	TEO2jM4i60bS72DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715072552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixaChRQaGvKUHEvNH8Bz6whyZ7S1illey/rZiGocvi8=;
	b=jXT81tP+Re2hes4VND70fiagI72rujWt0OqRG9tVRAwmfQC3zILCE6avtnrzRQZ41VinIz
	2KBi5Brli5rTF11eq++jiWUYuz7XE3x9p0oRgGSjKEp62voTVY3ld+2BoEOBAX0iZiFlCk
	GgA6LfygyR6rao2k7JjHjmaFh8wjYig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715072552;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixaChRQaGvKUHEvNH8Bz6whyZ7S1illey/rZiGocvi8=;
	b=LfRkAYkX5N7Oao+7Jux7Gwo6vYjLRALURbKFhHMeME0iBTC6jyCpshpWJI0+Si3xJfUzQV
	TEO2jM4i60bS72DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FA5B139CB;
	Tue,  7 May 2024 09:02:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OIEOGCjuOWalRgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 07 May 2024 09:02:32 +0000
Date: Tue, 7 May 2024 11:02:30 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Jane Chu <jane.chu@oracle.com>
Cc: linmiaohe@huawei.com, nao.horiguchi@gmail.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/memory-failure: try to send SIGBUS even if unmap
 failed
Message-ID: <ZjnuJgUVVnwYrr5p@localhost.localdomain>
References: <20240501232458.3919593-1-jane.chu@oracle.com>
 <20240501232458.3919593-2-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501232458.3919593-2-jane.chu@oracle.com>
X-Spam-Flag: NO
X-Spam-Score: -2.78
X-Spam-Level: 
X-Spamd-Result: default: False [-2.78 / 50.00];
	BAYES_HAM(-2.98)[99.91%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Wed, May 01, 2024 at 05:24:56PM -0600, Jane Chu wrote:
> For years when it comes down to kill a process due to hwpoison,
> a SIGBUS is delivered only if unmap has been successful.
> Otherwise, a SIGKILL is delivered. And the reason for that is
> to prevent the involved process from accessing the hwpoisoned
> page again.
> 
> Since then a lot has changed, a hwpoisoned page is marked and
> upon being re-accessed, the process will be killed immediately.
> So let's take out the '!unmap_success' factor and try to deliver
> SIGBUS if possible.

I am missing some details here.
An unmapped hwpoison page will trigger a fault and will return
VM_FAULT_HWPOISON all the way down and then deliver SIGBUS,
but if the page was not unmapped, how will this be catch upon
re-accessing? Will the system deliver a MCE event? 


-- 
Oscar Salvador
SUSE Labs

