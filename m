Return-Path: <linux-kernel+bounces-407145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FCB9C6960
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0993BB24399
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6075417BB13;
	Wed, 13 Nov 2024 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bdyg5JVr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o0yHErMn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bdyg5JVr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o0yHErMn"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FE82594;
	Wed, 13 Nov 2024 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731479832; cv=none; b=VGl7wvE/APp39xQRdg3XZvCQ9uccWVlZXq4nvJeluoPrQoakH1h0TZXte/OETW5kLPYIHRcgsD/SA6EJDgrPP2dS0pZTRg8LkzoJH0vY3CrTkKxUaC/dBkIGcJJCufB8d02tMDigPcBLBIqXg+dq3VAFjMwT4tsJgpzw8cP9mH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731479832; c=relaxed/simple;
	bh=1EgrhR3on3jzM/0V8F+3zII6aqLifXC0C8mJLiXPyEw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAsMv+MQi2RnHlA9Ooq9nxsaSyaipAN2N3hsh6KpzIa440pr95ks4lhF01kfcViraiFlp5UudpSuTpgR5wPn1TaJ45G84otJCgVSHx6wNub0j6v8+GnVUWBZaz6jBytghQ91S28YEwTIshz5IWwUw3WWsjsfu9BBSZSYim1IhVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bdyg5JVr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o0yHErMn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bdyg5JVr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o0yHErMn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6770C1F365;
	Wed, 13 Nov 2024 06:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731479829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vdB8dEUdXNhcMEH8g70pkGBG55AelLUk5EA29jMJvsM=;
	b=bdyg5JVrfkdZTjsRV0t9P4SPuBLSuKPFz5MxtFRz5Jra+0bGxYdL8JsNoMGQSH0fmedqCK
	puGIpE1BQdHkESoWbijCepE2EjQmtlECdTs9NRpmSF9g9Do/BLjQon4t5RBVZhPVFdDL06
	1zENwgf/s/2z771/cy4k15nIAzKi4Dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731479829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vdB8dEUdXNhcMEH8g70pkGBG55AelLUk5EA29jMJvsM=;
	b=o0yHErMn3peAa8yCX9bhbYSnI0HJKR1UrGQ9iSwkRtERboBWpvAiTux3ZJ1fhkuIKpxThb
	2ZgUTF1ZsMPIv9DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bdyg5JVr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=o0yHErMn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731479829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vdB8dEUdXNhcMEH8g70pkGBG55AelLUk5EA29jMJvsM=;
	b=bdyg5JVrfkdZTjsRV0t9P4SPuBLSuKPFz5MxtFRz5Jra+0bGxYdL8JsNoMGQSH0fmedqCK
	puGIpE1BQdHkESoWbijCepE2EjQmtlECdTs9NRpmSF9g9Do/BLjQon4t5RBVZhPVFdDL06
	1zENwgf/s/2z771/cy4k15nIAzKi4Dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731479829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vdB8dEUdXNhcMEH8g70pkGBG55AelLUk5EA29jMJvsM=;
	b=o0yHErMn3peAa8yCX9bhbYSnI0HJKR1UrGQ9iSwkRtERboBWpvAiTux3ZJ1fhkuIKpxThb
	2ZgUTF1ZsMPIv9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40A4013301;
	Wed, 13 Nov 2024 06:37:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1/FqDhVJNGeMCgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 13 Nov 2024 06:37:09 +0000
Date: Wed, 13 Nov 2024 07:37:08 +0100
Message-ID: <87wmh7skq3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Maksym Glubokiy <maxgl.kernel@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs for a HP EliteBook 645 G10
In-Reply-To: <20241112154815.10888-1-maxgl.kernel@gmail.com>
References: <20241112154815.10888-1-maxgl.kernel@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 6770C1F365
X-Spam-Level: 
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.01
X-Spam-Flag: NO

On Tue, 12 Nov 2024 16:48:15 +0100,
Maksym Glubokiy wrote:
> 
> HP EliteBook 645 G10 uses ALC236 codec and need the
> ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to make mute LED and
> micmute LED work.
> 
> Signed-off-by: Maksym Glubokiy <maxgl.kernel@gmail.com>

Thanks, applied now.


Takashi

