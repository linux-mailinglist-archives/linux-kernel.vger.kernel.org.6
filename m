Return-Path: <linux-kernel+bounces-308199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7042965888
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E4A287F52
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495F914C5A4;
	Fri, 30 Aug 2024 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v+G7GvwM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rM7B3hn8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v+G7GvwM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rM7B3hn8"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F7A15855F;
	Fri, 30 Aug 2024 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002965; cv=none; b=YAsmlq616skCBPJlTrEq0JGejpDXehJNo/T9uGeiH3Lq+GxFaO8gh2VEKPCeUQ4e3qsZdAAlAZllScWdM75wDROH5RHT0U+R65gyupJZFngiqQUU7BwhXkFYrxoNnzIIfSjgMWHIB8t1qL2gz8gM5xhi5GldAX6cyC/37ndDg1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002965; c=relaxed/simple;
	bh=QiFIssSFWRueC9erw2+bHra3ANRGrVHTdR3M0wWNZHo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tf1E1yCg6xjHeYrdOCgwL3uPnalL7GxlVc7KMgvSStd/wvR0xN7MDAu3q+5CkyOA6g8kgZJWxgbWdQjiX8w0PoDjgur9kRGoHbE3a7AJvjYI8RjOVBIxJv1H+iKtvlIPUygQZrDXaAls4/Pc6ziEPGLRK+A5ZVoZ9k8YKcGL7AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v+G7GvwM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rM7B3hn8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v+G7GvwM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rM7B3hn8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 11AD31F7A7;
	Fri, 30 Aug 2024 07:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725002962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ld+P0HPgoa4AL3BOpa6b7hpUQm2Xu4qAt2RseA/xXr0=;
	b=v+G7GvwMUvNVcP54tFJgJiyp+DpJFHCVyvj9E7YhBmWA9AEHhKyJkA4lWdEQ0ga3q5EvNF
	wXQsw0upgBkKm4nXJRDpIKPc3D5/90k4/r2A9WeajKTiodZpF+SWJIhruaobBKriqv8l9k
	iFtoCQ8IF9wLa/DQ9tpvm5nEm/Owtzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725002962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ld+P0HPgoa4AL3BOpa6b7hpUQm2Xu4qAt2RseA/xXr0=;
	b=rM7B3hn82SR9PD6lExOeiwhKUgJNd2Ye4SMu/IBvaV3ESOPZ7hmmiJW7O5Pgg1UrhanqLT
	NM1jVycK5qq5nKCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=v+G7GvwM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rM7B3hn8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725002962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ld+P0HPgoa4AL3BOpa6b7hpUQm2Xu4qAt2RseA/xXr0=;
	b=v+G7GvwMUvNVcP54tFJgJiyp+DpJFHCVyvj9E7YhBmWA9AEHhKyJkA4lWdEQ0ga3q5EvNF
	wXQsw0upgBkKm4nXJRDpIKPc3D5/90k4/r2A9WeajKTiodZpF+SWJIhruaobBKriqv8l9k
	iFtoCQ8IF9wLa/DQ9tpvm5nEm/Owtzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725002962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ld+P0HPgoa4AL3BOpa6b7hpUQm2Xu4qAt2RseA/xXr0=;
	b=rM7B3hn82SR9PD6lExOeiwhKUgJNd2Ye4SMu/IBvaV3ESOPZ7hmmiJW7O5Pgg1UrhanqLT
	NM1jVycK5qq5nKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF99813A44;
	Fri, 30 Aug 2024 07:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +5EzMdF00WazYgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 30 Aug 2024 07:29:21 +0000
Date: Fri, 30 Aug 2024 09:30:06 +0200
Message-ID: <87r0a6lb7l.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Terry Cheong <htcheong@chromium.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Steve Kendall <skend@chromium.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ALSA: hda/realtek: add patch for internal mic in Lenovo V145
In-Reply-To: <20240830-lenovo-v145-fixes-v3-1-f7b7265068fa@chromium.org>
References: <20240830-lenovo-v145-fixes-v3-1-f7b7265068fa@chromium.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 11AD31F7A7
X-Spam-Score: -5.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 29 Aug 2024 22:11:53 +0200,
Terry Cheong wrote:
> 
> Lenovo V145 is having phase inverted dmic but simply applying inverted
> dmic fixups does not work. Chaining up verb fixes for ALC283 enables
> inverting dmic fixup to work properly.
> 
> Signed-off-by: Terry Cheong <htcheong@chromium.org>

Thanks, applied now.


Takashi

