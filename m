Return-Path: <linux-kernel+bounces-343532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A00989C28
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04EC01F21F14
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14050166F00;
	Mon, 30 Sep 2024 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dlOjIu+6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ml+h/3l4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ODdleCwc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jhcAQDS3"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93540862;
	Mon, 30 Sep 2024 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683439; cv=none; b=YYCEToR9aODRzn9VMy607jftNH2D6/LVa/mOv2hGFcpfa0uODpPpe86O8fJv39v9dYnh8YmqYTF7O/DyxwBuBkjNfwXl/1sgtIyGnBTYNIHtvPs+yYEYGJymxhCsmFsBKjcBqZfBnUCp8tUNBLBzr+4sbuoJrDp7uHalOlKbqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683439; c=relaxed/simple;
	bh=sFCU0uT2f4V+BnM4FzPrNtiBLsLpUqPoiOMjYLKsK7A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8MxPOzTzpoA7kq7ERlzZCmZaNO4aRPnq2AlpIW04xgrTXA/WEpgRbFCXixAIkTomCJskn3KikqLKSSAHWpuxl0MhIC3GkBx15O0+p1xfE9n87Zjq+qK9hzP0rxzQF/QdtXdPoRb/evxqaFeWiLa945+6hmzkhxm28A5Hi9ZKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dlOjIu+6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ml+h/3l4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ODdleCwc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jhcAQDS3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F0531F7F0;
	Mon, 30 Sep 2024 08:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727683436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2XGm8wML56b8CDPsfhC+lG6xuwQmxCg0oCIzC28IFqs=;
	b=dlOjIu+6cMUSE6wf1HyphkZOz2+ubrj53WrK4XwtMk0vi/z4DIcbjqOyQhMV56WoXbWeBh
	UN9/S/D0PX1lZizPzudQ/Lrt+cKKJp/2BZApBtxqpZ3aesfuXL2f5BISI6cl5qzvRvYAhY
	H5Tahay6Hx1Xvu6g//kjgPmjGy/LtJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727683436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2XGm8wML56b8CDPsfhC+lG6xuwQmxCg0oCIzC28IFqs=;
	b=Ml+h/3l4GOANjnull1EssqLY6AswSpaFnCxA8icaRofOnvAHjUTckSjmSWlja7xInVw+tO
	jU45gHts6g4KECDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ODdleCwc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jhcAQDS3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727683435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2XGm8wML56b8CDPsfhC+lG6xuwQmxCg0oCIzC28IFqs=;
	b=ODdleCwcIYS18L/1dT2m6n5yOFKU8g84Vk49FqTJrp9K1TeB0Paqwc7m7n/U1k6EPeXqtS
	WCJ5YvzZSCleN8EZWSxUENiaqU12FN8nHk4ExBkvW1OrPEEwkkphNJQyApmk4NRJ/Wfmab
	6tC8XS8BOnJeoTLvbVe8tT3wObGdQ0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727683435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2XGm8wML56b8CDPsfhC+lG6xuwQmxCg0oCIzC28IFqs=;
	b=jhcAQDS30xfyzQsz939KumeN6YAsHEZtQE8Ef1Tfx6/FRZ7Se34josvQGaL5R0CUKwtw6y
	VfJiogtxt6yPnSDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B642413A8B;
	Mon, 30 Sep 2024 08:03:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3I1EK2pb+mY+FAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 30 Sep 2024 08:03:54 +0000
Date: Mon, 30 Sep 2024 10:04:47 +0200
Message-ID: <87bk05k1nk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ai Chao <aichao@kylinos.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	josh@joshuagrisham.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Huawei MateBook 13 KLV-WX9
In-Reply-To: <20240926060252.25630-1-aichao@kylinos.cn>
References: <20240926060252.25630-1-aichao@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 0F0531F7F0
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 26 Sep 2024 08:02:52 +0200,
Ai Chao wrote:
> 
> The headset mic requires a fixup to be properly detected/used.
> 
> Signed-off-by: Ai Chao <aichao@kylinos.cn>

Applied now.  Thanks.


Takashi

