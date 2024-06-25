Return-Path: <linux-kernel+bounces-229029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3B89169EA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A921C217BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214E31684AD;
	Tue, 25 Jun 2024 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="myAGUbX6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mIHkr2Jg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="myAGUbX6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mIHkr2Jg"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42711B7F7;
	Tue, 25 Jun 2024 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324706; cv=none; b=c/nuX1KNBI8ZW3po6sCZnbc9b2IgftofETKLktBhjru0f4N6kdM37yOZu3NyuhONawy9PqQueGgfWF+9NLpYuS9uVOt5XUKYtxURvVU9QAJ/Ov2fB3lBhELzNth9QwcZJdefMrUQFQBNQGSe0R/tUWcvagkSBWVni8agmRKDcAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324706; c=relaxed/simple;
	bh=Irlmbt8HJWy8tp+OoQC0I/M5XM8XaoXQYKdhtUVkjPM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eivZwxwjfJzgbdDM2JYOFTR/hNeMtS5XQ0OfEskww6bXIMsB2d6oG15v/k/s9jpZyfUYp72/WnwWBKOBoVZZqK4FDXiFI3Vxp2SO4HjDQwKVQq3mKT62h2lvmb5614LWVvmxejIvtQ9VWeFzOy4F4vNUlTJD32iTfWw/ptMLKM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=myAGUbX6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mIHkr2Jg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=myAGUbX6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mIHkr2Jg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C106B21A85;
	Tue, 25 Jun 2024 14:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719324702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NnC+97gwME9kjwNXm6zl+j05zVpdI6JNfkbkHaSB3fw=;
	b=myAGUbX6pE7EFPY2Pd95h06RUxqQt9XCzgVMXkQV4WvIRl4vExXkh0CdfnQoAmY6PmkHU1
	I0JwjTHHRrOzwhq3YS84V6pHH7hRxMVY8JVIwruCc6kfhZaJ7eW7TtSjcmkqrRQ9FRx88K
	R5FDU3c5ZEeXuNbKMW2fYpQXmeU+oCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719324702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NnC+97gwME9kjwNXm6zl+j05zVpdI6JNfkbkHaSB3fw=;
	b=mIHkr2JgcRlnIl0WcMWht/vBoHV6UE6/9uhrVp7GwbNzgOQf7QnDP3wgdsKgpuuF1ndI/+
	kCsXzDDN8O+8qBAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=myAGUbX6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mIHkr2Jg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719324702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NnC+97gwME9kjwNXm6zl+j05zVpdI6JNfkbkHaSB3fw=;
	b=myAGUbX6pE7EFPY2Pd95h06RUxqQt9XCzgVMXkQV4WvIRl4vExXkh0CdfnQoAmY6PmkHU1
	I0JwjTHHRrOzwhq3YS84V6pHH7hRxMVY8JVIwruCc6kfhZaJ7eW7TtSjcmkqrRQ9FRx88K
	R5FDU3c5ZEeXuNbKMW2fYpQXmeU+oCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719324702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NnC+97gwME9kjwNXm6zl+j05zVpdI6JNfkbkHaSB3fw=;
	b=mIHkr2JgcRlnIl0WcMWht/vBoHV6UE6/9uhrVp7GwbNzgOQf7QnDP3wgdsKgpuuF1ndI/+
	kCsXzDDN8O+8qBAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BF8213A9A;
	Tue, 25 Jun 2024 14:11:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g3JRIR7QemabJwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 25 Jun 2024 14:11:42 +0000
Date: Tue, 25 Jun 2024 16:12:10 +0200
Message-ID: <87sex1kt6t.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: wzhd@ustc.edu
Cc: Rauty <rautyrauty@gmail.com>,
	Gergo Koteles <soyer@irl.hu>,
	alsa-devel@alsa-project.org,
	tiwai@suse.com,
	perex@perex.cz,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset mic on IdeaPad 330-17IKB 81DM
In-Reply-To: <87tthhktdz.wl-tiwai@suse.de>
References: <20240615125457.167844-1-rauty@altlinux.org>
	<2c9ba341bc95d4b9010bf5f8794c0d14b1c57dc9.camel@irl.hu>
	<CAGpJQTHoBAixmxta2WuZfjHjiK9GXF=hkfPyV7PBD5rt9Z_0WA@mail.gmail.com>
	<CAGpJQTGqxEkfp003QLsp-syUgzDFCmHSmNaoOaem0ZMVf7_=bg@mail.gmail.com>
	<c0a9e15e7926e098bdea97a7d31c32427e0910c9.camel@irl.hu>
	<871q4lm9dp.wl-tiwai@suse.de>
	<CAGpJQTFF=gKN2h105dGhBOEhN0Q1Tpj5hJWpSdQ_-nCoUTzj5A@mail.gmail.com>
	<87tthhktdz.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: C106B21A85
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,irl.hu,alsa-project.org,suse.com,perex.cz,realtek.com,opensource.cirrus.com,ljones.dev,ti.com,athaariq.my.id,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, 25 Jun 2024 16:07:52 +0200,
Takashi Iwai wrote:
> 
> On Tue, 25 Jun 2024 16:00:57 +0200,
> Rauty wrote:
> > 
> > On Tue, 25 Jun 2024 at 16:32, Gergo Koteles <soyer@irl.hu> wrote:
> > > I still think this breaks Duet 7 sound, because snd_hda_pick_fixup
> > > function picks the PCI SSIDs before Codec SSIDs.
> > 
> > a piece of lspci from Lenovo IdeaPad 330-17IKB 81DM:
> > 00:1f.3 Audio device [0403]: Intel Corporation Sunrise Point-LP HD
> > Audio [8086:9d71] (rev 21)
> > Subsystem: Lenovo Device [17aa:3837]
> > Kernel driver in use: snd_hda_intel
> > 
> > Since PCI SSIDs are in priority, I will specify it (0x3837).
> > Then this patch will not break the sound in the laptop and the change
> > will be minimal.
> 
> It's not about PCI SSID but the codec SSID.  It's found in the
> corresponding /proc/asound/card*/codec#* file.  It might be the same
> number as PCI SSID, though.  Please check both Vendor Id and Subsystem
> Id lines.
> 
> And we need to know those numbers from the conflicting model (Yoga
> Diet 7 13ITL6), too.

No need to diet, but "duet" :)

Zihao, do you still have the access to this machine?
If yes, could you give alsa-info.sh output, or a proc file output?


thanks,

Takashi

