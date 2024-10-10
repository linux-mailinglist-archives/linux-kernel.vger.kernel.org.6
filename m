Return-Path: <linux-kernel+bounces-358930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B67998574
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF121C238CA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35D21C32E1;
	Thu, 10 Oct 2024 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GEXAoj0M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gxr764gF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GEXAoj0M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gxr764gF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3677E1BD4FD;
	Thu, 10 Oct 2024 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561706; cv=none; b=VXrPWXw89y2PjekptalnhrgGBwOinQeIYBGAtFynmgFzyUvs0ynsdFgu/NhiFdwwGDx8Che4APsWebD2sePiIZ4BYA8jF6sdOSF4X8kqarC1xn2GhqXbvbO8vqEDoX7jIYiAXv1FzvpV7TRw3roCOpMy/lirP1Tl6BooTN/Jb1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561706; c=relaxed/simple;
	bh=tpvO244oO1AWWvJvxAtLZ3TTnq5+64dt1JcZ81ZK+Sw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtpNtGzUwYsjuFZQgNVFnSsoN3pS87TuRXBe8neqZ7JxXVkUhaoYp+9qDTi2MLSaeRnvIX52FReO5OgyxYOcnDqyIoH9Wv6brZdqy6YdTwt54efUF2p2p0WLbLOzzhh2/Mgjb0kU0z/Fqoiiaf2kaj6mGJpodFZGxZPK2zfPmKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GEXAoj0M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gxr764gF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GEXAoj0M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gxr764gF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0782E1FF01;
	Thu, 10 Oct 2024 12:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728561701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lCMfCVjD8asCg63BJswDMoyokyzE9kqZYa09bjaVv/8=;
	b=GEXAoj0MnWmXKTiUAMeNpDuuJUo3cny3xtC7F60Muin1io2hgNuhJz7/SSHRe/kokjBSfn
	AaACdwpMA6LvFsafH3WLHLm49O0phRZP1MEXjkZlZowcN5J9cmUw+9GyMjfzN1TXUi08Tm
	0euSpuTuaLjIgRHhO9O6RZzRDOH9tok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728561701;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lCMfCVjD8asCg63BJswDMoyokyzE9kqZYa09bjaVv/8=;
	b=gxr764gFKXremNkHB10QLfVLg7UlOit/oDdYrldmTMADISEDOBdaMhFWM2YnwBMN09IxCa
	hJoUSwrMMoCJA3Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GEXAoj0M;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gxr764gF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728561701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lCMfCVjD8asCg63BJswDMoyokyzE9kqZYa09bjaVv/8=;
	b=GEXAoj0MnWmXKTiUAMeNpDuuJUo3cny3xtC7F60Muin1io2hgNuhJz7/SSHRe/kokjBSfn
	AaACdwpMA6LvFsafH3WLHLm49O0phRZP1MEXjkZlZowcN5J9cmUw+9GyMjfzN1TXUi08Tm
	0euSpuTuaLjIgRHhO9O6RZzRDOH9tok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728561701;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lCMfCVjD8asCg63BJswDMoyokyzE9kqZYa09bjaVv/8=;
	b=gxr764gFKXremNkHB10QLfVLg7UlOit/oDdYrldmTMADISEDOBdaMhFWM2YnwBMN09IxCa
	hJoUSwrMMoCJA3Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBC1F1370C;
	Thu, 10 Oct 2024 12:01:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vCJaMCTCB2drOAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 10 Oct 2024 12:01:40 +0000
Date: Thu, 10 Oct 2024 14:02:37 +0200
Message-ID: <87zfnc17z6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Karol Kosik <k.kosik@outlook.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Johan Carlsson <johan.carlsson@teenage.engineering>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Fix NULL pointer deref in snd_usb_power_domain_set()
In-Reply-To: <AS8P190MB1285B563C6B5394DB274813FEC782@AS8P190MB1285.EURP190.PROD.OUTLOOK.COM>
References: <AS8P190MB1285B563C6B5394DB274813FEC782@AS8P190MB1285.EURP190.PROD.OUTLOOK.COM>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 0782E1FF01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Thu, 10 Oct 2024 08:59:10 +0200,
Karol Kosik wrote:
> 
> Commit adding support for multiple control interfaces expanded struct
> snd_usb_power_domain with pointer to control interface for proper control
> message routing but missed one initialization point of this structure,
> which has left new field with NULL value.
> 
> Standard mandates that each device has at least one control interface and
> code responsible for power domain does not check for NULL values when
> querying for control interface. This caused some USB devices to crash
> the kernel.
> 
> Fixes: 6aa8700150f7 ("ALSA: usb-audio: Support multiple control interfaces")
> 
> Signed-off-by: Karol Kosik <k.kosik@outlook.com>

It seems that tabs got broken by your mailer, so I applied manually
now.  Please fix your mailer setup at the next time you submit.


thanks,

Takashi

