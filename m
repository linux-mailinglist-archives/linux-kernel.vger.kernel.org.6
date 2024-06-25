Return-Path: <linux-kernel+bounces-229024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8639169D5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F0C1C22795
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E4C16193C;
	Tue, 25 Jun 2024 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TMUxoOA8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zr9Qjcmz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TMUxoOA8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zr9Qjcmz"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECCC15FA74;
	Tue, 25 Jun 2024 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324448; cv=none; b=ixjElf4t95cor4Mv5C0RzWJC23z0/yg4izHvl9RbvzYeW+YRvaQOmMbP70uWveq7xDx4QKmOe34Z37m/LMLYbq9gk+KI7l1UuPUsG2lERMm4u0wkhPzA+fgH9KUaTcJ8UuXjh+LkCHV5Ni7a1FzLfBY6G4iaO4G8y1Jdmxo/TfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324448; c=relaxed/simple;
	bh=9XV83LrXSjRYW1AcuSnVMLu4Y4BncWKJllrwrdhAu4g=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZa1vKLyYzk/JStx0gy/uBin8Lhm7RP4doFLtQUFJe/A8lCgivPhQonTPnDOqsEp29yIQHPB22iMWX8n7BEK2EqvD4XUrTDAxQ2KoME9c3ThSh0xSfFDkeMN0iS5ROuyH/SszJaJCzGgZRKKSe3lpuiB+OHvwDHIRMK718XtZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TMUxoOA8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zr9Qjcmz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TMUxoOA8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zr9Qjcmz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 22E741F863;
	Tue, 25 Jun 2024 14:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719324445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VBByb5/SaRYwvVsGzkL/+7/3oncmJYY7cYNw+F2rxeQ=;
	b=TMUxoOA8/JD3jby9E5H8QSixYyl+TJJJt3enSQUOvhSqNYBf6rp30FQ3VowY0x0aF6nOtu
	r3jvSonZOFp+Ah+6LZedmZf7fvSZeJEap9LSMUXs6nZezZu8CXx+bjqyaYcZQzuBEDEXh6
	P9o4RFH60uJo6s4CmNY+c1t07Q2FnSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719324445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VBByb5/SaRYwvVsGzkL/+7/3oncmJYY7cYNw+F2rxeQ=;
	b=zr9QjcmzTcJxXBBeOIR5kwRFOiww3EBGKuiv3QoU0bNRQimekw+9hLBnXuOlDHj69+r+3i
	tnktucoedpJe4pCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719324445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VBByb5/SaRYwvVsGzkL/+7/3oncmJYY7cYNw+F2rxeQ=;
	b=TMUxoOA8/JD3jby9E5H8QSixYyl+TJJJt3enSQUOvhSqNYBf6rp30FQ3VowY0x0aF6nOtu
	r3jvSonZOFp+Ah+6LZedmZf7fvSZeJEap9LSMUXs6nZezZu8CXx+bjqyaYcZQzuBEDEXh6
	P9o4RFH60uJo6s4CmNY+c1t07Q2FnSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719324445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VBByb5/SaRYwvVsGzkL/+7/3oncmJYY7cYNw+F2rxeQ=;
	b=zr9QjcmzTcJxXBBeOIR5kwRFOiww3EBGKuiv3QoU0bNRQimekw+9hLBnXuOlDHj69+r+3i
	tnktucoedpJe4pCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBB6C13A9A;
	Tue, 25 Jun 2024 14:07:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nmXSOBzPemZTJgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 25 Jun 2024 14:07:24 +0000
Date: Tue, 25 Jun 2024 16:07:52 +0200
Message-ID: <87tthhktdz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Rauty <rautyrauty@gmail.com>
Cc: Gergo Koteles <soyer@irl.hu>,
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
	wzhd@ustc.edu,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset mic on IdeaPad 330-17IKB 81DM
In-Reply-To: <CAGpJQTFF=gKN2h105dGhBOEhN0Q1Tpj5hJWpSdQ_-nCoUTzj5A@mail.gmail.com>
References: <20240615125457.167844-1-rauty@altlinux.org>
	<2c9ba341bc95d4b9010bf5f8794c0d14b1c57dc9.camel@irl.hu>
	<CAGpJQTHoBAixmxta2WuZfjHjiK9GXF=hkfPyV7PBD5rt9Z_0WA@mail.gmail.com>
	<CAGpJQTGqxEkfp003QLsp-syUgzDFCmHSmNaoOaem0ZMVf7_=bg@mail.gmail.com>
	<c0a9e15e7926e098bdea97a7d31c32427e0910c9.camel@irl.hu>
	<871q4lm9dp.wl-tiwai@suse.de>
	<CAGpJQTFF=gKN2h105dGhBOEhN0Q1Tpj5hJWpSdQ_-nCoUTzj5A@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Tue, 25 Jun 2024 16:00:57 +0200,
Rauty wrote:
> 
> On Tue, 25 Jun 2024 at 16:32, Gergo Koteles <soyer@irl.hu> wrote:
> > I still think this breaks Duet 7 sound, because snd_hda_pick_fixup
> > function picks the PCI SSIDs before Codec SSIDs.
> 
> a piece of lspci from Lenovo IdeaPad 330-17IKB 81DM:
> 00:1f.3 Audio device [0403]: Intel Corporation Sunrise Point-LP HD
> Audio [8086:9d71] (rev 21)
> Subsystem: Lenovo Device [17aa:3837]
> Kernel driver in use: snd_hda_intel
> 
> Since PCI SSIDs are in priority, I will specify it (0x3837).
> Then this patch will not break the sound in the laptop and the change
> will be minimal.

It's not about PCI SSID but the codec SSID.  It's found in the
corresponding /proc/asound/card*/codec#* file.  It might be the same
number as PCI SSID, though.  Please check both Vendor Id and Subsystem
Id lines.

And we need to know those numbers from the conflicting model (Yoga
Diet 7 13ITL6), too.


Takashi

