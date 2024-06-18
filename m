Return-Path: <linux-kernel+bounces-218991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF49590C881
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9867F2809B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E5A2074AE;
	Tue, 18 Jun 2024 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RFpSx1KN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RVXQeHxu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RFpSx1KN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RVXQeHxu"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97C1AC78B;
	Tue, 18 Jun 2024 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704363; cv=none; b=CrpjdT5I5O9Z3mDlm4up2hUDm9vKKnIx66C4br+dPqAKzcZMR9y7SQSQqLytTybYhZLWOp3CfOK0SBMbASD+wHno5wzUT2gC25tYl84dWBqGHfDSCYEVfVctDGxQI5OYDaIYEe9kFUQJVArsfHGRymPzXEXJvL2eLSB48h700ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704363; c=relaxed/simple;
	bh=SSxtrx0QUg2Wx7cvN+gJuUD0e6TauR5b527O69izf+k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfYYLn8/8wamF+u4oOGjCNff7yNY4YEJf1fWsHl51BO9yyVq+IDwrwPz/yWpD1d6757PD4I5vkEo+FBA1rMtsx16M2imwh09ZKSqYJ15qw11b+85DPfk2uo0cagx6OQE/O2ILJbFa32aVSq3rlAYbjLRZ7RWkZuIc9INz9Oyllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RFpSx1KN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RVXQeHxu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RFpSx1KN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RVXQeHxu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 600D8219C4;
	Tue, 18 Jun 2024 09:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718704356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y72GhFWTBnlWQ6W2vqBZp1TnCwscWwZaxfHEyJk338M=;
	b=RFpSx1KNc+zFAkDpUOhpDz361bKkyU3rlSd5lRzvTNmah6qCrpBEBaMxNEl5WR+dpbs+I4
	FziXUki7Q7pRl6/dqVxTCq2gzPcAnJWW0gFRcwXza3KMEXnwJsybNyXuPBsY7hUMGxuY/R
	yjscNPr2Rrjtvd59Z/HXKg+1w7HFH+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718704356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y72GhFWTBnlWQ6W2vqBZp1TnCwscWwZaxfHEyJk338M=;
	b=RVXQeHxuT5Ek/u0/7nY6WyZIOLCYod/khkacKNSPRm3AesNLjFxbXHNRd1/aJGTrJYc9+5
	rf+MGTsb2brax4DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RFpSx1KN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RVXQeHxu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718704356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y72GhFWTBnlWQ6W2vqBZp1TnCwscWwZaxfHEyJk338M=;
	b=RFpSx1KNc+zFAkDpUOhpDz361bKkyU3rlSd5lRzvTNmah6qCrpBEBaMxNEl5WR+dpbs+I4
	FziXUki7Q7pRl6/dqVxTCq2gzPcAnJWW0gFRcwXza3KMEXnwJsybNyXuPBsY7hUMGxuY/R
	yjscNPr2Rrjtvd59Z/HXKg+1w7HFH+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718704356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y72GhFWTBnlWQ6W2vqBZp1TnCwscWwZaxfHEyJk338M=;
	b=RVXQeHxuT5Ek/u0/7nY6WyZIOLCYod/khkacKNSPRm3AesNLjFxbXHNRd1/aJGTrJYc9+5
	rf+MGTsb2brax4DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BFD513AA0;
	Tue, 18 Jun 2024 09:52:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AWgbDuRYcWaAIAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 18 Jun 2024 09:52:36 +0000
Date: Tue, 18 Jun 2024 11:53:02 +0200
Message-ID: <87le327f29.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>,
	<soyer@irl.hu>,
	<shenghao-ding@ti.com>,
	<kevin-lu@ti.com>,
	<baojun.xu@ti.com>
Subject: Re: [PATCH v3 0/4] ALSA: hda: Improvements to hda_component
In-Reply-To: <20240617154105.108635-1-simont@opensource.cirrus.com>
References: <20240617154105.108635-1-simont@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 600D8219C4
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon, 17 Jun 2024 17:41:01 +0200,
Simon Trimmer wrote:
> 
> This series of patches moves duplicated members from the
> instanced component structures into a new parent structure and
> introduces locking so that consumers of the interface do not use
> stale data.
> 
> Changes in v3:
>  - These Fixes separated from this series to make them easier
>    to manage:
>    https://lore.kernel.org/all/20240613133713.75550-1-simont@opensource.cirrus.com/
> 
> Simon Trimmer (4):
>   ALSA: hda: hda_component: Introduce component parent structure
>   ALSA: hda: hda_component: Change codecs to use component parent structure
>   ALSA: hda: hda_component: Move codec field into the parent
>   ALSA: hda: hda_component: Protect shared data with a mutex

Applied all patches now to for-next branch.  Thanks.


Takashi

