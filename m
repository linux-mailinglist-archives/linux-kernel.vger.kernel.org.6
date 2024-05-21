Return-Path: <linux-kernel+bounces-184979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED2C8CAECD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01E41C212BF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E83757FC;
	Tue, 21 May 2024 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DvRDVTRg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DFh1aaYd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pm8coJpp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6rL/LDG1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0661E48B;
	Tue, 21 May 2024 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296593; cv=none; b=EaMlh8atEOhAzC73V5tCyhHayFq7Lh6Kb9bfSfXZRVLR1I3Ie3VLZVNL4XSDwtPIIAdljZsLUmElNyhsWMSPdXdn0nOhLqg9W8Sr5N5D9vbBrh/DCcgbutHgPhC6hPmVn/Pzh8VZj3+I+McFG4skIs502DSAkkKiYhfjzdNJjT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296593; c=relaxed/simple;
	bh=TeuiLt5VwmzwVFG6iJ3tFjIJetQiid6c7HRyPxVGzqY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5v0RZse93ezPO7Cvn6lFkoaqehWawj+JlSQzuOtO9U6fJqlTW16ggGDc4EFEXLo121XAi/Zp1B5LZxIDBRkJc8JaKQbqXd6SyHRQ2jRNDXQ5f8q6/YGoqb9NqsUuYyUb69c6gEcTaLKlPAAyImHaWoEioSfYSk+bOfXrR7WnEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DvRDVTRg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DFh1aaYd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pm8coJpp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6rL/LDG1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D468721CC9;
	Tue, 21 May 2024 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716296590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HrUcyfZvkIGpNNtfWpPeamQ4DL5sODsh0kQZjJEmcrE=;
	b=DvRDVTRgl2EEQvusXnq6P3faxboCaVptmw0yNFF3FiUfIdfey1qy3OyJzlmIY6nIV2wgFO
	CH/pAvTvx4PtG+vpTS3TEopQAkzSHpR8tksXTQpdXiIZd1GG412iO3rWgmJ/9oNWb0oXqa
	6Rp2YoeTZy7nIgjiNMv7SbDoItM/Vwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716296590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HrUcyfZvkIGpNNtfWpPeamQ4DL5sODsh0kQZjJEmcrE=;
	b=DFh1aaYdiCirBBOm46wsMCWhcNjc9LP+Phk4jXHy8wv++TWvSHtQ4/91EWmyjeJc57yLhH
	v5wZyNspSWf/Q4DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pm8coJpp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="6rL/LDG1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716296589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HrUcyfZvkIGpNNtfWpPeamQ4DL5sODsh0kQZjJEmcrE=;
	b=pm8coJppysesPPp6NsIZS/9JbP+MlQk4QbR7sVT2lv0yfcVtDFz5fzLdF67H9skm0qog7L
	k5MGBEDbNSNiiAstvgnONg3wnHdlS3Un8gTZnNDwR49yRQYm3CKZomMcjqD/EW/4mgkh88
	Fj253UH0X5ir7w4sU83mLXt3F7KP6kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716296589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HrUcyfZvkIGpNNtfWpPeamQ4DL5sODsh0kQZjJEmcrE=;
	b=6rL/LDG164Al7RKrtPisUNkkVxtyclWWdo6LMG+bU8gTK2udqmoDLj2dZiQacbFPKdjmaL
	yE8IrCSQ9xXRnhDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA0EE13A1E;
	Tue, 21 May 2024 13:03:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8cM3KI2bTGYgTgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 21 May 2024 13:03:09 +0000
Date: Tue, 21 May 2024 15:03:28 +0200
Message-ID: <87ed9v1fmn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable headset mic of JP-IK LEAP W502 with ALC897
In-Reply-To: <20240520055008.7083-2-jhp@endlessos.org>
References: <20240520055008.7083-2-jhp@endlessos.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-5.36 / 50.00];
	BAYES_HAM(-2.85)[99.33%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D468721CC9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.36

On Mon, 20 May 2024 07:50:09 +0200,
Jian-Hong Pan wrote:
> 
> JP-IK LEAP W502 laptop's headset mic is not enabled until
> ALC897_FIXUP_HEADSET_MIC_PIN3 quirk is applied.
> 
> Here is the original pin node values:
> 
> 0x11 0x40000000
> 0x12 0xb7a60130
> 0x14 0x90170110
> 0x15 0x411111f0
> 0x16 0x411111f0
> 0x17 0x411111f0
> 0x18 0x411111f0
> 0x19 0x411111f0
> 0x1a 0x411111f0
> 0x1b 0x03211020
> 0x1c 0x411111f0
> 0x1d 0x4026892d
> 0x1e 0x411111f0
> 0x1f 0x411111f0
> 
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>

Thanks, applied now.


Takashi

