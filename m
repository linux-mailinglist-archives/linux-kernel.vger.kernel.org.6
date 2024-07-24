Return-Path: <linux-kernel+bounces-261232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7753893B473
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012111F229C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AB515B15D;
	Wed, 24 Jul 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LEYVFVOx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K+mjhmQz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LEYVFVOx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K+mjhmQz"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94C71BF38;
	Wed, 24 Jul 2024 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836954; cv=none; b=LgOmJP7O46XumK4XSoj5fMSsaVSvxg1fsxujoyi45E+huJMOnkHm/pAADZOC6jBk9iQG2xRUGGd6wK381RbAJ8Xgh2fr0UrtbAjmjEiqONV+10M9A4SpIczYKYq7QyGtYZgQSo654yYBbYg0KUINbCsrrSO4FdG2ZgZ9ec25tX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836954; c=relaxed/simple;
	bh=RB8OIrgGwsoMOpuv/2lAhWm/URqyKCpEIlfmrjde8gI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPj5mkKtiyI5jtxatC7TtMKMV+booE1bnM0Y6t75iP4QomjqqHh5YxC7KuwyHSjo2ON93+HcE96DLHOJFyRse+CwlBMPrb/qKe5OHu5N5JTC+jzSYTF5DWxmpAsL67+p4PXOCrsuqyKnpOZlF/WVmi83NNNDYcAEXD4S/3cQgYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LEYVFVOx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K+mjhmQz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LEYVFVOx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K+mjhmQz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 48A9621B2E;
	Wed, 24 Jul 2024 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721836553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMyZ8DTxmzUpFQtU/rwWuAo99ThGySzfP1HGsX4vNHw=;
	b=LEYVFVOxoLrco3EwWc+/K4rR+o2MPweVDuF8dtnzM2WKHfFe0G/SvpUh000bM2X6Wqhh2g
	uBXQu/vbstU9JInP6y/02w4ADJj1/2ntk0WvQWHUk7GtYNqHrSSOJolFq2DtyXED02XXkP
	gcTnU0voeS7zRIY0aRQEOfVHMs0M7fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721836553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMyZ8DTxmzUpFQtU/rwWuAo99ThGySzfP1HGsX4vNHw=;
	b=K+mjhmQzucsnu+sJreL/KQH5Zjmxy8NbI7WGOREheJ28xRyDI2CBS9WkypkubbcoAgp5UG
	iwuG1fzVGboI8sAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721836553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMyZ8DTxmzUpFQtU/rwWuAo99ThGySzfP1HGsX4vNHw=;
	b=LEYVFVOxoLrco3EwWc+/K4rR+o2MPweVDuF8dtnzM2WKHfFe0G/SvpUh000bM2X6Wqhh2g
	uBXQu/vbstU9JInP6y/02w4ADJj1/2ntk0WvQWHUk7GtYNqHrSSOJolFq2DtyXED02XXkP
	gcTnU0voeS7zRIY0aRQEOfVHMs0M7fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721836553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMyZ8DTxmzUpFQtU/rwWuAo99ThGySzfP1HGsX4vNHw=;
	b=K+mjhmQzucsnu+sJreL/KQH5Zjmxy8NbI7WGOREheJ28xRyDI2CBS9WkypkubbcoAgp5UG
	iwuG1fzVGboI8sAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 110C91324F;
	Wed, 24 Jul 2024 15:55:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bmYCAwkkoWaDQwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 24 Jul 2024 15:55:53 +0000
Date: Wed, 24 Jul 2024 17:56:28 +0200
Message-ID: <87o76mkclv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Luke D. Jones" <luke@ljones.dev>
Cc: tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: cs35l41: Fixup remaining asus strix models
In-Reply-To: <20240723011224.115579-1-luke@ljones.dev>
References: <20240723011224.115579-1-luke@ljones.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.10 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.10

On Tue, 23 Jul 2024 03:12:24 +0200,
Luke D. Jones wrote:
> 
> Adjust quirks for 0x3a20, 0x3a30, 0x3a50 to match the 0x3a60. This
> set has now been confirmed to work with this patch.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Thanks, applied now.


Takashi

