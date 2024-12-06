Return-Path: <linux-kernel+bounces-435030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4379E9E6E9D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F0116A5CD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C9D201006;
	Fri,  6 Dec 2024 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JZhNT4r4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kYqmnMWf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JZhNT4r4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kYqmnMWf"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7AF204F93;
	Fri,  6 Dec 2024 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489586; cv=none; b=WxsfLDimxX9tPQzGLyNXbEvyxUW6JO2phiEHvBKskqhg7QxUqEnwhkoIgETXxbLkmR6rHBzNbL+XJG6XKlzyLbSKyVvhuxFYp9xXR4g/i63iHS6dNugFiNfCTA98dNIjirJe1RaTFkfqkVyZ3LdqNooBjsR6WDwBYvp3elZOSMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489586; c=relaxed/simple;
	bh=NNH2CGKsXiIZdsvoeSaZfIlniAYTVmFKET6/rDs6msk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCRRADmCLnFxx3pHkAtlfybd4uqJigBIZephDlFfhi3X1GMz7HyOpVudGULYVWCKBOIi3qaK+sZQGKojvgBeMqEPXcJZYxNprOM2FxSXrobfMC7F18p/4GRQns5FXoWp8o8zmtEBJrdfYpoGG0Gy21mcN7ji3IlncGBsOGJsohU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JZhNT4r4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kYqmnMWf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JZhNT4r4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kYqmnMWf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68003210F9;
	Fri,  6 Dec 2024 12:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733489583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e/kv/kcjd5RCRuH56GPV04913ebZVWwqbwnwfd1cpwo=;
	b=JZhNT4r4grJDNg27S6f4NDQJum5w05pe7mLKQE1dQi8pl824gmPz4GzoGYS2r9xqh6TiFF
	id+YcOZl5L/3tj18WH6mi0a1UPzt1ahBLPLV/Z+wPp1gl23eghDINix7n1Ndx5T9ZH7wr7
	DXh+8GK5kXtXuYTQjGxJSyx2etbQ3VY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733489583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e/kv/kcjd5RCRuH56GPV04913ebZVWwqbwnwfd1cpwo=;
	b=kYqmnMWfrq5DfEse5F0+W80tpuaMVE2c+RFS2aRVN03/4ZG4fC9S65RLxOHWsLSRWNOjI3
	mJEamOmkaYIb/NAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733489583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e/kv/kcjd5RCRuH56GPV04913ebZVWwqbwnwfd1cpwo=;
	b=JZhNT4r4grJDNg27S6f4NDQJum5w05pe7mLKQE1dQi8pl824gmPz4GzoGYS2r9xqh6TiFF
	id+YcOZl5L/3tj18WH6mi0a1UPzt1ahBLPLV/Z+wPp1gl23eghDINix7n1Ndx5T9ZH7wr7
	DXh+8GK5kXtXuYTQjGxJSyx2etbQ3VY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733489583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e/kv/kcjd5RCRuH56GPV04913ebZVWwqbwnwfd1cpwo=;
	b=kYqmnMWfrq5DfEse5F0+W80tpuaMVE2c+RFS2aRVN03/4ZG4fC9S65RLxOHWsLSRWNOjI3
	mJEamOmkaYIb/NAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26DBC138A7;
	Fri,  6 Dec 2024 12:53:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PxE9CK/zUmfFSwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 06 Dec 2024 12:53:03 +0000
Date: Fri, 06 Dec 2024 13:53:02 +0100
Message-ID: <87o71prn0x.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: seq: oss: fix typo in seq_oss_init.c
In-Reply-To: <20241206031727.20500-1-zhujun2@cmss.chinamobile.com>
References: <20241206031727.20500-1-zhujun2@cmss.chinamobile.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Fri, 06 Dec 2024 04:17:27 +0100,
Zhu Jun wrote:
> 
> The word 'annoucement' is wrong, so fix it.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Applied now.  Thanks.


Takashi

