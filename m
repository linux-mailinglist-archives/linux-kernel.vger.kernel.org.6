Return-Path: <linux-kernel+bounces-281783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B098994DB43
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 09:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D97B1F21B96
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 07:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ED014A624;
	Sat, 10 Aug 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KzIonzyV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MZFq2thD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KzIonzyV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MZFq2thD"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B82C2F5E;
	Sat, 10 Aug 2024 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723276626; cv=none; b=ZToRL1wzv0IcJXF1yyH5O/tPqR0M1T002Ee78k/8XInNYnViAN/b9v2wjf7ZhO+ph0JYyeDoYVN4Kr3J9iS3vWWs1dYgDEXfiW0DMzSFwmWRJrkKJMOg9jSv5iCoXNgtQgTiDxZFli4GZ17KR/7k32UKQOviCEdwHudUgD9tpNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723276626; c=relaxed/simple;
	bh=NOFQbZhMWY3kji6rmTI3u/1KuA468HeSAuM7BUrlFYM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuL3yAOyFDr1gXJtN2a0n/7X27yqWs+RsveyXA/j1hdokhA8dfU+m0cThS3G2owqeeooMeCPy86g7LmK2zC/tqQfaCmcZLcZGaPERLYuHhA/qlPJmsxLi8e/JLUwfLjnu1/NA4lRIPMqdvECkHK++7q516scwASHDjHn2K15aDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KzIonzyV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MZFq2thD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KzIonzyV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MZFq2thD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BCD8620066;
	Sat, 10 Aug 2024 07:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723276621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LpOEi5+FSjuXUxGTm0Z868dRm/7akdjBvOtYoiYVsY4=;
	b=KzIonzyVRtz5XiGu/KkeDHp82aR31Riem7f+pWrlQj7FDLZDSPHS4nyeQ0mDf8rHMN7ohi
	93MDls3AexFd2DYWk2pjkTWVf5xkL/4Wqnivr70clmJtllWoDIx0YN4DPplj1mvpCgfoxu
	JtbAOJRNr7MoWnPku8TM3rXh3B9cv4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723276621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LpOEi5+FSjuXUxGTm0Z868dRm/7akdjBvOtYoiYVsY4=;
	b=MZFq2thDTmC2daOn9dRJB/ygD226VSVEVeU3OnA2k6X9eEUJbIRgFbeorgvPj7fs2KWxkL
	KOsGwBbUnHK1GFCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KzIonzyV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MZFq2thD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723276621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LpOEi5+FSjuXUxGTm0Z868dRm/7akdjBvOtYoiYVsY4=;
	b=KzIonzyVRtz5XiGu/KkeDHp82aR31Riem7f+pWrlQj7FDLZDSPHS4nyeQ0mDf8rHMN7ohi
	93MDls3AexFd2DYWk2pjkTWVf5xkL/4Wqnivr70clmJtllWoDIx0YN4DPplj1mvpCgfoxu
	JtbAOJRNr7MoWnPku8TM3rXh3B9cv4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723276621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LpOEi5+FSjuXUxGTm0Z868dRm/7akdjBvOtYoiYVsY4=;
	b=MZFq2thDTmC2daOn9dRJB/ygD226VSVEVeU3OnA2k6X9eEUJbIRgFbeorgvPj7fs2KWxkL
	KOsGwBbUnHK1GFCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90ACA13704;
	Sat, 10 Aug 2024 07:57:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d6OIIU0dt2ZtGQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 10 Aug 2024 07:57:01 +0000
Date: Sat, 10 Aug 2024 09:57:41 +0200
Message-ID: <87jzgolsi2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Parsa Poorshikhian <parsa.poorsh@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	tiwai@suse.com,
	kailang@realtek.com
Subject: Re: forgot to CC all relevant maintainers
In-Reply-To: <20240809221755.352238-2-parsa.poorsh@gmail.com>
References: <20240809181303.9882-1-parsa.poorsh@gmail.com>
	<20240809221755.352238-2-parsa.poorsh@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -2.01
X-Rspamd-Queue-Id: BCD8620066
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

On Sat, 10 Aug 2024 00:17:56 +0200,
Parsa Poorshikhian wrote:
> 
> i forgot to CC all relevant maintainers in previous patch email, so this
> reply would CC them. sorry for the inconvenience. this is my first time
> doing merge request in linux.
> 
> Signed-off-by: Parsa Poorshikhian <parsa.poorsh@gmail.com>

I'm not sure which exact patch you're referring to.

Could you rather just resubmit your patch with your proper
Signed-off-by tag?


thanks,

Takashi

