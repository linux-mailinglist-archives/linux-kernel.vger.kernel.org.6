Return-Path: <linux-kernel+bounces-576580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42131A7115B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B6116565B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BFC19C578;
	Wed, 26 Mar 2025 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OP8ksSPc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z/7SdtK+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I5UYyivD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F0W7tIKP"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C957C2E3361
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742974026; cv=none; b=r6HqfUtkqhg18QooT0Z5eqKPZKdlOqTgaPiRD9MNFqeM2tUvEQwp5A2P6NdgTa1B19feeo/zPURlW7v2xKb4xC1zYRDglsko9rsSLA1qkL0pr19eedzUzphXhjGSc0ssQHh3xduZS5n6pNX+E0q3zBUDPIE8HTkOuy1tDY5i8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742974026; c=relaxed/simple;
	bh=1kz1EtJpGc7SEihOU8uWwIy6si6Se9ElCW89nQAJWfM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMy1CyZfr9pRbP1tCDB1A4sNl2/Rm2imB9cvBnX9eQ3gs+qeLGACdaaHpp3uJV/8MU59A6tUH7ZtNjMZJ38oWizGUER1AgSb867hinkLngeOsZE8Dde73Ul1k7R5nNWWPNAz1nxDCMX3z0eREcOY6HX6G60WTb00NBcMnIXa0DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OP8ksSPc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z/7SdtK+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I5UYyivD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F0W7tIKP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CEC6821185;
	Wed, 26 Mar 2025 07:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742974016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTB+eZH7dmSWObSm8wqs7dacimcYNTWpAIiwPmgIVW0=;
	b=OP8ksSPcN+Jg63gLHgW7t4PCPu9tngAfhM8a27wUQ778KV2JjkDqC2+H3v24hYsPmcxWxH
	rLp+Y9n6TL0AWgp1W9YoVg4SaTAXXDJkmtdYsq0Cw5EvcEwGHstiVB9EQIjGC37uvZGe5p
	tjEAt35bdKSCb8l42A/vyFVgcBQ4jNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742974016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTB+eZH7dmSWObSm8wqs7dacimcYNTWpAIiwPmgIVW0=;
	b=Z/7SdtK+q4ukmxmOhyQdmGInxbK3kOkKAa178RuWKxV+EbAVVrp1G2HWRVNMiFEPupZZPv
	wPwp793DYWsyGSBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=I5UYyivD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=F0W7tIKP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742974015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTB+eZH7dmSWObSm8wqs7dacimcYNTWpAIiwPmgIVW0=;
	b=I5UYyivDaTh+CfknXnztySHEDWA5umUEafOw7kid2n6eXzwfeRwBaBMnx3ZemJGf/nJIsJ
	KjiICPFseOc9Nm4SiosGoclFgR8m1MMiUjBhR769Roys2w0s6nQPdeguDY0e1TQjtrDe8d
	swe9uQqqBqo6GbN+XOyaKxBRSI7y7sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742974015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTB+eZH7dmSWObSm8wqs7dacimcYNTWpAIiwPmgIVW0=;
	b=F0W7tIKPOV3eP2yksC8CDFNlT1ahgprbI0n/nH00HQ9U1crlxTZa7EE7YlWnuBvW98ReG0
	IO+AWeomHl7GRxAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A171B1374A;
	Wed, 26 Mar 2025 07:26:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a22yJT+s42dcPgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 26 Mar 2025 07:26:55 +0000
Date: Wed, 26 Mar 2025 08:26:55 +0100
Message-ID: <87cye4b6bk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sharwesh05 <sharweshraajan@gmail.com>
Cc: tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 	modified:   sound/pci/hda/patch_realtek.c
In-Reply-To: <20250325150510.31452-1-sharweshraajan@gmail.com>
References: <20250325150510.31452-1-sharweshraajan@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: CEC6821185
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
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 25 Mar 2025 16:05:10 +0100,
Sharwesh05 wrote:
> 

Thanks for the patch.

But, please make the patch in a proper format, namely, have the
appropriate Subject line starting with the prefix "ALSA: hda/realtek:"
and containing the concise description about the patch.  Then put more
information about the changes (why it's needed and what it fixes /
changes) in the patch description, followed by a blank line, and most
importantly, your Signed-off-by tag with your real name and address;
it's a legal requirement.

Please check Documentation/admin/submitting-patches.rst for details.

About the code change:

> ---
>  sound/pci/hda/patch_realtek.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index a84857a3c2bf..8c2375476952 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -4739,6 +4739,21 @@ static void alc245_fixup_hp_mute_led_coefbit(struct hda_codec *codec,
>  		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
>  	}
>  }
> +static void alc245_fixup_hp_mute_led_v1_coefbit(struct hda_codec *codec,
> +					    const struct hda_fixup *fix,
> +						int action)

Put a blank line before the function.

Could you correct the above and resubmit?


thanks,

Takashi

