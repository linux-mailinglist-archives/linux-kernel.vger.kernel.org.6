Return-Path: <linux-kernel+bounces-544481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA4EA4E221
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B0B3BFB0C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D74D25FA0C;
	Tue,  4 Mar 2025 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yX0oqdjg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S63i0mEi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yX0oqdjg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S63i0mEi"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFF625F996
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099390; cv=none; b=F5LQ490VHCQPUM+0sX8EqzfRfSbvtLFmvtTtJ6g9niUWI7RlLtMOss1443cNZty6qlCw/c0LfbPhbL1H3x7PJCLAKYMT0HrpQykbTZfVDM7INylv3xqhxf3xpqawaBy80svXflOtWixFstAJMVOzCDmSjTlVaiPxDTsniQ/OB2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099390; c=relaxed/simple;
	bh=KcYgkB4zTVvN8S1M7wolNQGQE3M9+SCDs85WY6yumtQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QM0jTHyCJP8646AHjHXSiTr1IEzvT6mmVpt/CZ0o2gfgHq87DkK04amsT8Z0fVfsVzA9CIey60j5jf/sMuaDyABxavAmibBWgntIpfFIBf5v6eUH1bvLtz9DjGym4+mODsYlnD1WGVFsCOt8ZHGGw4L8uwrkibTyIO+z9hAX8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yX0oqdjg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S63i0mEi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yX0oqdjg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S63i0mEi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0123D1F78A;
	Tue,  4 Mar 2025 14:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741099387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vy0jB6YWJvG9X3KVhHi/jP8vYHRElOXSzkp2ng5O3ws=;
	b=yX0oqdjgrtAVWncpsBVHBi1KYhYnT8gIov8y7fn3Q9/0HDBUGr2koPq9ZnDBMWLr62/mbh
	IE8bBGgeaae+nD7jtErx6SwkoK3TJrp+Sjv+9YGZPIOkSyBicLK7fuWnERnERjs7aArqvd
	za3619KnOkk088ZaAVbJ2Y4B/QXcKBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741099387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vy0jB6YWJvG9X3KVhHi/jP8vYHRElOXSzkp2ng5O3ws=;
	b=S63i0mEiHC/kZVaR8Re4f8uU9R78+BmpeplwoYhzcNI6TvyoJ52jAMwIorzeTd/FLMci1B
	TjpXhMY4MABSmwCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741099387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vy0jB6YWJvG9X3KVhHi/jP8vYHRElOXSzkp2ng5O3ws=;
	b=yX0oqdjgrtAVWncpsBVHBi1KYhYnT8gIov8y7fn3Q9/0HDBUGr2koPq9ZnDBMWLr62/mbh
	IE8bBGgeaae+nD7jtErx6SwkoK3TJrp+Sjv+9YGZPIOkSyBicLK7fuWnERnERjs7aArqvd
	za3619KnOkk088ZaAVbJ2Y4B/QXcKBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741099387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vy0jB6YWJvG9X3KVhHi/jP8vYHRElOXSzkp2ng5O3ws=;
	b=S63i0mEiHC/kZVaR8Re4f8uU9R78+BmpeplwoYhzcNI6TvyoJ52jAMwIorzeTd/FLMci1B
	TjpXhMY4MABSmwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6FAB1393C;
	Tue,  4 Mar 2025 14:43:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M2jvM3oRx2cSNgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 04 Mar 2025 14:43:06 +0000
Date: Tue, 04 Mar 2025 15:43:06 +0100
Message-ID: <87tt88oo05.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Joshua Grisham <josh@joshuagrisham.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] snd: hda: realtek: fix incorrect IS_REACHABLE() usage
In-Reply-To: <20250304142620.582191-1-arnd@kernel.org>
References: <20250304142620.582191-1-arnd@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: *
X-Spamd-Result: default: False [1.20 / 50.00];
	RSPAMD_URIBL(4.50)[arndb.de:email];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: 1.20

On Tue, 04 Mar 2025 15:25:55 +0100,
Arnd Bergmann wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The alternative path leads to a build error after a recent change:
> 
> sound/pci/hda/patch_realtek.c: In function 'alc233_fixup_lenovo_low_en_micmute_led':
> include/linux/stddef.h:9:14: error: called object is not a function or function pointer
>     9 | #define NULL ((void *)0)
>       |              ^
> sound/pci/hda/patch_realtek.c:5041:49: note: in expansion of macro 'NULL'
>  5041 | #define alc233_fixup_lenovo_line2_mic_hotkey    NULL
>       |                                                 ^~~~
> sound/pci/hda/patch_realtek.c:5063:9: note: in expansion of macro 'alc233_fixup_lenovo_line2_mic_hotkey'
>  5063 |         alc233_fixup_lenovo_line2_mic_hotkey(codec, fix, action);
> 
> Using IS_REACHABLE() is somewhat questionable here anyway since it
> leads to the input code not working when the HDA driver is builtin
> but input is in a loadable module. Replace this with a hard compile-time
> dependency on CONFIG_INPUT. In practice this won't chance much
> other than solve the compiler error because it is rare to require
> sound output but no input support.
> 
> Fixes: f603b159231b ("ALSA: hda/realtek - add supported Mic Mute LED for Lenovo platform")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch.  Indeed it's a very corner case, but I still
hesitate to add a kconfig dependency.  Can we take an alternative fix
to define the proper dummy functions like below instead?


Takashi

-- 8< --
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5038,8 +5038,21 @@ static void alc233_fixup_lenovo_line2_mic_hotkey(struct hda_codec *codec,
 	}
 }
 #else /* INPUT */
-#define alc280_fixup_hp_gpio2_mic_hotkey	NULL
-#define alc233_fixup_lenovo_line2_mic_hotkey	NULL
+static void alc280_fixup_hp_gpio2_mic_hotkey(struct hda_codec *codec,
+					     const struct hda_fixup *fix,
+					     int action)
+{
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		codec_info(codec, "Input is disabled, skipping quirk\n");
+}
+
+static void alc233_fixup_lenovo_line2_mic_hotkey(struct hda_codec *codec,
+						 const struct hda_fixup *fix,
+						 int action)
+{
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		codec_info(codec, "Input is disabled, skipping quirk\n");
+}
 #endif /* INPUT */
 
 static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,

