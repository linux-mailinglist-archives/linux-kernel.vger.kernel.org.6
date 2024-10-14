Return-Path: <linux-kernel+bounces-363754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB83599C697
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0D91F23766
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B763B158A18;
	Mon, 14 Oct 2024 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vGYpR7oS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s6IqQwRh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vGYpR7oS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s6IqQwRh"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4F158870
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899976; cv=none; b=jeL/MzEPHlQzyVhwaw6+fVgbyhjbaxIarzXWSaRSwtzKMbu7xeiP9Y8mbCsPSTXCs9h2so2Vdr2M7UIYsG6/lR+sCGnqc89Egp1boXuyTyIkdxva2D5D7eTR+9aTpHqIa4xEjWkBx48JPTNH8zazNUxWAWNzwChM7eND7ScXxSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899976; c=relaxed/simple;
	bh=lvKzRKA1STie5+wdivnzCDVeEz3EssOMyCHz2JZV8M0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhKjpyKkihQPtGbcUr+Ub/mi8MIYZH9wTEzlz4pSNTnVUpjBg91IdLVUpLmAEj//VPa0K2LEyW+6IvL61ipIJ3vhacBkbMYHHveGTDo8mEE6hPLo4Z9Qa3V4GBQtz47SFVcTShqD3nOu9Yduxw7lKVaL6NErUoSLFDj01+pTdYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vGYpR7oS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s6IqQwRh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vGYpR7oS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s6IqQwRh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64EDC21BE1;
	Mon, 14 Oct 2024 09:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728899972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tS2RxcoySz23bKjqPH4GWyNxVK5w2YGKCrvQPwppOas=;
	b=vGYpR7oSIRzJP2583h/7livmmLSVIuKsrPQeZchJ2/Fn1yrliNWf6Q8Ig11jhB+IWBrRHt
	zfIL/M4JW3faI0FTlXBQepxJqkSET8GPRR8n1432I37N2dEmgxtYtB5j+9aA5sA3UCVWux
	yMaFzT77XTtK4pG0TuEGbr9ESarCJXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728899972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tS2RxcoySz23bKjqPH4GWyNxVK5w2YGKCrvQPwppOas=;
	b=s6IqQwRhJ1UCslkqVr+oVjaNc0C66H1lkfNZWwI8Ok38qAkN4Bctt86r9G06CUUca0iPND
	vjRWypZ8H+y7YbCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vGYpR7oS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=s6IqQwRh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728899972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tS2RxcoySz23bKjqPH4GWyNxVK5w2YGKCrvQPwppOas=;
	b=vGYpR7oSIRzJP2583h/7livmmLSVIuKsrPQeZchJ2/Fn1yrliNWf6Q8Ig11jhB+IWBrRHt
	zfIL/M4JW3faI0FTlXBQepxJqkSET8GPRR8n1432I37N2dEmgxtYtB5j+9aA5sA3UCVWux
	yMaFzT77XTtK4pG0TuEGbr9ESarCJXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728899972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tS2RxcoySz23bKjqPH4GWyNxVK5w2YGKCrvQPwppOas=;
	b=s6IqQwRhJ1UCslkqVr+oVjaNc0C66H1lkfNZWwI8Ok38qAkN4Bctt86r9G06CUUca0iPND
	vjRWypZ8H+y7YbCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C71E613A51;
	Mon, 14 Oct 2024 09:59:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b0/+LoPrDGeOEgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 14 Oct 2024 09:59:31 +0000
Date: Mon, 14 Oct 2024 12:00:29 +0200
Message-ID: <87frozj96q.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baojun Xu <baojun.xu@ti.com>
Cc: <robh+dt@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<lgirdwood@gmail.com>,
	<perex@perex.cz>,
	<pierre-louis.bossart@linux.intel.com>,
	<kevin-lu@ti.com>,
	<shenghao-ding@ti.com>,
	<navada@ti.com>,
	<13916275206@139.com>,
	<v-hampiholi@ti.com>,
	<v-po@ti.com>,
	<niranjan.hy@ti.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<liam.r.girdwood@intel.com>,
	<yung-chuan.liao@linux.intel.com>,
	<broonie@kernel.org>,
	<soyer@irl.hu>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Add new quirk for Lenovo, ASUS, Dell projects
In-Reply-To: <20241011074040.524-1-baojun.xu@ti.com>
References: <20241011074040.524-1-baojun.xu@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 64EDC21BE1
X-Spam-Level: 
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,perex.cz,ti.com,139.com,alsa-project.org,vger.kernel.org,intel.com,irl.hu];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.01
X-Spam-Flag: NO

On Fri, 11 Oct 2024 09:40:40 +0200,
Baojun Xu wrote:
> 
> Add new vendor_id and subsystem_id in quirk for Lenovo, ASUS,
> and Dell projects.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>

Applied now.  Thanks.


Takashi

