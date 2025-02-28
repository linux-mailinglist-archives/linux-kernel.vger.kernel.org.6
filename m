Return-Path: <linux-kernel+bounces-538575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 148C0A49A64
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13108173959
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8E926B971;
	Fri, 28 Feb 2025 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="taPak6TA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bwen6s49";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="taPak6TA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bwen6s49"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546001D555
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748878; cv=none; b=EUo8QropgM9vd2awwAh/+eopnnSxuBmKVasEpzsqcxeXn7WTxCx3q4NZETSuErtLqW09iaCk6YTZuah8rGniqyagyw2V48pTif/AO7zeukdG2SUGjGyOkoAP8ZKR3qmAVHo5d3Tqa5tjem+B3NTtRFfiByZ4wuuMesMgkGGwiII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748878; c=relaxed/simple;
	bh=O/ALDNWIKnkbqJSvabrN0JBWkia3q7ZZdMnuoIu1yRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9KAVDvECRxI9egfQsYX1L4ImhmzTWFyxHNbY8Ayh7lZVIUdzLe/bRh/vM/3EUtkI2GKDH01R1C6cI/Zkg1sg3Ju47oVaRyFNb05XLcgi3snMtIykB8EmTrSx2JAQBVCUK8vqy/Vx28q5tvzBM4qqzUCBqBEbAz3VLUlZXv6WDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=taPak6TA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bwen6s49; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=taPak6TA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bwen6s49; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B25D21166;
	Fri, 28 Feb 2025 13:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740748873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yO8Vwa49DPqVDuGglnqVAaTVZKpO++hm+tq543hr6RQ=;
	b=taPak6TAa6a6ZF8bNLI3yNLZOIE1XVKoWTdXPJrwSPe96MEDqZ4zYXlqZhD0Q33MBq0GeY
	BttgSDQ7NVYVr0kXfFuSNsxkI1GoxArErKtZRQOGLLkzxBfzeDo1R9JTPC/hMrlfRY6jjW
	7nO42QudkY+/T5+8H9mkpiZfApN/0xM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740748873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yO8Vwa49DPqVDuGglnqVAaTVZKpO++hm+tq543hr6RQ=;
	b=bwen6s49ykC7piav+2UEs5LBYx+ZYVJ69tSdKS3a4P3FgYCdArql9E+jxh+vGNvU931trE
	UB1vPLc6UjHhBNCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740748873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yO8Vwa49DPqVDuGglnqVAaTVZKpO++hm+tq543hr6RQ=;
	b=taPak6TAa6a6ZF8bNLI3yNLZOIE1XVKoWTdXPJrwSPe96MEDqZ4zYXlqZhD0Q33MBq0GeY
	BttgSDQ7NVYVr0kXfFuSNsxkI1GoxArErKtZRQOGLLkzxBfzeDo1R9JTPC/hMrlfRY6jjW
	7nO42QudkY+/T5+8H9mkpiZfApN/0xM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740748873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yO8Vwa49DPqVDuGglnqVAaTVZKpO++hm+tq543hr6RQ=;
	b=bwen6s49ykC7piav+2UEs5LBYx+ZYVJ69tSdKS3a4P3FgYCdArql9E+jxh+vGNvU931trE
	UB1vPLc6UjHhBNCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A61C1344A;
	Fri, 28 Feb 2025 13:21:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id slCgCUm4wWeUHgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 28 Feb 2025 13:21:13 +0000
Date: Fri, 28 Feb 2025 14:21:11 +0100
From: David Sterba <dsterba@suse.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Nitin Gupta <nitingupta910@gmail.com>,
	Richard Purdie <rpurdie@openedhand.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
	Dave Rodgman <dave.rodgman@arm.com>
Subject: Re: [v3 PATCH] crypto: lzo - Fix compression buffer overrun
Message-ID: <20250228132111.GG5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <Z7rGXJSX57gEfXPw@gondor.apana.org.au>
 <20250226130037.GS5777@twin.jikos.cz>
 <Z7_D4i5yifwdXjwZ@gondor.apana.org.au>
 <Z7_JOAgi-Ej3CCic@gondor.apana.org.au>
 <Z8Aqrrm2o_0SXciH@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8Aqrrm2o_0SXciH@gondor.apana.org.au>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,openedhand.com,linux-foundation.org,chromium.org,oberhumer.com,arm.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Feb 27, 2025 at 05:04:46PM +0800, Herbert Xu wrote:
> Unlike the decompression code, the compression code in LZO never
> checked for output overruns.  It instead assumes that the caller
> always provides enough buffer space, disregarding the buffer length
> provided by the caller.
> 
> Add a safe compression interface that checks for the end of buffer
> before each write.  Use the safe interface in crypto/lzo.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks.

Reviewed-by: David Sterba <dsterba@suse.com>

