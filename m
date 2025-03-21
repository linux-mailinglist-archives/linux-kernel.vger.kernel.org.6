Return-Path: <linux-kernel+bounces-571841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 126C4A6C301
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA711B628EE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BB622E3F1;
	Fri, 21 Mar 2025 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TNNh7tpo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sczX0TCN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TNNh7tpo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sczX0TCN"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A983154426
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742584107; cv=none; b=WyckVN90MDUsQP/tMs2koSoZ1t+I0meARE6gBdIxL8xtfcfdgufzcVe0E8VRM+xmKMjSsJ6NwzrGeyNECUm2zg4o/L5+KUBhDoD8JsbgQFDNrrM8wO98vuuX1CeEsv5ncB64pY2gKJ2l0+x5euK6uxkq+txjnZie010urSbTe60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742584107; c=relaxed/simple;
	bh=3ob7dWnddRt7NjhXz3FcRpTbvHcFlALDzT4Ho7pFvIA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rqTALxXTZKhftuTajg2+O4d+JvtaMCX+tz6JovYpuOQIfiTTh7vPJAWX/LRs4Up6LvggPQkNen+QckuE+/AamikSCFpKBmZvVTEDAszuz3QOTXgNgXDC/uO19GWLNKQQmbqJoJxTvORPJCoTU+EF6C+z4PUQjyl9Z7oiDf4H7To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TNNh7tpo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sczX0TCN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TNNh7tpo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sczX0TCN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 955071FCF5;
	Fri, 21 Mar 2025 19:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742584103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TxfzUjstrgUZ2nQluVCGRlxri+auozNaRVyG3dPT8Tk=;
	b=TNNh7tpom1OngPUO8IN1B4FuDteGntQaPHhnyyEOjVVlklo+9jO0lGBFQ8vKGgbPfGioja
	0EDYBDmXKQIKdN0AMicb4E1hHQZB4dT9DGMAhmzG4Xfe9Ddg4g4S8EFCil91DtMDzlZboX
	JKAdSnN7AEHJuVCi6i7fUF6Y431WhAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742584103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TxfzUjstrgUZ2nQluVCGRlxri+auozNaRVyG3dPT8Tk=;
	b=sczX0TCNSbAsOVQOSD/w+Fo6KX6C4nFYB5/meRGO8o5YjlomEB/MDKlqUDksWOuMb0zstN
	gfxYlUtyDDf7TKDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TNNh7tpo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sczX0TCN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742584103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TxfzUjstrgUZ2nQluVCGRlxri+auozNaRVyG3dPT8Tk=;
	b=TNNh7tpom1OngPUO8IN1B4FuDteGntQaPHhnyyEOjVVlklo+9jO0lGBFQ8vKGgbPfGioja
	0EDYBDmXKQIKdN0AMicb4E1hHQZB4dT9DGMAhmzG4Xfe9Ddg4g4S8EFCil91DtMDzlZboX
	JKAdSnN7AEHJuVCi6i7fUF6Y431WhAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742584103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TxfzUjstrgUZ2nQluVCGRlxri+auozNaRVyG3dPT8Tk=;
	b=sczX0TCNSbAsOVQOSD/w+Fo6KX6C4nFYB5/meRGO8o5YjlomEB/MDKlqUDksWOuMb0zstN
	gfxYlUtyDDf7TKDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62A6B139AA;
	Fri, 21 Mar 2025 19:08:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 80xxFie53WeSUQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 21 Mar 2025 19:08:23 +0000
Date: Fri, 21 Mar 2025 20:08:22 +0100
Message-ID: <87frj6td5l.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v1] ALSA: hda/realtek: Add support for various HP Laptops using CS35L41 HDA
In-Reply-To: <20250321175040.800963-1-sbinding@opensource.cirrus.com>
References: <20250321175040.800963-1-sbinding@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 955071FCF5
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Fri, 21 Mar 2025 18:50:06 +0100,
Stefan Binding wrote:
> 
> Add support for HP Cadet, Clipper OmniBook, Turbine OmniBook, Trekker,
> Enstrom Onmibook, Piston Omnibook
> 
> Laptops use 2 CS35L41 Amps with HDA, using Internal boost, with I2C
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

This seems conflicting with the recent changes.
Could you try to rebase to for-linus branch and resubmit?


thanks,

Takashi

