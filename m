Return-Path: <linux-kernel+bounces-245580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E3992B48F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015901C227B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BED815575C;
	Tue,  9 Jul 2024 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bmqg5BEZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="udF14+mV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n6cdigFQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dVSUL5VV"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B3A26AC9;
	Tue,  9 Jul 2024 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519160; cv=none; b=gwMcCAxq2l7mU4aQo0XZapfD6zh45AwhsRwTQ98OJTwzGA2iKcouedRtadi+vsnLOU3xIAjbE5e4EzkGdKCzIxvTg756j4Z8WWG4s6g+T8qWhR56aPav21+o/hu+9iQcmkNUKQwr/hX/R7z53KmfohSua67nE1ZQU+Snvgw5y2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519160; c=relaxed/simple;
	bh=0L8qZkIRswnVHIoZOL+QpI04Q8AqBRQSC0Xu+OGaZs8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XyUJx1L2bFsZJu6HPuKrKnb/DcaJudexpkBRJTINHZTQ0n2gNqH34clof5tkQ1S53jboizMiNsokfEG4lxbyqCCxsPiLZz+PixzluhZenfcj09vXvtGpC/Rbz64wfsoAEFxnm2zHHIis0j6ls8Wrh6ru+r5Mbd66cqsr6FhnZH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bmqg5BEZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=udF14+mV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n6cdigFQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dVSUL5VV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E55221B9A;
	Tue,  9 Jul 2024 09:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720519157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eFGyhwLjwHvqnxzFNZDxqYKqmIP/aQi15p3X3ME9A3o=;
	b=bmqg5BEZ5b48Xex84v8vIqjga9EzKe8xHztDHcnQyLQ4MMUPhEoGvK37VOaDnKVJ3hq7ib
	Hg9iX8u1aZo3u8UPw4YXoQdfE5AVCe5GfCfa+gL0E4h4WIAaD7iTxkoQJ3uB6/jom5SalV
	z9SNnHGlJQPPHLDYkqP6cG4dW8MkGa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720519157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eFGyhwLjwHvqnxzFNZDxqYKqmIP/aQi15p3X3ME9A3o=;
	b=udF14+mVf4SnwpCqK7VBfc8N7pyRSORzth19dk9ss3c3jgYttrmeBhritgXd/Hl9lHCSsw
	BMuxaGf0uAKFqKAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=n6cdigFQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dVSUL5VV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720519156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eFGyhwLjwHvqnxzFNZDxqYKqmIP/aQi15p3X3ME9A3o=;
	b=n6cdigFQhLcLLZEnHKZ2+8bjmo1bLYgVsne3zCW7t8hGjnwHfxN+QC4OrZY7kKAeBnPbvA
	+ZVaIAaNYGWU/OY9LrZ0nDuUz2JrM+ESc/1X2ZSGdkWaMC5FzH/nHaebC8Ol1bCkaXCo8A
	mjoxNlJQruCz/hR5ZWjnRS66171WkXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720519156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eFGyhwLjwHvqnxzFNZDxqYKqmIP/aQi15p3X3ME9A3o=;
	b=dVSUL5VVE2wrfVPGBbq+3qAPxBGTkfblA/rcRQR6iajM1gaR81MuIQEpj6kCiisYdItrqt
	7v474Mh2ESFeUvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBD051369A;
	Tue,  9 Jul 2024 09:59:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 24cBOfMJjWY5RQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 09 Jul 2024 09:59:15 +0000
Date: Tue, 09 Jul 2024 11:59:46 +0200
Message-ID: <878qyadgx9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Nazar Bilinskyi <nbilinskyi@gmail.com>
Cc: tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable Mute LED on HP 250 G7
In-Reply-To: <20240709080546.18344-1-nbilinskyi@gmail.com>
References: <20240709080546.18344-1-nbilinskyi@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 0E55221B9A
X-Spam-Score: -3.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, 09 Jul 2024 10:05:46 +0200,
Nazar Bilinskyi wrote:
> 
> HP 250 G7 has a mute LED that can be made to work using quirk
> ALC269_FIXUP_HP_LINE1_MIC1_LED. Enable already existing quirk.
> 
> Signed-off-by: Nazar Bilinskyi <nbilinskyi@gmail.com>

Thanks, applied now.


Takashi

