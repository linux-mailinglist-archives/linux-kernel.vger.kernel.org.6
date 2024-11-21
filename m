Return-Path: <linux-kernel+bounces-416886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B744E9D4C09
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E07F2B237A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FD31CF5D4;
	Thu, 21 Nov 2024 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a4+gVaXx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NAHHOyfm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a4+gVaXx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NAHHOyfm"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4821C3F30;
	Thu, 21 Nov 2024 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188875; cv=none; b=lxBBscWpbMeb7mZX8v46SLB+kWYi3R/M+Ypyu4SWaQq/+b6/j1v8eHpjqMLzmTUCvvPZqYJrPy+juUTxbgKrByIQz9ljWacX/ASaN+Dm5oGaT/9pkspqiAT5O50CpPb1TbmE9/wsnf8MNfHWcxCewpiM5ZM9IGzXRZguAbyMTjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188875; c=relaxed/simple;
	bh=nhLURGiYFE2NzII4zqh4+OqgV4HQaUsevwe9Il1IHX0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ld9B2x62wHKgHfce3+M0z5zvTDzs0xsezCiGb2NbNqoSwFe2KlNOmWA3fNwP1Ic8z5qkMers8pFxo7vI8saL2fkza/IPlDSyg75gQseiQbd7x0GwUJRVFqSSjppO8tRa0beMfysmucm0qXFa4SU1Wj1f68xIsC+c1GHTbdRsbzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a4+gVaXx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NAHHOyfm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a4+gVaXx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NAHHOyfm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08957215D0;
	Thu, 21 Nov 2024 11:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732188872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCuP5yWLXAZTtrxCrcELZUlKkFv511iMX9agRsJGT1Q=;
	b=a4+gVaXxJIl1L0kgE+dgkf0SY8YowjbBtPOIIdPRMykBv9deeSV4Zp7AtOUcCulec5bOv+
	qdpPAs7RdtttNwP1Xxk4VmqmECT0UhKIZVJM+MuohKB3V1Bu10xGkyIyYN9dZ1KtTFSaql
	SXoILOx2TjTnWazFVfCjtvPSpBEAM1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732188872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCuP5yWLXAZTtrxCrcELZUlKkFv511iMX9agRsJGT1Q=;
	b=NAHHOyfmKmyMiLo4mG0Yad2v2sUsn8aHtXRd2/O7xyHdMg+EJgwYMtBNZdQ6w1qMcTKLRX
	4+QBt7sBfo2MhjCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732188872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCuP5yWLXAZTtrxCrcELZUlKkFv511iMX9agRsJGT1Q=;
	b=a4+gVaXxJIl1L0kgE+dgkf0SY8YowjbBtPOIIdPRMykBv9deeSV4Zp7AtOUcCulec5bOv+
	qdpPAs7RdtttNwP1Xxk4VmqmECT0UhKIZVJM+MuohKB3V1Bu10xGkyIyYN9dZ1KtTFSaql
	SXoILOx2TjTnWazFVfCjtvPSpBEAM1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732188872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCuP5yWLXAZTtrxCrcELZUlKkFv511iMX9agRsJGT1Q=;
	b=NAHHOyfmKmyMiLo4mG0Yad2v2sUsn8aHtXRd2/O7xyHdMg+EJgwYMtBNZdQ6w1qMcTKLRX
	4+QBt7sBfo2MhjCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C506213A7D;
	Thu, 21 Nov 2024 11:34:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 51rfLscaP2d3BAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 21 Nov 2024 11:34:31 +0000
Date: Thu, 21 Nov 2024 12:34:31 +0100
Message-ID: <87frnk3jnc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Hridesh MG <hridesh699@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: docs: fix dead hyperlink to Intel HD-Audio spec
In-Reply-To: <20241120155553.21099-1-hridesh699@gmail.com>
References: <20241120155553.21099-1-hridesh699@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,lwn.net,gmail.com,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 20 Nov 2024 16:55:51 +0100,
Hridesh MG wrote:
> 
> Update the hyperlink as it currently redirects to a generic site
> instead of the actual specification.
> 
> Signed-off-by: Hridesh MG <hridesh699@gmail.com>

Thanks, applied now.


Takashi

