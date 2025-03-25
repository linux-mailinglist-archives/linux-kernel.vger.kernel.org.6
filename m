Return-Path: <linux-kernel+bounces-575137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB8EA6EE00
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80DFC16833F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889011EEA51;
	Tue, 25 Mar 2025 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FA5DuLQa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4Ps4+2Fu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FA5DuLQa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4Ps4+2Fu"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C4719ABA3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899519; cv=none; b=adbeD90YY2f9fEsOhJ2MRd5i/DXBEwdaGRwCPz0JbKw8uGKVrKtWFU3QIjk5ZKTe70sqXrNKrGNJcWtewNfTMNjvtc7/s7Dchrnn2RJBAmKHiANMP/iOOaYkQfFQx7EvFEwKnZXKE/8ecEdG+WZ7gK+XjhkWnTkYDsDmJ8ghb4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899519; c=relaxed/simple;
	bh=JhPeedg859hO5Xn9kfQvOnjhlS8q0xjhsgC6OTFP0c4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCFQajzJXNOvQCMT1u3fXAQg1W//roxU3/DINBWd/AuCpwpjKja+dc+I5wngSygaGwZUnzXK6MzUDHntkqANxN+lGplyL19WRi8RWj/VuhoM+e1TKQU/WlXVOdfyZee6j9Oct7tCWQu2pOtsuRkpGsKEevdhidcbiTjwqFkjFrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FA5DuLQa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4Ps4+2Fu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FA5DuLQa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4Ps4+2Fu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A4FA121168;
	Tue, 25 Mar 2025 10:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742899515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e9zLWqX6yoEEWcpjzy7q0ZG4a3JyA4ZR+yXAZIVuauk=;
	b=FA5DuLQaGkddETl9sEiVyoQ6/AmERzXpc5hq80J0P6ak2O5A5QkoaFFXaam5+zrpH2HLfE
	pGajCgAufeIC6swijECTuEZ+lANhKVg4PrkWSyFttjwJ5geYGenMWzmjvtJ9lUcHcrFZ78
	Dz2KmoMWSPIyO0hFinkbi0sQZ2vVdPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742899515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e9zLWqX6yoEEWcpjzy7q0ZG4a3JyA4ZR+yXAZIVuauk=;
	b=4Ps4+2FuQjfNjha/HcGwfNIetLS3X4FYNIaOj8fnX3XM/OEHR1MgBzBxNwYG5dLdmrBwvb
	26pR6PgkbDpqv9Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FA5DuLQa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4Ps4+2Fu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742899515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e9zLWqX6yoEEWcpjzy7q0ZG4a3JyA4ZR+yXAZIVuauk=;
	b=FA5DuLQaGkddETl9sEiVyoQ6/AmERzXpc5hq80J0P6ak2O5A5QkoaFFXaam5+zrpH2HLfE
	pGajCgAufeIC6swijECTuEZ+lANhKVg4PrkWSyFttjwJ5geYGenMWzmjvtJ9lUcHcrFZ78
	Dz2KmoMWSPIyO0hFinkbi0sQZ2vVdPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742899515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e9zLWqX6yoEEWcpjzy7q0ZG4a3JyA4ZR+yXAZIVuauk=;
	b=4Ps4+2FuQjfNjha/HcGwfNIetLS3X4FYNIaOj8fnX3XM/OEHR1MgBzBxNwYG5dLdmrBwvb
	26pR6PgkbDpqv9Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69DD2137AC;
	Tue, 25 Mar 2025 10:45:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uwegGDuJ4mcITwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 25 Mar 2025 10:45:15 +0000
Date: Tue, 25 Mar 2025 11:45:15 +0100
Message-ID: <87o6xpcrt0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andres Traumann <andres.traumann.01@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Bass speaker fixup for ASUS UM5606KA
In-Reply-To: <20250325102535.8172-1-andres.traumann.01@gmail.com>
References: <20250325102535.8172-1-andres.traumann.01@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: A4FA121168
X-Spam-Level: 
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.01
X-Spam-Flag: NO

On Tue, 25 Mar 2025 11:25:35 +0100,
Andres Traumann wrote:
> 
> This patch applies the ALC294 bass speaker fixup (ALC294_FIXUP_BASS_SPEAKER_15),
> previously introduced in commit a7df7f909cec ("ALSA: hda: improve bass
> speaker support for ASUS Zenbook UM5606WA"), to the ASUS Zenbook UM5606KA.
> This hardware configuration matches ASUS Zenbook UM5606WA, where DAC NID
> 0x06 was removed from the bass speaker (NID 0x15), routing both speaker
> pins to DAC NID 0x03.
> 
> This resolves the bass speaker routing issue, ensuring correct audio
> output on ASUS UM5606KA.
> 
> Signed-off-by: Andres Traumann <andres.traumann.01@gmail.com>

Thanks, applied now.


Takashi

