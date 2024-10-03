Return-Path: <linux-kernel+bounces-348670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5230C98EA3F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6DA1F22708
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D97824BD;
	Thu,  3 Oct 2024 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ufOgue36";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XP8Wv8Vm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NR+njKNf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hzvA82rA"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A1A2CA9;
	Thu,  3 Oct 2024 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939909; cv=none; b=OXwIGkppHLGb/NT/lxfWYHCNc1hDmSVYq+UtxmYwh3hzAIQxncY0SiX2GwQwBgLHmzM6Bo7zsHKak3Cq9I7QUgY2U279wvK4VRcdGuDmQZGoNprZa1VrP7svLq4sxL7UZHrdBYgYjbqWZ93di1DlenskYuiSCMb39zEpQgmKLwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939909; c=relaxed/simple;
	bh=kJGB9Hobjy2rYg9xXwmeHXV0lEaswvAw6NN/nRKr1uo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJEOF47RxdQmqiWOjJmR1Ia5Sj4FfMm/7dxsrE+qqL25U6R1Dq8l39ekZHOu5UK/f0M8uCgi3LANWQtVrwTuZz4NytVMal3stzIaC4KFqmw+L/mlDeiK1D1roZNu+VtjqGZacsYgQXn4jf4wiDjQni8JCZFxnqFGBDXMCRT0xXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ufOgue36; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XP8Wv8Vm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NR+njKNf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hzvA82rA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8FDC21D0A;
	Thu,  3 Oct 2024 07:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727939890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4dum5nJMR5yZp8cLZblbpre2+vXo2MjICzgmsJ6Ryds=;
	b=ufOgue36eTwkvXfUvrtt7WnGqNvQyS8QGP3fh8BharrtVL4lRCEwqtrxUVDKXJNjgyvJbp
	1JuYorRJXiRYLLbK04aaC5N+gg6R2JeivF0S3OcSBNfNjzYW838T/606kUBXNeyiiN1pME
	hqxTIfyT05Thk93hq1QANg3qlI2ITH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727939890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4dum5nJMR5yZp8cLZblbpre2+vXo2MjICzgmsJ6Ryds=;
	b=XP8Wv8VmdUa6YtJrqBgMhXg13Ne4k714ka18soZG1DaKrUMRr6GE4rRVoTPwcmUtipOVsL
	IKtQhU3U4WKlW3Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727939889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4dum5nJMR5yZp8cLZblbpre2+vXo2MjICzgmsJ6Ryds=;
	b=NR+njKNfonQ+GGetvM49rq4OxPoiEz05kh4lAYQiYfa6/dq0PvSq8jtNlyOnPMyIZD9P5G
	ESxQljjDkVy4+zHyUkQzolWL0gBzmIIKCIkCqCtbS/ZUlmtjUWPiHJcmXC9f2dUvQW62Kg
	ugNkcLsA5p6Q5+0uw/Nts49WwBIL/Hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727939889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4dum5nJMR5yZp8cLZblbpre2+vXo2MjICzgmsJ6Ryds=;
	b=hzvA82rABKFWS/gHnICvFhuy6dDL7YAZMnWz/Ucgo78jNOumYoAIlmPCw646DjFQaSICu8
	Xf7BCK/7PO3ZHDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEA67139CE;
	Thu,  3 Oct 2024 07:18:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OIdILTFF/maYRAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 03 Oct 2024 07:18:09 +0000
Date: Thu, 03 Oct 2024 09:19:03 +0200
Message-ID: <87wmipk61k.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jan Lalinsky <lalinsky@c4.cz>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Add native DSD support for Luxman D-08u
In-Reply-To: <20241003030811.2655735-1-lalinsky@c4.cz>
References: <20241003030811.2655735-1-lalinsky@c4.cz>
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 03 Oct 2024 05:08:11 +0200,
Jan Lalinsky wrote:
> 
> Add native DSD support for Luxman D-08u DAC, by adding the PID/VID 1852:5062.
> This makes DSD playback work, and also sound quality when playing PCM files
> is improved, crackling sounds are gone.
> 
> Signed-off-by: Jan Lalinsky <lalinsky@c4.cz>

Applied now, thanks.


Takashi

