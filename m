Return-Path: <linux-kernel+bounces-290769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2872955861
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 16:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E021F2232A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650D2C2F2;
	Sat, 17 Aug 2024 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ewOMJnjd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vUQo0VU7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ewOMJnjd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vUQo0VU7"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FB18F40;
	Sat, 17 Aug 2024 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723905203; cv=none; b=JrgI9tE58y4wsnT3+rkff74a2TnyAoC6vJHe+AzHcF1dqaj78DjAqRovBYkO3lClM2QophDwCbYX3ImkqtCJW8EX+72jrekikFNc9Liaj7WXyvsdfnf+nqnhBGZAHgIEbjoW8O3vmWZfBYlhwaiRfzMmrguf+VWk3gO62zNrgss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723905203; c=relaxed/simple;
	bh=Dd2hSN40Umb1jQk3NKaLC/vMNlZO8EYr901d+sqxtLY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3YVt4M4ZczTp5oRlcQU5xVLwIyLX7MVEKP4GG3tjjlaqx1De72CeqRf1xqOO5Q0czyVETvCH/xYWKWc28Vzz0kyoQbcc7J9N+2m6YWpyFiNfBIKoRFTwpnrujh9tbE41FKiZ6alesYvAypdjmhfUC18l59lxPh5sLQRrQIVrK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ewOMJnjd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vUQo0VU7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ewOMJnjd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vUQo0VU7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08EF922525;
	Sat, 17 Aug 2024 14:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723905200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KzKGiyBT5DWBz1kLtKqWaET8TXhfyQzBOIdEy+znmS4=;
	b=ewOMJnjdtmGUnuEXkY2xgdtLR+nA5vBPJS7UgvvsM8kHIW0WWmeebBCSz/69kNXVyki/f8
	ppWfpujZaKbfn1PgW3C5xNtAFHY3RfnETZMwCNxe2wNycIYwG18HIZpvp/Ey45K6FSlJrU
	EKScQYBcWoSQWuZGVl9xRV0SAVkYXTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723905200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KzKGiyBT5DWBz1kLtKqWaET8TXhfyQzBOIdEy+znmS4=;
	b=vUQo0VU703YX8ZK8z0kZT6d8TyPBj3D60433WQ5sFhpwNfRSFwId+m7xHn40/GE4+QJIrz
	mW7gOD12Yl9uoSBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ewOMJnjd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vUQo0VU7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723905200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KzKGiyBT5DWBz1kLtKqWaET8TXhfyQzBOIdEy+znmS4=;
	b=ewOMJnjdtmGUnuEXkY2xgdtLR+nA5vBPJS7UgvvsM8kHIW0WWmeebBCSz/69kNXVyki/f8
	ppWfpujZaKbfn1PgW3C5xNtAFHY3RfnETZMwCNxe2wNycIYwG18HIZpvp/Ey45K6FSlJrU
	EKScQYBcWoSQWuZGVl9xRV0SAVkYXTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723905200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KzKGiyBT5DWBz1kLtKqWaET8TXhfyQzBOIdEy+znmS4=;
	b=vUQo0VU703YX8ZK8z0kZT6d8TyPBj3D60433WQ5sFhpwNfRSFwId+m7xHn40/GE4+QJIrz
	mW7gOD12Yl9uoSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D51071397F;
	Sat, 17 Aug 2024 14:33:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I7HHMq+0wGaxWgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 17 Aug 2024 14:33:19 +0000
Date: Sat, 17 Aug 2024 16:34:01 +0200
Message-ID: <87le0v1ana.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: <perex@perex.cz>,
	<tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] ALSA: trident: Remove unused declarations
In-Reply-To: <20240817093527.1120240-1-yuehaibing@huawei.com>
References: <20240817093527.1120240-1-yuehaibing@huawei.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 08EF922525
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,huawei.com:email]
X-Spam-Score: -3.51

On Sat, 17 Aug 2024 11:35:27 +0200,
Yue Haibing wrote:
> 
> Commit 8bb8b453cb45 ("[ALSA] trident - clean up obsolete synth codes")
> remove synth functions but leave declarations.
> And Commit e5723b41abe5 ("[ALSA] Remove sequencer instrument layer")
> left snd_trident_attach_synthesizer().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Applied now.  Thanks.


Takashi

