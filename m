Return-Path: <linux-kernel+bounces-169953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447A08BCFCB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C99EB24F1D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E3C13CF95;
	Mon,  6 May 2024 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0MhZXtvV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6P2WRc2X";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0MhZXtvV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6P2WRc2X"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D3713CAAD;
	Mon,  6 May 2024 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004802; cv=none; b=tKxOgihaxJvl2eBybtQDJ35KXfnZEBQPcMSa8NTFBjmP7VH+Zi7yBJNQPmYUFsXZBvQ3oz3GggMXx6b3kElIdgI04RMvZyjSyGErKiLwlGRed6E19MJ9deYYMt0UwXwsNt8y8fJecJWL3/QFiTAP4t/7seQB5CGt0dHBznvpox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004802; c=relaxed/simple;
	bh=QRbq6H4DwuT9gwWhZhUd8BbIWyf3EoJfoxV0DVP1gA0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtX7gjtDQXuoh1Pf1+waAHlz/Y7bjtxeJ8shrpJV0FWbjv9wq70J3YMzIFuFS9Se42/LaRFpJ1aA5GB0RrBiORjnq8kOa1DK4TDBi47j6p8NZAJ5Q47fA7K8PCUd7ubzlcdxM8n1+L5Os2DWoZL8injKrPz22nkHKSF6u52jsqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0MhZXtvV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6P2WRc2X; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0MhZXtvV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6P2WRc2X; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 79BB03846B;
	Mon,  6 May 2024 14:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715004799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=irJD7qM4mYj0gC4NEUKkvFnP7jHOV8RW90W/Hb6silI=;
	b=0MhZXtvVAvMpqpdq8QPxgXxe7s3ZxyX6Y4PLqXRKwXjAC5ss9zBPWzCUA7FhbsTbFTfd3X
	X1qYMDopMYE8DnmEP9M28Pd4+Ruur2dVz13QkdxGszk1g0Wq1UF5qbxH1wKgiKdVZIY77D
	kZvRQRrWfxtjbbIa5RnCdeocyDRyYo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715004799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=irJD7qM4mYj0gC4NEUKkvFnP7jHOV8RW90W/Hb6silI=;
	b=6P2WRc2X3AQ3RnfLS8PE9CV81oUyC3RccalrCGVu2569DdtPhTckPC1Shw3ev+Dn/DOqu0
	trV1Sy+PeS1MobAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715004799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=irJD7qM4mYj0gC4NEUKkvFnP7jHOV8RW90W/Hb6silI=;
	b=0MhZXtvVAvMpqpdq8QPxgXxe7s3ZxyX6Y4PLqXRKwXjAC5ss9zBPWzCUA7FhbsTbFTfd3X
	X1qYMDopMYE8DnmEP9M28Pd4+Ruur2dVz13QkdxGszk1g0Wq1UF5qbxH1wKgiKdVZIY77D
	kZvRQRrWfxtjbbIa5RnCdeocyDRyYo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715004799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=irJD7qM4mYj0gC4NEUKkvFnP7jHOV8RW90W/Hb6silI=;
	b=6P2WRc2X3AQ3RnfLS8PE9CV81oUyC3RccalrCGVu2569DdtPhTckPC1Shw3ev+Dn/DOqu0
	trV1Sy+PeS1MobAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C2691386E;
	Mon,  6 May 2024 14:13:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 47GQDX/lOGbFaQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 06 May 2024 14:13:19 +0000
Date: Mon, 06 May 2024 16:13:33 +0200
Message-ID: <878r0ngh9u.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	baojun.xu@ti.com
Subject: Re: [PATCH v1 1/1] ALSA: Correct the kernel object suffix of target
In-Reply-To: <20240506085219.3403731-1-andriy.shevchenko@linux.intel.com>
References: <20240506085219.3403731-1-andriy.shevchenko@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.27 / 50.00];
	BAYES_HAM(-2.97)[99.86%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,intel.com:email]
X-Spam-Score: -3.27
X-Spam-Flag: NO

On Mon, 06 May 2024 10:52:19 +0200,
Andy Shevchenko wrote:
> 
> The correct suffix is 'y' for the kernel code and
> 'objs' for the user space. Update documentation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied now.  I added a suffix to the subject to indicate it's a
documentation fix, too.


thanks,

Takashi

