Return-Path: <linux-kernel+bounces-186696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F908CC7C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1D21C20D6A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34B1145FE9;
	Wed, 22 May 2024 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fS3T7fSX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XOHJPvWW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fS3T7fSX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XOHJPvWW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D2770EA
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716410279; cv=none; b=BqWTqaIKJRwWnGp7uDvzrbnwFWrZG4xoQoMIP8HpP4uHz1lOG9iKe9hiLHoNsOf/99Djeo4ZulRANUERphWcsTYV6nxfeQTHO6jrJsqafJinGTqsK1+iHR4cieaLynL1jPAzuGCAekFN0PamcYmxQy5LroK8ZZxJK+iUmRBEvq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716410279; c=relaxed/simple;
	bh=KrdFb42E1qLTtj5JgWIQfwazEzkKc+euMPqFJMa9zLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LttKr4Dqlu8CwAv2E6I/pA7NcLOGRqge5xMQfd3g2M/kaO/ObcTKfr/s2U64iMDlRQ3cfTpVN9KpxUrgUG+p0cQc/c3oqgpPTPgwhcD9If81BRORqeZPLigKSDymJmD4ObqhamNzJnR9xD43M7awx2iUaJCrO45peQP7Y5xCHxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fS3T7fSX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XOHJPvWW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fS3T7fSX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XOHJPvWW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71A6F21AFD;
	Wed, 22 May 2024 20:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716410275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P7sgCBLEOd0zAwb9Vd8c+xk3tzP1NVqfInYRCah7qvo=;
	b=fS3T7fSXE1NEq1FIoX3byHQiLLv7Pxt12b31mdWRp3mXRgHvhAbDtvLUWJA+R9xQWBbi11
	a6Kfku0b3IOqmo467uOh/1Eppku/V21XQuDWgLcnsQ9qbSCKcPZ0ZegZQj1XeAC7pqGy9v
	FHu/ZdAnoZKN4BU1i8yYVJJw1pNYTps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716410275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P7sgCBLEOd0zAwb9Vd8c+xk3tzP1NVqfInYRCah7qvo=;
	b=XOHJPvWW6NVaE8aJfQ+47Iqw7PJFlDYJ6tAB4Sc0SPRDL+kUAncGyC9kPuTkN+FF0JmaYh
	FH3Hoehur+jrCPDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fS3T7fSX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XOHJPvWW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716410275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P7sgCBLEOd0zAwb9Vd8c+xk3tzP1NVqfInYRCah7qvo=;
	b=fS3T7fSXE1NEq1FIoX3byHQiLLv7Pxt12b31mdWRp3mXRgHvhAbDtvLUWJA+R9xQWBbi11
	a6Kfku0b3IOqmo467uOh/1Eppku/V21XQuDWgLcnsQ9qbSCKcPZ0ZegZQj1XeAC7pqGy9v
	FHu/ZdAnoZKN4BU1i8yYVJJw1pNYTps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716410275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P7sgCBLEOd0zAwb9Vd8c+xk3tzP1NVqfInYRCah7qvo=;
	b=XOHJPvWW6NVaE8aJfQ+47Iqw7PJFlDYJ6tAB4Sc0SPRDL+kUAncGyC9kPuTkN+FF0JmaYh
	FH3Hoehur+jrCPDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1078013A6B;
	Wed, 22 May 2024 20:37:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +0kOAaNXTmaSAwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 22 May 2024 20:37:55 +0000
Date: Wed, 22 May 2024 22:37:53 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Jane Chu <jane.chu@oracle.com>
Cc: linmiaohe@huawei.com, nao.horiguchi@gmail.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] mm/memory-failure: improve memory failure
 action_result messages
Message-ID: <Zk5Xoc1aXuw-KMJG@localhost.localdomain>
References: <20240521235429.2368017-1-jane.chu@oracle.com>
 <20240521235429.2368017-4-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521235429.2368017-4-jane.chu@oracle.com>
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 71A6F21AFD
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,linux-foundation.org,kvack.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Tue, May 21, 2024 at 05:54:27PM -0600, Jane Chu wrote:
> Added two explicit MF_MSG messages describing failure in get_hwpoison_page.
> Attemped to document the definition of various action names, and made a few
> adjustment to the action_result() calls.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

This looks much better, thanks:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

By the way, I was checking the block in memory_failure() that handles
refcount=0 pages, concretely the piece of code that handles buddy pages.

In there, if we fail to take the page off the buddy lists, we return
MF_FAILED, but I really think we should be returning MF_IGNORED.

Thoughts?
 

-- 
Oscar Salvador
SUSE Labs

