Return-Path: <linux-kernel+bounces-217207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 692AB90ACD9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA8F2874FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581AA194A7A;
	Mon, 17 Jun 2024 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BdBG/FTc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2OPL3QZ8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BdBG/FTc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2OPL3QZ8"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE16194A6C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623436; cv=none; b=ZEI5NbgIi9Axh0vqXXBFuYIlwQCeqaLq9ECDv9zydU0WUZQTRBJyoraan7CuiSbziI/+ySu+FbcLM/1pgGeVB0CTwKsVsIed3YLN5Z9Lybg70ETRgLhJyNltxUNBWwQXXhFoTMakoYNjRu3CdPfUcyAOX0Nkz4Q5wDQTRnfcM+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623436; c=relaxed/simple;
	bh=xh2+GlEoA2a8qMe86GcChozIUp+tHZ39vdNTqdmT0vU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxKfdSBG1PooPaM6KxzSglWvnzSTtipsb4lH4QlycmQxzPPUwjBGmfIbIZ7caF58lVCpnoRHDR8lDqnFy1FNEj7ChdXP4iJ5grHwW7FRl10u6+jG0J8A0rw7N7ByNkWcUOrEK3hWmh7DsvwUym7yUaQYcDHW9eAsL9pl/sI/E2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BdBG/FTc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2OPL3QZ8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BdBG/FTc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2OPL3QZ8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 29CC6380C5;
	Mon, 17 Jun 2024 11:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718623433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGmXsqRrUJrc8PC5HysrdtZ7w5eDkeXpsmG2fR5a5io=;
	b=BdBG/FTcYsuDOt6v5Es3L67slwaQjza0LKrWpzY6oHYhdzbuDnJIvegdVc8AhsdNNufUXg
	t70bqsXYQkLKZxCq5NVoP/mEpPfKopPe1TQqVoexr9tfr5cA6w5anN5iqr0mvdfJk9tyom
	z3Ay8jIJNO1X7wOBbhVcAGHBXq73kKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718623433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGmXsqRrUJrc8PC5HysrdtZ7w5eDkeXpsmG2fR5a5io=;
	b=2OPL3QZ8AtvXMOSd165hI3lVTtOeEaLQYlJC5paOwIQCnVBEYSmejny9JGfToAm3YpjBpP
	ak76aTaog0R1L9DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718623433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGmXsqRrUJrc8PC5HysrdtZ7w5eDkeXpsmG2fR5a5io=;
	b=BdBG/FTcYsuDOt6v5Es3L67slwaQjza0LKrWpzY6oHYhdzbuDnJIvegdVc8AhsdNNufUXg
	t70bqsXYQkLKZxCq5NVoP/mEpPfKopPe1TQqVoexr9tfr5cA6w5anN5iqr0mvdfJk9tyom
	z3Ay8jIJNO1X7wOBbhVcAGHBXq73kKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718623433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGmXsqRrUJrc8PC5HysrdtZ7w5eDkeXpsmG2fR5a5io=;
	b=2OPL3QZ8AtvXMOSd165hI3lVTtOeEaLQYlJC5paOwIQCnVBEYSmejny9JGfToAm3YpjBpP
	ak76aTaog0R1L9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAAA913AAA;
	Mon, 17 Jun 2024 11:23:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pOWILscccGYdGwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 17 Jun 2024 11:23:51 +0000
Date: Mon, 17 Jun 2024 13:23:48 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] drm/display: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20240617132348.5f20bf89@endymion.delvare>
In-Reply-To: <xd2yybtxvzte7gwqwg2vudzvhoekqao2dle6zsuduzjzi3rsay@xhahwof2prph>
References: <20240617103018.515f0bf1@endymion.delvare>
	<xd2yybtxvzte7gwqwg2vudzvhoekqao2dle6zsuduzjzi3rsay@xhahwof2prph>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,linux-foundation.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]

Hi Dmitry,

Thanks for your feedback.

On Mon, 17 Jun 2024 12:57:19 +0300, Dmitry Baryshkov wrote:
> On Mon, Jun 17, 2024 at 10:30:30AM GMT, Jean Delvare wrote:
> > Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> > is possible to test-build any driver which depends on OF on any
> > architecture by explicitly selecting OF. Therefore depending on
> > COMPILE_TEST as an alternative is no longer needed.  
> 
> The goal of this clause is to allow build-testing the driver with OF
> being disabled (meaning that some of OF functions are stubbed and some
> might disappear). I don't see how user-selectable OF provides the same
> result.

Historically, the goal of this clause *was* to allow build-testing the
driver on architectures which did not support OF, and that did make
sense back then. As I understand it, building the driver without OF
support was never a goal per se (if it was, then the driver wouldn't be
set to depend on OF in the first place).

Some of my other submissions include the following explanation which
you might find useful (I ended up stripping it on resubmission after
being told I was being too verbose, but maybe it was needed after all):

It is actually better to always build such drivers with OF enabled,
so that the test builds are closer to how each driver will actually be
built on its intended target. Building them without OF may not test
much as the compiler will optimize out potentially large parts of the
code. In the worst case, this could even pop false positive warnings.
Dropping COMPILE_TEST here improves the quality of our testing and
avoids wasting time on non-existent issues.

-- 
Jean Delvare
SUSE L3 Support

