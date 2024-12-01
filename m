Return-Path: <linux-kernel+bounces-426566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA059DF508
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 09:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D508281110
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 08:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74707083E;
	Sun,  1 Dec 2024 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tIftdx7D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m9/4G5Fh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1w6Y9+zv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fjk5g+Fb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3DF6FD5;
	Sun,  1 Dec 2024 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733043068; cv=none; b=m0AY5GXdJ3cU5x9ozzjeVHVdU/0eswtsSlwzakjK7VwSic0rCRDADsmJ0KRj57MSNmzIPWPcdBBT/Sinv9XekPVAHy/5rxMiV1g60lXbeXgTh4Jh2YHO5XsM08x31iE6VeL2SAs0C1MsT2auLlFeBf/7qktT8loMni7JlRHOxY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733043068; c=relaxed/simple;
	bh=Qe+D83qXumroTRyr7fSFDsUTe1V0pjsTvwSStSp0B0c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZHxPQmQxMJpLulWm/7NWpWdsMDVJaBt9u52i9UaN0cAZPCnaSVP7SMio7+xwIYTppF3XQKzHkgpzitDpl8Onm0Q6QO36gg5YU7cU25n4t1eZQG1kcxn6roCuBX9yGnIOrXRazb3nV4OCNwiAJ9utxnv7mmDXO3zuwCdLafR5Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tIftdx7D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m9/4G5Fh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1w6Y9+zv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fjk5g+Fb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D2CD51F383;
	Sun,  1 Dec 2024 08:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733043062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aeExrs1aYdDHfUzMH082DL4FWKhLKEf0fhA1eUJbfOo=;
	b=tIftdx7DxR5mJwRJkblKYUtIsGmUSD3MmPb6R/t3+ixr+9QRWgt5HG8QhuzTFNlur/y63V
	bFOAgL/FOUZTS25E2OmDDRxyIGG/AEM3We6xhK9wBLLOBe3EEvlxdEVUnk/Owsvx6SDqyO
	Tz9yN0NMpqrKSY0UamoONtd+yPk2AYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733043062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aeExrs1aYdDHfUzMH082DL4FWKhLKEf0fhA1eUJbfOo=;
	b=m9/4G5Fhep6XwzUrlhwL5ueKThrX3vz1f1iCUY1KZNGqErKu3l5iCUPXCSTeRkbTrz0rQH
	v2N00U9H3cNqVZAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1w6Y9+zv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Fjk5g+Fb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733043061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aeExrs1aYdDHfUzMH082DL4FWKhLKEf0fhA1eUJbfOo=;
	b=1w6Y9+zvVfeuOK/mhSIEwpV7g9EU0QrXuQ0Y9QNx7dTGD9dnwrw9u1h3ppgToGShyxGDfJ
	YkIG6rCJSwY72IHbSB7mb9YM3ltmkZk9RiruEi+G70lityVux5784LUWm2RIPMOwtDjxe0
	EBgQ5E707DLY75yQyPTILglNBCkMxgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733043061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aeExrs1aYdDHfUzMH082DL4FWKhLKEf0fhA1eUJbfOo=;
	b=Fjk5g+Fb0y8eNeohAi9B2FCD6Z3I0z/smUCflaDVzFzXVM+WMds1osM8pwJL6MMvdmDH1e
	mnh4Not/M2HFC9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3E9613974;
	Sun,  1 Dec 2024 08:51:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ONurJnUjTGfTRgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 01 Dec 2024 08:51:01 +0000
Date: Sun, 01 Dec 2024 09:51:01 +0100
Message-ID: <87cyibzszu.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Nazar Bilinskyi <nbilinskyi@gmail.com>
Cc: tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable mute and micmute LED on HP ProBook 430 G8
In-Reply-To: <20241130231631.8929-1-nbilinskyi@gmail.com>
References: <20241130231631.8929-1-nbilinskyi@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: D2CD51F383
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Sun, 01 Dec 2024 00:16:31 +0100,
Nazar Bilinskyi wrote:
> 
> HP ProBook 430 G8 has a mute and micmute LEDs that can be made to work
> using quirk ALC236_FIXUP_HP_GPIO_LED. Enable already existing quirk.
> 
> Signed-off-by: Nazar Bilinskyi <nbilinskyi@gmail.com>

Thanks, applied now.


Takashi

