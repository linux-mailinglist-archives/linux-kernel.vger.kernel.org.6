Return-Path: <linux-kernel+bounces-279866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7B994C2C8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D751E1F23256
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FEE190052;
	Thu,  8 Aug 2024 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DXZai/bt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QqpzbkHJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OB+fIaYl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7byGmy7+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A0018E04F;
	Thu,  8 Aug 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134756; cv=none; b=NgQpBg/XAtQt1Eep6khhZVpzKvJwQBdpX4be/fOmOrLQOxPppOPqorA+Ona159te9n42lqsvUp6+pyj0T5XPxvufoavEkZfrMYKvoTX+GopGFmvyNEzGJVgtoLtzy5LdwxOrAFGfJ9j+Ghk653f297hZK4R4XX+Aeb92+KNgWgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134756; c=relaxed/simple;
	bh=Ss07Ig0Vc0WTFPvO7fYvtBUA+bSnfXv7lWQANVwNBvE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7M6sIgv9zcOZgXmEa5jzH3S/P9YCLvLMXBB7LZWGQgmzu5ykLDNGTBfxumCOoW7b6cRaSgEzFrzB49zFDSMMneGisEpdB1iDTwDBt665U1QY7ezssCkUU9ybe4U8Rwkp5ghI4fiFf+56tVMa+/XCHPXQapLqyw6Hz9I4ILUmAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DXZai/bt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QqpzbkHJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OB+fIaYl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7byGmy7+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F50E1FCE9;
	Thu,  8 Aug 2024 16:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723134753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H8chINUKV2piRga7HhL1/U/V6Fkt52brkH0qlXNSc60=;
	b=DXZai/bt+v3XBpfjfcvjUErBnJP08T8GXuKAW1sEykWLqzGV5LGiETkTXqe31bA5CxXCSX
	9jBpBHySwjEIfjFTYBy2/QkGV487Giz7X7ALNoDnZnWq2NJFa1+xnRGhoSRzFtcjikfBPU
	Q2Sdnm4iX41TF5w5mAnNBC5tPLCiVkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723134753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H8chINUKV2piRga7HhL1/U/V6Fkt52brkH0qlXNSc60=;
	b=QqpzbkHJwqjKxtygxeos5r6dBcvKZu6YG+KhH0kqHTsOvfTGTBWu+b9rwWcafa0fvIA7dR
	+o4FJ7XuHhjFKHDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OB+fIaYl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7byGmy7+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723134752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H8chINUKV2piRga7HhL1/U/V6Fkt52brkH0qlXNSc60=;
	b=OB+fIaYlY0Ma6CWZl9Q8dwtKT2wLnna0rJirSdCACLg8wT+JsAiNdoG/3ngi+c3ByHF2SR
	40pq7h1dOxPpDIPkSiYcSLFwB+ACDVx7ESS1WJkHAqpKvlGXcYho5l3EdqTzYDX3oP6d6e
	iVc/kJbowFcPvyhrcgokqx7iIv0/dKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723134752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H8chINUKV2piRga7HhL1/U/V6Fkt52brkH0qlXNSc60=;
	b=7byGmy7+1GLdYzU6ljcyvna0g6MLnN6vSTuAQBPIUyraFjyPRNVYFLtwgh7i3CubkHOCpq
	WdN2nHIW8mdFBzDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBF5C13B20;
	Thu,  8 Aug 2024 16:32:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sYNtMB/ztGZvLgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 08 Aug 2024 16:32:31 +0000
Date: Thu, 08 Aug 2024 18:33:10 +0200
Message-ID: <87ed6z7z5l.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Daniel Mack <zonque@gmail.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: snd-usb-caiaq: use snd_pcm_rate_to_rate_bit
In-Reply-To: <20240808134857.86749-1-jbrunet@baylibre.com>
References: <20240808134857.86749-1-jbrunet@baylibre.com>
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
X-Spamd-Result: default: False [-2.51 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,gmail.com,alsa-project.org,vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,baylibre.com:email];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,baylibre.com:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 0F50E1FCE9

On Thu, 08 Aug 2024 15:48:54 +0200,
Jerome Brunet wrote:
> 
> Use snd_pcm_rate_to_rate_bit() helper provided by Alsa instead
> re-implementing it. This reduce code duplication and helps when
> changing some Alsa definition is necessary.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Thanks, applied now.


Takashi

