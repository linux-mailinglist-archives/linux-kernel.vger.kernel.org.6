Return-Path: <linux-kernel+bounces-373773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851309A5C89
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0541F22924
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C09A1D0F51;
	Mon, 21 Oct 2024 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LtJOFmuI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="00hJ7km6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LtJOFmuI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="00hJ7km6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B871D0E30;
	Mon, 21 Oct 2024 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495102; cv=none; b=lzmw7xEysSiB3Wu8JctBnMVVCSVpYsn+vGwXgW2wZECqDUYEBGDTQDJbiY84Nz6wuktNJAbk/e43fqvpVhSqyjcmH3npdW4viUne/fUozNE5Di/Si9uySnfjEEZNkUkdDyQ1kR8jeLQcaVnfAwijnAGVHNrHgvkBq7tA/ZKy94I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495102; c=relaxed/simple;
	bh=klh9N9NAJYzZn5KntM/sGf5rLYPye9Y+JOfk2TdWk8s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ee4U2neUp2GTFr5HATzR2QxZiSmEa02cS4h6rEgIp7J6ZY4Kb33xE5UqBgfnqzuckIGvQYLwWzzS3KwTw1K6RrVZk/8PBrnqBPbwZJquABwhSwQdILzVquDYqwvH9FlZaOjPhFHpSm7AAa1VNt1hBr3rFFjRg6E3PLs+m85hWAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LtJOFmuI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=00hJ7km6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LtJOFmuI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=00hJ7km6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5250F21FD0;
	Mon, 21 Oct 2024 07:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729495099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=16QQJ5UoM8E+Z9zE0W665mVfhAOpl7dhvagpSv4Qb8A=;
	b=LtJOFmuII0nr5uD040WqE/g3w1HCrXr19yhazKDokUmP4oprI8K2zaCA4yICIYmxVh/5mD
	lh31qjPDa4swIj9uMNms0W2IjRJqv0n1L6NfYZFflmpcuQ3rtSwbbKmMBaJNzueW0oq2EL
	f7ANzXnOIz6mTOd9Uf77u70Owmujoik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729495099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=16QQJ5UoM8E+Z9zE0W665mVfhAOpl7dhvagpSv4Qb8A=;
	b=00hJ7km6FAvUQuxSYnTm6ss8IDmm3XdAPxlnTvy07cwvJs8efnCboHNINWx8nKzChF20I4
	8jkCQzKhVASm1DAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729495099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=16QQJ5UoM8E+Z9zE0W665mVfhAOpl7dhvagpSv4Qb8A=;
	b=LtJOFmuII0nr5uD040WqE/g3w1HCrXr19yhazKDokUmP4oprI8K2zaCA4yICIYmxVh/5mD
	lh31qjPDa4swIj9uMNms0W2IjRJqv0n1L6NfYZFflmpcuQ3rtSwbbKmMBaJNzueW0oq2EL
	f7ANzXnOIz6mTOd9Uf77u70Owmujoik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729495099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=16QQJ5UoM8E+Z9zE0W665mVfhAOpl7dhvagpSv4Qb8A=;
	b=00hJ7km6FAvUQuxSYnTm6ss8IDmm3XdAPxlnTvy07cwvJs8efnCboHNINWx8nKzChF20I4
	8jkCQzKhVASm1DAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5200136DC;
	Mon, 21 Oct 2024 07:18:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YFusMjoAFmfZTAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 21 Oct 2024 07:18:18 +0000
Date: Mon, 21 Oct 2024 09:19:19 +0200
Message-ID: <8734kpkjns.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Baojun Xu <baojun.xu@ti.com>,
	tiwai@suse.de,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	perex@perex.cz,
	pierre-louis.bossart@linux.intel.com,
	shenghao-ding@ti.com,
	navada@ti.com,
	13916275206@139.com,
	v-hampiholi@ti.com,
	v-po@ti.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com,
	yung-chuan.liao@linux.intel.com,
	broonie@kernel.org,
	antheas.dk@gmail.com
Subject: Re: [PATCH v2] ALSA: hda/tas2781: Add speaker id check for ASUS projects
In-Reply-To: <ZxJVCb13lQ4h2KRD@smile.fi.intel.com>
References: <20241018071118.3298-1-baojun.xu@ti.com>
	<ZxJVCb13lQ4h2KRD@smile.fi.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dt];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[ti.com,suse.de,kernel.org,gmail.com,perex.cz,linux.intel.com,139.com,vger.kernel.org,intel.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 18 Oct 2024 14:31:05 +0200,
Andy Shevchenko wrote:
> 
> On Fri, Oct 18, 2024 at 03:11:18PM +0800, Baojun Xu wrote:
> > +			// Speaker id is not valid, use default.
> > +			dev_dbg(tas_priv->dev, "Wrong spk_id = %d\n", spk_id);
> > +			spk_id = 0;
> > +		}
> > +		scnprintf(tas_priv->coef_binaryname,
> 
> Why 'c' variant? You do not check the return value anyway. So, what's the point?

There is a difference between snprintf() and scnprintf().
With W=1, the compiler (at least the recent gcc version) will warn you
when the string truncation may happen in the former case while not
complaining for the latter.
So, when the truncation is intentional and acceptable (that's
certainly most cases), the use of scnprintf() will result in less
warnings.


Takashi

