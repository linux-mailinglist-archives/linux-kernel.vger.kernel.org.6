Return-Path: <linux-kernel+bounces-572260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17D7A6C859
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 09:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D63F1B61490
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 08:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444FE1DE2BD;
	Sat, 22 Mar 2025 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z4mvDCOJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9VelYOyH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z4mvDCOJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9VelYOyH"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3361DAC95
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742632260; cv=none; b=epjSLFKtzA4wSX8D/u3UEzT3MUzFtnVqi878w0B0d7mEzLFobHoshiU1TmtCsjrM8urc7meBi4Bc59FRDdoE7rKyPycbW1hvOOUAEXj3ERjf5L0kqw7k0PC3eNmY8NY9KvcTu1ev1saE9yfEzWOESen61SeKROnNeOutHhLBJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742632260; c=relaxed/simple;
	bh=ofYtQbBAKo553J0J0+bpj11xImPgmsV0KiR3yZzKmug=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+E+0jhlQj97krj6F11REFXRO4o4e+320vLRWY3X46tRUkqLy6JSinzmpawMY93c5vVAkLNz1RBKqQQR24qO/8kkUYwiis74Z0KzsWE2sZQ3VF2WjgRxWkfsRmHSPA8Nhm+KkZaL1HqmvFLzOiIOmrRrQGqc1faolPC3cskCPN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z4mvDCOJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9VelYOyH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z4mvDCOJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9VelYOyH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F55721E13;
	Sat, 22 Mar 2025 08:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742632257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dEJztIMG7d0L+YIRegaxEOuDHNuhYzP5+1zLra1O5eQ=;
	b=Z4mvDCOJbyiG3AK94LFg+BooLFTYJKP+7q7bUi3lw1VdkhZXSCKjOlGmBQdEtdGfQ1Dhrl
	aiVHlIVp6gjQFvUReaUjHLuOayBk/fhEUH471MTEXHZ8k502JKmF03CxK+iuHl36IAhP/Q
	DDTrhu4yqGBa4dcCdlvWDBXFbcVqv1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742632257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dEJztIMG7d0L+YIRegaxEOuDHNuhYzP5+1zLra1O5eQ=;
	b=9VelYOyH6J6Y9WoKbyR9pZdF2qllqeeq0cGbLcu5un7ZxwXdEdtAQ6p8Pb39yXvV71N2NH
	yZ8LFJSsCJMt2LDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Z4mvDCOJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9VelYOyH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742632257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dEJztIMG7d0L+YIRegaxEOuDHNuhYzP5+1zLra1O5eQ=;
	b=Z4mvDCOJbyiG3AK94LFg+BooLFTYJKP+7q7bUi3lw1VdkhZXSCKjOlGmBQdEtdGfQ1Dhrl
	aiVHlIVp6gjQFvUReaUjHLuOayBk/fhEUH471MTEXHZ8k502JKmF03CxK+iuHl36IAhP/Q
	DDTrhu4yqGBa4dcCdlvWDBXFbcVqv1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742632257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dEJztIMG7d0L+YIRegaxEOuDHNuhYzP5+1zLra1O5eQ=;
	b=9VelYOyH6J6Y9WoKbyR9pZdF2qllqeeq0cGbLcu5un7ZxwXdEdtAQ6p8Pb39yXvV71N2NH
	yZ8LFJSsCJMt2LDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D621B13A38;
	Sat, 22 Mar 2025 08:30:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vs8JM0B13mdwFgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 22 Mar 2025 08:30:56 +0000
Date: Sat, 22 Mar 2025 09:30:56 +0100
Message-ID: <87a59dtqkf.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v2] ALSA: hda/realtek: Add support for various HP Laptops using CS35L41 HDA
In-Reply-To: <20250321231717.1232792-1-sbinding@opensource.cirrus.com>
References: <20250321231717.1232792-1-sbinding@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 0F55721E13
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Sat, 22 Mar 2025 00:16:36 +0100,
Stefan Binding wrote:
> 
> Add support for HP Cadet, Clipper OmniBook, Turbine OmniBook, Trekker,
> Enstrom Onmibook, Piston Omnibook
> 
> Laptops use 2 CS35L41 Amps with HDA, using Internal boost, with I2C
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Applied now.  Thanks.


Takashi

