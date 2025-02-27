Return-Path: <linux-kernel+bounces-536157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCCFA47C36
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DE51893153
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C16229B2C;
	Thu, 27 Feb 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lcT//jS0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u2NnOG0+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lcT//jS0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u2NnOG0+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F80AEEBB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655657; cv=none; b=gpsGJvt/f/BJjPL2gdZwYiA0boak9MmRPvEV6jMAau7tnTKD+60VTw31SXiXYJehNHnv0+/hkbM/phIKGXNM2k+686hlK+1oMXHxVGVMGcRgz1I+tjXCjkZPuYE/27HC48Go02kSPUNaHBdlKtLMf+OiwKX/EK8SgiULYTUg7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655657; c=relaxed/simple;
	bh=hfCtgKRhQ7KTwp3Whk5tojBSDo2zZtB8SocxmAzQsZw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0J4mydJrxWLe+PNObqoeEVRTRg+58V7XH0FClEn204M2CFrxmTHwWMpIUvFW9HsWURuNcdUseX85PAddDpenI5g7rmZb6vJHsY2lvW6BcuxqiAy3l2/gOfMtyFcXKYk3sUCMFmA+MO4Zmys2hoNUgnsw5T+gK8OyW4W5NEVxzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lcT//jS0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u2NnOG0+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lcT//jS0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u2NnOG0+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C89FA1F38A;
	Thu, 27 Feb 2025 11:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740655653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jDoiAS1gLYwvlDucP39bYw6WXQ/amu77UEaTcGr90JI=;
	b=lcT//jS0CkxZHDxvHlOwT7ekAYZOMUDvq6/Nyg/jnX3plimWLwMG673Hw+5QCM2l9yPyVh
	B2KYtAyIpbvZqZ30bqNzHW8Ok9NLfqmuxBIb3Ev+MgN8nPWrGOku53RplEmBswibJIarMm
	XEEmzidKnDuncrz+DhMN/Wk9Hg7GhoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740655653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jDoiAS1gLYwvlDucP39bYw6WXQ/amu77UEaTcGr90JI=;
	b=u2NnOG0+SoTZSdx9uR0xaMQ29aMAPbkAcaaPThNvaXv5/OtyJNiG6Pieb1PD23dJDzvjbs
	5Bu1FdkCfkE0M3Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740655653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jDoiAS1gLYwvlDucP39bYw6WXQ/amu77UEaTcGr90JI=;
	b=lcT//jS0CkxZHDxvHlOwT7ekAYZOMUDvq6/Nyg/jnX3plimWLwMG673Hw+5QCM2l9yPyVh
	B2KYtAyIpbvZqZ30bqNzHW8Ok9NLfqmuxBIb3Ev+MgN8nPWrGOku53RplEmBswibJIarMm
	XEEmzidKnDuncrz+DhMN/Wk9Hg7GhoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740655653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jDoiAS1gLYwvlDucP39bYw6WXQ/amu77UEaTcGr90JI=;
	b=u2NnOG0+SoTZSdx9uR0xaMQ29aMAPbkAcaaPThNvaXv5/OtyJNiG6Pieb1PD23dJDzvjbs
	5Bu1FdkCfkE0M3Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9509813888;
	Thu, 27 Feb 2025 11:27:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RQDKIiVMwGemOQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 27 Feb 2025 11:27:33 +0000
Date: Thu, 27 Feb 2025 12:27:33 +0100
Message-ID: <875xkv7hlm.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Charles Han <hanchunchao@inspur.com>
Cc: <perex@perex.cz>,
	<tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: opti9xx: fix inconsistent indenting warning in snd_opti9xx_configure()
In-Reply-To: <20250227091810.18847-1-hanchunchao@inspur.com>
References: <20250227091810.18847-1-hanchunchao@inspur.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.995];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo,inspur.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 27 Feb 2025 10:18:10 +0100,
Charles Han wrote:
> 
> Fix below inconsistent indenting smatch warning.
> smatch warnings:
> sound/isa/opti9xx/opti92x-ad1848.c:489 snd_opti9xx_configure()
> warn: inconsistent indenting
> 
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Applied now.  Thanks.


Takashi

