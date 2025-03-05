Return-Path: <linux-kernel+bounces-547518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B73A50A59
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE213168430
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925B4252911;
	Wed,  5 Mar 2025 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PpqEfdfA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uaiZ7kje";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2TiqfMOy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uaiZ7kje"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDB51C863A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200837; cv=none; b=DMNki7IQaw7aDYX3Z/QULJcXrjQZ0XvENa400gMYtdrL1bs2tL2rj7eJNF5PrV6ktekILqY7XYSJiTnrVunf8rXjhR6O4+oONj9IxrbKGoX8m/BY1Fq/fpqzGmY/HGeClFYWY9/++fFqA9nHQGdY3HLIOECRjkU9ZcO9/liaYeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200837; c=relaxed/simple;
	bh=3cq7gDHWYX9B5hkXU82IO10/vE5OhALp3Tf7wVmp8rQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MiaNCRhkn7bodO9J0tBPwocy7VWyVRhIy98TmS+OklLtlWLGJxSieh6gZ5w1XC77ffPeD9svS9Z7dZ6OUXQTHpdk3kcREKQE7032fq25uagQ640kN3o09V5TIDgTeyMl1t4S7IjfDbeJP7KQCBiSyYlykTPKPxUDUAwxY+yXr4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PpqEfdfA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uaiZ7kje; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2TiqfMOy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uaiZ7kje; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F2B691F37E;
	Wed,  5 Mar 2025 18:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741200834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+FZIZhHm+gbadO7RjQ23J/lkTdz43cQOamtvD4EPji0=;
	b=PpqEfdfAEwiVTsoQxdtSgYl+now1WuXaBYfPGPFztY7fi6nk9NRe44wyXd14Al7U/oktez
	wzJ2pUAiUhbnpTebE56Gzo0DoAwjhiX3XlIoTrb4e5deDKt+e7G89XmfES+/eJhWFBR4Ok
	Wrcaw0fhIuJHJ+c8XPvfkxgtlS1/QH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741200834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+FZIZhHm+gbadO7RjQ23J/lkTdz43cQOamtvD4EPji0=;
	b=uaiZ7kjeim1kvvgs7OdHbRBJQYmdiHaNx7N6Ax5xxw3ujVfVGTgeFCC6uiCGGNh7dKlU/M
	yQwgLVDapbRWy7Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2TiqfMOy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uaiZ7kje
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741200833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+FZIZhHm+gbadO7RjQ23J/lkTdz43cQOamtvD4EPji0=;
	b=2TiqfMOyDaAcDuT2fsd141QWDVuKrwAT47wUlbCKBK5waQuMcn+u8g1Xs6HajVeSWuDKIR
	8rinkY+xXJktqY43QgCak8wViD3+/Yn4HE59h9cozYnbMQaEoIoSPBWtzimwSss7Jmf5Wy
	RxpRukTPKBsr15PmOvrGBAqF68623Us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741200834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+FZIZhHm+gbadO7RjQ23J/lkTdz43cQOamtvD4EPji0=;
	b=uaiZ7kjeim1kvvgs7OdHbRBJQYmdiHaNx7N6Ax5xxw3ujVfVGTgeFCC6uiCGGNh7dKlU/M
	yQwgLVDapbRWy7Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD1C613939;
	Wed,  5 Mar 2025 18:53:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k9N3LMGdyGc1KQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 05 Mar 2025 18:53:53 +0000
Date: Wed, 05 Mar 2025 19:53:53 +0100
Message-ID: <87plivqpfi.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v1 0/7] Add Support for various ASUS laptops using CS35L41
In-Reply-To: <20250305170714.755794-1-sbinding@opensource.cirrus.com>
References: <20250305170714.755794-1-sbinding@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: F2B691F37E
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 05 Mar 2025 18:06:44 +0100,
Stefan Binding wrote:
> 
> Add support for several Commercial and Consumer laptops using CS35L41 HDA.
> These laptops use combinations of Internal and External boost, as well as
> SPI and I2C.
> 
> Stefan Binding (7):
>   ALSA: hda/realtek: Add support for ASUS ROG Strix G814 Laptop using
>     CS35L41 HDA
>   ALSA: hda/realtek: Add support for ASUS ROG Strix GA603 Laptops using
>     CS35L41 HDA
>   ALSA: hda/realtek: Add support for ASUS ROG Strix G614 Laptops using
>     CS35L41 HDA
>   ALSA: hda/realtek: Add support for various ASUS Laptops using CS35L41
>     HDA
>   ALSA: hda/realtek: Add support for ASUS B3405 and B3605 Laptops using
>     CS35L41 HDA
>   ALSA: hda/realtek: Add support for ASUS B5405 and B5605 Laptops using
>     CS35L41 HDA
>   ALSA: hda/realtek: Add support for ASUS Zenbook UM3406KA Laptops using
>     CS35L41 HDA

Thanks, applied all patches now.


Takashi

