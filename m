Return-Path: <linux-kernel+bounces-358963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E839985CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D6A281301
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A2E1C4626;
	Thu, 10 Oct 2024 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fRrlne07";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MiJw1jab";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fRrlne07";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MiJw1jab"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115691C4610;
	Thu, 10 Oct 2024 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562889; cv=none; b=qnIU2i4mKVULCiecEcQFzImut7PH/RKcW/H4fiM62BKf3QTNMb3aSd7T2bUIh2/NfzGbxc6UkzMTRwcLHS7tjadyxct4T6NQIJmJlilc0O2Sh70dz8CUcsL4Lz4935OScpYDQUpP5vuMffCRPrOJAm7goitvmQqrK1j2ssa1UFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562889; c=relaxed/simple;
	bh=jGhIUZBw7JVTbsNw2cE2IfamX8/sDx7aIfisHS9Nsuk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOPgnSD4rd+FJdW3LyxP5BQnSuZQSf6KnHQbcRUSFB1Dv8+rd8Q4151mk6qXxW8AKTQsqCcS4zJvnFPPa8gH3ApyI5XjCxiMiKFwTPcWarlKliIleq+3igei1e4FslyL7/9nJwY1uF0Fg18OmGBf41GavcuEF4A5rbC4KWgZPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fRrlne07; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MiJw1jab; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fRrlne07; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MiJw1jab; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0EEEE1FF0B;
	Thu, 10 Oct 2024 12:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728562885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hcebttzkZwUDTN1chPuKyvpu71EUHY3veoCxnBjlU0I=;
	b=fRrlne076NAT9tAgscvAT0Jd+yxKYLWLJozihqvi9CUn0/eFDU1CLGFylpvhyEDE3ATFGP
	jEw4mzqh4+TYTsDf1Ux5y1uWSrid91cWK2JVlaycT8/eNZGp6+FWtYqlEFlzZDocOxw35z
	8VWAYD2AOWnf1ZRPu7C1wmxmraywmhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728562885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hcebttzkZwUDTN1chPuKyvpu71EUHY3veoCxnBjlU0I=;
	b=MiJw1jabo7L05Xlo3sZGrvd8bj61QsevEQhTtyxvVd4NRUWKGqI3WxgasSmlQ/y4x3nN9O
	JfGHBwb9mSFVIZCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fRrlne07;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MiJw1jab
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728562885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hcebttzkZwUDTN1chPuKyvpu71EUHY3veoCxnBjlU0I=;
	b=fRrlne076NAT9tAgscvAT0Jd+yxKYLWLJozihqvi9CUn0/eFDU1CLGFylpvhyEDE3ATFGP
	jEw4mzqh4+TYTsDf1Ux5y1uWSrid91cWK2JVlaycT8/eNZGp6+FWtYqlEFlzZDocOxw35z
	8VWAYD2AOWnf1ZRPu7C1wmxmraywmhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728562885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hcebttzkZwUDTN1chPuKyvpu71EUHY3veoCxnBjlU0I=;
	b=MiJw1jabo7L05Xlo3sZGrvd8bj61QsevEQhTtyxvVd4NRUWKGqI3WxgasSmlQ/y4x3nN9O
	JfGHBwb9mSFVIZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFBDF1370C;
	Thu, 10 Oct 2024 12:21:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e5KFMcTGB2eXPgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 10 Oct 2024 12:21:24 +0000
Date: Thu, 10 Oct 2024 14:22:21 +0200
Message-ID: <87v7y0172a.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: linux@treblig.org
Cc: clemens@ladisch.de,
	o-takashi@sakamocchi.jp,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: firewire: Remove unused cmp_connection_update
In-Reply-To: <20241009003653.254753-1-linux@treblig.org>
References: <20241009003653.254753-1-linux@treblig.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 0EEEE1FF0B
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Wed, 09 Oct 2024 02:36:53 +0200,
linux@treblig.org wrote:
> 
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> cmp_connection_update() has been unused since 2019's commit
> 7eb7b18e9fc7 ("ALSA: fireworks: code refactoring for bus reset handler")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Thanks, applied now.


Takashi

