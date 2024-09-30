Return-Path: <linux-kernel+bounces-343500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A15989BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583E61C216AA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6D2161313;
	Mon, 30 Sep 2024 07:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z+d3SBRt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qmChkpow";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z+d3SBRt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qmChkpow"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6415CD78;
	Mon, 30 Sep 2024 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682234; cv=none; b=FJDVJtdQu6Ct6TynJVPi53AWiSP5A82iCuRtgwyFo4cEzCy6UKWZyMM2FnhHXIa1Q4HDVVUghBON7D25t+6RPrWl+au1ssq4TWo9jX7P+j8lH+FP+1s6O6Yt5KNtk680Ez30HpakR7xm9XH2bqK9QekoTb09Gv3SzJdJ02LM1d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682234; c=relaxed/simple;
	bh=0Xi/J+biURecEooD0Ouc5gh2xxZbpfjhNiXBp3KUPQE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TItM0h9sZolRs5XqzRT/2E0Udmj8vbFdyERztf9w6gU5h7/C/aHcWv7nQPw3ojv4+/4wPD2N32AJEPSHTcsbIApt/n2BCyIL1tYEu1CKaK++baQ+jrrXOvgglKHQEEKDlqUt6iidmibpNU+mgkUwnxbhZdr5PRVuBh4yCULsUnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z+d3SBRt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qmChkpow; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z+d3SBRt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qmChkpow; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B14B11F7F9;
	Mon, 30 Sep 2024 07:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727682230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gbq8Cjj5vR0lbkP7gRM0LJLGr8qpZhZuXpMTxTEBIGU=;
	b=z+d3SBRtINqU/GfAFFW+vWR24CdzKZ8Fh1wra7l+2T1YG5Qjfmx9qVRHlSI3MgRdU64xUN
	cAZmDqCeeX0e1w+6SsEFwNv+H+kRm+BXyKQPXVTAbksNp3e1rN2LE/BqZlGf3LR66Gpqv7
	YlyslTp8s61OJogAdvPhraIYMfR/Jl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727682230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gbq8Cjj5vR0lbkP7gRM0LJLGr8qpZhZuXpMTxTEBIGU=;
	b=qmChkpowJdYlvPI76nKgSeP7R7GclCj8CTGjnBCWXoS2nJ/qFXHGCOvRhyM8tgYBiyjP7O
	MQLx6zTEWnimWVAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=z+d3SBRt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qmChkpow
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727682230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gbq8Cjj5vR0lbkP7gRM0LJLGr8qpZhZuXpMTxTEBIGU=;
	b=z+d3SBRtINqU/GfAFFW+vWR24CdzKZ8Fh1wra7l+2T1YG5Qjfmx9qVRHlSI3MgRdU64xUN
	cAZmDqCeeX0e1w+6SsEFwNv+H+kRm+BXyKQPXVTAbksNp3e1rN2LE/BqZlGf3LR66Gpqv7
	YlyslTp8s61OJogAdvPhraIYMfR/Jl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727682230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gbq8Cjj5vR0lbkP7gRM0LJLGr8qpZhZuXpMTxTEBIGU=;
	b=qmChkpowJdYlvPI76nKgSeP7R7GclCj8CTGjnBCWXoS2nJ/qFXHGCOvRhyM8tgYBiyjP7O
	MQLx6zTEWnimWVAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67D35136CB;
	Mon, 30 Sep 2024 07:43:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aW8TGLZW+maUDAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 30 Sep 2024 07:43:50 +0000
Date: Mon, 30 Sep 2024 09:44:43 +0200
Message-ID: <87jzetk2l0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jerry Luo <jerryluo225@gmail.com>
Cc: tiwai@suse.de,
	christian@heusel.eu,
	cs@tuxedo.de,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	regressions@lists.linux.dev,
	wse@tuxedocomputers.com
Subject: Re: [REGRESSION][BISECTED] Audio volume issues since 4178d78cd7a8
In-Reply-To: <ea6e5168-238f-41f5-9600-36b75ed990a1@gmail.com>
References: <87jzfbh5tu.wl-tiwai@suse.de>
	<ea6e5168-238f-41f5-9600-36b75ed990a1@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: B14B11F7F9
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Mon, 23 Sep 2024 21:37:42 +0200,
Jerry Luo wrote:
> 
> 
> Hi Takashi,
> 
> On Mon, 16 Sep 2024 19:22:05 +0200,
> 
> Takashi Iwai wrote:
> 
>     Could you give alsa-info.sh output from both working and non-working
>     cases?  Run the script with --no-upload option and attach the outputs.
> 
>     thanks,
>     
>     Takashi
>     
> Issue now reappear, output from alsa-info.sh are attached. If they are still
> needed.

Thanks.  The obvious difference seems to be the assignment of two DACs
0x10 and 0x11 for headphone and speaker outputs.

Christoffer, how are those on your machines?


Takashi

