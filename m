Return-Path: <linux-kernel+bounces-388791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE30B9B6469
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823AD28123D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10351EABDC;
	Wed, 30 Oct 2024 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ag1U8qzw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RD8rpap6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ag1U8qzw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RD8rpap6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337091E32D8;
	Wed, 30 Oct 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295746; cv=none; b=PkRSmVnOVGdxBem/DyW+4aVJvgMXHFL6iGfnuz82VJCIOgNVohS5QfOnOikPwddxJmpHBMmjwcsotw7Ywux1e2KehLTljpurtR5NY2ZcqXnopeUvCMBs8wbkaD25phoffErarp0KAIQwK+xBTMyDcg8pAPJrGsQbHUpKshyusk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295746; c=relaxed/simple;
	bh=IKxDWX/1fQn5xXVKFZ5/ZdXJPkw7oKWH9+cSgQEvR7U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/c3mfZZMzZR3bzRGNrvV7BDqRlH9YiGkv31tuiuFuggTCfXXoIRbGmiGglpnLKWfe5CQ0ooxkqoHk3Jz82VbuTvw+v38OTTgddIpOpZveWevxAJPZ3f19qg0d1y1VCLCfFdXcETu7riMamvEPQ5sLlnAuSTBA5BxlNp4AGpIFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ag1U8qzw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RD8rpap6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ag1U8qzw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RD8rpap6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C19A1F750;
	Wed, 30 Oct 2024 13:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730295742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y88MDMRPGFOzO2ZSSJjdlw2Jd1mhNWx8h1ZCrt8zLxE=;
	b=ag1U8qzwnDvUVp8d4zdPeuLw3ND8sF6xt9hAH7wKDnqDkXHkhj7MkD5kx0Cc+Ak0wVcgcf
	ZpI6GJQsBj/nMFA7FM2HvBNb6P2ell7vdrqC6aw5e1nrLvVMA6ds9KsVMhnp6nLs2l+BMa
	fG8l8Mh5DYGD8Mmz0tPIcbkR35WExDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730295742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y88MDMRPGFOzO2ZSSJjdlw2Jd1mhNWx8h1ZCrt8zLxE=;
	b=RD8rpap6jyjoxU4ueKzZ72XipKQFq96kXeGvVAvYZJWKHpToyA+dxRQZlNWvsTpqT8rC0u
	coVizjsiOhcmkXDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730295742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y88MDMRPGFOzO2ZSSJjdlw2Jd1mhNWx8h1ZCrt8zLxE=;
	b=ag1U8qzwnDvUVp8d4zdPeuLw3ND8sF6xt9hAH7wKDnqDkXHkhj7MkD5kx0Cc+Ak0wVcgcf
	ZpI6GJQsBj/nMFA7FM2HvBNb6P2ell7vdrqC6aw5e1nrLvVMA6ds9KsVMhnp6nLs2l+BMa
	fG8l8Mh5DYGD8Mmz0tPIcbkR35WExDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730295742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y88MDMRPGFOzO2ZSSJjdlw2Jd1mhNWx8h1ZCrt8zLxE=;
	b=RD8rpap6jyjoxU4ueKzZ72XipKQFq96kXeGvVAvYZJWKHpToyA+dxRQZlNWvsTpqT8rC0u
	coVizjsiOhcmkXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E364613AD9;
	Wed, 30 Oct 2024 13:42:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RjNZNr03ImfWdQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 30 Oct 2024 13:42:21 +0000
Date: Wed, 30 Oct 2024 14:43:24 +0100
Message-ID: <87wmhpyadf.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christoffer Sandberg <cs@tuxedo.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ALSA: hda/realtek: Fix headset mic on TUXEDO Gemini 17 Gen3
In-Reply-To: <20241029151653.80726-1-wse@tuxedocomputers.com>
References: <20241029151653.80726-1-wse@tuxedocomputers.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 29 Oct 2024 16:16:52 +0100,
Werner Sembach wrote:
> 
> From: Christoffer Sandberg <cs@tuxedo.de>
> 
> Quirk is needed to enable headset microphone on missing pin 0x19.
> 
> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>

Applied both patches now.  Thanks.


Takashi

