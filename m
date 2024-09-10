Return-Path: <linux-kernel+bounces-322673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3740972C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A794728369F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A1F18309B;
	Tue, 10 Sep 2024 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NM+RwUK0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1K177Iya";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NM+RwUK0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1K177Iya"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D73136344;
	Tue, 10 Sep 2024 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956880; cv=none; b=YZpkDsxi2Kea3tg2a51WUZa8lgtbvRbKDAqFJiZnTQ/5MSRJF2AA6I1sP86Iuif44YeXgGtsxpGSCm2DMo4oq9KNvA6E2Zg8Qjk9TZCCWZmqp3QyZ+G2jQ/Vidhd3nb37Zwo5t4DktT9n0QJm8KyhRZDHCwwkJL75sqSVHUyV2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956880; c=relaxed/simple;
	bh=X4hs/NYjUa6gfdvFk3CnuiUSrKwfb3QiwVFkJLTjSGc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LYNdmKmfSkwgVQrBSBa+mbTUvbanm/vf52ITlhCJk9C28N7fHrja46vX05fuzwwx4DVigr/xyGmsXMRhDQYjrJYcxlCKabnVoKQrO+eTA2L9qsfYA8NuLvZSKmDY7pp39/eVSQWyw1ib1CbpuAx/i7gqz2x701NBIxK5fEhmtGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NM+RwUK0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1K177Iya; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NM+RwUK0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1K177Iya; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1E8661F454;
	Tue, 10 Sep 2024 08:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725956877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OMCpO710s/YdJ0sDkDnODfiudlVK3KqfUvyjSOLAyMw=;
	b=NM+RwUK0as9Oqe9d4Z7YyFyvmb6Il9Izh0fzxpULcVyoTg0B6DF78EyJYvEFjLxAIOqeqt
	XGgcfP5Z4S4WJumFPEvJB73ZwpU0FzjKSwPorOVyhn2/lqc2nkArnVdzSa/8pZUpIg3kcQ
	xFcZmFe0o2AlJxnwywon9xO2xnzTIIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725956877;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OMCpO710s/YdJ0sDkDnODfiudlVK3KqfUvyjSOLAyMw=;
	b=1K177IyafxiHf0sH2zzTapK4mfyKullS8QEG8SCi+FF/t/vv5w3dZv6D3E1EhnWZSZ7rtm
	qZPVx3J8ScIuOBAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725956877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OMCpO710s/YdJ0sDkDnODfiudlVK3KqfUvyjSOLAyMw=;
	b=NM+RwUK0as9Oqe9d4Z7YyFyvmb6Il9Izh0fzxpULcVyoTg0B6DF78EyJYvEFjLxAIOqeqt
	XGgcfP5Z4S4WJumFPEvJB73ZwpU0FzjKSwPorOVyhn2/lqc2nkArnVdzSa/8pZUpIg3kcQ
	xFcZmFe0o2AlJxnwywon9xO2xnzTIIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725956877;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OMCpO710s/YdJ0sDkDnODfiudlVK3KqfUvyjSOLAyMw=;
	b=1K177IyafxiHf0sH2zzTapK4mfyKullS8QEG8SCi+FF/t/vv5w3dZv6D3E1EhnWZSZ7rtm
	qZPVx3J8ScIuOBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA292132CB;
	Tue, 10 Sep 2024 08:27:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JdMVMAwD4GaROQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 10 Sep 2024 08:27:56 +0000
Date: Tue, 10 Sep 2024 10:28:45 +0200
Message-ID: <87mskf7w02.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable mic on Vaio VJFH52
In-Reply-To: <20240909162751.4790-1-edson.drosdeck@gmail.com>
References: <20240909162751.4790-1-edson.drosdeck@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -1.80
X-Spam-Flag: NO

On Mon, 09 Sep 2024 18:27:51 +0200,
Edson Juliano Drosdeck wrote:
> 
> Vaio VJFH52 is equipped with ACL256, and needs a
> fix to make the internal mic and headphone mic to work.
> Also must to limits the internal microphone boost.
> 
> Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

Thanks, applied now.


Takashi

