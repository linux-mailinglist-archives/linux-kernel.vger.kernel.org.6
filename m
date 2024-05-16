Return-Path: <linux-kernel+bounces-181144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 890758C782C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E44D28424B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F98149001;
	Thu, 16 May 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yvkGjKI+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yEL3sR0H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yvkGjKI+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yEL3sR0H"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B528A146D51;
	Thu, 16 May 2024 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868151; cv=none; b=kRR8mLPuf/0BO8gmprOW3iD0IjExWcskCSilverOcq87YSEbzQdU7cluDqjaZUUfwyKovyzeOyPDu6lE2+P3p+yCalISqQOfPAuuXF58Jp1Pzu33VLswcEAVeaDW6VUlKLFBPrddffU+tSRKAaLQIcQcru1g49azu3Gd48Zn5qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868151; c=relaxed/simple;
	bh=V/NH146L7hIj0JHJ81pb0dj3R2FIvS7eqv0S8By9H3M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0NJye2ma/vgxaBsAR0UHAJeBlKRm4q+ouojF0weCbFol5dZGlRVBDo8FARrL/5rB/6Dv9giZ2buEN/dffcDyEFKmQNuyzz5lmOtj60JZzqOgXIJNxCP0BMNv9dIJBotXTMXqbvio6m8m5UgZbLNp1eazhR/rzp6VuPfWwgWcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yvkGjKI+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yEL3sR0H; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yvkGjKI+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yEL3sR0H; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D114E34A44;
	Thu, 16 May 2024 14:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715868147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eS8dHN/8uJit7KYQ/wbXUaaaUK7rLV870M0qQi40wRk=;
	b=yvkGjKI+HlU66ZeEIDPc5u1ZN2WdFvqMcB9L2qwKmGMlUB95vzaZUWtRWe6SGky1NB+yi8
	YA5x0lc2LBVM6AaRHly4m8Wc1aOEKemxsCAWslvafYd9UwcOqTUgwWIk0Ws3wX1PIVBzqH
	A2YUsI1gbqsGFFDBeIE7kjqsj1p1hrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715868147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eS8dHN/8uJit7KYQ/wbXUaaaUK7rLV870M0qQi40wRk=;
	b=yEL3sR0HvJfrS+9bZ3N+OJ2/2Wmkd4V+1TX90j+VjtH5+iC/14dwnkUEXzNKVHZUmYS3DS
	fMe1AsRljprqdmAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yvkGjKI+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yEL3sR0H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715868147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eS8dHN/8uJit7KYQ/wbXUaaaUK7rLV870M0qQi40wRk=;
	b=yvkGjKI+HlU66ZeEIDPc5u1ZN2WdFvqMcB9L2qwKmGMlUB95vzaZUWtRWe6SGky1NB+yi8
	YA5x0lc2LBVM6AaRHly4m8Wc1aOEKemxsCAWslvafYd9UwcOqTUgwWIk0Ws3wX1PIVBzqH
	A2YUsI1gbqsGFFDBeIE7kjqsj1p1hrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715868147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eS8dHN/8uJit7KYQ/wbXUaaaUK7rLV870M0qQi40wRk=;
	b=yEL3sR0HvJfrS+9bZ3N+OJ2/2Wmkd4V+1TX90j+VjtH5+iC/14dwnkUEXzNKVHZUmYS3DS
	fMe1AsRljprqdmAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8449713991;
	Thu, 16 May 2024 14:02:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ijkOH/MRRmZbaAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 16 May 2024 14:02:27 +0000
Date: Thu, 16 May 2024 16:02:43 +0200
Message-ID: <87h6ex3ldo.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Manuel Barrio Linares <mbarriolinares@gmail.com>
Cc: alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jeremie Knuesel <knuesel@gmail.com>,
	Lukasz Tyl <ltyl@hem-e.com>,
	Christos Skevis <xristos.thes@gmail.com>,
	Jussi Laako <jussi@sonarnerd.net>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Fix for sampling rates support for Mbox3
In-Reply-To: <20240516134003.39104-1-mbarriolinares@gmail.com>
References: <87ikze486g.wl-tiwai@suse.de>
	<20240516134003.39104-1-mbarriolinares@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[alsa-project.org,perex.cz,suse.com,gmail.com,hem-e.com,sonarnerd.net,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D114E34A44
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Thu, 16 May 2024 15:40:02 +0200,
Manuel Barrio Linares wrote:
> 
> Fixed wrong use of usb_sndctrlpipe to usb_rcvctrlpipe
> 
> Signed-off-by: Manuel Barrio Linares <mbarriolinares@gmail.com>

Thanks, applied now with Fixes tag.


Takashi

