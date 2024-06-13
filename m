Return-Path: <linux-kernel+bounces-213082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E06A6906ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A06D1F247CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630A1143725;
	Thu, 13 Jun 2024 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ebkH5Vgh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9f6JfGyf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ebkH5Vgh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9f6JfGyf"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D8713D28D;
	Thu, 13 Jun 2024 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718277562; cv=none; b=HweefK8TdIMI/eTicnxoxQaNqstLifDoW7weLoC20TeBt5LFeWqiXimedaQjhI3OAC1iHYEV9CD+ozIHlbu+nMs8E2hF4h1BLnhi2D0eM2oncltG7n9VdB0rzuJaWNK6vtTz/NCu/s0dHa9QeH9cJF5eNhfoC0qmA2tfjE2WN1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718277562; c=relaxed/simple;
	bh=FSIeRAlLZMWHT261y1qfIVJfXLwpq4Sk47twc/pjht4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHFQUn+wZtQE+FHm6zGV1SY6KV35rXVLXKaKAiGsmyymGR7vS7s7pC0kjP9XH547nMBOvGrpDndqKX7OtNrmB/gUT2McZ7A3K7Qawhen4PdLDHYpETP8XpMZuXbn8kLEDBuNp1m6O4kR+2syjjPuY7WIiRzerNpofBmROMb58t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ebkH5Vgh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9f6JfGyf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ebkH5Vgh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9f6JfGyf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 44F145D239;
	Thu, 13 Jun 2024 11:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718277558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2sq5NScImGREjqWBwAlqWPpEhG6A5ciFsXTqLEKEWsc=;
	b=ebkH5Vgh+Sa0HLVFLk7dHP/Z8hjZ7EXotfc5xYhju1AYSuREtoAGmUytIk832QOrlbOz4G
	Sz7WijD5YOa8sRvEuJgoqKspXuJLGxU85ZoBpmH2B/oKJgjCK/ulQMgkuloI8qAsYWJZfA
	MSrWeBN2Aeny8FXlBS/3LigKiJhdU/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718277558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2sq5NScImGREjqWBwAlqWPpEhG6A5ciFsXTqLEKEWsc=;
	b=9f6JfGyfoI8XeemxAZGpE7c3II8iiAtnasyUPlATkZN+ZA/qhOuICik7zCA6K3p5HKsCoA
	2TZJ5KAJBA4R2ODw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718277558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2sq5NScImGREjqWBwAlqWPpEhG6A5ciFsXTqLEKEWsc=;
	b=ebkH5Vgh+Sa0HLVFLk7dHP/Z8hjZ7EXotfc5xYhju1AYSuREtoAGmUytIk832QOrlbOz4G
	Sz7WijD5YOa8sRvEuJgoqKspXuJLGxU85ZoBpmH2B/oKJgjCK/ulQMgkuloI8qAsYWJZfA
	MSrWeBN2Aeny8FXlBS/3LigKiJhdU/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718277558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2sq5NScImGREjqWBwAlqWPpEhG6A5ciFsXTqLEKEWsc=;
	b=9f6JfGyfoI8XeemxAZGpE7c3II8iiAtnasyUPlATkZN+ZA/qhOuICik7zCA6K3p5HKsCoA
	2TZJ5KAJBA4R2ODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE42013A87;
	Thu, 13 Jun 2024 11:19:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DM7LNLXVamZaEgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 13 Jun 2024 11:19:17 +0000
Date: Thu, 13 Jun 2024 13:19:41 +0200
Message-ID: <87o785nl82.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andy Chi <andy.chi@canonical.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Kailang Yang <kailang@realtek.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Athaariq Ardhiansyah <foss@athaariq.my.id>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs don't work for ProBook 445/465 G11.
In-Reply-To: <20240605092243.41963-1-andy.chi@canonical.com>
References: <20240605092243.41963-1-andy.chi@canonical.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.21 / 50.00];
	BAYES_HAM(-2.91)[99.60%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.21
X-Spam-Level: 

On Wed, 05 Jun 2024 11:22:41 +0200,
Andy Chi wrote:
> 
> HP ProBook 445/465 G11 needs ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to
> make mic-mute/audio-mute working.
> 
> Signed-off-by: Andy Chi <andy.chi@canonical.com>

Sorry for the late reply, as I've been off in the last weeks.
Now applied.


thanks,

Takashi

