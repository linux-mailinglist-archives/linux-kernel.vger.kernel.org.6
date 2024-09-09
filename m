Return-Path: <linux-kernel+bounces-321114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDA99714A9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD17D281468
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905871B3B02;
	Mon,  9 Sep 2024 10:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IOkk/kGr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5wD6Xpyx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IOkk/kGr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5wD6Xpyx"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471B91B2519;
	Mon,  9 Sep 2024 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876181; cv=none; b=Zkei/k8cQeSypQi73kyV2HTcel6x7YVXh81/GYDCZbo+PmSixTwuqadMuPdiNc9vFvVg+BFDKB3P07InrA9Wht3N9/SaJwx1RlneW1tbAqFRnTPgxu9uY9aj2LE+7bNlyWsnyeezCtlyhuXN7Aal5oSdU09iJyeWHebZnsUseLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876181; c=relaxed/simple;
	bh=QyYTZyx1I3L7IkMpLtaF1TMsnO5dFt99PjD94R3Zaqo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMW86wCaeln7NgrDSjMufh2f1NpNMk7MKSjqCtetX0Z08NRDGqcv1CQOs6GiShCGaZeWOPA1Ee9KwA9K6O+0fs99CQB8xcZ/LVJ8WtKAuuKuhcpuNhXAvGE5rD9R1VLKfzGljPQAgUCzyVxI/IVtnDYmFRwjEKSOIyRpdUQIc3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IOkk/kGr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5wD6Xpyx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IOkk/kGr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5wD6Xpyx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B79A1F7AB;
	Mon,  9 Sep 2024 10:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725876177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afWdfk+vDO5vn6q9+J+N/P01T5vWfYx+54v1NaOroSw=;
	b=IOkk/kGrr+0+GMhHWf21cMY7JS02B52/NC7qn9DdM9y4cwu5WRA9Gk/zMmNHNUamjLCroE
	n1DET7zmjwD+ziRcV9lVW8797k11cKEBEgia1gQcUP4M5x5Fy2vTOQbUhuA7hF+NRvoSqn
	ZApNHMuCfnVWO8EMhS3Wm3lKF52F+A0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725876177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afWdfk+vDO5vn6q9+J+N/P01T5vWfYx+54v1NaOroSw=;
	b=5wD6XpyxpplP5qgslCHGQEOGxbSkXFBrVwFfTgDu62F12s8NUPeANA1A1cmJ/LlxTWc7YO
	baA4ANQdkihyOnCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="IOkk/kGr";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5wD6Xpyx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725876177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afWdfk+vDO5vn6q9+J+N/P01T5vWfYx+54v1NaOroSw=;
	b=IOkk/kGrr+0+GMhHWf21cMY7JS02B52/NC7qn9DdM9y4cwu5WRA9Gk/zMmNHNUamjLCroE
	n1DET7zmjwD+ziRcV9lVW8797k11cKEBEgia1gQcUP4M5x5Fy2vTOQbUhuA7hF+NRvoSqn
	ZApNHMuCfnVWO8EMhS3Wm3lKF52F+A0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725876177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afWdfk+vDO5vn6q9+J+N/P01T5vWfYx+54v1NaOroSw=;
	b=5wD6XpyxpplP5qgslCHGQEOGxbSkXFBrVwFfTgDu62F12s8NUPeANA1A1cmJ/LlxTWc7YO
	baA4ANQdkihyOnCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C8FB13312;
	Mon,  9 Sep 2024 10:02:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MZp6EdHH3mbZDwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 09 Sep 2024 10:02:57 +0000
Date: Mon, 09 Sep 2024 12:03:44 +0200
Message-ID: <877cblb0u7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: zenghongling <zenghongling@kylinos.cn>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	zhongling0719@126.com
Subject: Re: [PATCH v2] ALSA: hda/cs8409: Support new Dell Dolphin for device
In-Reply-To: <20240909014457.610682-1-zenghongling@kylinos.cn>
References: <20240909014457.610682-1-zenghongling@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 7B79A1F7AB
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[126.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,perex.cz,suse.com,126.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 09 Sep 2024 03:44:57 +0200,
zenghongling wrote:
> 
> Add 1 new Dell Dolphin Systems, same configuration as older systems.
> 
> Signed-off-by: zenghongling <zenghongling@kylinos.cn>
> ---
>  sound/pci/hda/patch_cs8409-tables.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
> index 36b411d1..be0cc48 100644
> --- a/sound/pci/hda/patch_cs8409-tables.c
> +++ b/sound/pci/hda/patch_cs8409-tables.c
> @@ -541,6 +541,7 @@ const struct snd_pci_quirk cs8409_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x1028, 0x0BBB, "Warlock MLK Dual Mic", CS8409_WARLOCK_MLK_DUAL_MIC),
>  	SND_PCI_QUIRK(0x1028, 0x0BBC, "Warlock MLK", CS8409_WARLOCK_MLK),
>  	SND_PCI_QUIRK(0x1028, 0x0BBD, "Warlock MLK Dual Mic", CS8409_WARLOCK_MLK_DUAL_MIC),
> +	SND_PCI_QUIRK(0x1028, 0x0BAA, "Dolphin", CS8409_DOLPHIN),
>  	SND_PCI_QUIRK(0x1028, 0x0BD4, "Dolphin", CS8409_DOLPHIN),
>  	SND_PCI_QUIRK(0x1028, 0x0BD5, "Dolphin", CS8409_DOLPHIN),
>  	SND_PCI_QUIRK(0x1028, 0x0BD6, "Dolphin", CS8409_DOLPHIN),

1028:0BAA is already present for ODIN.  Conflicting setup?

(And you should try to put the entry at the right position; the table
is sorted in PCI SSID order.  If you did that, you should have noticed
the confliction more easily.)


Takashi

