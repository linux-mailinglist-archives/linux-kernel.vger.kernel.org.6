Return-Path: <linux-kernel+bounces-344217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFB298A68E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF95B1F24842
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F16190068;
	Mon, 30 Sep 2024 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p3ho+n9d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eEO/mOn/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p3ho+n9d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eEO/mOn/"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E03848E;
	Mon, 30 Sep 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704920; cv=none; b=k4msPbp64HUYAvjnW4AzDgsxH1bNbJOGZdQflz1j/5pjgx4dLWPo2Zpr3jkEtKh4KEzWmovVGgGATRuN4TBh7psyuPWyJS2r90wzPObtLLD3o+5DHaqkVqjTIUF7Y2PdKbhoR6NiwbMNvPHifnqryG8FvS3mwZeFlRBG/fHuZbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704920; c=relaxed/simple;
	bh=G6LzdqOokS23LP1VY338tGcBvZCN/ylAvCaZppvKVcg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruPt9uIDyA5y+kM0cD90g0rJSX1qFY8A7n9YEkzt++aAz13PjISw8K+UI/jg/5lZM7gNCb7TzEOTEFGvY2F/IcwMhCynK88emV7k3F3Pev0F+N0dBAEQkqTK4bXKTqR2oCb+T4FNoDLsOnuhn/CAIfLqzATyGUShiRViUo8zR3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p3ho+n9d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eEO/mOn/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p3ho+n9d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eEO/mOn/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ABFDA21A64;
	Mon, 30 Sep 2024 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727704916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JBtmLH9COnq4AhxoZndZCXmFIPw/Tb/FqVdz+ETVuio=;
	b=p3ho+n9d13D5Br2KKpvA3EE7+DtUE9NO+R0DafHbl4xW1Al59cC8ZqBiPsBw5R4sZWS/yn
	Q3Jx+mT6tG3XMQPOEmXjmSxPSe7O0tj6s7c0NIih5b+QprdlxOl35mdU+aVMRlHrk0RmZI
	RaH0+GzznvF3ShIUKvu5W0tx+MiQwYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727704916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JBtmLH9COnq4AhxoZndZCXmFIPw/Tb/FqVdz+ETVuio=;
	b=eEO/mOn/QlUxT7GsQu87oQRKNZ9XwiDI9OjzZ40nZhhaQknq4oiDvPmyAa1LEvCLvAi9V4
	WUmFj9dP1aeqSyAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=p3ho+n9d;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="eEO/mOn/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727704916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JBtmLH9COnq4AhxoZndZCXmFIPw/Tb/FqVdz+ETVuio=;
	b=p3ho+n9d13D5Br2KKpvA3EE7+DtUE9NO+R0DafHbl4xW1Al59cC8ZqBiPsBw5R4sZWS/yn
	Q3Jx+mT6tG3XMQPOEmXjmSxPSe7O0tj6s7c0NIih5b+QprdlxOl35mdU+aVMRlHrk0RmZI
	RaH0+GzznvF3ShIUKvu5W0tx+MiQwYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727704916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JBtmLH9COnq4AhxoZndZCXmFIPw/Tb/FqVdz+ETVuio=;
	b=eEO/mOn/QlUxT7GsQu87oQRKNZ9XwiDI9OjzZ40nZhhaQknq4oiDvPmyAa1LEvCLvAi9V4
	WUmFj9dP1aeqSyAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AC7D13A8B;
	Mon, 30 Sep 2024 14:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AbmXHFSv+mYYCQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 30 Sep 2024 14:01:56 +0000
Date: Mon, 30 Sep 2024 16:02:49 +0200
Message-ID: <87ed51grxy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Jaroslav Kysela <perex@perex.cz>,
	kernel-janitors@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/35] ALSA: Reorganize kerneldoc parameter names
In-Reply-To: <20240930112121.95324-5-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
	<20240930112121.95324-5-Julia.Lawall@inria.fr>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: ABFDA21A64
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[inria.fr:email,suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 30 Sep 2024 13:20:50 +0200,
Julia Lawall wrote:
> 
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> Problems identified using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied now.  Thanks.


Takashi

