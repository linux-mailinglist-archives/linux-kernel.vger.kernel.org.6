Return-Path: <linux-kernel+bounces-535980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D86A47A08
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD6C16DE9A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71368227563;
	Thu, 27 Feb 2025 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e4sYQt5L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3ffahikF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JlIYfMy2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aBOvGw1d"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260B916F288
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651676; cv=none; b=kEmI7XwMB6HWIyASmE/DOY9MHEzM0ulkwX/3xnTyIZv08RUmgw1+5SW3ftmg3Kczs4AFOu4smY2O+4/owOe3wTvtX5vFFiH/MjqPrj1/QbycCK1c50rpF5TB2ZTIeFUGr7r9o9GFUG6lBmm6SzunPs/Ce02i0jfl7izhRcX2kdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651676; c=relaxed/simple;
	bh=YoV0Ho8VbeX7QdfnW9hKC4inbEbS7ucIBRTNRRxc9H4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UiKbHD7X5adZ7h3/q/K+Z836We0vpwpyCtfGGNtu4Jayrvx453MvQj/3PPRXXw8jiEnnFlTebLSPhSonM1UQfTtnVIdwF54zzx4m37hAMK3Oil5pfW3AgHfSqC3+p+pHmb38yH/cn/nGLhKrLeWRiwkzjBVC6Ip47bmEve/JD1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e4sYQt5L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3ffahikF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JlIYfMy2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aBOvGw1d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 324001F38A;
	Thu, 27 Feb 2025 10:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740651673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzzF53d4A8R5a5kWjqkAAyKX91eyek1MAytqRR0wP0Y=;
	b=e4sYQt5L+K8DH6ZcE2tqdgdS0QqkUUEerzjE9/iN8OnJ+hr4wc9iwz2zWblx7OSu+4iY+Q
	uvL48Aedtk+9Mo0gwpfNKdZvrHrMDn+OlVIQW6XYP/s+RT0H/a8zesDbCd+IswTV4Qk/Q6
	vt+SGdoxik6CqIDtCQEasb7FSGpGe40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740651673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzzF53d4A8R5a5kWjqkAAyKX91eyek1MAytqRR0wP0Y=;
	b=3ffahikFm8SXC2EOuM3dPF9kOGJ+rzXZZLBSzsUiG4eqB5dilyB2rE5njE2Nb7a+QHetyV
	JdEdD/T1igGmJNAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740651672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzzF53d4A8R5a5kWjqkAAyKX91eyek1MAytqRR0wP0Y=;
	b=JlIYfMy2CdlCI9JSf22WJQXl83Mc/KyEfJyUsnSlJ1w4lwIoEGSEycy6G3zuZBIRpLpAQ1
	oWo6hV5oxpMlEVuVQRTetH71Cv+lggdgUYVaVLZf9hs+Co3rtqFUvgC/UbxBAfACk3SGgS
	mUeaWd8zyf0X+2scf8cwLRluVk2LU/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740651672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzzF53d4A8R5a5kWjqkAAyKX91eyek1MAytqRR0wP0Y=;
	b=aBOvGw1d86fnIPnqDKviMZd6KOSJo3EpQq65YUQEAz10gHU+Dplek1QfmxU2uEng1ttjhb
	g3e+WCn72cPH8pDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF71A1376A;
	Thu, 27 Feb 2025 10:21:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b8/YOJc8wGdxJQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 27 Feb 2025 10:21:11 +0000
Date: Thu, 27 Feb 2025 11:21:11 +0100
Message-ID: <87frjz7ko8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Charles Han <hanchunchao@inspur.com>
Cc: <perex@perex.cz>,
	<tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: seq: seq_oss_event: fix inconsistent indenting warning in note_on_event()
In-Reply-To: <20250227092441.19044-1-hanchunchao@inspur.com>
References: <20250227092441.19044-1-hanchunchao@inspur.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[inspur.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 27 Feb 2025 10:24:41 +0100,
Charles Han wrote:
> 
> Fix below inconsistent indenting smatch warning.
> smatch warnings:
> sound/core/seq/oss/seq_oss_event.c:297 note_on_event() warn: inconsistent indenting
> 
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  sound/core/seq/oss/seq_oss_event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/core/seq/oss/seq_oss_event.c b/sound/core/seq/oss/seq_oss_event.c
> index 7b7c925dd3aa..9a42713c7bdd 100644
> --- a/sound/core/seq/oss/seq_oss_event.c
> +++ b/sound/core/seq/oss/seq_oss_event.c
> @@ -294,7 +294,7 @@ note_on_event(struct seq_oss_devinfo *dp, int dev, int ch, int note, int vel, st
>  				/* set volume to zero -- note off */
>  			//	type = SNDRV_SEQ_EVENT_NOTEOFF;
>  			//else
> -				if (info->ch[ch].vel)
> +			if (info->ch[ch].vel)
>  				/* sample already started -- volume change */
>  				type = SNDRV_SEQ_EVENT_KEYPRESS;
>  			else

I'd rather clean up the commented-out dead lines and fix the indent as
well.  The indent was because of the "else" line.

Care to resubmit with that?


thanks,

Takashi

