Return-Path: <linux-kernel+bounces-421970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B554F9D92BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F619B257F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14023194AE8;
	Tue, 26 Nov 2024 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YjQqgCpc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fm5cGiDL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YjQqgCpc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fm5cGiDL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2C44964E;
	Tue, 26 Nov 2024 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607219; cv=none; b=hz2SM8+xUQPaAIAnNpPT7Y4uJPiLr7lvH+tzYwHTnmJmY70v64AfKuysuxkSphf265IeRRXtGhaBd5kQpmA4+gAgS8uZWOxDFsLT2Xw8KPezzsDLC89RPvTI+Vut6cJA3BT3xNQDJyAPgzImo6gOljWg1ablbgtcHJXLZRLfYWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607219; c=relaxed/simple;
	bh=rGxIdHssWJLlPvfwSObL7KV2i8SJ0MtYYUio/uZNJfI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiHZHNGEM1Tv36iEXcf3spIWEr/c3DdlhdRfyPpQZtLl/Dhpv8uhBz1w2h9zbQHrlZh9MxVrqZbJ9lYwsCi8H0CgDIge5+RfpOFBg/eyFDcl+IPo3zr101GzB47IWP1ZgWfUc6ACuj1/+EMgw9mQ/plL4B4bgAvyNNhq4tcGEWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YjQqgCpc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fm5cGiDL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YjQqgCpc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fm5cGiDL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91D9D2115E;
	Tue, 26 Nov 2024 07:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732607215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48nfOpDY6B+c9KfYgZwoNHkDV5BTUzCGiztMlmdTkwI=;
	b=YjQqgCpcJ+0o2d3XMqQzidsH9TTNaoBTfvinix+7N3q8sq6r/KVbg7D1H8GDebOeRE5m4N
	Ropfer2Evk5IQd3fakcHl7+YtgxkxIk0YFxqQkB5SNco6NSfE03DhqUyt3DEkuRDfpgvGv
	BKz08L8Rh8ZG7WLc879JewrkjKrTch8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732607215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48nfOpDY6B+c9KfYgZwoNHkDV5BTUzCGiztMlmdTkwI=;
	b=Fm5cGiDLYCwAbOdHSgAYOKvhEEiotHqgksRMoMNs0ZqN07TovEUEwCZHNPEiG5lmvPWSbd
	xqrqPeYOl6loAXBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732607215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48nfOpDY6B+c9KfYgZwoNHkDV5BTUzCGiztMlmdTkwI=;
	b=YjQqgCpcJ+0o2d3XMqQzidsH9TTNaoBTfvinix+7N3q8sq6r/KVbg7D1H8GDebOeRE5m4N
	Ropfer2Evk5IQd3fakcHl7+YtgxkxIk0YFxqQkB5SNco6NSfE03DhqUyt3DEkuRDfpgvGv
	BKz08L8Rh8ZG7WLc879JewrkjKrTch8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732607215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48nfOpDY6B+c9KfYgZwoNHkDV5BTUzCGiztMlmdTkwI=;
	b=Fm5cGiDLYCwAbOdHSgAYOKvhEEiotHqgksRMoMNs0ZqN07TovEUEwCZHNPEiG5lmvPWSbd
	xqrqPeYOl6loAXBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4264913890;
	Tue, 26 Nov 2024 07:46:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ofPxDu98RWe3ZQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 26 Nov 2024 07:46:55 +0000
Date: Tue, 26 Nov 2024 08:46:54 +0100
Message-ID: <871pyyl9n5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dirk Su <dirk.su@canonical.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Joshua Grisham <josh@joshuagrisham.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs don't work for EliteBook X G1i
In-Reply-To: <20241126060531.22759-1-dirk.su@canonical.com>
References: <20241126060531.22759-1-dirk.su@canonical.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Tue, 26 Nov 2024 07:05:24 +0100,
Dirk Su wrote:
> 
> HP EliteBook X G1i needs ALC285_FIXUP_HP_GPIO_LED quirk to
> make mic-mute/audio-mute working.
> 
> Signed-off-by: Dirk Su <dirk.su@canonical.com>

Thanks, applied now.


Takashi

