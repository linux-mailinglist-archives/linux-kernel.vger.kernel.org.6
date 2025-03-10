Return-Path: <linux-kernel+bounces-553959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA2FA59126
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1B73A3593
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B26D226545;
	Mon, 10 Mar 2025 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A7dDRtIf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jAyVPhJ+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A7dDRtIf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jAyVPhJ+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7C921D585
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602506; cv=none; b=n4X+RrPlgDreY5+wC0Z0BGEAYanJOnyVXQzkmTQ4nMGx6/IAp9mzttSfIyu5oDOIsAgBJhSZ8pmmOR0IOHoK7I6ILB+wqcA+t1tjbGMwUtkLM7WpqmgXj4YLrzUlCDusXQTlwc13hDYN1iV2f7DZ2lzn1khlWN+vv7289Ltuu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602506; c=relaxed/simple;
	bh=aXI+JMKiOqLVkfblHR5HjhlgmjRLkXpcCkuWsHpOjFI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaSCUAoHPnaivRrhWellUlXBD0pTYYnCXTzcApTksaLm5vWjn5nOvKOzzrxQ5UerovrCwN79KSsQZP4p16rhQFIupMWO8SsBYIjjcmEP9wNSQdOU0uN9ZbCMztWb9M73bTkvCkamob9zhX0g/qlSbe/GJDY7Uo13jmkhFqawma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A7dDRtIf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jAyVPhJ+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A7dDRtIf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jAyVPhJ+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 067191F387;
	Mon, 10 Mar 2025 10:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741602503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0+5Q/4zdvQm4ku6LSLVA8gfuk2ie1/5ffTFd6Zp7eM=;
	b=A7dDRtIfkpLlfC/A0SDoU1lUGmIP9nyrWqswDTFh1M95ZVjestadNTnKpBHsWrArcyoSyZ
	JDKuG/XsfEJirj+Rvg785aQEDzE+dxWhjL1Lsb9mI3xvQBBr8/Wf6YY7h8/6hk8vxAhI+p
	T2edpKBIpgraMZoW+N61K9gs237jYPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741602503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0+5Q/4zdvQm4ku6LSLVA8gfuk2ie1/5ffTFd6Zp7eM=;
	b=jAyVPhJ+a2tMcGXvsU0yxufznWHpZ3DiMjuLYd38/2KODI6TcpOsi9EAfglTbuN8NoF4iA
	O1a/8qDBhTDSB9Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A7dDRtIf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jAyVPhJ+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741602503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0+5Q/4zdvQm4ku6LSLVA8gfuk2ie1/5ffTFd6Zp7eM=;
	b=A7dDRtIfkpLlfC/A0SDoU1lUGmIP9nyrWqswDTFh1M95ZVjestadNTnKpBHsWrArcyoSyZ
	JDKuG/XsfEJirj+Rvg785aQEDzE+dxWhjL1Lsb9mI3xvQBBr8/Wf6YY7h8/6hk8vxAhI+p
	T2edpKBIpgraMZoW+N61K9gs237jYPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741602503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0+5Q/4zdvQm4ku6LSLVA8gfuk2ie1/5ffTFd6Zp7eM=;
	b=jAyVPhJ+a2tMcGXvsU0yxufznWHpZ3DiMjuLYd38/2KODI6TcpOsi9EAfglTbuN8NoF4iA
	O1a/8qDBhTDSB9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D406B139E7;
	Mon, 10 Mar 2025 10:28:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 65GUMsa+zmc7aQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 10 Mar 2025 10:28:22 +0000
Date: Mon, 10 Mar 2025 11:28:22 +0100
Message-ID: <87r035yybd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Navon John Lukose <navonjohnlukose@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add mute LED quirk for HP Pavilion x360 14-dy1xxx
In-Reply-To: <20250307213319.35507-1-navonjohnlukose@gmail.com>
References: <20250307213319.35507-1-navonjohnlukose@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 067191F387
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 07 Mar 2025 22:33:19 +0100,
Navon John Lukose wrote:
> 
> Add a fixup to enable the mute LED on HP Pavilion x360 Convertible
> 14-dy1xxx with ALC295 codec. The appropriate coefficient index and bits
> were identified through a brute-force method, as detailed in
> https://bbs.archlinux.org/viewtopic.php?pid=2079504#p2079504.
> 
> Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>

Thanks, applied now.


Takashi

