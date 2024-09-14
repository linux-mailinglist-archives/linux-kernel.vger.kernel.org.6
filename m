Return-Path: <linux-kernel+bounces-329291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E83978F9E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183251F23880
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3FE1CE700;
	Sat, 14 Sep 2024 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dedP4Nns";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5M0tRan8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dedP4Nns";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5M0tRan8"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AB833999;
	Sat, 14 Sep 2024 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307515; cv=none; b=sM5xrlxXTMdt5EZ908fOxmY2IvWHmZAy8QES2lLs854jyAs+H60gHd+FC3mJmRUoxaDMXqjvcv43HcxSL6sEhMFb0VIjbHeETTIXJXMseZgaNp6Ajbf4znUoN18SCOlnqb2b04iTixUo7RkHgOlqXe8cOpF5ckSx8Gmx9D8K0xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307515; c=relaxed/simple;
	bh=2yikssCdp1JPdL8XEX6SBB0au0SzZL1DOJS0MZ9IpGQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSXczY1VIegZiYWRfjw4rCNmRBfC7vCtN6brohr+5rQ6gH5Jeesem9oRzR1rv8PSJ6VgtViEtvLdbtsWsLZyDjTYAc4yAYb/frTfBbAX1xeOuQ7Y+idnI3L/BigJ3dQOP/OTzFiHKN+hYAVy5TUpuQ2gtNjnJWWoKh3amvWanCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dedP4Nns; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5M0tRan8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dedP4Nns; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5M0tRan8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 506991F799;
	Sat, 14 Sep 2024 09:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726307506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gZcrCKONdWFUS0jrSo5Rm8gsT83F1J8Ugnq74mhVzzM=;
	b=dedP4NnsygE4kgcAvjQSOxPJl59WlLVEz4MaQAgi/K48CqvhfB3qg81owRQvOBSt70OrBz
	zawFMyIB7LGpRU8hnnpH+5qcW+orQPmkTQ1qnL/MuYTpzp9QK/e5eVwhWmkQ8KiUrUlopz
	F6ljZo8Pqal9+bUb3BHLs5mSVOin2FA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726307506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gZcrCKONdWFUS0jrSo5Rm8gsT83F1J8Ugnq74mhVzzM=;
	b=5M0tRan8orR52AkYE7zxJCj7/JEWMKpLT6Y8A8URkFt43gM4Uo16F+QMQ+EqhDSG+BegB+
	GUYJHjShaRYmLFAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726307506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gZcrCKONdWFUS0jrSo5Rm8gsT83F1J8Ugnq74mhVzzM=;
	b=dedP4NnsygE4kgcAvjQSOxPJl59WlLVEz4MaQAgi/K48CqvhfB3qg81owRQvOBSt70OrBz
	zawFMyIB7LGpRU8hnnpH+5qcW+orQPmkTQ1qnL/MuYTpzp9QK/e5eVwhWmkQ8KiUrUlopz
	F6ljZo8Pqal9+bUb3BHLs5mSVOin2FA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726307506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gZcrCKONdWFUS0jrSo5Rm8gsT83F1J8Ugnq74mhVzzM=;
	b=5M0tRan8orR52AkYE7zxJCj7/JEWMKpLT6Y8A8URkFt43gM4Uo16F+QMQ+EqhDSG+BegB+
	GUYJHjShaRYmLFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A4AE1386E;
	Sat, 14 Sep 2024 09:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M8LPBLJc5WYUegAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 14 Sep 2024 09:51:46 +0000
Date: Sat, 14 Sep 2024 11:52:35 +0200
Message-ID: <87frq2blzw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linux Sound Mailing List <linux-sound@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sound fixes for 6.11-rc7
In-Reply-To: <CAHk-=wi+31+ctjVhgVww4MN9vD=vc27uw_KepbufhgzxaEHViw@mail.gmail.com>
References: <87ldzubqgr.wl-tiwai@suse.de>
	<CAHk-=wi+31+ctjVhgVww4MN9vD=vc27uw_KepbufhgzxaEHViw@mail.gmail.com>
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
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 14 Sep 2024 11:50:25 +0200,
Linus Torvalds wrote:
> 
> On Sat, 14 Sept 2024 at 10:15, Takashi Iwai <tiwai@suse.de> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.11
> >
> > The topmost commit is 134536c21275bb3410cd1f10c5e369d30702741d
> 
> -ENOSUCHTAG.
> 
> I see the branch with that commit, but no signed tag. Forgot to push?

Oops, sorry, pushed now.


Takashi

