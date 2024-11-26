Return-Path: <linux-kernel+bounces-422430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C239D9992
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57CC165794
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CBF1D5AB6;
	Tue, 26 Nov 2024 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1Tow8kry";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C3mTA9W+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1Tow8kry";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C3mTA9W+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BDA1D4613;
	Tue, 26 Nov 2024 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732631136; cv=none; b=ET6ZPtxS1FXODKVnkjcviJGaG3b8a0rLEXKLyB6O0058L5cAP7iAl9le2Ll3alFgBRvocgCj8AMNWOziMoFr3e27uvZFH4K1hxl2I4Xyw1V4Uq5I2buakYTrhnHfOGNeN5qHDoTlTVl0xuBaZzcrVGBK8EFHdddtbpFH6kmQ3aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732631136; c=relaxed/simple;
	bh=LCJwEdebs/Wgp6PyBm4ogPVQlFU9GBzhKFRxPyeQTac=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eisXAwrYlIzqKldfNeEFPD051NDuRA5qTzU/ENgBY3k7pJ9MEvbXaYQA+kWHFZeai2os5XKOMS0ST0q+KFUGz95K7uGqJb7JWfuak+y0s48deYrCNkr3MuEa/LiW9So2LAR236QbJQLNhqpB5gi9r+BvNCFVaY0qlt0JfHTT3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1Tow8kry; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C3mTA9W+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1Tow8kry; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C3mTA9W+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 110BA2116E;
	Tue, 26 Nov 2024 14:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732631132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=59tyn3Ay1zIV9EvoMe0QOwMNIHWHtmydlw+Xs7xpc7Y=;
	b=1Tow8krySiJe+rWWlgfq7sSuNQ9uDdpC+Kn7ipurGcVHacANLs4txDPgw5Zoj9SiZtGWD6
	ZyMWrUMQj6d18DkWUde0kwHxdnUIkQnxvSZLsJdOn/QpD3UcYgSCywR4MPhG04HVIoYW4h
	xqV4a+Vu4s/Tf+iJg2dW7Hi6nhxcqs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732631132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=59tyn3Ay1zIV9EvoMe0QOwMNIHWHtmydlw+Xs7xpc7Y=;
	b=C3mTA9W+N9/XrHM7NTRSGHoR4jBVuL4NRrAOAmAL4bUbA84agS+6aLx6ILqxQ760/mM3Vd
	TpHvpoioNKPIfcDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732631132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=59tyn3Ay1zIV9EvoMe0QOwMNIHWHtmydlw+Xs7xpc7Y=;
	b=1Tow8krySiJe+rWWlgfq7sSuNQ9uDdpC+Kn7ipurGcVHacANLs4txDPgw5Zoj9SiZtGWD6
	ZyMWrUMQj6d18DkWUde0kwHxdnUIkQnxvSZLsJdOn/QpD3UcYgSCywR4MPhG04HVIoYW4h
	xqV4a+Vu4s/Tf+iJg2dW7Hi6nhxcqs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732631132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=59tyn3Ay1zIV9EvoMe0QOwMNIHWHtmydlw+Xs7xpc7Y=;
	b=C3mTA9W+N9/XrHM7NTRSGHoR4jBVuL4NRrAOAmAL4bUbA84agS+6aLx6ILqxQ760/mM3Vd
	TpHvpoioNKPIfcDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E65BE139AA;
	Tue, 26 Nov 2024 14:25:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CWG5N1vaRWf+dgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 26 Nov 2024 14:25:31 +0000
Date: Tue, 26 Nov 2024 15:25:31 +0100
Message-ID: <87a5dmax7o.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: asihpi: Remove unused variable
In-Reply-To: <20241126093245.3228-1-zhujun2@cmss.chinamobile.com>
References: <20241126093245.3228-1-zhujun2@cmss.chinamobile.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Tue, 26 Nov 2024 10:32:45 +0100,
Zhu Jun wrote:
> 
> the variable is never referenced in the code, just remove it.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Thanks, applied now.


Takashi

