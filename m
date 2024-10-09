Return-Path: <linux-kernel+bounces-357039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766B3996ABD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D782283A6C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305FA1A3020;
	Wed,  9 Oct 2024 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lobR1fVz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gQM10Th5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ImXhjl7x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="khPux883"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D337A1990AD;
	Wed,  9 Oct 2024 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478122; cv=none; b=kGD5uPgHNWnlOE3BbyA64D2v80Cd1klMj66Ox/TOMsvveLpa+yDHfKaRpjTa32PD7d3VIYFueSqRVC1/zLBbeL9RbZIyZtmFEsrvZ22y+svyKEmBYM8w/ymFu4UQuodkHm5T213zXTTTVuzkGVb27KxXbNMiES7VvMPv7vQ3pbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478122; c=relaxed/simple;
	bh=276w1taUYiND0ce+xeuQyEmjc89J+wryV8F5KKnvxuw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5LprCWN8cNTBvPgdTYDyr5dbjv9PgsjgUtLwEumw9AUNwYdypiUFZ88MkH8o7pGG0Tj9vph6zPoOc7JN+M3S03x95MLxDQ9TQyiwgUzO6VmlqUVtPo2uQDOfXPVWVRP45psVwRs6cCjpOKMSy9VwerOd4XR8WT21d7BoZJdkeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lobR1fVz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gQM10Th5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ImXhjl7x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=khPux883; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E749E21F73;
	Wed,  9 Oct 2024 12:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728478119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BkFbe7VJqv8no7zDISVSnAPmBelGOfpZ3/Qn7YdotWM=;
	b=lobR1fVzzZ3Gcnei+yYcgLZ4bR5iTWY2ylci+qymjSIz53eTBH2tFypJ2jZQDPqCt7dH+y
	qwXg60X35YeD72D6U+vvAfkouqtvZtWlPCYjMUvkYylIFSA9pckDDRme9fKl3v7ZaSj6Ty
	USMSM3/zhd/jZi5+U6v8kPHSCxIBJ/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728478119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BkFbe7VJqv8no7zDISVSnAPmBelGOfpZ3/Qn7YdotWM=;
	b=gQM10Th5GpwgNUUU+Ir84KJf5JrPboyTnkKwaBskWF1ntwjYPAAyjCtubToRVtPDcRi5+2
	BO7SCuzOUpJBGUAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ImXhjl7x;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=khPux883
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728478118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BkFbe7VJqv8no7zDISVSnAPmBelGOfpZ3/Qn7YdotWM=;
	b=ImXhjl7xC4tkQ7OGgoYUq/m9gsqo8pDIu1Us0LqVFQtjVaZosS/CVzdHx1kO1ocz4sXxSR
	YFxjSIGHUuzRdPaWMybta2R8tCMh563rUCoWBlEfOth12wXeZ1ET31dm932s1QX0C/FJ1e
	+m/nu09adug1vJxW+vlslVMC+u3S6S4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728478118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BkFbe7VJqv8no7zDISVSnAPmBelGOfpZ3/Qn7YdotWM=;
	b=khPux883tZTkN1561HAbPDonf0bGt+6EWolDRkwNS73fjyXJ19+BdiZi7G2FFwSpN/wb90
	GxHp47DyrZhvLOBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADD44136BA;
	Wed,  9 Oct 2024 12:48:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9AI6KaZ7Bme3IgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 09 Oct 2024 12:48:38 +0000
Date: Wed, 09 Oct 2024 14:49:34 +0200
Message-ID: <87plo9tp9d.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bo liu <bo.liu@senarytech.com>
Subject: Re: [PATCH] ALSA: hda/conexant - Fix audio routing for HP EliteOne 1000 G2
In-Reply-To: <b585fdc8-cc45-30e5-9f32-bc04d6df0244@basealt.ru>
References: <20241009111207.655842-1-kovalev@altlinux.org>
	<87v7y1tr3n.wl-tiwai@suse.de>
	<b585fdc8-cc45-30e5-9f32-bc04d6df0244@basealt.ru>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: E749E21F73
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 09 Oct 2024 14:28:47 +0200,
Vasiliy Kovalev wrote:
> 
> Hi,
> 
> 09.10.2024 15:09, Takashi Iwai wrote:
> > On Wed, 09 Oct 2024 13:12:07 +0200,
> > Vasiliy Kovalev wrote:
> >> 
> >> There is a problem with simultaneous audio output to headphones and
> >> speakers, and when headphones are turned off, the speakers also turn
> >> off and do not turn them on.
> >> 
> >> However, it was found that if you boot linux immediately after windows,
> >> there are no such problems. When comparing alsa-info, the only difference
> >> is the different configuration of Node 0x1d:
> >> 
> >> working conf. (windows): Pin-ctls: 0x80: HP
> >> not working     (linux): Pin-ctls: 0xc0: OUT HP
> >> 
> >> This patch disable the AC_PINCTL_OUT_EN bit of Node 0x1d and fixes the
> >> described problem.
> >> 
> >> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> > 
> > Interesting, is this pin not used by any routes, but it has to be set
> > up? 
> 
> Yes, I tried configuring this 0x1d address in hdajackretask for
> headphones and speakers, but to no avail. I also tried various hints,
> for example, inv_jack_detect=yes turned on the speakers, but at the
> same time the headphones stopped working and the system showed inverse
> detection. That is, changing this patch is the only way so far.
> 
> I have attached two logs to the message:
> alsa-info.ERR.txt - the first linux boot
> alsa-info.OK.txt  - booting linux after windows

OK, then could you add more comments to the quirk function and
resubmit?  I guess we don't have to read the original value but just
use the fixed value for snd_hda_set_pin_ctl() for simplicity, too.


thanks,

Takashi

