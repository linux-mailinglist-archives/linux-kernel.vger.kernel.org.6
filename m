Return-Path: <linux-kernel+bounces-544855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70250A4E5F3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075A18A80C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72C327FE7D;
	Tue,  4 Mar 2025 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yFSgXNX4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SrDaeMDK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yFSgXNX4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SrDaeMDK"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F6B20DD4C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104239; cv=none; b=WwVyZdH0SNmI1W75wrXF+SnKj4rKchNLiBe0mZDeggYy7kLq2tMC89TzBFSgbUj9vtWJwbx2c5Y0AITAYeLAkfmlA54LLr1Dd4Tm3LVNP56udJekHdIfRzXuNO3yFoEk/zZBVmO4JK6Rq8CujSxA6IBnESx0wagtirNP+sU1+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104239; c=relaxed/simple;
	bh=bdwxiy4kXslJpByfIdTnVDJq1CDBP0ngp/DxK3nUyt4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCfVdpX8F+HfU9xyaxevBmuOPl3kzRf8o7q3Fhs5NaXCaj3KVLvSs8hYKBakVV4t/89Aa88KbC/xGQZYAk5HuT1Q0QLmN3cO40oqGclEi6zeKzCFz3H3YbAr/jXIAQ8x8J4clPTO9r2qIa+8CKpDKg943B8h0JPoTQPguaVaJFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yFSgXNX4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SrDaeMDK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yFSgXNX4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SrDaeMDK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AB6B2211AA;
	Tue,  4 Mar 2025 16:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741104235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQA4ZIhyW/4iFLrkSc1IiUv3MxWcxzn4jf4rHXFSogU=;
	b=yFSgXNX4jc+uqjUtMH5wMgVvFaodqX6e9s4SwS8K0KhZ4aZSZMtS/bACHX+8yGvwzTfUP9
	UROEMsE7QR6idKY+8194IWKMtrelnzM+FGnotmyhZab+B/BBSxL6Vwj7NAeZxitHnNlirj
	JjzMmP/exm0buZlKlYwAasCeFsHrEwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741104235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQA4ZIhyW/4iFLrkSc1IiUv3MxWcxzn4jf4rHXFSogU=;
	b=SrDaeMDKrjmOwLLCmKcJs5AkAe8npd9Wct1Eq8g9ayCG/tFCZSIh9wBzj7zyyJbUU/iG7G
	pWemtxMOmz1EAQAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yFSgXNX4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SrDaeMDK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741104235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQA4ZIhyW/4iFLrkSc1IiUv3MxWcxzn4jf4rHXFSogU=;
	b=yFSgXNX4jc+uqjUtMH5wMgVvFaodqX6e9s4SwS8K0KhZ4aZSZMtS/bACHX+8yGvwzTfUP9
	UROEMsE7QR6idKY+8194IWKMtrelnzM+FGnotmyhZab+B/BBSxL6Vwj7NAeZxitHnNlirj
	JjzMmP/exm0buZlKlYwAasCeFsHrEwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741104235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQA4ZIhyW/4iFLrkSc1IiUv3MxWcxzn4jf4rHXFSogU=;
	b=SrDaeMDKrjmOwLLCmKcJs5AkAe8npd9Wct1Eq8g9ayCG/tFCZSIh9wBzj7zyyJbUU/iG7G
	pWemtxMOmz1EAQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89F4B13967;
	Tue,  4 Mar 2025 16:03:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BJwfIWskx2d7UQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 04 Mar 2025 16:03:55 +0000
Date: Tue, 04 Mar 2025 17:03:55 +0100
Message-ID: <87ikooail0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Takashi Iwai" <tiwai@suse.de>,
	"Arnd Bergmann" <arnd@kernel.org>,
	"Jaroslav Kysela" <perex@perex.cz>,
	"Takashi Iwai" <tiwai@suse.com>,
	"Kailang Yang" <kailang@realtek.com>,
	"Simon Trimmer" <simont@opensource.cirrus.com>,
	"Joshua Grisham" <josh@joshuagrisham.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] snd: hda: realtek: fix incorrect IS_REACHABLE() usage
In-Reply-To: <94b39ea3-bc29-49f0-bd34-eec45d61ff1b@app.fastmail.com>
References: <20250304142620.582191-1-arnd@kernel.org>
	<87tt88oo05.wl-tiwai@suse.de>
	<94b39ea3-bc29-49f0-bd34-eec45d61ff1b@app.fastmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: AB6B2211AA
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 04 Mar 2025 15:54:33 +0100,
Arnd Bergmann wrote:
> 
> On Tue, Mar 4, 2025, at 15:43, Takashi Iwai wrote:
> > On Tue, 04 Mar 2025 15:25:55 +0100,
> >
> > Thanks for the patch.  Indeed it's a very corner case, but I still
> > hesitate to add a kconfig dependency.  Can we take an alternative fix
> > to define the proper dummy functions like below instead?
> 
> I'm sure that works, and I had considered something like that,
> but I really dislike the IS_REACHABLE() use because I think it
> causes more problems than it solves. (I introduced the macro
> originally but regret that).
> 
> Note that the only way to disable input is to have manually flip
> CONFIG_EXPERT and CONFIG_TTY as well as the major GPU drivers
> that select it:
> 
> config INPUT
>         tristate "Generic input layer (needed for keyboard, mouse, ...)" if EXPERT
>         default y
> 
> so in the end, there is very little difference between
> your patch and mine, as they both fix build testing on
> randconfig.

OK, I don't mind much, so I take your patch now, as this actually
reduces the code size.


thanks,

Takashi

