Return-Path: <linux-kernel+bounces-394549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3909BB0FF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06441C215E4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90B41B0F1C;
	Mon,  4 Nov 2024 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oUVx9LPZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="551VEPYU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oUVx9LPZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="551VEPYU"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FEA1ABEBD;
	Mon,  4 Nov 2024 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715873; cv=none; b=Sp4UP7uKl87Qs/qsMiFwPbOETaNv0rmVoGF1klxXlwiPzx0yQ0W0Tb4wQVt0FFZgwUDxNgQZCMGos8y3tGFOVG0JWQ24ZlSNfTNtXAcmVhox8b8KqLnhmt20ZFYV5myMZsWGilfg59+0sttF0sfuEJssDiHHmeWD5e5aKb0aoHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715873; c=relaxed/simple;
	bh=UhC1xihM0yyX3J7pEDwPom1OrSC8tmiwc5UbVvLh4+A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4e8thU0Z1IPREHRaKICH7vzUlOdu2MBLhCAMZh1eHA8X4iVrU12wdxAgQx4ie/FRPdpmOrNaCY1LfoUCmEjaA+JT3EX+iMZfmMKc3qj/8Upd0a/W8CKkOMTSIoD8eFwb4mx14Xc8hhTgxu0l5Jzx9XodBnI5+qMspjfQBFpoOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oUVx9LPZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=551VEPYU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oUVx9LPZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=551VEPYU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4ADAB1FDD4;
	Mon,  4 Nov 2024 10:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730715869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QONVyxe8S/T0cD5/iGzh2jvCjZgjKOX2yaCeq/joY70=;
	b=oUVx9LPZiJdZv9JySK+DzXtr/cMPUK+LAsV6ZHllZFZDMcKVIZdkIOGnxVXz/llxl68SBx
	9oBt4Dk9tE12tNyUdtbZlwFOF9XvqBgqlVEO706g86YeX1wYGpvirmQ/BfLSSmKFS2UAGz
	lFmYVSEkWvMqMtKYUynCP3+QIxq5HTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730715869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QONVyxe8S/T0cD5/iGzh2jvCjZgjKOX2yaCeq/joY70=;
	b=551VEPYUjiNMnRPkrslgYNW5G4jRdUCV5lntS3n8g+43d+YG9t2BxoTxCIDURl+u/P4UHd
	Ck9RrBtMdKvlToDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oUVx9LPZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=551VEPYU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730715869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QONVyxe8S/T0cD5/iGzh2jvCjZgjKOX2yaCeq/joY70=;
	b=oUVx9LPZiJdZv9JySK+DzXtr/cMPUK+LAsV6ZHllZFZDMcKVIZdkIOGnxVXz/llxl68SBx
	9oBt4Dk9tE12tNyUdtbZlwFOF9XvqBgqlVEO706g86YeX1wYGpvirmQ/BfLSSmKFS2UAGz
	lFmYVSEkWvMqMtKYUynCP3+QIxq5HTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730715869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QONVyxe8S/T0cD5/iGzh2jvCjZgjKOX2yaCeq/joY70=;
	b=551VEPYUjiNMnRPkrslgYNW5G4jRdUCV5lntS3n8g+43d+YG9t2BxoTxCIDURl+u/P4UHd
	Ck9RrBtMdKvlToDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 151E813736;
	Mon,  4 Nov 2024 10:24:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BEgFBN2gKGfFLwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 04 Nov 2024 10:24:29 +0000
Date: Mon, 04 Nov 2024 11:25:34 +0100
Message-ID: <871pzrcn35.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Murad Masimov <m.masimov@maxima.ru>
Cc: Clemens Ladisch <clemens@ladisch.de>,
	Takashi Sakamoto
	<o-takashi@sakamocchi.jp>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai
	<tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: Re: [PATCH] ALSA: firewire-lib: fix return value on fail in amdtp_tscm_init()
In-Reply-To: <20241101185517.1819-1-m.masimov@maxima.ru>
References: <20241101185517.1819-1-m.masimov@maxima.ru>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: *
X-Spamd-Result: default: False [1.36 / 50.00];
	RSPAMD_URIBL(4.50)[maxima.ru:email];
	BAYES_HAM(-2.93)[99.68%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MX_GOOD(-0.01)[];
	R_DKIM_ALLOW(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: 1.36
X-Spamd-Bar: +
X-Rspamd-Queue-Id: 4ADAB1FDD4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO

On Fri, 01 Nov 2024 19:55:13 +0100,
Murad Masimov wrote:
> 
> If amdtp_stream_init() fails in amdtp_tscm_init(), the latter returns zero,
> though it's supposed to return error code, which is checked inside
> init_stream() in file tascam-stream.c.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 47faeea25ef3 ("ALSA: firewire-tascam: add data block processing layer")
> Signed-off-by: Murad Masimov <m.masimov@maxima.ru>

Applied now.  Thanks.


Takashi

