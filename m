Return-Path: <linux-kernel+bounces-427893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 416099E0B2F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6FC1B43DFE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AF7208998;
	Mon,  2 Dec 2024 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xyvnElTm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CqjwQkhq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xyvnElTm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CqjwQkhq"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A941FDE1A;
	Mon,  2 Dec 2024 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153576; cv=none; b=KsyQo3tYM1ZXvbWavfFnw784rXXooMx7/Qgx+1VaEitBI+hbVxFFqp+NIM9y3cESW1bzIOGH/hZEE+pHGnVk4C8gzIC8Kcw800X3Rx2IDWRtMiR7cddt9Y79bU8AvDmjLQLEC8gt6+xQQZ+9GQef3iXqL+T40SqkZc/oQA3mdTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153576; c=relaxed/simple;
	bh=7JZzgjvIxp2zXNn/qUydx86IDlCGk/1UUEI5DxA+Dzc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQ7Wy9LL6TWKyqF+TKgWTY84lgEa0iM87lHJgWvVZ1ailhAlXsG9befPSKzGiURE+PRYnBGLIzWgO5tHnRqgHphgSQE7VariMG0JGFd9FGagU9JaYDUlFkDB2JUpXk9DHmDOkiyMPhiNnNS/4RJfzVICG1l1XZxO9IV/9rDi2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xyvnElTm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CqjwQkhq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xyvnElTm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CqjwQkhq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1658821101;
	Mon,  2 Dec 2024 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733153573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMm6tHoFHi/K+ZQGg4IXWDxv573Z3NMHLzv+W0SQ+LI=;
	b=xyvnElTmYUlYxb6Caqq2teKvjAFmiwsraZoO6bdR5Ryc+dTtTDNuCp37Bvuw90vYphda0T
	wnHtLT8tCjXpO8yP8ACajFz/ioe7qZpcMge8gIwl6e+TrJ6C8anpyZPO1QouXfLZw0E5iQ
	GhOmDNHNJaRGpTT5NaGsMh+wpJN/vSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733153573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMm6tHoFHi/K+ZQGg4IXWDxv573Z3NMHLzv+W0SQ+LI=;
	b=CqjwQkhq1Q/1iKViWb+4ltgQGOd7NbxiFyUW/dbq114a104DqVsuAED1FQA9wLjJHXPE7f
	4sCz9ElCqIckYXBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xyvnElTm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CqjwQkhq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733153573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMm6tHoFHi/K+ZQGg4IXWDxv573Z3NMHLzv+W0SQ+LI=;
	b=xyvnElTmYUlYxb6Caqq2teKvjAFmiwsraZoO6bdR5Ryc+dTtTDNuCp37Bvuw90vYphda0T
	wnHtLT8tCjXpO8yP8ACajFz/ioe7qZpcMge8gIwl6e+TrJ6C8anpyZPO1QouXfLZw0E5iQ
	GhOmDNHNJaRGpTT5NaGsMh+wpJN/vSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733153573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMm6tHoFHi/K+ZQGg4IXWDxv573Z3NMHLzv+W0SQ+LI=;
	b=CqjwQkhq1Q/1iKViWb+4ltgQGOd7NbxiFyUW/dbq114a104DqVsuAED1FQA9wLjJHXPE7f
	4sCz9ElCqIckYXBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC800139C2;
	Mon,  2 Dec 2024 15:32:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F0O3MCTTTWcvMwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 02 Dec 2024 15:32:52 +0000
Date: Mon, 02 Dec 2024 16:32:52 +0100
Message-ID: <87cyiauml7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Chris Chiu <chris.chiu@canonical.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: fix micmute LEDs don't work on HP Laptops
In-Reply-To: <20241202144659.1553504-1-chris.chiu@canonical.com>
References: <20241202144659.1553504-1-chris.chiu@canonical.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 1658821101
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,canonical.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Mon, 02 Dec 2024 15:46:59 +0100,
Chris Chiu wrote:
> 
> These HP laptops use Realtek HDA codec ALC3315 combined CS35L56
> Amplifiers. They need the quirk ALC285_FIXUP_HP_GPIO_LED to get
> the micmute LED working.
> 
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>

Thanks, applied now.


Takashi

