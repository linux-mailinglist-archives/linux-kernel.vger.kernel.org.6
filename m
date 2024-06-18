Return-Path: <linux-kernel+bounces-219622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B8390D5A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B507288D38
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD12F16DC1E;
	Tue, 18 Jun 2024 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yW78bFGr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F0s09LQj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yW78bFGr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F0s09LQj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BA416B749;
	Tue, 18 Jun 2024 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720821; cv=none; b=GYs4PTTXs6oPIpNP4cZwP6uRi47gx+Z5sHIxSqF1XR1/kggfGP7/T3YXvanHsXUyp2rghR8pZQw0A84dI3JKu0ZYqlgmkGaX3AVfzKUdP8O/62Afhe7Rz1P8UGZVaPZNYSBdgL5nBZq5Dcr9HO7zhVFmcbU1orzRUv/L9P6m4Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720821; c=relaxed/simple;
	bh=sKWjat2X5yPXn7jlcAdYmOWGsDtEENMMgW5iFrljRmI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKvSnCpXHpCuue0P5bXipwL4lKNwk/6XY53IbymUnTYlEWGkpWuRrpRo8MI/apuIBMKBTYwYPa/8VIZ+8kNK6nSwO6jpFd89NBXwj64/y5wHMkdgZ3QDYjEfRpCJngdVP0Bf0rymGVCcVzk8chOr9+GQxFyH2+BKANQ0TjbjTeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yW78bFGr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F0s09LQj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yW78bFGr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F0s09LQj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4CB8D1F74A;
	Tue, 18 Jun 2024 14:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718720818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0SF97UA2nDWP6UOLgZba7YSw3MTN8iQvTaEbBzqC6MY=;
	b=yW78bFGrUc5Y47Nn5Q05UMCm53oTQcKEEW9FMtZTBxxAEwl4ftmopEMWp6MZIPOu3K0oRp
	SbhcFYPjS59vT9dEyBkv3HgM3Bz0b59cPDOWGEg3JkWqVQJShoEo5TIN9nzklM2WuEH61S
	0+H1mo9jikNG6vFaz3cuZO6qNzYmoaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718720818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0SF97UA2nDWP6UOLgZba7YSw3MTN8iQvTaEbBzqC6MY=;
	b=F0s09LQjVc0KzS9oUxzOiK6b7hic9QDzumrC8thdKEH7qcqfJ8fANLl995b1CGAz8uuasA
	Z/pmRzT1qneod3BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718720818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0SF97UA2nDWP6UOLgZba7YSw3MTN8iQvTaEbBzqC6MY=;
	b=yW78bFGrUc5Y47Nn5Q05UMCm53oTQcKEEW9FMtZTBxxAEwl4ftmopEMWp6MZIPOu3K0oRp
	SbhcFYPjS59vT9dEyBkv3HgM3Bz0b59cPDOWGEg3JkWqVQJShoEo5TIN9nzklM2WuEH61S
	0+H1mo9jikNG6vFaz3cuZO6qNzYmoaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718720818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0SF97UA2nDWP6UOLgZba7YSw3MTN8iQvTaEbBzqC6MY=;
	b=F0s09LQjVc0KzS9oUxzOiK6b7hic9QDzumrC8thdKEH7qcqfJ8fANLl995b1CGAz8uuasA
	Z/pmRzT1qneod3BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33DCA13AA0;
	Tue, 18 Jun 2024 14:26:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vTsIDDKZcWbtdwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 18 Jun 2024 14:26:58 +0000
Date: Tue, 18 Jun 2024 16:27:24 +0200
Message-ID: <87iky65nsj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v2] ALSA: hda: cs35l56: Perform firmware download in the background
In-Reply-To: <20240618130011.62860-1-simont@opensource.cirrus.com>
References: <20240618130011.62860-1-simont@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.26
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.26 / 50.00];
	BAYES_HAM(-2.96)[99.83%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Tue, 18 Jun 2024 15:00:11 +0200,
Simon Trimmer wrote:
> 
> It is possible that during system boot when there multiple devices
> attempting simultaneous initialization on a slow control bus the
> download of firmware and tuning data may take a user perceivable amount
> of time (a slow I2C bus with 4 amps this work could take over 2
> seconds).
> 
> Adopt a pattern used in the ASoC driver and perform this activity in a
> background thread so that interactive performance is not impaired. The
> system_long_wq is a parallel workqueue and driver instances will perform
> their firmware downloads in parallel to make best use of available bus
> bandwidth.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>

Thanks, applied now to for-next branch.


Takashi

