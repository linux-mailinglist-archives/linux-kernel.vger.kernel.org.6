Return-Path: <linux-kernel+bounces-181143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E823E8C7828
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3258285F92
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CFC146D51;
	Thu, 16 May 2024 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ehd7q8u0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Pc1HbMUa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ehd7q8u0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Pc1HbMUa"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327DC4206C;
	Thu, 16 May 2024 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868054; cv=none; b=uDH4quMiscfsEZEEZcOlpvra4F7dZFgYtatsxpvmoi83ro3Teh1u6JX2cHTsrNXNHLdm6AoHWYcOPmvXAAHQMRk78Uu8dHVxdTOc9QdkbeUboXziWQJjJE5oqnh2zwk9MZ53EWislccRrucQb7xgvLU0JGMN1mT0HJM53/eaS6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868054; c=relaxed/simple;
	bh=DCdCl+jO0kjYmCxdZw/zHZZwCC5836MYIRE9rGfvjHE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=An44NJnKBPnjgO5xeY9sRbFaUuayYr4JAfon+0XiAHmilT2Ht3EbVwIelhN95EBc0aiVW5YWOQJH5M72ADaEgCyLSv0zBJP9cr5iCvfbQXPuCayxwbHxPkGbLdi8u8hfSJlMKQoDxXzSwp1BR4BJjVn0SILv0i1yfWFxhNC+OKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ehd7q8u0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Pc1HbMUa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ehd7q8u0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Pc1HbMUa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4F29F34A41;
	Thu, 16 May 2024 14:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715868050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YV3n87S+h1/ApYJqiZ5Lqmv/bboT8c5+IyTyEnHIynI=;
	b=ehd7q8u0Dr4iNB7fXOgxCENd54A6+3C1PsJCxeSepn3kTJRNlEo4QZMdSZDPXE5LE1fyTZ
	tGUOprAzMEfTm/PTqkGHarEMdvTkufO9q3iJ1wFJP32VM23Le1KT9t+ahSX9Chgrg3lj93
	/PtNuapNWjx4VKUode2k0LJfsjcrUkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715868050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YV3n87S+h1/ApYJqiZ5Lqmv/bboT8c5+IyTyEnHIynI=;
	b=Pc1HbMUanNRRj/57iLCy3e51lQSz2YaeTKQA6unx280Qn7rK0l+PqTz0BrWCw3CQ0dRD2D
	aJzKKjTnY8leS1AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715868050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YV3n87S+h1/ApYJqiZ5Lqmv/bboT8c5+IyTyEnHIynI=;
	b=ehd7q8u0Dr4iNB7fXOgxCENd54A6+3C1PsJCxeSepn3kTJRNlEo4QZMdSZDPXE5LE1fyTZ
	tGUOprAzMEfTm/PTqkGHarEMdvTkufO9q3iJ1wFJP32VM23Le1KT9t+ahSX9Chgrg3lj93
	/PtNuapNWjx4VKUode2k0LJfsjcrUkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715868050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YV3n87S+h1/ApYJqiZ5Lqmv/bboT8c5+IyTyEnHIynI=;
	b=Pc1HbMUanNRRj/57iLCy3e51lQSz2YaeTKQA6unx280Qn7rK0l+PqTz0BrWCw3CQ0dRD2D
	aJzKKjTnY8leS1AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04DF113991;
	Thu, 16 May 2024 14:00:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8F0yO5ERRmazSQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 16 May 2024 14:00:49 +0000
Date: Thu, 16 May 2024 16:01:06 +0200
Message-ID: <87ikzd3lgd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Abhinav Saxena <xandfury@gmail.com>
Cc: linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: sound: Fix trailing whitespaces
In-Reply-To: <20240515034103.1010269-1-xandfury@gmail.com>
References: <20240515034103.1010269-1-xandfury@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-2.84 / 50.00];
	BAYES_HAM(-2.54)[97.94%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.84
X-Spam-Flag: NO

On Wed, 15 May 2024 05:41:03 +0200,
Abhinav Saxena wrote:
> 
> Remove trailing whitespace from sound/hd-audio/notes as reported by
> checkpatch. Removing trailing spaces improves consistency, and
> prevents Preventing potential merge conflicts due to whitespace
> differences. maintain a cleaner and more professional codebase.
> 
> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>

Applied to for-linus branch now.  Thanks.


Takashi

