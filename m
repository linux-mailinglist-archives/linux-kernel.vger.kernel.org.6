Return-Path: <linux-kernel+bounces-274312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 715DB947665
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8771F21B16
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E39214AD0A;
	Mon,  5 Aug 2024 07:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VMIhWpOi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KNWuVkLy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LiBbezmn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kd9p6EOu"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB314A090;
	Mon,  5 Aug 2024 07:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844506; cv=none; b=gCSaMhYLQqXEUgpHBLTV9g/u8gyPsNEjerzpNitZlsTDyyXT/R7J1Sl5Es9+UqJsApkMCakcyi8jNuvZk6TKUG0a6l61qhzp+VWEmnTDuSJd09F6jmJZgKQ+KGmKsN77UXvfdIPaHdj3/xBUtRJSUd2udGgr2r8840VwMikZc/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844506; c=relaxed/simple;
	bh=waWaEDx97MJ1tzf5OiYJXuyqvkcr7DutDcN6EPl3ijQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzvk0qEyXlaraGldszgk+Stq1jOHT0o2Vrqp2sCNRMCFQKN0xi2urz3Cyu30NEWJwcFZzQM6+YmSneK3M/2eTG3NhaiEtnoGaaagIk6OSDDH+R5AdVUp53eOhO9YIv5hU8DVx7NbMjADUwvWvzf2dilaLZUcqRmwKH/VwScMiRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VMIhWpOi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KNWuVkLy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LiBbezmn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kd9p6EOu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 827ED21B85;
	Mon,  5 Aug 2024 07:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722844503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V2f6mIciRZDBbY53v9Z2vM6BKSKBswlBvsK+h6N+i9s=;
	b=VMIhWpOiqPtJ63Nv0PF7PLLv8foPOFLLXiX1M+rcMfsJIDf31VDZqXVUU1x5eicV4QtfkQ
	+Q6z+tWgv/VA003s+KfDSQdd05LIrVzogxySfK358Juc9/Zp6rkTgq+9uNI4Fd1Wn/RBNT
	o1hCHXNXihPGIjPBXOgm6oWpuCA/0fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722844503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V2f6mIciRZDBbY53v9Z2vM6BKSKBswlBvsK+h6N+i9s=;
	b=KNWuVkLyxi9S0cIh6wvUCQuWiop25TVpZA9pLn4v3oZ3V9+qK6CcsIc9FU+eTsfVqausc/
	OeB9o9Wom0nkleDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LiBbezmn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kd9p6EOu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722844502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V2f6mIciRZDBbY53v9Z2vM6BKSKBswlBvsK+h6N+i9s=;
	b=LiBbezmnInvHFubDNLeqEOaCJDKAFAeZGNzg42iE9bH72yYhLliY1UMsYc5ZZWaFqns9KL
	qrhmZJXArlLUUSmrKwuYuSco2QAEEzVcB9+syOSOmqgPZluEfhDGIIEUDuX2bq7ZnjlDxz
	AqNO7C8phbXXMkHuqznOebC+IA1VFII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722844502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V2f6mIciRZDBbY53v9Z2vM6BKSKBswlBvsK+h6N+i9s=;
	b=kd9p6EOufJZG3PyQsrGKOwU4WfwAvgHyROi/YvrfeTiuoJeVAAQaYj1k3OhpbzQdiYY+WW
	0EyPRuGeumwyrYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BF7513254;
	Mon,  5 Aug 2024 07:55:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WTs6FVaFsGYnUgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 05 Aug 2024 07:55:02 +0000
Date: Mon, 05 Aug 2024 09:55:40 +0200
Message-ID: <875xsfl7yb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Steven 'Steve' Kendall <skend@chromium.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: Manally set pins to correct HP firmware settings
In-Reply-To: <20240802-hdmi-audio-hp-wrongpins-v1-1-8d8ba10d77f8@chromium.org>
References: <20240802-hdmi-audio-hp-wrongpins-v1-1-8d8ba10d77f8@chromium.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Rspamd-Queue-Id: 827ED21B85

On Sat, 03 Aug 2024 01:50:11 +0200,
Steven 'Steve' Kendall wrote:
> 
> In recent HP UEFI firmware (likely v2.15 and above, tested on 2.27),
> these pins are incorrectly set for HDMI/DP audio. Tested on
> HP MP9 G4 Retail System AMS. Pins for the ports set to escalating values
> (0x70, 80, 90) to have differing default associations, though in my
> testing setting all pins to 0x70 also worked as suggested by the first
> link below. Tested audio with two monitors connected via DisplayPort.
> 
> Link: https://forum.manjaro.org/t/intel-cannon-lake-pch-cavs-conexant-cx20632-no-sound-at-hdmi-or-displayport/133494
> Link: https://bbs.archlinux.org/viewtopic.php?id=270523
> Signed-off-by: Steven 'Steve' Kendall <skend@chromium.org>

I suppose it can be rather added to force_connect_list[] table like a
few other HP models, instead?  Something like below.

Or, maybe we can apply with vendor HP (103c) in the case of Kaybelake.
I got another report indicating a same issue, but with the ID
103c:83e2.


thanks,

Takashi

-- 8< --
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1989,6 +1989,7 @@ static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t cvt_nid)
 }
 
 static const struct snd_pci_quirk force_connect_list[] = {
+	SND_PCI_QUIRK(0x103c, 0x83ef, "HP MP9 G4 Retail System AMS", 1),
 	SND_PCI_QUIRK(0x103c, 0x870f, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x871a, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x8711, "HP", 1),

