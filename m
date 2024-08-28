Return-Path: <linux-kernel+bounces-304419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99832961FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559A3286265
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B86158A31;
	Wed, 28 Aug 2024 06:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fp6u5uRJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6/xvoDqp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fp6u5uRJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6/xvoDqp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2904F156F3F;
	Wed, 28 Aug 2024 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826485; cv=none; b=FnojcJUo8pubm67doNF3iIMPz2j4w3qxXZi/fp2m9Y9TlmD2ivhWqhdBp2ZpUiUHW7P+a8A5fhlRX8E+d7n7fsasP5f/3q097BSUro2A/yZMJgUAwRddqSZEmVdNFzDUaaSlkBDZlBS2ouSjm5+GacE09lrrkUcfM+t7LBpQjGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826485; c=relaxed/simple;
	bh=4y2VemdvEjvSYIQo8SSeUG7DOR27qhQrru1e7JKOCRQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0Alky5WMtGubOyfgSIiBJ39nOcFll4duKPkG2eJmco5S26VNM9qu8ae9POUy4lapWasln3XfKa5M0JUf9H/iUv0WXSqJPA+j84zqSy0353TnfpbkcgtcubMJsVBQDcDHCkZ0URjPZMFGaefW+U7FvgEOCOBnAoMrZQBCoHKMv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fp6u5uRJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6/xvoDqp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fp6u5uRJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6/xvoDqp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E53121B34;
	Wed, 28 Aug 2024 06:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724826482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zNxLFuZa0KWSyeRDXxWJdaPjdPnsQZ39p3n3v2q5g78=;
	b=fp6u5uRJ9iga8hf/R88pqCGdzUPQpvhmD0Nb87vNyTt1xH93sA7HK5ukXddqjQHNALXkY9
	P3NxnfxV7IOe0e8xNwaPmANKGq9+6IEEKLBILy+98s7pZI8xratSRe8FB16qJ98cGg8yH6
	J8Db5TUJ17MKb2KXfKRhjms/sEAdNIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724826482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zNxLFuZa0KWSyeRDXxWJdaPjdPnsQZ39p3n3v2q5g78=;
	b=6/xvoDqpVg7qpAXIkvtC9V8Ra+DOYC4qJ96wzUARlllutKs3myAFG1iaUWHBhbJoem0gF1
	mEiHApR2vd1Dh2DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724826482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zNxLFuZa0KWSyeRDXxWJdaPjdPnsQZ39p3n3v2q5g78=;
	b=fp6u5uRJ9iga8hf/R88pqCGdzUPQpvhmD0Nb87vNyTt1xH93sA7HK5ukXddqjQHNALXkY9
	P3NxnfxV7IOe0e8xNwaPmANKGq9+6IEEKLBILy+98s7pZI8xratSRe8FB16qJ98cGg8yH6
	J8Db5TUJ17MKb2KXfKRhjms/sEAdNIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724826482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zNxLFuZa0KWSyeRDXxWJdaPjdPnsQZ39p3n3v2q5g78=;
	b=6/xvoDqpVg7qpAXIkvtC9V8Ra+DOYC4qJ96wzUARlllutKs3myAFG1iaUWHBhbJoem0gF1
	mEiHApR2vd1Dh2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10EC7138D2;
	Wed, 28 Aug 2024 06:28:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CK7pAnLDzmYkHwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 28 Aug 2024 06:28:02 +0000
Date: Wed, 28 Aug 2024 08:28:46 +0200
Message-ID: <87seupyxcx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christoffer Sandberg <cs@tuxedo.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/conexant: Add pincfg quirk to enable top speakers on Sirius devices
In-Reply-To: <20240827102540.9480-1-wse@tuxedocomputers.com>
References: <20240827102540.9480-1-wse@tuxedocomputers.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Tue, 27 Aug 2024 12:25:40 +0200,
Werner Sembach wrote:
> 
> From: Christoffer Sandberg <cs@tuxedo.de>
> 
> The Sirius notebooks have two sets of speakers 0x17 (sides) and
> 0x1d (top center). The side speakers are active by default but
> the top speakers aren't.
> 
> This patch provides a pincfg quirk to activate the top speakers.
> 
> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org

Thanks, applied now.


Takashi

