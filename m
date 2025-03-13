Return-Path: <linux-kernel+bounces-560224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7B0A5FF84
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9815F19C522E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EECE1EBA14;
	Thu, 13 Mar 2025 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mEAxVzTb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gWi72Z6/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mEAxVzTb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gWi72Z6/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B077104
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741891310; cv=none; b=eGkGrMx+WtaYpF0X01eosCzC/fBvsjtUhI7IO4C6k7i/pSNEZL9vuqFcioVg2MuxyF/Z+vxenkAzdQwOvFyk2UMk8UtsEF3lJ1PR89z6D7emdY6NLkx3+iKm4ib3mQ0RsakgtjxDplEsR94Scf97ZSfQCTnjNqu+1H2rVJMlDU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741891310; c=relaxed/simple;
	bh=K1ufW1t71/LhbRTS9L3x2kbBKHk7K1sfsb/P4RdG8oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dq0eZxkxntgWK9p2qHncc5UPLwhZCp04kLmnveaVRHPXiwpJyTbLw1LBxb1pEHxvvT/LWhdJkYjng5Dm77np5o/H6OMcPmbd2ZvrR2nq2qQYjuQDefgjKfe8r7+sIuYHHsU+sa+BsWGw07J4rrp8969RQ7cMs/FmVRdE5CmbKTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mEAxVzTb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gWi72Z6/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mEAxVzTb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gWi72Z6/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 35A5E1F388;
	Thu, 13 Mar 2025 18:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741891307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9ZI1osHMrRJiV1DMOXcbTgh24ULb8W1iYmvmy5Cp1c=;
	b=mEAxVzTbbK1c6ob/mDj7EeatyGXMWMmQY6ivReL6+Mfv4d23tgLUix/KkAxHqBkRQ0xjTk
	Nv7bmuoapUGjoqHihdVbJncNbBorw+QuTUqxnEtSdN8yJgEKxnLeNB3drPjhXKTWUqfs1o
	+67ENFtGM4CSHfA79jGiCCA+PEhxrZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741891307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9ZI1osHMrRJiV1DMOXcbTgh24ULb8W1iYmvmy5Cp1c=;
	b=gWi72Z6/xpwuqvjv5qohD3QU6oqbbkfJQq5PQ7ZTxNEy4V5D6KqUZvF6H45GXEAqUconPy
	HXz+bjmELAAKlICA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741891307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9ZI1osHMrRJiV1DMOXcbTgh24ULb8W1iYmvmy5Cp1c=;
	b=mEAxVzTbbK1c6ob/mDj7EeatyGXMWMmQY6ivReL6+Mfv4d23tgLUix/KkAxHqBkRQ0xjTk
	Nv7bmuoapUGjoqHihdVbJncNbBorw+QuTUqxnEtSdN8yJgEKxnLeNB3drPjhXKTWUqfs1o
	+67ENFtGM4CSHfA79jGiCCA+PEhxrZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741891307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9ZI1osHMrRJiV1DMOXcbTgh24ULb8W1iYmvmy5Cp1c=;
	b=gWi72Z6/xpwuqvjv5qohD3QU6oqbbkfJQq5PQ7ZTxNEy4V5D6KqUZvF6H45GXEAqUconPy
	HXz+bjmELAAKlICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07DCA13797;
	Thu, 13 Mar 2025 18:41:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7pSVO+om02fzVgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Thu, 13 Mar 2025 18:41:46 +0000
Date: Thu, 13 Mar 2025 19:41:45 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: dmi: Respect buffer size in get_modalias
Message-ID: <20250313194145.284d7815@endymion>
In-Reply-To: <Z7eWSCCqp_HP3iSh@grain>
References: <Z7eWSCCqp_HP3iSh@grain>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+]
X-Spam-Score: -3.80
X-Spam-Flag: NO

Hi Cyrill,

On Thu, 20 Feb 2025 23:53:28 +0300, Cyrill Gorcunov wrote:
> When we collect data from DMI data the result is accumulated either
> in a page buffer from sysfs entry or from uevent environment buffer.
> Both are big enough (4K and 2K) and it is hard to imagine that we
> overflow 4K page with the data, still the situation is different for
> uevent buffer where buffer may be already filled with data and we
> possibly may overflow it.

Would it not be a concern if that ever happened?

> Thus lets respect buffer size given by a caller and never write
> data unconditionally.

On the principle I agree. On the implementation, not quite so.

> CC: Jean Delvare <jdelvare@suse.com>
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> ---
>  drivers/firmware/dmi-id.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> Index: linux-tip.git/drivers/firmware/dmi-id.c
> ===================================================================
> --- linux-tip.git.orig/drivers/firmware/dmi-id.c
> +++ linux-tip.git/drivers/firmware/dmi-id.c
> @@ -103,8 +103,12 @@ static ssize_t get_modalias(char *buffer
>  	char *p;
>  	const struct mafield *f;
>  
> -	strcpy(buffer, "dmi");
> -	p = buffer + 3; left = buffer_size - 4;
> +	l = strscpy(buffer, "dmi", buffer_size);
> +	if (l < 0)
> +		return 0;

If function get_modalias() now has a return convention, it should be
documented. But I see a problem which is that the return convention
isn't clear. It *may* now return 0 on buffer overrun, but not
necessarily. The rest of the function is best-effort mode and will
silently drop a part of the modalias string if it doesn't fit. This is
not consistent.

This is not caused by your patch, but this could actually cause false
positive matches, so it may be a good idea to fix it while you're here.
And in my opinion the best thing to do is to return an error rather
than an half-baked modalias string. If the string doesn't fit as a
whole, it's going to cause trouble at some point anyway, so we better
learn about it early and do something about it. And that would be
consistent.

I'm also curious why you chose to return 0 on error, rather than the
more conventional -1 or -ENOMEM?

> +	p = buffer + l; left = buffer_size - l - 1;

Please split on separate lines for readability. I would also appreciate
a comment explaining that the "- 1" is to leave room for the trailing
":" (if I understand that right).

> +	if (left < 0)
> +		return 0;
>  
>  	for (f = fields; f->prefix && left > 0; f++) {
>  		const char *c;
> @@ -135,7 +139,7 @@ static ssize_t sys_dmi_modalias_show(str
>  				     struct device_attribute *attr, char *page)
> {
>  	ssize_t r;
> -	r = get_modalias(page, PAGE_SIZE-1);
> +	r = get_modalias(page, PAGE_SIZE-2);

Why? As I read the code, get_modalias() returns the length of the
string, excluding the trailing '\0'. So it will be, at most, one less
than the buffer size we passed. So if we pass PAGE_SIZE-1, r is at most
PAGE_SIZE-2, which leaves exactly the 2 bytes we need for the two lines
of code below. Am I missing something?

(The last line of get_modalias would probably be clearer as:
	return (p + 1) - buffer;
or if p was increased beforehand to actually point to the end of the
string.)

>  	page[r] = '\n';
>  	page[r+1] = 0;
>  	return r+1;
> @@ -163,7 +167,7 @@ static int dmi_dev_uevent(const struct d
>  		return -ENOMEM;
>  	len = get_modalias(&env->buf[env->buflen - 1],
>  			   sizeof(env->buf) - env->buflen);
> -	if (len >= (sizeof(env->buf) - env->buflen))
> +	if (!len || len >= (sizeof(env->buf) - env->buflen))
>  		return -ENOMEM;

I do not like the fact that we check whether get_modalias() returns an
error here, and not in sys_dmi_modalias_show(). This is inconsistent.
IMHO both functions should check the return value and return an error
code on failure.

As a side note, I can't see how the second condition could be true. We
pass the buffer size to get_modalias() exactly to make sure that it
won't write past the buffer's end.

>  	env->buflen += len;
>  	return 0;

Thanks,
-- 
Jean Delvare
SUSE L3 Support

