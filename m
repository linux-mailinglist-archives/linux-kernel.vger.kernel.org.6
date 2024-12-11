Return-Path: <linux-kernel+bounces-441628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A500E9ED0DD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2895167B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A2A1D63CA;
	Wed, 11 Dec 2024 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ROIUKUk0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Se1C2ctl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ROIUKUk0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Se1C2ctl"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D16C1DBB0C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933297; cv=none; b=kU1QjNrUr+fVlpy92gs0bGBpWf8/Wz/Uv3Ldx2LFgFlwDQnn8dx1KxRQfDMRxzlJiuHrQrj9CkvMU4mfl6SLk1XJWFv5+mGq8LMbpj6ThnHV8t046g44KHYgjZjTMcUBgsszeIBqBh51uAAiW2H4MnLaFEq1xpnx7JgnP0P+4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933297; c=relaxed/simple;
	bh=tuI7MK9zBdpQseSyOX6KKaBQeCWr7ro/OeiS1nHrqhY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p4vtBdYEjGqWcNQsxe+EvU83weyFGcMnIqUzmk5h4e5KOHxiFGsvq76hz3k5XEsrKuWlIs2LPYfmCH+uXL+ou1W3LhKzawzuNB0hUbKoTEoHOWe/c5yBu+OMMphnSEcSAESGLrugKRRpclC7tmY3LXlL97Nfu4EEVHkqFpi5NUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ROIUKUk0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Se1C2ctl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ROIUKUk0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Se1C2ctl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6EA3F1F38C;
	Wed, 11 Dec 2024 16:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733933293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IjvTT5N3QMcR+eVeVqsTAHalXtEBVa2ZyuCBe66dF+g=;
	b=ROIUKUk0iiXbvewwmljfnGJp7E3SKdZJI8qzfIKnghUfEAoASVfhFzYZGwNB/DeHUPcdfx
	QLpx8TbWjS9E9EjD0plCKInBOQbD/38OmSDUzQ0eSw8n4/u4VgVW02BAUNEcS6ck/0CuVZ
	KtR6dKU05yqRKm37Ir1CjqjPHA+QZF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733933293;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IjvTT5N3QMcR+eVeVqsTAHalXtEBVa2ZyuCBe66dF+g=;
	b=Se1C2ctl6PJQq1kEyS9X+vmjFCn6QOUlF8J4vXEM28AM5k/KFNZQ4oowJrDQraVBY5JDiA
	UWj4TzYEDhqi5fCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ROIUKUk0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Se1C2ctl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733933293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IjvTT5N3QMcR+eVeVqsTAHalXtEBVa2ZyuCBe66dF+g=;
	b=ROIUKUk0iiXbvewwmljfnGJp7E3SKdZJI8qzfIKnghUfEAoASVfhFzYZGwNB/DeHUPcdfx
	QLpx8TbWjS9E9EjD0plCKInBOQbD/38OmSDUzQ0eSw8n4/u4VgVW02BAUNEcS6ck/0CuVZ
	KtR6dKU05yqRKm37Ir1CjqjPHA+QZF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733933293;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IjvTT5N3QMcR+eVeVqsTAHalXtEBVa2ZyuCBe66dF+g=;
	b=Se1C2ctl6PJQq1kEyS9X+vmjFCn6QOUlF8J4vXEM28AM5k/KFNZQ4oowJrDQraVBY5JDiA
	UWj4TzYEDhqi5fCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 030F213983;
	Wed, 11 Dec 2024 16:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qMFSL+y4WWchUQAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 11 Dec 2024 16:08:12 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,  Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, "hanqi@vivo.com" <hanqi@vivo.com>
Subject: Re: Unicode conversion issue
In-Reply-To: <Z1mzu4Eg6CPURra3@google.com> (Jaegeuk Kim's message of "Wed, 11
	Dec 2024 15:46:03 +0000")
Organization: SUSE
References: <Z1mzu4Eg6CPURra3@google.com>
Date: Wed, 11 Dec 2024 11:08:07 -0500
Message-ID: <87v7vqyzh4.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 6EA3F1F38C
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Jaegeuk Kim <jaegeuk@kernel.org> writes:

> Hi Linus/Gabriel,
>
> Once Android applied the below patch [1], some special characters started to be
> converted differently resulting in different length, so that f2fs cannot find
> the filename correctly which was created when the kernel didn't have [1].
>
> There is one bug report in [2] where describes more details. In order to avoid
> this, could you please consider reverting [1] asap? Or, is there any other
> way to keep the conversion while addressing CVE? It's very hard for f2fs to
> distinguish two valid converted lengths before/after [1].

I got this report yesterday. I'm looking into it.

It seems commit 5c26d2f1d3f5 ("unicode: Don't special case ignorable
code points") has affected more than ignorable code points, because that
U+2764 is not marked as Ignorable in the unicode database.

I still think the solution to the original issue is eliminating
ignorable code points, and that should be fine.  Let me look at why this
block of characters is mishandled.

>
> [1] 5c26d2f1d3f5 ("unicode: Don't special case ignorable code points")
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=219586

-- 
Gabriel Krisman Bertazi

