Return-Path: <linux-kernel+bounces-173220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BE68BFD36
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 079D3B21A23
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EE854BCB;
	Wed,  8 May 2024 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rH3cCnAv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I6+XFoN1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rH3cCnAv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I6+XFoN1"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384C254BE2;
	Wed,  8 May 2024 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171646; cv=none; b=NTeMJIKwj8qA+HvagJfgdCYJLH/K46X4543vF36YolGHKCmzbBNCA2EsQTe23rGPu2NepfeteRNcxnbs2KmO0gQOjixj8W5iyux8aR41a9aRXuBRRa7y0s/aCgvgg1LhN4kSnhF5kh6LvW/nrg5xHk7ubW+WEKcSQYk1bUFVaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171646; c=relaxed/simple;
	bh=yYslb0OUmSwvxLA6zHbTZpvzOahjKxA4E3PzATeflR8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdDmUbBX1yykKR+/sA2w7yRHb9/DQQxBY/1vJHIzSbibLpkzYT2nr2kzgfRxrQuO7QB6ghyeiBp7nDlycAmZ/bf94V9QQMRj4xL8mHInuIAzdwL6NCzIvPlOc+sHhtjUiV6L5/4lK4h0D5+cGVq840GGUEY129yoPMEraArkQf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rH3cCnAv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I6+XFoN1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rH3cCnAv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I6+XFoN1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78B3C5C9BD;
	Wed,  8 May 2024 12:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715171643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TqlxnX8S/G0wOUmeXETdKPJLjbdsBZmj/P2uIy6RbuQ=;
	b=rH3cCnAvOurWLBC9fK4xwW3YeG2TvJcshPbiBoDDW+2xM6+K8fAha+WcEq56X1NW8FTVfy
	/0MDS+kplPZpWk4KExGerT6G62xEgNcNukoOjqx6ADRIcCeJxASqjaDdhYJ2u/azYXaP2G
	nSnU0Avt5bMVnxqisEBbAEcAcCOGOLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715171643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TqlxnX8S/G0wOUmeXETdKPJLjbdsBZmj/P2uIy6RbuQ=;
	b=I6+XFoN1josjzaLN35NdNh34BJPm4OMmjdktprYpl+CghV4ZdrWyE5FRr03wZKp9QLxlOi
	TR4ophO8Vq7fx5CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rH3cCnAv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=I6+XFoN1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715171643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TqlxnX8S/G0wOUmeXETdKPJLjbdsBZmj/P2uIy6RbuQ=;
	b=rH3cCnAvOurWLBC9fK4xwW3YeG2TvJcshPbiBoDDW+2xM6+K8fAha+WcEq56X1NW8FTVfy
	/0MDS+kplPZpWk4KExGerT6G62xEgNcNukoOjqx6ADRIcCeJxASqjaDdhYJ2u/azYXaP2G
	nSnU0Avt5bMVnxqisEBbAEcAcCOGOLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715171643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TqlxnX8S/G0wOUmeXETdKPJLjbdsBZmj/P2uIy6RbuQ=;
	b=I6+XFoN1josjzaLN35NdNh34BJPm4OMmjdktprYpl+CghV4ZdrWyE5FRr03wZKp9QLxlOi
	TR4ophO8Vq7fx5CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DBB21386E;
	Wed,  8 May 2024 12:34:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IfvVETtxO2ZAXQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 08 May 2024 12:34:03 +0000
Date: Wed, 08 May 2024 14:34:18 +0200
Message-ID: <8734qscwj9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda: cs35l56: Fix lifetime of cs_dsp instance
In-Reply-To: <20240508100811.49514-1-rf@opensource.cirrus.com>
References: <20240508100811.49514-1-rf@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.05
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 78B3C5C9BD
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.05 / 50.00];
	BAYES_HAM(-2.54)[97.93%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,cirrus.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Wed, 08 May 2024 12:08:11 +0200,
Richard Fitzgerald wrote:
> 
> The cs_dsp instance is initialized in the driver probe() so it
> should be freed in the driver remove(). Also fix a missing call
> to cs_dsp_remove() in the error path of cs35l56_hda_common_probe().
> 
> The call to cs_dsp_remove() was being done in the component unbind
> callback cs35l56_hda_unbind(). This meant that if the driver was
> unbound and then re-bound it would be using an uninitialized cs_dsp
> instance.
> 
> It is best to initialize the cs_dsp instance in probe() so that it
> can return an error if it fails. The component binding API doesn't
> have any error handling so there's no way to handle a failure if
> cs_dsp was initialized in the bind.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier")

Applied now.  Thanks.


Takashi

