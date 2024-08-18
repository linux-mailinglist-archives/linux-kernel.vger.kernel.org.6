Return-Path: <linux-kernel+bounces-290985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BFA955BDB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 09:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066312824C2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6B71758B;
	Sun, 18 Aug 2024 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="arEHSKbF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AOMtHxkG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lWCZDQE0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9x8iQL9l"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E760D517;
	Sun, 18 Aug 2024 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723967417; cv=none; b=Cxd3Q80FP6j5U2chzOGNm2/ItUzSFV7VhjTLTJzefsh9H/cdC6gdaMts/L2B3TuFsSzcNTaExU4/a0m4jMYAqMoiETnOJFjblJ8N+qXjXAdUSwRhGXCB81Xa4EG5qbrisI+gg+yze1pgsEjmvH18l0wqRqCDukBMPomv9MFgxlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723967417; c=relaxed/simple;
	bh=WNmBES2YN6RkzmcMnUQq0Azqd/2ZCKbj7rc7inbDf+Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsHmXXRDPngZm+hSfTKTWcrUPLwwf6jlCVHbaBn8+iTUo1O73TxzuxEGJltknhvi6SoQTn4gNhwenmD1/T/W2SZWfYesaYsszkM0d9zvWk3gHcrUNRxQG6BKdqHD2s3Zq6o+6z1RqtQs9RhnHYawU0ipTkz78kJ3rZT/P+U1DNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=arEHSKbF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AOMtHxkG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lWCZDQE0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9x8iQL9l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 731D11FBAE;
	Sun, 18 Aug 2024 07:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723967413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hVqXz7vVv+Rwpy7vb7f2UqOUpshcZsveNtQNNp1IgSo=;
	b=arEHSKbFvBCqhUG5Kftx6iXArDh5RH4KoPAQ0jiAmQ8cHpisrMtZ7D+rd4sjd0yVioYXhm
	dG4HIvCV1mNiL0zxFsn7hCNBUx0F6xxcBsaPli4wGEfNYP0t+xQBoXPpEiOnk/dJJlPDWr
	t3Vu9M4owbGRKY/gYZ4+W+vJ4DncMjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723967413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hVqXz7vVv+Rwpy7vb7f2UqOUpshcZsveNtQNNp1IgSo=;
	b=AOMtHxkG8I65niixDljGLcfHOFOp1iQ+1bgePnL0xOuRp5ixtC0vDpYRp6kUzh3ngieM5h
	kh8pRNrZuvSQPzCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lWCZDQE0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9x8iQL9l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723967412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hVqXz7vVv+Rwpy7vb7f2UqOUpshcZsveNtQNNp1IgSo=;
	b=lWCZDQE0wZFj2539peTCaKSvJsrbUzEpWg0yOKM62pp4o8s4xHxxclvBiWftddPo5g7wDl
	L4ap8HM2rB9rVCb159zEAaJg3UHtfv9GYP/118nARDzRTLTwunqXZaxIX80W7R8YtedUy4
	VGYgrnCK2osKRlDQHvqb71N5ASa4cR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723967412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hVqXz7vVv+Rwpy7vb7f2UqOUpshcZsveNtQNNp1IgSo=;
	b=9x8iQL9lTD8Jpb4AbTInxgO1dlG/zf82AcN/08lnE1V0Hu1jDD4X/kWJSCQa9xFiAPp5+1
	RrQTeGQPl3YVdICQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27C2D136ED;
	Sun, 18 Aug 2024 07:50:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qy7dB7SnwWY6QwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 18 Aug 2024 07:50:12 +0000
Date: Sun, 18 Aug 2024 09:50:53 +0200
Message-ID: <87cym61d7m.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	linux-sound@vger.kernel.org,
	vkoul@kernel.org,
	vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.de,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: Re: [PATCH 1/3] ALSA/ASoC/SoundWire: Intel: use single definition for SDW_INTEL_MAX_LINKS
In-Reply-To: <19ab3bfb-cc7c-4f3d-84bb-ef35d8849064@sirena.org.uk>
References: <20240816023331.6565-1-yung-chuan.liao@linux.intel.com>
	<20240816023331.6565-2-yung-chuan.liao@linux.intel.com>
	<19ab3bfb-cc7c-4f3d-84bb-ef35d8849064@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 731D11FBAE
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,intel.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -5.51

On Fri, 16 Aug 2024 13:25:45 +0200,
Mark Brown wrote:
> 
> On Fri, Aug 16, 2024 at 10:33:29AM +0800, Bard Liao wrote:
> > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > 
> > The definitions are currently duplicated in intel-sdw-acpi.c and
> > sof_sdw.c.  Move the definition to the sdw_intel.h header, and change
> > the prefix to make it Intel-specific.
> > 
> > No functionality change in this patch.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

As Bard requested, the series can go via ASoC tree.

Feel free to take my ack for HDA part.

Reviewed-by: Takashi Iwai <tiwai@suse.de>


Takashi


