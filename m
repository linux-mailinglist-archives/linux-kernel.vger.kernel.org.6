Return-Path: <linux-kernel+bounces-326905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06043976E54
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CBA1B22C51
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8830B7868B;
	Thu, 12 Sep 2024 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D0TFyp6E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="heHxXiK1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D0TFyp6E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="heHxXiK1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742591EB2A;
	Thu, 12 Sep 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156852; cv=none; b=C+A3YFlZipsduBLxaAVTmjxasIpCPbdYF4kbq/ZjJMfNfRlC/fddCK0vwfs+OXVkPy1394OUHaB4UTr07DY5NDgUYsJNFYxQXE+l9LL+OkwVjNJ7KR+7LxaJY9BnoUW6Ir3Ri2b/LflZ5NOEg5Kv+adPCMQZ7fcVfvfQ744PBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156852; c=relaxed/simple;
	bh=gG42ozVvV6+BbGtVKFqhowCSWwptcDdxjLkJvWrSKbI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyFsWPBo7hqTJeDcm7RvgB6zReRE0vpscVHwi1zf9WA/3ELZLK7QZ8k1O7HhFEz5ri0Gh3yM9iIJ/c+r6dveQD9Jdu+u+VsaIwxWqxTWgL6sY0ZeW/BIZw+fO1IKpXbnTIxCXBeHDnspoxbvKpXKYUs8JIOj1nQCztRlSPXgZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D0TFyp6E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=heHxXiK1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D0TFyp6E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=heHxXiK1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B46F21B13;
	Thu, 12 Sep 2024 16:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726156848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VH1CvNjzwRlNSKpwAd7M4y39jAuCuA7jnUxQokgxr7g=;
	b=D0TFyp6EW2F/UxiNht6DbbO88VmaVEUqQ+wevWeOh5Sd6sUDi/byXIesAeCOKK60H2ZCM1
	gGeIs8ikD0CdndsyUvFTBWfw1MiIqheDFUOWVHPWPHkjjn9jGxvwCO9qG/EC6kl83KCgpO
	tdWM3OpaNdRdcYy13E2aFxxjCn9U54k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726156848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VH1CvNjzwRlNSKpwAd7M4y39jAuCuA7jnUxQokgxr7g=;
	b=heHxXiK1AYGqiawPVHwbuCawvfK42Cxuc3J9Rsa+lZKSBrbZxPVVGNUg+1uOuxsA792jb7
	aIBeZ4wllmHA03Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D0TFyp6E;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=heHxXiK1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726156848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VH1CvNjzwRlNSKpwAd7M4y39jAuCuA7jnUxQokgxr7g=;
	b=D0TFyp6EW2F/UxiNht6DbbO88VmaVEUqQ+wevWeOh5Sd6sUDi/byXIesAeCOKK60H2ZCM1
	gGeIs8ikD0CdndsyUvFTBWfw1MiIqheDFUOWVHPWPHkjjn9jGxvwCO9qG/EC6kl83KCgpO
	tdWM3OpaNdRdcYy13E2aFxxjCn9U54k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726156848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VH1CvNjzwRlNSKpwAd7M4y39jAuCuA7jnUxQokgxr7g=;
	b=heHxXiK1AYGqiawPVHwbuCawvfK42Cxuc3J9Rsa+lZKSBrbZxPVVGNUg+1uOuxsA792jb7
	aIBeZ4wllmHA03Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FF9B13A73;
	Thu, 12 Sep 2024 16:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UyWxDTAQ42Y0IgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 12 Sep 2024 16:00:48 +0000
Date: Thu, 12 Sep 2024 18:01:37 +0200
Message-ID: <877cbgg8ta.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Joshua Pius <joshuapius@chromium.org>
Cc: alsa-devel@alsa-project.org,
	Joshua Pius <joshuapius@google.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Karol Kosik <k.kosik@outlook.com>,
	"Steven 'Steve' Kendall" <skend@chromium.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Add logitech Audio profile quirk
In-Reply-To: <20240912152635.1859737-1-joshuapius@google.com>
References: <20240912152635.1859737-1-joshuapius@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 8B46F21B13
X-Spam-Score: -5.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[alsa-project.org,google.com,perex.cz,suse.com,outlook.com,chromium.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 12 Sep 2024 17:26:28 +0200,
Joshua Pius wrote:
> 
> Specify shortnames for the following Logitech Devices: Rally bar, Rally
> bar mini, Tap, MeetUp and Huddle.
> 
> Signed-off-by: Joshua Pius <joshuapius@chromium.org>

Thanks, applied.


Takashi

