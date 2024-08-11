Return-Path: <linux-kernel+bounces-282173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FC394E075
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 915B6B21075
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 08:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE23200CB;
	Sun, 11 Aug 2024 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z5TR7DUW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qUy/0X1D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z5TR7DUW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qUy/0X1D"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E01F5F6;
	Sun, 11 Aug 2024 08:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723364265; cv=none; b=kyl5vgRMJMJAWS+uC0ooA9Y/GnRpp1diRpeDGKGRoswxUm0cIYSex7LAHAom9ig5zfXIqxz0MTIV7XDMFmF9eJvVmwe3RcZ0eoTm1i6QWJrBtL88kW75lKzcRBQ2Fxw6qeqAT0UaF9F31Qfbxm3iCnSIylN/GxHj8ZgdR5im9M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723364265; c=relaxed/simple;
	bh=k8FfPhUGfIf8N6QGFQASiW8JMHlSgSiPgjF+tTeuWow=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDukKx7WhhxybOcONqT9UELJVwm/gYC+AcheDzyQF7p+BqhVGvWDtxV+3jJwr5kFAaahuxPScInOCyfLWx92riv4ZR0jdTyrSKwOJPCncctuR1GJQMd/V569OvtI3fBibIwzLV9UXDPBE4rXCVa+3HzEWHO08aDB5tU/UWbL4TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z5TR7DUW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qUy/0X1D; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z5TR7DUW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qUy/0X1D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1717E21C3D;
	Sun, 11 Aug 2024 08:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723364261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QnS5ipjP4a/K8lhsUquf6FuKXqcRQOc9DH3+Bb3w2TQ=;
	b=z5TR7DUW6JJCtvnKs1ygrTPpogDK+DFBlt9zMgzVGzh2EsoRbo1hNJMnMCXcriJP1T8rwU
	YEQHMufEp+x6/FMrjf4ekJyWMAh9833rSU4AlZLMKy/AdZJrUqmEmRbmK1LILv8TpjgVCp
	XmpL5RN3B6O0EV/ilMPUHZlnpENbaZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723364261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QnS5ipjP4a/K8lhsUquf6FuKXqcRQOc9DH3+Bb3w2TQ=;
	b=qUy/0X1DN3AcOAlxGAdgxPKxyLNXICHTN1b5fAsuHOpHJ5MjZiktA1vZ7KLL9nL4QOtIGp
	ZlrEXuRri+zI0RBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=z5TR7DUW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="qUy/0X1D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723364261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QnS5ipjP4a/K8lhsUquf6FuKXqcRQOc9DH3+Bb3w2TQ=;
	b=z5TR7DUW6JJCtvnKs1ygrTPpogDK+DFBlt9zMgzVGzh2EsoRbo1hNJMnMCXcriJP1T8rwU
	YEQHMufEp+x6/FMrjf4ekJyWMAh9833rSU4AlZLMKy/AdZJrUqmEmRbmK1LILv8TpjgVCp
	XmpL5RN3B6O0EV/ilMPUHZlnpENbaZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723364261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QnS5ipjP4a/K8lhsUquf6FuKXqcRQOc9DH3+Bb3w2TQ=;
	b=qUy/0X1DN3AcOAlxGAdgxPKxyLNXICHTN1b5fAsuHOpHJ5MjZiktA1vZ7KLL9nL4QOtIGp
	ZlrEXuRri+zI0RBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD04D13704;
	Sun, 11 Aug 2024 08:17:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QM5cNKRzuGaqVgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 11 Aug 2024 08:17:40 +0000
Date: Sun, 11 Aug 2024 10:18:20 +0200
Message-ID: <87sevbjwvn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Parsa Poorshikhian <parsa.poorsh@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	tiwai@suse.com,
	kailang@realtek.com
Subject: Re: [PATCH] ALSA: hda/realtek: Fix noise from speakers on Lenovo IdeaPad 3 15IAU7
In-Reply-To: <20240810150939.330693-1-parsa.poorsh@gmail.com>
References: <20240810150939.330693-1-parsa.poorsh@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 1717E21C3D
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 0.99

On Sat, 10 Aug 2024 17:09:06 +0200,
Parsa Poorshikhian wrote:
> 
> Fixes: 70794b9563fe ("ALSA: hda/realtek: Add more codec ID to no shutup pins list")

The Fixes tag should be around Signed-off-by tag.

> Fix noise from speakers connected to AUX port when no sound is playing.
> The problem occurs because the `alc_shutup_pins` function includes
> a 0x10ec0257 vendor ID, which causes noise on Lenovo IdeaPad 3 15IAU7 with
> Realtek ALC257 codec when no sound is playing.
> Removing this vendor ID from the function fixes the bug.
> 
> Signed-off-by: Parsa Poorshikhian <parsa.poorsh@gmail.com>

Applied with a minor modification above.  Thanks!


Takashi

