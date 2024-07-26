Return-Path: <linux-kernel+bounces-262928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB44F93CEC6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CFD5B22A93
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C9A17557E;
	Fri, 26 Jul 2024 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PxcwDMYe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qmRl5LTY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PxcwDMYe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qmRl5LTY"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9D4A2A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978613; cv=none; b=qk17DJPY6+wP9SEpMxleXMQTr8h4eznKB1WgXxXlBHU4/ewY98GcO2px6hFSM2DIcuvzlY1p+xza2AEbXdhybKSfuHquW/ktkMlAfmovLS3TwTGHqqBF5WhX6GX/EqJeSm9f27PtLOxnU0JT6PsxLU559CJJqa7DZS9J0VkLBQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978613; c=relaxed/simple;
	bh=nlZ5XTu7aKQY5eOub/IIfBi0FvPWjetDemmGi8yJwUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hj6CVz77RrLEoXEHwiSZU3u7QRtXtTrB6pW7YC9qgDilCtb11t5Xh2djV2Ew2M4z3qTFlcF3pdc7WrhRcQSfkmHu6qqw5fvzCypxX9h1QhgFecCtYRkSaZXTxpse1JkI0uQqmsxJWyS9obnwgNKrVfP2IwbOkvSbaeW7WatYka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PxcwDMYe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qmRl5LTY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PxcwDMYe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qmRl5LTY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71FB121A52;
	Fri, 26 Jul 2024 07:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721978610;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nlZ5XTu7aKQY5eOub/IIfBi0FvPWjetDemmGi8yJwUU=;
	b=PxcwDMYe3RU0a8jn2W1UIib9BsHAWcA17jFIQ++vTH8e8vjqxCmlqs97LhoDlUXIBjtiMR
	n1D1xLVtnOBWwePS5UyhMGQVbFfeEP6HR+M3cdNoMBFNW69a1rEr8gNjmO2O3DvN0jUKwc
	H/8SxTBr8txMbfRjucQAkF/fXIzZDYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721978610;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nlZ5XTu7aKQY5eOub/IIfBi0FvPWjetDemmGi8yJwUU=;
	b=qmRl5LTYWwEkdANyQD3RVkLqpEv1UQaSBCxFcG8LLmLMzuqGKGzZvgf4E+Mav/Ev6CA7oQ
	CuJVxUy43aF9pJDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721978610;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nlZ5XTu7aKQY5eOub/IIfBi0FvPWjetDemmGi8yJwUU=;
	b=PxcwDMYe3RU0a8jn2W1UIib9BsHAWcA17jFIQ++vTH8e8vjqxCmlqs97LhoDlUXIBjtiMR
	n1D1xLVtnOBWwePS5UyhMGQVbFfeEP6HR+M3cdNoMBFNW69a1rEr8gNjmO2O3DvN0jUKwc
	H/8SxTBr8txMbfRjucQAkF/fXIzZDYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721978610;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nlZ5XTu7aKQY5eOub/IIfBi0FvPWjetDemmGi8yJwUU=;
	b=qmRl5LTYWwEkdANyQD3RVkLqpEv1UQaSBCxFcG8LLmLMzuqGKGzZvgf4E+Mav/Ev6CA7oQ
	CuJVxUy43aF9pJDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1893E13AF7;
	Fri, 26 Jul 2024 07:23:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e04gBPJOo2Z5HwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 26 Jul 2024 07:23:30 +0000
Date: Fri, 26 Jul 2024 09:23:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: Cyril Hrubis <chrubis@suse.cz>, Jan Stancek <jstancek@redhat.com>,
	Li Wang <liwang@redhat.com>, Xiao Yang <yangx.jy@fujitsu.com>,
	Yang Xu <xuyang2018.jy@fujitsu.com>,
	Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Vorel <petr.vorel@gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Update LTP members and web
Message-ID: <20240726072327.GA1021851@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240726072009.1021599-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726072009.1021599-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,redhat.com,fujitsu.com,suse.de,lists.linux.it,linux-foundation.org,gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.80

Hi all,

> LTP project uses now readthedocs.org instance instead of GitHub wiki.

> LTP maintainers are listed in alphabetical order.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>

Please, whoever merges this, please keep as SOB only my SUSE address.
I'm sorry for the noise.

Kind regards,
Petr

