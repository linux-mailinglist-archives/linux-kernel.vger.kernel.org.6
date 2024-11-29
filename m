Return-Path: <linux-kernel+bounces-425429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEDD9DC1ED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D93EB20FF3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DED189BA8;
	Fri, 29 Nov 2024 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NwNgrWnh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zF4kRas2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ngvX9RxB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BiSx415H"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0614C5B0;
	Fri, 29 Nov 2024 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732874776; cv=none; b=kcWCV7ERYbRFNueYbR2uyDuE4VPisHU0AFhouazKGGt9O+dmHSinqt+KzkLJqcFsQFACbpgrYi7DL+Ezxf9XrN+bTB7Mn2IoQf/r1PPMjR6LdHJq0Z8vOQ6LACogCHQreN7cfulpy71NKaG0IceV4yMZJQkk8dOCCPRaI4FJd38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732874776; c=relaxed/simple;
	bh=Hl00BjCfhciezHzis82v2nRi92k9UMOvV3Faam5pOTQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbbZGP1j/1IE5ENrcyESD4BjHzrVAt9b7UcmjrXnvOu1jrme93Hh7YaTJ0gBVw+/3z+Q7CHpm/wtCPZi+YvE9Lbl73Fr3diNZ5LUXLvdn2st8rDgIsJH8WLnm+mnX+bj8EXRkIIH+IA/ieG2Jjsky6cX+9xqZUTDK5byRiDBw44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NwNgrWnh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zF4kRas2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ngvX9RxB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BiSx415H; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D847621177;
	Fri, 29 Nov 2024 10:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732874773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+IwV0x9dYzcu5k7ay/kKo733CnYrSOVULCe8y3xhN4=;
	b=NwNgrWnhhZF2kAxwl1xiC8X7cHxevc2Z9DzNG/10v1LNiFxXhvTnu9QImc+rAjXoaQ/pDX
	TX0jNyaLXWXGt0wFKZ4ABOe4LAXFU7rHwWkEmkhNKbr6bkVqz/Wf+aLfEeGc33A4b1iOdD
	TVsesujBxiJGs8lFHXt1fn8IsnGqR3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732874773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+IwV0x9dYzcu5k7ay/kKo733CnYrSOVULCe8y3xhN4=;
	b=zF4kRas2vqASLwupo9EwIDgMCKwLKAEOH7YxSGItRoDLwBeahIOEhUk6/A0Y9NKnQ4LpiQ
	1KeQ7nCZDBd11+BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ngvX9RxB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BiSx415H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732874772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+IwV0x9dYzcu5k7ay/kKo733CnYrSOVULCe8y3xhN4=;
	b=ngvX9RxBtFZrUuW+6tXdAHaHIc6lxQrVw/2t22LLObMKikZonjdvLKYuJ7LA8OtgXky9IU
	TcEdm1W0is7601rL7whBzB6k6P0VX29DKrIDszVANmatKQz0TMdoknLCU5BUIHNEBfEhet
	1gSbCmybVSgaWSHhW9CeGF9Qs80O9Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732874772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+IwV0x9dYzcu5k7ay/kKo733CnYrSOVULCe8y3xhN4=;
	b=BiSx415Hzw9eVTBTKdGLyPw/4s+kjWCoDQnFSrKY24JWin5qhaLGGLH6z7B1MfsyXnvne9
	quUpkSgRE4GxxCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7553133F3;
	Fri, 29 Nov 2024 10:06:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AyigJxSSSWdoXQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 29 Nov 2024 10:06:12 +0000
Date: Fri, 29 Nov 2024 11:06:12 +0100
Message-ID: <87o71y5p7v.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: bo liu <bo.liu@senarytech.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	feng.liu@senarytech.com
Subject: Re: [PATCH V2] ALSA: hda/conexant: fix Z60MR100 startup pop issue
In-Reply-To: <20241129014441.437205-1-bo.liu@senarytech.com>
References: <20241129014441.437205-1-bo.liu@senarytech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: D847621177
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Fri, 29 Nov 2024 02:44:41 +0100,
bo liu wrote:
> 
> When Z60MR100 startup, speaker will output a pop. To fix this issue,
> we mute codec by init verbs in bios when system startup, and set GPIO
> to low to unmute codec in codec driver when it loaded .
> 
> Signed-off-by: bo liu <bo.liu@senarytech.com>

Applied with minor white-space fixes now.  Thanks.


Takashi

